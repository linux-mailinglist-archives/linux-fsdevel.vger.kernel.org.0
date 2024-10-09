Return-Path: <linux-fsdevel+bounces-31448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06770996E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA751F25097
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B0819DF8B;
	Wed,  9 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Y6orSiGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F57197A8F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484901; cv=none; b=c7zN0NbvyeUBnI+KxMohVxdc1EFHGkPi5atmb9w+uUBhDtXKKiznjipF+4GMLcqQApF00r2rIQ6xG8ycAiZpJnBlskMokeywJJmyeqJg3BfKkJVCl00hJNe9B/efR7DCfKxr+pEvVWkn3DZNeomYiehYHYFL2WXmF8um39eKh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484901; c=relaxed/simple;
	bh=ZkMXaGXK3vOYJa0SvIWW1dfqffTI0W6YThAuMAv9htE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mN401ZQfgS7PiAmc/skKpF2fCwJXj9tPWbJLiX/OdaGvGbwOQo4QJIHgLJPyFx78UoKzDga4URzC9i1+bqU0f4XKIleOtKnANI2NILePQ+E1IkJQaUYS0UVth+q6fBBOtYIGsg5vr2rdqwj4u/5bHjQlgrl0SW3t1vJVzw0EmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Y6orSiGL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea1b850d5cso1280929a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728484899; x=1729089699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIiaKwpes0nmcRx/K3u+SN5+YvMoD90XzWrUKk6r3qs=;
        b=Y6orSiGLd/BlwnPnhKtKJcmg06qSANR5CGxijQTMHgMMMCHkniGq/DQTBTpGc3oBFg
         VOYmh48+RvkhOEAlXCs1hkvAnvCO1KJaOrCQIPGwX5AIH0VM+XOcOe8vjkvgxcqbCF/a
         aKTMt4/6/yu/FHOY+UeOBQ/erdBERoStcZwYhAs5RDo6UiIu5bL408P+aQVi1v5I2u8N
         sbzD6osvAD/GgcU4yZMrJlijfDiQDoJH8ag6z8unSMKhkqSzWPIWEw6+MkpjV7cpEpyG
         CcD8fTevU8xBXl6Ue38HVhCN7u0b2uTWg8Ecvr5+YxIJZ2hhC2LhUBaZ9z6WAErD4TRM
         PdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484899; x=1729089699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIiaKwpes0nmcRx/K3u+SN5+YvMoD90XzWrUKk6r3qs=;
        b=vgqVUIt6g7E/8lbj+BkPVu+kLiRU2EQ9ZhTljkM55ZcyceDEzLc7I+EyPmgN2EjHkj
         4v2LJjaykK7f261mLvlJ1mQnuwn42vQVtzpMkLjN4MGprZrT/2yOw6dVEVO1ieHohKWa
         0Agz/xIlIiSD5fXZPMjP6aS4HY11RD2jE9qumZu0ziN65iFjwcuHTSdXlCa/56DxSqY0
         IQ/zWA+3/VbSojzbsfiZGQekuftW5cDzeFcMBOxS1VRglKqldds4a1b6rA5MBlO0NAEK
         ud2ufBUU5RmYE5lmD6B8VDTIibExcagjUUzpCXB2VNe1l/JblRC8sp/BiunqX6k2C/tA
         27ow==
X-Forwarded-Encrypted: i=1; AJvYcCW5lHGgOORg+YJ/lidXBVKljI/gBJV5UhojIQEQd4sD1TDo0gwJ1ink75XEvNP2BY6ZypEIb1zIDjyDYtAq@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGnsuDOxgQY4VAFZg+c18E80EUoRnfvEteXVo7roVOLWBBmeR
	pXISBmonOCk/+FmNP9fNvSQfushkWUhczXy5Cev7AVBJk62qevcxBLqpJCwL03I=
X-Google-Smtp-Source: AGHT+IEaZ/prco7C4oF5lCWqhRZLR0ygJ+Go+pa+KiOBjSGAm0bDYgzb9+GyjYftuCC7qtA8vT67yw==
X-Received: by 2002:a05:6a20:c791:b0:1d2:e94d:45a6 with SMTP id adf61e73a8af0-1d8a3bfec45mr5025125637.14.1728484899516;
        Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb64sm7852764b3a.48.2024.10.09.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 1/2] mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
Date: Wed,  9 Oct 2024 23:17:27 +0800
Message-Id: <20241009151728.300477-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009151728.300477-1-yizhou.tang@shopee.com>
References: <20241009151728.300477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
only used in the bandwidth update functions wb_update_bandwidth() and
__wb_update_bandwidth(), but also in the dirty limit update function
domain_update_dirty_limit().

Currently, we haven't found an ideal name, so update the comment only.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..c7c6b58a8461 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -54,7 +54,7 @@
 #define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
 
 /*
- * Estimate write bandwidth at 200ms intervals.
+ * Estimate write bandwidth or update dirty limit at 200ms intervals.
  */
 #define BANDWIDTH_INTERVAL	max(HZ/5, 1)
 
-- 
2.25.1


