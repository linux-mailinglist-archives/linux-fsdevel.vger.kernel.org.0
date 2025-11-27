Return-Path: <linux-fsdevel+bounces-69975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56EC8CD6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444084E5DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7735313295;
	Thu, 27 Nov 2025 05:01:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE030F954
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219694; cv=none; b=PDnMtekvQnt38R6m2dlpSGUjXDRk0tDshRKBnSVDycGGtyTJcxBw0R8ol8bsNLKXf3H+RosAsMC+30Bp+suWfCOI/edTE79A0BsqpXs/hberFCWcFWtG426tlcDpML++vNzM+NtpA2HVTn8VBor9HUwDeWMWFixjOxOkByfNZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219694; c=relaxed/simple;
	bh=n5b/MQre1QxLtg9Zn1TXSpWNvwaGErlBIH1V1qOd5wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/N2AEmVE4Hba2jp0o8E72eFzMIYV6UEvJq9Am3wNzwcwXXeEER0g6dWW+2o3tMhht+g0PSJNCBXKOSQvrrR5oWyDl7RQh5g9UpUENT0o0sPmn5MjGSoU5g1M9pQBb8O3RufMiqLZbL36O2DrY78SEAKQcyV/LkMveeWwP16x0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297ef378069so4783975ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764219689; x=1764824489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8EtTs8rd1c6lDJ+HYVOpgm4BMVT9cA8PtoqZF5AUvk=;
        b=Ehr4pC2EoQQLt6VkBep2kIBMJL6jh4t/jYPlmAOrLyvzOZb5l/NPlK1IVmfE2FaLYn
         WbmaTYf1+EXxSlXs80NCHTU1njzx6rMJfVknEelKHDmqTOJnZiOCz9GVOt6v17EAh3mx
         1Q3rmD4ILaIXfSOwIGhEYsl6sdrzrvp7/JgwvtYIkrMTvNkHJ0zfrHRdyFdeK883HwVi
         9+wDxpIUi78NPn+lI8TMrKHsdxhrrWG4l8JOkom1jFIgrbHaX730NwZMl/OfPoDjhFgu
         /qtfocb5e+HzEBd6GOLjvmYtR0cw3brGEgBx6MXwYurVCmlWEtGVVg6KxPO8GYy424iF
         odwA==
X-Gm-Message-State: AOJu0Yxe9flEDvEaxx9zzhU5bOisGr9uhzhDXCnkla98ylRhAgyuMYMm
	3OgsqrqeqkQnVjXaWJId9K9qZYsqrDWSEoDgLY7+z5GIWwLbDMobRkYq
X-Gm-Gg: ASbGnctGC9DbehDmR7brqQGZfPmVDhhSe01wJ4y0GTY9rhS+qGVo97XFR9+zG+o5b2M
	h5Uo8PG0ffzINpI44+onYXoLdjFtXICmv2B9VgD1WJkvMTHAnO9WYKD5tnPqrdDHUClcf1yy3Bh
	4MLM9A/g7vAgjfhKARkepIC4N8WstaCtNfc95fm33y4jt7aCP5uKQFCmc5mlMle2kaXDM6O38vl
	On2Z4dOgu7PR5XN1V5FFEFTD/S9Ig+lP9wzdwb//cLFUlPZbUycDqb/Skiw/UQddSI6I638/CXm
	pozwfwW9GRS69gnOY5sdi5SMgT7mCS+ADTMedjngUkijFgzdGeXaCSXwQSRjC9SRlX582+umN9+
	aZExErlIJ6b4oiIrHcWDINYYlfxKERcutYGuvP+xkSOFZRlKPoEj0NHxhxPsl7T7DrsMUMQfFx2
	zm6k3JUbklFu17xGwEwcqWeDcgAg==
