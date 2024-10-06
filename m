Return-Path: <linux-fsdevel+bounces-31126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A9991F07
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334631C20BC0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F64114B061;
	Sun,  6 Oct 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="P4kxfRrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718B13A3EC
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226385; cv=none; b=fQNH2q6n6Xf8OlOVPXd4HA6ibkzhC4XpUaP7rSosmq2iBRJrIWYBYfnLbeP7nA1g4DmcQ5Wa+018/gbDC8d4v6JtfR2rjf+SG5J27WlAoAAnGpSSEVP1893cJfM2OmyEmwDQXwbXhqUL+k65gbjDmCk3JJBsbFnPMBsntJIJwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226385; c=relaxed/simple;
	bh=rhJ9GRZNgwHY1raVKmWuJN9qtyI0iNeH7MHZzGrpBag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nc6ksvz9SaZxuLG4kc8J4aM5dhDILvqH+CMXSK2wrWfFX8BPA+3KtwVLrn0M8qGsewyYVSqDpgUmPJDLb86Aip9LtjdQ2jdP66zQLETR8A2jM2wSGQHq63Qf13lVMtqDQ91T4uYhQTbeLSiU/Ln42ApjDp1xobW2F1147XDJLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=P4kxfRrn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso2717313a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728226383; x=1728831183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AqnyP+Byv1dd6vDoQ+Ar0AhPFXyUFcqkrKiBNXDFDI=;
        b=P4kxfRrnfOTUhLfMRH36lD5Mqw+3Xxj3VHD7XPNLOPXVjsu6G29ugkz5H4tpAugc+n
         Xtx/suJum5v5aCre6gIJADij2Yco+SwdNJUSDrDwmRUV7VAn3hhY+UhG9cqAPYwQ1M+w
         6z/JLlfkQ62Eb/TA16NpzPexB7SXb9xSWx8+NpwKY3uOPKzhFpIlzh0oTj1cjAumRKLQ
         c8T05yj3l0d0e+OQjqhfG71sWqpWMCaQgj2qD4aFTQ1cVkoiPhOwJSyHszsFj0xaZLvJ
         BZJ8+WXbk7UPP3YKlcIwYcQZuXl67tGeN8LLZVSRS4EtQMsoiwT7cj8KBD4TCAL/ffVF
         Rw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226383; x=1728831183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AqnyP+Byv1dd6vDoQ+Ar0AhPFXyUFcqkrKiBNXDFDI=;
        b=FeHKyTV7N/pCPs9BxQnZM3JdjAsyf5z8gpRS7QgXIV1QYnDGZBlAV6FIHg3WD2bHAG
         1JHrZVYpTS2nr50Uk7/1aN+yw+vr79tFUNxq1bjBGesBFIjX/Mha6pSdlrxVklYscG8k
         ihZA9iMbTuu7NRjNFSS7BJYHRutnZcWjOKziqC3UqnGQqVErWLAg1Rord0OaxL1GlbQb
         ujgcS4hPC6Jlt+RT/1BnfgAcwYl+Vu/jqwzVt1TyYV4+09z79miCCTngtXvmqHG4tek6
         wGwrMZEn7BjnQNAq10GbuQdCme9xt08fdJjtyMn2CauT6XUOYpiIZAmllNlvY0yTRX+e
         iTSA==
X-Forwarded-Encrypted: i=1; AJvYcCX48Gu3+6jR3EgumA5dkJKVvx4WqktUQDZa9XdNr6ScjK2ic/DWWBJUsRxL02N1ysHpKEKyPmpJ85gx3XaB@vger.kernel.org
X-Gm-Message-State: AOJu0YyIvkBNCeYVNbdYo9WMgbrSEx9WQ3GNcd8Y5IQP5hJVamEwz8uF
	+g/sh+XTPBJyNsTqjhopFn9p+KYQpAK9pZGKQBYmufoRCXiq/ObakGl9rtArIBc=
X-Google-Smtp-Source: AGHT+IGPeVAO5tVDuO+R32h3LCBclCg7gEXpFP9t2p1QktdHAai9ZNmvTFB36rtLf2nnkg375yrefw==
X-Received: by 2002:a17:90b:4f87:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e1e6221b1dmr11933090a91.10.1728226383035;
        Sun, 06 Oct 2024 07:53:03 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e8664bfasm5213680a91.44.2024.10.06.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 07:53:02 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	willy@infradead.org,
	akpm@linux-foundation.org,
	chandan.babu@oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 2/3] mm/page-writeback.c: Fix comment of wb_domain_writeout_add()
Date: Sun,  6 Oct 2024 23:28:48 +0800
Message-Id: <20241006152849.247152-3-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241006152849.247152-1-yizhou.tang@shopee.com>
References: <20241006152849.247152-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

__bdi_writeout_inc() has undergone multiple renamings, but the comment
within the function body have not been updated accordingly. Update it
to reflect the latest wb_domain_writeout_add().

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3af7bc078dc0..68e48749c947 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -586,7 +586,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 	/* First event after period switching was turned off? */
 	if (unlikely(!dom->period_time)) {
 		/*
-		 * We can race with other __bdi_writeout_inc calls here but
+		 * We can race with other wb_domain_writeout_add calls here but
 		 * it does not cause any harm since the resulting time when
 		 * timer will fire and what is in writeout_period_time will be
 		 * roughly the same.
-- 
2.25.1


