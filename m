Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F315F22CE05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXSpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 14:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGXSpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:45:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD63C0619E8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a25so6939333pfl.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VSwfu85pneIFmS24X/ynlOi1yjIof1V3mRCitL8rAYY=;
        b=maAmxJ7NYpOeYwEieVBxCvRDZINBI5z01Z7yoA6Kvl2IYqByL1XVGCthlTgPirzHTR
         5nXxBJvJ9Wt7KA1zuGzaQDvSG5JBu4jne2azUTlVKbGojdVvR/GsCiiOGhYZfls55xX+
         vb7IqBleMcL/eF/RiTCPxqdypPn2KKzoMLJ6OlgoiFw2wmrMpqEd0oGoa/cAUN16dbVJ
         mbvl5Pjm/9rEEPXF1iygFadnE/pcA3dJdwaWGdx4RU8aeSSpToh7gK1ay2iYWIqrnIqQ
         wGwk93dF3mWAgl2urxtmiGQyZwx8qsrDPbHwP4m2RhCl25zv7XND4Kaft04Xv2XS6LU/
         rOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VSwfu85pneIFmS24X/ynlOi1yjIof1V3mRCitL8rAYY=;
        b=dIwLlkI7duZtW9UoMPBeLni0d9Q1LxuFvC2L0UdRMzN1ir6t/1INacJ4P1cyfLCkng
         2dVm99hpjCfgCMUgWy38ykDFsQAtG0/Kcu6+IVtBX/xbWUF4ZP6DMmDPd2QuX/P/AR7S
         xdNd/76uCtwih+zPZ73k/Qdm6N4dpOzaDgDIoMq1FCJ+Qah/Cx6PuimVeyYKSHfNFJXr
         n37voML9s5bvoUsHPAQwIo6kPbn6UqkvxHaz6DfnCtgOdebwrdCojqoSP2KrFHXTw1N9
         Oqi4n/GCk7Mgmegeutu6rv3nJmmeUFRILo86DE4NoeZkUDpSim+GmkgyPVqFxTxlH+Nz
         8QCQ==
X-Gm-Message-State: AOAM532Eo8a42LWhnFptD617KEGmj+SKEQV3AT3F9RZjbah8zpMrIGTS
        qilWgaf/6ffDG1fTeQw+xYh3BKhd+cQ=
X-Google-Smtp-Source: ABdhPJyT41z7Bo2DJVXrD2yfQgUGfnGWGnRtL9zK9eYdoIYIP8wyrLRC6/JqsXYyBn0KLNCSTVI1XabDyNk=
X-Received: by 2002:a17:90b:1296:: with SMTP id fw22mr6730717pjb.20.1595616309435;
 Fri, 24 Jul 2020 11:45:09 -0700 (PDT)
Date:   Fri, 24 Jul 2020 18:44:56 +0000
In-Reply-To: <20200724184501.1651378-1-satyat@google.com>
Message-Id: <20200724184501.1651378-3-satyat@google.com>
Mime-Version: 1.0
References: <20200724184501.1651378-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v6 2/7] direct-io: add support for fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required,
and explicitly check for DUN continuity when adding pages to the bio.
(While DUN continuity is usually implied by logical block contiguity,
this is not the case when using certain fscrypt IV generation methods
like IV_INO_LBLK_32).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/direct-io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6d5370eac2a8..f27f7e3780ee 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -411,6 +412,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      sector_t first_sector, int nr_vecs)
 {
 	struct bio *bio;
+	struct inode *inode = dio->inode;
 
 	/*
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
@@ -418,6 +420,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 */
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+				  sdio->cur_page_fs_offset >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
@@ -782,9 +787,17 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 		 * current logical offset in the file does not equal what would
 		 * be the next logical offset in the bio, submit the bio we
 		 * have.
+		 *
+		 * When fscrypt inline encryption is used, data unit number
+		 * (DUN) contiguity is also required.  Normally that's implied
+		 * by logical contiguity.  However, certain IV generation
+		 * methods (e.g. IV_INO_LBLK_32) don't guarantee it.  So, we
+		 * must explicitly check fscrypt_mergeable_bio() too.
 		 */
 		if (sdio->final_block_in_bio != sdio->cur_page_block ||
-		    cur_offset != bio_next_offset)
+		    cur_offset != bio_next_offset ||
+		    !fscrypt_mergeable_bio(sdio->bio, dio->inode,
+					   cur_offset >> dio->inode->i_blkbits))
 			dio_bio_submit(dio, sdio);
 	}
 
-- 
2.28.0.rc0.142.g3c755180ce-goog

