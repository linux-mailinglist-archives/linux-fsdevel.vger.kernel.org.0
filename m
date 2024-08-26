Return-Path: <linux-fsdevel+bounces-27072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A691B95E5F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 02:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AD92810D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 00:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A555139D;
	Mon, 26 Aug 2024 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pjQB+mnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81D623;
	Mon, 26 Aug 2024 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631408; cv=none; b=MKy2jY1uVGFpQtbMw4ToNDIFo9jkZfz3dulTmOO+MTzBGwu8YR6egh01jNhelOa9+SumtQkYsQV4VGvUNf2/8Qkk2TKK1PemItKxKfVhwwcer6fpoPdTcxu3skdHb8lcmm7L8VVSxJ+YYAwPmLag0C3qGKzxZiYcMzan3jtk5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631408; c=relaxed/simple;
	bh=h3oFpfXf51AqeUkuOeTEcLoxvTmO/wb6NbJewe8704c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FP2GarUNTgnyA0XUG0P/Omwsj8XEu468svRIpnHT0x0/Tok/qLg5Et2FWRnYMYFr8ipsoceGCREz7ZRw3h4/ohWm93nR3VYu6HQKdZzaOBYq67TUKmASGrggR4eEZJY/ghEF19Vg3cjNX/Fx5AKOd1WUjYbvQHXCr7wLtCsdxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pjQB+mnv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eVEfY25bFaaUmkSSv/dQYk+QOj18buGsOyCj0zIKmiw=; b=pjQB+mnvS7U8IX9flc3mqQIa1Z
	WiBaT1OIqImCGq5W+ZwEJJweDFlYNnCjLoFtr0Cx1reF0qXdZ4D4lcYZPmrqza1DbT3QUz/C7OI16
	QW+GZ2PfKFX0IWfTVNGrVDoJ6es+LeZD2rgKU7k7Sx3aq/7k0DmYrfhAud5yq/+gCUOnR8Wj0+oFy
	wIOsNv6ZFSAQispfXZSF4qTLdpVr2RiOSlVEEodNdCAGgbSR5P3B8wNi2is52+/b2Yb5AwjieMec8
	Br427Zzswa7dhpPecevQvdrlRg/FW1vPmcnt+NC9ZCVQjhlczi5cm1dej7ToALSSHU2HEfIBJMAs9
	TI09NspQ==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1siNPN-0053Td-8f; Mon, 26 Aug 2024 02:16:33 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH V4] Documentation: Document the kernel flag bdev_allow_write_mounted
Date: Sun, 25 Aug 2024 21:15:11 -0300
Message-ID: <20240826001624.188581-1-gpiccoli@igalia.com>
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

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V4: More improvements in the wording (thanks Jens and Darrick!)

V3 link: https://lore.kernel.org/r/20240823180635.86163-1-gpiccoli@igalia.com


 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..d521d444a35c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -517,6 +517,18 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bdev_allow_write_mounted=
+			Format: <bool>
+			Control the ability to open a block device for
+			writing, i.e., allow / disallow writes that bypass
+			the FS. This was implemented as a means to prevent
+			fuzzers from crashing the kernel by overwriting the
+			metadata underneath a mounted FS without its awareness.
+			This also prevents destructive formatting of mounted
+			filesystems by naive storage tooling that don't use
+			O_EXCL. Default is Y and can be changed through the
+			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
-- 
2.46.0


