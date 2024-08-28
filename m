Return-Path: <linux-fsdevel+bounces-27593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A8962ACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B73283141
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795C319FA80;
	Wed, 28 Aug 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P0YHczkk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE0189B91;
	Wed, 28 Aug 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856671; cv=none; b=gdevBxRoc9V/cEB7tpjrYmyDP3uH3Aed49/DeJaxnQkDog6qHHwEbIT9KEK3l17NKhmLgko00Y7kiPkietKRUUuAoKy7NlYqlpIL50ET9wEFva+uqpVVIGHDVu/Ld2WIoYMv33xS08Hcd/erH0KtZd92DzHljrInRD7FhxaJl9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856671; c=relaxed/simple;
	bh=Yx/xWH7sRQ0bUoCuj+xNJqLUe1vsbZ+IZWTvoqAWuGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHoDLRFYEN6Tl4PgdJV5UyvzssneHXgaZ6MRoPm403sC4sSyfqruCvWQOw8ndB6jYkM5cwniTlHBPOPGug1S8d38qTPIi1JxRlE2CcMtfDSOhtNZCgaRqA0SzcQQt9e+OktSWRM7wpBOCK/6oXJiYbHZLFjJP+UmO8st3pD+z2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P0YHczkk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kktE0sKtiI/wFdgKRtUfY1cxi+R6IyXPcJRTWtxZiag=; b=P0YHczkky21tDEptzoJ5oKMwwD
	JaPNpeZYkuScmkHxvH99HM5r+FWHH0Z8kz0a3jlvir16AVO6Q6ruNa+TGTuZigDieepjS+INvrBh1
	sgEIxQixEC5n5TaiEG6YpRRH7fIiBRbiVJAGDw5ia/Gxu82RXeEmIrt14TSEA8LcTDsIw6Gy6e20N
	tWk/2QQUkHNFIZxU3cott1otTBgff215iSDARpBAYV2vYeOdDMvZnoDV7331kCCRx4bUZw14ZH37c
	c2hTKf2EZoBDcRsIpA3JY4R8wLf7iBHUUqKFtDdRp1RMpiMXShOjAhahFVG+6AREaEo+mjz52KLIw
	QkoYNv7g==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sjK0e-006N2z-1X; Wed, 28 Aug 2024 16:50:56 +0200
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
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH V5] Documentation: Document the kernel flag bdev_allow_write_mounted
Date: Wed, 28 Aug 2024 11:48:58 -0300
Message-ID: <20240828145045.309835-1-gpiccoli@igalia.com>
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
Cc: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

V5:
- s/open a block device/open a mounted block device (thanks Jan!).
- Added the Review tag from Jan.

V4 link: https://lore.kernel.org/r/20240826001624.188581-1-gpiccoli@igalia.com


 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..efc52ddc6864 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -517,6 +517,18 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bdev_allow_write_mounted=
+			Format: <bool>
+			Control the ability to open a mounted block device
+			for writing, i.e., allow / disallow writes that bypass
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


