Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944603F8A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 16:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhHZO1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbhHZO1T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:27:19 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993EDC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 07:26:32 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so2520590pjt.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d8AdWOu1C2KmNDi0WuZ+5K7PD8/DNfu2a7FRFmIcixs=;
        b=NVHrbKNNmejnOhxqatXlgRmyVLyzSDH5ikPV2YDcC5ERc6T93fr5AlAVxrLQ8yTf6Q
         xJJRxySnEH4Bcgv9JgCUyLYOcvUscHRbZA2RTqKYVoizW1i5WR8ThmahoFcirfc6NS5K
         I4gNCwUqBZD769ZgVJs+IMV1mUZ01GoQopNurh1tIxTixIQx15Zd3lTdLtcstdwLNmXh
         iOiRxx6ebIx3/S+VLlp1Vjxnc3QEkQLTOjc0EVSpN93V2hJDc5xDtfXJ6SXeGVm7IX9X
         r412jVU9UnMwMwVQjop9gN8+Ab1PYLa6apM+3QonakdT5XK4/3gPYicsXvMDS8blbLgt
         i4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d8AdWOu1C2KmNDi0WuZ+5K7PD8/DNfu2a7FRFmIcixs=;
        b=kXQ5CQiyaYaoHyiq6p2MvLRx2YLehhoxar3NR0LTP4SedhakDPIZfSI3ttsJA+XL6e
         cD6Ig469Gf1Nn2N8Wqmp3urZRhdyzVh3lGOSTpGQFUhLgLhF9Gt1b7ojyiBqE9NGDKjd
         wWncOW7caIOyIBF9Q1rizEPllcUu3RJKR/f0vHgALSFmHrYg3FqVJch9Z3KbsNhAGUrn
         9Vx55LKyWQw/+9cmy6oRD8AmkOiKTHGjnvJsdFpxMZpNl3hMDYqh49EuhlgWfSMuEGWD
         4yZSVZ77EANtzUiZYxqoMOU9m/oNS7CPEKo8oRiKBhLVVx8xwqk3PVg94/WNrt+PwlLN
         RHSQ==
X-Gm-Message-State: AOAM532ufmPWTMSGWhdRvx5xEt2tIhJ+wDWDs18n579vs/BINPkNl5uD
        RT9WJlKV4K75ZalFKozxAI8=
X-Google-Smtp-Source: ABdhPJxYk4UWZJpVM+zx1IqJdRWXoOaQKiYanH32EiKzhBCNaSF67d8A5IUlt9LhxQ1Ph4od1Xbvlg==
X-Received: by 2002:a17:90b:f8d:: with SMTP id ft13mr16951972pjb.228.1629987992212;
        Thu, 26 Aug 2021 07:26:32 -0700 (PDT)
Received: from localhost.localdomain ([162.14.23.249])
        by smtp.gmail.com with ESMTPSA id z131sm3321330pfc.159.2021.08.26.07.26.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Aug 2021 07:26:31 -0700 (PDT)
From:   tcs.kernel@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com,
        linux-fsdevel@vger.kernel.org, zhiqiangyan@tencent.com
Cc:     Haimin Zhang <tcs_kernel@tencent.com>
Subject: [PATCH] fs:exfat fix out of bound bug in __exfat_free_cluster
Date:   Thu, 26 Aug 2021 22:26:19 +0800
Message-Id: <1629987979-6301-1-git-send-email-tcs_kernel@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

There is an out of bounds bug in the exfat_clear_bitmap function
in fs/exfat/balloc.c. Because the index of vol_amap array isn't
verified. The function could be called by __exfat_free_cluster
function, and the p_chain->dir variable which could be controlled
by user can be large, that will eventually lead to out of bounds
read. So we should check the index before entering the function.

Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Signed-off-by: yanzhiqiang <zhiqiangyan@tencent.com>
---
 fs/exfat/fatent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index e949e56..5ce524d 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -157,6 +157,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int cur_cmap_i, next_cmap_i;
+	int chain_i;
 	unsigned int num_clusters = 0;
 	unsigned int clu;
 
@@ -176,6 +177,13 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		return -EIO;
 	}
 
+	/* check size */
+	chain_i = BITMAP_OFFSET_SECTOR_INDEX(sb,
+		CLUSTER_TO_BITMAP_ENT(p_chain->size + p_chain->dir));
+	if (chain_i > sbi->map_sectors) {
+		exfat_err(sb, "invalid start size (%u)", p_chain->size);
+		return -EIO;
+	}
+
 	clu = p_chain->dir;
 
 	cur_cmap_i = next_cmap_i =
-- 
1.8.3.1

