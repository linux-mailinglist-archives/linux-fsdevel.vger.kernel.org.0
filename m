Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41E655A0B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiFXSV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXSV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:21:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF24456C37;
        Fri, 24 Jun 2022 11:21:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso6552348pjg.1;
        Fri, 24 Jun 2022 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5YJ65pvDdEwq3atTRzFu054q854VYDQ/r8rcFUwysg=;
        b=VufbRJ4GpKPqMP701/bggIhVtf11LdAOfoZb9tap7+gmimqkQXAviT5LJdOx5Smn/H
         hCjemWQA8ZtNBBROfP/qmmvoLGncmPisF87Xez3+XuxTZBszqzvmdrl7boDPhc2LdYj6
         PnSQShnAosrQzC78g/XUdzDBduKPAYE6IQCQupqCXQik1+B8knWtIMjMWusjrSmxsZK/
         fLKAo1JsfR2/je76z2yHkMtYQ4iRSdT/6AHM9/GLB/MAsxdaVhPYB2+9q7UcmsQtf1pY
         flV/4h6KYU2/IqvlKuaAkSvS3VjIBHsm1PJe2h26JbJGJIH20C0fPjg3c35Q0NxZPerL
         1Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5YJ65pvDdEwq3atTRzFu054q854VYDQ/r8rcFUwysg=;
        b=Ump49RFd9w2aTeNceqWGF4imdo6QMyRDL8mgibA4iIvlfeF1WDh5ILyzoOVi+xYZbK
         3v+9NcKySBpy9qIwbA5oLKXGBdrlKgP0nCLD+LyEvsmOggWOOh7Crw4VvzbnnJD4PRH5
         qWAUZQxwydvF9SzDADS6Go2HQ8xRG/ouJT9gjf/ehLzNff0e4yTB5FpJfvokdZfTen7X
         AZpQ3JplNvl4sKZ55LiGkSVOomHDk/vWJ9Zq9K9xe5kZQhRYZaJDigqWR7SUxjQDgxaq
         bU0VDqYC1GbB5bTacUW1PtE9movE5h0hys3HgVd0U6Z0AZR3Rhh827a7C7LQRlvs8pSd
         3JDA==
X-Gm-Message-State: AJIora8/h075Hu/7jsFPkJVXvT1cJdY5GhGL45Y1AyKAe+HsGj3YbZga
        Qhv6gghZDyYIIg23Ut6DlfCIj2cbM2E=
X-Google-Smtp-Source: AGRyM1sFD9bcbdzSpjXDlvoIE+L8SqCeXx9XLaApcPkSgwXvzavEDcMfL387kacADsMW6D3geeArEw==
X-Received: by 2002:a17:90b:4a42:b0:1ec:ae10:3408 with SMTP id lb2-20020a17090b4a4200b001ecae103408mr221715pjb.172.1656094887365;
        Fri, 24 Jun 2022 11:21:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b00524e2f81727sm2018726pfb.74.2022.06.24.11.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:21:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     viro@zeniv.linux.org.uk, hughd@google.com
Cc:     ran.xiaokai@zte.com.cn, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] drop caches: skip tmpfs and ramfs
Date:   Fri, 24 Jun 2022 18:21:21 +0000
Message-Id: <20220624182121.995294-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

All tmpfs and ramfs pages have PG_dirty bit set
once they are allocated and added to the pagecache。So pages
can not be freed from tmpfs or ramfs. So skip tmpfs and ramfs
when drop caches.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 fs/drop_caches.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..600c043c1eb7 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -10,6 +10,7 @@
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
+#include <linux/magic.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -19,6 +20,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	if (sb->s_magic == TMPFS_MAGIC || sb->s_magic == RAMFS_MAGIC)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-- 
2.15.2

