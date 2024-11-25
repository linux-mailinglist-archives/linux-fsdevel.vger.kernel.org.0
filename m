Return-Path: <linux-fsdevel+bounces-35852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E79D8E45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A68728A4C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D31CD219;
	Mon, 25 Nov 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lenRvBsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CD1C3F36
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572364; cv=none; b=VzfeTRXf9x/msgzhj5DVs6l1aguuU67UVX5ol3BcgUDD8uiMm6SgfkNUra+t6UhXXYln4VXbnZ3nlRfq0IgnO6MKg0YqQUjzWPIS+Y5hPgZjFEMQME5LvrVYEDXxDeMduw3DYF924i4CbOubDcqqywDnzPhUc7uhPyi6ZY2yg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572364; c=relaxed/simple;
	bh=55qbSnrj4JkB2375Qk2GnwsuvJJj9SWJ5VUBMZ5acLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKgUi2CIPBPu5Ynjqx56ntEStGncyfabuxFfWIGdSVOkzLNORbd1dQ77Gi/Kfh17l/bTQDvUobiSYTxWNTiJUADXov+Wiaeg4sxX7zLJoJy12CSD8aGjaL1ZRskPk30m9N9nMjbqFwX6J5Lo1pajXXbY9zlqeiZ8OAQDxzmv56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lenRvBsd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ef1921383bso11350477b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572362; x=1733177162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5X+/GBIJEUOwrM2hRDnk+nYnGxoZZRK51MgHbAmHqrs=;
        b=lenRvBsd+WgbFUxiRr0Ua0nxOzfW0/wvWmlvFzkWMdSmcA5O4gsCPUizOduyCAKuuK
         tdZPnLrp2AazYchdRHy5Pq4lM/ShQ9YsQwOGRlLsd9eXz0ADqrA4owff6RTUCRlWsH5i
         8tEvyl0W6mBOcCPuWBr6SfP99J0Re68T5v5Qs/NX9kEz/GRxyb8/LkXMCyvxQtX4l+08
         GglmxrzCV4Hln79eH7QO1plwEpnH4IirAXGSuvGm5Ok4i6GdOU+nNXKJmwzTjzJ3QB/y
         i8m3XvB3YVmT/6aYhgyhdWXYaBuCivPAQ3y6IwdvXpbL3tbH6W+IyhrQavE76QISbYhy
         A3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572362; x=1733177162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X+/GBIJEUOwrM2hRDnk+nYnGxoZZRK51MgHbAmHqrs=;
        b=Vjo1FnpNJsWy2zhhlWGGMv4VFv/HMjR5N5XhlIbhjdkJbXNe9ofMI9oJho1bbbNpzC
         QzWKsJdO01bkhfPflEXbZsRRM/PbcalNDBgz8p2hmHbhuxuYpflb/HVR24k0lJqLw2eb
         KxpN/9sV/UQbgtEV9BNxjsGaA1/FADy/AW8tUH4YpQJQ1fGEDajz18PtZgP5yCsooFZy
         EbXsPYGIJOcJwjWvBUl8WsMQFJlCClwCtWGiL+ES+HQS3cIg/xklr4nGoDlhuAvy8Q5p
         68krK+DO7dRoJ8+9SEgzeCSLIwUWJC9sR6AGSQ2TXTjUR5Ivu3HMBPx3FosDJ+4ypBUe
         zi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAofnkgFoaC6aDZhECaE4IJ/liO3MCc7jpPWxEaID0GqzYCSrcleowQuCHVdi6Ze7sJJ0eROkUyIzl5kr4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1P7ktNg0eNzHZOCbvNcW2EWPyt0aBqDuh5/6Ch3Jp74v7fTz
	HwCatHO+ywkxpipkuoJ1ZeJNRHhH0Rxinbj+dx21T4jrf7T4o5/3
X-Gm-Gg: ASbGncuxnHZHWdTCnDOOmudjsdlJgoyBtCaqDxBwXYJgZDUXTg/5HoOmZquJtoPxz29
	WGCHhaAmvuOwGzjifXbCFsjkH1pyfTsTLUMHoNlLrzRz0SwurcolxHwdskHDDU4OhrGFXGTVpc2
	NfvGV+xOZy3w9nZ58thCIWjQpT0L0MCM7gAq1pJ7X3IuMp3SHf8D8cY9OXcNsTM+l3WxfbkjqV8
	BZ0l7uRDk33POYRugx2jAiVcMNLgPlt+D6O36kB+q3k2A8DqBxJ/OenDdpKgY5se3JHAp0Gb+QL
	46RZA4U+Mw==
X-Google-Smtp-Source: AGHT+IHse5uyxbDrUO7SoYD5ahNcValj2iv94zpJxk/7iX0uT5QxbNDnzYWqfhylHfTou0gNokTs1g==
X-Received: by 2002:a05:690c:5a16:b0:6ee:8363:96ee with SMTP id 00721157ae682-6eee0a4ec91mr106596247b3.41.1732572361808;
        Mon, 25 Nov 2024 14:06:01 -0800 (PST)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee009b85esm20023277b3.115.2024.11.25.14.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:01 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 04/12] fuse: support large folios for writethrough writes
Date: Mon, 25 Nov 2024 14:05:29 -0800
Message-ID: <20241125220537.3663725-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
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
---
 fs/fuse/file.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a89fdc55a40b..fab7cfa8700b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1135,6 +1135,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 				     struct iov_iter *ii, loff_t pos,
 				     unsigned int max_pages)
 {
+	size_t max_folio_size = mapping_max_folio_size(mapping);
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
@@ -1146,17 +1147,17 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
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
@@ -1169,7 +1170,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_folio(folio);
 
-		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		bytes = min(folio_size(folio) - folio_offset, num);
+
+		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
 		flush_dcache_folio(folio);
 
 		if (!tmp) {
@@ -1180,6 +1184,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		err = 0;
 		ap->folios[ap->num_folios] = folio;
+		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
 
@@ -1187,11 +1192,11 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
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


