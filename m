Return-Path: <linux-fsdevel+bounces-32940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A439B0DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2715A1F2517C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9320F3E6;
	Fri, 25 Oct 2024 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGLP2lMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFD1FF04A;
	Fri, 25 Oct 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883308; cv=none; b=AIm0ECvg+HqggAkIUgsqux9q3fqZ7Rvaw1zePhHFvwhV1JYMJ49WZk0JyYWkVTNloKp4jr2yZ6kicXDq/yC0WFVtwkkDx86O4VWAuYUtyxETRPEy8BpWZHKjMEpEgnudra33sIWfCIyJvbH61LHlQnu1rUii6Q5K4ymdohdYRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883308; c=relaxed/simple;
	bh=+N/3CNeSqYIiw3WeWycoxeyoK/Wg6RrHh9USwpRdx5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQwzP1i0LC5ftpwHZgrBaKUcVqbr3IOqOQBepAmEisj/QIc5vceoFdWy6TTsPWRaI+FE1MmelOrD9F/DN8APT5/VjCnkOuZm2+PMN09stKDFmOpc09x2QjICXC3L9BL3/kvO2S9xKz1ZGWMifIFZyfVZ64VCVI0X/jMtT7fSNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGLP2lMb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=oG70nI1x0BD9NrNKwoyfLV7xuyzNiqaZvDa2zjd+ZR8=; b=pGLP2lMbJttjY+JHAe6DLku11/
	hAPguFWSzcwgJaSS/rhn4X4bjtREB07Sqi25v4NUgE690f0CfhlhkqSiE9pNmrVFVzHJySanFubC5
	bfPZy9zoRNNDRQJied5e9Tez65fpSkVxt+zmN7Wpuq8F5FvjfoicWo41vknb58O53l1XBzMmluWFM
	iGRXpw30JjtLp/hHmwc29H2FfuWNbTR3s1N8rYaWSnCLl7U6CJqOh3o7VrW9NhkxynWnGhOgH/dB0
	nNcOCAId0MbE7k38bX+sw1gpdMzfKB10OCSuv3qqqBhjhaujIhmXKhLbOQQYzQJwDrQiBRzYV5Egp
	7K47pz+A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Pfc-00000005XBw-2k3p;
	Fri, 25 Oct 2024 19:08:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Tyler Hicks <code@tyhicks.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/10] ecryptfs: Pass the folio index to crypt_extent()
Date: Fri, 25 Oct 2024 20:08:20 +0100
Message-ID: <20241025190822.1319162-11-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241025190822.1319162-1-willy@infradead.org>
References: <20241025190822.1319162-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to pass pages, not folios, to crypt_extent() as we may be
working with a plain page rather than a folio.  But we need to know the
index in the file, so pass it in from the caller.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ecryptfs/crypto.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index bb65a3a5ee9b..69536cacdea8 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -340,6 +340,7 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
  *              encryption operation
  * @dst_page: The page to write the result into
  * @src_page: The page to read from
+ * @page_index: The offset in the file (in units of PAGE_SIZE)
  * @extent_offset: Page extent offset for use in generating IV
  * @op: ENCRYPT or DECRYPT to indicate the desired operation
  *
@@ -350,9 +351,9 @@ static loff_t lower_offset_for_page(struct ecryptfs_crypt_stat *crypt_stat,
 static int crypt_extent(struct ecryptfs_crypt_stat *crypt_stat,
 			struct page *dst_page,
 			struct page *src_page,
+			pgoff_t page_index,
 			unsigned long extent_offset, int op)
 {
-	pgoff_t page_index = op == ENCRYPT ? src_page->index : dst_page->index;
 	loff_t extent_base;
 	char extent_iv[ECRYPTFS_MAX_IV_BYTES];
 	struct scatterlist src_sg, dst_sg;
@@ -432,7 +433,8 @@ int ecryptfs_encrypt_page(struct folio *folio)
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
 		rc = crypt_extent(crypt_stat, enc_extent_page,
-				folio_page(folio, 0), extent_offset, ENCRYPT);
+				folio_page(folio, 0), folio->index,
+				extent_offset, ENCRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error encrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
@@ -505,8 +507,8 @@ int ecryptfs_decrypt_page(struct folio *folio)
 	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
 	     extent_offset++) {
 		struct page *page = folio_page(folio, 0);
-		rc = crypt_extent(crypt_stat, page, page,
-				  extent_offset, DECRYPT);
+		rc = crypt_extent(crypt_stat, page, page, folio->index,
+				extent_offset, DECRYPT);
 		if (rc) {
 			printk(KERN_ERR "%s: Error decrypting extent; "
 			       "rc = [%d]\n", __func__, rc);
-- 
2.43.0


