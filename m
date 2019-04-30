Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9118DFF9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3SQF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:16:05 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:40334 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfD3SQF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:16:05 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id C81F7C02FB9;
        Tue, 30 Apr 2019 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556648162;
        bh=dNPRffawg0+ybO8pzwlTlOMbqgV+OFyJM3IZuJK5bQI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=4ZL+q/JroJlsCPDMpdWZXDuBSQMCeWE5Gqp5ujEhMNKzJqG7h7eJ/Iu0tJcQy/6Al
         fJQyYz4BIdxJsJlsATosaAVFCYG5sQS8ZrDLbPa4nPpGTLwTrcgzM3o4ti4PPr0yGB
         1qI7fA34mNkWl+n6r/CARgrysq5qW6OK8UvGuYO0=
Subject: Re: io_uring: submission error handling
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
 <66fb4ed7-a267-1b0b-d609-af34d9e1aa54@stbuehler.de>
 <8ce7be42-4183-b441-9a26-6b3441ed5fef@kernel.dk>
 <4fe4bfb0-81a8-82da-66a2-ffe6fd972a7b@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <9a16ac43-da5c-613a-3581-9acc6ba4cff0@stbuehler.de>
Date:   Tue, 30 Apr 2019 20:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4fe4bfb0-81a8-82da-66a2-ffe6fd972a7b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 30.04.19 18:15, Jens Axboe wrote:
> On 4/30/19 10:02 AM, Jens Axboe wrote:
>> On 4/27/19 9:50 AM, Stefan Bühler wrote:
>>> Hi,
>>>
>>> On 24.04.19 00:07, Jens Axboe wrote:
>>>> On 4/23/19 2:31 PM, Jens Axboe wrote:
>>>>>> 1. An error for a submission should be returned as completion for that
>>>>>> submission.  Please don't break my main event loop with strange error
>>>>>> codes just because a single operation is broken/not supported/...
>>>>>
>>>>> So that's the case I was referring to above. We can just make that change,
>>>>> there's absolutely no reason to have errors passed back through a different
>>>>> channel.
>>>>
>>>> Thinking about this a bit more, and I think the current approach is the
>>>> best one. The issue is that only submission side events tied to an sqe
>>>> can return an cqe, the rest have to be returned through the system call
>>>> value. So I think it's cleaner to keep it as-is, honestly.
>>>
>>> Not sure we're talking about the same.
>>>
>>> I'm talking about the errors returned by io_submit_sqe: io_submit_sqes
>>> (called by the SQ thread) calls io_cqring_add_event if there was an
>>> error, but io_ring_submit (called by io_uring_enter) doesn't: instead,
>>> if there were successfully submitted entries before, it will just return
>>> those (and "undo" the current SQE), otherwise it will return the error,
>>> which will then be returned by io_uring_enter.
>>>
>>> But if I get an error from io_uring_enter I have no idea whether it was
>>> some generic error (say EINVAL for broken flags or EBADF for a
>>> non-io-uring filedescriptor) or an error related to a single submission.
>>>
>>> I think io_ring_submit should call io_cqring_add_event on errors too
>>> (like io_submit_sqes), and not stop handling submissions (and never
>>> return an error).
>>>
>>> Maybe io_cqring_add_event could then even be moved to io_submit_sqe and
>>> just return whether the job is already done or not (io_submit_sqes
>>> returns the new "inflight" jobs, and io_ring_submit the total number of
>>> submitted jobs).
>>
>> I think we are talking about the same thing, actually. See below patch.
>> This changes it so that any error that occurs on behalf of a specific
>> sqe WILL trigger a completion event, instead of returning it through
>> io_uring_enter(). io_uring_enter() can still return -ERROR for errors
>> that aren't specific to an sqe.
>>
>> I think this is what you had in mind?
>>
>> Totally untested, will do so now.
> 
> Seems to work for me, just needed to adjust the -EAGAIN test case in
> liburing.
> 
> I forgot to mention, but this will still stall the submission sequence.
> Before, if you wanted to queue 8 sqes and we had an error on the 5th, we'd
> return ret == 4 and the application would have to look at the sqring to
> figure out what is wrong with the head entry. Now we'd return 5, and
> have a cqe posted for the 5th entry that had an error. The app can then
> decide if it needs to do anything about this. If it doesn't, it just
> needs to call io_uring_enter() again to submit the remaining 3 entries.
> 
> I do like this change. Any error on an sqe will result in a cqe being
> posted, instead of having the submission be slightly different and have
> the cqe be dependent on where the error occurred.

I think you forgot to attach the patch - I can't find it :)

Without seeing the patch I'd like to point out the stalling is buggy
right now: if you stall you must not wait for an event (unless you
decrease min_complete by the number of events you didn't submit,
min(...) is wrong), as the event that possibly might wake up the loop
might not have been submitted in the first place.

The patch I was working on locally didn't stall so it also indirectly
fixed that bug; the challenge with stalling will be how to detect it:
"submitted < to_submit" does not indicate a stall if we accept that
applications are allowed to pass "to_submit" values larger than what is
actually in the queue.

While I agree that for special applications stalling on errors might be
an interesting feature, for more "general purpose" libraries stalling is
probably not useful (also note that the SQ thread won't stall either).

Maybe other solutions can be found: e.g. mark submissions as depending
on other submissions (including a barrier), and fail if the previous one
fails.

One last thing about stalling: the ring documentation so far describes
pending SQ elements as "owned by kernel"; allowing the application to
update it afterwards might make the documentation more complex (I don't
see a technical problem: without SQ thread the kernel never accesses the
submission queue outside io_uring_enter; but the application mustn't
modify SQ head).

cheers,
Stefan
