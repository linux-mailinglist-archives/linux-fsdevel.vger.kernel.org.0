Return-Path: <linux-fsdevel+bounces-44089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1E0A61FA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1094E420F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE011ACEA5;
	Fri, 14 Mar 2025 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="0s53wtR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96557205E02;
	Fri, 14 Mar 2025 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989536; cv=none; b=podlH2uIXKBUYs+mSnZVgOR30Cp2RhiEKGZtaHoPFQ6HUyER0DOboKtl3A+kOcTG++UAhGpbtAVM3pWu6yqKfYddb7f4p0jVyFlJupw7TL8lxEsMYWAT5pfv6kCQ/pMMyhFq35AVxGRXlHWYMxdQxaqVU7EjSK2HAAuY+xxdwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989536; c=relaxed/simple;
	bh=MnSYV3XLK4sRq0WVX5U43nwT6MjTFeoDVB+uFlzURzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e12Zc11aRbt37v/ixjtM1A/M0REKt78x3EHH4EBv2LoJWEGXldry0BAwXH3bs3IsvWpoAkuQXzHrPpe1g08G8MQiLN6E3cnOablqTSFs6FWwLUJW3uSGYJ2IncQPYICTuE7PvODXA9TSTqFb2orSw4pUfrt8bAdb/xH6X4pduIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=0s53wtR9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZDytf5xBdz9sln;
	Fri, 14 Mar 2025 22:58:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741989530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aio0/lDjvjoCGxaJdiIsv2h9ocMug1fEI9eEXxDbSo8=;
	b=0s53wtR9ZBs/FjcTFAT0EGa+l6mF84JfsLNKyIZ103V9BXdBNRowlTpJOaqnQE8cAypHGn
	TiXhbG6hAZO8dvCNZk30lSHksZpYa8CCyuiJR8CVhxFqG5Wk0SsxoPFJ3pNfr8SUg+W1wz
	5EhI1C4S0S0OcamCs6pcVkaLKSaOpiiQRsQ5MPakAbjXmIBMER3pLeieO9lXssbpPpsMPX
	ymNSigfa9hcOyGMSePME9DThrPUec8a7K1BZNJSt+LFGSKFDk4RS8eITbc3svYUmX3NYFw
	9V5kKzblGA66FTnKrasOb15BkCKLZKjW+0UAWG2GN71VzoRPByWICtDAipaX8g==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 17:57:53 -0400
Subject: [PATCH RFC 7/8] staging: apfs: init TODO and README.rst
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-apfs-v1-7-ddfaa6836b5c@ethancedwards.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu
Cc: ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4769;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=MnSYV3XLK4sRq0WVX5U43nwT6MjTFeoDVB+uFlzURzc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOVpWbEdVSk5CNlBtNkt6TkYzZHF2NjgxSlYxMnJWCkpxejJyWC9KdkRHVElWbDV6
 L0tPVWhZR01TNEdXVEZGbHY4NXlta1BOV2NvN1B6cjBnUXpoNVVKWkFnREY2Y0EKVE9USUhvWi8
 1dGN2bTVURVg1bFlwL0Y1WjMxcFd0MDdGNEc2bDRjWDh0bWNPYkxja3JIUWorR2YxZG9ybFdhYg
 ozazR4WWRGLzhVK2l0TWl5VnF6UUxiQnAycm92VDd2cjFEZ1lBWTlmVFhnPQo9SGxxUwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

There are various cleanup tasks required before this driver can be moved
to fs/ and out of staging/. TODO attemps to start a list of what those
tasks may be.

The README delineates a history and provides credit to the module's
original authors. I am not the original author, I have just ported it
for upstream submission.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/apfs/README.rst | 87 +++++++++++++++++++++++++++++++++++++++++
 drivers/staging/apfs/TODO       |  7 ++++
 2 files changed, 94 insertions(+)

