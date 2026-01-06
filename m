Return-Path: <linux-fsdevel+bounces-72504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5825CF8817
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 000F4304549B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179719B5B1;
	Tue,  6 Jan 2026 13:26:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB372D7DEC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706000; cv=none; b=Q6IT79u4i3oj8GAK7Eg7Mk37QU423JlT4cTSwM3gZ1IVKEUmdEoqEYos00+V82jswgGq8UKVi+dL/ZJdC5Wfcnm9+uTQQk8wwkpV6/XR2fAHsglCz67EH2Y5qbuOrb8pZFYObYeuh3FIPayQgsVNv9byX0ohIizGhWJLqADmS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706000; c=relaxed/simple;
	bh=Toht+N2fjHilFhQAe1OQSPRJU4PCA19l3RnEE26zndw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gg7UoyWCRL2NMFd0ebmSbKbCuWHmdqKIMZIMELrSPWzxp68L8bZS2jcc7NEJi66EkBlSvXWdpquA+V1U3rI/tYIyR3h0qagT5OAJXoSA6f4PSNInIFvb5yWSL3b5b0bcN0sKVpmF9ZV0+Cpvz/4+k6B78w8XkKz5d4Frdcoh2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so1184173b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767705998; x=1768310798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jXPQLCDThT45NL0q+gHDucg/ciE0BMofThY4wA7Hjz8=;
        b=Asst6tCsj59HD+OnCyziJSp6X3M3ppnk0FYUx01eZzXxVDdSpGKFB/hAwQdVX0ZTOs
         hIqbvuucUFs9VYLlA2LJuH6VkCusWyQTqwST+LgisTEw7exRf33CBnZUxk4/V5wi5Vmt
         NDYpSVCRMY2FdtkWOnCP4y94HYpVhATU0XmXed2fIMImOov0UAMmVfEPXiv4X6+Wqg9g
         +ndolG3ngigE5PxOrSq250v/UiHPg0q/BmRotrsYOT900V3oGoRVimNPyi3iClTNgfDz
         myrdTO0UWWZdjr/NFxvHyOEQ17Pzp3f2TJF+NfTrozBR7948QMsjdQKOVlSFkE/NuUEu
         fruw==
X-Gm-Message-State: AOJu0YzOANzrIY+y94TodcKFlq7/F0AkhY6TCkGhvp3ngbBgYmuelKHB
	hm0Umhw6YEim8ZK4Qj4amesdEWdqFmOQDwPyViAmYECb9O9EwKyKfSCa
X-Gm-Gg: AY/fxX7l+4VUSy7PD5/V7aobneKN6uCGtF1J6MGtreC1fLujWZFROEXA5GJjpuOFhJl
	iKnAN2Rn0g6YGq1UO/kJyIl17y5z00hlXoHe5i9q07yyj1YYa5zJIVrBDAUxyw9tRTLYQe1I0sH
	hdkB0gxUBDJHMnyiwa8LnOuBfsiruCuuLjDwb79s0zhhNNUvDtHZTeg10ysazwsPtnoMkN0o7cj
	UIbBPC2nsaMWh8hmlHRCeU/66z7zD/wrOosKa7gJ0J5arcG59glY5EboWg4YYxmD6s9HISZRz2+
	vC5tD0IVyby0fs+9h+cspwlqdkotwbrXq44DjYxo+hxfainkbasAIi5H/zq0g4PiasUopOeJC+1
	j3x5OFsGygb9ZBEYh5D7VhPlwpR5727P0yshYc9GnZO982J1zHGlhdXqEkJDVwVMDLsxx4rHrYD
	5NQzO7BhsNP9ImiN9RUNMoysSC1A==
X-Google-Smtp-Source: AGHT+IHlMRuA8ah4BJovNnIXq1xQTUYUAsN+HYhYY7rqjuJ+qPhW3qEk1IM/usyxVTUts9TrBLHUSg==
X-Received: by 2002:a05:6300:513:10b0:35d:8881:e6c9 with SMTP id adf61e73a8af0-389822f6ef3mr1909583637.23.1767705998364;
        Tue, 06 Jan 2026 05:26:38 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5c66sm2409570a12.24.2026.01.06.05.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:26:37 -0800 (PST)
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
Subject: [PATCH v4 13/14] ntfs: add Kconfig and Makefile
Date: Tue,  6 Jan 2026 22:11:09 +0900
Message-Id: <20260106131110.46687-14-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106131110.46687-1-linkinjeon@kernel.org>
References: <20260106131110.46687-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduce Kconfig and Makefile for remade ntfs.
And this patch make ntfs and ntfs3 mutually exclusive so only one can be
built-in(y), while both can still be built as modules(m).

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig       |  1 +
 fs/Makefile      |  1 +
 fs/ntfs/Kconfig  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/Makefile | 13 +++++++++++++
 fs/ntfs3/Kconfig |  1 +
 5 files changed, 61 insertions(+)
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..43cb06de297f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -152,6 +152,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
+source "fs/ntfs/Kconfig"
 source "fs/ntfs3/Kconfig"
 
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c854..6893496697c4 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_NLS)		+= nls/
 obj-y				+= unicode/
 obj-$(CONFIG_SMBFS)		+= smb/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
+obj-$(CONFIG_NTFS_FS)		+= ntfs/
 obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
new file mode 100644
index 000000000000..6b49c99e4834
--- /dev/null
+++ b/fs/ntfs/Kconfig
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFS_FS
+	tristate "NTFS file system support"
+	select NLS
+	help
+	  NTFS is the file system of Microsoft Windows NT, 2000, XP and 2003.
+	  This allows you to mount devices formatted with the ntfs file system.
+
+	  To compile this as a module, choose M here: the module will be called
+	  ntfs.
+
+config NTFS_DEBUG
+	bool "NTFS debugging support"
+	depends on NTFS_FS
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
+config NTFS_FS_POSIX_ACL
+	bool "NTFS POSIX Access Control Lists"
+	depends on NTFS_FS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support additional access rights
+	  for users and groups beyond the standard owner/group/world scheme,
+	  and this option selects support for ACLs specifically for ntfs
+	  filesystems.
+	  NOTE: this is linux only feature. Windows will ignore these ACLs.
+
+	  If you don't know what Access Control Lists are, say N.
diff --git a/fs/ntfs/Makefile b/fs/ntfs/Makefile
new file mode 100644
index 000000000000..d235ce03289e
--- /dev/null
+++ b/fs/ntfs/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfs filesystem support.
+#
+
+obj-$(CONFIG_NTFS_FS) += ntfs.o
+
+ntfs-y := aops.o attrib.o collate.o dir.o file.o index.o inode.o \
+	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
+	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
+	  iomap.o debug.o sysctl.o quota.o
+
+ccflags-$(CONFIG_NTFS_DEBUG) += -DDEBUG
diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index cdfdf51e55d7..876dbc613ae6 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NTFS3_FS
 	tristate "NTFS Read-Write file system support"
+	depends on !NTFS_FS || m
 	select BUFFER_HEAD
 	select NLS
 	select LEGACY_DIRECT_IO
-- 
2.25.1


