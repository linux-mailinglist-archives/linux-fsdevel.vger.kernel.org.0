Return-Path: <linux-fsdevel+bounces-26915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB96A95D02E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DBEB2CD94
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491F6188902;
	Fri, 23 Aug 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ozuKZJeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C118786B;
	Fri, 23 Aug 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423353; cv=none; b=bmhHBGvJBToz+7l2yuVAaCee1FX0s5LcR00q9pW4aS0iUlLs1ysBAxGHfEPVqwNt6Gx9+4tVHP6Jp38Y9lwKQDRm7931+hSlxQAZz2uBDnPeHnkQEX5ZsciYTeLQ+XJ8lnJLafLjt5S/A8mp/CWpGuoftUO1xhjBMp9MRcommt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423353; c=relaxed/simple;
	bh=YCwmfOQ4+j5ZTua/y1w9BRTVk9yDOdoM0dPoqpyi2pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqKiFnEwUH8e/IedwETFBpOIaKZyQrlB+AWnPplIUls7Onz6JsTL7tPjAwhGiHHB+t9k3CR7whwV9lJXKNr3+x//l+NTr1D4dkVHS+i/EACod8I8O1g0WWMLaQajrHABTqzbNjANnu8swUrAGEfCllX/EBiYfCw/rqqk9teplN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ozuKZJeI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=s7YPy+QRRfbLk38fcA19eeP3a4qxXdeXDpbv4x1kpi0=; b=ozuKZJeIB1KUMIczATebdsWN3P
	aefS7hQGqVuJlxfTVgpH22EUXlsTymgj+GsNfBMCaI8GiwjUMXvT1wy9Z7aNXTIUNYnSIf7HIIjCc
	n+AYUjOoW6rkw4JZXOOHX87CknOHrw2adzCqzQcE6Rq6qChGkqTGfj6wDuXBRk67FIuOKsLmqeffW
	E4dCtAyB40n8by8IgpTZ7tY4LZbL29Sk2J655LHStRXCR/BkJZGam6gk9JTrBvwDvGAGuMOto3wxO
	OdlOMi4wbz+lxQ8T7367hCQoe+nO8VzebTV9/qwXu3r9Zd3nAvusno1M8aJhcH8i7+z9r7Qva9hhJ
	F6/GXBMg==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shVHa-00458Y-5f; Fri, 23 Aug 2024 16:28:54 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH V2] Documentation: Document the kernel flag bdev_allow_write_mounted
Date: Fri, 23 Aug 2024 11:26:07 -0300
Message-ID: <20240823142840.63234-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ed5cc702d311 ("block: Add config option to not allow writing to mounted
devices") added a Kconfig option along with a kernel command-line tuning to
control writes to mounted block devices, as a means to deal with fuzzers like
Syzkaller, that provokes kernel crashes by directly writing on block devices
bypassing the filesystem (so the FS has no awareness and cannot cope with that).

The patch just missed adding such kernel command-line option to the kernel
documentation, so let's fix that.

Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V2: Improved wording (thanks Darrick!)

V1 link: https://lore.kernel.org/r/20240819225626.2000752-2-gpiccoli@igalia.com


 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..7c5283f11308 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -517,6 +517,18 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bdev_allow_write_mounted=
+			Format: <bool>
+			Control the ability of directly writing to mounted block
+			devices' page cache, i.e., allow / disallow writes that
+			bypasses the FS. This was implemented as a means to
+			prevent fuzzers from crashing the kernel by overwriting
+			the metadata underneath a mounted FS without its awareness.
+			This also prevents destructive formatting of mounted
+			filesystems by naive storage tooling that don't use
+			O_EXCL. Default is Y and can be changed through the
+			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
-- 
2.46.0