diff --git a/drivers/staging/apfs/README.rst b/drivers/staging/apfs/README.rst
new file mode 100644
index 0000000000000000000000000000000000000000..0aa624e3a6eca4bbce5dac07ccd224ce4a67f690
--- /dev/null
+++ b/drivers/staging/apfs/README.rst
@@ -0,0 +1,87 @@
+===========================
+Apple File System for Linux
+===========================
+
+The Apple File System (APFS) is the copy-on-write filesystem currently used on
+all Apple devices. This module provides a degree of experimental support on
+Linux.
+
+To help test write support, a set of userland tools is also under development.
+The git tree can be retrieved from https://github.com/eafer/apfsprogs.git.
+
+Known limitations
+=================
+
+This module is the result of reverse engineering and testing has been limited.
+If you make use of the write support, there is a real risk of data corruption.
+Please report any issues that you find.
+
+Writes to fusion drives are not currently supported.
+Encryption is also not yet implemented even in read-only mode.
+
+Reporting bugs
+==============
+
+If you encounter any problem, the first thing you should do is run (as root)::
+
+	dmesg | grep -i apfs
+
+to see all the error messages. If that doesn't help you, please report the 
+issue via email at lore.kernel.org.
+
+Mount
+=====
+
+Like all filesystems, apfs is mounted with::
+
+	mount [-o options] device dir
+
+where ``device`` is the path to your device file or filesystem image, and
+``dir`` is the mount point. The following options are accepted:
+
+============   =================================================================
+vol=n	       Volume number to mount. The default is volume 0.
+
+snap=label     Volume snapshot to mount (in read-only mode).
+
+tier2=path     Path to the tier 2 device. For fusion drives only.
+
+uid=n, gid=n   Override on-disk inode ownership data with given uid/gid.
+
+cknodes	       Verify the checksum on all metadata nodes. Right now this has a
+	       severe performance cost, so it's not recommended.
+
+readwrite      Enable the experimental write support. This may corrupt your
+	       container.
+============   =================================================================
+
+So for instance, if you want to mount volume number 2, and you want the metadata
+to be checked, you should run (as root)::
+
+	mount -o cknodes,vol=2 device dir
+
+To unmount it, run::
+
+	umount dir
+
+Credits
+=======
+
+Originally written by Ernesto A. Fernández <ernesto@corellium.com>, with
+several contributions from Gabriel Krisman Bertazi <krisman@collabora.com>,
+Arnaud Ferraris <arnaud.ferraris@collabora.com> and Stan Skowronek
+<skylark@disorder.metrascale.com>. For attribution details see the historical
+git tree at https://github.com/eafer/linux-apfs.git and 
+https://github.com/linux-apfs/linux-apfs-rw.
+
+The module was ported by Ethan Carter Edwards <ethan@ethancedwards.com> to
+mainline and submitted upstream in 2025.
+
+Work was first based on reverse engineering done by others [1]_ [2]_, and later
+on the (very incomplete) official specification [3]_. Some parts of the code
+imitate the ext2 module, and to a lesser degree xfs, udf, gfs2 and hfsplus.
+
+.. [1] Hansen, K.H., Toolan, F., Decoding the APFS file system, Digital
+   Investigation (2017), https://dx.doi.org/10.1016/j.diin.2017.07.003
+.. [2] https://github.com/sgan81/apfs-fuse
+.. [3] https://developer.apple.com/support/apple-file-system/Apple-File-System-Reference.pdf
diff --git a/drivers/staging/apfs/TODO b/drivers/staging/apfs/TODO
new file mode 100644
index 0000000000000000000000000000000000000000..15d566a532688900e7b6234ee7b9600e3c0f4f88
--- /dev/null
+++ b/drivers/staging/apfs/TODO
@@ -0,0 +1,7 @@
+There are a couple things that should probably happen before this
+module is moved to fs/ and out of staging/. Most notably is the
+proper documentation of how APFS/this module works. Another is the
+conversion from bufferheads/pages to folios.
+
+Another good task for newcomers is patches that make it so this 
+module conforms to current kernel coding standards.

-- 
2.48.1


