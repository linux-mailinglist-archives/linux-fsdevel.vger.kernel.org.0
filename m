Return-Path: <linux-fsdevel+bounces-7855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85382BB71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A301B23029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D05C907;
	Fri, 12 Jan 2024 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPASxGTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D85D724
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3373bc6d625so5081292f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705042785; x=1705647585; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMDSp2ZNZdvA1/0x96e6idKEXK9ueWlbixOmKjycJeI=;
        b=mPASxGTRG4ee1EsbMUtyLbavfZwSNuWYoQ2tS7jA2O33T5m815dQsGECfJUq5smV5y
         rkI/FprsHB+As5Pm82Z9NlqURdjNipW3FNw9TQd3XmeD1sdCYYm+NT6Y+NLIDkvl2fi4
         +EshQEnELjsu+TREkJigi7yaUNAz04SjX6QL7mnoMuF/PS3EwlFvuc58N1Kp1xwDsW49
         Tad9FzEdwdkwSlmVb5nkypHZ9khY4BLpvXME6KsUDL7sdaEKw6Pq9pi0NT45PdmtEVgl
         i8xmhtMG6VLILGDmYiAJmeHtlxwHNVM866/U+vmQ2S7glyAQRhrgwQJ0/9RtX8YU4Qh+
         l8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705042785; x=1705647585;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aMDSp2ZNZdvA1/0x96e6idKEXK9ueWlbixOmKjycJeI=;
        b=kasiId+EudwJJf8Lb9ADTXgkIV7OGevyC8dSz2pPkGhuX0JDym0vDTN//wVuQIMJuK
         vkWx6TVYl8searIiDHvGifEn1l3LmyMgBJp+z0SmrwJp29yat4SCLXdb1KbGUhv2Wz1q
         C53FoKbY6PUbAKaZhapDfoNcrNsOUOKr+/RtS5IcFV1H1DfgMVgzfn/rLd7vz6P4BXcy
         iwxKBl3chfac4o/qsHjekL87TimbdCIPSZ+hG4JZH6ADiaI41YxXHLXwdgUihsPH0Z6J
         DeEBaeBmE6N49KioHO39gNUbz7QxaJENVTRFjeDVAtHzo7Cemdz9UIGN8RAQKb3VsbBj
         EwBw==
X-Gm-Message-State: AOJu0YzOZPYMjsHnF2vBjO6VPA3HHRXpuBTMau2rfAGGTfsPZNypZVop
	nIxcDV0HAq4NhLELzhAn7uD1h5V8KJZ6tw==
X-Google-Smtp-Source: AGHT+IFIM8WcAUdOil9Y7u+h4e46rIteWp4Vx2BN9L2wWJb+W2y9/7uTleu8vvvEr7YShi+xUYEX6w==
X-Received: by 2002:a05:6000:cd:b0:336:77a5:479d with SMTP id q13-20020a05600000cd00b0033677a5479dmr436727wrx.123.1705042784923;
        Thu, 11 Jan 2024 22:59:44 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6d50000000b00336a0c083easm2990218wri.53.2024.01.11.22.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 22:59:44 -0800 (PST)
Date: Fri, 12 Jan 2024 09:59:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2] netfs, fscache: Prevent Oops in fscache_put_cache()
Message-ID: <e84bc740-3502-4f16-982a-a40d5676615c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This function dereferences "cache" and then checks if it's
IS_ERR_OR_NULL().  Check first, then dereference.

Fixes: 9549332df4ed ("fscache: Implement cache registration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: My first version introduced a race and a possible use after free.

 fs/netfs/fscache_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index d645f8b302a2..9397ed39b0b4 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -179,13 +179,14 @@ EXPORT_SYMBOL(fscache_acquire_cache);
 void fscache_put_cache(struct fscache_cache *cache,
 		       enum fscache_cache_trace where)
 {
-	unsigned int debug_id = cache->debug_id;
+	unsigned int debug_id;
 	bool zero;
 	int ref;
 
 	if (IS_ERR_OR_NULL(cache))
 		return;
 
+	debug_id = cache->debug_id;
 	zero = __refcount_dec_and_test(&cache->ref, &ref);
 	trace_fscache_cache(debug_id, ref - 1, where);
 
-- 
2.43.0


