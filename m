Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD16D6EB47C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjDUWNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjDUWN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:13:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AE61BE7
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b64a32fd2so3665877b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682115205; x=1684707205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5AkNpnnC51XtdBu29L1YvEWhYLiet10/hNPEtnlk4k=;
        b=G4PoB7ojaq05ZoUvu0bGhZVqKkk7zuFsPAQngKsh3YkvxtolTqu1sE5QemG7mwI9bC
         +lav55U9fdGkURLbrLnJpkwmFYqt+QPV1H3FtmqsyKCWezQ4MHw4sDrMDuq7BBrcauHj
         vF1OEuZHKgdoBCROSFAfcnRZzV8U5N65M2Rkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682115205; x=1684707205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5AkNpnnC51XtdBu29L1YvEWhYLiet10/hNPEtnlk4k=;
        b=XH359akoa229YGwYu1VkW+fKwGTU8PKAr8Mz2gwMmQ53nORVQlL+3EkkqNRBn/OL7g
         YamusukWXlbVm/NTCQe6638Dsc0Ghxs0SaWFxu6BUbRvPlJ0WVF1RqrOBhYXfCd9+TZ9
         RWSXI/9z9pvvh1sWUI8f6MgEvHWLU0o++sKRRuQnD8mfd4K7zlAcVtmaF6KVRQeVDdck
         dWCfve5/e32HjN5FtAfU8ty/ZknCkllQsleBgTRxTaitqkAAM0M0n7pU6eBzbT5iIRVp
         gwWnRedTZ1lXiJ4clIJyq9OMIs004BjMfRpEReROztj04YDiiHCwyiH3962ueEbUWA2g
         AclA==
X-Gm-Message-State: AAQBX9cvfXbv4a+qlNKb2F2CUWDB1XiWsKRvCWl8OId13e0yjC4y2/L8
        M79czi4N/9m4RfF6xWn+mQmA6Q==
X-Google-Smtp-Source: AKy350Zf5b8NMr8PvbXnnwZSXrydNzrK4lJ4UsMs/fDtsJnXPPkwv+LxUNSlTubSDT1jS6eyThlL9A==
X-Received: by 2002:a05:6a00:1393:b0:63f:15cc:9c1a with SMTP id t19-20020a056a00139300b0063f15cc9c1amr6134194pfg.1.1682115205182;
        Fri, 21 Apr 2023 15:13:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:87cc:9018:e569:4a27])
        by smtp.gmail.com with ESMTPSA id y72-20020a62644b000000b006372791d708sm3424715pfb.104.2023.04.21.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:13:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH v2 2/4] buffer: Add lock_buffer_timeout()
Date:   Fri, 21 Apr 2023 15:12:46 -0700
Message-ID: <20230421151135.v2.2.Ie146eec4d41480ebeb15f0cfdfb3bc9095e4ebd9@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230421221249.1616168-1-dianders@chromium.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a variant of lock_buffer() that can timeout. This is useful to
avoid unbounded waits for the page lock in kcompactd.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- "Add lock_buffer_timeout()" new for v2.

 fs/buffer.c                 |  7 +++++++
 include/linux/buffer_head.h | 10 ++++++++++
 include/linux/wait_bit.h    | 24 ++++++++++++++++++++++++
 kernel/sched/wait_bit.c     | 14 ++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..fcd19c270024 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -71,6 +71,13 @@ void __lock_buffer(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(__lock_buffer);
 
+int __lock_buffer_timeout(struct buffer_head *bh, unsigned long timeout)
+{
+	return wait_on_bit_lock_io_timeout(&bh->b_state, BH_Lock,
+					   TASK_UNINTERRUPTIBLE, timeout);
+}
+EXPORT_SYMBOL(__lock_buffer_timeout);
+
 void unlock_buffer(struct buffer_head *bh)
 {
 	clear_bit_unlock(BH_Lock, &bh->b_state);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 8f14dca5fed7..2bae464f89d5 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -237,6 +237,7 @@ struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
 void free_buffer_head(struct buffer_head * bh);
 void unlock_buffer(struct buffer_head *bh);
 void __lock_buffer(struct buffer_head *bh);
+int __lock_buffer_timeout(struct buffer_head *bh, unsigned long timeout);
 int sync_dirty_buffer(struct buffer_head *bh);
 int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
 void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
@@ -400,6 +401,15 @@ static inline void lock_buffer(struct buffer_head *bh)
 		__lock_buffer(bh);
 }
 
+static inline int lock_buffer_timeout(struct buffer_head *bh,
+				      unsigned long timeout)
+{
+	might_sleep();
+	if (!trylock_buffer(bh))
+		return __lock_buffer_timeout(bh, timeout);
+	return 0;
+}
+
 static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 						   sector_t block,
 						   unsigned size)
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..33f0f60b1c8c 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -30,6 +30,7 @@ void wake_up_bit(void *word, int bit);
 int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
 int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
 int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
+int out_of_line_wait_on_bit_lock_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
 struct wait_queue_head *bit_waitqueue(void *word, int bit);
 extern void __init wait_bit_init(void);
 
@@ -208,6 +209,29 @@ wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)
 	return out_of_line_wait_on_bit_lock(word, bit, bit_wait_io, mode);
 }
 
+/**
+ * wait_on_bit_lock_io_timeout - wait_on_bit_lock_io() with a timeout
+ * @word: the word being waited on, a kernel virtual address
+ * @bit: the bit of the word being waited on
+ * @mode: the task state to sleep in
+ * @timeout: the timeout in jiffies; %MAX_SCHEDULE_TIMEOUT means wait forever
+ *
+ * Returns zero if the bit was (eventually) found to be clear and was
+ * set.  Returns non-zero if a timeout happened or a signal was delivered to
+ * the process and the @mode allows that signal to wake the process.
+ */
+static inline int
+wait_on_bit_lock_io_timeout(unsigned long *word, int bit, unsigned mode,
+			    unsigned long timeout)
+{
+	might_sleep();
+	if (!test_and_set_bit(bit, word))
+		return 0;
+	return out_of_line_wait_on_bit_lock_timeout(word, bit,
+						    bit_wait_io_timeout,
+						    mode, timeout);
+}
+
 /**
  * wait_on_bit_lock_action - wait for a bit to be cleared, when wanting to set it
  * @word: the word being waited on, a kernel virtual address
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 0b1cd985dc27..629acd1c6c79 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -118,6 +118,20 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
+int __sched out_of_line_wait_on_bit_lock_timeout(void *word, int bit,
+						 wait_bit_action_f *action,
+						 unsigned mode,
+						 unsigned long timeout)
+{
+	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
+	DEFINE_WAIT_BIT(wq_entry, word, bit);
+
+	wq_entry.key.timeout = jiffies + timeout;
+
+	return __wait_on_bit_lock(wq_head, &wq_entry, action, mode);
+}
+EXPORT_SYMBOL(out_of_line_wait_on_bit_lock_timeout);
+
 void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
-- 
2.40.0.634.g4ca3ef3211-goog

