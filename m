Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B623F86A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKLCKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:25 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47946 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726915AbfKLCKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:25 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AN7O011415
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:23 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AID3030154
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:23 -0500
Received: by mail-qk1-f198.google.com with SMTP id e11so9185448qkb.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nRpTki0gCidh58OgWjsjlNbtGeZKooZJJuOtnn09nxI=;
        b=L9gcClUaedLYp4zC5JYixZI+zmLiofYyjVO2Zk8IRjrNiKUzSZYzi9ChSKDLm2d1/v
         lgZDAXoFYs1tKie2q2DHyR4ryk1W9cm0ON4lZ37Cw74kXvbwACmjZUICw18nc4QS0Y6D
         /ztJFqH6ZT3vIx4dPtZlKmRhl44g3B2bNIxZnP53IF3rKyJwJvP6oHSm1QJR0GKtWyXC
         cpGKiW/EhL3DL/YXUar5l7yxJgqg/rXmpaQm29SewRJX7lCDJo8zGPdvl5/1DlVBRVOd
         OofncUcbG/1gWV3Jwu+dZwXiCjzFdn0FkB77IVJapaeOh+TPZcy7oXsWt4g5uEENT1ti
         h+yg==
X-Gm-Message-State: APjAAAXAKcX84Aqaj6kfUHZiGCiTdgrFAqfG396KA4dCBztf8qEu3jsf
        1TgG3tWy74Aei9/na6G0RIYFGcApGYJ0pahOc+0QXS3oW+QlMOIO2feYVjQuKIxdpa86CdsquZs
        XbflG9SIQAIueOkj8ygEAVXw1mfE32BIcyKuu
X-Received: by 2002:a37:782:: with SMTP id 124mr13627258qkh.142.1573524618167;
        Mon, 11 Nov 2019 18:10:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDZC46SpCJRfV6mpGZkD/E1Flbu1ayJdrNSgII1HY5pMVz/B6gXtJHLghNxKZhqlGG5vzC5Q==
X-Received: by 2002:a37:782:: with SMTP id 124mr13627238qkh.142.1573524617853;
        Mon, 11 Nov 2019 18:10:17 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:16 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] staging: exfat: Clean up return codes - FFS_FORMATERR
Date:   Mon, 11 Nov 2019 21:09:49 -0500
Message-Id: <20191112021000.42091-2-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_FORMATERR to -EFSCORRUPTED

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 3 ++-
 drivers/staging/exfat/exfat_core.c  | 8 ++++----
 drivers/staging/exfat/exfat_super.c | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index acb73f47a253..4f9ba235d967 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -30,6 +30,8 @@
 #undef DEBUG
 #endif
 
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
@@ -209,7 +211,6 @@ static inline u16 get_row_index(u16 i)
 /* return values */
 #define FFS_SUCCESS             0
 #define FFS_MEDIAERR            1
-#define FFS_FORMATERR           2
 #define FFS_MOUNTED             3
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index b23fbf3ebaa5..e90b54a17150 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -573,7 +573,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			return FFS_MEDIAERR;
 	}
 
-	return FFS_FORMATERR;
+	return -EFSCORRUPTED;
 }
 
 void free_alloc_bitmap(struct super_block *sb)
@@ -3016,7 +3016,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	num_root_sectors = GET16(p_bpb->num_root_entries) << DENTRY_SIZE_BITS;
 	num_root_sectors = ((num_root_sectors - 1) >>
@@ -3078,7 +3078,7 @@ s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
 	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
@@ -3157,7 +3157,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
 	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 1ae5a7750348..e0c4a3ab8458 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -384,7 +384,7 @@ static int ffsMountVol(struct super_block *sb)
 	if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
 		brelse(tmp_bh);
 		bdev_close(sb);
-		ret = FFS_FORMATERR;
+		ret = -EFSCORRUPTED;
 		goto out;
 	}
 
-- 
2.24.0

