Return-Path: <linux-fsdevel+bounces-32605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0D39AB64B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BF2284B88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D21CCEE3;
	Tue, 22 Oct 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLWq3Ods"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A81CB31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623296; cv=none; b=EZW4kgVsov5Dl+u4y75qgIz4AeAradRO4Eq2tAna1Bb+AuekYq06yobPCu8NMwhjPhhIuQOe3f9I51DoqZrU6+kedEeEFq8pmz+pv6+i/5d8EE5CIc/jkFA6vt+dhor6mv/vaOcyeheNE+K2nsSsGISpAeX7ho+Prw0LkLK19sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623296; c=relaxed/simple;
	bh=4MEV22g4XjsggbYOYj2TugUOdvoBUWfpcLG9LT8sZss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ssYqIgA4K5pUc5K0Tuiw4ROqnxMm8yE5Tm8cUzzENRFf2/+hxzUe38HpG1JVU8FpFzHep/4LLZ7RX4aRzhLTI4QTVJByg23Pk7B9k3AXayDz19vQXAYOHPtAx160SaOvrs8Aq8LzLefaooXMX9G2PSwYl6JdlXm6SLxgYI2ZDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLWq3Ods; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3a97a6010so69923687b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623294; x=1730228094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fnLj/x/wj/MDATez8fu+sEbs2DKFZMz09D7xlaJo8s=;
        b=RLWq3OdsDGqK9B2NI17QJ4yIOnUx8uXsv7ORpvNwO6OMxR8lwlkkweCYjNo/tpaMiW
         F8A8u6W7UVGgQUHsv+0ZzR9VTHtP3ZTxqr1r/jvZ7M23QvhfUbnn+EOrZWHHsmG9SoW2
         8jH9JfMT6vOczV7qvd4I7zwvaIpLuZZc5VLdO7UmS0o4k6AETTMFwNM7oJpxi+yGekhR
         cXZ7AcVxXbt/jirsMZD81gugEs0KVjAFGMUdxEtejbKmLtdIF9ONWbCsrRScMROCgKsx
         KmkYiyocqXRlHy9BlK+qYkordR47NPXj9agEaodCbKrS7vWgPEQd31RDmn1idDOE1L66
         i9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623294; x=1730228094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fnLj/x/wj/MDATez8fu+sEbs2DKFZMz09D7xlaJo8s=;
        b=Wynj7uE9ZhocuOl6EDpKosUefngnxhgu+wNWdY5bqJGPE0ZkM//C6kvieMDEi+8TsW
         rbHy921G/c0dBhyGAXBoWWGINGCHa5sm+irjO0oVSW/2F6ZKf9quoo9hzq6PG72/skCz
         SmbkW6N/auOc6+2BRn05t533Qx2awmH6m/kF0jvglfQexVx9k87NJFV4IYa5syRRR38s
         6qkYOBekA8sm9BSTwA27A53uUCcl1pSBT8dtAu8LZ+HRQljijAK+fDNeVHr8NKdi/Kpa
         +ASHb73x6qx2sk58KpK90vMP7MDe8NUqr29aRo2pdVruPsZJmV3l8STn6wZdGTRic2re
         QEZw==
X-Forwarded-Encrypted: i=1; AJvYcCUq95Rg3ixKopzOQZnYzoXkSzePh2Xwq5hGuAem4Qn0e5VwqGWBgTb4KfddBS/CBIYTPc1lZRvKeiez+Hdu@vger.kernel.org
X-Gm-Message-State: AOJu0YzxK60O7OiFNJZ14dPbIXF0oh2zSqJjRSHKkolWg+amIZ5eq0RU
	pfRfBSkI2mcTrHpP2HLy+RTu4jOBwCXOVTxEs7SzuGbdV7X4JAzE
X-Google-Smtp-Source: AGHT+IE17RxujGV4wWJOZ054N/B1M2F5cL2ZD8WOUSGvQI4WP2M4v8eO8pMq+eVle1PDf17QuZ/7Aw==
X-Received: by 2002:a05:690c:93:b0:6e3:5c5c:215 with SMTP id 00721157ae682-6e5bfd7d109mr141864167b3.37.1729623293910;
        Tue, 22 Oct 2024 11:54:53 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb754sm11959287b3.89.2024.10.22.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 07/13] fuse: convert writes (non-writeback) to use folios
