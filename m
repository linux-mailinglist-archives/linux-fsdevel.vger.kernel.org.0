Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E3E245290
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgHOVxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729163AbgHOVwo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB373C004593
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:48:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so4012171plr.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z2xPpRoHP7BzvSX2rjf/bwJ13SQNsG5PYmvhRIAd2sU=;
        b=BGEhN/WbxTSkRKE60J3CvxmlY0UKRwp/ZAg2U45KlXRgN/v22AODymoCybBpuELHV0
         gJiM8R0WOAwzDxsIYSpFiIrtUl6bPq4CRMs7zzUC85FWMhbaZA6TQo5KugLzFSwFV+M5
         DETZEEYKUO3FHXdeFU5FPCcxbslgBH1bLKQYKi+xkXMquvWPJGCrtbRidRLvonRf8XKm
         MASkzLIGO//+pjB4BrxXuiUtW9kWXJNEd+OEeLjxyTEBRAwfC73k3K3Qn2sV0yHOFLMe
         sd9D2+Q4fxUE0wHI7tUlUKxhmH2LM/eULQgvaVqrUXvh/U7N7SrzPaR6krKkJkazlHXj
         7kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2xPpRoHP7BzvSX2rjf/bwJ13SQNsG5PYmvhRIAd2sU=;
        b=crd58xHuNi8v+NA3gZjjDUzk7uAp1zSkObQTQ/kS/kdJzXyc0IU361K+h+/KtEBv4J
         Oes3By5VBsbI/VZC95uXlRmGDNeCwbs3Q85Zy06HnPa5VKPfghxKJdWL/KqBwetjBngX
         Ot70/Q39yjnJtKY9F5SQ9nKWNBcYg7vVyS1AwEPMDgkSQBeItXLmYX3XnTv0JCa+001K
         dKFbLw3+xKZmHmMJU1KIWESWj+NMtPD4HTNSTB9YfBbE8zcV1pgsAxFm8iG8EUOwN1+5
         wbzS/ZuN5TNnHIA7P3mBquFoyMXqxq6szeWl80bBUfeugwzr/TPDqveT1VtlMeDfD/XV
         XRTg==
X-Gm-Message-State: AOAM532P5VoL7MS7ICEUHzDMpZw6kAhauf5eSrKfaGvZ2AHObtT3JBpK
        S4JEmL+yXEVHJ6FtYAqotA8BpA==
X-Google-Smtp-Source: ABdhPJx2mzq8cS50/9IeaIq3A/NHdBiAOJ23/yFhnZW3jwTW9wfQhvvXukV2bvVi1sqca5xchRsk+w==
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr6629664pjb.151.1597517334243;
        Sat, 15 Aug 2020 11:48:54 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6299:2df1:e468:6351? ([2605:e000:100e:8c61:6299:2df1:e468:6351])
        by smtp.gmail.com with ESMTPSA id b63sm12599824pfg.43.2020.08.15.11.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2020 11:48:53 -0700 (PDT)
Subject: Re: general protection fault in io_poll_double_wake
From:   Jens Axboe <axboe@kernel.dk>
To:     syzbot <syzbot+7f617d4a9369028b8a2c@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000018f60505aced798e@google.com>
 <fb1fe8ff-5c79-a020-f6ea-a28f974bde6b@kernel.dk>
Message-ID: <178c8252-eb93-daaf-61fd-f0652de3b658@kernel.dk>
Date:   Sat, 15 Aug 2020 11:48:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb1fe8ff-5c79-a020-f6ea-a28f974bde6b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/20 11:16 AM, Jens Axboe wrote:
> On 8/15/20 10:00 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    7fca4dee Merge tag 'powerpc-5.9-2' of git://git.kernel.org..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1264d116900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7f617d4a9369028b8a2c
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f211d2900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1721b0ce900000
>>
>> The issue was bisected to:
>>
>> commit 18bceab101adde8f38de76016bc77f3f25cf22f4
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Fri May 15 17:56:54 2020 +0000
>>
>>     io_uring: allow POLL_ADD with double poll_wait() users
> 
> I can reproduce this, I'll fix it up. Thanks!

This should fix it:


From 34fc8d0b76572c9fb184ab589d682dccfeb5c039 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 15 Aug 2020 11:44:50 -0700
Subject: [PATCH] io_uring: sanitize double poll handling

There's a bit of confusion on the matching pairs of poll vs double poll,
depending on if the request is a pure poll (IORING_OP_POLL_ADD) or
poll driven retry.

