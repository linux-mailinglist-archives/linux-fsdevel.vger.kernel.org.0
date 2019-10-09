Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931EAD185D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbfJITLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:34679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbfJITLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MGQSj-1iJcHh1zkj-00GsWY; Wed, 09 Oct 2019 21:11:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH v6 29/43] REPLACE gfs2: add compat_ioctl support
Date:   Wed,  9 Oct 2019 21:10:30 +0200
Message-Id: <20191009191044.308087-30-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cS3/sfwAkrlKljto27S6eVG/uuPsCXcx4FSTY4203dGSHJvWpBw
 Y/QigecS3No2SqHeWCOGB/W6xC1Ok3w8tcPq9dlYEdZm3BatlYEYVv/wmbhhaLlDcp8uxHs
 C7lXB1/M5UDHms6xRtOLlXy6Fb0SM4Q7UclbwQgDMDarQqmByhg7nKD8pPDl9rdsGEgG3lD
 B/HkZp8uQR7x7zFN8P+nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqrUhAhzDB4=:R09Cty2tcFGQtALD0fbRvq
 6rGoeKKmIVe4e+wj5XtkY9Np2XBJMJ/te+tI2sr5syyE1YE3/fBWVAd4A/ZbtZ27vtaw++gc1
 BU4WDcVKKsTcSPdMT8ZSkWaU9XCAVov2ps9NCFt1WKEjPDDtTMt1XkSG4Q93KKke4lCBLVU0/
 RLt49ycv4tzqkPgfYEyNwVMhgwPaR6KwDPO+DbjBMEBN1Zw/zuv6YewMuAas9/JG90GmfebRA
 fCelIdGghcHHBH9TL17QTWdMbiPiir9hc7pnbpvxDVkZai7udPUfrakHqP00HwjynnbmRphrF
 y3PZiTm92s/MxqPORXrrY4P6IErrG5UVhgvYrspWw9xqsvoj3Kpj8pJJa3QRqbrbel4C7v/kF
 1obVvQKWJ5T14PLhGlFT0+2OUJOz1dTdDh9oGSLeeMaJK+iunfEajhjuluZbmXg3LABjM4Nm6
 3pF02f/p9HmZs1UVmDoOYH9P9wsxUF4G5YSZgBu5qdZmLAH0bR38lzujAXtDV9OgHV7B60YhB
 k1pJ91U8s8++o2D56cN+RXVe1WmKDEUsmSkl4l650yrf+fDOtgrDpOHQ519OQK5mjUWDIF3Xz
 +Q72rzqE1dkX45PSBLYTtk0MQIj8+cUO4ZCBLKdxEOoZ5b1G6oVvaurOVi+dm5PuAgnD1BSaC
 0I1gn6qWBcWXmV4UTbjroBaxWN57Txmz/I5dNgde9Ux/bFEpn4FCHBxq74fhlrKQ+mh7sR6fC
 HMdLDCHPMXXdv2uQNn52oAOWr0LluqK8Xm1lhQN2w1CmRAVZTfF6s9UfM83UipxhtNKTq1qKz
 XsOTI865bM7o4iWQ7iWPeEN0JJ3B+FXzrOaDo80mpnWseZRhqS7bnA1vjaDLI8ULdBqXW7W65
 fKC9RxEY8zTuLOe9aGWg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Out of the four ioctl commands supported on gfs2, only FITRIM
works in compat mode.

Add a proper handler based on the ext4 implementation.

Fixes: 6ddc5c3ddf25 ("gfs2: getlabel support")
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/gfs2/file.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 997b326247e2..e073050c1f2a 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/compat.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>
 #include <linux/pagemap.h>
@@ -354,6 +355,31 @@ static long gfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return -ENOTTY;
 }
 
+#ifdef CONFIG_COMPAT
+static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch(cmd) {
+	/* These are just misnamed, they actually get/put from/to user an int */
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	/* Keep this list in sync with gfs2_ioctl */
+	case FITRIM:
+	case FS_IOC_GETFSLABEL:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return gfs2_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#else
+#define gfs2_compat_ioctl NULL
+#endif
+
 /**
  * gfs2_size_hint - Give a hint to the size of a write request
  * @filep: The struct file
@@ -1293,6 +1319,7 @@ const struct file_operations gfs2_file_fops = {
 	.write_iter	= gfs2_file_write_iter,
 	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
+	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
@@ -1308,6 +1335,7 @@ const struct file_operations gfs2_file_fops = {
 const struct file_operations gfs2_dir_fops = {
 	.iterate_shared	= gfs2_readdir,
 	.unlocked_ioctl	= gfs2_ioctl,
+	.compat_ioctl	= gfs2_compat_ioctl,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
@@ -1324,6 +1352,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.write_iter	= gfs2_file_write_iter,
 	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= gfs2_ioctl,
+	.compat_ioctl	= gfs2_compat_ioctl,
 	.mmap		= gfs2_mmap,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
@@ -1337,6 +1366,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 const struct file_operations gfs2_dir_fops_nolock = {
 	.iterate_shared	= gfs2_readdir,
 	.unlocked_ioctl	= gfs2_ioctl,
+	.compat_ioctl	= gfs2_compat_ioctl,
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
-- 
2.20.0

