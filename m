Return-Path: <linux-fsdevel+bounces-45928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF8BA7F68C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F02174955
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 07:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FF264F89;
	Tue,  8 Apr 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aooWy6bP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E3263C74;
	Tue,  8 Apr 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097846; cv=none; b=B/FpvNSA1prz060YAbc5ovnh11OFv0vZA0QClySTXNicc0NXNgAEd3iG0nWf5XqBbhNifrEb8KaCHzOh8+IcCYxyz2xOHwtq+sOFv8317egY1ENJsE2zJSkJtqEJCGjMi0nRA+GEL07OkyYDHLOxO29LGJWRelJcP1vAst8hvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097846; c=relaxed/simple;
	bh=ar5XQBlEF7k0tqNfubHLeA/je1jwcPGbfwtzEwWTm8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU3UMWKXY3YkfkOPUjnBdEUaQXdfuphVUH63WRtky4YvsDu0LDimpqXAKpaYmnZdJebvWkhmgXYkfKRO7EzHnsg/YLvrtGlcAWg1cQ3ICQfbSKiUB7EPAm8dzBaqOUKaHRPcS97Ptt4/qdTzDrU1N69mmDKdlL5eTcp1GHq36pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aooWy6bP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf680d351so36388435e9.0;
        Tue, 08 Apr 2025 00:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744097843; x=1744702643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+bV3HaOye67+5wSUQFO1LCTh5AfAgyxfb2bNbTE+s74=;
        b=aooWy6bP2KOKNR8vK5NP7K/kwlqCqVOn7j7bMiKBhmazL8tF4KOvw7jHHRuvMg2nO/
         /hn9t4hrvwonSY0jCubLchgKsHMus5PSKtpQKJYtdF7I87XWfRZoVN8HNSwhJperXJXT
         kw5qNzoLB6fVEX9kxWKwZf0FTlRDIH/r/RhlqcUbxnS67Ge62ZDkFOcKkiTN3UNZxEla
         yVgNxT0KTNxZtLF5l/SItrdLJpBC+pIFLaZLYjRl8OOUzBnQFY+tXGnp+GahNy4Y9pbq
         2u3qPFLA4a1DvUYifB7FDqbrUxZz2CpmfvBxUSZYg7L1jbzM8eLVcq4kGon8DRYocaVm
         pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097843; x=1744702643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+bV3HaOye67+5wSUQFO1LCTh5AfAgyxfb2bNbTE+s74=;
        b=mHfT50cZ2o+3nMsn/fh9smwQxGIcvN3doyg+hJ807ItMvliyuJvWEqhpo04s+DaYSz
         DXZGslESp2zAuczkagnubP0G/k/MZvwhh/TsWUq05MdA3Ko6709L4uvhjQoCKA/ZDm1D
         h1oZ45mWBumvEUrGEtDTnB00wVfHpnponGXbwQHN97FGcJHwNzcgw6UkIW618P7IUpCG
         wOiC0HTu3qOotrgLHKT4m3A4+aX6/0Pr/CLgcBKkHdJh0J1TDl1u715XKqGYDjFYyuc5
         1Rmvnmje5G+VW2aob0LXTGI9AWvLLscCvZ6HHx6RSrTwZKBV3zMHwR37FzOdFCHFsHAx
         LNAg==
X-Forwarded-Encrypted: i=1; AJvYcCUV1uZ/U5Iys27BuHxjgLcHJMeR713okT66p9O/hjHpxC63irFOcyo6vkdvLs3ZbTZffg18KMbRHJbB6I1f@vger.kernel.org, AJvYcCXphyaIXYUxzIGUXPDUyP7RnydNPU3k5DUFmrIuxIKPehTxlQNksZ1uIygF8RmJOPSCiGAnYs9CX86RKE8C@vger.kernel.org
X-Gm-Message-State: AOJu0YznlCvoQJfZ+FDJqE4TK1+kLXWxTPa7FEWP/1VZxyq5/C9SjQ+Z
	ZQcXsltwRQ0XhQAbg3P8LBY5QASODh5wBLwAZX4yKcZIf03c0y7R
X-Gm-Gg: ASbGnctLJztQpSACwxwDSVRHWZf6Br96VnTgy3qJe4MuAZmV6gx4IGYJXpgFHfs9vbE
	cMJQ8xcKYh3nzFZcHfQfuw1+gagkkdQPz2Ph5R4RZ5mkBMYo2cd8TYGIfufJr33voBtGL1DMETz
	Z2TUktN9+yoVUIMi517BxpU0kM9jnB0OF6rCNU90eVH6OKYgDpftTmNALGi+cZ+YKLsMXZyuB8t
	J0PUxL9uZhccdIhJjF82CT5Zi3pHjIOb9NfYFbUbwkKhyGjns+qYMRVhx26wXYe51iEcMFts8qW
	7bb6VNVeg6F+QpEmJgrltCdKMBz6B3q/FY1098LTv/MHvWobltuY3snkzIxQAm5HohlxJMQ=
X-Google-Smtp-Source: AGHT+IHzV7lgRhl3LcbHjjyj7Zx8jLcnrpxEQQSh7UM3VRWVmNsHnrWx+IPdYbdIeKdplyQbnDd2qQ==
X-Received: by 2002:a05:6000:184d:b0:39c:266c:434 with SMTP id ffacd0b85a97d-39d82110daemr1768446f8f.27.1744097843073;
        Tue, 08 Apr 2025 00:37:23 -0700 (PDT)
Received: from f.. (cst-prg-66-32.cust.vodafone.cz. [46.135.66.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a7615sm151512065e9.9.2025.04.08.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:37:22 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: unconditionally use atime_needs_update() in pick_link()
Date: Tue,  8 Apr 2025 09:36:41 +0200
Message-ID: <20250408073641.1799151-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vast majority of the time the func returns false.

This avoids a branch to determine whether we are in RCU mode.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..ae2643ff14dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1905,13 +1905,13 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 			unlikely(link->mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
-	if (!(nd->flags & LOOKUP_RCU)) {
+	if (unlikely(atime_needs_update(&last->link, inode))) {
+		if (nd->flags & LOOKUP_RCU) {
+			if (!try_to_unlazy(nd))
+				return ERR_PTR(-ECHILD);
+		}
 		touch_atime(&last->link);
 		cond_resched();
-	} else if (atime_needs_update(&last->link, inode)) {
-		if (!try_to_unlazy(nd))
-			return ERR_PTR(-ECHILD);
-		touch_atime(&last->link);
 	}
 
 	error = security_inode_follow_link(link->dentry, inode,
-- 
2.43.0


