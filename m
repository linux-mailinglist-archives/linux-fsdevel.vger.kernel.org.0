Return-Path: <linux-fsdevel+bounces-67446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E40C404BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9378189DF72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9532ABEC;
	Fri,  7 Nov 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To2POnNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DE32938B
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525327; cv=none; b=pNPd42+nsuC79Uk9AyJeaKRIeMc8DxCSYLCP/6ia2bdlOLTqs75k07tZ9GWE+WfCnp2If1FjWOFPBPbmRmbX3Sx0/3H9Lm5gfxXcqjiWdq/Js5Nmm+01uFVoIUafef7w3SX70YLNwPLK9HXGQgvlj4sURAdhT1Ilwaw1T1usVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525327; c=relaxed/simple;
	bh=wS2imuQ9BmkOhIkqMvqqB5gl66Z+pbAiZyZ4vNX0hTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAgIg/7z8hzHhWmZBWAPtVyisiEs2x6BywDAF1X1LZU3sn1rzjtvc35ajkC5asK/gjURJ6/24TJzbeNXeSsBwiHeT7QFNqrwQeOzAjAzex6bZQy0UeeLuId9ikHBVCZH9DQhEiPQfcuutSHWid4W1aDxYmMgh/zc5pQm7HsONCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To2POnNR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7260435287so117167166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525324; x=1763130124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=To2POnNRLv1Z3RMuB327G2Bf9yjQ9YNRisL8V7Ov15aKZICI4Ofq0UP/LIsjXK3XcJ
         VM/LwdnxjyCrL9PnHBrxhsZCG+NPykzg0l0pv5mRfhqC4hWrY5m+Ozha1bnoZfy6+iYy
         l11vn2RvuaI5l0OjlNCmjYC2kJUYPQzX49GitXv5ByPDkv57UpscjjzZEbRaW9uWdpv+
         mZdwjpZyiDA7wRjBTnWpbImi0ZQl+ClMQo8gZfEUJwOETqt2ZIYoZ3Atbr3xsPzg11Sj
         6Sh9e9DRaAWTOuIlOxUa4w5h6K+nKUNG3PSqzYyCRRclZ8b3LfN9EDfyBN3NIdY6GF7j
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525324; x=1763130124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=cPKgZMjVsR0ZlYI7Cmue4qg9yGm1f+5nM8F6EJzYWmTv6qVW+/GMvpDY7D9XqFFl1/
         ltByvk0yRboOXUTI2venOwuPjfxebn69V226w9VtMvH2tbB5m02BQqt8hu/Uvja+H1UL
         1hENlOh/GP9oMXDcFvLs5F/Yg0lKD+Furi/+nJpKSmoVAv+G4/1feZqZ8VdQ5+9b9Owp
         6R7wgEvvcrkz075yR181iR47Ms99IHayftifC28QEfUiPJUNaRjSSYv2P0RwtgF4KWSu
         a2QtAu1lIlQ1KA8qnPrqOOyVD821jzTcC7dIRfQlTEb6vFEIqHqg1HcTYwggThcjX5L7
         Z9uA==
X-Forwarded-Encrypted: i=1; AJvYcCVL52VsNcH+JpWiobL4RKtg5+m6/mkik8VOnLAJwtZY9e4w2glwIwPJcaxJzjiWUY1pO3MZZeQhEr3DQR9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlx4hfGJT1LTegxDoJB0lMwY8rdBQZxmiofr4D2xXn6bZt7l1h
	clBqygXpOn5ZmTduGFHF5kxD+RwZwni7Aw2GQ5y60KeUdaXT1/fDlRt3
X-Gm-Gg: ASbGncuX+JR2X4dXk8Z4N0zBMQQBe532Tp6UMR4P5/dARRIYe4fiJoCCeRtDQTBhApo
	EU2+S5NF/5wKYrnCV1xoNRL8YkglXpFsGwOyCKy2ontwVTZaV5/ggV00nPhBSbJx9BGRNm9YZSV
	AW4LklGyqnSpb5HtfgDu+8RWHAXHGeo0wJt3Gk93r8liMQpkUTppi3dlXIpsiYbK5M8rlQ6i9ai
	NGhpOi5eVr4KL2vAPuYHLpNQL1/HSlmN8RWB7NfOfsZg4xh3nRNr1kOUNvTWKsTtYcV1OyDd1bL
	c40epvlICN2ZSpPUQWUR/5TVOx0ljfS2eYkcn0IgPoTdBBIYala6QtYSgClQ0kMNH1IvRuOM/yf
	gUjQKO+zi4p1PROJG87vFWN97VL1fn9fZmtTKgQoumJqr1f8Sbh2aqklodkvwHsf3ecvazRUnnK
	fplWLsxZl0cYoie9sQ0myIFiorfzDCc4SVWhviT5DCo9Jz0eOs
X-Google-Smtp-Source: AGHT+IFYK2b9ojdXtTAd4PTW5XlFiit6Z3g1OoNfduNaJTNxwuPOLhjJOAV1QVecyGCifhAj28KZcw==
X-Received: by 2002:a17:907:3fa5:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b72c090e626mr342966366b.31.1762525323963;
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] fs: retire now stale MAY_WRITE predicts in inode_permission()
Date: Fri,  7 Nov 2025 15:21:49 +0100
Message-ID: <20251107142149.989998-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary non-MAY_WRITE consumer now uses lookup_inode_permission_may_exec().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6b2a5a5478e7..2a112b2c0951 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -546,7 +546,7 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
  */
 static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 {
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		umode_t mode = inode->i_mode;
 
 		/* Nobody gets write access to a read-only fs. */
@@ -577,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (unlikely(retval))
 		return retval;
 
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-- 
2.48.1


