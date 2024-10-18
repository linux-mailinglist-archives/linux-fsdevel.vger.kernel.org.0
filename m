Return-Path: <linux-fsdevel+bounces-32311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EDA9A35B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA028520C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF518B48C;
	Fri, 18 Oct 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vt5RjUkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1206F187FE7;
	Fri, 18 Oct 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233666; cv=none; b=O3r93XEnXo95lXe/qHSLTzu4tGNdbd4qG3JOy0ktxgYPXcXuY3xZkWE4Ph51v9azBa9BOjpRfRnFDpx30oGgqelymH2Ht3CguZgIth97RznFVhto7fmOOVgCtf2lYjGsNw1wvlqOgUFls13xtxBU035RVdyAqim9hpy8PnqewoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233666; c=relaxed/simple;
	bh=LlOfKWFmMimgOZRHZFBWIeDtQDuVJjBoFm4a8ckUAcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxLPJoE+ZeVM78FcLcg4ybiXOVEzggcAOUzWCYkArquR6edtAyKLUzshojqzg18U/3Nfs7cFrP4GyYBDdnyrD9k8bvT4IsT3XNBlCqljI4ICuNpqP1tGubJVxZdk2J1qSA9PycrnIklAUjrU2c5qtrc3r8qRETFJVNMTupoFSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vt5RjUkb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233665; x=1760769665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LlOfKWFmMimgOZRHZFBWIeDtQDuVJjBoFm4a8ckUAcs=;
  b=Vt5RjUkbqt3BfPP5u+NR3dit1Ptu5wYySvDbNJy2GaMSS4TAJ5q0M8fC
   giGle4I5DJZn70A8js7t8wU+hPYOVyhCrxPJFbox0bp4Txi+jHEMpETqe
   MXudlNY62HO13dWBLN+wKSpmx6XX1zit+fGSaro5PCbuiDVdyJ4W4xfDi
   Jy2wUNDUuhKFFqqpfHt8s5HGVYMd3N3q/a3LA+sdd/Yhuo0kfw5EtC0p0
   ArFYil69s+W6KdzEzBWZJZxsTtibtaqZC01p1KjtmJ2KLnLqCgnV/jJIT
   3wEexK3uJ14bosfz/u+21LmJHMwX3sb2KoUNweCkvpn3TcbwEDj3bwVKI
   g==;
X-CSE-ConnectionGUID: nBmi1AG/RvChkDPaTFgDrg==
X-CSE-MsgGUID: IIX+Af/aRZOIIcBw5Nck8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884794"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:02 -0700
X-CSE-ConnectionGUID: gJKulEXVTRCuP5PYxKnngw==
X-CSE-MsgGUID: S19yrmp8R/uCrtwKGYX3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607493"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:02 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 02/13] crypto: iaa - Add support for irq-less crypto async interface
Date: Thu, 17 Oct 2024 23:40:50 -0700
Message-Id: <20241018064101.336232-3-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a crypto acomp poll() implementation so that callers can use true
async iaa compress/decompress without interrupts.

To use this mode with zswap, select the 'async' iaa_crypto
driver_sync_mode:

  echo async > /sys/bus/dsa/drivers/crypto/sync_mode

This will cause the iaa_crypto driver to register its acomp_alg
implementation using a non-NULL poll() member, which callers such as
zswap can check for the presence of and use true async mode if found.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 237f87000070..6a8577ac1330 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1788,6 +1788,74 @@ static void compression_ctx_init(struct iaa_compression_ctx *ctx)
 	ctx->use_irq = use_irq;
 }
 
+static int iaa_comp_poll(struct acomp_req *req)
+{
+	struct idxd_desc *idxd_desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct idxd_wq *wq;
+	bool compress_op;
+	int ret;
+
+	idxd_desc = req->base.data;
+	if (!idxd_desc)
+		return -EAGAIN;
+
+	compress_op = (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS);
+	wq = idxd_desc->wq;
+	iaa_wq = idxd_wq_get_private(wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	ret = check_completion(dev, idxd_desc->iax_completion, true, true);
+	if (ret == -EAGAIN)
+		return ret;
+	if (ret)
+		goto out;
+
+	req->dlen = idxd_desc->iax_completion->output_size;
+
+	/* Update stats */
+	if (compress_op) {
+		update_total_comp_bytes_out(req->dlen);
+		update_wq_comp_bytes(wq, req->dlen);
+	} else {
+		update_total_decomp_bytes_in(req->slen);
+		update_wq_decomp_bytes(wq, req->slen);
+	}
+
+	if (iaa_verify_compress && (idxd_desc->iax_hw->opcode == IAX_OPCODE_COMPRESS)) {
+		struct crypto_tfm *tfm = req->base.tfm;
+		dma_addr_t src_addr, dst_addr;
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+
+		src_addr = sg_dma_address(req->src);
+		dst_addr = sg_dma_address(req->dst);
+
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+out:
+	/* caller doesn't call crypto_wait_req, so no acomp_request_complete() */
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+
+	idxd_free_desc(idxd_desc->wq, idxd_desc);
+
+	dev_dbg(dev, "%s: returning ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
 static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
 {
 	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
@@ -1813,6 +1881,7 @@ static struct acomp_alg iaa_acomp_fixed_deflate = {
 	.compress		= iaa_comp_acompress,
 	.decompress		= iaa_comp_adecompress,
 	.dst_free               = dst_free,
+	.poll			= iaa_comp_poll,
 	.base			= {
 		.cra_name		= "deflate",
 		.cra_driver_name	= "deflate-iaa",
@@ -1827,6 +1896,11 @@ static int iaa_register_compression_device(void)
 {
 	int ret;
 
+	if (async_mode && !use_irq)
+		iaa_acomp_fixed_deflate.poll = iaa_comp_poll;
+	else
+		iaa_acomp_fixed_deflate.poll = NULL;
+
 	ret = crypto_register_acomp(&iaa_acomp_fixed_deflate);
 	if (ret) {
 		pr_err("deflate algorithm acomp fixed registration failed (%d)\n", ret);
-- 
2.27.0


