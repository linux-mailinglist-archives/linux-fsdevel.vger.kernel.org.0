Return-Path: <linux-fsdevel+bounces-26324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28E957846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 00:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF47A282596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43EB1DF66A;
	Mon, 19 Aug 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ot1hZGON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B73C482;
	Mon, 19 Aug 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724108266; cv=none; b=NS0pd0RLzAXwLoNPMwnN4tkFwALv+RTltyjKe0XsEBJdBja73KFmA2wGyzfxr0ESYt0HQQHDfZbJE+t0I1tOgwx35XnXqoc4+8f6dnVAF4GCXK0bmjVYMOfo23ckHaeSSQWEJQza4pUIwau4857QRggZAcVisTYsFLfWn4zXD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724108266; c=relaxed/simple;
	bh=3RYkj11lora+jk88iuLfmUrVXzlcGtIcbelB817NQv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZYyxBJgEjVnLQ0qO/GR88tECafHV+hSMZvRcn8tfYoZ0m+q8kB/PaY9SOjGCuD/46wcm1pOTbUHNjswvWRm1rAZ2svwLjeqnUsmtNHcEaNFLU3PtCzoSwdFDz1ExKFlRR/B3tBA6txkTv7PL8qCLjjjMeQcHC7MNYM26T+2rS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ot1hZGON; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iGfyJmX1Qzz8nM0pIFZUr1CNLjNyXjnaY0/FtRYCuzY=; b=ot1hZGONVPSZvQBPNekSSZ6h1b
	L1c1lvSHOZlXHoDhld0CaHi/GNxXUK7CHiKtcNEW1TFDHUrJbaGy4irle5OEGCQDHrXTSO+CK5gN2
	a0xMyaH38iD/d2kKA+X7iO3HrCKfV8hhHC7/inMqtTvEcYt6H/zyMHaFNY5XUNWmtRquWVnK4ZYhp
	KicX6G55EOvHCSEM9Rez9da2LN3jlllyp9JJpKuMbC9XewXOmSk8l0/5l6hVEZPK9xf76EY14sKCZ
	wEacaWqalp/l59k5PlBpj3YnNzWtZJL+3bTlU6gxbV0Vuy79SD4k9JWnBkZ/RN7051LIAsW2d4SRj
	+1NGjhlA==;
Received: from [177.76.152.96] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgBJb-002OXu-UJ; Tue, 20 Aug 2024 00:57:31 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-doc@vger.kernel.org
Cc: corbet@lwn.net,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH] Documentation: Document the kernel flag bdev_allow_write_mounted
Date: Mon, 19 Aug 2024 19:56:27 -0300
Message-ID: <20240819225626.2000752-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.45.2
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

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 09126bb8cc9f..709d1ee342db 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -517,6 +517,16 @@
 			Format: <io>,<irq>,<mode>
 			See header of drivers/net/hamradio/baycom_ser_hdx.c.
 
+	bdev_allow_write_mounted=
+			Format: <bool>
+			Control the ability of directly writing to mounted block
+			devices' page cache, i.e., allow / disallow writes that
+			bypasses the FS. This was implemented as a means to
+			prevent fuzzers to crash the kernel by breaking the
+			filesystem without its awareness, through direct block
+			device writes. Default is Y and can be changed through
+			the Kconfig option CONFIG_BLK_DEV_WRITE_MOUNTED.
+
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
-- 
2.45.2


