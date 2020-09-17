Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131A226D6B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgIQIdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQIdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:33:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9929C06174A;
        Thu, 17 Sep 2020 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=pK3ZGE1heHTlt9wO/wdfyB7vDi2paiMLw72nt8Y8iog=; b=NSDTpPppN9I32oNKteZhXs8xN/
        RMr0juqsnTEogCXyOYbtjYLoZ8WgoOWu15rdPjANN5ROBEZ7YA5cHMP3keiiK7wNbqvItjucYP1oH
        Yui5begMOphZn+RiAHsjTNPrtOQ2kKMlNq2N5nZptVhIafYfDnUuNduCruAqRMIdPn6dl5vhOO1jG
        Uj+qSc6kZnT8BnaAyLoap7rbxoSV+87qxdeurp1OW49FGACK0i17+xm25bTtTUAOTGS7HQqRTpobe
        /xrEEh21QSKcx1FEWPyEJWmOxEzdmL1KJ5nnieW/HigihvakI1Zd+LZcoVebDAiS3fjw2t+SlqGzi
        tEUUD7hA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIpMD-0001fn-7r; Thu, 17 Sep 2020 08:33:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] alpha: simplify osf_mount
Date:   Thu, 17 Sep 2020 10:22:35 +0200
Message-Id: <20200917082236.2518236-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917082236.2518236-1-hch@lst.de>
References: <20200917082236.2518236-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge the mount_args structures and mount helpers to simplify the code a
bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/kernel/osf_sys.c | 111 +++++++++---------------------------
 1 file changed, 28 insertions(+), 83 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d5367a1c6300c1..5fd155b13503b5 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -421,109 +421,54 @@ SYSCALL_DEFINE3(osf_fstatfs64, unsigned long, fd,
  *
  * Although to be frank, neither are the native Linux/i386 ones..
  */
-struct ufs_args {
+struct osf_mount_args {
 	char __user *devname;
 	int flags;
 	uid_t exroot;
+	/* this has lots more here for cdfs at least, but we don't bother */
 };
 
-struct cdfs_args {
-	char __user *devname;
-	int flags;
-	uid_t exroot;
-
-	/* This has lots more here, which Linux handles with the option block
-	   but I'm too lazy to do the translation into ASCII.  */
-};
-
-struct procfs_args {
-	char __user *devname;
-	int flags;
-	uid_t exroot;
-};
-
-/*
- * We can't actually handle ufs yet, so we translate UFS mounts to
- * ext2fs mounts. I wouldn't mind a UFS filesystem, but the UFS
- * layout is so braindead it's a major headache doing it.
- *
- * Just how long ago was it written? OTOH our UFS driver may be still
- * unhappy with OSF UFS. [CHECKME]
- */
-static int
-osf_ufs_mount(const char __user *dirname,
-	      struct ufs_args __user *args, int flags)
+SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
+		int, flag, void __user *, data)
 {
-	int retval;
-	struct cdfs_args tmp;
+	struct osf_mount_args tmp;
 	struct filename *devname;
-
-	retval = -EFAULT;
-	if (copy_from_user(&tmp, args, sizeof(tmp)))
-		goto out;
-	devname = getname(tmp.devname);
-	retval = PTR_ERR(devname);
-	if (IS_ERR(devname))
-		goto out;
-	retval = do_mount(devname->name, dirname, "ext2", flags, NULL);
-	putname(devname);
- out:
-	return retval;
-}
-
-static int
-osf_cdfs_mount(const char __user *dirname,
-	       struct cdfs_args __user *args, int flags)
-{
+	const char *fstype;
 	int retval;
-	struct cdfs_args tmp;
-	struct filename *devname;
-
-	retval = -EFAULT;
-	if (copy_from_user(&tmp, args, sizeof(tmp)))
-		goto out;
-	devname = getname(tmp.devname);
-	retval = PTR_ERR(devname);
-	if (IS_ERR(devname))
-		goto out;
-	retval = do_mount(devname->name, dirname, "iso9660", flags, NULL);
-	putname(devname);
- out:
-	return retval;
-}
-
-static int
-osf_procfs_mount(const char __user *dirname,
-		 struct procfs_args __user *args, int flags)
-{
-	struct procfs_args tmp;
 
 	if (copy_from_user(&tmp, args, sizeof(tmp)))
 		return -EFAULT;
 
-	return do_mount("", dirname, "proc", flags, NULL);
-}
-
-SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
-		int, flag, void __user *, data)
-{
-	int retval;
-
 	switch (typenr) {
-	case 1:
-		retval = osf_ufs_mount(path, data, flag);
+	case 1: /* ufs */
+		/*
+		 * We can't actually handle ufs yet, so we translate UFS mounts
+		 * to ext2 mounts. I wouldn't mind a UFS filesystem, but the UFS
+		 * layout is so braindead it's a major headache doing it.
+		 *
+		 * Just how long ago was it written? OTOH our UFS driver may be
+		 * still unhappy with OSF UFS. [CHECKME]
+		 */
+		fstype = "ext2";
+		devname = getname(tmp.devname);
 		break;
-	case 6:
-		retval = osf_cdfs_mount(path, data, flag);
+	case 6: /* cdfs */
+		fstype = "iso9660";
+		devname = getname(tmp.devname);
 		break;
-	case 9:
-		retval = osf_procfs_mount(path, data, flag);
+	case 9: /* procfs */
+		fstype = "proc";
+		devname = getname_kernel("");
 		break;
 	default:
-		retval = -EINVAL;
 		printk("osf_mount(%ld, %x)\n", typenr, flag);
+		return -EINVAL;
 	}
 
+	if (IS_ERR(devname))
+		return PTR_ERR(devname);
+	retval = do_mount(devname.name, dirname, fstype, flags, NULL);
+	putname(devname);
 	return retval;
 }
 
-- 
2.28.0

