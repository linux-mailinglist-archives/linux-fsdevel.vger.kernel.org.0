Return-Path: <linux-fsdevel+bounces-43075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DC3A4DA8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEE77A28D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67175200116;
	Tue,  4 Mar 2025 10:29:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6412A1FFC72
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084194; cv=none; b=MMhBM93ianvaeFU5A9au9BXaxi8zri7Ezd5aEKQD4u95Z2NQF/TEv7ACXjKfWUC9jnGJhPF0GyRSOymiPWTMfUNWphUIjN50QGu6BG0Uqid+wy4QuQhLGOCuZdaDwM3V0IEQ69WQUrXVathbrkZZV6NqWAl6c2fOBbh2zDnCqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084194; c=relaxed/simple;
	bh=6M9vMD3m8RcahDfKt4U9A6z7ib3A7FvvznwiPTpZVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRHUX7+oJSonw7riEapB8P3+AirUzBEpMm532lw7mG6lYzmR8ovSoIJLIrCeYawf4429mhUhuP8VqGhgXb1oSC60mwNaXb22NKC90G7iUXfY7DMZ4+h5uMBQLH/WRGN6axlYvRzBq+ALjcqNdFKYHNDYeOhA2/fin17GtTXfQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.155])
	by sina.com (10.185.250.24) with ESMTP
	id 67C6D618000021E6; Tue, 4 Mar 2025 18:29:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 55183410748496
X-SMAIL-UIID: C4D1D13C98534C22922D15BBC552A9A8-20250304-182946-1
From: Hillf Danton <hdanton@sina.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Tue,  4 Mar 2025 18:29:33 +0800
Message-ID: <20250304102934.2999-1-hdanton@sina.com>
In-Reply-To: <0d17fc70-01a8-43b4-aec6-5cede5c8f7ba@amd.com>
References: <20250102140715.GA7091@redhat.com> <e813814e-7094-4673-bc69-731af065a0eb@amd.com> <20250224142329.GA19016@redhat.com> <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt> <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 4 Mar 2025 11:05:57 +0530 K Prateek Nayak <kprateek.nayak@amd.com>
>On 3/4/2025 10:36 AM, Hillf Danton wrote:
>> On Mon, 3 Mar 2025 15:16:34 +0530 "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
>>> On 2/28/2025 10:03 PM, Oleg Nesterov wrote:
>>>> And... I know, I know you already hate me ;)
>>>>
>>>
>>> Not at all :)
>>>
>>>> but if you have time, could you check if this patch (with or without the
>>>> previous debugging patch) makes any difference? Just to be sure.
>>>>
>>>
>>> Sure, I will give this a try.
>>>
>>> But in the meanwhile me and Prateek tried some of the experiments in the weekend.
>>> We were able to reproduce this issue on a third generation EPYC system as well as
>>> on an Intel Emerald Rapids (2 X INTEL(R) XEON(R) PLATINUM 8592+).
>>>
>>> We tried heavy hammered tracing approach over the weekend on top of your debug patch.
>>> I have attached the debug patch below. With tracing we found the following case for
>>> pipe_writable():
>>>
>>>     hackbench-118768  [206] .....  1029.550601: pipe_write: 000000005eea28ff: 0: 37 38 16: 1
>>>
>>> Here,
>>>
>>> head = 37
>>> tail = 38
>>> max_usage = 16
>>> pipe_full() returns 1.
>>>
>>> Between reading of head and later the tail, the tail seems to have moved ahead of the
>>> head leading to wraparound. Applying the following changes I have not yet run into a
>>> hang on the original machine where I first saw it:
>>>
>>> diff --git a/fs/pipe.c b/fs/pipe.c
>>> index ce1af7592780..a1931c817822 100644
>>> --- a/fs/pipe.c
>>> +++ b/fs/pipe.c
>>> @@ -417,9 +417,19 @@ static inline int is_packetized(struct file *file)
>>>    /* Done while waiting without holding the pipe lock - thus the READ_ONCE() */
>>>    static inline bool pipe_writable(const struct pipe_inode_info *pipe)
>>>    {
>>> -	unsigned int head = READ_ONCE(pipe->head);
>>> -	unsigned int tail = READ_ONCE(pipe->tail);
>>>    	unsigned int max_usage = READ_ONCE(pipe->max_usage);
>>> +	unsigned int head, tail;
>>> +
>>> +	tail = READ_ONCE(pipe->tail);
>>> +	/*
>>> +	 * Since the unsigned arithmetic in this lockless preemptible context
>>> +	 * relies on the fact that the tail can never be ahead of head, read
>>> +	 * the head after the tail to ensure we've not missed any updates to
>>> +	 * the head. Reordering the reads can cause wraparounds and give the
>>> +	 * illusion that the pipe is full.
>>> +	 */
>>> +	smp_rmb();
>>> +	head = READ_ONCE(pipe->head);
>>>    
>>>    	return !pipe_full(head, tail, max_usage) ||
>>>    		!READ_ONCE(pipe->readers);
>>> ---
>>>
>>> smp_rmb() on x86 is a nop and even without the barrier we were not able to
>>> reproduce the hang even after 10000 iterations.
>>>
>> My $.02 that changes the wait condition.
>> Not sure it makes sense for you.
>> 
>> --- x/fs/pipe.c
>> +++ y/fs/pipe.c
>> @@ -430,7 +430,7 @@ pipe_write(struct kiocb *iocb, struct io
>>   {
>>   	struct file *filp = iocb->ki_filp;
>>   	struct pipe_inode_info *pipe = filp->private_data;
>> -	unsigned int head;
>> +	unsigned int head, tail;
>>   	ssize_t ret = 0;
>>   	size_t total_len = iov_iter_count(from);
>>   	ssize_t chars;
>> @@ -573,11 +573,13 @@ pipe_write(struct kiocb *iocb, struct io
>>   		 * after waiting we need to re-check whether the pipe
>>   		 * become empty while we dropped the lock.
>>   		 */
>> +		tail = pipe->tail;
>>   		mutex_unlock(&pipe->mutex);
>>   		if (was_empty)
>>   			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
>>   		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>> -		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
>> +		wait_event_interruptible_exclusive(pipe->wr_wait,
>> +				!READ_ONCE(pipe->readers) || tail != READ_ONCE(pipe->tail));
>
>That could work too for the case highlighted but in case the head too
>has moved by the time the writer wakes up, it'll lead to an extra
>wakeup.
>
Note wakeup can occur even if pipe is full, and more important, taking
the pipe lock after wakeup is the price paid for curing the hang in
question.

		 * So we still need to wake up any pending writers in the
		 * _very_ unlikely case that the pipe was full, but we got
		 * no data.
		 */

>Linus' diff seems cleaner and seems to cover all racy scenarios.
>
>>   		mutex_lock(&pipe->mutex);
>>   		was_empty = pipe_empty(pipe->head, pipe->tail);
>>   		wake_next_writer = true;
>> --
>
>-- 
>Thanks and Regards,
>Prateek

