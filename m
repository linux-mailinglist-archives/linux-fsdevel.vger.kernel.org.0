Return-Path: <linux-fsdevel+bounces-56486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BACB17A95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C481D1C264CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35098D2FF;
	Fri,  1 Aug 2025 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCYf5K2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138C8F40
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008060; cv=none; b=bNuxJ5hS20BAEN9LVr20CcAS5dvWozpdCRFMczMSTPo/hO95fIaSXzBHKOcp/YB/rRZvkBYvcGk+wUxKBsNFy/2LQgyZKb7U9fC099JqrI2EM0aTvwgpKpmat2xFDDPMJd8YxgVyrB8XqQyzxHj4LE680kY8KC40ACu2LmNzLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008060; c=relaxed/simple;
	bh=kazSFW5HclqA7MtBl6eA1dxNUaArGH/KM1Jv1QN6zqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2M/izYaaEUI+UjNW5mGvQX/h0tI4xwCc5gdNtqpTZErnImtedecgorm5+rmpk1FRgRExtxnHc2xZ+vHmiYj5Z8y4qV7jJXc1LI9DhzgXZhIPK5gCU8XluhqKo5JFz/UARWkuHZoDtYyGCRw1g1SQ+I1ozGc+8nLwhuMvEJWIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCYf5K2B; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so1028784b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008058; x=1754612858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5B57mseETpFTK2e/32JnZzIEdRNKgkoknISTtuUYAk=;
        b=VCYf5K2B63eGwjaXexd7erStRrmWhfOKRdRqPrqEKZeqCBwagOkhyvGIcuSQ4g1nZM
         98csOdUMTJ3BHyqmp/7snyWkxyydNeTl4e2alYIwCi8EG3OPgK75qQK0sxAGm6hwGz7U
         xxfkCDP2oRAnqnPwTdPlsRA+CgQ9w91BoPmqDq+kI3eLEL0pDKH/6Ts/av+M2IxMyFQR
         f9l+i8nIkGfBlnVByWusBwQxWu7i+9T2wzUiciYV4xLw45Iy2s1VjpGtBhCaMVpY9OVf
         73eWCK4JWuDGfEFt4LSOo4b/vAtpn/1CvBz5Z3KSSgZZgn1GauvQpYUNyoTaD1eOzYRo
         cPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008058; x=1754612858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5B57mseETpFTK2e/32JnZzIEdRNKgkoknISTtuUYAk=;
        b=CYhoHKDlJRRQtGfqZnux3sxEamF960PHMK4L/d/rqrcjQwmUf3GdIB5FcyzyZDVovG
         i6rWoBkGt86sHg/e6iEKx1gLgelkB7W6aQxoM9afTiOv9kLMRJXB6d+XSA3EnDU2jRsI
         /XhjDc0CKQlmtdAlovW1IZY0ePGOn7gGmmug+vq6DA/34/91Dpv8ScjF6bWgmepUbUQC
         GRubU0ADAWokVIPMJArvfRoTQpBuDb15QbNbCEoNP1Vhg5LGRvT7RjW0ya/uN4MDJ6dI
         v1+MIlGrQVeSCJ6yxtM4K6uFZ4FSwNJvcMTFYvAKjs4K2n0N8OtiMg/JnayljUoyhxoz
         eSRw==
X-Forwarded-Encrypted: i=1; AJvYcCUHDgcL7OoMLPs/cB24etY5y9VlYXvNki4VVcRF2aGe8GH69Dp/Ehg5Xr/snsdnj8pwR5PA6RzIVyMCoINf@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNIHqtH8mxnBJEJwTvueQrX+H+fcCMYX+Oi1qmqKuOxmkz6vN
	QduaxiNyaYASfC2ZabPqMQVCLWkW2js1nqqwXR2jSbzvC0nN8ZQ5Oe4bw9F9pg==
