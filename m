Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451CC1079C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 13:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEALt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 07:49:58 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:58872 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfEALt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 07:49:58 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 81894C02E1B;
        Wed,  1 May 2019 11:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556711395;
        bh=F44zzl5VtydQMPbN9B2W6/ZfAyaCpUB96dYx/bsHxGA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tHD6tIb+14lEA33k4p1Lka8KVMxsJ3iKf/9+6alKDFimlbpT+jr0PcQca8lHsW7aq
         Kx8G/0suIlgAiEV1YAIXjp2Xulk/1mVZhpIs1n1OA25AlYJuNUpiXmC5yRZbAB/o9Y
         CLcCBgzj1e8bNC8UiPpQ8H0ftphMNBYFFH5vnVbs=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] [io_uring] don't stall on submission errors
Date:   Wed,  1 May 2019 13:49:55 +0200
Message-Id: <20190501114955.13103-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <fc1f2755-2c79-f5de-4057-ff658f3919ca@kernel.dk>
References: <fc1f2755-2c79-f5de-4057-ff658f3919ca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stalling is buggy right now, because it might wait for too many events;
for proper stalling we'd need to know how many submissions we ignored,
and reduce min_complete by that amount.

Easier not to stall at all.

Also fix some local variable names.

Should probably be merged with commit
fd25de20d38dd07e2ce7108986f1fd08f9bf03d4:
    io_uring: have submission side sqe errors post a cqe

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e614a675a1e0..17eae94a54fc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1846,7 +1846,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			  unsigned int nr, bool has_user, bool mm_fault)
 {
 	struct io_submit_state state, *statep = NULL;
-	int ret, i, submitted = 0;
+	int ret, i, inflight = 0;
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
@@ -1863,7 +1863,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 			ret = io_submit_sqe(ctx, &sqes[i], statep);
 		}
 		if (!ret) {
-			submitted++;
+			inflight++;
 			continue;
 		}
 
@@ -1873,7 +1873,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *sqes,
 	if (statep)
 		io_submit_state_end(&state);
 
-	return submitted;
+	return inflight;
 }
 
 static int io_sq_thread(void *data)
@@ -2011,7 +2011,7 @@ static int io_sq_thread(void *data)
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
-	int i, submit = 0;
+	int i, submitted = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, to_submit);
@@ -2028,12 +2028,11 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.has_user = true;
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
-		submit++;
+		submitted++;
 
 		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
 			io_cqring_add_event(ctx, s.sqe->user_data, ret, 0);
-			break;
 		}
 	}
 	io_commit_sqring(ctx);
@@ -2041,7 +2040,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 	if (statep)
 		io_submit_state_end(statep);
 
-	return submit;
+	return submitted;
 }
 
 static unsigned io_cqring_events(struct io_cq_ring *ring)
@@ -2779,15 +2778,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 
 		min_complete = min(min_complete, ctx->cq_entries);
 
-		/*
-		 * The application could have included the 'to_submit' count
-		 * in how many events it wanted to wait for. If we failed to
-		 * submit the desired count, we may need to adjust the number
-		 * of events to poll/wait for.
-		 */
-		if (submitted < to_submit)
-			min_complete = min_t(unsigned, submitted, min_complete);
-
 		if (ctx->flags & IORING_SETUP_IOPOLL) {
 			mutex_lock(&ctx->uring_lock);
 			ret = io_iopoll_check(ctx, &nr_events, min_complete);
-- 
2.20.1

