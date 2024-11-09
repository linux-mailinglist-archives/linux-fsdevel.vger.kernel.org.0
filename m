Return-Path: <linux-fsdevel+bounces-34113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26E39C28AD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B41E1C21794
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3D4689;
	Sat,  9 Nov 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ZMp1f/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A23232
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111225; cv=none; b=UWLxXUfqDRydQSH4JoGqLa+GMvFJZrlfSmES2ga009ieLViOGns0uEwr0wl/SaiY4xoKI/eSgtKRFc+kSbu3x27yOHb+moi4xgXTaEmT0xLGQI9qUiHyQCmAzy3KCpIXb+9lkKEPo8ts5oa9IHRlDjXFnDEvVsPMw/kYQcle8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111225; c=relaxed/simple;
	bh=wqEV/ZMnUjbgJjUAp3L1aME+cCcLDODheG/o816v65I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzBrRhaUs99cVGytPy3EBC/jkBd8qI1EwGZfDQ0PDqiNUyzfnhDY3g3NpsBDN0youfoDacXxrzAeDB5XlUO0tMe6UfLm79N8Xutm8rwayCMTjM4PqDvbs37/4/xJVv0+pso/x/sA2CO4jH6D0jMqhz1de8SuQpIyIQYt2gMKC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ZMp1f/; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e291f1d659aso2710823276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111223; x=1731716023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UZCVQtLcgRe4PHhlgikruZTXPYWfQqBHt0rJvAWgD0=;
        b=R+ZMp1f/GW6Uad2vLPzM9io1ALU1oM+Tsoa52yxT9KcPvD1vo/LCIzcy6j4wyWug8X
         f++MtYm4H+wJ15Ax0vNNolcWHFnQfjO7A7XQJOSnVcsP91uYHvYD9rnk7tikiIOSEaeq
         YjRjOdhVqyLgZKbkvoaAy8YrJA+VyDQabK7/2uI/qnqhfs+5go9dGFRfdShcgk3cXWiK
         0rQGCLYC8E0m+f8I3JFVhm+i/XOJY/QOzkewdklAfN3ji6Kp2Hn9s3QMiLHUYxIqR9mi
         bngwoQjP9V+LKDqV6lJ+58P/We8tMGGTOHb66OkaO3J1ubnThWwG0bxDCyrXbFYOG4/1
         zXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111223; x=1731716023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UZCVQtLcgRe4PHhlgikruZTXPYWfQqBHt0rJvAWgD0=;
        b=e5cQV/Qo413YuTW+RdToXT0sxQBliYQ7b/LTBt3vrWCTeulqPb/fUXBQBekz+P4+c+
         cXjmiyXKczivK/xyDFAJzse/wr/kpANP04j/m88gjH2gz56USih/Sk8FqojfuO8i/zXj
         uGs+4x7UQkxAd7uJ8vVYy7Ujh2RCjEW8wF0tQndpWF79JHw9YPQ2VRciOOnr2SZ+LoLJ
         cupS9LHdl67l2NcyqgVKyaS0Lpz4ojvxunCkTy7oMEq4zoEvGr8mkspTKwmJRrPxSJ4P
         MXGoNx1cSrIO+BclEG0aTcuy1QO8rRWwoGiVZWY9qNTbFfnKk3Z2n3YQ8hlLrWWP2HWo
         93qw==
X-Forwarded-Encrypted: i=1; AJvYcCXejcg0z+loShAO6uPkKONm7BU0i5MnK2Fc3mzWzgRsLDlb/a0H4rXQ8n1Jc0NBvTVglnyEetYvi4kK31Zs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QdDvXeatMoyrnmCGynVb+FHNebLZ0YkrMnRGYh9fLcnhLk/p
	n/lW+lYBym6/IWPL+R9NDRKud5nhgWlbLvQgB/NBkytqBje+1uJO
X-Google-Smtp-Source: AGHT+IFPX8+3a/bqxlMHtEjTK2+bzshJqshIMFxvklnUOqD53b7Gfx2gplJk5ZCj6yxDSijI1jfOBA==
X-Received: by 2002:a05:6902:288e:b0:e29:1627:d4d3 with SMTP id 3f1490d57ef6-e337f8cf0e5mr4650125276.41.1731111223026;
        Fri, 08 Nov 2024 16:13:43 -0800 (PST)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef2652csm940830276.22.2024.11.08.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:13:42 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH 03/12] fuse: refactor fuse_fill_write_pages()
Date: Fri,  8 Nov 2024 16:12:49 -0800
Message-ID: <20241109001258.2216604-4-joannelkoong@gmail.com>
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

Refactor the logic in fuse_fill_write_pages() for copying out write
data. This will make the future change for supporting large folios for
writes easier. No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f8719d8c56ca..a89fdc55a40b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1138,21 +1138,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
-	unsigned int nr_pages = 0;
 	size_t count = 0;
+	unsigned int num;
 	int err;
 
+	num = min(iov_iter_count(ii), fc->max_write);
+	num = min(num, max_pages << PAGE_SHIFT);
+
 	ap->args.in_pages = true;
 	ap->descs[0].offset = offset;
 
-	do {
+	while (num) {
 		size_t tmp;
 		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
-		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
-				     iov_iter_count(ii));
-
-		bytes = min_t(size_t, bytes, fc->max_write - count);
+		unsigned int bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		err = -EFAULT;
@@ -1182,10 +1182,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].length = tmp;
 		ap->num_folios++;
-		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
+		num -= tmp;
 		offset += tmp;
 		if (offset == PAGE_SIZE)
 			offset = 0;
@@ -1202,8 +1202,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 		if (!fc->big_writes)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+		if (offset != 0)
+			break;
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.43.5


