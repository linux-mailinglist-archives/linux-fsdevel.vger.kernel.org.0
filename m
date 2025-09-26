Return-Path: <linux-fsdevel+bounces-62827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C8CBA211D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CBD560872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7DC1A9B58;
	Fri, 26 Sep 2025 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM2AkNDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB746447
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846576; cv=none; b=MvZTXLZ5a1m6U8iiXN4OChCOk2vdx8RqsW2ZFC2LyfYBMBVRsBuMg4QAq3Bxos5fLmbRhg6Jwwlq7bE/0BJ9YNNTH4nwQsc4MO4vchN+2ScUPZfmwf2r9iIJ6joF13BvfeaXGypDcL0X3vJNDm14C4BtiWWL5erbh1dPEBnpfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846576; c=relaxed/simple;
	bh=s6mhJfy1wLr9wwae+98XWped88EO8RR6Rj9hVh2fPUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq3iluo03UnAvQ91o+t8pP8y5kbskasSLFAu4ush2/39KS+nhKsi3wkpzJRcrIOLocAvFR/+cNBOve0Qx6nagla0zBsK4+kDqUgw70a44i+rMn+iMzeFoljELdGYs9wfrf/zg6MSA38cjbdKMz+vGof4qJeYQzayUcpyBEeNmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM2AkNDj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eed7bdfeeso4721445ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758846573; x=1759451373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=LM2AkNDj6wNzRUiWXRrGj8H72x5v9FO2ZH47PZW7DoFbxWYb91OQBPRIfx64+WnGPO
         Wmdn+UiUT9dWBUS21y1ZK0+8q5FEUjpBQZEhWo+7nTw+q9lC1mHu8Q866MKSO/UDFYVo
         sF7oEU3/iXz5W2MH83TusynjOgnUEn16cN9QWCd156ZorxKMOJL3tIDhvJLCRZuuGKt1
         WQVA87hChY+VIvQaKOEymRaH9jWzNHnjqruFWod6Qzeib8NfAdFvdhHqXm3dewazpz4L
         K0DzqofrbMBdkBH4nW9zex6hFic7B8zKK0EIX1WAprjTMeFj8FdSV9VOzc0t75iuU8fK
         10aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846573; x=1759451373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+b5voxvHVAQ9evPBAMJkr0K4640egjfoU7iv7FHQ8OE=;
        b=hi+OjxoZqzfTw5LM9XH+DlHfKfRPdOGfsaMfTyGCGte5c8VYLIawAH/yf0gSp5QRAx
         zRY56Qu+Qn++GhsND0mS9Zj18p51+9BvuWpzKhTcU3KHw1DBWBbV4VhpRJjvhYPsll2u
         d84V9Ng/txosdylYEA8lKzI0unEMN3kAvWINSkOXsxal3uTrYXSQKA1SBTg/6zOeFc+p
         lLFBNnJ2Q/XwlcnAw7e4hPyxoP7e65Mj3Vu7e9drcAsZNLrQUVBNYNvypZ9zLY0JUR8j
         Bv57I7BWcNXS902ruCD/Mnl4tOgkrFYsaCO14tcy7DywXjrbg80sfrrK+ZyR2ppCIGKS
         GBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUCRJs/XnTjQICCrX/0kHn4xyqVQ/1GQMnltVFyI7lpcB5pTetIStKzAd38pLLv0h5KZjg57pwwvd3YCvvJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf45a5ZYtUK8fszxDoaTXSRtQoZMb6UA/fxAXR9SDjOWfzC/sw
	PZxnwPtPaIQgDnTs6x9AttYys4FT2Z3zmiX48do6pS5jZ276yw+NSy/M
X-Gm-Gg: ASbGncsPgSOwi7ZxztxnrPCiKZ7VdVjYLtjB9VNxkDYg6C/0mI21/aMGYu2f/jdwnNu
	Fbt8/oppfIbGXUdgdTeNZPTv+3tzHxOTk1bJsfD8gfPyb//v8wBQvSl8m5z3tJzXXu8V86dz0/2
	/TglVlcP4Bv7YXnBTnKw8cmaNZur7rwQCjXJgnBEvZdbZMshmVDyU46uZMc5QOonr864PkD043q
	lLXDonl9XdfzTWhwxzKfMgGqgKqP1QYFxuepL2jwnZ/etzusUvTHp7e6GBBeuVJ1xDQK4JOR8pd
	JvCOScbdPolubqTypPQZJU4fguGZ23Yv1xyMnGhdCJ3En854AiAvppbjdGGlAjO6MmCw9bd5Gxq
	ygkiIRqBAzViaOFyl47Xjqnan0u/Lai4QHOJLzVVcdXpdr1en
X-Google-Smtp-Source: AGHT+IEHIVx4kLA4F6aUCgGEHZ0YDmnSl35bmhbet6WjaurCHoQfC42jLR71Pq42gzogAiSpCmWQBg==
X-Received: by 2002:a17:902:db0e:b0:26b:3cb5:a906 with SMTP id d9443c01a7336-27ed722bb32mr50893315ad.16.1758846573101;
        Thu, 25 Sep 2025 17:29:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad1d45sm36470675ad.141.2025.09.25.17.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 17:29:32 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/14] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Thu, 25 Sep 2025 17:26:00 -0700
Message-ID: <20250926002609.1302233-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926002609.1302233-1-joannelkoong@gmail.com>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index dbe5783ee68c..23601373573e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -422,7 +422,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -487,7 +487,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -521,7 +521,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 				return -EINVAL;
 			ctx->cur_folio_in_bio = false;
 		}
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


