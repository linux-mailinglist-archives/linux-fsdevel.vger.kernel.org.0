Return-Path: <linux-fsdevel+bounces-59254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC857B36E58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626E9461104
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C8735E4E3;
	Tue, 26 Aug 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AjnpHHL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4F35E4C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222882; cv=none; b=RZfAcMjRsYkp4jMFrPuLl6oenvKa5xnRDWRmUn2UadKIsVALQShF6ZrsgONexVJuV+bgW9WJTTX+W0OO11RXZWOHEoSyDWtifNV0S1ZLDD90Awmzb/pCLaKyt+DhJr+S7rTbgB/PO5NYqP1s2vYfjEwD5X+f1LMzWhY6WrAzyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222882; c=relaxed/simple;
	bh=9h6PPznuSE5nPJ74VSVyjjLvORGODq5PPIqVHYaiKuw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pn2cHXmoC4tTfW5Zk8JRDIHgWwwYiZ1WutvPscEz5tmi4PD1T2UhkXg3K/G3WKsrdB28HmftXVqr5V2t30QdVhW7hgCd0hIiBJeBO4vXv+8CMRg+H817yJYyaeC3aL108uTwtLueqmhrohBfAHxR10QzaYR4/AmTJdgd8I8EgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AjnpHHL1; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e931c71a1baso8240894276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222879; x=1756827679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbLQoR7hnQAMVl5aGLYTpEQarM8sb2EoAq+ZL5IeLT4=;
        b=AjnpHHL1enuJhFyTHe5bVpEY4e+nbhowgl8US8whiIL2vqfQkOmQ+mh8kNpkXDrv8o
         rpexrT8FbR4WsGp3PXfS46Z9RgG3qXJ+ANuaTGA18pBS1FdrFUEF+MaKo+JP6rOn/jnq
         OIRL4e2vtfTIBqsYG/QqQB3sN/NV8CBAhShtwiGvlQ13Xz1gOjMEKEx5bZB4LJ7/2+Fo
         GYqnOs1vJOw5V2TxHRN7skQFEpPN8KMBRtayCtsI2mf1mdNkGV2BE2rNme9tGFDOtq/A
         dBskaSGuwz6p+rC4g5eZE9J5p8GRbAlAfpq0CCAbUepksUVNDmiRNtmtEEPZs8NLJIbv
         EtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222879; x=1756827679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbLQoR7hnQAMVl5aGLYTpEQarM8sb2EoAq+ZL5IeLT4=;
        b=NlD5Y2h9RUaeYPgpe3bLtpMTuL13ZVAE5KQac3HJZzx9m+GyF7wzp71cZ3134/22ba
         RuZfuIlczhXW61ABFNJF0t8OlKk6iGAtQ89ZABRgrwjv1KHof6ViMaRBVnHXC+wNjY6C
         pfJ1Cqt+C+6q8mONdZsquRaDUvOc94SKwUlx/fSSpUPa7qKmhVr35HxQUsa/JYYRUloi
         Wrhs8NTA29urDK0JUDEUEOuO4a1BHHtnzCglJfcgFtntxspwRXU+WoxhWGFo0XoVOP6s
         cNiue4i8ALnzolVN4U1UM70WuwjjKSl9R8VCCKLB0TBCOtjv8L7IGixkiiVL5y9Bj1qp
         hF8A==
X-Gm-Message-State: AOJu0YwBfGvKZrpBT4FeIt1AVvPYDSoGsthR7gL0ywjGJnf/0kDa8p3e
	UzafNt0mlCEvwgzHZRLk2Vqk1RC6YPDZodGD+gozB2mOoguWp/+cMTkjhnuRwqln+lA5sTrBUDt
	ORLyT
X-Gm-Gg: ASbGnculeCAzPg6iujo87cbciVewXv4hy6CbMweXh5AJawJwgUX5cwWo80N3Mt33v9U
	WsQppIbT/JmK/9Z0wWBWlz0VgyMwzJde7r5ipVpUcTMgKFSbtFUn7pCmC/rJDua48QbHzaoivmV
	PMqYb0pSax0b5n2zOUhGNq34g/INFlumGT/eyOekVBccdtEw9WaUtfv3KiS/2sAqi7qSCLQxkzY
	ON6/aauAylZdwZF13uIAuW52vrrK1b9cB1GSKDvIK9/T2W8L3gnG8Be12lIlc/LfvpNNaGo1M3s
	/uoFJJgI2vM+2/g1eViI4aA6jwbEr6xJ3feUsPHw1hsw2WJMLjQ08TWc4tE8shH+DXAyOCr6UOI
	FeGeDkcSJQtImar6RkTUIsJWbXsiY9i+kgcufzyZb4APf0wc4f2XyBWbLZSQ=
X-Google-Smtp-Source: AGHT+IFVd/Dppsnb6E1/+4Q9E2BDcwXG8IrdClOe5QP1Pciq2pnbXmjT7B3KKQidZ+9xNPYLXeeOlg==
X-Received: by 2002:a05:690c:311:b0:71f:9a36:d33c with SMTP id 00721157ae682-71fdc41251amr159706727b3.46.1756222879135;
        Tue, 26 Aug 2025 08:41:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e9fa5d42sm189948276.18.2025.08.26.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 21/54] fs: make evict_inodes add to the dispose list under the i_lock
Date: Tue, 26 Aug 2025 11:39:21 -0400
Message-ID: <c500d99c66c4b09a212005fe75465745d5c78f3d.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the future when we only serialize the freeing of the inode on the
reference count we could potentially be relying on ->i_lru to be
consistent, which means we need it to be consistent under the ->i_lock.
Move the list_add in evict_inodes() to under the ->i_lock to prevent
potential races where we think the inode isn't on a list but is going to
be added to the private dispose list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index d1668f7fb73e..1992db5cd70a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -975,8 +975,8 @@ void evict_inodes(struct super_block *sb)
 
 		__iget(inode);
 		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+		spin_unlock(&inode->i_lock);
 
 		/*
 		 * We can have a ton of inodes to evict at unmount time given
-- 
2.49.0


