Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1F21A34D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGIPS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgGIPS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA143C08C5CE;
        Thu,  9 Jul 2020 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IDYu3f552iIyRVTqE2LzxtyKo6CqX/7abLDo4mTAARE=; b=KhUOxOtuOym1g/70pmWVqGsfIx
        cHTHYoxxiFZgTW8DQTI+bSYejALxyayXusBAEcCqvt5BflwPw9f8XswQezWWxrWKK7BdmU0+Nd0n3
        lnNicwmU2Jq8rIxHf14NUsN6MNlELhepGljQLLyXK4bSXOx0FFV2batJ+7jmGIe9ndVtBZGGOHDyw
        JA4k9DxqqTbkuMDl+AB/YzMfbzAUc2+wdVXlGGiU9BOlBXYdoJ7p52PkldPudvRE3IfnWHgtm6ut7
        KfMo4iYVmhuHdrEH2YxPeXsAYbRDuR6N2HFhwoqz6Vwl5jvR2XxnbEHJ797Mijm+FS5UOKuAeiUFx
        DwREmKHw==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJc-0005Kf-Bf; Thu, 09 Jul 2020 15:18:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/17] md: simplify md_setup_drive
Date:   Thu,  9 Jul 2020 17:18:03 +0200
Message-Id: <20200709151814.110422-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the loop over the possible arrays into the caller to remove a level
of indentation for the whole function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-autodetect.c | 203 ++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 102 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 6bc9b734eee6ff..a43a8f1580584c 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -27,7 +27,7 @@ static int __initdata raid_noautodetect=1;
 #endif
 static int __initdata raid_autopart;
 
