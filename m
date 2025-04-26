Return-Path: <linux-fsdevel+bounces-47426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 482CEA9D68F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4474C7F46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560C13B284;
	Sat, 26 Apr 2025 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/8Cp5Er"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E618C01D
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626213; cv=none; b=HF+vUhnMF4QzLQzWTwo9PwzBGtEcfGOSnP4I2AJfk7w89Lnsxt+BgVtZnnM+PkBKJQsTakH1wBhdgfHpfV/EOioUGMbWLT+0s0xCKyaJYliRyYm+3ntKaT1iO7ofRb5Fx0/5BDqkchX6R67jXb1vg1FCiKfIx/AlIhcnUd7s99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626213; c=relaxed/simple;
	bh=bmpuJqG/erlELdEJVTOT1CDB50SpDrozWa63ohkerU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb00sJWVBFGUzWKqXf0Kw2kFF3P5UPD98/N1BTgM+ysvMyNR3TTh3lL3wwAOFYBZQiscgY3WoYdZ+iOTNCQ24ty/XnMcuLTEkCOWZWRk0jqm/Tg2+sTZGuC5nz14DPRF4s892H0vvuwuqbDsBExk9fpDGohdTCiIo3SpOrigHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/8Cp5Er; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399838db7fso3027477b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626211; x=1746231011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcP22qvXZzrSYp31GFVZ9lIMptn/8spltSeZ3og5GTs=;
        b=V/8Cp5ErAA9c4pqx0zC5sfYfYuxpNs7FuAJqj2k14NBnkvtRYR5nIQG1m9DB961W95
         bh0+I1Cd4+7ki/Zo0FDnmyNYL80vDpWMJZxC66QJUCaJn3p2vYpbYN4rckHgKGRDBEkG
         oKrmZ4FRjTSR8KDj/nUMPz2kJKvWF4GmPewqF+ny9Cb9vFMy+YSP0bXiJ7rUCzWcLV9O
         DTF1ApXCdtIMRE7R5+ob3cCRlBh/LVBgTR0tz6Otl4EhJ+Jtd9rPRRVmxUD8u2Hx7cn3
         KP+zO0XOmYBRbnwGbS99501BB1N+iUa1VfAXsvurWkdDLqSzoQyVXg0jnhQes4FIj5gA
         Rhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626211; x=1746231011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcP22qvXZzrSYp31GFVZ9lIMptn/8spltSeZ3og5GTs=;
        b=MHyiWz+giv6kbdMttFeG5bSV5Eq/F3GqoRqwbWKBTSf6DcsH/U1QqNFDKZwopHy44m
         0H2IxAChRKPovk6LzzCba62LQ5SKhWn9faBPMQD7lhTjxQHfnQQRIE/Qx4ofjgHb+odC
         rrk4iE0W3uvEhhF6v2KPBK4P6/0M7XAIPVkFXmd+blmWxcBsJzUx/Rq6wBy2aC31mq4I
         uMuTV36CVIgz8IJ/gur5SriQ2mBzo9rVzXpWErEPLWmuxBT3fHEAzscnvbaN+4G6HjyJ
         vRAWXdV/lzee89e7Ek4mOZAdXYD7m7tmltTv1KIxgR9TYLihVbwpjtZj0G3YPvQzqBzS
         li+A==
X-Gm-Message-State: AOJu0YxYD5Zaz3h3ZJFsgustcwhWGgmqBGPz6MmVJGmmTwic+HPKDk6F
	3rtaX801HXQjN5awGgntt/O5vc9z0CTKc+ZVacrordat4zd40f5f
X-Gm-Gg: ASbGncuYsytg2SVOwvzDfVrtELJDpciLfSrpvIsTQL9EMbX6EGZo8P7Mjxf98LyGkLR
	PEIPrr+BXhqqFNZX8De4CrXixJhkvOtRiigbMT2DF+3YggZwyiZ7LEwicDvbVsxYrZ7hv0RCLDH
	qjhtmkCn322z9PoGuhj+LFcWwKDneTtskIZkXm1fYCSqhleWkdwDsUPK9iers5QlkVQHmpcnI3A
	n+EGHFQtPUz5Up5yotYUzmEB6NdgNz0bHYeYFOPmmdfPhgr7REH4oN2KSXDEDDWfx/ejxnnyNs6
	cqUc1CHhckBZS+TOOWOFDeMcEkauPuq3cU0=
X-Google-Smtp-Source: AGHT+IERfR91c/IBbienKC2UqPe2awfX73kkxjwkYVNtJBqg0mkOHdiCfPOguHWQXvNB9wf4hpJmOQ==
X-Received: by 2002:a05:6a00:928b:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-73e267b8cf9mr14028973b3a.3.1745626210741;
        Fri, 25 Apr 2025 17:10:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a99a92sm3750477b3a.125.2025.04.25.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 03/11] fuse: refactor fuse_fill_write_pages()
Date: Fri, 25 Apr 2025 17:08:20 -0700
Message-ID: <20250426000828.3216220-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e203dd4fcc0f..edc86485065e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1132,21 +1132,21 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
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
+		unsigned bytes = min(PAGE_SIZE - offset, num);
 
  again:
 		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
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
@@ -1200,10 +1200,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			ia->write.folio_locked = true;
 			break;
 		}
-		if (!fc->big_writes)
+		if (!fc->big_writes || offset != 0)
 			break;
-	} while (iov_iter_count(ii) && count < fc->max_write &&
-		 nr_pages < max_pages && offset == 0);
+	}
 
 	return count > 0 ? count : err;
 }
-- 
2.47.1


