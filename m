Return-Path: <linux-fsdevel+bounces-67928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77EC4E0E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6347E34422B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B633AD8E;
	Tue, 11 Nov 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="j/DJBH1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240433120D;
	Tue, 11 Nov 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866706; cv=none; b=Tb8srWh9A52mnxsNvexP8y2xuc+Zp0zESEOhaljiQ6avy/jF3yuHuiexSNX6DWeoNw06QxRT274La+9ymXk9tAuXoa/Vlzo4IE0l4hGkYT92qHm9PlNm4nY+rBYIKv8Deuib9rY727uqxv/e5i0bCyEH52C906Z4/intnMtwBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866706; c=relaxed/simple;
	bh=X4aJpb/kBhUJ3mq0S18GxI1BYxXrlx8ZD0KTAn6iZFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HURetroLNYT4ItumuUiE2EW7Sj6X/TY141MgzivsHen636haOQMZ3JAcdVr3d4X/Qy3HEKC8vZKWifMq7E9s766mPDlShcmM5ypedsJNqe1nWGFZ1ngtwQ2hezEUom40OEvzwj9ZGrsksQgAKTS9ME3q+opg+C/MrtXZhECINFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=j/DJBH1f; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762866699; x=1763471499; i=w_armin@gmx.de;
	bh=+DIgu2KMwjrSKPX7H24CNXucYnKkbf+BuCBZwvVExHA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j/DJBH1fuPLZPCZVVusg5YfJpP02pWqHA7bIKsYuwh6tP9fi7aayDUnTOWRRnTGR
	 zzf5k9+bRPIZe9Kj3Mgwnj/+9p2w2oLU2kVrzL1HIP+UPOfsq+mg9049KVs0ExrdC
	 RGi2kJL9nk5DItjoFBBd/dUtrEqLdDARHwy1SnpCxQf60KaU/6LcMvWrR5nmBgqG0
	 1cj7akTbJHC42iTSYQa1qomlz8WKFY5fvgWuqKWSRnA181HpD9cYMlf/Zd1uphgbo
	 kJwV77s7i48pIUFmDRcDXNUUtQjOm7NHj3YdQK0Am0nc9hTVEvEs7VFSE3cDHtR8m
	 Spj1kmwfLFIUa3crRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M9o21-1vFDGJ3IBx-00DuWf; Tue, 11 Nov 2025 14:11:39 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: superm1@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: wmi: Move WMI core code into a separate directory
Date: Tue, 11 Nov 2025 14:11:25 +0100
Message-Id: <20251111131125.3379-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251111131125.3379-1-W_Armin@gmx.de>
References: <20251111131125.3379-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jCWzpKwCZaQFCgHU7eXuPV37SqHjsPC9wk17Sp+1lrRgcABXjVi
 JIaBb9dC4CjS0B+Yf0zdQrZ1dx2m/ZPNoLNjvQmRZE2zh2kBsbApzIfT4XF/aVFyU9eSpqo
 A4gASH/A39JbWpb7d40qDWFsOrP02+c83TNp4wNFWF/Uik5WaV8N83x3vlUYGmprY92jHfy
 EdkkPctdZ3lX/aBzoeVig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:43+4nTlfPY8=;1ai4+qIxKyZkUcgv6PIQAuP/S1A
 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
 0eunLRxUQ52oSXHxCiHZfGoz6+Z+4NWDD1PvLE

Move the WMI core code into a separate directory to prepare for
future additions to the WMI driver. Also update the description
of the Kconfig entry to better fit with the other subsystem
Kconfig entries.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/driver-api/wmi.rst           |  2 +-
 MAINTAINERS                                |  2 +-
 drivers/platform/Kconfig                   |  2 ++
 drivers/platform/Makefile                  |  1 +
 drivers/platform/wmi/Kconfig               | 34 ++++++++++++++++++++++
 drivers/platform/wmi/Makefile              |  8 +++++
 drivers/platform/{x86/wmi.c =3D> wmi/core.c} |  0
 drivers/platform/x86/Kconfig               | 30 -------------------
 drivers/platform/x86/Makefile              |  1 -
 9 files changed, 47 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/wmi/Kconfig
 create mode 100644 drivers/platform/wmi/Makefile
 rename drivers/platform/{x86/wmi.c =3D> wmi/core.c} (100%)

diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/w=
mi.rst
index 4e8dbdb1fc67..db835b43c937 100644
=2D-- a/Documentation/driver-api/wmi.rst
+++ b/Documentation/driver-api/wmi.rst
@@ -16,5 +16,5 @@ which will be bound to compatible WMI devices by the dri=
ver core.
 .. kernel-doc:: include/linux/wmi.h
    :internal:
=20
-.. kernel-doc:: drivers/platform/x86/wmi.c
+.. kernel-doc:: drivers/platform/wmi/core.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..2dc2e6cd58df 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -402,7 +402,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-wmi
 F:	Documentation/driver-api/wmi.rst
 F:	Documentation/wmi/
