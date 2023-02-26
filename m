Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315726A2F7D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBZMwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 07:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBZMwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 07:52:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE34BBAE;
        Sun, 26 Feb 2023 04:52:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kb15so3464214pjb.1;
        Sun, 26 Feb 2023 04:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS+TlC+EiV0VF2Rz3BRf4GEHgtRgdd+dzhIKTko3Adc=;
        b=J3uh/yzOf0BMd6HVZ427c8iw0Q3fhTNqjTvvEpAFqErAaEE+9oRuC1giLmhLFg2hUC
         rHoMSLwG5Reteaiu7wXv7O1mo5J0n/g5G8D7gt66MBgVTCcUMEXap09Y9DjPK9xeeIeW
         kJpSobXfi0in5dTgl3Q/WzQg95sGmPCRN1c48aqLtxUIcSXx6ABFwQ3LgO2f2z77gjJv
         n3OhMJSF7F0c9VSW+TWMnSWEjBFmwubOHDxn4utTTjEHP7/YEanU/sZysApBGoJ2yweE
         OZTc4G+Rb02mPH8+0krx15HDQW9hG1GZYBrXfYOwP1tyfA3mul33LRpmrG/Lcxy8Lm+D
         cjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS+TlC+EiV0VF2Rz3BRf4GEHgtRgdd+dzhIKTko3Adc=;
        b=AZnPTUkwHUaGSHxzLkHXyBO1EpRQjx+oLjYfFoC/vEWdig3aGDMYPrrwM7ygxXjmR5
         vNV6kbmtnA1TWyRlxq5wO1qCc3bfrc4Q4ozGLmaErP2uINtKVthb8lE1CKRE3S/PrmDt
         MJKsJvbTVTjdJEGEILeVFXfGBcQtxqFbFHGNxwLQ0yxcM9YPV9ABtj/mB8iUNp00dixp
         Dn0JbSdHyYY2jICPWKE8fBMl1S3uEFiU0aCfuyCXAUahOAlOYbkZiK0qZDOtvyB1k/Df
         x5AxTxWwokABL1/zTKC5PdzrfNg/qsA0Dq8IXX9g9aeMNcCDMC9rJczX7J+/4bsaemAv
         2fTg==
X-Gm-Message-State: AO0yUKXgRx3L+V9fRHo2Q+E/DVbzu7ctnyT9GfPAIyyk14FD5UnPSe+A
        jbhPPnnL4x/3et3aGKK2DvJbcWhayw3Lq3BoMoE=
X-Google-Smtp-Source: AK7set9TIYU+I5MesW9FJSEiOVUVnuHHXfjTXQN0VZana3vFUqwCAUeTBbeWbH3QtVY1to3laVZtHw==
X-Received: by 2002:a05:6a20:4417:b0:cd:4ad1:cffb with SMTP id ce23-20020a056a20441700b000cd4ad1cffbmr279401pzb.51.1677415948615;
        Sun, 26 Feb 2023 04:52:28 -0800 (PST)
Received: from localhost.localdomain ([199.101.192.110])
        by smtp.gmail.com with ESMTPSA id c24-20020aa78c18000000b005ac419804d5sm2506090pfd.98.2023.02.26.04.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:52:28 -0800 (PST)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+57e3e98f7e3b80f64d56@syzkaller.appspotmail.com,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: hfsplus: Fix UAF issue in hfsplus_put_super
Date:   Sun, 26 Feb 2023 20:49:47 +0800
Message-Id: <20230226124948.3175736-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current hfsplus_put_super first calls hfs_btree_close on
sbi->ext_tree, then invokes iput on sbi->hidden_dir, resulting in an
use-after-free issue in hfsplus_release_folio.

As shown in hfsplus_fill_super, the error handling code also calls iput
before hfs_btree_close.

To fix this error, we move all iput calls before hfsplus_btree_close.

Note that this patch is tested on Syzbot.

Reported-by: syzbot+57e3e98f7e3b80f64d56@syzkaller.appspotmail.com
Tested-by: Dongliang Mu <mudongliangabcd@gmail.com>
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/hfsplus/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 122ed89ebf9f..1986b4f18a90 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -295,11 +295,11 @@ static void hfsplus_put_super(struct super_block *sb)
 		hfsplus_sync_fs(sb, 1);
 	}
 
+	iput(sbi->alloc_file);
+	iput(sbi->hidden_dir);
 	hfs_btree_close(sbi->attr_tree);
 	hfs_btree_close(sbi->cat_tree);
 	hfs_btree_close(sbi->ext_tree);
-	iput(sbi->alloc_file);
-	iput(sbi->hidden_dir);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
 	unload_nls(sbi->nls);
-- 
2.34.1

