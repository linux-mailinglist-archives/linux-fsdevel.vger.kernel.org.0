Return-Path: <linux-fsdevel+bounces-34114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA779C28AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E278D1F22E41
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216615D1;
	Sat,  9 Nov 2024 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnEaz1Po"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FD81E
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111227; cv=none; b=YmiL9V+vY8R5/BqOTVLU4bdwcDDyq8bHydt6qrZrTujIYb5Q8kVuHJmayEaz6gUEsaonXP9z+pXQSPn8Jcr0fu2SebVMa1CiIWadsEiAnv6dIx0wAuWuKwlJPAOuw9zGx92xaLuDi3rzPeo3JyPMkCNRzPp4eKvczsPbHj8kZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111227; c=relaxed/simple;
	bh=nJ3vJStqvBAnIo21+zNKzvHLKEvkD+YrIcD87lzgIis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKgTOmxYVSWb33UhavRk1plVKtNBX1rEvsknHKaMzXfD/6xsg6Hqj+ByK+gjgWyZXduG5slAnNW/j4wSlVsW8cvNbJEKnQ4rHXBh8yqv+K1Xr8WqmkBjr3R3AWOU7i/UoR/hA50WlQObyUx+528mDzi/3TVJuKATuP1Vk2oA/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnEaz1Po; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso3061174276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111225; x=1731716025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u0vKDd00/Gx0I67cawEwoAlLYtJSHEVWq7vgYdfHGk=;
        b=HnEaz1PopPI8B569+AsDLG/l23j+C6H8PtlwVFrKau1tUog6oTgQJ0dBzFYSiXQnCZ
         HTRHDTPpaFLTNqzSx+qc0YURjwiFbv9mdEOloniAvIMC6wlccSFRHHv63JUMhO6KCnYL
         HsEz+fHaqmH2vH+EdbrCRKCfATWsSSgwctZ8pnQE1Y3XkJLSr1rPDngMQk3FQeS/uZHK
         6LTE7y6AN6gX+36NJBPqggMx5tpjVSUZgo5Ja3OJeZ7MRArdRDQUUfbIbovcApzQJYPI
         ILUs37RhbrsrEDnKYUaLxxstgXBPeCW2EmR8MxjnP1NFSJy/Aa1joUMQmv6iGR23Cg50
         X09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111225; x=1731716025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u0vKDd00/Gx0I67cawEwoAlLYtJSHEVWq7vgYdfHGk=;
        b=HQ+iD+cCNKxwENF2RZ5dUL3P1tZGfPfckAF01+aiDNW92W4il4rv8eWxE2rasTVDVl
         CyvoG1pvJRCCsWDA5G1TOCD7RDNULQuNybSBZkWWilaoC/QYix+LRR3t6RKs8etaXfEJ
         pHlPoWCNs+wjfw9yBDCgRJrs2ed3hapntDtgkoRUqaYRv1PydvY77fIbVsF5fObSzy4/
         ihikfqk+jVVkPg5VNYpcT+i1LKmko18s9/jwLYBLVsn1vz5zDMtfX3qMzsYcHGXlY1KG
         SWpOK2Z992Tz46nHOtWrmcFuxG657EwdOI/Vy8RWz2QmIAk99wr5ONizLEgIu9QjmR8k
         5jLA==
X-Forwarded-Encrypted: i=1; AJvYcCXyX+7X8DJWfIhJ9LYhDfpFiTloMXIPKDHzszp7lejgVOgmOqIm8gdxIS9teKuONoH1mJzZZs6/LFtdPUuL@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZh/iyFyGYvgQGLq3gRYBKqg1etGIimiQCxgDbzguD2S+9hbg
	0GkWo6xn1ImI25y/y+rqrLfqPVMysW1DorsdYApshky0lMnxyWLM
X-Google-Smtp-Source: AGHT+IFW9C3tis6Dk+bmddCPTB9nTFMAU3RBIEaszEQPp9IkG7YH7ua5i07VBY2Rnw8J/PrdlL+a1w==
X-Received: by 2002:a05:6902:1827:b0:e28:6b10:51b5 with SMTP id 3f1490d57ef6-e337f8ca22emr4204713276.32.1731111224851;
        Fri, 08 Nov 2024 16:13:44 -0800 (PST)
Received: from localhost (fwdproxy-nha-006.fbsv.net. [2a03:2880:25ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef1fe34sm959394276.13.2024.11.08.16.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:44 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 04/12] fuse: support large folios for non-writeback writes
Date: Fri,  8 Nov 2024 16:12:50 -0800
Message-ID: <20241109001258.2216604-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for non-writeback
writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a89fdc55a40b..6ee23ab9b7f2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1146,19 +1146,15 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
 
 	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		unsigned int bytes = min(PAGE_SIZE - offset, num);
-
- again:
-		err = -EFAULT;
-		if (fault_in_iov_iter_readable(ii, bytes))
-			break;
+		unsigned int bytes;
+		unsigned int folio_offset;
 
+	again:
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					    mapping_gfp_mask(mapping));
 		if (IS_ERR(folio)) {
@@ -1166,10 +1162,20 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			break;
 		}
 
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		err = -EFAULT;
+		if (fault_in_iov_iter_readable(ii, bytes)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			break;
+		}
+
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1180,6 +1186,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		err = 0;
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1187,11 +1194,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		pos += tmp;
 		num -= tmp;
 		offset += tmp;
-		if (offset == PAGE_SIZE)
+		if (offset == folio_size(folio))
 			offset = 0;
 
-		/* If we copied full page, mark it uptodate */
-		if (tmp == PAGE_SIZE)
+		/* If we copied full folio, mark it uptodate */
+		if (tmp == folio_size(folio))
 			folio_mark_uptodate(folio);
 
 		if (folio_test_uptodate(folio)) {
-- 
2.43.5


