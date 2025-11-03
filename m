Return-Path: <linux-fsdevel+bounces-66839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F7C2D3A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342F2188A5F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535331A559;
	Mon,  3 Nov 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mly6Z4mD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D3E27FB0E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188495; cv=none; b=npRQ/YHjen56O6DVDVZ/7rWM/pqVTUuDt+b2T4odcQYaj9unbBqC0b/UoUCaxOyORCeTdzI6r+bOupL4C9f804YkyyNpW4VYm6jkg3+A6Rrl8eH9diuxStU/OacNXblwsfxPbCpVNa+v2DIpHkvetxgDxgZI/HnR9sPryNUkW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188495; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBiHPZkLGo+KHBVhTjDTz9oR+K40QB9gnRQUyk6tK70SEj3jVJm+RgAqjlu5etjs8DYPIdJYTjF3BLJPkD4atp2psm8zkb78to7hgtOKB0x8B/G4+4klNk1KnX461okB6vLJSgU7IPaZWqxklYUEHnSzVexcYqHYSUNnyIQJfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mly6Z4mD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34101107cc8so1429234a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188493; x=1762793293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=mly6Z4mDv830e117Wb/WZgDoDqVTOArVC6L+MlO0OvVQ4iuT+wrIJAOhFpJFqEBmbS
         DHTEMhiowsYxbYlyyX1TDHQwSgpNwQ3nIln6fkTLmcWJ62oAFyNANcIYG7I775kPBGYv
         qjGlZTVGqan2l5/Z7tAFhODGqtTLvbjd7mYxk0cuGo3l2B3P/8DXWrlURCi8GhvUcPq5
         WAjp++Bll1OlWSGJOHrvXSzQz4gJGCFedWfa9jt+O7aGVUZNsCIvQsq+f7hMt+j8y9zF
         bqsiJmweBjT2QCUNi/dBfmURYpF01wzFBPD3VRPMhOuOI8PKOEXwZ5j826K7qJFqul4B
         ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188493; x=1762793293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=NI09ustqg15nprT7XVNSKepBxWSWoZ2eLsxOSgZmxkaY+4UXyE1LRNU8Z0BFS5Z7u8
         MuLSJZfnfxK6WMyJwi5IiZ2Zwxmw8tFEQFtZiHV8APN9wr1vaVoXv/zNb/L1diGOKCIe
         QO+V0jv7UtrXC7IL7gjRPGQJanDFv+IAgxSKSLxXHNaMOxHTz8KEWpGJPcIngG4daDhD
         eijNQBTckzDJNRS1/1ofXmoJQbGcVzidjZWbGMoKN3C9Rg6dQKMfvlHpVNCM4FecBgkq
         tvQ6S+Tr4Mw+oGF7K8GHa9HgMsDQhBsj/EGTUSTuXPDWWp8UcgStyiEjoos4yy9ymh8N
         /cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeWlElxHQABAMxO7fTCBR9QEANOF14+I5s5sA96ljpu8DMLR6vMaqglfQ3FoJnRPesJUjco0u10KtHty+A@vger.kernel.org
X-Gm-Message-State: AOJu0YwUT4g+4M+hLuA4vUcfnCnJRB4C9+vv3dF8UNZILPSkzo7dfpy2
	tNmvxA2kx0bsO+8sRbsMU1gxWg0WOPooiPPuTwYqKNYWmtYi17ieo/kh
X-Gm-Gg: ASbGnctHUI6DR+uzpwPQNsqtXWj82o7GioC73Va26iNruUqBJgDSsuATQBeQhfpKOjR
	o72qm3/pmUOG72tqHz2ZfNJ3bjgF+pKNjLAtTT9y5TBoHJyd0zwENP1cGxzXvLeXk/6JPaPYBrQ
	1BVscm6MSShfpqmVT/BV46sVfz/1/tJ5eOGA8cLjgZI3R2508HLLj8sh1K++GBidcysw5yu6/Qf
	/HqB1En77ljo9x3BnwFBdOVnqsOff4LGBeGjWXexB3YbbeQMz2lu/wgtL7qvuMymCoQ+WhYSs9k
	Rx+12skaskUl2g+CyMF4W6D5KtU43uLq6VVzDGXvofDJLETfaCONSTr9FJ4JMdgp98L/yWQYvTZ
	q4gYxcn2epTTe3V/swln9T7JlK13xXoZwrJ2Jz1q/jzb6my/sjrEJcrYq5jPvYozwstESJZerxe
	bhZwIJwnPk01obqnm48EnStWneXdg5AtxkxBsFx72iiw==
X-Google-Smtp-Source: AGHT+IHyVbpQ031khovVH+RdF5IYFXxXooq/uMJcv6MssOTN24pCbmD2Np+fsrwq7RaQP1KpB2eDcw==
X-Received: by 2002:a17:90b:3c52:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34082fd9099mr17153531a91.13.1762188493051;
        Mon, 03 Nov 2025 08:48:13 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:12 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v5 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:47:20 +0800
Message-ID: <20251103164722.151563-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
accessing the filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 719c1e1829166d ("exfat: add super block operations")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/exfat/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
-- 
2.43.0


