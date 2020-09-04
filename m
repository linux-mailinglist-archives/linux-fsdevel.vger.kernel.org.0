Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EB25DA08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgIDNhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 09:37:05 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49004 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730501AbgIDNgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:36:04 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 7FE9982183;
        Fri,  4 Sep 2020 16:34:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599226479;
        bh=ixGyvfOtF1m0Qt8mSIDj693P0IvczSm5D6Px5h32/OM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pSDdDSvtciqlNktcfputpB9pBNfeSwbPgEz4uCF38DHvOMroxPp7mJvXlQAy7k4wo
         P6eyaPR7zFMK8+C5CB8WO0ZvlJxKmaTeh9zU3r5o3T7cMXNvekjwzsGiLflOlZ49Mn
         su0UWol5UuHiTwfNBOGjuxmTafQIgyzFt4HWqOrQ=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Sep 2020 16:34:39 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v4 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Date:   Fri, 4 Sep 2020 16:32:29 +0300
Message-ID: <20200904133231.1769292-9-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200904133231.1769292-1-almaz.alexandrovich@paragon-software.com>
References: <20200904133231.1769292-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds Kconfig, Makefile and doc

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 Documentation/filesystems/ntfs3.rst | 103 ++++++++++++++++++++++++++++
 fs/ntfs3/Kconfig                    |  23 +++++++
 fs/ntfs3/Makefile                   |  11 +++
 3 files changed, 137 insertions(+)
 create mode 100644 Documentation/filesystems/ntfs3.rst
 create mode 100644 fs/ntfs3/Kconfig
 create mode 100644 fs/ntfs3/Makefile

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
new file mode 100644
index 000000000000..02f59ff97d28
--- /dev/null
+++ b/Documentation/filesystems/ntfs3.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
+NTFS3
+=====
+
+
+Summary and Features
+====================
+
+NTFS3 is fully functional NTFS Read-Write driver. The driver works with
+NTFS versions up to 3.1, normal/compressed/sparse files
+and journal replaying. File system type to use on mount is 'ntfs3'.
+
+- This driver implements NTFS read/write support for normal, sparse and
+  compressed files.
+  NOTE: Operations with compressed files require increased memory consumption;
+- Supports native journal replaying;
+- Supports extended attributes;
+- Supports NFS export of mounted NTFS volumes.
+
+Mount Options
+=============
+
+The list below describes mount options supported by NTFS3 driver in addition to
+generic ones.
+
+===============================================================================
+
+nls=name		These options inform the driver how to interpret path
+			strings and translate them to Unicode and back. In case
+			none of these options are set, or if specified codepage
+			doesn't exist on the system, the default codepage will be
+			used (CONFIG_NLS_DEFAULT).
+			Examples:
+				'nls=utf8'
+
+uid=
+gid=
+umask=			Controls the default permissions for files/directories created
+			after the NTFS volume is mounted.
+
+fmask=
+dmask=			Instead of specifying umask which applies both to
+			files and directories, fmask applies only to files and
+			dmask only to directories.
+
+nohidden		Files with the Windows-specific HIDDEN (FILE_ATTRIBUTE_HIDDEN)
+			attribute will not be shown under Linux.
+
+sys_immutable		Files with the Windows-specific SYSTEM
+			(FILE_ATTRIBUTE_SYSTEM) attribute will be marked as system
+			immutable files.
+
+discard			Enable support of the TRIM command for improved performance
+			on delete operations, which is recommended for use with the
+			solid-state drives (SSD).
+
+force			Forces the driver to mount partitions even if 'dirty' flag
+			(volume dirty) is set. Not recommended for use.
+
+sparse			Create new files as "sparse".
+
+showmeta		Use this parameter to show all meta-files (System Files) on
+			a mounted NTFS partition.
+			By default, all meta-files are hidden.
+
+prealloc		Preallocate space for files excessively when file size is
+			increasing on writes. Decreases fragmentation in case of
+			parallel write operations to different files.
+
+no_acs_rules		"No access rules" mount option sets access rights for
+			files/folders to 777 and owner/group to root. This mount
+			option absorbs all other permissions:
+			- permissions change for files/folders will be reported
+				as successful, but they will remain 777;
+			- owner/group change will be reported as successful, but
+				they will stay as root
+
+acl			Support POSIX ACLs (Access Control Lists). Effective if
+			supported by Kernel. Not to be confused with NTFS ACLs.
+			The option specified as acl enables support for POSIX ACLs.
+
+noatime			All files and directories will not update their last access
+			time attribute if a partition is mounted with this parameter.
+			This option can speed up file system operation.
+
+===============================================================================
+
+ToDo list
+=========
+
+- Full journaling support (currently journal replaying is supported) over JBD.
+
+
+References
+==========
+https://www.paragon-software.com/home/ntfs-linux-professional/
+	- Commercial version of the NTFS driver for Linux.
+
+almaz.alexandrovich@paragon-software.com
+	- Direct e-mail address for feedback and requests on the NTFS3 implementation.
+
diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
new file mode 100644
index 000000000000..92a9c68008c8
--- /dev/null
+++ b/fs/ntfs3/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config NTFS3_FS
+	tristate "NTFS Read-Write file system support"
+	select NLS
+	help
+	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
+
+	  Y or M enables the NTFS3 driver with full features enabled (read,
+	  write, journal replaying, sparse/compressed files support).
+	  File system type to use on mount is "ntfs3". Module name (M option)
+	  is also "ntfs3".
+
+	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
+
+config NTFS3_64BIT_CLUSTER
+	bool "64 bits per NTFS clusters"
+	depends on NTFS3_FS && 64BIT
+	help
+	  Windows implementation of ntfs.sys uses 32 bits per clusters.
+	  If activated 64 bits per clusters you will be able to use 4k cluster
+	  for 16T+ volumes. Windows will not be able to mount such volumes.
+
+	  It is recommended to say N here.
diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
new file mode 100644
index 000000000000..4d4fe198b8b8
--- /dev/null
+++ b/fs/ntfs3/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the ntfs3 filesystem support.
+#
+
+obj-$(CONFIG_NTFS3_FS) += ntfs3.o
+
+ntfs3-objs := bitfunc.o bitmap.o inode.o fsntfs.o frecord.o \
+	    index.o attrlist.o record.o attrib.o run.o xattr.o\
+	    upcase.o super.o file.o dir.o namei.o lznt.o\
+	    fslog.o
-- 
2.25.4

