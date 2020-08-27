Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19E725478B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgH0OvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:51:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62448 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgH0N2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:28:18 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07RDRrPG009820;
        Thu, 27 Aug 2020 22:27:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Thu, 27 Aug 2020 22:27:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07RDRqQU009816
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 27 Aug 2020 22:27:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] block: allow for_each_bvec to support zero len bvec
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20200810031915.2209658-1-ming.lei@redhat.com>
 <db57f8ca-b3c3-76ec-1e49-d8f8161ba78d@i-love.sakura.ne.jp>
 <20200810162331.GA2215158@T590>
 <4ec1b96f-b23c-6f9c-2dc1-8c3d47689a77@i-love.sakura.ne.jp>
Message-ID: <cf26a57e-01f4-32a9-0b2c-9102bffe76b2@i-love.sakura.ne.jp>
Date:   Thu, 27 Aug 2020 22:27:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4ec1b96f-b23c-6f9c-2dc1-8c3d47689a77@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens or Al, will you pick up
"[PATCH V2] block: allow for_each_bvec to support zero len bvec"
( https://lkml.kernel.org/r/20200817100055.2495905-1-ming.lei@redhat.com )
which needs be backported to 5.5+ kernels in order to avoid DoS attack
by a local unprivileged user.

David, is the patch show below (which should be backported to 5.5+ kernels)
correct? Is splice_from_pipe_next() the better location to check?
Are there other consumers which needs to do the same thing?

From 60c3e828f9d8279752865d80411c9b19dbe5c35c Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 27 Aug 2020 22:17:02 +0900
Subject: [PATCH] splice: fix premature end of input detection

splice() from pipe should return 0 when there is no pipe writer. However,
since commit a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write()
to preallocate slot") started inserting empty pages, splice() from pipe
also returns 0 when all ready buffers are empty pages. Since such behavior
might confuse splice() users, let's fix it by waiting for non-empty pages
before building the vector.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Fixes: a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write() to preallocate slot")
Cc: stable@vger.kernel.org # 5.5+
---
 fs/splice.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07..52daa5fea879 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -724,6 +724,19 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		tail = pipe->tail;
 		mask = pipe->ring_size - 1;
 
+		/* dismiss the empty buffers */
+		while (!pipe_empty(head, tail)) {
+			struct pipe_buffer *buf = &pipe->bufs[tail & mask];
+
+			if (likely(buf->len))
+				break;
+			pipe_buf_release(pipe, buf);
+			pipe->tail = ++tail;
+		}
+		/* wait again if all buffers were empty */
+		if (unlikely(pipe_empty(head, tail)))
+			continue;
+
 		/* build the vector */
 		left = sd.total_len;
 		for (n = 0; !pipe_empty(head, tail) && left && n < nbufs; tail++, n++) {
-- 
2.18.4

