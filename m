Return-Path: <linux-fsdevel+bounces-26958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDF95D4E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B972F1C22FC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F8191F81;
	Fri, 23 Aug 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZwyI6TSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42681885B9;
	Fri, 23 Aug 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436409; cv=none; b=dMP4TPIkjTQe/0+d37O1LESzGjSJX49vfuXHmUxEKaBvRk98jOoobKvegIZv190zY0mOOiKSK5kr8mZgKRci6Q4reec5uDlSXTNWES/LDkD5jaRQgG9Uqi+48B1CfhGM0Tg5nO41daZwYHsJ4QTEDCEm5VFmPD1gH6i6A7fCiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436409; c=relaxed/simple;
	bh=cl2zerZ4TMH3sxVHRiVXcW5ONjHaxzlxj0AlT7Bp+mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdk9/i83XE4nYVHmysiEP1XTbwms+Vw2RGfd0jEsHg9R/iLNufMH8Zy7VOZ0ki+CLjdfXJUgUbM9VdwmEBLaFIyoD3hFGpkT/eGydSI5XpXKPuh0CKxXErY0SJVVcziRtTl2jr1CNU3dTIBPfjp+V86qy+cOln/fX8/azR8kNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZwyI6TSj; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bbZDuqZ2tplb1V/ahj8mHD3Uq39717xv3shBDUdulMQ=; b=ZwyI6TSj8VEA4bPwQgrsfHMSHQ
	g2lw5tLiGEnokciF84n+r7Syd85AmHTe2tpl1MwlR+hj3v3Us4vLUmj+QDD31l0OGD1/lTj9skubA
	4Bol5MADZi3Q2wc6yQmHAjeKPGCBtQi8KSvGVVbyQ0co91tcLgaeo0bekHSU485+96bWkhUc4AujM
	BdAEvjQtI3UUFMfr9eLGD8f2ORxJe8CL5hHv55wDNT/9DLJQtWIWwMTazWAZUA06QXRwMjBif4pds
	Ij0MoDQWGJEDn4+APKnsdP0I73pwQzy6O4qoLjUU03R0F96lXOm1UGqkYvTnOEaZ2ZI/epv6N8aLp
	mRsnTicA==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYgM-00495r-3g; Fri, 23 Aug 2024 20:06:42 +0200
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
	Jan Kara <jack@suse.cz>
Subject: [PATCH V3] Documentation: Document the kernel flag bdev_allow_write_mounted
Date: Fri, 23 Aug 2024 15:05:13 -0300
Message-ID: <20240823180635.86163-1-gpiccoli@igalia.com>
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
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V3: Dropped reference to page cache (thanks Bart!).

V2 link: https://lore.kernel.org/r/20240823142840.63234-1-gpiccoli@igalia.com


 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..58b9455baf4a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -517,6 +517,18 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bdev_allow_write_mounted=
+			Format: <bool>
+			Control the ability of directly writing to mounted block
+			devices, i.e., allow / disallow writes that bypasses the
+			FS. This was implemented as a means to prevent fuzzers
+			from crashing the kernel by overwriting the metadata
+			underneath a mounted FS without its awareness. This
+			also prevents destructive formatting of mounted
+			filesystems by naive storage tooling that don't use
+			O_EXCL. Default is Y and can be changed through the
+			Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
-- 
2.46.0


