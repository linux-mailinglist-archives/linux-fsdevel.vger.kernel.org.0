Return-Path: <linux-fsdevel+bounces-16609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBF89FCBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82301C22C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556FF17A93F;
	Wed, 10 Apr 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBDbgWpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB916F0EE;
	Wed, 10 Apr 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766145; cv=none; b=ESCv9Itnup/wxvTkifvFn7ey2nX5nN6wKW0edxvASbCU/1BFfQm3krBlQzww44dqSNFE9vE/tZW8HHnBUi7hFx5jkkfVemErf3g+6RyOc7IDVrsxWbjF+OE0WqFGNqD/mb5/kroMf7FPx3Dpl9DDLI9JOiQUa3QvANWfqGAHj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766145; c=relaxed/simple;
	bh=RSc60GGCkzefo7hAd7oUdI/LD2fJrAc/bWt6d7Qbuac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hJmI1up0+9vigVowUrUGxD6st2S4wHj77sEft8kdl2RuKnOBI3dIr62RUCTBZVCwPPm0LBUiXnzRocByo9/+frqjKVMu2Xw+mJ7m1ZWKUm6Yf/736edVKj6WWRVwNQefWIs2U7WQCCN3Y4mmzVaAzd8RsjhYWAVTgNFwk6nTNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBDbgWpU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417c5cc6be0so2444775e9.3;
        Wed, 10 Apr 2024 09:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712766142; x=1713370942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Un0q94+0D1nSdkyt4bWQE/2WmNoTX3iVEbAyLwz3Yqg=;
        b=JBDbgWpUunTNpdjAQPYLkuJByLNs8Ewv/GR0W7WOXyWXKYAb8Xi5Zb+BJgYo1cPmtH
         uQy/GfNIBDG2SBFAS/QO4BQmRATtbJeOikn8wDOt8j/AjcAAXHpPcQYIJJREam4F93xh
         28oCKy5+Z1lsePu6S4ykUO10sn9MA1MLXgVT6a4Y3K3GCpvzujnXkjXQnaDcHknLv/W5
         vTuhkqY8z9pGCyOYg/MlLlmjG/WzAS+fP2Tytp2sZSghjbZf+zzIabevBcew1xUUooyF
         Y7nmql/lqz4HR6BDyvAQ0E2ral9TRT/kS05UH9MoXqyt8wduh7KQcz/NV95KfUBmWyVM
         T0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766142; x=1713370942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Un0q94+0D1nSdkyt4bWQE/2WmNoTX3iVEbAyLwz3Yqg=;
        b=IEHi7tv5UtWGN+CpRLtPLtxYSEZGKOo22kZJg+2WykOGnVGXxnIuFq0uP4sB5KXIV7
         lOddFHln+6tnDpdGNyUyNm6Bgu5q5+9alHlWjFY4UOIMTwCEoZoRF0AYGvQxdRNF6uol
         dLKJBvjP1NVpiEkf/g32Q5VU/xZrWGgNXCKbkUeG6oM5bf5biPTrELLDIZzCXCYMoSct
         uqmDBe4KCgyRnjaz57BhTRf2RR/P/6nFkdhPAqsy7mDiva7g9DVuGB2jI1LrSx72b/qy
         QSOXo6iF140+k6Q3sEQ6paK6c5n7+7CPweFPoUSOVSotEDdv5HKUVsyxnPJXBxo77foI
         lvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxGfAYJUSUpW5qAPJvYFBEqTPiURyhbVVtJTv2UjnE1luBjlrkfAykboK+37XjEilv4GmF/NCFXKpntzU3QsN8U37BVtlTe3WBwhxQPS2L/e8Yzg2293aurnFxz75oZHBftAnS6iubpXOExA==
X-Gm-Message-State: AOJu0Yz8egv/B8m2ePV3YKgBWjx5Q3/qGMUTbYxbuod7Hb+lqElUYYr9
	WahvvROPVWVM/zKXolJ+XnK58zt3N7QBrLD0UbdNzs+P4cyDowHP
X-Google-Smtp-Source: AGHT+IFJ2sIdGoBtfQPeCbUI0llgwzc3jXatjTyMfEH/mraGoPhvOR+CHYmovvJX5lSzWIlYVxWdGg==
X-Received: by 2002:a05:600c:4e88:b0:416:a6ff:bba0 with SMTP id f8-20020a05600c4e8800b00416a6ffbba0mr2509726wmq.11.1712766142309;
        Wed, 10 Apr 2024 09:22:22 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b00341dbb4a3a7sm14129528wrs.86.2024.04.10.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:22:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/direct-io: remove redundant assignment to variable retval
Date: Wed, 10 Apr 2024 17:22:21 +0100
Message-Id: <20240410162221.292485-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable retval is being assigned a value that is not being read,
it is being re-assigned later on in the function. The assignment
is redundant and can be removed.

Cleans up clang scan build warning:
fs/direct-io.c:1220:2: warning: Value stored to 'retval' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/direct-io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 62c97ff9e852..b0aafe640fa4 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1217,7 +1217,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	 */
 	inode_dio_begin(inode);
 
-	retval = 0;
 	sdio.blkbits = blkbits;
 	sdio.blkfactor = i_blkbits - blkbits;
 	sdio.block_in_file = offset >> blkbits;
-- 
2.39.2


