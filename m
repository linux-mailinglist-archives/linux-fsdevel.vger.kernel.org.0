Return-Path: <linux-fsdevel+bounces-48779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F2AB47BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 00:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CAE4678F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C35299AB6;
	Mon, 12 May 2025 22:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQYcijHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B029A9D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090775; cv=none; b=PGLfKRbNWdqD+NyKdf8YbkomE3B/SBrcV4LF0N1tiaclLML16+m8TO9kMEhFLVb64+dm5f5+H04xBeSGJXzuSX0y8ih5l9OPz+R/10dgiW7/Ot6hugiVwhwNbACTfkWkNhgeLmcAE7mcsKwJGPrEC/Nl7rsn/vCq3xO/HPrytF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090775; c=relaxed/simple;
	bh=r4dkLb329DkNgPmk+dLCJ/fS3aLRefi5OO9+/s4IP/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtiG64VhfpDn/dJrF96MqPGCq6ma231DtXfZud4pIr8be7JVM5ywOMhm7Em8CQNKGNNhu3SW6ofE3wKKu/1icayp7DW+2hBqec/4W5G1eZH/9lcbIqRBj39TGFr0OYBi4fKn+rsIkHnzqoJoiwM2iZClSPWt2lzfqR3p+sDCjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQYcijHJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso6517896b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090773; x=1747695573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLtZjXZpCaGmXAucx7svU1g2FmPWjMKOdhd+ccYrpEc=;
        b=WQYcijHJ4YFF/4yQfIAATHik5TZpez9qIkLjZ9v4rdlK/sZfPM0RtobH6WSuJChHXh
         GwrQl5F2CK51NII+4mEj9U59J8GH32OeeW3xgh1WrTcuGRKg6NGCy43/4jrnSpfFoIkO
         eBjEyUW+n30Ey0EzkEyJZJdRnkVAHiwqzmkhictNYd78+RWOlnXW3qepxCpM+TJXIFJB
         6Ltw/BhSl/5jXMeHKXei/MRwohuoMfFXV+yikXx10/YiFUGwAykHju3/VQWeZTadBHRL
         +MVHHLYdbP4tOVaAp7L7HHmaLzWt3eqtKgpLqpsERc4Cq3zgLB5hoE035DFtfGx6po1X
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090773; x=1747695573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLtZjXZpCaGmXAucx7svU1g2FmPWjMKOdhd+ccYrpEc=;
        b=pMjLYHy1aP+wLaNy0zjIDibkkO2sSqAEYiW9+AwaWSfMD5/H+7usyAjSFYZdZvozzC
         zcvnQr5mcoav4Hzx37kfnXh4qf8UYt6c8LPd84AFBSN87D0oVlmu6ugSZF9PawMDrAkI
         dN4S1toSHHQFCqL32nQZKj2eTL3ybKAAPQsYjoHSs3stPbSYt/kou9tPIKc1cojGCtOL
         ir0aQYAtLDXyJaze8QzfPlGiVbpFYdv4cq1ONtcq7RqiTqzL+d0oVLNt5goA9i6KcfKI
         1Q6gleh2fAqw9UpF1k/gOpJfzhDOk5u1i/9j7+tLQSy67adVuH/ZEzpsxYsnhGGjHp7z
         0JYw==
X-Gm-Message-State: AOJu0YwNqyCrY45q9pfsBomF+PSgpIMr1Z6No1jUohwbG4XiVGT8C2qZ
	998k5yRtIoP8MGUB76vlXoaJwB962VAxrol3BGiFESLlfdQgh5Yy
X-Gm-Gg: ASbGncuIiE01M4vYvmpMRkduUNF/pST2CDfBQYNAxhDN7EqEi5W/sOAVJSjyLu51BPZ
	kWx1IuEZqPCE7qHLWehotNi670XQMjdM3DzFqjCCUTzNmK6Gt5Hc2/wxAQW/ekVnNPpPVYhVa24
	QYT3gjNP+Y8fP4YLVWsDRzC3QZEN7rUdDjA5zRiQHqEv0sQrolhG+3TDWmj34CaH9xasM39pMbB
	CMTlBGI1+f64GX6+v/1Zvt48vdAbJQ/8BUJa89nbbRCqA+mnSW6q4GNZe+lu6BFHk9phNjwsK7+
	6SRUEUGIVkZREGEYF7/6bLLd2Ipr2NDrRtOkJJMytsmcQA==
X-Google-Smtp-Source: AGHT+IFmabg6E9Jjyws+XocY9XmtLjzGmkR1ftzTKbJ/q6arLCwMrQb12xJOiYjfLjZ2BYeRrtbmHQ==
X-Received: by 2002:a05:6a00:a83:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-7423ba832c2mr19421893b3a.5.1747090773283;
        Mon, 12 May 2025 15:59:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2349325e16sm6293892a12.1.2025.05.12.15.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v6 04/11] fuse: support large folios for writethrough writes
Date: Mon, 12 May 2025 15:58:33 -0700
Message-ID: <20250512225840.826249-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writethrough
writes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6b77daa2fbce..2d9bc484e87a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1146,7 +1146,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		unsigned bytes = min(PAGE_SIZE - offset, num);
+		unsigned int bytes;
+		unsigned int folio_offset;
 
  again:
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
@@ -1159,7 +1160,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1179,6 +1183,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1186,11 +1191,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
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
2.47.1