-static struct {
+static struct md_setup_args {
 	int minor;
 	int partitioned;
 	int level;
@@ -126,122 +126,117 @@ static inline int create_dev(char *name, dev_t dev)
 	return ksys_mknod(name, S_IFBLK|0600, new_encode_dev(dev));
 }
 
-static void __init md_setup_drive(void)
+static void __init md_setup_drive(struct md_setup_args *args)
 {
-	int minor, i, ent, partitioned;
+	int minor, i, partitioned;
 	dev_t dev;
 	dev_t devices[MD_SB_DISKS+1];
+	int fd;
+	int err = 0;
+	char *devname;
+	mdu_disk_info_t dinfo;
+	char name[16];
 
-	for (ent = 0; ent < md_setup_ents ; ent++) {
-		int fd;
-		int err = 0;
-		char *devname;
-		mdu_disk_info_t dinfo;
-		char name[16];
+	minor = args->minor;
+	partitioned = args->partitioned;
+	devname = args->device_names;
 
-		minor = md_setup_args[ent].minor;
-		partitioned = md_setup_args[ent].partitioned;
-		devname = md_setup_args[ent].device_names;
+	sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
+	if (partitioned)
+		dev = MKDEV(mdp_major, minor << MdpMinorShift);
+	else
+		dev = MKDEV(MD_MAJOR, minor);
+	create_dev(name, dev);
+	for (i = 0; i < MD_SB_DISKS && devname != NULL; i++) {
+		struct kstat stat;
+		char *p;
+		char comp_name[64];
 
-		sprintf(name, "/dev/md%s%d", partitioned?"_d":"", minor);
-		if (partitioned)
-			dev = MKDEV(mdp_major, minor << MdpMinorShift);
-		else
-			dev = MKDEV(MD_MAJOR, minor);
-		create_dev(name, dev);
-		for (i = 0; i < MD_SB_DISKS && devname != NULL; i++) {
-			struct kstat stat;
-			char *p;
-			char comp_name[64];
+		p = strchr(devname, ',');
+		if (p)
+			*p++ = 0;
 
-			p = strchr(devname, ',');
-			if (p)
-				*p++ = 0;
+		dev = name_to_dev_t(devname);
+		if (strncmp(devname, "/dev/", 5) == 0)
+			devname += 5;
+		snprintf(comp_name, 63, "/dev/%s", devname);
+		if (vfs_stat(comp_name, &stat) == 0 && S_ISBLK(stat.mode))
+			dev = new_decode_dev(stat.rdev);
+		if (!dev) {
+			printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
+			break;
+		}
 
-			dev = name_to_dev_t(devname);
-			if (strncmp(devname, "/dev/", 5) == 0)
-				devname += 5;
-			snprintf(comp_name, 63, "/dev/%s", devname);
-			if (vfs_stat(comp_name, &stat) == 0 &&
-			    S_ISBLK(stat.mode))
-				dev = new_decode_dev(stat.rdev);
-			if (!dev) {
-				printk(KERN_WARNING "md: Unknown device name: %s\n", devname);
-				break;
-			}
+		devices[i] = dev;
+		devname = p;
+	}
+	devices[i] = 0;
 
-			devices[i] = dev;
+	if (!i)
+		return;
 
-			devname = p;
-		}
-		devices[i] = 0;
+	printk(KERN_INFO "md: Loading md%s%d: %s\n",
+		partitioned ? "_d" : "", minor,
+		args->device_names);
 
-		if (!i)
-			continue;
+	fd = ksys_open(name, 0, 0);
+	if (fd < 0) {
+		printk(KERN_ERR "md: open failed - cannot start "
+				"array %s\n", name);
+		return;
+	}
+	if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) == -EBUSY) {
+		printk(KERN_WARNING
+		       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
+		       minor);
+		ksys_close(fd);
+		return;
+	}
 
-		printk(KERN_INFO "md: Loading md%s%d: %s\n",
-			partitioned ? "_d" : "", minor,
-			md_setup_args[ent].device_names);
+	if (args->level != LEVEL_NONE) {
+		/* non-persistent */
+		mdu_array_info_t ainfo;
+		ainfo.level = args->level;
+		ainfo.size = 0;
+		ainfo.nr_disks =0;
+		ainfo.raid_disks =0;
+		while (devices[ainfo.raid_disks])
+			ainfo.raid_disks++;
+		ainfo.md_minor =minor;
+		ainfo.not_persistent = 1;
 
-		fd = ksys_open(name, 0, 0);
-		if (fd < 0) {
-			printk(KERN_ERR "md: open failed - cannot start "
-					"array %s\n", name);
-			continue;
-		}
-		if (ksys_ioctl(fd, SET_ARRAY_INFO, 0) == -EBUSY) {
-			printk(KERN_WARNING
-			       "md: Ignoring md=%d, already autodetected. (Use raid=noautodetect)\n",
-			       minor);
-			ksys_close(fd);
-			continue;
+		ainfo.state = (1 << MD_SB_CLEAN);
+		ainfo.layout = 0;
+		ainfo.chunk_size = args->chunk;
+		err = ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
+		for (i = 0; !err && i <= MD_SB_DISKS; i++) {
+			dev = devices[i];
+			if (!dev)
+				break;
+			dinfo.number = i;
+			dinfo.raid_disk = i;
+			dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
+			dinfo.major = MAJOR(dev);
+			dinfo.minor = MINOR(dev);
+			err = ksys_ioctl(fd, ADD_NEW_DISK,
+					 (long)&dinfo);
 		}
-
-		if (md_setup_args[ent].level != LEVEL_NONE) {
-			/* non-persistent */
-			mdu_array_info_t ainfo;
-			ainfo.level = md_setup_args[ent].level;
-			ainfo.size = 0;
-			ainfo.nr_disks =0;
-			ainfo.raid_disks =0;
-			while (devices[ainfo.raid_disks])
-				ainfo.raid_disks++;
-			ainfo.md_minor =minor;
-			ainfo.not_persistent = 1;
-
-			ainfo.state = (1 << MD_SB_CLEAN);
-			ainfo.layout = 0;
-			ainfo.chunk_size = md_setup_args[ent].chunk;
-			err = ksys_ioctl(fd, SET_ARRAY_INFO, (long)&ainfo);
-			for (i = 0; !err && i <= MD_SB_DISKS; i++) {
-				dev = devices[i];
-				if (!dev)
-					break;
-				dinfo.number = i;
-				dinfo.raid_disk = i;
-				dinfo.state = (1<<MD_DISK_ACTIVE)|(1<<MD_DISK_SYNC);
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
-				err = ksys_ioctl(fd, ADD_NEW_DISK,
-						 (long)&dinfo);
-			}
-		} else {
-			/* persistent */
-			for (i = 0; i <= MD_SB_DISKS; i++) {
-				dev = devices[i];
-				if (!dev)
-					break;
-				dinfo.major = MAJOR(dev);
-				dinfo.minor = MINOR(dev);
-				ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
-			}
+	} else {
+		/* persistent */
+		for (i = 0; i <= MD_SB_DISKS; i++) {
+			dev = devices[i];
+			if (!dev)
+				break;
+			dinfo.major = MAJOR(dev);
+			dinfo.minor = MINOR(dev);
+			ksys_ioctl(fd, ADD_NEW_DISK, (long)&dinfo);
 		}
-		if (!err)
-			err = ksys_ioctl(fd, RUN_ARRAY, 0);
-		if (err)
-			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		ksys_close(fd);
 	}
+	if (!err)
+		err = ksys_ioctl(fd, RUN_ARRAY, 0);
+	if (err)
+		printk(KERN_WARNING "md: starting md%d failed\n", minor);
+	ksys_close(fd);
 }
 
 static int __init raid_setup(char *str)
@@ -289,11 +284,15 @@ static void __init autodetect_raid(void)
 
 void __init md_run_setup(void)
 {
+	int ent;
+
 	create_dev("/dev/md0", MKDEV(MD_MAJOR, 0));
 
 	if (raid_noautodetect)
 		printk(KERN_INFO "md: Skipping autodetection of RAID arrays. (raid=autodetect will force)\n");
 	else
 		autodetect_raid();
-	md_setup_drive();
+
+	for (ent = 0; ent < md_setup_ents; ent++)
+		md_setup_drive(&md_setup_args[ent]);
 }
-- 
2.26.2

