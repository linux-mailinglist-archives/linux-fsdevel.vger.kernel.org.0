Return-Path: <linux-fsdevel+bounces-66990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E2C32F62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36448460DC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1C2FCC10;
	Tue,  4 Nov 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="O4YLFnPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0452ED165;
	Tue,  4 Nov 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289172; cv=none; b=US+0qwnKBa+nW6kLXJS8i+NrnxknCLam9mC4H4utSqrDV0ykUVZw0s6igH/MDsy95I68KeDWThN4SPlisuCJQGI2H0zmg9Y6ctlU74I/aJQ2Py3z4dkHKNYZVurDNu7MYGYR34HyUg2B6aXzxjr42tZrScT/apTilGHQJbsmCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289172; c=relaxed/simple;
	bh=x4A52WzdsmxngpNH8+MvtYuknxjuaZpJ62kjIbeYyhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOwP+vKdv2yzC5GJWwn9RZZaUy3VP5DcU4zKHj+CtlxKfGPvOnwm0yraQ0Fn0k7eMoNZsVomWQSKURneXYjjbGZGYhzNbGWyS6hULZeugO2BhP5uXkxpMVf7/epAX1HdQ/FImFHOboy4Xe4VYLAQBBdpz0Ver6v6d895uG3JMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=O4YLFnPF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762289160; x=1762893960; i=w_armin@gmx.de;
	bh=lzNQRY1Kb1yI7hH4FYsUrDSOUJVAglm57BSX732SI7U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=O4YLFnPFIjiHNleHj48cIJ50PBn80L/nI6B1aXOPqOrfjTI+Di0eDqL7Two5W+MR
	 8/X37OexGZbWeAGWu+Kbkd3r/dMwWnUGywcDsZvwAAejZ8dwuY1YWdTaya2WIlgdr
	 7Y0cOVkyY0gytfBlb5DE37N7iaq5Nq2K+umzQgVVgShoz5mgOMgy3sUqWN0cEocEz
	 WBa0Jhi881hYO2Dbsjjk4YHXmk34asF4q1wPJ/CnO/sHwHweV+DZKx5Q8u0b3pFvx
	 VaMGzIdbuI9wYw3wTbL3TPrG2OmoSxJr0fIbu5pDb13K3TSCbJG+hxoKJfL+jMqJ/
	 f/8yeBe6VD0zYCKMGw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N6sn1-1wJ3rk3SAx-00xWti; Tue, 04 Nov 2025 21:46:00 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: wmi: Move WMI core code into a separate directory
Date: Tue,  4 Nov 2025 21:45:40 +0100
Message-Id: <20251104204540.13931-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104204540.13931-1-W_Armin@gmx.de>
References: <20251104204540.13931-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yfGdNrQmTknkoY6OCz3hi5tLFH0Bc518RojyonoJYRLh81dtkg6
 oeFMCuXnhiQJGy6Em7myyqS8mIzXLxud5ZdqI55rDzi67+vA/jrG4XFtJX71FZm7w1siknM
 I67xlR/7RtnuXk2JI60P7LHtKKA3w5d9UJKuans6RGY2MzKgoayX5bpwVCk47akXaDAdGqb
 vnTtWGNaV29lZ742kQgxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:599g5XI5hvw=;BIFkHj3pZjRK2/6LyAtLlpiWAbF
 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
 +mAd93QWv1HK7Iyqs=

Move the WMI core code into a separate directory to prepare for
future additions to the WMI driver.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/driver-api/wmi.rst           |  2 +-
 MAINTAINERS                                |  2 +-
 drivers/platform/x86/Kconfig               | 30 +------------------
 drivers/platform/x86/Makefile              |  2 +-
 drivers/platform/x86/wmi/Kconfig           | 34 ++++++++++++++++++++++
 drivers/platform/x86/wmi/Makefile          |  8 +++++
 drivers/platform/x86/{wmi.c =3D> wmi/core.c} |  0
 7 files changed, 46 insertions(+), 32 deletions(-)
 create mode 100644 drivers/platform/x86/wmi/Kconfig
 create mode 100644 drivers/platform/x86/wmi/Makefile
 rename drivers/platform/x86/{wmi.c =3D> wmi/core.c} (100%)

diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/w=
mi.rst
index 4e8dbdb1fc67..66f0dda153b0 100644
=2D-- a/Documentation/driver-api/wmi.rst
+++ b/Documentation/driver-api/wmi.rst
@@ -16,5 +16,5 @@ which will be bound to compatible WMI devices by the dri=
ver core.
 .. kernel-doc:: include/linux/wmi.h
    :internal:
=20
-.. kernel-doc:: drivers/platform/x86/wmi.c
+.. kernel-doc:: drivers/platform/x86/wmi/core.c
    :export:
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..abc0ff6769a8 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -402,7 +402,7 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-wmi
 F:	Documentation/driver-api/wmi.rst
 F:	Documentation/wmi/
-F:	drivers/platform/x86/wmi.c
+F:	drivers/platform/x86/wmi/
 F:	include/uapi/linux/wmi.h
=20
 ACRN HYPERVISOR SERVICE MODULE
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..ef59425580f3 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -16,35 +16,7 @@ menuconfig X86_PLATFORM_DEVICES
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
+source "drivers/platform/x86/wmi/Kconfig"
=20
 config WMI_BMOF
 	tristate "WMI embedded Binary MOF driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c7db2a88c11a..c9f6e9275af8 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -5,7 +5,7 @@
 #
=20
 # Windows Management Interface
-obj-$(CONFIG_ACPI_WMI)		+=3D wmi.o
+obj-y				+=3D wmi/
 obj-$(CONFIG_WMI_BMOF)		+=3D wmi-bmof.o
=20
 # WMI drivers
diff --git a/drivers/platform/x86/wmi/Kconfig b/drivers/platform/x86/wmi/K=
config
new file mode 100644
index 000000000000..9e7c84876ef5
=2D-- /dev/null
+++ b/drivers/platform/x86/wmi/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ACPI WMI Core
+#
+
+config ACPI_WMI
+	tristate "WMI"
+	depends on ACPI
+	help
+	  This driver adds support for the ACPI-WMI (Windows Management
+	  Instrumentation) mapper device (PNP0C14) found on some systems.
+
+	  ACPI-WMI is a proprietary extension to ACPI to expose parts of the
+	  ACPI firmware to userspace - this is done through various vendor
+	  defined methods and data blocks in a PNP0C14 device, which are then
+	  made available for userspace to call.
+
+	  The implementation of this in Linux currently only exposes this to
+	  other kernel space drivers.
+
+	  This driver is a required dependency to build the firmware specific
+	  drivers needed on many machines, including Acer and HP laptops.
+
+	  It is safe to enable this driver even if your DSDT doesn't define
+	  any ACPI-WMI devices.
+
+config ACPI_WMI_LEGACY_DEVICE_NAMES
+	bool "Use legacy WMI device naming scheme"
+	depends on ACPI_WMI
+	help
+	  Say Y here to force the WMI driver core to use the old WMI device nami=
ng
+	  scheme when creating WMI devices. Doing so might be necessary for some
+	  userspace applications but will cause the registration of WMI devices =
with
+	  the same GUID to fail in some corner cases.
diff --git a/drivers/platform/x86/wmi/Makefile b/drivers/platform/x86/wmi/=
Makefile
new file mode 100644
index 000000000000..71b702936b59
=2D-- /dev/null
+++ b/drivers/platform/x86/wmi/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/wmi
+# ACPI WMI core
+#
+
+wmi-y			:=3D core.o
+obj-$(CONFIG_ACPI_WMI)	+=3D wmi.o
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi/core.c
similarity index 100%
rename from drivers/platform/x86/wmi.c
rename to drivers/platform/x86/wmi/core.c
=2D-=20
2.39.5


