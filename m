Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643F723DC80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHFQxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 12:53:17 -0400
Received: from verein.lst.de ([213.95.11.211]:50299 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729490AbgHFQwx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:52:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CAE3868D0E; Thu,  6 Aug 2020 16:17:32 +0200 (CEST)
Date:   Thu, 6 Aug 2020 16:17:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vikas Kumar <vikas.kumar2@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, rafael@kernel.org
Subject: Re: [LTP-FAIL][02/21] fs: refactor ksys_umount
Message-ID: <20200806141732.GA5902@lst.de>
References: <d28d2235-9b1c-0403-59ca-e57ac5d0460e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28d2235-9b1c-0403-59ca-e57ac5d0460e@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix for umount03 below.  The other one works fine here, but from
your logs this might be a follow on if you run it after umount without
the fix.

---
From 718c12b6559c6be5fac39837b496fd1cd325a0d5 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 6 Aug 2020 16:07:10 +0200
Subject: fs: fix a struct path leak in path_umount

Make sure we also put the dentry and vfsmnt in the illegal flags
and !may_mount cases.

Fixes: 41525f56e256 ("fs: refactor ksys_umount")
Reported-by: Vikas Kumar <vikas.kumar2@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namespace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7301790abb211..1180437dfab909 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1708,15 +1708,16 @@ static inline bool may_mandlock(void)
 
 int path_umount(struct path *path, int flags)
 {
-	struct mount *mnt;
+	struct mount *mnt = real_mount(path->mnt);
 	int retval;
 
+	retval = -EINVAL;
 	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
-		return -EINVAL;
+		goto dput_and_out;
+	retval = -EPERM;
 	if (!may_mount())
-		return -EPERM;
+		goto dput_and_out;
 
-	mnt = real_mount(path->mnt);
 	retval = -EINVAL;
 	if (path->dentry != path->mnt->mnt_root)
 		goto dput_and_out;
-- 
2.27.0

