Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A1FFCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3SmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:42:07 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41517 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfD3SmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:42:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7241270pgs.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4BeSsEexnTz3hLNHkjUjZ2x7bY6NrmR7kz1DmMBCBTs=;
        b=eUKC68jnv9ctStElBZpJeYSW3p1MDAUkwGOiAvgaERbiX9geYSV3J9aw3WKjUczwiJ
         l8EBfXVWC9o3usfnTtnZqlxaD2g1ab4z/hKWMCQSL5TdLSlKYN01omsv/PHAaQhx9O6F
         LDEbHMBtWNui79+PU/SIKx2R7mKIrLfEJaCyFZbT8/qfuEqtEMi3bqf/a8di2V4YWkfC
         4v84HCj7AbSyDkyqrZ25F/JXMbaYd/Ut4kem/iqnw5cM+GYGsq6AfpafSxtj8NS0tpvb
         dC9j/g+kkJgOdV8HR+/Q/YdSzU0/08NYcvqmEWuBdDEBVZEn+CMqSSqTXfnVC+Arq+kj
         0L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4BeSsEexnTz3hLNHkjUjZ2x7bY6NrmR7kz1DmMBCBTs=;
        b=ONEzE+GHpANioU8y2Fo/HGG2HGzKY5O7Yl3XPP+Slj7GmELpHfXVivfFcmv4suXcCy
         fXv0hUbPO4u98yWaaTiwoyA7XUX8D2L0RNF3opIAhzjJUIp4Xy+ZxQeB5V7/McpNI6aS
         3hWGXT1xoIKnvc8AzMM2Lwb94kQABimjnGb3Tj7FbGGOAo1uY5jbl8aLAmAc4ek7nBIq
         1AHCzYpU7tFQt5P6ZGbkEJcnKiiQO0wv+zYJVcsU0FtHDvq0SyWsee1gqYB7KHDqlzAR
         N6rKtWaLm6azLM7HV2quRQD+L74XW4SPzsfYI0Ywuc36W+euvtEqahQJfiyaaJOYYAcA
         VEWw==
X-Gm-Message-State: APjAAAXXJ3SiLxkn2pNPNaoJ7Y/SavHaEWXvEgZgvWN3mK7cN/R1C6h7
        +XMRsxkSqY+PgSx6i4rpaBYBuBGsp32HZg==
X-Google-Smtp-Source: APXvYqyKl51hOLYnechYsAm+DEk1UjJONWaMXqpReHCWvoflA4bBF6DSKoD5AneP5YuFDlbiUIs7FA==
X-Received: by 2002:a63:58b:: with SMTP id 133mr10999656pgf.138.1556649725927;
        Tue, 30 Apr 2019 11:42:05 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id w190sm30527003pfb.101.2019.04.30.11.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:42:04 -0700 (PDT)
Subject: Re: io_uring: submission error handling
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
 <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
 <8ce7be42-4183-b441-9a26-6b3441ed5fef@kernel.dk>
 <4fe4bfb0-81a8-82da-66a2-ffe6fd972a7b@kernel.dk>
 <9a16ac43-da5c-613a-3581-9acc6ba4cff0@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc1f2755-2c79-f5de-4057-ff658f3919ca@kernel.dk>
Date:   Tue, 30 Apr 2019 12:42:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9a16ac43-da5c-613a-3581-9acc6ba4cff0@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/19 12:15 PM, Stefan Bühler wrote:
> Hi,
> 
> On 30.04.19 18:15, Jens Axboe wrote:
>> On 4/30/19 10:02 AM, Jens Axboe wrote:
>>> On 4/27/19 9:50 AM, Stefan Bühler wrote:
>>>> Hi,
>>>>
>>>> On 24.04.19 00:07, Jens Axboe wrote:
>>>>> On 4/23/19 2:31 PM, Jens Axboe wrote:
>>>>>>> 1. An error for a submission should be returned as completion for that
>>>>>>> submission.  Please don't break my main event loop with strange error
>>>>>>> codes just because a single operation is broken/not supported/...
>>>>>>
>>>>>> So that's the case I was referring to above. We can just make that change,
>>>>>> there's absolutely no reason to have errors passed back through a different
>>>>>> channel.
>>>>>
>>>>> Thinking about this a bit more, and I think the current approach is the
>>>>> best one. The issue is that only submission side events tied to an sqe
>>>>> can return an cqe, the rest have to be returned through the system call
>>>>> value. So I think it's cleaner to keep it as-is, honestly.
>>>>
>>>> Not sure we're talking about the same.
>>>>
>>>> I'm talking about the errors returned by io_submit_sqe: io_submit_sqes
>>>> (called by the SQ thread) calls io_cqring_add_event if there was an
>>>> error, but io_ring_submit (called by io_uring_enter) doesn't: instead,
>>>> if there were successfully submitted entries before, it will just return
>>>> those (and "undo" the current SQE), otherwise it will return the error,
>>>> which will then be returned by io_uring_enter.
>>>>
>>>> But if I get an error from io_uring_enter I have no idea whether it was
>>>> some generic error (say EINVAL for broken flags or EBADF for a
>>>> non-io-uring filedescriptor) or an error related to a single submission.
>>>>
>>>> I think io_ring_submit should call io_cqring_add_event on errors too
>>>> (like io_submit_sqes), and not stop handling submissions (and never
>>>> return an error).
>>>>
>>>> Maybe io_cqring_add_event could then even be moved to io_submit_sqe and
>>>> just return whether the job is already done or not (io_submit_sqes
>>>> returns the new "inflight" jobs, and io_ring_submit the total number of
>>>> submitted jobs).
>>>
>>> I think we are talking about the same thing, actually. See below patch.
>>> This changes it so that any error that occurs on behalf of a specific
>>> sqe WILL trigger a completion event, instead of returning it through
>>> io_uring_enter(). io_uring_enter() can still return -ERROR for errors
>>> that aren't specific to an sqe.
>>>
>>> I think this is what you had in mind?
>>>
>>> Totally untested, will do so now.
>>
>> Seems to work for me, just needed to adjust the -EAGAIN test case in
>> liburing.
>>
>> I forgot to mention, but this will still stall the submission sequence.
>> Before, if you wanted to queue 8 sqes and we had an error on the 5th, we'd
>> return ret == 4 and the application would have to look at the sqring to
>> figure out what is wrong with the head entry. Now we'd return 5, and
>> have a cqe posted for the 5th entry that had an error. The app can then
>> decide if it needs to do anything about this. If it doesn't, it just
>> needs to call io_uring_enter() again to submit the remaining 3 entries.
>>
>> I do like this change. Any error on an sqe will result in a cqe being
>> posted, instead of having the submission be slightly different and have
>> the cqe be dependent on where the error occurred.
> 
> I think you forgot to attach the patch - I can't find it :)

