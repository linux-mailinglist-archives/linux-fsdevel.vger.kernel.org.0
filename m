Return-Path: <linux-fsdevel+bounces-34117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6F9C28B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04309282A9E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2318C07;
	Sat,  9 Nov 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLrHwLrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDC81E
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111231; cv=none; b=WDHcCfN3+ZjB0R7Wk1aIEFl3A0MWv/qbBaFh0H6dHmtEuvHS95D/QUhmjZSnqkmZHHN4JKC7yxrohtVdfQcIj2AgrogKzKuOb7shzmE0RI4g71CWLVe3ltsUIwjx5Y/qLQhbPre29NfbUgcAr/QCpiDr55OLPfaFS1vlfWQU2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111231; c=relaxed/simple;
	bh=uQ7ed7VaoSKKodByRTTY7Vy9xgq6E4EKe3TJfnPEr9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6ZoUwMc6xdnmzbmUGOLVTgUj/A4vudISia4DnuwpUgQl1X2AaN6D43k+n1i3MBwc5KlB3LnFktZUntHv1aHmewYz/aEtyF9egKhZY9jTJuAolB2Afi2xlUWul8xm9tDHb63xo7AbhYB90tG9e6Ej+Svs76KX0+B0aE3mKPBEoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLrHwLrG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea5f68e17aso30401847b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111229; x=1731716029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P//IZ3vPFKZwRWDvcfeeruexp11/KzxuvABZbXdMKBQ=;
        b=cLrHwLrGEsX4Snk1D04BAaYLnPy+spFxf5YyEzqxsBSfWDSbFi0RAf0OF1uKgd7QB2
         SGdTmP5kckxu4NtebGjaLgoaMnGGeptNiQRTCfKSlW5C4rZ/US9UDF/HjI8qbMmG6lH7
         NK64f7RHtTnnAqMdDCwFfbs+r538NnuQOvUhS+w9IrBfJU/R4eu6hZYQM9j879QnCFQf
         ZbgUPCQ6vucAyg4J9Wpm9fnd4gsrevlVwKvePx1MqLeQmYdo0PlmgdtdYx9wEMGibbAQ
         2yTL9B2XhK4FrV/deFktLC5zZfzUoaLQi6SGmazqKDkw7XXUHUT+GfAgMDZCQBWGfm7y
         +lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111229; x=1731716029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P//IZ3vPFKZwRWDvcfeeruexp11/KzxuvABZbXdMKBQ=;
        b=AVIbglmTTHlfdLLqJY+f+C+18ROor8B5KZPdNwtNoOv+0IA8sH2TclRKy8WYe+0nuA
         KjH7P8gFXOlOSoj8N5liiTmWmrB2e+E0Ly++Ra/2p6PJjgybwz1R1xWEmv+sKxLpya0N
         uf6uRXoiOrkL95TIK2q43DadR0B8+5yxCJuEmlollDCvrrkKttSUlifpmTtBc5eNHwr3
         k84L5sxAbhUhteTWkakW+Lc1V55p+5ZesrQIQp1vbd0Lvf8Pprf0IpzxCVc1z7BEZtr7
         xW7uxC7jMkd2ERVzZjNxde1dTIHFa/0isL/duYJfxEl1PL5Xj6pqsnVx+lFYHShApliK
         vblw==
X-Forwarded-Encrypted: i=1; AJvYcCVv86nZNjqDXr/untD02Q9QgXIlt8udQmarii60Nw/cdPBcL+zLzAwiNmWeyDcyl7lU33EobCzpHfD9tjta@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ76STF3uVp9sWof2v+Ds6Noa0HHmJxWqJAoq/BCC2gjmA0B03
	MNRfzuOtbTkDJH7L6TJ+yjE0UxCYl798RPujxCLHmB+HCZC/MGPU
X-Google-Smtp-Source: AGHT+IGHbIj5r4GbPESffghDnHwvOmOiAov7gDgsq//ARFWkdtBhHY61AfKA1vuP/7XkEtulF3h5fQ==
X-Received: by 2002:a05:690c:6601:b0:6e3:fd6:6ccb with SMTP id 00721157ae682-6eaddda0f27mr60104767b3.13.1731111229053;
        Fri, 08 Nov 2024 16:13:49 -0800 (PST)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8ee1c0sm9399717b3.28.2024.11.08.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:48 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 07/12] fuse: support large folios for stores
Date: Fri,  8 Nov 2024 16:12:53 -0800
Message-ID: <20241109001258.2216604-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
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
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5be666af3ebe..df9138f33c47 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1658,18 +1658,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
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
@@ -1678,9 +1683,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
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