Add io_poll_get_double() that returns the double poll waitqueue, if any,
and io_poll_get_single() that returns the original poll waitqueue. With
that, remove the argument to io_poll_remove_double().

Finally ensure that wait->private is cleared once the double poll handler
has run, so that remove knows it's already been seen.

Cc: stable@vger.kernel.org # v5.8
Reported-by: syzbot+7f617d4a9369028b8a2c@syzkaller.appspotmail.com
Fixes: 18bceab101ad ("io_uring: allow POLL_ADD with double poll_wait() users")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7dd6df15bc49..cb030912bf5e 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4649,9 +4649,24 @@ static bool io_poll_rewait(struct io_kiocb *req, struct io_poll_iocb *poll)
 	return false;
 }
 
-static void io_poll_remove_double(struct io_kiocb *req, void *data)
+static struct io_poll_iocb *io_poll_get_double(struct io_kiocb *req)
 {
-	struct io_poll_iocb *poll = data;
+	/* pure poll stashes this in ->io, poll driven retry elsewhere */
+	if (req->opcode == IORING_OP_POLL_ADD)
+		return (struct io_poll_iocb *) req->io;
+	return req->apoll->double_poll;
+}
+
+static struct io_poll_iocb *io_poll_get_single(struct io_kiocb *req)
+{
+	if (req->opcode == IORING_OP_POLL_ADD)
+		return &req->poll;
+	return &req->apoll->poll;
+}
+
+static void io_poll_remove_double(struct io_kiocb *req)
+{
+	struct io_poll_iocb *poll = io_poll_get_double(req);
 
 	lockdep_assert_held(&req->ctx->completion_lock);
 
@@ -4671,7 +4686,7 @@ static void io_poll_complete(struct io_kiocb *req, __poll_t mask, int error)
 {
 	struct io_ring_ctx *ctx = req->ctx;
 
-	io_poll_remove_double(req, req->io);
+	io_poll_remove_double(req);
 	req->poll.done = true;
 	io_cqring_fill_event(req, error ? error : mangle_poll(mask));
 	io_commit_cqring(ctx);
@@ -4711,7 +4726,7 @@ static int io_poll_double_wake(struct wait_queue_entry *wait, unsigned mode,
 			       int sync, void *key)
 {
 	struct io_kiocb *req = wait->private;
-	struct io_poll_iocb *poll = req->apoll->double_poll;
+	struct io_poll_iocb *poll = io_poll_get_single(req);
 	__poll_t mask = key_to_poll(key);
 
 	/* for instances that support it check for an event match first: */
@@ -4725,6 +4740,8 @@ static int io_poll_double_wake(struct wait_queue_entry *wait, unsigned mode,
 		done = list_empty(&poll->wait.entry);
 		if (!done)
 			list_del_init(&poll->wait.entry);
+		/* make sure double remove sees this as being gone */
+		wait->private = NULL;
 		spin_unlock(&poll->head->lock);
 		if (!done)
 			__io_async_wake(req, poll, mask, io_poll_task_func);
@@ -4808,7 +4825,7 @@ static void io_async_task_func(struct callback_head *cb)
 	if (hash_hashed(&req->hash_node))
 		hash_del(&req->hash_node);
 
-	io_poll_remove_double(req, apoll->double_poll);
+	io_poll_remove_double(req);
 	spin_unlock_irq(&ctx->completion_lock);
 
 	if (!READ_ONCE(apoll->poll.canceled))
@@ -4919,7 +4936,7 @@ static bool io_arm_poll_handler(struct io_kiocb *req)
 	ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask,
 					io_async_wake);
 	if (ret || ipt.error) {
-		io_poll_remove_double(req, apoll->double_poll);
+		io_poll_remove_double(req);
 		spin_unlock_irq(&ctx->completion_lock);
 		kfree(apoll->double_poll);
 		kfree(apoll);
@@ -4951,14 +4968,13 @@ static bool io_poll_remove_one(struct io_kiocb *req)
 {
 	bool do_complete;
 
+	io_poll_remove_double(req);
+
 	if (req->opcode == IORING_OP_POLL_ADD) {
-		io_poll_remove_double(req, req->io);
 		do_complete = __io_poll_remove_one(req, &req->poll);
 	} else {
 		struct async_poll *apoll = req->apoll;
 
-		io_poll_remove_double(req, apoll->double_poll);
-
 		/* non-poll requests have submit ref still */
 		do_complete = __io_poll_remove_one(req, &apoll->poll);
 		if (do_complete) {
-- 
2.28.0


-- 
Jens Axboe