X-Google-Smtp-Source: AGHT+IEYAB2a0oO7i5VPi5Akwg5ZUKtDBsMvjSRBiWzLidc/hVipMcno2poMfBe2U+PggXu4ab/YZQ==
X-Received: by 2002:a17:903:11c7:b0:295:5972:4363 with SMTP id d9443c01a7336-29baacae71emr114911405ad.0.1764219689255;
        Wed, 26 Nov 2025 21:01:29 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54454sm2719825ad.84.2025.11.26.21.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 21:01:28 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 11/11] ntfsplus: add Kconfig and Makefile
Date: Thu, 27 Nov 2025 13:59:44 +0900
Message-Id: <20251127045944.26009-12-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127045944.26009-1-linkinjeon@kernel.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Kconfig and Makefile for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig           |  1 +
 fs/Makefile          |  1 +
 fs/ntfsplus/Kconfig  | 45 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/Makefile | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100644 fs/ntfsplus/Kconfig
 create mode 100644 fs/ntfsplus/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..70d596b99c8b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -153,6 +153,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
 source "fs/ntfs3/Kconfig"
+source "fs/ntfsplus/Kconfig"
 
 endmenu
 endif # BLOCK
diff --git a/fs/Makefile b/fs/Makefile
index e3523ab2e587..2e2473451508 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -91,6 +91,7 @@ obj-y				+= unicode/
 obj-$(CONFIG_SMBFS)		+= smb/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
+obj-$(CONFIG_NTFSPLUS_FS)	+= ntfsplus/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
diff --git a/fs/ntfsplus/Kconfig b/fs/ntfsplus/Kconfig
new file mode 100644
index 000000000000..c13cd06720e7
--- /dev/null
+++ b/fs/ntfsplus/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFSPLUS_FS
+	tristate "NTFS+ file system support"
+	select NLS
+	help
+	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
+	  This allows you to mount devices formatted with the ntfs file system.
+
+	  To compile this as a module, choose M here: the module will be called
+	  ntfsplus.
+
+config NTFSPLUS_DEBUG
+	bool "NTFS+ debugging support"
+	depends on NTFSPLUS_FS
+	help
+	  If you are experiencing any problems with the NTFS file system, say
+	  Y here.  This will result in additional consistency checks to be
+	  performed by the driver as well as additional debugging messages to
+	  be written to the system log.  Note that debugging messages are
+	  disabled by default.  To enable them, supply the option debug_msgs=1
+	  at the kernel command line when booting the kernel or as an option
+	  to insmod when loading the ntfs module.  Once the driver is active,
+	  you can enable debugging messages by doing (as root):
+	  echo 1 > /proc/sys/fs/ntfs-debug
+	  Replacing the "1" with "0" would disable debug messages.
+
+	  If you leave debugging messages disabled, this results in little
+	  overhead, but enabling debug messages results in very significant
+	  slowdown of the system.
+
+	  When reporting bugs, please try to have available a full dump of
+	  debugging messages while the misbehaviour was occurring.
+
+config NTFSPLUS_FS_POSIX_ACL
+	bool "NTFS+ POSIX Access Control Lists"
+	depends on NTFSPLUS_FS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support additional access rights
+	  for users and groups beyond the standard owner/group/world scheme,
+	  and this option selects support for ACLs specifically for ntfs
+	  filesystems.
+	  NOTE: this is linux only feature. Windows will ignore these ACLs.
+
+	  If you don't know what Access Control Lists are, say N.
diff --git a/fs/ntfsplus/Makefile b/fs/ntfsplus/Makefile
new file mode 100644
index 000000000000..1e7e830dbeec
--- /dev/null
+++ b/fs/ntfsplus/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfsplus filesystem support.
+#
+
+# to check robot warnings
+ccflags-y += -Wint-to-pointer-cast \
+        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
+        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
+
+obj-$(CONFIG_NTFSPLUS_FS) += ntfsplus.o
+
+ntfsplus-y := aops.o attrib.o collate.o misc.o dir.o file.o index.o inode.o \
+	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
+	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
+	  ntfs_iomap.o
+
+ccflags-$(CONFIG_NTFSPLUS_DEBUG) += -DDEBUG
-- 
2.25.1


