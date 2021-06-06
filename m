Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B1C39CC5E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 05:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFDIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Jun 2021 23:08:24 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:35802 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFDIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Jun 2021 23:08:24 -0400
Received: by mail-pg1-f171.google.com with SMTP id o9so8294112pgd.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Jun 2021 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmNq4peZOAOyDPklFXMeKeYFKClQGReaGV/U+xkvXQ0=;
        b=w7tT8XJpLxNPgu+o/5mF+K2jB/4Nuo2lE+4B0epXqNpufBtNPiER3R7Tss6U6gkmar
         IQFrIZ/Whw8TqMtbCCbBq9F41ZBiIFybwAsEhPcN1iA/+JWsOXjkgVDJbHA5L8GN7YyR
         xpbYvCGtDVd7Ayl7jcqd1/V3RElnhQAGivpppSn6L8IY9AAD98EfNpPb8WOM8DkVAsLf
         LqlNRVZwIUtCi6ilNm9ot8vxwa/cOCRT5+fWgFVvMJRXbGk4W1OhaliyolRCJfUNCTlk
         fiA2NbJSPmbLubBh/TfW8UECkjmQwTLQ5UT8pXaTluyg/X6VZvW6Df4/BrbJ3UkY8eXw
         boIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmNq4peZOAOyDPklFXMeKeYFKClQGReaGV/U+xkvXQ0=;
        b=lwjd4Qwg9g7PldNf0VBl7fo8p8fI4SjV3nTg+N15xwlFvJN3LIYy6Szpvjv16ZuBX9
         XHJqN6E7fJPR5IhJbMHcvedvB8lEYpLTl9XRsHGVMrB8fRKDT2+AND4ofv8bTmGLwCR0
         p1gDvB0aDg/M5vvolHdKS4tflqH/PIHGC9WE4EcYPoeFpwhzwaOfeZFJEwzlpvl6YVU+
         u/xmAFZOzFJJc6Ac2mp23KjUl5NDgTQUKuuMs3c8mkkfGqVaLxQOGT/EsKJ2CqSOkVh1
         TevyFR298QjVq+UaIGAjmK/1qkxyYn333T2HgBRl7I3Ihy6mSsrUupOyeF1vAr8saJUn
         u6rA==
X-Gm-Message-State: AOAM533Z54rmX0TP7A1SouPZWw0THw0TsScjxlWEB2B+9IAYLfD+q/6A
        BO2yJI9OL8s8j0ly3WF6fa9ucA==
X-Google-Smtp-Source: ABdhPJwupnG0F7AOML64hOYrBSXuTXNGc5Kpa7E8SpvMxYSBytsEswYDa/ueeM2osUYRANIxrxCxqA==
X-Received: by 2002:aa7:8588:0:b029:28e:dfa1:e31a with SMTP id w8-20020aa785880000b029028edfa1e31amr11432836pfn.77.1622948720555;
        Sat, 05 Jun 2021 20:05:20 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id q23sm5435219pgj.61.2021.06.05.20.05.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jun 2021 20:05:20 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: [PATCH RESEND v3] writeback: fix obtain a reference to a freeing memcg css
Date:   Sun,  6 Jun 2021 11:02:26 +0800
Message-Id: <20210606030226.66667-1-songmuchun@bytedance.com>
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

  rcu_read_lock()
  memcg_css = css_from_id()
  wb_get_create(memcg_css)
      cgwb_create(memcg_css)
          // css_get can change the ref counter from 0 back to 1
          css_get(memcg_css)
  rcu_read_unlock()

Fix it by holding a reference to the css before calling
wb_get_create(). This is not a problem I encountered in the
real world. Just the result of a code review.

Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
---
Since this patch has not been merged to the linux-next tree,
just resend it.

Changelog in v3:
 1. Do not change GFP_ATOMIC.
 2. Update commit log.

 Thanks for Michal's review and suggestions.

Changelog in v2:
 1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.

 fs/fs-writeback.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3ac002561327..dedde99da40d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -506,9 +506,14 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
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
+	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	css_put(memcg_css);
 	if (!isw->new_wb)
 		goto out_free;
 
-- 
2.11.0

