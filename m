Return-Path: <linux-fsdevel+bounces-43391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10217A55C81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 02:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DED18989D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 01:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B717A597;
	Fri,  7 Mar 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Klrjf5ll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2015575C;
	Fri,  7 Mar 2025 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309121; cv=none; b=Y2DZYeJHC8iUywY2SBVRhUrclcb72+OshlGn9KE+RRbt+lc25YYdCc7ce8tXGqj+y6OSRVsMzm+QtHBqrwaI0P/SwKJOZz5Zc99016VgQ7ii8vz/RkGsc8EjeG6O7H1Aiwjxy1sXQWL7JAvSAQxOgkfu2oEk/ra3UCYE5LmLGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309121; c=relaxed/simple;
	bh=sSKw8GZ/kVfCKmy78Nbmbwe4LJmPA9c+Q0hFr078t3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cofIRfWYrx9YWs0Wvo334caoAtSYm2PFk0ztGm4Ugiolka7WZ/MNmc6IrLNgrtY8lSqVEFZmz2fufePgIfjjngwslxm8emu2lhGOLejMA5TgwkTpTS6xYBqX6V6ZT5I5xLpqsrI1W8GMHRrsI6S4a9UbFnjwZtoykw847QV2lZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Klrjf5ll; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1741309121; x=1772845121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c17Kf0Er2P2sLGN5x8xcm8SJt/PbgebI9se/WEG3Bh0=;
  b=Klrjf5llwW92xMo4+kBglbMlHheb9eEe/FW7xyP55kK/uXkXgxwLrYNk
   qkEQfHuvytP7f/phCETXGtmHvd8wokr0nqrsGYCajSK1Itxt/ow+EB6PU
   kTb7GZ/EUeBMLBBSou6vepAZL5hunPHx6Km5U3jnqLCf4OIlKEFmXRqJl
   U=;
X-IronPort-AV: E=Sophos;i="6.14,227,1736812800"; 
   d="scan'208";a="72017059"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:58:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:64899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.39:2525] with esmtp (Farcaster)
 id cb54e298-4a3c-4851-97b6-2bac0b19c9ca; Fri, 7 Mar 2025 00:58:34 +0000 (UTC)
X-Farcaster-Flow-ID: cb54e298-4a3c-4851-97b6-2bac0b19c9ca
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Mar 2025 00:58:34 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 00:58:33 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTP id 463AE40235;
	Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 05EB84FDD; Fri,  7 Mar 2025 00:58:33 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Pratyush Yadav <ptyadav@amazon.de>, Jonathan Corbet <corbet@lwn.net>,
	"Eric Biederman" <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Hugh Dickins <hughd@google.com>, Alexander Graf
	<graf@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David
 Woodhouse" <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, "Mike
 Rapoport" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, "Wei
 Yang" <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
Subject: [RFC PATCH 2/5] misc: add documentation for FDBox
Date: Fri, 7 Mar 2025 00:57:36 +0000
Message-ID: <20250307005830.65293-3-ptyadav@amazon.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307005830.65293-1-ptyadav@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

With FDBox in place, add documentation that describes what it is and how
it is used, along with its UAPI and in-kernel API.

Since the document refers to KHO, add a reference tag in kho/index.rst.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 Documentation/filesystems/locking.rst |  21 +++
 Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
 Documentation/kho/index.rst           |   3 +
 MAINTAINERS                           |   1 +
 4 files changed, 249 insertions(+)
 create mode 100644 Documentation/kho/fdbox.rst

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d20a32b77b60f..5526833faf79a 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -607,6 +607,27 @@ used. To block changes to file contents via a memory mapping during the
 operation, the filesystem must take mapping->invalidate_lock to coordinate
 with ->page_mkwrite.
 
