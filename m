Return-Path: <linux-fsdevel+bounces-36355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B89E2348
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8286286E8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32FC1F4276;
	Tue,  3 Dec 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ssdLS1LP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E01F76C7
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239970; cv=none; b=VDk41p6rpIpDKsOyTRtunlkIPxA7le1I82kq7u8QSewZ0WwNQxJCQZJUYD7IHExd66yzEM2PGibFgLbe01qxcSTP03ajcMdDL0cWzLkqfeo2+XuwfyaLYzfPknrofHZIHH/6I+FZ8PGd29bj7OKBL/BSTywm93FH9rASrXUYkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239970; c=relaxed/simple;
	bh=89Ccy3GI5ZUKxFiNR9lyKoxkgOUx6zEEiBrhRigykbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rddwmrrk79piGPTMSiMvxdgg1rRn7PBSdZCZ1LLrC2zJPHbzAiREPcNzDc02uxxbvDGFejdDRpvHpTWcNoZww2nujh0ZNzkUNfpQHx4l2JcV0M26f/os8GD5j2w23lsEphVtKkVKeK4cMD7u7g12HbHo+G7Mu+1+NZiK7m3YI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ssdLS1LP; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea55d16d73so2002513b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239967; x=1733844767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReI+Zr1x7wQ/SlfmJGhzAq3WrMPRqrYdy9B8AN1mepA=;
        b=ssdLS1LPBUHL1S31Q32Y/smkGXM0559dx9pYbkyDBWJ7eY6YZD+xY2uqJAfV12RuVW
         xwtblMjAy2gaeg7xJ3mkFST5v0G+JzIFu+gF7FWes+8Q7MPyarpDkxEWlN68cx39P79p
         qjZbtmWeQiUaON9nakCBeBVepmGECBc+cSpKmS1pPqYlRb+My0DohaccrNIzgMocBMs0
         BERVtEJ35+2veCbgFwsQISDue53j3fIhlrIk9B843TKalWJPW9LaX+5PkTmNnFHdFkKf
         BSbv+W/kFJrSiXxrJY/NJvfPwSfbmL+9mK/81i1/r5v5p7J86z08tUOY9ObHCH7ng6e9
         sroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239967; x=1733844767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReI+Zr1x7wQ/SlfmJGhzAq3WrMPRqrYdy9B8AN1mepA=;
        b=b3exVnDMp/IOhHIDjd3iXAsXvMKnv5qXwhAcrafsuM/t2/OcYThj6DzSTKwVido8OP
         gj/r0jMOiaCkC4uFA2eZRKlQfxpvMg7/rgsbJx7pUjghe3bU/shUAx6/x3jU4VkE6wic
         uVIiZb08fkP1yyFytenak6i/X+6BCvnsgA2TFnOTbh9XVeULnQgazTB3t4NTfdWRfWFC
         ILQsCtADa0rrYg3r35YvZ2+vRKIQGHJawK/Ra0KbRp+UpQIeMs8qmsf5vpPBji6HeASU
         qz1txB/HCe/nR0mWLUcr5UuPgt6tZmTsLOBjT4TgV/4SiS3bU7JSiS+dQuWkx+EHN3zQ
         AusA==
X-Forwarded-Encrypted: i=1; AJvYcCWdC8B6ALR9O0LfPAkyAJ6XPBcX7hVr7XM7YSbAtOKB2UrVlm1AhCKycTd0aSKCzC8wTRTurvJkYEw3kG5X@vger.kernel.org
X-Gm-Message-State: AOJu0YwDno7JiUHPutmfbgqgLYnJl17EZ+y0EHpZDlICzulsdd3OyvX9
	hoU4vDGDphmp5G8qZHHXVXT7ep7At9m3BF7MLgyClFijjJn6rvfFktqMPo8Hfog=
X-Gm-Gg: ASbGnct5Iitw11Su7NUpI3cTMHaX8Ta/pTe+8e4Bg+w9E+hWQ+f0ZMN7ZMRxkSjiAWJ
	pcLDOwlPdR6hGKgFdBYAM7fo6faI1t1GJi2ve0VIC8FdU+5KRwXh5YDWnmsxJ/pyc/z2XTxb4NK
	PI7kaGdJANodycjI4RdnI6s+3iCexe/Gsus4rVe1kzYE4DsaWqQg2kFGxidwx2HnYx1yn1Sm4wB
	T0UbL6z79AvlUXdKeqsTEfNxSDrzd1RoIycFb0U2jYv3aKwgs7m2E9h4oo=
X-Google-Smtp-Source: AGHT+IEjGwc7GFJjqyvYWDgJBqgGGBcMfQCEEJJRf9YUZZ1W6BgQFHNlpJWElLeXDmEpw+9XPHnUvQ==
X-Received: by 2002:a05:6808:1406:b0:3e6:1ea5:6b30 with SMTP id 5614622812f47-3eae4f9162amr3792647b6e.24.1733239966815;
        Tue, 03 Dec 2024 07:32:46 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take a struct kiocb
Date: Tue,  3 Dec 2024 08:31:37 -0700
Message-ID: <20241203153232.92224-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than pass in both the file and position directly from the kiocb,
just take a struct kiocb instead. While doing so, move the ki_flags
checking into filemap_create_folio() as well. In preparation for actually
needing the kiocb in the function.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c76a123ba18..898e992039e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2459,15 +2459,17 @@ static int filemap_update_page(struct kiocb *iocb,
 	return error;
 }
 
-static int filemap_create_folio(struct file *file,
-		struct address_space *mapping, loff_t pos,
-		struct folio_batch *fbatch)
+static int filemap_create_folio(struct kiocb *iocb,
+		struct address_space *mapping, struct folio_batch *fbatch)
 {
 	struct folio *folio;
 	int error;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
+	if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
+		return -EAGAIN;
+
 	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), min_order);
 	if (!folio)
 		return -ENOMEM;
@@ -2486,7 +2488,7 @@ static int filemap_create_folio(struct file *file,
 	 * well to keep locking rules simple.
 	 */
 	filemap_invalidate_lock_shared(mapping);
-	index = (pos >> (PAGE_SHIFT + min_order)) << min_order;
+	index = (iocb->ki_pos >> (PAGE_SHIFT + min_order)) << min_order;
 	error = filemap_add_folio(mapping, folio, index,
 			mapping_gfp_constraint(mapping, GFP_KERNEL));
 	if (error == -EEXIST)
@@ -2494,7 +2496,8 @@ static int filemap_create_folio(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_folio(file, mapping->a_ops->read_folio, folio);
+	error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
+					folio);
 	if (error)
 		goto error;
 
@@ -2550,9 +2553,7 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	}
 	if (!folio_batch_count(fbatch)) {
-		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
-			return -EAGAIN;
-		err = filemap_create_folio(filp, mapping, iocb->ki_pos, fbatch);
+		err = filemap_create_folio(iocb, mapping, fbatch);
 		if (err == AOP_TRUNCATED_PAGE)
 			goto retry;
 		return err;
-- 
2.45.2


