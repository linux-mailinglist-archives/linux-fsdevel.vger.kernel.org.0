Return-Path: <linux-fsdevel+bounces-21875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C290CAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4544828A28E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2477BB14;
	Tue, 18 Jun 2024 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSBJ5ji6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546EE745C0;
	Tue, 18 Jun 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711442; cv=none; b=qVTcQlBWuN4HS4eL2pI6Za7vvrrmAH3Irlo9QzNPv0yL00u+5lxFMawkn0Q3B4C0fSlqUy5Lp1kXXJs5nX6K2O8h3oUUN2vH7oxudp22g9wOttOWJ1enL94QeiKZu6S/1mYJpVOTX6WXQ/JH5yBP5CVnJb5QfZPIWz2cS14UJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711442; c=relaxed/simple;
	bh=gn5CPAnzZLTEwuHX/rg00l93QkVeW3D7QPysAsulW2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfvoHbXPq4kW0ZzgbZEJkVdTWNHO7lRH2qjYxcTC6V71T0O0Aq4DNlv20R68FZY26R/9jb17e6WlaTblGqMqxoEJfCEXA9IdYOE9B8NRl3F+QbIZplFe8Rf+Llac6ZX0gfSgisIOCS6ODbadjYWcpTfnYfvc5as3EM5e1fYtp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSBJ5ji6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70131063cso41811085ad.2;
        Tue, 18 Jun 2024 04:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718711440; x=1719316240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5s6/LFX8WRrd2o/jtRmvisL1C8048AZKiXldCA8XPv8=;
        b=PSBJ5ji6I3hZ3WKzyuqmEA1brrxCv9m/ug/yPLZpw+up79PxIC3NMxf6rc6McBZA2g
         bh9xSkV58QdezsG0xUsnArqkT/OPAdOWdfH2S3b1vvq18c15kZcda/Hd7V8pxuoalWUi
         55IN6OZowZiCAQl+9Tqh/OxnI/hL/aHQA+lHhv2OwNib1lTTezjYqaaYENtdQWKgBIaB
         70ixQdWIhjtuYEPwyB+1391+ga/1DSbXwo4ZqMz9V5nWRdZ4keHaCHRUnq1pxxUvRpCK
         9j7OYUPW0XiIwYdaxMRbII0n52qRSaD7FmT3mR3qYQM1BsGsMgXO2NCqtFmsDpDPC581
         agOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711440; x=1719316240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s6/LFX8WRrd2o/jtRmvisL1C8048AZKiXldCA8XPv8=;
        b=tLEp8ntnTIO79WXpj/e4f+5bgXFkQh2M1ITM4dsQvcSN+MNhr86KycADfDYuFl/xmQ
         PlVYGkW1YFd9EYVo66GY9bvIcb+8qth2xZCX3GARQ6ZNwmiSsu8eJaYWrzM62q8Qo3JK
         CEEtAfCzv3xtRCPySryxik+gjmHQe8ALHfg6INYZ6a1ZkZHu1n/UetikhgWBLy2gjlIl
         KlrUbRroSRf0DtAMKWmKuhNqBRy0o+PqL4FjVvVgqCXBJ9fq/El9UxW+MVK50AZAosZ5
         eF03K5Hguz1eLvoOSQc7AQ4Lyl5RsoLqAlbwvFAoD60OdqWTHteS0TzepSDnFPpXVtrQ
         Arnw==
X-Forwarded-Encrypted: i=1; AJvYcCU2lYBBzq4SmW1dSBnXnrCx9bun3bOcQzuHy65tLc+kSC+p+GLtui8wnDRAULeJVqbtYZy23DCNmwk5BIMbHYSmcKMmLt9x/rh9WQllj4gfOtg7Tw1526V7uW0AUSUh/RzNhgoIQ+7Ea8fjpA==
X-Gm-Message-State: AOJu0Yyva8qlJWIh11SMoUp8SBH9aCJkvCJdoxKpdCGchlvLEtLOmiuy
	v92iYxgh4XVEWFQagRVw6zmZCEj85hS1stHkzitV4qwyMXRx9oBCynCwTiO5
X-Google-Smtp-Source: AGHT+IH6Z3j/b0LjFf0GkWIaBhwNo56mHqUE9EsvTcdnjzrbDUZk8I1kDyLDNVWXU4Yb1P3z7Mag0g==
X-Received: by 2002:a17:902:d50a:b0:1f7:23d9:f530 with SMTP id d9443c01a7336-1f862a0eadfmr139727715ad.66.1718711440120;
        Tue, 18 Jun 2024 04:50:40 -0700 (PDT)
Received: from BRUZZHANG-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee7ce5sm95643995ad.129.2024.06.18.04.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:50:39 -0700 (PDT)
From: Peng Zhang <zhangpengpeng0808@gmail.com>
To: willy@infradead.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: bruzzhang <bruzzhang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>,
	Vern Hao <vernhao@tencent.com>
Subject: [PATCH RFC] mm/readahead: Fix repeat initial_readahead
Date: Tue, 18 Jun 2024 19:49:41 +0800
Message-Id: <20240618114941.5935-1-zhangpengpeng0808@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bruzzhang <bruzzhang@tencent.com>

Now, if read from start of file, readahead
state will be repeatly initialized when
first time async readahead after sync one.
This case likes:

sequence read
page_cache_sync_readahead()
  --> ondemand_readahead() <-- initial ra
  --> folio ready <-- order=2, readahead flags
folio_test_readahead(folio)
filemap_readahead() <-- async readahead
 --> ondemand_readahead() <-- initial ra again

The second initialization of ra seems a
mistake, and right ra window
(start, size, async_size) should be (4,8,8)
instead of (0,4,3) after async readahead.

What's more, this patch can improve sequence
read greatly, the result of test as following:

case name             upstream    upstream+fix  speedup
----------            --------    ------------  --------
randread-4k-sync      48981.00    48948.0000    -0.0674%
seqread-4k-sync       1162630.00  1334915.00    14.8186%
randread-4k-libaio    47561.00    49910.00      4.9389%
seqread-4k-libaio     1058526.00  1257134.00    18.7627%
seqread-1024k-libaio  1365866.00  1411463.00    3.3383%

Signed-off-by: bruzzhang <bruzzhang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
Signed-off-by: Vern Hao <vernhao@tencent.com>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d..498708b4b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -571,7 +571,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	/*
 	 * start of file
 	 */
-	if (!index)
+	if (!folio && !index)
 		goto initial_readahead;
 
 	/*
-- 
2.39.3


