Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0074D23DEDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbgHFRc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:32:58 -0400
Received: from verein.lst.de ([213.95.11.211]:50470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbgHFRcy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B828768D0F; Thu,  6 Aug 2020 16:48:35 +0200 (CEST)
Date:   Thu, 6 Aug 2020 16:48:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Vikas Kumar <vikas.kumar2@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, rafael@kernel.org
Subject: Re: [LTP-FAIL][02/21] fs: refactor ksys_umount
Message-ID: <20200806144834.GA7818@lst.de>
References: <d28d2235-9b1c-0403-59ca-e57ac5d0460e@arm.com> <20200806141732.GA5902@lst.de> <20200806143221.GQ1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806143221.GQ1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 06, 2020 at 03:32:21PM +0100, Al Viro wrote:
> On Thu, Aug 06, 2020 at 04:17:32PM +0200, Christoph Hellwig wrote:
> > Fix for umount03 below.  The other one works fine here, but from
> > your logs this might be a follow on if you run it after umount without
> > the fix.
> 
> Ugh...
> 
> How about 
> static int may_umount(const struct path *path, int flags)

may_umount is already take.  But with can_umount this would work:

---
From e4ccb3da160831a43eeea48c68d2d43fd7cf6724 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 6 Aug 2020 16:07:10 +0200
Subject: fs: fix a struct path leak in path_umount

Make sure we also put the dentry and vfsmnt in the illegal flags
and !may_umount cases.

Fixes: 41525f56e256 ("fs: refactor ksys_umount")
Reported-by: Vikas Kumar <vikas.kumar2@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/namespace.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a7301790abb211..1c74a46367df4e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1706,34 +1706,38 @@ static inline bool may_mandlock(void)
 }
 #endif
 
-int path_umount(struct path *path, int flags)
+static int can_umount(const struct path *path, int flags)
 {
-	struct mount *mnt;
-	int retval;
+	struct mount *mnt = real_mount(path->mnt);
 
 	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
 		return -EINVAL;
 	if (!may_mount())
 		return -EPERM;
-
-	mnt = real_mount(path->mnt);
-	retval = -EINVAL;
 	if (path->dentry != path->mnt->mnt_root)
-		goto dput_and_out;
+		return -EINVAL;
 	if (!check_mnt(mnt))
-		goto dput_and_out;
+		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
-		goto dput_and_out;
-	retval = -EPERM;
+		return -EINVAL;
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
-		goto dput_and_out;
+		return -EPERM;
+	return 0;
+}
+
+int path_umount(struct path *path, int flags)
+{
+	struct mount *mnt = real_mount(path->mnt);
+	int ret;
+
+	ret = can_umount(path, flags);
+	if (!ret)
+		ret = do_umount(mnt, flags);
 
-	retval = do_umount(mnt, flags);
-dput_and_out:
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
 	dput(path->dentry);
 	mntput_no_expire(mnt);
-	return retval;
+	return ret;
 }
 
 static int ksys_umount(char __user *name, int flags)
-- 
2.27.0

