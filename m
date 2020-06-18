Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B521FE783
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 04:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgFRCld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 22:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgFRBMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:25 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DAC061755;
        Wed, 17 Jun 2020 18:12:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so1981113pfw.10;
        Wed, 17 Jun 2020 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mYYmw9nQduGr7ImYE2MP1C2QsjcPBen23TKEtxnDoY=;
        b=kBa3G0l+ZNUXGCRjrjIh/s9kaSyUojbgB+Eyc39Uf/7c8gLLYv3g5WFrTplfAXZSGj
         Ueg4+uAgarXniOlUAp+AC46WRJSoLNnrj1PIkVBcEeRYdR58TvKwFV9LkxqmFkUFtSDm
         qoWSMDCY/5hMkvJl4c8s3bA93TIZqTfsYGepQ1SDqvko2De6KbRJrNRvgSriNUqyirPm
         Z/XMPQ//Av9revEdsHJtzzlpIq+i7Nw9bzZwxc69FNnY2gRXr65vmVykrJpJbB0q8Ywi
         vHaBxvZveDmajKMqGsWHZvRA4rcJec9Z6iAOKoTulcl+M5MN/np6JJecMEzr/NnS0HGz
         MH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mYYmw9nQduGr7ImYE2MP1C2QsjcPBen23TKEtxnDoY=;
        b=NbR8KWAtJQZhnSs47MjpcS97DqHzOQDcxVzl6ZmXYrj425VxIR0bz/KEx8S0ULGUN4
         86zAJJHPJ4y0Qts7S9M0yLGtUv/kBXIkoBLz10buz5rnx/+Z173f/lVyNc6nU8fFn8PS
         rhRNwCH5DgyM1lb3E2zwevMPnos1MloMlJS92qWBOOZn7qbUoJitOFNvnRAJYrqxd69f
         F5w8Bj6zoXDYm2ns/qAZVQ2cbNKVKpcCFJYvxIPnJXCG/i0OOx+iLlyHIdkVBvfxiobK
         DnDhptJwtsSQcFsUMesdVix78rmpiJneVRI8+v74doNQNBnPRql5s2aBAarYm9k9R81r
         pGMw==
X-Gm-Message-State: AOAM533scHdM1ODVLdBJ1+CeiqOmn6+qSDj75j/OrKde3G98n1E+eoFP
        akIW+x7sQPLVIzD8KFbx7l11CBHtpLU=
X-Google-Smtp-Source: ABdhPJz/mOUor7XwvAv9bccD3inxzqmkUVqwhIN47oG3dQuKAkR+QC0pz02eMw/i7U68pqz8EN7zXw==
X-Received: by 2002:a63:3409:: with SMTP id b9mr1394174pga.106.1592442744653;
        Wed, 17 Jun 2020 18:12:24 -0700 (PDT)
Received: from dc803.localdomain (FL1-125-199-162-203.hyg.mesh.ad.jp. [125.199.162.203])
        by smtp.gmail.com with ESMTPSA id q10sm1022781pfk.86.2020.06.17.18.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 18:12:24 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2 v3] exfat: write multiple sectors at once
Date:   Thu, 18 Jun 2020 10:12:03 +0900
Message-Id: <20200618011205.1406-1-kohada.t2@gmail.com>
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

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2:
 - Split into 'write multiple sectors at once'
   and 'add error check when updating dir-entries'
Changes in v3
 - Rebase to latest exfat-dev

 fs/exfat/dir.c      | 12 ++++++------
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 02acbb6ddf02..a3364df6339c 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -606,13 +606,13 @@ void exfat_update_dir_chksum_with_entry_set(struct exfat_entry_set_cache *es)
 
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
+		err ? bforget(es->bh[i]):brelse(es->bh[i]);
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

