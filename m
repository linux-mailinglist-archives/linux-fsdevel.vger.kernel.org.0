Return-Path: <linux-fsdevel+bounces-26937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA195D356
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB391C23221
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF55318E038;
	Fri, 23 Aug 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNF1cNgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5C18DF81
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430467; cv=none; b=pjTbKxrk2rmhLV/SBzhM/myTyv94WU0mCRlhtaVuMwkKqdkT6v5752By6x14+C2BnrgQE+wmbONSVLziEcScaOT/8bvcieVcqdrgI2i/mPWcdUzL/FvgjL3rg+Nlt3s4AeFu4A6ozgtVnmC4znsW81ZJkbDj7n09cns7w7RkavQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430467; c=relaxed/simple;
	bh=BCWLaokALe3n0fYU9hV7T1e4BPVGraqKKewR6GbmZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flBpKmHrJC9cveE3ewN3Gzq8TsNKjthp2RpjQbIYeGtmj5P6nARUsfU/YoXOh8V1dW++anDXx4pYjHJLf5uLlNyzdb4/laFS25BrZL1plsI8gAt9eIyO/HsOSXF+oUeik2e0O3orUJouLe19QGzk53Bb73nFOwSGxQUkBSb4M8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNF1cNgD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-690e9001e01so20669727b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430464; x=1725035264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK5FE5FzMMbXdXMgVp7PugykD5NwuMLOFm247vIYHks=;
        b=VNF1cNgD0fpHj+Ie70uHRFl67PweN7qC/krcrHEx5IK1KOrsvz7ldTIWRcwzTyoILw
         mirA1i9EkrmLRT0G1qYyU6r5t49czRL3s9ilJbQWrL4oRmlH+O6HllOg4In7VQ8ckmmT
         QSwWJoA8nb6Fpn8Zs9cQhuyY86i+laByLVgobD4VWMrCelclb8+VQxsL9H1LL47NGfZA
         qNDUMQeJMKUum4UKaqm1N4Z+Hob3sdw1ok+ID6PJplNiYg7y5CreN7wgLRr7jz/TNrVI
         cP8jQ7wnErArKwFIWZaA0mBU9gJR1+W7cteyaQnJfrzABmagN7ZbS6UMyOFhRYzkknBg
         axkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430464; x=1725035264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK5FE5FzMMbXdXMgVp7PugykD5NwuMLOFm247vIYHks=;
        b=IFlMWXXki5mCoO94ZxnTfDaRRvBGEyLjTNbYgcZ6sa8HA+qPP4pp+d1ZoUCg0pPtHf
         6rCLQz5XUHEPgKJxSNYC4UwvhhgfaHg/IvAe56f4Z/YWNnVoA5eDBscMm7oKE+ov9dn+
         0T0jve8gBwiyUdT/YMhwRd7SkOeYKDs/kHUzXkA1733x6AFV4S8VtzQlys3P1ezmGCK+
         Ro4eMja/vqjywB8kDmAWcmAvK06qx8Bg0gfS4EqOJplxacfrRjMp6e9W4yR7C4m8faMo
         kxUdto9LH/mg2IDiMTFX3YCjzjMA6jljhr2gYnl7p5fSv2zFCmdZWxPKRfBz6i7Q2nGD
         +srQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+1cq2ju4XfKr43cWmQ8curaOo2QHXhzYM7uKx3cSa1OpT8e9caA/27yV2WAbt3QN0yxjUokPhUg0lfUkV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+gFrXQ65JdpfosSk4Hczq8m+vLk5Uy+8U39psYogbVhKAWC7N
	/jUBZJ/Z8453oP47veHST1BDhqbOUhcTrAw5K6GgqI/cd0hPwtKx
X-Google-Smtp-Source: AGHT+IGz9DrHln8n6qHcuIfMa2t6x5H/LbEqkdj7XHRQrPzK5I3EqxLujVA8ryJ4TkjyT6weJC9L0A==
X-Received: by 2002:a05:690c:5888:b0:6bd:7eb:7192 with SMTP id 00721157ae682-6c6268bcd4bmr22304137b3.25.1724430464600;
        Fri, 23 Aug 2024 09:27:44 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007afcsm5938457b3.72.2024.08.23.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:44 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 6/9] fuse: convert fuse_writepages_fill() to use a folio for its tmp page
Date: Fri, 23 Aug 2024 09:27:27 -0700
Message-ID: <20240823162730.521499-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pave the way for refactoring out the shared logic in
fuse_writepages_fill() and fuse_writepage_locked(), this change converts
the temporary page in fuse_writepages_fill() to use the folio API.

This is similar to the change in e0887e095a80 ("fuse: Convert
fuse_writepage_locked to take a folio"), which converted the tmp page in
fuse_writepage_locked() to use the folio API.

inc_node_page_state() is intentionally preserved here instead of
converting to node_stat_add_folio() since it is updating the stat of the
underlying page and to better maintain API symmetry with
dec_node_page_stat() in fuse_writepage_finish_stat().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a51b0b085616..905b202a7acd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct page *tmp_page;
+	struct folio *tmp_folio;
 	int err;
 
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
@@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 
 	err = -ENOMEM;
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
+	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
+	if (!tmp_folio)
 		goto out_unlock;
 
 	/*
@@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *folio,
 		err = -ENOMEM;
 		wpa = fuse_writepage_args_alloc();
 		if (!wpa) {
-			__free_page(tmp_page);
+			folio_put(tmp_folio);
 			goto out_unlock;
 		}
 		fuse_writepage_add_to_bucket(fc, wpa);
@@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 	folio_start_writeback(folio);
 
-	copy_highpage(tmp_page, &folio->page);
-	ap->pages[ap->num_pages] = tmp_page;
+	folio_copy(tmp_folio, folio);
+	ap->pages[ap->num_pages] = &tmp_folio->page;
 	ap->descs[ap->num_pages].offset = 0;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	data->orig_pages[ap->num_pages] = &folio->page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
 
 	err = 0;
 	if (data->wpa) {
-- 
2.43.5


