Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79435E3724
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 17:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503355AbfJXPyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 11:54:43 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54556 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503352AbfJXPyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:41 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFseOo027029
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:40 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsYw2004105
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:39 -0400
Received: by mail-qk1-f198.google.com with SMTP id h9so8694929qkk.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=D/1VhmAhD3zi1l2243w8fbyxsU10KIHq0czBUcE2Eo8=;
        b=J5A3iDiY3yhQ1E2a1p0diT/r8JXiBJ2KxYkzAvxOG3S0pY9IDmeHD+vSS5Opkt++Sf
         fJHq2qF5fH0AomVevvmOBHEFhOeU9JppS1hQXdYR19sJoGPVgHiitblTvcB/3OKMSca1
         9ei5N0QNTK4qC4UNhxMtN3g34/g8t0Mdp0aVEKjmM+32f2TL4TgiG3Emvvd0L8d+RxH3
         EQpj8SBaNhkIwiw6gBq5juND6A6K+TZxe9msuw/ZU5h3LxwBFEWvqcMhflOTUaNXNvyE
         NYdy1PVI6b7sR6c9oVnOPTkXXZWrytsPV3XNPNarmKTJSXY3b0vEXlqnM0mgRXSjCJNX
         J0IA==
X-Gm-Message-State: APjAAAXDCzFEhvLadzfbZ3YNGo2jOOcuitr/ZfcMiRo9Et2uOsGD6NFq
        Xud9382ws7znoZl17aq9SJfmVug4QOmXwBgMMNP82UAdC/qQrJ1G32l2kxgHftnX9WGSOWLh3GQ
        X3+huhaF+bPAgjvuokBwfjGcuxW1JSUDDsQwT
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14381382qke.115.1571932474704;
        Thu, 24 Oct 2019 08:54:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4esJktLLI4kSKiGMacw/otWmsfL+5VwGdnUH9R6Wajz3T1AOiruITnXjnTZAYbU4iCu4DWw==
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14381364qke.115.1571932474401;
        Thu, 24 Oct 2019 08:54:34 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:33 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] staging: exfat: Clean up return codes - FFS_FORMATERR
Date:   Thu, 24 Oct 2019 11:53:20 -0400
Message-Id: <20191024155327.1095907-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
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
 drivers/staging/exfat/exfat_core.c  | 4 ++--
 drivers/staging/exfat/exfat_super.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2588a6cbe552..7ca187e77cbe 100644
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
index fa2bf18b4a14..39c103e73b63 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -205,7 +205,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			return FFS_MEDIAERR;
 	}
 
-	return FFS_FORMATERR;
+	return -EFSCORRUPTED;
 }
 
 void free_alloc_bitmap(struct super_block *sb)
@@ -2309,7 +2309,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
 	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b35e3683605..161971c80c02 100644
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
2.23.0

