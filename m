Return-Path: <linux-fsdevel+bounces-39787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F8A18151
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 16:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6202E1666CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14511F2C5B;
	Tue, 21 Jan 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="dewXfSKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZbzoI0vl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB971E51D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737474388; cv=none; b=OOcIvsprMkhuuJDTzEMeLlJhDy2RiLfIBYBhuG5cIkJlTcVN/8OshbpgkBxvQ2Vk5Xq3F3E/5SpgNUCqChvkCGjSHdI3x7+oCFOyOVycWL9ZlxNonIVgbvfElmuQ3cyesAdxDqKpKGZsvBxINcWqCvxxgV1hqBczQSFKbstTmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737474388; c=relaxed/simple;
	bh=mNcvn9K9+bu9KCWmscH/uBK62BhZNNzz6y+9wgMDxt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cTUpB/7V5yyGJckjod6eDqIaRpk67Vdan72ZU84dNE2lCOESKdisSkh0VrpMoRjNtqIuAM84kRhLhz2X9yf/O56QxiTg2egf+jO50X8DkK2N0N61UFVeWg8xCdLscL2dymmKsweKTjf+Kk6BzYRcVmOK9MAPGKbej6UIbGpbuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=dewXfSKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZbzoI0vl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 116611140207;
	Tue, 21 Jan 2025 10:46:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jan 2025 10:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1737474385; x=1737560785; bh=xRhQg7Z3M6ZAaAlZ9W4J+pXvUNzw4SL1
	05Brt9UfWhc=; b=dewXfSKnBbDjEQCrMnta8hssbRTwPfiyRQ4bZYiRdzl8yghS
	DXBWW9briHewprZk+SnAVVcsjfHLlm4Za2ZpCUzNGaB71MwdtsaCyoIOKcG/iOjl
	PQdz+fOX9aDP/RLz9ipDQvtb2X9bX+rZPO0V5wa21Z6oL0kEy0Niiq40HaYYtUId
	q9OCWRY4H26W4+91VM+AS2Vkfj8+7kj/YLUtkw/Zr9cX3q3Bc85mPE+N6I6LPzQS
	OMY+KaOBzGCZn+zqEDVlc/5LeipyJk/1pNzxwwZKjCKr1p3m50oW/f+4ghkq0MsF
	KP5aRBRqqeocOJqMDTUXZdkH1RIXii9M7RuFWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737474385; x=
	1737560785; bh=xRhQg7Z3M6ZAaAlZ9W4J+pXvUNzw4SL105Brt9UfWhc=; b=Z
	bzoI0vlytlpL9HZXrlSJmF7GQm3zg31w4QiT79RcAyNvPuTpSJvfEtA8EL+qHJGE
	vS7ozkjmVKybLuroJqdT8vcrjzboFmV01K+rs2FDBSoOd6gz38pAK5Ffb62VkVGx
	brRVJ5a0thwl4+DNtMNpD3FVj1nk+lKXdVgZOw9rTqpqEDDk2aBj3prKZcd8XXIJ
	a7WFCUV4U2AWOHzWZsKouFIVWILEmEdu7jupM9T4gErgEmopPpYFAIr/HkQ6AAFS
	Bo6LuM4B4OGvHb5DK/WZO5JrLokGv4hGEz2Ct0pOYbdEQoTWfHz1XP/wOzfw7yS8
	eK9ci+Xyi+ZaYuRpwGK6g==
X-ME-Sender: <xms:UMGPZ8pM2uqytsLRtAZewo06l9jAwkFJWYG-20UvsKkBMn6caGrUIQ>
    <xme:UMGPZypKHl53LfOuC9nr6c2twhK5tw5dzqrfSYBfWBvY-x6bCyJfnCW4DojW7ci3F
    giO8UjpODH66LpAhsk>
X-ME-Received: <xmr:UMGPZxOonwv54uxCGQrQqh0ZzH_XH_N6oetm8Osxb0OfLC1bKWNFbtqf3FnXCVfgzTitjYV3QvqLkPr5Q045WhzHXJIydHskv32HGk0cEqkbugA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepieefiefhgfdvgfetheffteehheelfedukedv
    vdeuleeifffhfefftdehieefudejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggr
    vhhiughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehtjheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvse
    gurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgu
    mhhishdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthht
    oheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhgrmhgvshdrsghothhtoh
    hmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrhhshhhiphdrtghomhdprhgtphhtthhopehk
    jhhlgiesthgvmhhplhgvohhfshhtuhhpihgurdgtohhm
X-ME-Proxy: <xmx:UMGPZz4OYxROiXsTsCmllHGTTsXb-IfSmdX7S5uBp9CrMx75bBg3OA>
    <xmx:UMGPZ76IZM75SZgoTcHrS2DQFMHA9duNsBovahzpCqLo0xKbm1BruA>
    <xmx:UMGPZziJt4eL2EuVKYm-3rDF-Q9ttmBh6aZgy4SFrKckI4VIjlRnyg>
    <xmx:UMGPZ15OqzDgwjY-jGUSnXGliP1UErIGsyeSTB86yxvmuhIa-s4Iew>
    <xmx:UcGPZ4zGFvdOwAfVxMmHUjMmY9r7ZSaSoqe86rzVsQVeHp3GWZvZ-_Fs>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 10:46:23 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>
