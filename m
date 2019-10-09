Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9324D1866
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbfJITNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:13:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbfJITLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEFfB-1iQDzd118v-00AIwU; Wed, 09 Oct 2019 21:11:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 29/43] gfs2: add compat_ioctl support
Date:   Wed,  9 Oct 2019 21:10:29 +0200
Message-Id: <20191009191044.308087-29-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7jCKQawljNZjnSFT863FA1hhtX5dPDFfB12E/nVCyioFJdqknCe
 L9BKW4WrOA4wAs00JkEHPmNcOlR7bZveM71zN1NKta7NfCnoql3BSZwF2SjLldXUaRHfm1t
 hoCHWSBdm2IJ9GKtnEzjVXLsfNPnbG65DbPFZs2jU2gRROyHV3bRuuAgW7zhsWb7dWA3XfU
 nHvThfhdWVHzdMyvYMGkQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DY83x9iTJwY=:05tW64lXHkUiTYHRncVdeq
 pmRnkjw14EHD0tH84Us6D83DQ4jSo6Lfk2Jwxa6EvnwZOFI1WQQie+D2/pBtfqUQ6VT3QD9Cw
 LR5ZoDJ/YWe1FlgG3FYnSVRUNdQfedKIOaOCH+IRs6OWYs7IXtxI6PSeGUYd44HrLzwu2+gCU
 45EZD4w4BCyQAbTEQUJZzXriYMkvgS6QS8WCaDqWOW4spEdlWZOrI+JfUPQHgYKX5/vZ7fjnX
 bwz3nzpDL+V7eT6244tXsV7RTi8XBhyrXuob0uyRewJkHzg5AVuD1lgeYSVO1cVFUcNqzw0/B
 iZo85vBvnLGm8Q/wcW1xCpb6dD7H6qDdLDYushs8mRplHIwWZ6FBamwlnTTmJaTYSPDUEPDAw
 lPRPDkEx7xMbeS0L9kzoJQg24CMZTmusBfAVnuPNEM3ikIRu1m4ww+9jbejXWkAno9n3tuQHP
 vPlX0dZPnaKw3V/ieJgumWYOQIudsJAttyrb/at4shBlIWLZK+END877WVJl0fGgL+f/edAwN
 gkNmGu7zof55myTrIdoj8K9Ss2nrVHpeqDoXMaz3hScOHY0kqrY0WTzQqJGBkF0Sh6oRE86FO
 dgraGartHXSEZJ2M1minvRUWzpVe1rLBxPLXJ4LIIbKQt2I299OGuCDR0N7YWPv7/VnA3LaJX
 Etg61+5jgF5kDYiPfx7TAhf0zD+zr0NdyxzR5TKyU+W7EinRarED0JLp5QEORXj0Y+A6tLfDC
 o3hKNhiiUjF4IPos+II151K8Ayc3lO1CWcLdGiBET9BpzKtNqTrC3xcl+xfDs8YZu5mH71Iq9
 e6MxK/qhuf6uDGgVWMEZ+QpDMr+vHpMAzTzmDNe9mwzsclkK2EJVzA7UqSsOZsH3rFBtzYGQ3
 YsqyHQ+Rpu9+2IxHSw+w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Out of the four ioctl commands supported on gfs2, only FITRIM
works in compat mode.

Add a proper handler based on the ext4 implementation.

Fixes: 6ddc5c3ddf25 ("gfs2: getlabel support")
Reviewed-by: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
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

