Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D069351275
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhDAJhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbhDAJhL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:37:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A293C061788
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 02:37:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q5so1017990pfh.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcgJPI+OLnXKS6f2jEHdXibOScXid3UD2wHpcMZsYC8=;
        b=XXHnwjtjUIXHglDE8sYs3uix5dsEwoiOr126fLR+uD3MRWnDxS5mXundRMl6oyKp8G
         0BLCnAd0wZdUTDQv56WayLebeE+LCDZkat3P2QE/0k4sHmu8NBn0RGQRL6DskgayhEpO
         f7OYOJq4cZf1cTx/cZ9d26eS+5jXRdj/j6OunAYDgBQsW3YFdnLcJadkiiuoPIQepTQz
         SejeuXsZq8aFLT/CMxOee3LtDWYILC+Tl5e/mZ9gSpTzd8IItpg22a7lTIMUfH+6YlmD
         ZyTzP9SIX/AQO1VFFJHw8ibEa1T0YPK9AzIhi9n+n+HwhvxGAX+4pSKt25A/Ehm2YWml
         n8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mcgJPI+OLnXKS6f2jEHdXibOScXid3UD2wHpcMZsYC8=;
        b=nle1NjZk6tNvc6F5LSRcW+Q9pwWwXxpsGVWBe0oPy2mlaYfp6FWbqX4aXWUqB+oNiy
         fGg2SzSkVwTvnpWo/KBjA5qdA1e2X3w04Qnze5/8lRKjGJei1fJCYn+Qaxshxtwn65Tc
         1WwUxOjPT/csT6RHrcKpK4WlwIrFXVfbIxtDI1062lxLooJMb5p34LYinfgUV0MBXul9
         OQSQNTnR6vy9tKEfULjFUIo++oZqTXz+UKPbfIpGaI5IrkbV4dQv9AFKhkDdethjH+AX
         duqaqZSk5apw9aQdhJdV0Xerk6zZFV1r+W/Wo944jJV1FlhHB+8mhJyx/rU5BXAPHyay
         QpZQ==
X-Gm-Message-State: AOAM532/6bJZF5menlVUscqKplkak0PGGJPyy39fTdfrUk+ie9E5ksUK
        Ue0DngCvtziSChLGj7ZvKaS5Eg==
X-Google-Smtp-Source: ABdhPJxkfP7QA7T16arIV78STn7cljX0N93gxkGF9gMmDTfxUDZogi1r5p1jZl2QT4ir2ZVOhGGaSQ==
X-Received: by 2002:a65:4c43:: with SMTP id l3mr6637800pgr.327.1617269831183;
        Thu, 01 Apr 2021 02:37:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id h13sm4710189pjv.52.2021.04.01.02.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:37:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] writeback: fix obtain a reference to a freeing memcg css
Date:   Thu,  1 Apr 2021 17:33:43 +0800
Message-Id: <20210401093343.51299-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The caller of wb_get_create() should pin the memcg, because
wb_get_create() relies on this guarantee. The rcu read lock
only can guarantee that the memcg css returned by css_from_id()
cannot be released, but the reference of the memcg can be zero.
Fix it by holding a reference to the css before calling
wb_get_create(). This is not a problem I encountered in the
real world. Just the result of a code review.

And it is unnecessary to use GFP_ATOMIC, so replace it with
GFP_NOIO.

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
Changelog in v2:
 1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.

 fs/fs-writeback.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..df7f89f8f771 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -501,16 +501,21 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
 		return;
 
-	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
+	isw = kzalloc(sizeof(*isw), GFP_NOIO);
 	if (!isw)
 		return;
 
 	/* find and pin the new wb */
 	rcu_read_lock();
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
-	if (memcg_css)
-		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	if (memcg_css && !css_tryget(memcg_css))
+		memcg_css = NULL;
 	rcu_read_unlock();
+	if (!memcg_css)
+		goto out_free;
+
+	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
+	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
 
-- 
2.11.0

