Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060925513B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiFTJFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiFTJFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0D103C;
        Mon, 20 Jun 2022 02:04:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so1917886plx.3;
        Mon, 20 Jun 2022 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcQlji3Cx+j7uayBebQyTWGNyA+9EAfDG0gMAxfScdY=;
        b=hMF0YeBQsMuGkQucRNSSxO6r56Chmy9P8vzkEn5YcXpVN+G3biF3IBUwvoC+a9NwBw
         6MeDckSTwmdtr21aSRYyxNtrOuVMTtP+ZlAHHpHdZF9q+UfJKiypKlgWgu5NnS1K/x1z
         yZ5ljee7VnjnYje+S3SUgeTL5CNSpXOGhBTMtxY4GMjmb/f42QwcNAQZ6OGOPlGAlx4J
         NHu/2YGcmGkdChA794qn9JcYiNRMCQ2nmqe+RiqCPZ/w+jiNjq/SjOfdMJOug70i9/5M
         HSREI9P2YFbpfRoClHygDV2cXFoCYs/3+jd/8qY84/W6EqP4rkuCig9yW6Nh9DCePZVc
         q3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcQlji3Cx+j7uayBebQyTWGNyA+9EAfDG0gMAxfScdY=;
        b=1ZjpgBP9I0DjlDIeDmnqd8+hfzY8eNSJvTV+Mb5XyD+BKpfS62Q0xplAO/Gh4TvYWk
         BWxSY+hiVbaVp+dg6hdzsbIECFizumx7uMr81d2todYsQDFp+S9zEezWVpb4f3kUgmq9
         7iCpArF7xBnSIbybB7BCIW/LVfdJvzCr5gr+EO/dIIL/w/KEsVOmgJPNQPG+WVRulOxp
         T+ceeA4C8st6w91e1SFRHpwnWsGvsFJVxqXM2Kg6ZuBkfVSAve+l7OilT3A9zaSbk2F0
         6WP4uIDIpTN+VgLuYdRAu7DjzRQzz/L+FmCCGxaEgdJDkIJ+ynYmYMY2RsoseXKKgGqy
         InPw==
X-Gm-Message-State: AJIora+maaRTTOw6k1olVgKGF6Vs0xzdKoYZge+oMQkuBD922frzRMyx
        UUfdbe8LMUqAijt322xILqyFGK7O3yk=
X-Google-Smtp-Source: AGRyM1t0Qv4vd6sWgSWK05Xy69C8ijWQ12ehSDvnJyGZPM8ovJa+4zEhwBim5llOyOSUTUVIfYPz/g==
X-Received: by 2002:a17:902:e74b:b0:166:4d34:3be3 with SMTP id p11-20020a170902e74b00b001664d343be3mr23078957plf.102.1655715897943;
        Mon, 20 Jun 2022 02:04:57 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id i67-20020a62c146000000b00524c5c236a6sm2308583pfg.33.2022.06.20.02.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:04:57 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCHv2 2/4] fs/ntfs: Drop useless return value of submit_bh from ntfs_submit_bh_for_read
Date:   Mon, 20 Jun 2022 14:34:35 +0530
Message-Id: <f53e945837f78c042bee5337352e2fa216d71a5a.1655715329.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655715329.git.ritesh.list@gmail.com>
References: <cover.1655715329.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

submit_bh always returns 0. This patch drops the useless return value of
submit_bh from ntfs_submit_bh_for_read(). Once all of submit_bh callers are
cleaned up, we can make it's return type as void.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/ntfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index a8abe2296514..2389bfa654a2 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -532,12 +532,12 @@ static inline int __ntfs_grab_cache_pages(struct address_space *mapping,
 	goto out;
 }

-static inline int ntfs_submit_bh_for_read(struct buffer_head *bh)
+static inline void ntfs_submit_bh_for_read(struct buffer_head *bh)
 {
 	lock_buffer(bh);
 	get_bh(bh);
 	bh->b_end_io = end_buffer_read_sync;
-	return submit_bh(REQ_OP_READ, 0, bh);
+	submit_bh(REQ_OP_READ, 0, bh);
 }

 /**
--
2.35.3

