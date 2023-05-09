Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231666FD2A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjEIWXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjEIWXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 18:23:03 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75935199B
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 15:23:00 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 349MMwQI004688;
        Wed, 10 May 2023 07:22:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 10 May 2023 07:22:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 349MMwNn004685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 10 May 2023 07:22:58 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <610781bc-cf11-fc89-a46f-87cb8235d439@I-love.SAKURA.ne.jp>
Date:   Wed, 10 May 2023 07:22:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: [PATCH] workingset: add missing rcu_read_unlock() in
 lru_gen_refault()
Content-Language: en-US
To:     syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>
References: <0000000000004c3e6b05fb414be2@google.com>
Cc:     linux-mm <linux-mm@kvack.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000004c3e6b05fb414be2@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting sleep in RCU context, for commit d66c718d28ac
("workingset: refactor LRU refault to expose refault recency check")
missed rcu_read_unlock().

Reported-by: syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3c6cac1550288f8e7060
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: d66c718d28ac ("workingset: refactor LRU refault to expose refault recency check")
---
 mm/workingset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index d81f9dafc9f1..90ae785d4c9c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -303,7 +303,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 		goto unlock;
 
 	if (pgdat != folio_pgdat(folio))
-		return;
+		goto unlock;
 
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
-- 
2.18.4


