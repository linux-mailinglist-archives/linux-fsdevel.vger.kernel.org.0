Return-Path: <linux-fsdevel+bounces-56487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BFB17A96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F574E0DCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839E1B7F4;
	Fri,  1 Aug 2025 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cov3WNdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8FB1862
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008062; cv=none; b=p1mc/bzzn3zjkiDlxGgJdN9sadcoh6aeddUjgjrp47+z9BpHf/0V2fdD5A49uv+xqVKZ8MKSVWpW+HzTwTzxMybXHFDRhhAdGVjHuL69M5P3HFNLEinPMrd1FlJySq/1/O6ujWYnrRDtvZN+XDbXPMT+Q5qoMWRgZ3OOpex+gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008062; c=relaxed/simple;
	bh=dLY6EaywSg2BY/xVrgTSvBDG727NYLCskz/eBKb9lQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5D23+i57X9mPgk5pjN2QHWHYyBqX9KisSngCcfPeyAfcDifqq62icHTAjblZuDQ8vZCpgLg30DDjdRHx652ChB4odJUYbJ708iFgcULCRI+aeB1KqGfGkJUmtOYluiE9DPgH2pTL2D43PKDGomDWoTgvaoW7pPJKyEgDF3zmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cov3WNdM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2407235722bso16281885ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008060; x=1754612860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M9kpbvWLnUIwwmNXFmwuD4lxN8l5bhfEtnRPPDnoy8=;
        b=Cov3WNdMSZD9QXiyxO2PkuNrkgFAkhoa+/ha057tGHeISMwE83vB9eDpoSHpBuHDtM
         8+vST+14MyKgv9hVL6ES54fGU7+k6QRKMUKycj+3ctf+rzk9v5N7gONEBM5Bj5mUK+WS
         gTHVLvhPQodEhG5vMdf6ENMcKC6P1W3JQb3Hwt7CPbQt6h3tmlC2MXGh1BtySclYL/dB
         nEDeRfsdepO+pQ4Yhe25JesDtKS0tMbfP3DiEQETX22o/LsO3effS3/JwgFmtNtv4qOW
         Ue51Pvw9lO5d0PqHlL9Sms/x2ZY171Qx2dw+cc7MNH+KyoE+0mFAVx+S+/d7/6wnBdMt
         coUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008060; x=1754612860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M9kpbvWLnUIwwmNXFmwuD4lxN8l5bhfEtnRPPDnoy8=;
        b=sShx4zbc6YwtIzcoBj3L/8cPmTUrsHjFW7jDxUReIghHJO3LTtZLyUXAGsyeVNVSW2
         1l5fhcAyd8Iy9/3JZ3NEaEDk93sMptqTAGN+4vnUffN4VucknnoWPlV0PYhAX0kqwvv0
         /7pZWhY1ivRMocD7GiXd8Jg1kFoe40sVoF6UYkztnv2R0xZA8AJGPybLI2YCEkDEeCzd
         nRb2Uw2wcTLGlmCaPqn3+bXpCnw6CquNeXGVmWaiv65gqFMaEb6Q4CJrRWpyLlZryV8Z
         nwzYmjz8jPYmbJhr57vY9xHUUIUPqhu1VN5qbtUEmmPoLPKkLj0vKqn4uL/vpHVbs6T9
         UldQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9xYPXsp6Jit1M6ihLIPKTSHxEUuiyt9ThdkTz6B/hv1pklTnB9kWKSlnXvSpptttIjUI1Hjbq3aRYQ26m@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9lEp0A9Ri3wy5WMV5SM1eQ7uc7LmDhWheZVfbDPZ2YM2j+6P
	+SWEMc5aq2fJ917Ekp9RwVHtEwszX7L8qVkkE+0w6xgh50XVaa3+4K9z
X-Gm-Gg: ASbGncucT1zpgxkUnlQVprMOToFXkNmft3S5+E8W6/AF206XyY9Zu71J/vmZekdLasK
	ip/G7yN9BmHBncF6aM8B2uPGTHSXvkzMuLL3UbnZWKHhDhXgVQJjXpdPGOgNILvNT6NUjLpvjnG
	WNioaSRzXjPaPpAeRNkdXyhelcMZXwt16CzPj+F+RbXwhwg7T9y8rpRDSBJ8Dcts2wkPkpgfEMJ
	x7pxlLB9w38COjt92tKmheM02qsTobzRab0JBv/Nj13z+O9pQ3qQv4sz43u8nIJ8XUxrjJpj72i
	mXSH5HV8XG2rNovJ082V9bHKG/bpqNEgWwrwcNLT9DH92ukxnN1QtLMnE9FreHIwZbv8B42+/Pw
	TQStNwyzsN2VMRruFqgYHKWaKkv3L
X-Google-Smtp-Source: AGHT+IGXKNA4I4oXYyWsYh4tjw8Fd9GbxeARJl7o9bH9bPXWfSgwrWVxmP2wI/PZg07/kGHCuMW2Hg==
X-Received: by 2002:a17:902:e78e:b0:235:ed01:18cd with SMTP id d9443c01a7336-24096b2f89dmr146079475ad.44.1754008059880;
        Thu, 31 Jul 2025 17:27:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f6b2sm28484605ad.54.2025.07.31.17.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:39 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 02/10] mm: pass number of pages to __folio_end_writeback()
Date: Thu, 31 Jul 2025 17:21:23 -0700
Message-ID: <20250801002131.255068-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an additional arg to __folio_end_writeback() that takes in the
number of pages that were written back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/filemap.c        |  2 +-
 mm/internal.h       |  2 +-
 mm/page-writeback.c | 13 ++++++-------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bada249b9fb7..b69ba95746f0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1657,7 +1657,7 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (__folio_end_writeback(folio))
+	if (__folio_end_writeback(folio, folio_nr_pages(folio)))
 		folio_wake_bit(folio, PG_writeback);
 
 	filemap_end_dropbehind_write(folio);
diff --git a/mm/internal.h b/mm/internal.h
index 6b8ed2017743..d94f3d40cc66 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -416,7 +416,7 @@ static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
-bool __folio_end_writeback(struct folio *folio);
+bool __folio_end_writeback(struct folio *folio, long nr_pages);
 void deactivate_file_folio(struct folio *folio);
 void folio_activate(struct folio *folio);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2e6b132f7ac2..2afdfaa285a6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3008,9 +3008,8 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
 	spin_unlock_irqrestore(&wb->work_lock, flags);
 }
 
-bool __folio_end_writeback(struct folio *folio)
+bool __folio_end_writeback(struct folio *folio, long nr_pages)
 {
-	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret;
 
@@ -3024,8 +3023,8 @@ bool __folio_end_writeback(struct folio *folio)
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 
-		wb_stat_mod(wb, WB_WRITEBACK, -nr);
-		__wb_writeout_add(wb, nr);
+		wb_stat_mod(wb, WB_WRITEBACK, -nr_pages);
+		__wb_writeout_add(wb, nr_pages);
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
 			wb_inode_writeback_end(wb);
 			if (mapping->host)
@@ -3037,9 +3036,9 @@ bool __folio_end_writeback(struct folio *folio)
 		ret = folio_xor_flags_has_waiters(folio, 1 << PG_writeback);
 	}
 
-	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-	node_stat_mod_folio(folio, NR_WRITTEN, nr);
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, -nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr_pages);
+	node_stat_mod_folio(folio, NR_WRITTEN, nr_pages);
 
 	return ret;
 }
-- 
2.47.3