+fdbox_file_ops
+==============
+
+prototypes::
+
+	int (*kho_write)(struct fdbox_fd *box_fd, void *fdt);
+	int (*seal)(struct fdbox *box);
+	int (*unseal)(struct fdbox *box);
+
+
+locking rules:
+	all may block
+
+==============	==================================================
+ops		i_rwsem(box_fd->file->f_inode)
+==============	==================================================
+kho_write:	exclusive
+seal:		no
+unseal:		no
+==============	==================================================
+
 dquot_operations
 ================
 
diff --git a/Documentation/kho/fdbox.rst b/Documentation/kho/fdbox.rst
new file mode 100644
index 0000000000000..44a3f5cdf1efb
--- /dev/null
+++ b/Documentation/kho/fdbox.rst
@@ -0,0 +1,224 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+===========================
+File Descriptor Box (FDBox)
+===========================
+
+:Author: Pratyush Yadav
+
+Introduction
+============
+
+The File Descriptor Box (FDBox) is a mechanism for userspace to name file
+descriptors and give them over to the kernel to hold. They can later be
+retrieved by passing in the same name.
+
+The primary purpose of FDBox is to be used with :ref:`kho`. There are many kinds
+anonymous file descriptors in the kernel like memfd, guest_memfd, iommufd, etc.
+that would be useful to be preserved using KHO. To be able to do that, there
+needs to be a mechanism to label FDs that allows userspace to set the label
+before doing KHO and to use the label to map them back after KHO. FDBox achieves
+that purpose by exposing a miscdevice which exposes ioctls to label and transfer
+FDs between the kernel and userspace. FDBox is not intended to work with any
+generic file descriptor. Support for each kind of FDs must be explicitly
+enabled.
+
+FDBox can be enabled by setting the ``CONFIG_FDBOX`` option to ``y``. While the
+primary purpose of FDBox is to be used with KHO, it does not explicitly require
+``CONFIG_KEXEC_HANDOVER``, since it can be used without KHO, simply as a way to
+preserve or transfer FDs when userspace exits.
+
+Concepts
+========
+
+Box
+---
+
+The box is a container for FDs. Boxes are identified by their name, which must
+be unique. Userspace can put FDs in the box using the ``FDBOX_PUT_FD``
+operation, and take them out of the box using the ``FDBOX_GET_FD`` operation.
+Once all the required FDs are put into the box, it can be sealed to make it
+ready for shipping. This can be done by the ``FDBOX_SEAL`` operation. The seal
+operation notifies each FD in the box. If any of the FDs have a dependency on
+another, this gives them an opportunity to ensure all dependencies are met, or
+fail the seal if not. Once a box is sealed, no FDs can be added or removed from
+the box until it is unsealed. Only sealed boxes are transported to a new kernel
+via KHO. The box can be unsealed by the ``FDBOX_UNSEAL`` operation. This is the
+opposite of seal. It also notifies each FD in the box to ensure all dependencies
+are met. This can be useful in case some FDs fail to be restored after KHO.
+
+Box FD
+------
+
+The Box FD is a FD that is currently in a box. It is identified by its name,
+which must be unique in the box it belongs to. The Box FD is created when a FD
+is put into a box by using the ``FDBOX_PUT_FD`` operation. This operation
+removes the FD from the calling task. The FD can be restored by passing the
+unique name to the ``FDBOX_GET_FD`` operation.
+
+FDBox control device
+--------------------
+
+This is the ``/dev/fdbox/fdbox`` device. A box can be created using the
+``FDBOX_CREATE_BOX`` operation on the device. A box can be removed using the
+``FDBOX_DELETE_BOX`` operation.
+
+UAPI
+====
+
+FDBOX_NAME_LEN
+--------------
+
+.. code-block:: c
+
+    #define FDBOX_NAME_LEN			256
+
+Maximum length of the name of a Box or Box FD.
+
+Ioctls on /dev/fdbox/fdbox
+--------------------------
+
+FDBOX_CREATE_BOX
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_CREATE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 0)
+    struct fdbox_create_box {
+    	__u64 flags;
+    	__u8 name[FDBOX_NAME_LEN];
+    };
+
+Create a box.
+
+After this returns, the box is available at ``/dev/fdbox/<name>``.
+
+``name``
+    The name of the box to be created. Must be unique.
+
+``flags``
+    Flags to the operation. Currently, no flags are defined.
+
+Returns:
+    0 on success, -1 on error, with errno set.
+
+FDBOX_DELETE_BOX
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_DELETE_BOX	_IO(FDBOX_TYPE, FDBOX_BASE + 1)
+    struct fdbox_delete_box {
+    	__u64 flags;
+    	__u8 name[FDBOX_NAME_LEN];
+    };
+
+Delete a box.
+
+After this returns, the box is no longer available at ``/dev/fdbox/<name>``.
+
+``name``
+    The name of the box to be deleted.
+
+``flags``
+    Flags to the operation. Currently, no flags are defined.
+
+Returns:
+    0 on success, -1 on error, with errno set.
+
+Ioctls on /dev/fdbox/<boxname>
+------------------------------
+
+These must be performed on the ``/dev/fdbox/<boxname>`` device.
+
+FDBX_PUT_FD
+~~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_PUT_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 2)
+    struct fdbox_put_fd {
+    	__u64 flags;
+    	__u32 fd;
+    	__u32 pad;
+    	__u8 name[FDBOX_NAME_LEN];
+    };
+
+
+Put FD into the box.
+
+After this returns, ``fd`` is removed from the task and can no longer be used by
+it.
+
+``name``
+    The name of the FD.
+
+``fd``
+    The file descriptor number to be
+
+``flags``
+    Flags to the operation. Currently, no flags are defined.
+
+Returns:
+    0 on success, -1 on error, with errno set.
+
+FDBX_GET_FD
+~~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_GET_FD	_IO(FDBOX_TYPE, FDBOX_BASE + 3)
+    struct fdbox_get_fd {
+    	__u64 flags;
+    	__u8 name[FDBOX_NAME_LEN];
+    };
+
+Get an FD from the box.
+
+After this returns, the FD identified by ``name`` is mapped into the task and is
+available for use.
+
+``name``
+    The name of the FD to get.
+
+``flags``
+    Flags to the operation. Currently, no flags are defined.
+
+Returns:
+    FD number on success, -1 on error with errno set.
+
+FDBOX_SEAL
+~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_SEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 4)
+
+Seal the box.
+
+Gives the kernel an opportunity to ensure all dependencies are met in the box.
+After this returns, the box is sealed and FDs can no longer be added or removed
+from it. A box must be sealed for it to be transported across KHO.
+
+Returns:
+    0 on success, -1 on error with errno set.
+
+FDBOX_UNSEAL
+~~~~~~~~~~~~
+
+.. code-block:: c
+
+    #define FDBOX_UNSEAL	_IO(FDBOX_TYPE, FDBOX_BASE + 5)
+
+Unseal the box.
+
+Gives the kernel an opportunity to ensure all dependencies are met in the box,
+and in case of KHO, no FDs have been lost in transit.
+
+Returns:
+    0 on success, -1 on error with errno set.
+
+Kernel functions and structures
+===============================
+
+.. kernel-doc:: include/linux/fdbox.h
diff --git a/Documentation/kho/index.rst b/Documentation/kho/index.rst
index 5e7eeeca8520f..051513b956075 100644
--- a/Documentation/kho/index.rst
+++ b/Documentation/kho/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+.. _kho:
+
 ========================
 Kexec Handover Subsystem
 ========================
@@ -9,6 +11,7 @@ Kexec Handover Subsystem
 
    concepts
    usage
+   fdbox
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d329d3e5514c5..135427582e60f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8866,6 +8866,7 @@ FDBOX
 M:	Pratyush Yadav <pratyush@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+F:	Documentation/kho/fdbox.rst
 F:	drivers/misc/fdbox.c
 F:	include/linux/fdbox.h
 F:	include/uapi/linux/fdbox.h
-- 
2.47.1


