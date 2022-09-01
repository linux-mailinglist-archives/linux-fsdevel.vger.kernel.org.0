Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B645A99C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiIAONz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiIAONy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:13:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AD367451;
        Thu,  1 Sep 2022 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F3BEB826FD;
        Thu,  1 Sep 2022 14:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1974C433D7;
        Thu,  1 Sep 2022 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662041631;
        bh=FjCazFtJD7dIaSrTBS6DK/n2ntd7At/25awsoy6HaF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOlOfvAGeSZCqFVPL6CMhCm5/U1JJCBb2O/lhA5KUiiRbmOvRX/APz4TYIgZFr5hx
         GoIzV6tHZ4w/0xBPbHUZSDZ36gqgNHzDiSIJqAm7kUmVfnaYP7Dvz+PwKlAF1UDPPf
         Mlbg7puC9+8ezg2Qne0cJJAwji3CdoTccuwQ3njQ+/KghEJ26KiGp8awGSigAlltB9
         kw3s2hDhi/AZg+UlutNkL1pOkE6sSeIZyVybsfqofgj21xlu3K76r9WeqPlgTEgqQd
         Rb0qSH3T4ubfxZ4tWaIU1Lo2ukfiMoApS9biyh2qXd9YUQmieLd2rW5ghJpI5tRQXL
         iYpjlrYDKd54w==
Date:   Thu, 1 Sep 2022 16:13:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <20220901141344.wqnnemixrlb2b74g@wittgenstein>
References: <217595.1662033775@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <217595.1662033775@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:02:55PM +0100, David Howells wrote:
>     
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> Fix this by adding a new LSM hook to load fc->security for submount
> creation when alloc_fs_context() is creating the fs_context for it.
> 
> However, this uncovers a further bug: nfs_get_root() initialises the
> superblock security manually by calling security_sb_set_mnt_opts() or
> security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> complaining.
> 
> Fix that by adding a flag to the fs_context that suppresses the
> security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
> when it sets the LSM context on the new superblock.
> 
> The first bug leads to messages like the following appearing in dmesg:
> 
>         NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> 
> Changes
> =======
> ver #5)
>  - Removed unused variable.
>  - Only allocate smack_mnt_opts if we're dealing with a submount.
> 
> ver #4)
>  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
>    Smack.
> 
> ver #3)
>  - Made LSM parameter extraction dependent on fc->purpose ==
>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> 
> ver #2)
>  - Added Smack support
>  - Made LSM parameter extraction dependent on reference != NULL.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Paul Moore <paul@paul-moore.com>
> cc: linux-nfs@vger.kernel.org
> cc: selinux@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> ---

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
