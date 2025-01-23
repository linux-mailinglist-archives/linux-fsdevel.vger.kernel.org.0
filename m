Return-Path: <linux-fsdevel+bounces-39893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE907A19C34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720BD1887C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2C2AE6C;
	Thu, 23 Jan 2025 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbgolBJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D261F61C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595692; cv=none; b=tjhKAgaDuonubK3iJJj9jtSSwD1iuI+82V+TGzR93ywZhdxzHcbBAkiUZGIQNVWIg31SYYUQ7ee5/e5uHqPhM8tnoExlAWKWEGiuZHoqEMFvVHNOabAr8TXDq75OQE8vUEtyzK7ZL7l4dHZbt+3wOnf/F2NhkXPf1XrfQ/L2b3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595692; c=relaxed/simple;
	bh=jnDUwYZt3z0RysXLnufPs3iHlGXYv6ybm4LXoFybwA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbbPHDKi4HksiXF/5pH+Wgvoz0VtTc9naVpcrRPcBEB7kW4Q8LCqsY4ZCxrTTGkMFflvzvP9j8Q1b0uzazdam5/R5Wy5e6iltuYlxXFh4tB6DnQS5FSoesItrnEBmGZ+C10FbhrgqeZYfgM+UDGmPZpgyOeDAWD0U5y2nmlGM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbgolBJv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e53c9035003so613193276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595690; x=1738200490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPHhZPkkOh3rgsYlEz/Eu75drHyoU6Q136E2ITdwV88=;
        b=gbgolBJvO7Cv3+356fW6vEoqzsIFmEdpggKq0Ccrrm1JCYM2jjd3wSjFqoNkgChJsQ
         YlxHaMvNV2zOlnmqrTdr+k40YQdzVQuI0Dpu6QGphrprd9zK45QhZl3n2TImKa4GNBc4
         0SUZwDnUN6o8D6OmgmNSk0tc03yodICYY8xRdnbsni9gzi/S2yxrnX/TyROoGEaFavc2
         ngQ1SU27hTp4gc+uFNVVSoBINjsX12YmrS/oIxIPlV1AjHirMQdKrjBaoZ24pdAObBxS
         N9+XoHVjSND69KvxtRl0S5fF4NfhbmQ56xyEHjG4aaSROX65aRGDD7Jj9N6MgJyNg2Bu
         Z/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595690; x=1738200490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPHhZPkkOh3rgsYlEz/Eu75drHyoU6Q136E2ITdwV88=;
        b=KVIWOwmQ1PPhGW9bisFa35TRqYg9CE/aumcKsaG/Ed5NI++0mzqILSq+S/wDBOdfvI
         eM1FwvrWgV79rx+CqnSMWTJg/u2bOnAVwCe4bUgA5OaY67xt5cqpgPJGdm5gtEsd3lKq
         u6RIxmKEw3N0zzig2CfzA6c6khyMCjTd6vPHTucIQ/LEduCnxZ9t+vik/OQwrYjnXbQR
         jfO5oR8ea/iGtrVIgTTPcHPJ5IjhjFBkqpq2FRz+QDD6+ZBw55hgPC6Z24v89JA9ZwrR
         Tg3FqwGVUbZf/eWDFQfPixeh46jma0JWgo6TGsDXwJq/xV2uDIJ79TSbXGkNgDs3V5uc
         5QxA==
X-Forwarded-Encrypted: i=1; AJvYcCX8FdWzI5YIcahvswkNpM5v45s9mdWksWnvhm6AD8G7JxtlNWoGPLzU9BlA+z8FMqp258qt0xkQocx09nON@vger.kernel.org
X-Gm-Message-State: AOJu0YydHiZBVJCZzDdISkgPXiivMeiAzs5UMba51tY1fO5a0gkCr3jm
	7DMriRcjZ8+Vzs6O1gnedVGG6KdVLyC7iKENVT4jGV89/6Rg5ac5
X-Gm-Gg: ASbGncs2uKPS+7y5Qa9gNWBAFbPExe7ho5YYbWdIk4bFKgH4kHtGytuagaeSau4j6G0
	8+L7kBLe6f25bEsviVZTFjmLg7mfTN423p0SKDvpwdQ8IuOlRTyoGldWQ4AIz2xoWz96jwiS9y1
	QAKD0S1/6CI3rQcBchwjQoCPOuK8Mnv7bNZUNEWwnCVzN0yRPYNt81oWjJGEA9qM+YLR0uHT4kl
	tNlwt7xwkZ5oVOxsB/xVdBE2XR9X95wob7rNhb+KdfQv768/bx4WbnG8cd4Dh3Oa3K4bRBYb6ET
	ig==
X-Google-Smtp-Source: AGHT+IEbsCGdfzrhi1b9fN/6eJiA3Neto5dMmVgDbYwaeIQQNRv/avmolqOIeerfKpij6HAoda5iiw==
X-Received: by 2002:a05:690c:6f8e:b0:6ef:7dde:bdef with SMTP id 00721157ae682-6f6eb9058b0mr182807647b3.23.1737595690249;
        Wed, 22 Jan 2025 17:28:10 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f745855530sm2614407b3.52.2025.01.22.17.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:09 -0800 (PST)
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
Subject: [PATCH v4 04/10] fuse: support large folios for writethrough writes
Date: Wed, 22 Jan 2025 17:24:42 -0800
Message-ID: <20250123012448.2479372-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 71b243b32f0a..aeed80bbf01c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1214,6 +1214,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 				     struct iov_iter *ii, loff_t pos,
 				     unsigned int max_pages)
 {
+	size_t max_folio_size = mapping_max_folio_size(mapping);
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
@@ -1225,17 +1226,17 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	num = min(num, max_pages << PAGE_SHIFT);
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
 
 	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		unsigned int bytes = min(PAGE_SIZE - offset, num);
+		unsigned int bytes;
+		unsigned int folio_offset;
 
  again:
 		err = -EFAULT;
-		if (fault_in_iov_iter_readable(ii, bytes))
+		if (fault_in_iov_iter_readable(ii, max_folio_size) == max_folio_size)
 			break;
 
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
@@ -1248,7 +1249,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1259,6 +1263,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		err = 0;
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1266,11 +1271,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
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


