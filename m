Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B471C20042F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgFSIjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 04:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbgFSIjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:39:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77946C06174E;
        Fri, 19 Jun 2020 01:39:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u128so4197556pgu.13;
        Fri, 19 Jun 2020 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+uPgnf+wW5u/QVoRDiXSyxSE34HMaGyVu1r9BybJSWM=;
        b=WD8Wfa/tV35Oo05bw3vytpEFgdHXmeW+Thl+2NEMIERdfjMGD2VqggqFX2raY2QiWN
         i8Ju2B88b7i/EiJDSvSLkmt7rXCIw9Pld+An57ups1CAKpKwMgGcBKv4157K60+ilTcr
         /WunHGRfxNsBfo2i/H2nBwMOps+/cbl3WOWnMut1aGKKL+4Z1N3DpInjAwFuNUFMhWq/
         6q0DohAoxCCjP/uAXaQM1G/zAlNrmzhWf5AnCwq2rij8aKuvEVgYSiTjB/k8b2NdAWnw
         /sGhCiAxDvP7o5QDxFKCydsLH5Fe7+T79EUhPARszg7yUyUPTmHCTJHJvwNdZ587g3QB
         IBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+uPgnf+wW5u/QVoRDiXSyxSE34HMaGyVu1r9BybJSWM=;
        b=gW2PkL2MMg8vNfNim8n3H1UCRUiJgI4vI8izMG2w1S9bKcrAJfEcPLIKJ5d5mmAuX9
         TgpwhGH0YFPoyWUPgBlHp7zgxF22YBmHsea0bX6v9IOotucKVpq6ZjeXNVbHzeRe+JHN
         MkZNRB7H+Wa60k4Un6Bf3k6CsG7ZPpy2KD/0z2XIl/MlcRdbF/MpehaWYpZRmnwYGEOp
         j1dAGnAHc8Un0CDgivGbLNIA/RVZ7Xf3U1f59dY3FEt/oOH+Q5WqFsC+3WEajGoj5/90
         bnJBaqSoIB7vzn36im1uLpLdQ8D5gOkudN2K42GaRz/U7pk+Qeg58lT1ydEZQJo+HDtB
         PQZA==
X-Gm-Message-State: AOAM533JOGYVun3gsLc0VMwokv1W2B7hr0ec7ZPRv+2/4yUiyyJ34cXw
        mq7idbCiZoOF8zD92DZIVaY=
X-Google-Smtp-Source: ABdhPJw656x3Mb0pQiRBNA1Vp5rBDHmdfd3Xpff8peVjGOFinVY+rdOVyVeLWKwfJIIPWmcyZpDKzg==
X-Received: by 2002:a63:2043:: with SMTP id r3mr2018078pgm.299.1592555942574;
        Fri, 19 Jun 2020 01:39:02 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id u24sm4437183pga.47.2020.06.19.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:39:01 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v4] exfat: write multiple sectors at once
Date:   Fri, 19 Jun 2020 17:38:54 +0900
Message-Id: <20200619083855.15789-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Write multiple sectors at once when updating dir-entries.
Add exfat_update_bhs() for that. It wait for write completion once
instead of sector by sector.
It's only effective if sync enabled.

Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'
Changes in v3
 - Rebase to latest exfat-dev
Changes in v4
 - Use if/else instead of conditional operator

 fs/exfat/dir.c      | 15 +++++++++------
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 02acbb6ddf02..7c2e29632634 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -606,13 +606,16 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 
 void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
-	int i;
+	int i, err = 0;
 
-	for (i = 0; i < es->num_bh; i++) {
-		if (es->modified)
-			exfat_update_bh(es->bh[i], sync);
-		brelse(es->bh[i]);
-	}
+	if (es->modified)
+		err = exfat_update_bhs(es->bh, es->num_bh, sync);
+
+	for (i = 0; i < es->num_bh; i++)
+		if (err)
+			bforget(es->bh[i]);
+		else
+			brelse(es->bh[i]);
 	kfree(es);
 }
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 84664024e51e..cbb00ee97183 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -512,6 +512,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct buffer_head *bh, int sync);
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
 void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 8a3dde59052b..564718747fb2 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -172,6 +172,25 @@ void exfat_update_bh(struct buffer_head *bh, int sync)
 		sync_dirty_buffer(bh);
 }
 
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
+{
+	int i, err = 0;
+
+	for (i = 0; i < nr_bhs; i++) {
+		set_buffer_uptodate(bhs[i]);
+		mark_buffer_dirty(bhs[i]);
+		if (sync)
+			write_dirty_buffer(bhs[i], 0);
+	}
+
+	for (i = 0; i < nr_bhs && sync; i++) {
+		wait_on_buffer(bhs[i]);
+		if (!buffer_uptodate(bhs[i]))
+			err = -EIO;
+	}
+	return err;
+}
+
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags)
 {
-- 
2.25.1

