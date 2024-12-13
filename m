Return-Path: <linux-fsdevel+bounces-37386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8D09F190E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B68161111
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F11F03C7;
	Fri, 13 Dec 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjDoXQCH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83A81EF092
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128599; cv=none; b=QnNl8nh73PS5lQY2/C0/8Y72uKnZmEXNmKhBWQvnQM4/xR3RXjEP4G3dX7hPuj6F3MEN8S7CxshhW3wGEwrzpUm7v3mOx/PkGqCCE605cqsaqRAiPAyJLSTWWkxkazyc5/JdvIV4BJNcLOj/kwxUokKj+QkhCJnH/YnAbl3nrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128599; c=relaxed/simple;
	bh=vGuWNMd9Ib/cFZq80jhsH60FNBeXmQMhp6UNul6DSzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4KRYXwxNf6XWqbc3cT2r5frfux/9SJMGfjwlxrbuwu8d8Sm08zuBuh0UF9BVz48BnCL4PaG3ye+rHw1hp9ybycRNtQ3ZIpTZvVD/0Lsd5VomtDz0s7z4mNbGL4iQ7IJWGlIR+9MngzaUmb+/V38X3tOr0UecC+fo40WzdIqJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjDoXQCH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e479e529ebcso55944276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128596; x=1734733396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MsqCNiS2Av0AT1F8h41t1E+yEYBskSEeM8QNXjZ6xU=;
        b=jjDoXQCHFULretiK9+czNJT/acEnB9pXG3fMUpgdQr/AeWUEbCo3gUGkzZzquF7yem
         O+fx93ZC/G5ywlShAq/5153IGThgmBnMh/Ds5jkrz4rQqJaqsJz08VcLvAKIFYG7pjoV
         Tc3K/rD4p2uG4ynB7ku3QB4qrOwuqUZB9lhrdRTdEVwpazmAa/8f+A9TOQw3cPxZs4nD
         1SWgoxH3aD5NmlBChsRUMGHDE6+0NmIjhRCnhpOYN3FHqWh2r89WPJA4EXwG5ntPIBcV
         +XnY3NzbxeBNyhbGpwBPtRZGRVlP1qrX5WxjyhzcKE4xtrKRWoYnB7OrOY7ksDXLXKBS
         grJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128596; x=1734733396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MsqCNiS2Av0AT1F8h41t1E+yEYBskSEeM8QNXjZ6xU=;
        b=I6fbTbAZboBixW15aHX/Sy4rSIxDvCr87h8pRfZybTmLVmlcIjLtKdm83xbm9vWfWC
         iTy4ja+Om6LujW8+UP7e6WTE8OQP+GhC814vOW25t9g8weDJrsBMAGNBEEkN5lsJiP2i
         yWyeHFOulaC602uGPDw8TWV8rPycnrXGIuLWmaTMHXYaOMVMjxzWuqXTJPaFGFfJxCw8
         RGrUhEzw0w1rNNOP41voOnnQu0yraz4OVMMe4gtIIwaMg3LbdhvBpm7dzKJOXr/TUYos
         7TrFjxAI7laB1eHF4v08wlN6fiI46uOZ6Ozh2zQVH8qNpAX4670lFXwOmhrx08HQA8A0
         5lQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKUJiJWHyVRM9B9Gd1AOITjchZg1P0TYKmmQZMfedd64IitlFzc7Pp9eLFLS/HM0XqMvYnTob5Go0c/sWv@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjmqVJHT5HKSttuCxr1YUJaQuqsvtQuIQHfxNcNTWmGElv+eM
	DeWaW5gRLjDGqeFup13Bbx8vi13OtULtECR1d2D3Lltn8qHR7Zxeu2pQvA==
X-Gm-Gg: ASbGncuyi7x0DG+fjLs0k1LTce2oVId3mVZ2Q67iZtTujaycmZ+FGYNEaiDWkVWfy8W
	rVSPGdQLF5iU19E/01EilBu17swn2HrzqgiJonMVte9sRgFXmczpLHiGSx6noNivWfcE3FcqfVI
	LbKybMLe6zL89W7BrljHyjdUkMPzA7fzRBl4DJMXx3jq7SdjQR/eCEcE0FgJuZZsyl1bDNpdViv
	1XdUCsbkMJ0eg/pD93GOteOBTOmL6/OKUkUgTi+7HXxg33/hgukQ+CPcMKU1paWHY3E3ggLZqvO
	BpjlBaExgcl50YJC
X-Google-Smtp-Source: AGHT+IGSYwVJaHvCGLatrC96YAV0XveT6KpNtTsqkXNH1d3P555qwSW1ANOBfV0TNnMpWUcrXGjUkw==
X-Received: by 2002:a05:6902:1893:b0:e39:8b24:65ee with SMTP id 3f1490d57ef6-e434e5e390dmr4024599276.40.1734128595749;
        Fri, 13 Dec 2024 14:23:15 -0800 (PST)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e470e54becfsm106386276.52.2024.12.13.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:15 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 07/12] fuse: support large folios for stores
Date: Fri, 13 Dec 2024 14:18:13 -0800
Message-ID: <20241213221818.322371-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for stores.
Also change variable naming from "this_num" to "nr_bytes".

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2a2a5e66412f..791688750caf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1655,18 +1655,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
-		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_segment(folio, this_num, folio_size(folio));
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
@@ -1675,9 +1680,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
-		num -= this_num;
+		num -= nr_bytes;
 		offset = 0;
-		index++;
+		index += nr_pages;
 	}
 
 	err = 0;
-- 
2.43.5


