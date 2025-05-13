Return-Path: <linux-fsdevel+bounces-48904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4EAB5809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 17:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3D286772E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122DC2BE7A0;
	Tue, 13 May 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VVjGZvNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08642BE0E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148622; cv=none; b=CrjmPWOyufOiS2sm/cQcwUXF1DcO7dRyFTn9NL9Kc3vd8HlBjs83EZIvz9XGRsNeDOVyfK0HDkCYbMSlFqdwOlCcSL0HmO51/4IyiqxFqhpMm8dNU8bp8PnPQtkOsZ4tYZGZT+AiOVFElrhNZP7zKuWqO+s2a3GRpxZDidON7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148622; c=relaxed/simple;
	bh=OPoPn4GqlKNKnmfT+RpBvoHnjFL78UgPcPRPUpvI6RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHFJtzmdy9veL+6hYH9DC8oCTocrXCaTKzBUCOWlI6E3zWq1M0ImQ/xsJ1UKOnLXPTSkVuYcMtDQKyEgbnhBaqQKrBuo8PnKfwAYzLdg+p5ViNv5FVTNIm+96ll3F6YSZhW46a7LDTLUFOShMvh2RZ/p5YUqFXlja9ABRIDBlHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VVjGZvNW; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-442ea341570so8807745e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1747148618; x=1747753418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db2aWyNP2LxWmcJ/JMP/pRSFXc//O8Zp66NOQ220IGQ=;
        b=VVjGZvNWFrF3+PKvfuRH3rBxv5f6j7NTsnx/Kwy0zY26y/HlqIs4VNNGI9DAtGyJX+
         V8WXUrVU/dp/t8vS5AXXq7EF13KgJ5M6hFTX1joFwylAiVQXsESL7J5CnZoifuPi0L0M
         ytjhC9mgXvrVOdGNFuTaRSbe91h+SydTFZq9ePp2vL5T3RiJ5exY3e0xC0XGAy4eQnyg
         lhX7ZSZ+/EZ7ZNHHY70aghzotkBECK8IyciAkr8bSTz5POe4fdVvXWfVs+yvwer03puN
         xBSmnhGebbbHL2RDCqLESWG637KnUNOjGo3h70+nBdMJ5MKgU3HYgZ7eyiBrv39IT+ln
         pIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148618; x=1747753418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db2aWyNP2LxWmcJ/JMP/pRSFXc//O8Zp66NOQ220IGQ=;
        b=TvmCnHfanaoGev44RSdYgwAsqwYuBLGFfIh1rGMeWrGtYi0qkdHM7+bf0lr+Dbegs4
         1xwIxtQ54i/W0kfeQTIgGHNepIhtDORIMRxg6zzDcpXghWuSMRj5U4A3Ty3NSuUj4fub
         8hFXhwnsJGBPEvGkpkmdGHjThpu9mQS3lD2ilvN9QXJPYF0r9Aa+uagH3T05ZTxbXLQN
         slYGuOoYFvH6I8jwJnGzM/iGiRTUES4xt0EmjVVvTN/pX8nGSmhxgoCXne7cfHr0FHOh
         79PvqDPFOhKeC5Pk1r1+MWkpaab4Y3n7hq9b+lxuwq9TiqJkr3Q0m8diprKmoxsq+ikF
         +WdA==
X-Forwarded-Encrypted: i=1; AJvYcCVR/kTgPZoidzSfUyUFlxZBGwPImCHN+7WIKQy5oKxqn8erb+6141I4mlIDC8DrjiDX8qt8FMXsrbAFg6XA@vger.kernel.org
X-Gm-Message-State: AOJu0Yya6fmzSOkfsoI8kGv/v+OyBVtL71Vkvzryb+4Po4T5+Rr5jAoR
	epASjZINpN21BRbwNRNYpolXW13T+Fcx8izGoZD4C4mV2pIFChZEnkcXK0Rx+qU=
X-Gm-Gg: ASbGncuUXbDbi0SidoqWEYsOzNJ3KzpjoYtw/3KtWOZSy3lPhS911BfFxgk7pnuSI6+
	9Ww8O/P/Jg1EjUoM8A92uK2oUQnIt2xBMdkF4BZ4IgY+zllLZahguhRJ2OSlWbCwhqlL4c0GWjP
	gD2LQ3HQa9bUz0VrB1YOobgFXvDI7s1Hfk8G3W5F7s0vXKulRFgO9I1vxRpVal/hd3Tc2EeDjjo
	6ZKcSrDOEwlqAyTazBYHzm6ncYziywfampa/9g1/cDijP4qP6x/kdOhKlgIX1PAUQVshjQaKAw/
	bUYTDOzic2R3BDk3kTr+2v1dxp6H9t+7NEfkAoZ63wJQeS1LjRU38qogFsXyD+vnZbJcZdNPUg6
	RrK5h2tVSurU+s3zCrxttTrZK8u/xavUhIYyz6KVwJSGE2n6s2Cc=
X-Google-Smtp-Source: AGHT+IGc+nZ62nfymS4OrutrGsR3feSgKZIQetLXYz32d1Zzau1u1NeuDlXW2cxVVdYZoFLjri83Lw==
X-Received: by 2002:a05:600c:1c8c:b0:442:dc6f:2f11 with SMTP id 5b1f17b1804b1-442de4a8ca9mr86448255e9.25.1747148617838;
        Tue, 13 May 2025 08:03:37 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f46c100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f46:c100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bc2fsm106800805e9.20.2025.05.13.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:03:37 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 4/4] fs/read_write: make default_llseek() killable
Date: Tue, 13 May 2025 17:03:27 +0200
Message-ID: <20250513150327.1373061-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513150327.1373061-1-max.kellermann@ionos.com>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows killing processes that are waiting for the inode lock.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v2: split into separate patches

TODO: review whether all callers can handle EINTR; see
 https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/
and
 https://lore.kernel.org/linux-fsdevel/hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3/

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bb0ed26a0b3a..0ef70e128c4a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file_inode(file);
 	loff_t retval;
 
-	inode_lock(inode);
+	retval = inode_lock_killable(inode);
+	if (retval)
+		return retval;
 	switch (whence) {
 		case SEEK_END:
 			offset += i_size_read(inode);
-- 
2.47.2


