Return-Path: <linux-fsdevel+bounces-35858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343CC9D8E4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6DB287F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0BE1CDFD3;
	Mon, 25 Nov 2024 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMU5MC08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05931C8FA8
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572371; cv=none; b=Q88vMUVkiMnPoZIQPj43sNFZDOXQXPr9xq0DEO1WWjOBeQVAmNn7KkNg72gn2rKRiOP7IIjae1z0D4koYYLv2nsNQqyGAirdG6lVht8U4NHBl9awt4NOCRWr+MVWRLHKvEz9y6SZJRUDQnrHU5/NqA8FAwLBPI9Ru7dBlD+tZcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572371; c=relaxed/simple;
	bh=+xbPSGby03WtiL3HlRFTnPezCXKa60W2op1hYxJUo/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUMSrN+bc53BgRYBjpHTmbBnXdLjBh0ug+28SbySEoKit4g6muEIM9YVbuokDnxkZyGaQ2kb/TUZy/V/Sv41CD9TGv2XmvkAx0fefN3kUiBQg2kOq+qg7RLZCYturcHCdqxCBMFkHaCnQlKV2Q3doxozW5FB1Fuqg1accIWmqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMU5MC08; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6eeb66727e7so48354617b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572369; x=1733177169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNQ9FkwB67Ctz/Hj06wigDjs85MxWSsQ2VipnP/l41Q=;
        b=mMU5MC08dR1A/lMibw7DtIiDAGdhGR8Z+HIyNUlVyiMKFHg+QgCwoWkMEUflAVdwI6
         3sKxSUw20ny2MDH4MQD4HXUjU5kyCkAl+cflOmlGFV2w5LT3QuRrNU9AvQlnYYKy4aSw
         DaII/LG+q7/U6GX5PP2qb17oYEuqHR3IgLFi8WCEvUtHqjJd4J788o1pHwA5YgmV6g2/
         vFvHlllcO2VLvngSVCLIQtXk65t3IF0TFCrYUeln2v7In1MpoBEZCnKI8yIgb5KcVeQr
         QccFbOjFfcprViQPJ7xrpUpnlWuFu+QBcA3DWLXRgnvpVmKoKWprw31nBr+gBu/tqDMy
         soww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572369; x=1733177169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNQ9FkwB67Ctz/Hj06wigDjs85MxWSsQ2VipnP/l41Q=;
        b=X2N1lwXVJrmh+Bsuh6KBoklvtsF4CvPm2IP9zjVlEqrCX1c9eMT7n0o1Y8nSFCcOC4
         +jIfjwuwEgyHXwMW1Kdfql8V6tfI/PRDqjkwkpUGs/hEokfmjJyt+IjA7da4+PORXlz0
         YaL9y9Z8Tze7xvYA63dbG8jXmc1ssW0hb+7LyQ+uGAwww93EexNUOg2zM5Bc5emGhY2Q
         HVIJE/vEt8+MSSGSbNTru4OPCGhHU5DY+HTa1klg9x9EiS0E6y8r+m6auRz31dg8aJCF
         adtHSsjpCD+ba0xC0g9fSLMV51Wk5dp5fWExtVSrrYMdikLNayy1Maj4URSOX3348A7q
         pL6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLg6lCr0hivBmcuNSMQhV3YpO+tU5lb800Dv/v0j3N/OawqTVpe91i4dg1ZCZcFMjJe5tizdRJ51yurd1E@vger.kernel.org
X-Gm-Message-State: AOJu0YziffwJfY4s/YEQk15TMMCIZO6Yjya1VjQfF96PM1IDzh1r9IE0
	Ov3qXiMXkQ2UZdsYD3v4pAPwicPC6CjUYJ8SjkQPho8G/omn2fMdbjfTLw==
X-Gm-Gg: ASbGncv0wKJTbva6sQSJcIiuzg03VLvOPRYiF6s7b43GQ6xGaI9w+OxtA4i141zNvWe
	pYHEtJPnpjm8428ARymJyq7cx9G42Ngv3tLl/uYDa5tUs5aSiqzHL1C3I2l5yoZspfVqLEcuPnk
	gQf60hWX0Kkci+4Rg6BqC97nE6y1l6HqZVFShlblXU7duTJEp6OUdxRzFxsh8MBcAYysmuA3DFG
	jMKkmcWQSs+K95QjJnBuy8ZIIii94srdY17aXpfoiSrZERusFt4ApRWJZRyC3yh/FUVgFWT/n0b
	uwb6YAMA
X-Google-Smtp-Source: AGHT+IHak7g+Fg+SX/RMWyegnQirebba96cEiah6ddfK/GA4qibQUBA6FH2OkabjKiXJiTO7GzIHHw==
X-Received: by 2002:a05:690c:7085:b0:6ea:8a73:c0b with SMTP id 00721157ae682-6eee08a9ae9mr142944117b3.7.1732572369177;
        Mon, 25 Nov 2024 14:06:09 -0800 (PST)
Received: from localhost (fwdproxy-nha-012.fbsv.net. [2a03:2880:25ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eee00800e1sm20138377b3.83.2024.11.25.14.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:09 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 10/12] fuse: support large folios for direct io
Date: Mon, 25 Nov 2024 14:05:35 -0800
Message-ID: <20241125220537.3663725-11-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for direct io.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 590a3f2fa310..a907848f387a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1482,7 +1482,8 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		return -ENOMEM;
 
 	while (nbytes < *nbytesp && nr_pages < max_pages) {
-		unsigned nfolios, i;
+		unsigned npages;
+		unsigned i = 0;
 		size_t start;
 
 		ret = iov_iter_extract_pages(ii, &pages,
@@ -1494,19 +1495,28 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 
 		nbytes += ret;
 
-		ret += start;
-		/* Currently, all folios in FUSE are one page */
-		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
+		npages = DIV_ROUND_UP(ret + start, PAGE_SIZE);
 
-		ap->descs[ap->num_folios].offset = start;
-		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
-		for (i = 0; i < nfolios; i++)
-			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
+		while (ret && i < npages) {
+			struct folio *folio;
+			unsigned int folio_offset;
+			unsigned int len;
 
-		ap->num_folios += nfolios;
-		ap->descs[ap->num_folios - 1].length -=
-			(PAGE_SIZE - ret) & (PAGE_SIZE - 1);
-		nr_pages += nfolios;
+			folio = page_folio(pages[i]);
+			folio_offset = ((size_t)folio_page_idx(folio, pages[i]) <<
+				       PAGE_SHIFT) + start;
+			len = min_t(ssize_t, ret, folio_size(folio) - folio_offset);
+
+			ap->folios[ap->num_folios] = folio;
+			ap->descs[ap->num_folios].offset = folio_offset;
+			ap->descs[ap->num_folios].length = len;
+			ap->num_folios++;
+
+			ret -= len;
+			i += DIV_ROUND_UP(start + len, PAGE_SIZE);
+			start = 0;
+		}
+		nr_pages += npages;
 	}
 	kfree(pages);
 
-- 
2.43.5


