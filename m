Return-Path: <linux-fsdevel+bounces-44555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA2A6A49A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7508A4FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C902206B9;
	Thu, 20 Mar 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1i6JkBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3B209F4E;
	Thu, 20 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469225; cv=none; b=TD8JLeCaZCByfbDblJ1vRLksZv3yNx4jguK4vixhKB4l77oedS1UR2+e4YnLbTV5Q2MLYYVh4KtXuwMI6wHhUmmjefSiTH9TV3aUmOlijcmsfy2rPetNNZAEd9xmKM2qpv4+WfuUZILsJwYm5YgpR6PtUStxZmIgXHIAwQ2CRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469225; c=relaxed/simple;
	bh=UQSVd9fn4oGGUe3K7GxXqZFSqLzzVOuQ21NoWR5cw8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHJSeeeg9keynWCFm7bugqIfcpqFubFVTmFbamd5qcrFvprq0S4RpOUkYPhH1yBnsPaLJjtUt2KEkYNZ4HlYs0rirv1KuErVACImIJH8/g5jjjzhpU0Xr2ZYLvMylOycnalPOYjZGl0cWoye89xUvYF/qnn4MPvHmRX62F98aGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k1i6JkBH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gs4mQgpvMaKPx1XMegy2dt340WQwRma2LYoA2+CbDAc=; b=k1i6JkBHSHT0fr3QGyBpbdKsKs
	qwtzxHS2sxeO/5RW2t/2epVt9HQlqit7a1xKKEr6Ekf/btQ9vTKoA0rCyc0w8E6PSbY0VZ3Gt0Gzx
	FWphpz71JxF3i0wY6vjNTs4+Y1NTDvvsCNmGFfVDDaAPxPfc7G/Yx4n09nQu8tCz5zNhMODlArXcS
	hFAVGvl521m/au46cLJvAKxQwm5pfoFd591QFVEMXYhBWmuD1xCarxZDjVOVdARnWnKCEiVjBb0LL
	hFg5owWxQH9jv1x8Lc/M48kTqeVHRznRau24Jro+rjaqhzXaBHEWDGL/fPmwRIFl3HoEPffitH5A9
	oyrGnhWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvDqB-0000000BvGP-1BwN;
	Thu, 20 Mar 2025 11:13:35 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: leon@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joro@8bytes.org,
	brauner@kernel.org,
	hare@suse.de,
	willy@infradead.org,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [RFC 4/4] nvme-pci: add quirk for qemu with bogus NOWS
Date: Thu, 20 Mar 2025 04:13:28 -0700
Message-ID: <20250320111328.2841690-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320111328.2841690-1-mcgrof@kernel.org>
References: <20250320111328.2841690-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The NOWS value for qemu is bogus but that means we need
to be mucking with userspace when testing large IO, so just
add a quirk to use sensible max limits, in this case just use
MDTS as these drives are virtualized.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e62..8f516de16281 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2070,6 +2070,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		/* NOWS = Namespace Optimal Write Size */
 		if (id->nows)
 			io_opt = bs * (1 + le16_to_cpu(id->nows));
+		else if (ns->ctrl->quirks & NVME_QUIRK_BOGUS_NOWS)
+			io_opt = lim->max_hw_sectors << SECTOR_SHIFT;
 	}
 
 	/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..c63a804db462 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -178,6 +178,11 @@ enum nvme_quirks {
 	 * Align dma pool segment size to 512 bytes
 	 */
 	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
+
+	/*
+	 * Reports a NOWS of 0 which is 1 logical block size which is bogus
+	 */
+	NVME_QUIRK_BOGUS_NOWS			= (1 << 23),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 27b830072c14..577d8f909139 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3469,7 +3469,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DISABLE_WRITE_ZEROES |
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
-		.driver_data = NVME_QUIRK_BOGUS_NID, },
+		.driver_data = NVME_QUIRK_BOGUS_NID |
+				NVME_QUIRK_BOGUS_NOWS, },
 	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
-- 
2.47.2


