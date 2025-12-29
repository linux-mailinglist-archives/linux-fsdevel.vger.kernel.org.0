Return-Path: <linux-fsdevel+bounces-72161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB832CE670E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85A81303C103
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB38299959;
	Mon, 29 Dec 2025 11:02:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD928DB56
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006145; cv=none; b=S9BtC5NxAi5Z8/tDWGpUwPmEXohCzkJrehs3+3rx39TZV95hrfmW1Vr2cNLPdfXb2isdGgaDB69wTzWguyvDlWNQjjUoT3IiB2RlqsiGpoZk8CaFmxG9irzFAU61XUv7HPiW31/dTQ3ZBtO+XptmwZdI++tlE7OJ2Vf6NW5SjWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006145; c=relaxed/simple;
	bh=slGQ0cw+Zk4KdBgBNZ7xp+HZShzZ7Z2ZuYQDV4UksLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcaGl2b0eu+ANlV1mU6+GfPVmmLrbkf/WV9S/n06mbVwUDI9yduP7bHvZ9PhSJTUB1ZlgtQYCwyjcvx4pQzYO60lemIM2wDXJSeG2lRQAuachrFD4qAeeGu/cGJ7HMA4Ie/rR7CDk1nQHrEBBsQ1dcd5cEUrQcW7YzCVMd41iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7f121c00dedso12160463b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006143; x=1767610943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTH5uEfGI8daUCxSD0ZvagMoFwwyMdJxWViQQm+bVdk=;
        b=PTFJowNeDNpZRCqnCgSQYYKWFmgj5RexnO2tPr2QZdYAaTxEJKtHGIvEU0mIY/8oh2
         m3CsnlcXnoGi3M2+fC/56cf9knyId78OfbU6UNTzYl9gY8lgNbzJAPrGtI6qzSl0S7Z5
         5odXRYSo0PreyVKHcy0oKZMr67D0+8b/ygVPkUB6zkW+BmloeSD4i0/fgiHdI7cKmzE8
         Rpso9YH1leUiFkUy2GsMpWSr1w1OeooC3uGkWn/DVLfdXjti+oV0if608XiZw4K39hYb
         lPvr8pf6uNWx3SzhVo8JdLot1S8zkFywTmOAygJLnwTOTp2N0kOGSZu76pD+AvnQjxhA
         c+9g==
X-Gm-Message-State: AOJu0YyTyp/Ei80TnoroW2CZVpzVxJyePwjTsN0T+d62KCEkGB946WdF
	0qC9yIQog0SL+ZvKDZPV0CVy2D/W3fns7lpM7PYLv15lbQuqdaKBjsah
X-Gm-Gg: AY/fxX4MyfCJAsJ57LfxL1nj3gx/tYeIpK6DmqZWaNHqCrLaQ5AGfppGPSj+ypZjJxi
	ZAfHyPM7/rz2AE8iWi+E1CS05VFOnRiDYXn1aJovzOn7BOW3lK1R8qAQQwU7cbwo79o4iFAszsR
	Zgu7jy7bU9Ob/rHenoAbK5MhRDnNZdMpq4Mk/4G4uFiLrDXVvhrslthdOFCP/79ytciif6Nwvoi
	EwyHFQOdntUs5lxU9Tu0nG0dQdokymqncFY6aOXVyXzANCjlgAo6gto9ARDvow7KVBa2ijR4XyZ
	yTBIM1LC15a0bE394YZOog3UzK53bjIzNG2Rfn2za+ZIhcWC/HAeGtHQZTPkdzcLU4ZxjvlQNOW
	fXBpRAAhd+E34Y22NWxngJrqNnhyB8i7v1lPsUZ+Ya0EgRqanl67f/hxuFaCFX2DLr3yDqxHIzX
	McLvGFPuRudhw7eMK9tH5sDxknZw==
X-Google-Smtp-Source: AGHT+IGCcAB8UGON6KvsDUsOw9g4awQMqJpZIN4pRl2ZzHPp0qATAMCb5A50T+k8AE3KYBqlGWo4pw==
X-Received: by 2002:a05:6a00:3004:b0:7a2:8853:28f6 with SMTP id d2e1a72fcca58-7ff64dcd50amr26756616b3a.22.1767006143028;
        Mon, 29 Dec 2025 03:02:23 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7aa328basm29320722b3a.11.2025.12.29.03.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 03:02:22 -0800 (PST)
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
Subject: [PATCH v3 13/14] ntfs: add Kconfig and Makefile
Date: Mon, 29 Dec 2025 19:59:31 +0900
Message-Id: <20251229105932.11360-14-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
References: <20251229105932.11360-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the Kconfig and Makefile

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/Kconfig       | 18 ++++++++++++++++++
 fs/Makefile      |  1 +
 fs/ntfs/Kconfig  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/Makefile | 18 ++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 fs/ntfs/Kconfig
 create mode 100644 fs/ntfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..c57cb6a53baf 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -152,8 +152,26 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
+source "fs/ntfs/Kconfig"
 source "fs/ntfs3/Kconfig"
 
+choice
+	prompt "Select built-in NTFS filesystem (only one can be built-in)"
+	default DEFAULT_NTFS
+	help
+	  Only one NTFS can be built into the kernel(y) when selecting a
+	  specific default. Both can still be built as modules(m).
+
+	config DEFAULT_NTFS_NONE
+		bool "No built-in restriction (allows both drivers as 'y')"
+
+	config DEFAULT_NTFS
+		bool "NTFS"
+
+	config DEFAULT_NTFS3
+		bool "NTFS3"
+endchoice
+
 endmenu
 endif # BLOCK
 
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
index 000000000000..ef14c68ed36c
--- /dev/null
+++ b/fs/ntfs/Kconfig
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFS_FS
+	tristate "NTFS file system support"
+	depends on !DEFAULT_NTFS3 || m
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
index 000000000000..01faad8cbbc9
--- /dev/null
+++ b/fs/ntfs/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfs filesystem support.
+#
+
+# to check robot warnings
+ccflags-y += -Wint-to-pointer-cast \
+        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
+        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)
+
+obj-$(CONFIG_NTFS_FS) += ntfs.o
+
+ntfs-y := aops.o attrib.o collate.o dir.o file.o index.o inode.o \
+	  mft.o mst.o namei.o runlist.o super.o unistr.o attrlist.o ea.o \
+	  upcase.o bitmap.o lcnalloc.o logfile.o reparse.o compress.o \
+	  iomap.o debug.o sysctl.o quota.o
+
+ccflags-$(CONFIG_NTFS_DEBUG) += -DDEBUG
-- 
2.25.1


