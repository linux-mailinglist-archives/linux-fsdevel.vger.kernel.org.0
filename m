Return-Path: <linux-fsdevel+bounces-61851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C6B7ED54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E7D3B9A84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3322F3C2A;
	Tue, 16 Sep 2025 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP0VpIBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F52D73B2
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066648; cv=none; b=jp378BUWoM8hU73t8S41LcDIqCg2yeL6ZKrZNEVFOy8ovGzgxhLQOgZ2x/6nKKBDKK25+faYwX037asd2mC1Cc+/RWadt2Lz1c5+pkRkXl+cCRSD8KVSFtAen70Q++DFfBv44/Z2hMD7X24Iye+sGnLG10btzM7xYYtFyOMrTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066648; c=relaxed/simple;
	bh=WvDk48cCQDjmhEgUA3H/dzeLiBWsntQn2o/liLF6Xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAjEwNehcSCA5002syJs87zq4+/F/gF7l/azwWypd2yc2cts75aSbMuwmkxKXu20diTiURxe6tGzG4ZHUjxwPaW5V1RwPScUvMmpvWnXyWKu4BpLORcES7GXcg/wZ7Vxrit79r0Hz3ntreTTsVm5Iqh3E4zpU9xoVWDxI3hVqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP0VpIBQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77287fb79d3so4628455b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066645; x=1758671445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=cP0VpIBQ8bSAm6pcXxfh5/LTWHp2uJR6AZTw0bEmn/Qg4U0ZP/IH2jVqER2t1SmN8r
         B3oyorgV8DINUgGl0Wy8uq39dek7maZOcd/rd1aiEg4mSylA6/i4XjTaVgTjInvEa+UI
         jAkcEMcXnIHqjxA4LWqsFJt9/rqVSAli+OKFfNn6KxKkG4ZRCGZAQKKbHnlyVZ4V/StV
         6rU63KwOcdZKjdUzLRNLCOjhzj/sbPj7yzO3uaJ9v7cAQQeLIlj55/Wbp29wCQKiKq20
         5OxMJPuVnbymHqsQvYx0GONvyAKEhx25O/VvCIMMusrrjMVQvCXJwKFvHsc89z4DEWNZ
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066645; x=1758671445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHobEDbeY2DMEEr5x+JZY2wJlQRrUUUgIcR140CbiFE=;
        b=qTcvx2p59VXoegn0Defqz0nPXf2jhBItB8Y5kYiMP3kBArKt8MFBxw7lBq53OcBDxN
         p9/+cuvFtcYDWb6kZTPGZTE9MlBM9X9g5n/qwPuB7GEhVjVLx7O1o8KWZyvU3L8Jqqds
         bOhUYxW9fN7jwZa+Z4yI0WVfdQNsePeBrehkcGPXXspE6CYAOrisNj0gZ8X3vy9oHTEN
         Oh4Pa9pl4ybGurRg//HsxkBpSz/Q0xiFNzYlU+zp7Zw1IGYzuTK0j7lLxqyj7rFJfAdl
         XjDcjj2um8KPI7BfcpjoCXYecybwFNk1jHr5xuA72MOAXiIHFTZh8krnkRopL+mJlD5f
         gyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbJGk6pWS80IlI3tvfV10Sf+Arh0FzSDW7u2tK/1bgjx0MZq8P9Dw1+jLt1xuZCgNMEtff9x1vuWh0Zg8M@vger.kernel.org
X-Gm-Message-State: AOJu0YyhV+dN9PFhrkTCbXUKGbseaB4TDZhnXxLpVs6VwGkKa1dgXDFZ
	8C8DnmpZfmhQAYLeV2Ar+gx9KCWtVLtldUavxcD+L93bTP6tpIKPq326
X-Gm-Gg: ASbGncvPSnp90XNxl9W8LS0KhV15k68w7RIdft5MrlPQ5PRkp3ZyForjJQsmJOUqkSn
	CgPDGhNQbGnfLgTlB0ML6yVuciTCv6QmYG0wetFv+GiOLsMMjFRA1aXsieTVMfCu9pxcRNmVmV1
	bgYbF3A1IRvtZjSCXRWrzSeNvkX+Q2k9yk9HfRMA/b8IYNqAb8FilxP/96MNy84qqB4Qii6PCTF
	HtaZ2JcVVnVlj3MIDEDM1dx072xyed9+WyD0l1IG7d11CPtmhxOp8tJMvs/k5Bg3AaExihudilM
	rY12TfxySFeSfyamIA0eR8eAy2qRZ5HvZLlBladwZZPNLBA/cEYeONrU6J6DiRc5H3iPy0VONNA
	ZMlcYnirD8QZ+gzjQcOBBkQlhg9kUye7axwmnORcMlTz8D7rcaw==
X-Google-Smtp-Source: AGHT+IHkRlLnCp0WU1FUde2gi6s/vcnbEIKk0ErpbS8ixCYe3+7N5XMnBohfRkdqaL85QNvZmgrsuQ==
X-Received: by 2002:a05:6a20:7d9c:b0:262:5689:b2b1 with SMTP id adf61e73a8af0-27a938d847dmr96465637.14.1758066645351;
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b331e4sm17001334b3a.70.2025.09.16.16.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:45 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 12/15] iomap: make iomap_read_folio() a void return
Date: Tue, 16 Sep 2025 16:44:22 -0700
Message-ID: <20250916234425.1274735-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No errors are propagated in iomap_read_folio(). Change
iomap_read_folio() to a void return to make this clearer to callers.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 9 +--------
 include/linux/iomap.h  | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72258b0109ec..be535bd3aeca 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -450,7 +450,7 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 	return ret;
 }
 
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx)
 {
 	struct folio *folio = ctx->cur_folio;
@@ -477,13 +477,6 @@ int iomap_read_folio(const struct iomap_ops *ops,
 
 	if (!cur_folio_owned)
 		folio_unlock(folio);
-
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4a168ebb40f5..fa55ec611fff 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -340,7 +340,7 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops,
 		const struct iomap_write_ops *write_ops, void *private);
-int iomap_read_folio(const struct iomap_ops *ops,
+void iomap_read_folio(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
 void iomap_readahead(const struct iomap_ops *ops,
 		struct iomap_read_folio_ctx *ctx);
-- 
2.47.3


