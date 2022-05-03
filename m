Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B675181FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiECKHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 06:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiECKHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 06:07:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8763B01E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 03:03:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id iq10so14920533pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 May 2022 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Vvk+9fjdseiODkVOnE4uRp+LFKP70PHu6kpewmYz8KM=;
        b=NYGNWUwa4Qt6KDNrZpqAhyvbibPNOAt/9uM3UxX+/Y27sZWNc3ubMrj3gHqVvM/V70
         +HFbPA3soiHtzuXOcSTZUUVD6mVkfeiTxqTDDK2TaeHFRL33BlmcKMh2LEtfYJRbjSgD
         qR6pmIMO5YzSIXmiL2jrczI2EYdsYmr7xmWktXBYirTmyuY0obuP1ci7sLnhXF/8hQKk
         pObY7kIyZ2I48mrMWHJzZr0q3ic+GuYSEpq5kDY5fEUXggcmpWytF+M5SO/4omXludzP
         smbRyD7rGz7toKWyZ+6OnBnjvAPUQbWen7oi1CxZmvJws5EPxFsT4BUsnyZMLrYkiCBU
         sJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vvk+9fjdseiODkVOnE4uRp+LFKP70PHu6kpewmYz8KM=;
        b=SeHwtCbt19ab44mH7LzrQ99UlnzULjGoz6IUrr9UeZ6/Kpe4uYnIGBT/8JLLpU1X+I
         QBcLDk6lXPftaHGud4s5jJfUmO1LmTEnaEjZ3fr8gRt/cjfzBvBKbAQFgnsu80ywdw06
         dkooNtvPSZr+Ub7YxOm3/zFiVJKalz5OOTjGVyGXRbCr/c+6mUBGs6l8VvFF0lk7vrKK
         B6GsWQUhIpqH1UQWrMVwExsJvbg1Y6aEQT2ug7v/PlzAenz4pQiMclt0CkmcT2O5IH61
         Fb2Avw6ncrVMhg7uTkoEIEXep78MDVxfK4h2FBtUdulJc48AJvDmvl5vIViMsa5lJRSJ
         nG5Q==
X-Gm-Message-State: AOAM532mJqJlkKZkNVduIKy/KCvVhyHku59LJbH6mrP53VUwEl70S2kv
        1Jd8pKHl9S1rrwmjdmz652jJ1Qt6a8lU1qM9eWw=
X-Google-Smtp-Source: ABdhPJz2GbpEG1H3J2t4yqsiLVBjqzVbak3ZN83HYVlIav2ix3+eSnHB5WTmb6+KjLFoZE66fYXr1A==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr3708964pjb.103.1651572196275;
        Tue, 03 May 2022 03:03:16 -0700 (PDT)
Received: from localhost ([101.224.171.160])
        by smtp.gmail.com with ESMTPSA id em24-20020a17090b015800b001cd4989fedfsm1030376pjb.43.2022.05.03.03.03.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 May 2022 03:03:15 -0700 (PDT)
From:   Jchao Sun <sunjunchao2870@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, jack@suse.cz,
        Jchao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] Add assert for inode->i_io_list in inode_io_list_move_locked.
Date:   Tue,  3 May 2022 03:03:07 -0700
Message-Id: <20220503100307.44303-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cause of patch b35250c, inode->i_io_list will not only be protected by
wb->list_lock, but also inode->i_lock. And in that patch, Added some assert
for inode->i_lock in some functions except inode_io_list_move_locked.
Should complete it to describe the semantics more clearly. Modified comment
correspondingly.

Signed-off-by: Jchao Sun <sunjunchao2870@gmail.com>
---
 fs/fs-writeback.c | 1 +
 fs/inode.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 591fe9cf1659..5a761b39f36c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -120,6 +120,7 @@ static bool inode_io_list_move_locked(struct inode *inode,
 				      struct list_head *head)
 {
 	assert_spin_locked(&wb->list_lock);
+	assert_spin_locked(&inode->i_lock);
 
 	list_move(&inode->i_io_list, head);
 
diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..bd4da9c5207e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -27,7 +27,7 @@
  * Inode locking rules:
  *
  * inode->i_lock protects:
- *   inode->i_state, inode->i_hash, __iget()
+ *   inode->i_state, inode->i_hash, __iget(), inode->i_io_list
  * Inode LRU list locks protect:
  *   inode->i_sb->s_inode_lru, inode->i_lru
  * inode->i_sb->s_inode_list_lock protects:
-- 
2.17.1

