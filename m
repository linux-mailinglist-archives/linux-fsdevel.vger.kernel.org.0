Return-Path: <linux-fsdevel+bounces-21244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DD90080B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE1AB265D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1942C19B588;
	Fri,  7 Jun 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="J8/R4PXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE819CD19;
	Fri,  7 Jun 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772379; cv=none; b=qZCIKessw3M73PkPpmQhgEvsjFFkn6fCykO6kN1SjoMjtSPyf7Ni4oJ+DmPvbb5NEOiT/RGaAkOEUEl8MbcP6k2elJo3Bz2fNVGQ1JdlyJ178pK5EALLnzbJrORPtk4SPTIVLhj+uCTbxa4ym2KNL4Kp2nmJ2XW/ZZak26p6czM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772379; c=relaxed/simple;
	bh=47VVP/OnFHuryCmTdiZEhlMqP7OUFLbnVrVbFMsTCEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub4x+y9inUw+Kq7cP27dH1Fs1aY5ppDpLFhRaxY5oMLZbtF9Q+GsKb2STvreW3vYYIN9hwz8wbBenYWC7HbWWbeCemw+kGWKcKwP4qX2T/gBxZMiGFghkiUjtX3GMG6w64ewDB6ZOl5QYmCEbO9dRnnPe2M0HAimlj+two6U8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=J8/R4PXX; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Vwkr61KLfz9spm;
	Fri,  7 Jun 2024 16:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZ8spY/tVuIWIrFMviERGy/5Qi8haMN3dT86BjfIdPw=;
	b=J8/R4PXXvkkbYJHQl7XbsXJeITLpZQv1B3Zo+xpZIlQ9Ut+9PsC2vT1rlqmadtHLrvo6rb
	zQOFhlJSqPC0bSLUvcoaqFYoWSUq9y324Ft40iYEiTvD8Gqy4dTQiwviA6QtV/5ausrBl9
	YuOH5eZnKiQZYSaZMW2jyWegt9+fG8U0OoxOic/0njfB9gN5Sot38JjbEQI0Ikc0AQ2OGl
	sC40ZxMSHSlBRJwsKF/AxOJqEuwqlUVm/3p8+nMH2fa/fLOWTCS/SyVBd71MvC3DjUI8Z5
	YxBU/uRO8gGE3g3g0dBUpfzCsla0Q1BrAs5G17j6X7vu91SRzTxSWlx4rMMy+Q==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: [PATCH v7 06/11] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Fri,  7 Jun 2024 14:58:57 +0000
Message-ID: <20240607145902.1137853-7-kernel@pankajraghav.com>
In-Reply-To: <20240607145902.1137853-1-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. Cap the PTE range
to be created for the page cache up to the max allowed zero-fill file
end, which is aligned to the PAGE_SIZE.

An fstests test has been created to trigger this edge case [0].

[0] https://lore.kernel.org/fstests/20240415081054.1782715-1-mcgrof@kernel.org/

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8bb0d2bc93c5..0e48491b3d10 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3610,7 +3610,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3636,6 +3636,10 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
-- 
2.44.1