Date: Tue, 22 Oct 2024 11:54:37 -0700
Message-ID: <20241022185443.1891563-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert non-writeback write requests to use folios instead of pages.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c   | 33 ++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ece1c0319e35..b3d5b7b5da52 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1197,8 +1197,8 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	bool short_write;
 	int err;
 
-	for (i = 0; i < ap->num_pages; i++)
-		fuse_wait_on_page_writeback(inode, ap->pages[i]->index);
+	for (i = 0; i < ap->num_folios; i++)
+		fuse_wait_on_folio_writeback(inode, ap->folios[i]);
 
 	fuse_write_args_fill(ia, ff, pos, count);
 	ia->write.in.flags = fuse_write_flags(iocb);
@@ -1210,10 +1210,10 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 		err = -EIO;
 
 	short_write = ia->write.out.size < count;
-	offset = ap->descs[0].offset;
+	offset = ap->folio_descs[0].offset;
 	count = ia->write.out.size;
-	for (i = 0; i < ap->num_pages; i++) {
-		struct folio *folio = page_folio(ap->pages[i]);
+	for (i = 0; i < ap->num_folios; i++) {
+		struct folio *folio = ap->folios[i];
 
 		if (err) {
 			folio_clear_uptodate(folio);
@@ -1227,7 +1227,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 			}
 			offset = 0;
 		}
-		if (ia->write.page_locked && (i == ap->num_pages - 1))
+		if (ia->write.folio_locked && (i == ap->num_folios - 1))
 			folio_unlock(folio);
 		folio_put(folio);
 	}
@@ -1243,11 +1243,12 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct fuse_conn *fc = get_fuse_conn(mapping->host);
 	unsigned offset = pos & (PAGE_SIZE - 1);
+	unsigned int nr_pages = 0;
 	size_t count = 0;
 	int err;
 
 	ap->args.in_pages = true;
-	ap->descs[0].offset = offset;
+	ap->folio_descs[0].offset = offset;
 
 	do {
 		size_t tmp;
@@ -1283,9 +1284,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = &folio->page;
-		ap->descs[ap->num_pages].length = tmp;
-		ap->num_pages++;
+		ap->folios[ap->num_folios] = folio;
+		ap->folio_descs[ap->num_folios].length = tmp;
+		ap->num_folios++;
+		nr_pages++;
 
 		count += tmp;
 		pos += tmp;
@@ -1300,13 +1302,13 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (folio_test_uptodate(folio)) {
 			folio_unlock(folio);
 		} else {
-			ia->write.page_locked = true;
+			ia->write.folio_locked = true;
 			break;
 		}
 		if (!fc->big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 ap->num_pages < max_pages && offset == 0);
+		 nr_pages < max_pages && offset == 0);
 
 	return count > 0 ? count : err;
 }
@@ -1340,8 +1342,9 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 		unsigned int nr_pages = fuse_wr_pages(pos, iov_iter_count(ii),
 						      fc->max_pages);
 
-		ap->pages = fuse_pages_alloc(nr_pages, GFP_KERNEL, &ap->descs);
-		if (!ap->pages) {
+		ap->uses_folios = true;
+		ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->folio_descs);
+		if (!ap->folios) {
 			err = -ENOMEM;
 			break;
 		}
@@ -1363,7 +1366,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
 					err = -EIO;
 			}
 		}
-		kfree(ap->pages);
+		kfree(ap->folios);
 	} while (!err && iov_iter_count(ii));
 
 	fuse_write_update_attr(inode, pos, res);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b6877064c071..201b08562b6b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1096,7 +1096,7 @@ struct fuse_io_args {
 		struct {
 			struct fuse_write_in in;
 			struct fuse_write_out out;
-			bool page_locked;
+			bool folio_locked;
 		} write;
 	};
 	struct fuse_args_pages ap;
-- 
2.43.5


