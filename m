Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4375A6BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGTGmE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 02:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjGTGlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45B359E;
        Wed, 19 Jul 2023 23:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F2F615B0;
        Thu, 20 Jul 2023 06:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552DCC433C8;
        Thu, 20 Jul 2023 06:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689835265;
        bh=Fwhi0QdXodruF3aPzC1ed/kg6TfNggfPfBJpEtC+W/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3DUGZGhvBF3pagyXCkuIbkh9GWM1q9AYfi36o6jEgra1mWC3ycE0FPJbD082kCx3
         P/oGbwjAUdlYldRThWZ3uS7bSE3pkxaRIbXNmSdNi0UWDHivL6pTg29lFOKLTRthOU
         iC8s17z9eMP1NeOAk5z1f1a2VBpMxhEVLRaRGkv/UsbUZ8UsVG697+gvR+E6iJx+TP
         qJPnqqJd7pgTPkaxsFOSqAE0DL3TBxWu1mFZ/pC+jJLV8imrOEO1jR0DsOS528zxQE
         YfMrkx1zDkyMtYRIFowDoE4JzZiVyL0HyUkV+5s/v757AXZ8VSgRktKzdncdvmsR2+
         ceIDdIs4pcx2Q==
Date:   Wed, 19 Jul 2023 23:41:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     brauner@kernel.org, tytso@mit.edu,
        linux-f2fs-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v3 3/7] libfs: Validate negative dentries in
 case-insensitive directories
Message-ID: <20230720064103.GC2607@sol.localdomain>
References: <20230719221918.8937-1-krisman@suse.de>
 <20230719221918.8937-4-krisman@suse.de>
 <20230720060657.GB2607@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720060657.GB2607@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:06:57PM -0700, Eric Biggers wrote:
> 
> I'm also having trouble understanding exactly when ->d_name is stable here.
> AFAICS, unfortunately the VFS has an edge case where a dentry can be moved
> without its parent's ->i_rwsem being held.  It happens when a subdirectory is
> "found" under multiple names.  The VFS doesn't support directory hard links, so
> if it finds a second link to a directory, it just moves the whole dentry tree to
> the new location.  This can happen if a filesystem image is corrupted and
> contains directory hard links.  Coincidentally, it can also happen in an
> encrypted directory due to the no-key name => normal name transition...

Sorry, I think I got this slightly wrong.  The move does happen with the
parent's ->i_rwsem held, but it's for read, not for write.  First, before
->lookup is called, the ->i_rwsem of the parent directory is taken for read.
->lookup() calls d_splice_alias() which can call __d_unalias() which does the
__d_move().  If the old alias is in a different directory (which cannot happen
in that fscrypt case, but can happen in the general "directory hard links"
case), __d_unalias() takes that directory's ->i_rwsem for read too.

So it looks like the parent's ->i_rwsem does indeed exclude moves of child
dentries, but only if it's taken for *write*.  So I guess you can rely on that;
it's just a bit more subtle than it first appears.  Though, some of your
explanation seems to assume that a read lock is sufficient ("In __lookup_slow,
either the parent inode is locked by the caller (lookup_slow) ..."), so maybe
there is still a problem.

- Eric
