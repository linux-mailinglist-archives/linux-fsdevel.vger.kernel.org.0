Return-Path: <linux-fsdevel+bounces-34530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAACC9C6489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D8B36771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D221A4B3;
	Tue, 12 Nov 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcZjzfz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B82185A9;
	Tue, 12 Nov 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439549; cv=none; b=jnmLevgznLZpXDAIdiG0uBE9JwIVbhZWDXoimo743V71CDOWL+dQYHScDT1Uyec/588/ziKnJ5HkPNJ89BRckwi9xqNTgGcoaMJRQR4Yk003q0DJWqbH4sXJT9mLcI6rrqn6klvMjsGr3+xc+BT7OfulYmF7H5GEzx91Q5Ta+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439549; c=relaxed/simple;
	bh=uC3ScEW1U+O2Wc2A9bSGiVmy+OUmm1kGk/1ZnabR03U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dcc6DTfHkyPUgs17+ojxHz/O2DcIeSt62NdhsG73hhsy6AGHolGfx5badWwCFEKfvPQwO/61H6ldHvZXDdwLVTHGLvYIw1ahJy9Z6pBu0LWTurEe/bb6m7AQsMeWj/mbYDDvyqQ3A4z7tgMExElcuzFBiTNH0s4H5MH6AZzRB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcZjzfz7; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc1af8f10so2588598eaf.2;
        Tue, 12 Nov 2024 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731439547; x=1732044347; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpVYJlDWFg+wqwWY/7YvJ4k8chIUuFrMv+OyIyUOhHI=;
        b=IcZjzfz7QpQyEmERajh7sHdCf+ypO/RuP7kqF80gXqzFY0snThBryubLnvKQ19N1nD
         UKgIUQr5IcQ42D8/z7Uj41U4zpVa+vGsC0lb/bFxXXEmafnZOx/peJjGot1K0KF2u7VI
         yRAaPFMgLve4tRjctmGYa7eF+B/PA1YPi58AeRkWeCU/MzG3h00hVmo0AeneQaZgUnOs
         HYBNaz4xFS1mFnJSZ57eUCl+/GQYHtZ79fmcv8Q9G5AHYintBqTr7VKkF0lTcOxd8c8j
         GS1Q7+BzTmTf9ovyS0FyOxxeNoKyw+Cg0qqtKLP0k/P088Op0ss+0LRSPVIiDbr5YmTT
         /FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439547; x=1732044347;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpVYJlDWFg+wqwWY/7YvJ4k8chIUuFrMv+OyIyUOhHI=;
        b=tR689Zo2l2t20ambwqLt2NyTCvlETnEOcT1tO+xG/o8uXbLmBWj8K2hf65Fu500yfq
         KEc/noTbjrCFQ1lcjh2Td8kjEwfnqhz4BKP6Oci/N5ZeVxkKp4czF/LEHI3xkLMMAErz
         Lmo8CZv+Aa/vYdIa6Wt6Zaw8rVUrSYGOaNUrSTnE8DxFtkyE4xZkaHZt4R4DE5pus8+9
         Wx68p9H9qi6sXOHhnCzL7OJ3QzTgkqcY96Aj9+Wk8dVxV67hyzrqq6JwYByPtCO5Ns34
         +4zxcGQV6X1o+rOUj0BO21Ld1Qk1CBj1JNYHH0+vUtK4AzYRaYXXlUzLuqGxEBjxI4vM
         5xNw==
X-Forwarded-Encrypted: i=1; AJvYcCVtDSmVEp4zA+qysZvVJpZZMkbxPzFbu0pcOQIeD6EjU2GagL90ofMfHocZmOYjAYxoNNh39Ocs0nRNMEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSg6VgwxrelRuUJyRWTYpDEHAdd2IxvzCAyzODgqeNvh3mjoFq
	DCpfeCum4vO+7eqKIMu4ajTnpauKD9agM/jDg+2uJCsoUD8WeMlA
X-Google-Smtp-Source: AGHT+IFFRV2Y+4sab1Il1y9pJ2Hlo0TmUnKS43V28HLFId8FwN6LDig0N+eoxL2bSpQakMV/GzGL0A==
X-Received: by 2002:a05:6218:280a:b0:1c3:89d4:e888 with SMTP id e5c5f4694b2df-1c641f40665mr871574455d.20.1731439546671;
        Tue, 12 Nov 2024 11:25:46 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:2ba5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm78395581cf.86.2024.11.12.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 11:25:46 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 12 Nov 2024 14:25:36 -0500
Subject: [PATCH 1/2] xarray: extract xa_zero_to_null
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-xarray-insert-cmpxchg-v1-1-dc2bdd8c4136@gmail.com>
References: <20241112-xarray-insert-cmpxchg-v1-0-dc2bdd8c4136@gmail.com>
In-Reply-To: <20241112-xarray-insert-cmpxchg-v1-0-dc2bdd8c4136@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Reduce code duplication by extracting a static inline function that
returns its argument if it is non-zero and NULL otherwise.

This changes xas_result to check for errors before checking for zero but
this cannot change the behavior of existing callers:
- __xa_erase: passes the result of xas_store(_, NULL) which cannot fail.
- __xa_store: passes the result of xas_store(_, entry) which may fail.
  xas_store calls xas_create when entry is not NULL which returns NULL
  on error, which is immediately checked. This should not change
  observable behavior.
- __xa_cmpxchg: passes the result of xas_load(_) which might be zero.
  This would previously return NULL regardless of the outcome of
  xas_store but xas_store cannot fail if xas_load returns zero
  because there is no need to allocate memory.
- xa_store_range: same as __xa_erase.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 lib/xarray.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94ca13e11f350c6bcfcacc2040d0359..1b8305bffbff07adb80334fc83b5dc8e40ba2f50 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -435,6 +435,11 @@ static unsigned long max_index(void *entry)
 	return (XA_CHUNK_SIZE << xa_to_node(entry)->shift) - 1;
 }
 
+static inline void *xa_zero_to_null(void *entry)
+{
+	return xa_is_zero(entry) ? NULL : entry;
+}
+
 static void xas_shrink(struct xa_state *xas)
 {
 	struct xarray *xa = xas->xa;
@@ -451,8 +456,8 @@ static void xas_shrink(struct xa_state *xas)
 			break;
 		if (!xa_is_node(entry) && node->shift)
 			break;
-		if (xa_is_zero(entry) && xa_zero_busy(xa))
-			entry = NULL;
+		if (xa_zero_busy(xa))
+			entry = xa_zero_to_null(entry);
 		xas->xa_node = XAS_BOUNDS;
 
 		RCU_INIT_POINTER(xa->xa_head, entry);
@@ -1474,9 +1479,7 @@ void *xa_load(struct xarray *xa, unsigned long index)
 
 	rcu_read_lock();
 	do {
-		entry = xas_load(&xas);
-		if (xa_is_zero(entry))
-			entry = NULL;
+		entry = xa_zero_to_null(xas_load(&xas));
 	} while (xas_retry(&xas, entry));
 	rcu_read_unlock();
 
@@ -1486,11 +1489,9 @@ EXPORT_SYMBOL(xa_load);
 
 static void *xas_result(struct xa_state *xas, void *curr)
 {
-	if (xa_is_zero(curr))
-		return NULL;
 	if (xas_error(xas))
 		curr = xas->xa_node;
-	return curr;
+	return xa_zero_to_null(curr);
 }
 
 /**

-- 
2.47.0


