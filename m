Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC30C272A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfI3Urz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 16:47:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39139 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3Urz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:47:55 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MBUZr-1iQpiz3595-00D3fn; Mon, 30 Sep 2019 22:21:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>,
        Hannes Reinecke <hare@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hristo Venev <hristo@venev.name>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: use __kernel_timespec in timeout ABI
Date:   Mon, 30 Sep 2019 22:20:39 +0200
Message-Id: <20190930202055.1748710-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mlQX66YyJ89UsdNDcTaUDMkvDllD+MCdC0jwrPAhCDuUuJh0vOk
 zZ1jwySfQ09oEHruJb93xi023HsV+efktaoKqvpmHhP68Y4byhgRSjNpgjGQ3pvTTAS7rFA
 09K8xy6PviTkfJyCKQI2+MF+0GZfaZPB8iiYdBkkw2ex2b4niBs+M6FIX3/0Hs4nPJ2Ci+M
 QEWGo3Z0tATHhXTDBD6Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NV7gpjrMSJA=:okYpni+B9mopWZLlHONDJp
 xR8Uqy/ksQ9sz7P/lCZkqV1RHmQLWxi3Zcs9hP7G23NVdti21bzURdIU8KTe8KorJ2ZE52kzA
 JUY4ayZuWOuSN7SGagfzyLt2BJzmrmf/061UoiEHcSTXXZc8d3jsNnx1elf6C7BBJ6ufxKa+7
 NGYghSmO7UImkraFvg4CGdj8OK+Gh+82IZhA60bkWtkwNjFgdEJHbvFGGH7JLYUFth9c7+sxx
 vIb7BtF+63ZinJM6CA02I1FB/BAWQ8cLxI/F6iF5Un4JPbU5306X8Xb0OyVAkRdW52z2jUwsV
 FoqciNCWCdpZgxclQ4RczL+bc0/UkJxzU0kXQX9stuMQvMoSnDVLPGoismnyM5ukkA2dqPgCK
 j0fk85HX4KT1XeREo9XqHJrPPPE5XsIlETM58guXXs7H6MOmJFepI4ouGc/CeCybxqQSJeo0r
 iHrmwdqsvXNCSoyfRKxU+MTNY0P7xASYwJVNF2XRlcQ/BV9dgDjzZs+DRVwcBFwnwuHyIwO3P
 bP46smitC23t94UHyI7EehWvWuzx6mwwhySFEkX5onBqTcveJ2NyIkgpeTzQ8u4qHu6SSuSES
 pxQLbTHA+RgF2m6mB5C0EFqCvAmtdF3qlwudBVIABDFAKnSQZ/N2Di0ufu2/aH2RffXW2Yhc2
 BeYzdWjHiLQ9BoEPmet/gFeqOPy9L2R0OxZ5ZSD7ICczYGaCZ60Emlm9iZXebCTZVUVwJgHgD
 kpv9hy/fIGz4pByWEspBJQPhyg+6nRjSCy5lUcp7S1hv2DD5M/1vUHnwY9HPN+PvKEbQM7cnX
 SXzxqb7MJoSDoOzR0TSTBVMQTcIwZJDTdVt8NzikvdQiyqkcIuxI0UytpsnLgVY1yM/GzlS1B
 s6w+hxhaCHK4Aws2hZrA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All system calls use struct __kernel_timespec instead of the old struct
timespec, but this one was just added with the old-style ABI. Change it
now to enforce the use of __kernel_timespec, avoiding ABI confusion and
the need for compat handlers on 32-bit architectures.

Any user space caller will have to use __kernel_timespec now, but this
is unambiguous and works for any C library regardless of the time_t
definition. A nicer way to specify the timeout would have been a less
ambiguous 64-bit nanosecond value, but I suppose it's too late now to
change that as this would impact both 32-bit and 64-bit users.

Fixes: 5262f567987d ("io_uring: IORING_OP_TIMEOUT support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/io_uring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index aa8ac557493c..8a0381f1a43b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1892,15 +1892,15 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	unsigned count, req_dist, tail_index;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct list_head *entry;
-	struct timespec ts;
+	struct timespec64 ts;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
 	    sqe->len != 1)
 		return -EINVAL;
-	if (copy_from_user(&ts, (void __user *) (unsigned long) sqe->addr,
-	    sizeof(ts)))
+
+	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
 		return -EFAULT;
 
 	/*
@@ -1934,7 +1934,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	req->timeout.timer.function = io_timeout_fn;
-	hrtimer_start(&req->timeout.timer, timespec_to_ktime(ts),
+	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts),
 			HRTIMER_MODE_REL);
 	return 0;
 }
-- 
2.20.0

