Return-Path: <linux-fsdevel+bounces-27443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DC9618B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6991F24D16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAA31D3644;
	Tue, 27 Aug 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="b6l7dLO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA1C1D363C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791585; cv=none; b=dt3jFopa3SG6q2NEQfvn16opxs7bMEibv7lyUIPaUZgyjYqFFdd8P/8BHvfh8t7pFpkdp25EzauWvlCkQKj0PbTF9nJJc77YT/KXNIRlhnBRzwzBZlxDGIFoqpgkclYje341XiRTVXB5wadcjCuzLbVJ/IeWmrbkcdLzZhAfS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791585; c=relaxed/simple;
	bh=68tGStDSDr4B8RKeH/KjbTEzVenYeDClVq7NfNM+F2s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlHwW/T+Fq3IS/n6hvpm3MLR/KNZewRg5JpM0gvbXVGKzO2MoVeVx3NpeLstUiVcv1UIyTSjTjDjWsJx1cVXhf3NG2xeSVdoFUNbI3jcng0GZUI4pN2rTC6K8ZTJTbJmgjNRBEEXcO0L6zlmoaxeBExiDdolKHDkpM0yQJkXMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=b6l7dLO7; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf7658f4aaso31385706d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791582; x=1725396382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vs1wV5bOQctoxrXYwauzmoK2OAvZj6QgRF9kCz24XjY=;
        b=b6l7dLO7d2NyXWx/8q6ZEttJ/ZV2ixRRV5EjN9S4lGiv2/1VN5IpeMa6QTS5qlzJrq
         a5Tt+5sJX43pH1sQvpRYKty44434+WJ8xH1V6+RAR6mlmF3Y6tMeSWaJUt7FjXJlApqP
         JqfAQY7i+i1SA5CiDXt67d3eP0ye63wEVye044+ZKupifZdj+N+CE6ig/Am6DMFXKvt9
         lY5QM4cOkY5Mh6Ex1k5YDPBqQy/IkbGPH0Un8RkvSrXuFFB94KS2w6aOAPhULCN65PJV
         VPcXnUoaEDy0OCyJkxgYLv6Frf/3NCAgZI24L4xdI4QsTQbU4tRkdMWQra3Gs8FCZFQk
         SabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791582; x=1725396382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs1wV5bOQctoxrXYwauzmoK2OAvZj6QgRF9kCz24XjY=;
        b=Xmn5Kh8mtvBbQA6Rbz7tVUfCdTRU66vz/Uk3p1SwKQIH65KgEihpuKPaNzppMMYNvi
         QAQd4HW6rb6YSRkDQOxK21LqRp9owhvYz00uAmh5n+oczmPy2DzzPRZoztuFxp55I71k
         HIzKpkvauG6gF38FeLbgZjNQhbGagh6rOZ6Ds7zOOophXbZ7PSeZV71PG+D9Ds+WbWuW
         LBXUaMrU3PEcCpNQYbCBJSj7ixKvlHkstP7O3Br636Lw07+WNp+jbzw5zunuhLgIl/ab
         l9QIjKAltYDTKNTTGkEL3XKDMhmrYwbpTdRFSQ49IWymrFiidSrBf5L4/ZudrPw6p51/
         Yjnw==
X-Gm-Message-State: AOJu0Yw3l+SkYpa5ogkxwqblc2yzQHjDEWtfCP6SEjXfSPDjd/8JR2P1
	1uq+gPCcRslYDXGqu1g7WR+wyTuSXYQHaT4jxxA7r8JbtSIHrn3IzOkqO8Mk9poZET04MHd0G61
	Q
X-Google-Smtp-Source: AGHT+IG+qlqHgHHFueSkGn3Mpz+5wodyk8UOgG4RjhEPTZyoySHysR+g70Vx4+Z9dkC/WHLClxTwWw==
X-Received: by 2002:a05:6214:3205:b0:6c1:5546:8acc with SMTP id 6a1803df08f44-6c32b677e0amr58190326d6.1.1724791582084;
        Tue, 27 Aug 2024 13:46:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d21759sm59238186d6.25.2024.08.27.13.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 04/11] fuse: convert fuse_page_mkwrite to use folios
Date: Tue, 27 Aug 2024 16:45:17 -0400
Message-ID: <c78bdec10daef5268607a88c656667ad42c3482c.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cd3911446b6..3cc1917fd1b9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2534,17 +2534,17 @@ static void fuse_vma_close(struct vm_area_struct *vma)
  */
 static vm_fault_t fuse_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 
 	file_update_time(vmf->vma->vm_file);
-	lock_page(page);
-	if (page->mapping != inode->i_mapping) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (folio->mapping != inode->i_mapping) {
+		folio_unlock(folio);
 		return VM_FAULT_NOPAGE;
 	}
 
-	fuse_wait_on_page_writeback(inode, page->index);
+	fuse_wait_on_folio_writeback(inode, folio);
 	return VM_FAULT_LOCKED;
 }
 
-- 
2.43.0


