Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395A77404B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjHHRBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjHHRBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90B8682;
        Tue,  8 Aug 2023 09:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575C462544;
        Tue,  8 Aug 2023 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B3AC433C8;
        Tue,  8 Aug 2023 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691501527;
        bh=xTIkYrBHz5+6SzO4pB3IGPq/HC4uBhzgU7+be7OH9VU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZpEWm+PTm9uFdGmOoy5ygSH3XOPg6Y5ZyF0Ulu0M0HE1hTyuXrVvdG9f3BOamM/W
         3m8sLzVajCx1eYX5lZ3b30+sYKYXM3u0ewDW4+nd1xPBNtK65Jo8h2yyJ+inwyMHGs
         w2WK+YR84CUHGvViczIvWnkEgwBIt6jA9UIpd40G6jrmvqJVOK9KewB009NnSwZCHe
         FuqGamjpS7LjpwZz+GvSUYyUZWQ2PfS5KwB+UQ3reJTzCdmZf4c/JSvS6NM2uliol5
         LUwdEFraQwdTOXt7nGBplT/LAucUY6qUfKgCd/hdf4oAwdV56AZjsHCGIqFzd81wlg
         GdbWrpF/FvN3g==
Date:   Tue, 8 Aug 2023 15:31:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH v9] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
Message-ID: <20230808-erdaushub-sanieren-2bd8d7e0a286@brauner>
References: <20230808-master-v9-1-e0ecde888221@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808-master-v9-1-e0ecde888221@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 08, 2023 at 07:34:20AM -0400, Jeff Layton wrote:
> From: David Howells <dhowells@redhat.com>
> 
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
> 
> This bug leads to messages like the following appearing in dmesg when
> fscache is enabled:
> 
>     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)
> 
> Fix this by adding a new LSM hook to load fc->security for submount
> creation.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
> ---
> ver #2)
> - Added Smack support
> - Made LSM parameter extraction dependent on reference != NULL.
> 
> ver #3)
> - Made LSM parameter extraction dependent on fc->purpose ==
>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> 
> ver #4)
> - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or Smack.
> 
> ver #5)
> - Removed unused variable.
> - Only allocate smack_mnt_opts if we're dealing with a submount.
> 
> ver #6)
> - Rebase onto v6.5.0-rc4
> - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org
> 
> ver #7)
> - Drop lsm_set boolean
> - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e48407298@kernel.org
> 
> ver #8)
> - Remove spurious semicolon in smack_fs_context_init
> - Make fs_context_init take a superblock as reference instead of dentry
> - WARN_ON_ONCE's when fc->purpose != FS_CONTEXT_FOR_SUBMOUNT
> - Call the security hook from fs_context_for_submount instead of alloc_fs_context
> - Link to v8: https://lore.kernel.org/r/20230807-master-v8-1-54e249595f10@kernel.org
> 
> ver #9)
> - rename *_fs_context_init to *_fs_context_submount
> - remove checks for FS_CONTEXT_FOR_SUBMOUNT and NULL reference pointers
> - fix prototype on smack_fs_context_submount

Thanks, this looks good from my perspective. If it looks fine to LSM
folks as well I can put it with the rest of the super work for this
cycle or it can go through the LSM tree.
