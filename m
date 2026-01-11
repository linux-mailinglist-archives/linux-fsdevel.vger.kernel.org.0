Return-Path: <linux-fsdevel+bounces-73169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A38D0F196
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 15:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA13C301501E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3C346AEC;
	Sun, 11 Jan 2026 14:21:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C059346AC2
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768141299; cv=none; b=r6s0Aub6C3Wmnm2qT41f10H/BsxhG/3GLVMVyS9r0DL60u58n7LB+rvr5VEcphNELAAYA4D/hZK3TpMzEzfoA4AoxOStVX3Js3e+wmteAOO3w3p60tjx0AwetYPesSR+caYIHjeRCzhrOlvGZSrl7wWQeDTDzawrCbU7mHzXMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768141299; c=relaxed/simple;
	bh=twx+uRC8BuRfLHBYrr9hlzXztAFlz2+7S2jcIPWOYWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxelpabEtECSNVce9aYBzZaIrADIh/fhKw7nKbjkdMlp84N4JswGy6ZYsnrRhqAEOE8zEZo9UjC0iAauH5ToFb0gMruwXgNNf7XpKfVzTLCDSrr1nFpT4aF7t1cJWF5LUOK8y2DSVVM/9EwV6Yu9SXXsi6ngKW9IPfVhMNKV6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c227206e6dcso3669880a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 06:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768141297; x=1768746097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Svb4Pq+zVfgjKQ73aCuT6vqlQ2sdsaz0ycFJLtTWkNE=;
        b=fm5CXHH36iQlvlXYjd5ngo60IKJskgErVIqadXsqhmPTr7nN1AFJoOMiCCbk1uPJrg
         1Z4aS9+sqbrTbOqMEWBRTW8QjUG3k7NY2OVQyPUk2p9NoEKwG7E9Amg58IrqPNjXLqnL
         82dvqc6NGqfWrcCXN07Y/aL27+tk4o9Vepl1C5+fkzBloCoOr7qkCd5NId+eA7YH5eQd
         5ejOqPVzGEuuYXZfFbP2tVLZ/juYROI058QE7rt1YFuEjLmXOZIkd3oR88+JFyqBJ0Va
         29RBw4K5dyONHnPMdOZEIo9s4hvqMLkI8MGeg8FrpsVSaWFJQq0bNdi+LoTmE0+IxGqJ
         YxHA==
X-Gm-Message-State: AOJu0YxboDPVGRadjUmskPEiAKhKx8fFz5fIhs70auzaSOxGE0Pc03gM
	vQ1jWgm4wcf7HcWt4toTwc50f8VMUHwSGLEr9LW16Ez1zXeaPwO5hGiD
X-Gm-Gg: AY/fxX5Y38Zvf75lEbmNyF9j1L+HCzuY0Q7IynVHUaGiQruAt0Xei3XxOxH7XwXhMoG
	mG7dANah0fRHNFBGQ1qNQ1Z1vhzZ+7KQS9gTRYe1ET7xquPB2aqGsBpn1elRxB8yJjKjD9Y77px
	l3EnUXt2UicG263n4DJd7s1BmeQl3ZlSBxjUx3wz+qsUydN4MGZyiBkZHdxRWMksqGMwIXGAuvp
	ba+syRtywOz0WQ/cVEfBpaUk9JyMMO3KrC7rMTRyiON9N8ATvguEbKnqrB9yv46YCje/lYMfyMs
	m2m9FNSciBSHKAl1o8Bj0qAN4eJGsCFNborigtnDuJSOPvKw5T3oTndWFsC9XDWnS86g+AVaZ6W
	DKSUkP8e2rpBmSRUg/WmisZfA0Snh2R3YAoRs7Qo1b3Ruc8pSkAe9newXo8hVcZRDJl5uBMkY10
	mpeuHvAWxcyS0GyLTOXF6fjcnEtU84z7HTbjTu
X-Google-Smtp-Source: AGHT+IG8L1MvN+BCL/5G1vZWCB3TpL9BDAhw4kfEtjpSMO7Y47xHRt2/GQ3bhEXFKsgs6UsAa9JZUQ==
X-Received: by 2002:a05:6a20:3ca3:b0:366:23a6:c962 with SMTP id adf61e73a8af0-3898f91d1efmr15436484637.29.1768141297472;
        Sun, 11 Jan 2026 06:21:37 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc02ecfccsm14887077a12.13.2026.01.11.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 06:21:36 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
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
Subject: [PATCH v5 13/14] ntfs: add Kconfig and Makefile
Date: Sun, 11 Jan 2026 23:03:43 +0900
Message-Id: <20260111140345.3866-14-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260111140345.3866-1-linkinjeon@kernel.org>
References: <20260111140345.3866-1-linkinjeon@kernel.org>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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