-F:	drivers/platform/x86/wmi.c
+F:	drivers/platform/wmi/
 F:	include/uapi/linux/wmi.h
=20
 ACRN HYPERVISOR SERVICE MODULE
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 960fd6a82450..6bb645aed3d1 100644
=2D-- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -18,3 +18,5 @@ source "drivers/platform/surface/Kconfig"
 source "drivers/platform/x86/Kconfig"
=20
 source "drivers/platform/arm64/Kconfig"
+
+source "drivers/platform/wmi/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 19ac54648586..533f500dfcff 100644
=2D-- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CHROME_PLATFORMS)	+=3D chrome/
 obj-$(CONFIG_CZNIC_PLATFORMS)	+=3D cznic/
 obj-$(CONFIG_SURFACE_PLATFORMS)	+=3D surface/
 obj-$(CONFIG_ARM64_PLATFORM_DEVICES)	+=3D arm64/
+obj-$(CONFIG_ACPI_WMI)		+=3D wmi/
diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
new file mode 100644
index 000000000000..77fcbb18746b
=2D-- /dev/null
+++ b/drivers/platform/wmi/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# ACPI WMI Core
+#
+
+menuconfig ACPI_WMI
+	tristate "ACPI-WMI support"
+	depends on ACPI && X86
+	help
+	  This option enables support for the ACPI-WMI driver core.
+
+	  The ACPI-WMI interface is a proprietary extension of ACPI allowing
+	  the platform firmware to expose WMI (Windows Management Instrumentatio=
n)
+	  objects used for managing various aspects of the underlying system.
+	  Mapping between ACPI control methods and WMI objects happens through
+	  special mapper devices (PNP0C14) defined inside the ACPI tables.
+
+	  Enabling this option is necessary for building the vendor specific
+	  ACPI-WMI client drivers for Acer, Dell an HP machines (among others).
+
+	  It is safe to enable this option even for machines that do not contain
+	  any ACPI-WMI mapper devices at all.
+
+if ACPI_WMI
+
+config ACPI_WMI_LEGACY_DEVICE_NAMES
+	bool "Use legacy WMI device naming scheme"
+	help
+	  Say Y here to force the WMI driver core to use the old WMI device nami=
ng
+	  scheme when creating WMI devices. Doing so might be necessary for some
+	  userspace applications but will cause the registration of WMI devices =
with
+	  the same GUID to fail in some corner cases.
+
+endif # ACPI_WMI
diff --git a/drivers/platform/wmi/Makefile b/drivers/platform/wmi/Makefile
new file mode 100644
index 000000000000..98393d7391ec
=2D-- /dev/null
+++ b/drivers/platform/wmi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Makefile for linux/drivers/platform/wmi
+# ACPI WMI core
+#
+
+wmi-y			:=3D core.o
+obj-$(CONFIG_ACPI_WMI)	+=3D wmi.o
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/wmi/core.c
similarity index 100%
rename from drivers/platform/x86/wmi.c
rename to drivers/platform/wmi/core.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..8c13430366ae 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -16,36 +16,6 @@ menuconfig X86_PLATFORM_DEVICES
=20
 if X86_PLATFORM_DEVICES
=20
-config ACPI_WMI
-	tristate "WMI"
-	depends on ACPI
-	help
-	  This driver adds support for the ACPI-WMI (Windows Management
-	  Instrumentation) mapper device (PNP0C14) found on some systems.
-
-	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
-	  ACPI firmware to userspace - this is done through various vendor
-	  defined methods and data blocks in a PNP0C14 device, which are then
-	  made available for userspace to call.
-
-	  The implementation of this in Linux currently only exposes this to
-	  other kernel space drivers.
-
-	  This driver is a required dependency to build the firmware specific
-	  drivers needed on many machines, including Acer and HP laptops.
-
-	  It is safe to enable this driver even if your DSDT doesn't define
-	  any ACPI-WMI devices.
-
-config ACPI_WMI_LEGACY_DEVICE_NAMES
-	bool "Use legacy WMI device naming scheme"
-	depends on ACPI_WMI
-	help
-	  Say Y here to force the WMI driver core to use the old WMI device nami=
ng
-	  scheme when creating WMI devices. Doing so might be necessary for some
-	  userspace applications but will cause the registration of WMI devices =
with
-	  the same GUID to fail in some corner cases.
-
 config WMI_BMOF
 	tristate "WMI embedded Binary MOF driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c7db2a88c11a..978cb55672da 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -5,7 +5,6 @@
 #
=20
 # Windows Management Interface
-obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
 obj-$(CONFIG_WMI_BMOF)		+=3D wmi-bmof.o
=20
 # WMI drivers
=2D-=20
2.39.5