X-Gm-Gg: ASbGnctx2n+bKPGPFgKwn+fQxymwm1C/tM12lVc2S2zL2clza4nh81LdMMstztEYL1f
	ymMqu0aarFHABLgwGZFWPfb9oSVr5ZRlAp8AO7Lcd085gz6wxV25Kc1Ac+QZwPXXqdtUUB3H7mG
	TNJ4AgRKPwTpYVPzIR/rZpnOxp2EiA3xhgD/8+tEQdV9PcjLBrtZTJ73scEAtY3OnD6D/MH63cI
	nfEFb9ljCmHSp4n4+HkB1xoBvpqzz3JQi0wXIJLsd5SvjGVviTlrtFJgQWnuY3LKWXhdDW+eny4
	xA0AtriuIRZnuYe25VJ55k7j04F4yOHhGsFcopjlz63DN+Aun0AirzGqhiF4bZZ0UFEVtBQUyEZ
	DRWiuB5iA3OFhskP5H7yzjrBn0QQ=
X-Google-Smtp-Source: AGHT+IGd85tF/kHZ2d9TzwwdX0gJh7BUCyCttC3q9sNC0ospI7oQdPkh9WCQsdD2QQfSQq9fi+kfQA==
X-Received: by 2002:a05:6a00:1790:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-76ab101c40cmr10929375b3a.1.1754008058333;
        Thu, 31 Jul 2025 17:27:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcfe18sm2664208b3a.93.2025.07.31.17.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 01/10] mm: pass number of pages to __folio_start_writeback()
Date: Thu, 31 Jul 2025 17:21:22 -0700
Message-ID: <20250801002131.255068-2-joannelkoong@gmail.com>
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

Add an additional arg to __folio_start_writeback() that takes in the
number of pages to write back.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext4/page-io.c          |  2 +-
 include/linux/page-flags.h |  6 +++---
 mm/page-writeback.c        | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 179e54f3a3b6..b9ee40872040 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -580,7 +580,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		io_folio = page_folio(bounce_page);
 	}
 
-	__folio_start_writeback(folio, keep_towrite);
+	__folio_start_writeback(folio, keep_towrite, folio_nr_pages(folio));
 
 	/* Now submit buffers to write */
 	do {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4fe5ee67535b..7ec85ece9b67 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -854,13 +854,13 @@ static __always_inline void SetPageUptodate(struct page *page)
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-void __folio_start_writeback(struct folio *folio, bool keep_write);
+void __folio_start_writeback(struct folio *folio, bool keep_write, long nr_pages);
 void set_page_writeback(struct page *page);
 
 #define folio_start_writeback(folio)			\
-	__folio_start_writeback(folio, false)
+	__folio_start_writeback(folio, false, folio_nr_pages(folio))
 #define folio_start_writeback_keepwrite(folio)	\
-	__folio_start_writeback(folio, true)
+	__folio_start_writeback(folio, true, folio_nr_pages(folio))
 
 static __always_inline bool folio_test_head(const struct folio *folio)
 {
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 11f9a909e8de..2e6b132f7ac2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3044,9 +3044,9 @@ bool __folio_end_writeback(struct folio *folio)
 	return ret;
 }
 
-void __folio_start_writeback(struct folio *folio, bool keep_write)
+void __folio_start_writeback(struct folio *folio, bool keep_write,
+		long nr_pages)
 {
-	long nr = folio_nr_pages(folio);
 	struct address_space *mapping = folio_mapping(folio);
 	int access_ret;
 
@@ -3067,7 +3067,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
-		wb_stat_mod(wb, WB_WRITEBACK, nr);
+		wb_stat_mod(wb, WB_WRITEBACK, nr_pages);
 		if (!on_wblist) {
 			wb_inode_writeback_start(wb);
 			/*
@@ -3088,8 +3088,8 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		folio_test_set_writeback(folio);
 	}
 
-	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
+	lruvec_stat_mod_folio(folio, NR_WRITEBACK, nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr_pages);
 
 	access_ret = arch_make_folio_accessible(folio);
 	/*
-- 
2.47.3