Oops, here it is...

> Without seeing the patch I'd like to point out the stalling is buggy
> right now: if you stall you must not wait for an event (unless you
> decrease min_complete by the number of events you didn't submit,
> min(...) is wrong), as the event that possibly might wake up the loop
> might not have been submitted in the first place.
> 
> The patch I was working on locally didn't stall so it also indirectly
> fixed that bug; the challenge with stalling will be how to detect it:
> "submitted < to_submit" does not indicate a stall if we accept that
> applications are allowed to pass "to_submit" values larger than what is
> actually in the queue.
> 
> While I agree that for special applications stalling on errors might be
> an interesting feature, for more "general purpose" libraries stalling is
> probably not useful (also note that the SQ thread won't stall either).

I think we can get away with not stalling now, with the intent to add
the barrier type feature/flag for the queue. Might be safer to just
never wait if we do end up posting an event and quitting out earlier.

> Maybe other solutions can be found: e.g. mark submissions as depending
> on other submissions (including a barrier), and fail if the previous one
> fails.
> 
> One last thing about stalling: the ring documentation so far describes
> pending SQ elements as "owned by kernel"; allowing the application to
> update it afterwards might make the documentation more complex (I don't
> see a technical problem: without SQ thread the kernel never accesses the
> submission queue outside io_uring_enter; but the application mustn't
> modify SQ head).

If we post a cqe for it on error, then the event is consumed and gone.
A new entry would have to get added instead, which is different than
allowing the application to fiddle with the stalled one and resubmit
again from there.


commit fd25de20d38dd07e2ce7108986f1fd08f9bf03d4
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Apr 30 10:16:07 2019 -0600

    io_uring: have submission side sqe errors post a cqe
    
    Currently we only post a cqe if we get an error OUTSIDE of submission.
    For submission, we return the error directly through io_uring_enter().
    This is a bit awkward for applications, and it makes more sense to
    always post a cqe with an error, if the error happens on behalf of an
    sqe.
    
    This changes submission behavior a bit. io_uring_enter() returns -ERROR
    for an error, and > 0 for number of sqes submitted. Before this change,
    if you wanted to submit 8 entries and had an error on the 5th entry,
    io_uring_enter() would return 4 (for number of entries successfully
    submitted) and rewind the sqring. The application would then have to
    peek at the sqring and figure out what was wrong with the head sqe, and
    then skip it itself. With this change, we'll return 5 since we did
    consume 5 sqes, and the last sqe (with the error) will result in a cqe
    being posted with the error.
    
    This makes the logic easier to handle in the application, and it cleans
    up the submission part.
    
    Suggested-by: Stefan Bühler <source@stbuehler.de>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 77b247b5d10b..376ae44f0748 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1801,14 +1801,6 @@ static void io_commit_sqring(struct io_ring_ctx *ctx)
 	}
 }
 
-/*
- * Undo last io_get_sqring()
- */
-static void io_drop_sqring(struct io_ring_ctx *ctx)
-{
-	ctx->cached_sq_head--;
-}
-
 /*
  * Fetch an sqe, if one is available. Note that s->sqe will point to memory
  * that is mapped by userspace. This means that care needs to be taken to
@@ -2018,7 +2010,7 @@ static int io_sq_thread(void *data)
 static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 {
 	struct io_submit_state state, *statep = NULL;
-	int i, ret = 0, submit = 0;
+	int i, submit = 0;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, to_submit);
@@ -2027,6 +2019,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 
 	for (i = 0; i < to_submit; i++) {
 		struct sqe_submit s;
+		int ret;
 
 		if (!io_get_sqring(ctx, &s))
 			break;
@@ -2034,21 +2027,20 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		s.has_user = true;
 		s.needs_lock = false;
 		s.needs_fixed_file = false;
+		submit++;
 
 		ret = io_submit_sqe(ctx, &s, statep);
 		if (ret) {
-			io_drop_sqring(ctx);
+			io_cqring_add_event(ctx, s.sqe->user_data, ret, 0);
 			break;
 		}
-
-		submit++;
 	}
 	io_commit_sqring(ctx);
 
 	if (statep)
 		io_submit_state_end(statep);
 
-	return submit ? submit : ret;
+	return submit;
 }
 
 static unsigned io_cqring_events(struct io_cq_ring *ring)
@@ -2779,9 +2771,6 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
 		mutex_lock(&ctx->uring_lock);
 		submitted = io_ring_submit(ctx, to_submit);
 		mutex_unlock(&ctx->uring_lock);
-
-		if (submitted < 0)
-			goto out_ctx;
 	}
 	if (flags & IORING_ENTER_GETEVENTS) {
 		unsigned nr_events = 0;

-- 
Jens Axboe

