Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7905B633AA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 11:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiKVK5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 05:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiKVK5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:57:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5625CF;
        Tue, 22 Nov 2022 02:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A771AB819F6;
        Tue, 22 Nov 2022 10:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473ADC433C1;
        Tue, 22 Nov 2022 10:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669114656;
        bh=dSudoXz7KlBoU1Klan/84sEPqQWrkeKs1jTdna8n9qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1xEeK3mb7by2grAU0c8mMy5GZw8KlM0ofIELtw+q41xshTfx9/g7gxW4tEjtOFCo
         3Bvt7JMQLr2GQKI4uTXbaZY7QUqXVJWoWg7VRTtD1/58QDYhBMk2WEg7havS9AMpXD
         Q7J6iNc+QKkK9YpC+4Ts/sBlMQhxme1f0LxdNhRNvqErKL1a6wOJLnmGkk6Qt/Qyh7
         MXM/4pAy5fXik9SgsBAvmqFnzgjb7AnN0Mi9mBUUNf/cvk5LIQmmhm/htq989C4TXu
         BUbMaeK2TH6I+4H/LywBDCMxZvroMDRTU9y/wP1RBkjibnhaDyMq0g/rZbkck7lIa1
         mHUa9bA+xw13Q==
Date:   Tue, 22 Nov 2022 11:57:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, fstests <fstests@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Subject: Re: sgid clearing rules?
Message-ID: <20221122105731.parciulns5mg4jwr@wittgenstein>
References: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 02:14:13PM +0100, Miklos Szeredi wrote:
> I'm looking at sgid clearing in case of file modification.  Seems like
> the intent was:
> 
>  - if not a regular file, then don't clear
>  - else if task has CAP_FSETID in init_user_ns, then don't clear

This one is a remnant of the past. The code was simply not updated to
reflect the new penultimate rule you mention below. This is fixed in
-next based on the VFS work we did (It also includes Amirs patches we
reviewed a few weeks ago for file_remove_privs() in ovl.).

>  - else if group exec is set, then clear
>  - else if gid is in task's group list, then don't clear
>  - else if gid and uid are mapped in current namespace and task has
> CAP_FSETID in current namespace, then don't clear
>  - else clear
> 

The setgid stripping series in -next implements these rules.

> However behavior seems to deviate from that if group exec is clear and
> *suid* bit is not set.  The reason is that inode_has_no_xattr() will
> set S_NOSEC and __file_remove_privs() will bail out before even
> starting to interpret the rules.

Great observation. The dentry_needs_remove_privs() now calls the new
setattr_should_drop_sgid() helper which drops the setgid bit according
to the rules above. And yes, we should drop the S_IXGRP check from
is_sxid() for consistency.
The scenario where things get wonky with the S_IXGRP check present must
be when setattr_should_drop_sgid() retains the setgid bit. In that case
is_sxid() will mark the inode as not being security relevant even though
the setgid bit is still set on it. This dates back to mandatory locking
when the setgid bit was used for that. But mandatory locks are out of
the door for a while now and this is no longer true and also wasn't
enforced consistently for countless years even when they were still
there. So we should make this helper consistent with the rest.

I will run the patch below through xfstests with

-g acl,attr,cap,idmapped,io_uring,perms,unlink

which should cover all setgid tests (We've added plenty of new tests to
the "perms" group.). Could you please review whether this make sense to you?

From cbe6cec88c6cfc66e0fb61f602bb2810c3c48578 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 22 Nov 2022 11:40:32 +0100
Subject: [PATCH] fs: use consistent setgid checks in is_sxid()

Now that we made the VFS setgid checking consistent an inode can't be
marked security irrelevant even if the setgid bit is still set. Make
this function consistent with the other helpers.

Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b39c5efca180..d07cadac547e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3527,7 +3527,7 @@ int __init list_bdev_fs_names(char *buf, size_t size);
 
 static inline bool is_sxid(umode_t mode)
 {
-	return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
+	return (mode & S_ISUID) || ((mode & S_ISGID));
 }
 
 static inline int check_sticky(struct user_namespace *mnt_userns,

base-commit: f380367f1811222c3853d942676a451a2353b762
-- 
2.34.1

