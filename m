Return-Path: <linux-fsdevel+bounces-57339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627DB2095D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0CE17CE8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B62D374F;
	Mon, 11 Aug 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLK6GBN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238492D77E4;
	Mon, 11 Aug 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916800; cv=none; b=nEC+nryJinKeq5R3ovN8XZq4NHcHxNTyXg9YgSMuIq1ajn6IURpVBnaQyzStTwWZ1lC/2YwcoXMBxdMhyooUheRtQlXI1KCzzwM4cU/e5TuYAuuxOGbPkxzYutMqTvfB4OXfZU+JK5a96+LC9qwMhZwQK0kNyrNtLR9yr6wXNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916800; c=relaxed/simple;
	bh=zBFiHfemwtyvXXsvAMZhx4anhbqrwOkhIvWvpmO2tLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8ECH5lCqbX5Y5lm1S/JDFUgU24FbRy7HH87NWxw8wIEa682SqhNBjzzEbVJU7RrOVVeII3XuzPc0sDDuPQrB1dYQ5/zs+qtTxG6ILWl8Wk3ATW9W6J9GqJSw9tMCI1KlGiomcM8R1xfOcZfsQfSQA6570ZjLa7sV5K+kH5LBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLK6GBN8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b786421e36so2303205f8f.3;
        Mon, 11 Aug 2025 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754916797; x=1755521597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IR9Tj2ZFkHOVuxQAA7y4iVif6p4KRJfjxccWwOTQQE=;
        b=gLK6GBN8afe23iZgVMeyT5ywKVQ3otg1wgy9YiPKHfisgRdHzP8fXugRPZ1yAR/1v/
         CZdSJg4qokpa8p8SEaVXwPlbLYZmjEFuTohO/UD3JmzDoYCdyTa+HULYNw9hRkaEYxPh
         0uj/04igBfPJo9qPYq82OgBsIGAftr+dinAR2mFRS+ZO/4G7zACLfV/ykoGxfa6ob6EG
         s2auNv5/SqpR+XhPDflrKKcGg15YiCR6vE5P3ZhZiMgh8lasI2ceQgD/UqMzCOeph0bf
         RD6m4de+j4I+qnpI3dGFFZW9STMzcSNFSnazUgMq/f/0m2FUD9iRl93qOw+k9uBy1jRL
         llxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916797; x=1755521597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IR9Tj2ZFkHOVuxQAA7y4iVif6p4KRJfjxccWwOTQQE=;
        b=j7J/7POlgXGYzsgg6VfVeD1NY36SzB9LprbcpgvaNxYGZugkRaT75J5x0ZfdV5s2Ey
         MGwcl2WQ6L6vRs58fArbSdJYbPh8LqrUBMsAZ3WB4ovAIzqGXVmSEY8Spcp7n2jTtTQI
         haCSX/GI6Jp3H5X0ZNQa799mu6Gxqi0Pb5lkKMURfXjOz3c2H1xU8fg26xSzTHXrKgKl
         pUu4MP/AWQ6hm3GQkqta2Gp7/bT0ZSeV/4bfX2qjYwSWG8V2ORqaMCXZHQAnajDDTzPn
         oeyb45xwA0rxBW52UnLw0PDGCZpQ9tvXwr82eVWjMhArtryHEmiPzMR+MAptRl47458O
         Qr2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJtiMa6ngu5Tnii6fZ1EDRwOiBX2jpy3u48N6xbBpy3a5fCRNxsAOLMlcZcaxSiOUsKIqF4iTs5/TyW0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5q+83xpPyeWIM7HM57MkMnNDCj4zYhzSzle2gng6QWZnnh8C
	qHAdsjYHebkFOvPaiJSohUdNF1E8mLg8he1v0u+v7022w5CtpsLoQqoUT5RNTg==
X-Gm-Gg: ASbGncvG60dQPpIOeP5gR8NQMe6O1vA/hgPmeK8JXhfd222UoCs0f6h5Jtl0KejkagI
	OM0HyHxWC+HO3c3+BFcBzTUgnseeZ3wpyrm1f1+jyAfQhI91MbTzyJThGEkCN/YIBYhst4pD9x5
	dLSVeiyOIOS6pP2FNqDJ7mzGA1eOeVm2shzO30wf+zzyftoGciC4SwWV/guOit+GCTPeQ3/nWFA
	3z7yrxx5AzCfrdrzz+H4E6Yhhz2ERLM2TrjVsAm0/Y22b7qYypun2z0QSwx6iaL0RxaDBNsVHhF
	Fb7HBZ5zQPEMow52lnEqzKmvX9XWxZPKmo0MgjP7pwoNIbOce/TTgxa9LYatfeT4GS9SEN/WRJt
	meGW7W+95gDfpvPJhm2Jf1g==
X-Google-Smtp-Source: AGHT+IHwd702a+KQNTgQmvdd5bcelZ8AJusFrlVzmIvThx90Mz4CBzwR/92RC2fBAa15d7QtMUdQzw==
X-Received: by 2002:a05:6000:290b:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b900b5108cmr9189025f8f.48.1754916796691;
        Mon, 11 Aug 2025 05:53:16 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e0a24bf1sm277093835e9.1.2025.08.11.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:53:16 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fs: Use try_cmpxchg() in start_dir_add()
Date: Mon, 11 Aug 2025 14:52:38 +0200
Message-ID: <20250811125308.616717-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after CMPXCHG (and related
move instruction in front of CMPXCHG).

Note that the value from *ptr should be read using READ_ONCE() to
prevent the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 60046ae23d51..336bdb4c4b1f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2509,8 +2509,8 @@ static inline unsigned start_dir_add(struct inode *dir)
 {
 	preempt_disable_nested();
 	for (;;) {
-		unsigned n = dir->i_dir_seq;
-		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
+		unsigned n = READ_ONCE(dir->i_dir_seq);
+		if (!(n & 1) && try_cmpxchg(&dir->i_dir_seq, &n, n + 1))
 			return n;
 		cpu_relax();
 	}
-- 
2.50.1