Cc: David Reaver <me@davidreaver.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Krister Johansen <kjlx@templeofstupid.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] samples/kernfs: Adds boilerplate/README for sample_kernfs
Date: Tue, 21 Jan 2025 07:46:12 -0800
Message-ID: <20250121154618.42760-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250121153646.37895-1-me@davidreaver.com>
References: <20250121153646.37895-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds the necessary Kconfig/Makefile boilerplate to get sample_kernfs
compiled into the kernel. Also adds a README.rst file to describe how the
filesystem works from a user's perspective.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 MAINTAINERS                    |  1 +
 samples/Kconfig                |  6 ++++
 samples/Makefile               |  1 +
 samples/kernfs/Makefile        |  3 ++
 samples/kernfs/README.rst      | 55 ++++++++++++++++++++++++++++++++++
 samples/kernfs/sample_kernfs.c | 20 +++++++++++++
 6 files changed, 86 insertions(+)
 create mode 100644 samples/kernfs/Makefile
 create mode 100644 samples/kernfs/README.rst
 create mode 100644 samples/kernfs/sample_kernfs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fa7c5728f1e..5791aced4b93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12702,6 +12702,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 F:	fs/kernfs/
 F:	include/linux/kernfs.h
+F:	samples/kernfs/

 KEXEC
 M:	Eric Biederman <ebiederm@xmission.com>
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..968294ffb35d 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -291,6 +291,12 @@ config SAMPLE_CGROUP
 	help
 	  Build samples that demonstrate the usage of the cgroup API.

+config SAMPLE_KERNFS
+	bool "Build sample_kernfs pseudo-filesystem."
+	help
+	  Build a sample pseudo-filesystem that demonstrates the use of the
+	  kernfs API. The filesystem name is sample_kernfs.
+
 source "samples/rust/Kconfig"

 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..e024e76e396d 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
 obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
+obj-$(CONFIG_SAMPLE_KERNFS)		+= kernfs/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
 obj-$(CONFIG_SAMPLE_KFIFO)		+= kfifo/
 obj-$(CONFIG_SAMPLE_KOBJECT)		+= kobject/
diff --git a/samples/kernfs/Makefile b/samples/kernfs/Makefile
new file mode 100644
index 000000000000..3bd2e4773b91
--- /dev/null
+++ b/samples/kernfs/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SAMPLE_KERNFS) += sample_kernfs.o
diff --git a/samples/kernfs/README.rst b/samples/kernfs/README.rst
new file mode 100644
index 000000000000..e0e747514df1
--- /dev/null
+++ b/samples/kernfs/README.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================
+Sample pseudo-filesystem built on top of ``kernfs``
+===================================================
+
+This directory contains a kernel module that implements a pseudo-filesystem
+built on top of ``kernfs`` and it demonstrates the basic of how to use ``kernfs``.
+
+Usage
+=====
+
+Compile your kernel with ``CONFIG_SAMPLE_KERNFS=y`` and create a
+``sample_kernfs`` mount with::
+
+  # mkdir /sample_kernfs
+  # mount -t sample_kernfs none /sample_kernfs
+
+Filesystem layout
+=================
+
+The filesystem contains a tree of counters. Here is an example, where
+``sample_kernfs`` is mounted at ``/sample_kernfs``::
+
+  /sample_kernfs
+  ├── counter
+  ├── inc
+  ├── sub1/
+  │   ├── counter
+  │   └── inc
+  └── sub2/
+      ├── counter
+      ├── inc
+      ├── sub3/
+      │   ├── counter
+      │   └── inc
+      └── sub4/
+          ├── counter
+          └── inc
+
+When a directory is created, it is automatically populated with two files:
+``counter`` and ``inc``. ``counter`` reports the current count for that node,
+and every time it is read it increments by the value in ``inc``. ``counter`` can
+be reset to a given value by writing that value to the ``counter`` file::
+
+    $ cat counter
+    1
+    $ cat counter
+    2
+    $ echo 4 > counter
+    $ cat counter
+    5
+    $ echo 3 > inc
+    $ cat counter
+    8
diff --git a/samples/kernfs/sample_kernfs.c b/samples/kernfs/sample_kernfs.c
new file mode 100644
index 000000000000..82d4b73a4534
--- /dev/null
+++ b/samples/kernfs/sample_kernfs.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A sample kernel module showing how to build a pseudo-filesystem on top of
+ * kernfs.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int __init sample_kernfs_init(void)
+{
+	pr_info("Loaded sample_kernfs module.\n");
+	return 0;
+}
+
+module_init(sample_kernfs_init)
+MODULE_DESCRIPTION("Sample kernel module showing how to use kernfs");
+MODULE_LICENSE("GPL");

