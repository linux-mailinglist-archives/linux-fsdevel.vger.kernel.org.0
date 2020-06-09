Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD061F3593
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFIHyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgFIHyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:54:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998E5C03E97C;
        Tue,  9 Jun 2020 00:54:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so2864301pfv.11;
        Tue, 09 Jun 2020 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uKwWjkBeGKGswJB1rtsp6iRvLZ81zR9x6/pq8AsVAQ=;
        b=U/7xX1wyZKkmkicid4IRng//2YewQDpUJdNFAs2KG9nA+nTceYWC5PjTsGLABj0PDl
         5BzFX+IlCb84Bubw/uxgfzWcjn8O52zd22rntIBFILCkzPxXw4kzcOO34CTxzJD9cV7c
         MbnCcEpCxE+Obu5uIhYqH8skzyfbmBwanTRd0PT1NXfICtR17WuBT3kozTyA97TrUyxI
         26Ph4zk64R/Z9Jpx/BhvvwbKGSR2yAIRut3OWA/CQL/JgXaC1Ghl3r3Q4KSToynVcY3i
         /MZS/ezWA6mPmSj/oWpQUcBC82SY/DKQYIQ8RObNIlKnHD27pROWOx2tTQntFxkZZ+5V
         Sj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uKwWjkBeGKGswJB1rtsp6iRvLZ81zR9x6/pq8AsVAQ=;
        b=hwMKW1vfVin8NAl5OTsziEH2qpolvsR/fLIzF3FhjV4HbgsMvCx1+PWXnNuDYM7Zre
         z7xspDCctvngS0ZfpmSedZQx39yNppwU9tb+olhhdn0/GvRIeWxCeWmZxRQAXSOhwcvC
         uT3CsPjBYPptwEQBY5iLKrrSTcrQfVGVvvxCr5kOaUIZqn8YKZDgN+X/UtEgWDsLWpMa
         zG5imILfYAB75VnYyCUa/5bvZoXlV4y883KCkMxQxtONcmyO9ed6/mAPxkv+lMRDzxE6
         Xnp8o/Nu4/zQt8/qoOkx/mongeo1Ixl4oMaXmBpwVKIbm3/wy3g/wqB+PptUwm6X8haL
         ZT4Q==
X-Gm-Message-State: AOAM53020B+h5EBe5aX+P6x39hEbP72EF2WAiyuDRiW3valy5yJAglLL
        9NJP/VfcuqLyx/pAiIXhSiY=
X-Google-Smtp-Source: ABdhPJyjHZojemD/pn5jq9azXhxD4lMYU72dMlPM6n8Pq1Gmhn0sPozXmReQRMfWYB9Cl73MAVjH0A==
X-Received: by 2002:a63:689:: with SMTP id 131mr21195128pgg.401.1591689243048;
        Tue, 09 Jun 2020 00:54:03 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:99b4:eb52:d0bf:231c])
        by smtp.gmail.com with ESMTPSA id x4sm4769929pfx.87.2020.06.09.00.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 00:54:00 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <linkinjeon@kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v2] exfat: write multiple sectors at once
Date:   Tue,  9 Jun 2020 16:53:27 +0900
Message-Id: <20200609075329.13313-1-kohada.t2@gmail.com>
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

Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'

 fs/exfat/dir.c      | 12 +++++++-----
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index de43534aa299..495884ccb352 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -604,13 +604,15 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 
 void exfat_free_dentry_set(struct exfat_entry_set_cache *es, int sync)
 {
-	int i;
+	int i, err = 0;
 
-	for (i = 0; i < es->num_bh; i++) {
-		if (es->modified)
-			exfat_update_bh(es->sb, es->bh[i], sync);
-		brelse(es->bh[i]);
+	if (es->modified) {
+		set_bit(EXFAT_SB_DIRTY, &EXFAT_SB(es->sb)->s_state);
+		err = exfat_update_bhs(es->bh, es->num_bh, sync);
 	}
+
+	for (i = 0; i < es->num_bh; i++)
+		err ? bforget(es->bh[i]):brelse(es->bh[i]);
 	kfree(es);
 }
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 595f3117f492..935954da2e54 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -515,6 +515,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
 void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync);
+int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
 void exfat_chain_dup(struct exfat_chain *dup, struct exfat_chain *ec);
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 17d41f3d3709..dc34968e99d3 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -173,6 +173,25 @@ void exfat_update_bh(struct super_block *sb, struct buffer_head *bh, int sync)
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

