Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91A01EDC97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 06:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgFDEyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 00:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgFDEyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:54:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA36C05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 21:54:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so546055pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2020 21:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FVCdogF8ccOYT8JeABOFqCaqQivGZOnzUPDMckZY8pc=;
        b=t4nd4rdFIWGlby3vuY8dqUfrC64wPP5whBjSD4fWMOEsAeeX4T06q9XBnlWCH6c2Lj
         E+TKgKvEM+YT3tHcB441Fzzy99w9oQoqTooLNjlaj0MZk64LUPPqZC8BQ/RtRqKVG17t
         wIVU0ILPNENz/k6ZSlm9i9cyKoTl3OL8KTkm54goPINBcuO5bfkOaSsu22fSuq9cykih
         MsG86AEVhwIUS91UvqaAgf8nakbfsVpdeinBLKPE8Hi0OW/bsK5YXZ3lg4XMa6Gg64Dd
         xF18LuSeoZ+0P4HIR8LT3H12crazFUn+mMOrQAp3DdAMFDaPzG6vSs7kv32uU1uncUCn
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FVCdogF8ccOYT8JeABOFqCaqQivGZOnzUPDMckZY8pc=;
        b=DbqIOaVmoJ7LByfE8oD6+zHCepTkg6jK2CAOePxD61mPNZfMy3Z4G+o5HIKcNeP2QR
         sDmTlaIPyX9YQQUx1X942bDId9R14Zbkzg9x1v1w5Vp308Rm4NpDvLIi0rKutaFYgp46
         SbEkDStSmbx6AyJV+Hj+QeKuDAplgZAhDoQwpgnJ9uIvF0IO8RL9W7bJWJ6HbUk4THdg
         v7WbzJ2Pj6UDR6fTDI/BSjTvBg6aRnAz6Vf5sxGt7zzvgdl3bpfiJ6wD1zMh/Sz2exs5
         S2DpUb33Ecv/S0MqFUmQiU1CQrN/H4ZAY3eFS01+olepxUaIQrb2ekY/060hsJL0/Fgl
         AN6w==
X-Gm-Message-State: AOAM530zEq7S1COIfwSMyrrqMDzBFziiimFs6W14Gz3BJA97Q8xNei/Q
        88IDEj30mJYacReJAO6P9sA=
X-Google-Smtp-Source: ABdhPJxqGkTpzxuU8vRE7ZJX+xiVTZLDw3dzbxOXpt8OHzbX6M0nWJcgKmFB46S9YNz+0WsbajHIIQ==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr343936pju.61.1591246474680;
        Wed, 03 Jun 2020 21:54:34 -0700 (PDT)
Received: from localhost.localdomain ([125.186.151.199])
        by smtp.gmail.com with ESMTPSA id cm13sm4388707pjb.5.2020.06.03.21.54.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 21:54:34 -0700 (PDT)
From:   "hyeongseok.kim" <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org,
        "hyeongseok.kim" <hyeongseok@gmail.com>
Subject: [PATCH] exfat: fix range validation error in alloc and free cluster
Date:   Thu,  4 Jun 2020 13:54:28 +0900
Message-Id: <1591246468-32426-1-git-send-email-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is check error in range condition that can never be entered
even with invalid input.
Replace incorrent checking code with already existing valid checker.

Signed-off-by: hyeongseok.kim <hyeongseok@gmail.com>
---
 fs/exfat/fatent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 267e5e0..4e5c5c9 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -169,7 +169,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 		return 0;
 
 	/* check cluster validation */
-	if (p_chain->dir < 2 && p_chain->dir >= sbi->num_clusters) {
+	if (!is_valid_cluster(sbi, p_chain->dir)) {
 		exfat_err(sb, "invalid start cluster (%u)", p_chain->dir);
 		return -EIO;
 	}
@@ -346,7 +346,7 @@ int exfat_alloc_cluster(struct inode *inode, unsigned int num_alloc,
 	}
 
 	/* check cluster validation */
-	if (hint_clu < EXFAT_FIRST_CLUSTER && hint_clu >= sbi->num_clusters) {
+	if (!is_valid_cluster(sbi, hint_clu)) {
 		exfat_err(sb, "hint_cluster is invalid (%u)",
 			hint_clu);
 		hint_clu = EXFAT_FIRST_CLUSTER;
-- 
2.7.4

