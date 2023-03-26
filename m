Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5606C9887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCZWZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCZWZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 18:25:36 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7A5241
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Mar 2023 15:25:35 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 32QMOQCa026031;
        Mon, 27 Mar 2023 07:24:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 27 Mar 2023 07:24:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 32QMOQiU026028
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Mar 2023 07:24:26 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6fcbdc89-6aff-064b-a040-0966152856e0@I-love.SAKURA.ne.jp>
Date:   Mon, 27 Mar 2023 07:24:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: [PATCH] sysv: convert pointers_lock from rw_lock to rw_sem
Content-Language: en-US
To:     syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0000000000000ccf9a05ee84f5b0@google.com>
Cc:     hch@infradead.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000000ccf9a05ee84f5b0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting that __getblk_gfp() cannot be called from atomic
context. Fix this problem by converting pointers_lock from rw_lock to
rw_sem.

Reported-by: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+69b40dc5fd40f32c199f@syzkaller.appspotmail.com>
---
 fs/sysv/itree.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..513b20e30afd 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -62,7 +62,7 @@ typedef struct {
 	struct buffer_head *bh;
 } Indirect;
 
-static DEFINE_RWLOCK(pointers_lock);
+static DECLARE_RWSEM(pointers_lock);
 
 static inline void add_chain(Indirect *p, struct buffer_head *bh, sysv_zone_t *v)
 {
@@ -83,7 +83,7 @@ static inline sysv_zone_t *block_end(struct buffer_head *bh)
 }
 
 /*
- * Requires read_lock(&pointers_lock) or write_lock(&pointers_lock)
+ * Requires down_read(&pointers_lock) or down_write(&pointers_lock)
  */
 static Indirect *get_branch(struct inode *inode,
 			    int depth,
@@ -173,11 +173,11 @@ static inline int splice_branch(struct inode *inode,
 	int i;
 
 	/* Verify that place we are splicing to is still there and vacant */
-	write_lock(&pointers_lock);
+	down_write(&pointers_lock);
 	if (!verify_chain(chain, where-1) || *where->p)
 		goto changed;
 	*where->p = where->key;
-	write_unlock(&pointers_lock);
+	up_write(&pointers_lock);
 
 	inode->i_ctime = current_time(inode);
 
@@ -192,7 +192,7 @@ static inline int splice_branch(struct inode *inode,
 	return 0;
 
 changed:
-	write_unlock(&pointers_lock);
+	up_write(&pointers_lock);
 	for (i = 1; i < num; i++)
 		bforget(where[i].bh);
 	for (i = 0; i < num; i++)
@@ -214,9 +214,9 @@ static int get_block(struct inode *inode, sector_t iblock, struct buffer_head *b
 		goto out;
 
 reread:
-	read_lock(&pointers_lock);
+	down_read(&pointers_lock);
 	partial = get_branch(inode, depth, offsets, chain, &err);
-	read_unlock(&pointers_lock);
+	up_read(&pointers_lock);
 
 	/* Simplest case - block found, no allocation needed */
 	if (!partial) {
@@ -287,7 +287,7 @@ static Indirect *find_shared(struct inode *inode,
 	for (k = depth; k > 1 && !offsets[k-1]; k--)
 		;
 
-	write_lock(&pointers_lock);
+	down_write(&pointers_lock);
 	partial = get_branch(inode, k, offsets, chain, &err);
 	if (!partial)
 		partial = chain + k-1;
@@ -296,7 +296,7 @@ static Indirect *find_shared(struct inode *inode,
 	 * fine, it should all survive and (new) top doesn't belong to us.
 	 */
 	if (!partial->key && *partial->p) {
-		write_unlock(&pointers_lock);
+		up_write(&pointers_lock);
 		goto no_top;
 	}
 	for (p=partial; p>chain && all_zeroes((sysv_zone_t*)p->bh->b_data,p->p); p--)
@@ -313,7 +313,7 @@ static Indirect *find_shared(struct inode *inode,
 		*top = *p->p;
 		*p->p = 0;
 	}
-	write_unlock(&pointers_lock);
+	up_write(&pointers_lock);
 
 	while (partial > p) {
 		brelse(partial->bh);
-- 
2.18.4

