Return-Path: <linux-fsdevel+bounces-52668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D91AE59F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BE17A62C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23B22417C6;
	Tue, 24 Jun 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjF33Egf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770723ABAD;
	Tue, 24 Jun 2025 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731792; cv=none; b=JcdDuHpNMZaj0mrBZlx5Y3Kh79MVySPdvQrJBXhUJFPQwr57JGV8yKPVumcAEO4oHPttU6ZhwGvWPSYlppPg1fikpmu1DrPTEqdsfSYjYEz1e8XrM6Ybr3a9CQSwKPFZ9GxjzBPGP6vrFWiR5BPFgO0tQ0yeNA1lnMCHQX0IH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731792; c=relaxed/simple;
	bh=j5vgOtyIh/0mL3/1IM1EQg3ivNapUnNYD1rSJUxJUTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU4OG0Fde/f87k7WL/B9lRbOEG/LpKctDtnajMlZBl47lUGETYjxpHNyGtf4NkfL2ly+MOmO+SJrdtL/B4+og2diZ1rzV4xB41LHclGxfjLuclAvyX6yUlFM4ZS2kKjykWwsB9hIRaI0RfGGHPyZaB+1IeOw/JkTZhlEHzU14As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjF33Egf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so44349715ad.2;
        Mon, 23 Jun 2025 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731789; x=1751336589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC1UYON7hcM+s5zpfKbC1ZPj9/+qK5UO2VBeIZXIz0E=;
        b=PjF33EgfPGS+d+HkwdAKjRNjtDtiviCjiRz3MO3+0e3L639F5fmRkhj0SxvHeY4eba
         qMDqTVaeysX51aRJAtkxomYKka81Cwp2CRaopltjb+BQc/A7RoXF4Q5VQiUQ+HK5+a04
         ja4gckDUXIoxAYn8fynlTArQMQ9yzFRlAWn3kRKLOCNtc6CltGrcRKie9HAcYF06C8Md
         0+E/VqKJVzY3yo42Xf/F98F9dezedr0z0yXMY4REe+jgx2X5wWvN2asobDLpDZ59DyeM
         5qJUsdKKynr23F9asSjQnFsuVB0rUV2fGP51QWx6/YPvbgpQ6D/LuWYs5QZ2MfvG9s9j
         PKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731789; x=1751336589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wC1UYON7hcM+s5zpfKbC1ZPj9/+qK5UO2VBeIZXIz0E=;
        b=pNOPHPbjbiIaWOnxcECZT9vf6uK7qJ7Otm20reeX80xnwnMl3o1NBZucxNtEeQcYA5
         jIzpcb/oJ91qvTzgIj2flkFxcsrBGZOgR+XkFTh77zBYAZE0acmM52gU5xZ0B/kHNrOc
         bo7Y+QyjATZFk3TcqLMwNtkRI/63QsGO/T03iD0UM2hvX4wGhpKDLbmIQ+fUaSG8OEV5
         nzn46ywXMUM0LqpDLYnozGaS7aSqEoS2uPqZ1REUVtxoPFjyOkqq0N5prtYY+lpuSRmF
         2/fc10XvYodE9iDOBlsMIKRx2Nz2iZiLDNpWrcBYmur4H24fbP9XVm+jnYKEsfsnn2FL
         po0A==
X-Forwarded-Encrypted: i=1; AJvYcCVRrAuH36XcPB8s2bbDQCIu5T7fAKUU2AoZiPse3D4Mzje2tNWJBLBY1DvbyaByZc+UPXPi4D8PtjI5kw==@vger.kernel.org, AJvYcCVv2lfwyJ8Lwd+J3YbTU5+zqs7O4tu4qLHql+OvLCkkymzKsVU1KyOWaK4/6nBJ7o8OvlQ3eotYtNzs@vger.kernel.org, AJvYcCWfW4Oer187iURtFdwd4ZjLsMpJXLKuQLhc14l5rV30Mdkw3nFiT8cM8cY2P2Mg8gr27Rm5JqGNxsz9@vger.kernel.org
X-Gm-Message-State: AOJu0YymPi9hqyOabAfo2gMpQNbo1hOz6gxBn/qcvHNjHqILqEA3nOwt
	Com69aaf3OeIOQ4YymhKTfYrvfsND+6OJvDinlxG0NNHW30YpFdKOG6ieQchqA==
X-Gm-Gg: ASbGncu40NqUr0af7XIFrB76spSCg+FS2KLLyrgySxazLdspHLNarHgGmZz6joN8CqA
	VrDxeIn8CTgrHY0DXTOQamLu83LV+yavQ0DsJMhwHQzqgc3l2455dZwIJDw1NNW5CIRx2rzmwv2
	Mth0ogzcTsHFASRkqWEu3Dwq+Sq4bRqYD2NoS3qLBfsvpZoi4RsQnp3/XhClrbmJZ46giToZ8iw
	hsfuiT6d3Qrhd/yxfQEi5U5XE1RKytcBT/XkkfidmElQk8Zl7tAoGG0gM+X2EhtPffzeKnDPSct
	1qaKGycB9QVpkXtXZl+oIXt8iRWEQmyn1AZS0yv2i4eYecnJxbsuUMPc
X-Google-Smtp-Source: AGHT+IE9dVRe9OSggKmdFWeyGF5nhQkVROL7+L8HQgoSpB0UZLST5XDNEs2KEP5cexzKVClOYWSy/g==
X-Received: by 2002:a17:903:1b50:b0:235:ef79:2997 with SMTP id d9443c01a7336-237d9ab5f95mr192725555ad.47.1750731789069;
        Mon, 23 Jun 2025 19:23:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86635e0sm94530875ad.157.2025.06.23.19.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 08/16] iomap: move folio_unlock out of iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:27 -0700
Message-ID: <20250624022135.832899-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move unlocking the folio out of iomap_writeback_folio into the caller.
This means the end writeback machinery is now run with the folio locked
when no writeback happend, or writeback completed extremely fast.

This prepares for exporting iomap_writeback_folio for use in folio
laundering.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c6bbee68812e..2973fced2a52 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1656,10 +1656,8 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 
 	trace_iomap_writepage(inode, pos, folio_size(folio));
 
-	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
-		folio_unlock(folio);
+	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
-	}
 	WARN_ON_ONCE(end_pos <= pos);
 
 	if (i_blocks_per_folio(inode, folio) > 1) {
@@ -1713,7 +1711,6 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	 * already at this point.  In that case we need to clear the writeback
 	 * bit ourselves right after unlocking the page.
 	 */
-	folio_unlock(folio);
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
@@ -1740,8 +1737,10 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
-	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
+	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
+		folio_unlock(folio);
+	}
 
 	/*
 	 * If @error is non-zero, it means that we have a situation where some
-- 
2.47.1


