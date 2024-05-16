Return-Path: <linux-fsdevel+bounces-19607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9288C7CDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4945228351F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B21581F2;
	Thu, 16 May 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gTgUpP9/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DD157E6E;
	Thu, 16 May 2024 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886311; cv=none; b=QZG5c6dhWjPNctWXqSBN7gdsvxie+sqWkmZkyd753CfilIppVja05/bWG7dZsome+mXsey3dDXOUKWqdcgEEmJQRybIddoCyFiewB81FREd6sXNY1fJ8+dgEdrsUiVxgVuY62FmH4n+5SPGz8MOjX7EOcEr29m2+z3pE1hYqGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886311; c=relaxed/simple;
	bh=tzGNyzSA2XSVOcfb4MHGV3ymf1WGaeCoGpXHWR8I0Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeVA/FrRJ2HynQgjjhob5vYwzb72H906Tt+ioe6YfioIUUN/p7O3J78MCTM/RIXDml48+Pmgo+kD+mw9DN3JVC5tmkKFo1Oe/NMnetJGXcvC/mlOmZbTi3bblIkijtDbxM+QYm2IT9xYXGswcoQSVTtmhvisjaQCg+hC9VaT+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=gTgUpP9/; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2747; q=dns/txt; s=iport;
  t=1715886309; x=1717095909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJnJbYQMInpEqhEWqVj7qdnmi6VUKPrWQdQ0UzbxgDI=;
  b=gTgUpP9/Ofz0EjBhQ8VLOyq0gSPCk1PBfnKiZpzNR2eA0c+/BqSXg2wi
   A2S/glX/Jl5/drZkQhTMHI1Tz6QWhFQ/0lzaa2ia7pnZ5JLVZTEfhiZmL
   N/jaSDp1Ar7uF5EnngcELT+7x+GJvZr6OagM3/5whpA7W0Mllf/3PnqCn
   0=;
X-CSE-ConnectionGUID: 7AklUx1fQ5CuiRsQQJSmJA==
X-CSE-MsgGUID: R0i+RELvT6iiXRa0XzjoHQ==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12416983"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:03:58 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ3vLn030156
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:03:58 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 01/22] kernel: configs: add qemu-busybox-min.config
Date: Thu, 16 May 2024 22:03:24 +0300
Message-Id: <20240516190345.957477-2-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-1.cisco.com

This is a minimal configuration for running a busybox initramfs image
with networking support. Added for convenience.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 arch/x86/configs/qemu-busybox-min.config | 11 +++++
 kernel/configs/qemu-busybox-min.config   | 56 ++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 arch/x86/configs/qemu-busybox-min.config
 create mode 100644 kernel/configs/qemu-busybox-min.config

diff --git a/arch/x86/configs/qemu-busybox-min.config b/arch/x86/configs/qemu-busybox-min.config
new file mode 100644
index 000000000000..9a2bf2549053
--- /dev/null
+++ b/arch/x86/configs/qemu-busybox-min.config
@@ -0,0 +1,11 @@
+CONFIG_64BIT=y
+CONFIG_ACPI=y
+
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PVH=y
+
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0 nokaslr rdinit=/sbin/init"
diff --git a/kernel/configs/qemu-busybox-min.config b/kernel/configs/qemu-busybox-min.config
new file mode 100644
index 000000000000..51435e178199
--- /dev/null
+++ b/kernel/configs/qemu-busybox-min.config
@@ -0,0 +1,56 @@
+# This is a minimal configuration for running a busybox initramfs image with
+# networking support.
+#
+# The following command can be used create the configuration for a minimal
+# kernel image:
+#
+# make allnoconfig qemu-busybox-min.config
+#
+# The following command can be used to build the configuration for a default
+# kernel image:
+#
+# make defconfig qemu-busybox-min.config
+#
+# On x86, the following command can be used to run qemu:
+#
+# qemu-system-x86_64 -nographic -kernel vmlinux -initrd initrd.img -nic user,model=rtl8139,hostfwd=tcp::5555-:23
+#
+# On arm64, the following command can be used to run qemu:
+#
+# qemu-system-aarch64 -M virt -cpu cortex-a72 -nographic -kernel arch/arm64/boot/Image -initrd initrd.img -nic user,model=rtl8139,hostfwd=tcp::5555-:23
+
+CONFIG_SMP=y
+CONFIG_PRINTK=y
+CONFIG_PRINTK_TIME=y
+
+CONFIG_PCI=y
+
+# We use an initramfs for busybox with elf binaries in it.
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_RD_GZIP=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_SCRIPT=y
+
+# This is for /dev file system.
+CONFIG_DEVTMPFS=y
+
+# Core networking (packet is for dhcp).
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_INET=y
+
+# RTL8139 NIC support.
+CONFIG_NETDEVICES=y
+CONFIG_ETHERNET=y
+CONFIG_NET_VENDOR_REALTEK=y
+CONFIG_8139CP=y
+
+# To get GDB symbols and script.
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_GDB_SCRIPTS=y
+
+# For the power-down button (triggered by qemu's `system_powerdown` command).
+CONFIG_INPUT=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_KEYBOARD=y
-- 
2.34.1


