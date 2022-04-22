Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2650B6D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447297AbiDVMIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447339AbiDVMHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4B56C09
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so16008183ejn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRQ5FfxD8lP1DFsjLxOKmD5i3gKcdY45nZQTqkWRDXM=;
        b=W/3ngU5Iei0WlWBR4SjEYzhgeBFZTNCGR1tWPKnjWPR8k9445ZrDnt5GcYeUCzWZTu
         ga7GU8K+wq95r49L3ysTN0U9g2d84xZ3nsWf1nLtvLX8Kn4Y8yyIGDmy9p8WFUT1uut6
         3wjJ5KJzprzWpqno5/v0tzgozBnMp+mS/cYlBz4m7Mi6LkCogTdaeFRQ2WXsiPahteoO
         m/NvSFPKR7X/08TurY2So68NDY+xYLGZduy2vyoSe2oW1ReD/ZvyfWF9PfNa/HrkNK1U
         TMJLFaGiZ6/rShmJq30swnJmqV0l2RkjaoqqI/gECECyQmtGMLtGo/XKVVbLw8Z07qcK
         /vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRQ5FfxD8lP1DFsjLxOKmD5i3gKcdY45nZQTqkWRDXM=;
        b=CkYFxdh6Ln/gOn1Qa9HUwWDgV46CF/IDVLOBn2lqfP6LV679Tx62YNW4J7IfhvCxVq
         pXPmdrO4El58ZAAJ9/GYpFSqLo9rhEXgzWKAeK42IhxTXpaILvRehGLsLNA+xDUwcqHH
         7v2BunGsYvjsJqVAZEmkqG1ZXKn51nofefiSc3ycastgcXCQTEKQnXTv2FRHzZDBuuP/
         7VmBITiFRWh52KPdTRDpX3OTFytaTdwCih8lB6py34gTDs+TOTBOrjdycRZyLzFMQDB4
         fVKUhzTjMc+Zrb2ff3MS1Q+rU+AnO1/7K03JE6BWJJmvqR1B2WDQFM/HbPR00KTr9oji
         I6Tg==
X-Gm-Message-State: AOAM533ZOE6QZNrGDv/QednKpJoncr4yUAOzS6tCF1haLvtLIa1OnVKx
        9XMQzp1yDIQBhpyo1+j9DRw=
X-Google-Smtp-Source: ABdhPJzF7xLFFBFogEqImnDTGnNyOaozDINguzaQo/bqmR09WwZ/sKvgHARd7LBoyJD/kQDRDrDcUw==
X-Received: by 2002:a17:907:6d8b:b0:6f0:2533:72fb with SMTP id sb11-20020a1709076d8b00b006f0253372fbmr3754348ejc.93.1650629027543;
        Fri, 22 Apr 2022 05:03:47 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm697026ejv.43.2022.04.22.05.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 09/16] nfsd: use fsnotify group lock helpers
Date:   Fri, 22 Apr 2022 15:03:20 +0300
Message-Id: <20220422120327.3459282-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120327.3459282-1-amir73il@gmail.com>
References: <20220422120327.3459282-1-amir73il@gmail.com>
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

Before commit 9542e6a643fc6 ("nfsd: Containerise filecache laundrette")
nfsd would close open files in direct reclaim context and that could
cause a deadlock when fsnotify mark allocation went into direct reclaim
and nfsd shrinker tried to free existing fsnotify marks.

To avoid issues like this in future code, set the FSNOTIFY_GROUP_NOFS
flag on nfsd fsnotify group to prevent going into direct reclaim from
fsnotify_add_inode_mark().

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 74ddb828fd75..489c9c1d8f31 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -119,14 +119,14 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 	struct inode *inode = nf->nf_inode;
 
 	do {
-		mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
+		fsnotify_group_lock(nfsd_file_fsnotify_group);
 		mark = fsnotify_find_mark(&inode->i_fsnotify_marks,
-				nfsd_file_fsnotify_group);
+					  nfsd_file_fsnotify_group);
 		if (mark) {
 			nfm = nfsd_file_mark_get(container_of(mark,
 						 struct nfsd_file_mark,
 						 nfm_mark));
-			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+			fsnotify_group_unlock(nfsd_file_fsnotify_group);
 			if (nfm) {
 				fsnotify_put_mark(mark);
 				break;
@@ -134,8 +134,9 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 			/* Avoid soft lockup race with nfsd_file_mark_put() */
 			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
 			fsnotify_put_mark(mark);
-		} else
-			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+		} else {
+			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+		}
 
 		/* allocate a new nfm */
 		new = kmem_cache_alloc(nfsd_file_mark_slab, GFP_KERNEL);
@@ -679,7 +680,7 @@ nfsd_file_cache_init(void)
 	}
 
 	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							0);
+							FSNOTIFY_GROUP_NOFS);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
-- 
2.35.1

