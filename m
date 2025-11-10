Return-Path: <linux-fsdevel+bounces-67752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08729C497D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D95AF4EDA2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BF62FB988;
	Mon, 10 Nov 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="oUY0OT+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3YbsuUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B25F50F;
	Mon, 10 Nov 2025 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812552; cv=none; b=nF/NTgMJ8EBS0Urk3NXkAdBgjxdsYjDj1soHYjRtyczTRjP6u1CVU1/UOBy1ejrg/UxdCDo7hgudq7oJG4YgXRLe74cpdWb5yRae2NR19Rvw6m8zZxey6xEZJJJi7NGG5kExKDgES9C9LCP6hFMhc8tqYHIbRLxivCKmmQF8VHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812552; c=relaxed/simple;
	bh=jTi4LDGE7MRykeDEwyf3ZXVaTVJX6ZEnyBB5PfVi9/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrxKX99ilfiCOEXRpLFx1WtgAlY4+Lfs45ZzYfwXDLAysjNND6dpr+w2PeJC8EgJvLqaJrcJTo8fQH/novgg+bL1rfkv9QbFeOKVEoOHzbqyQ6X9zOIerpzk9k8RJN9R8ouGW/bk73JwuIQdMBJpUWvDbJGAnNnAXT6cHT/ocGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=oUY0OT+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3YbsuUW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F783EC0F97;
	Mon, 10 Nov 2025 17:09:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 17:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762812548;
	 x=1762898948; bh=VI7ijp6IJ9cElrucx5mus7kh4GWzi/YHisw1nnNzMGw=; b=
	oUY0OT+Lf7oGYkIfC+bt6R8hyHgtQ+vTgq3KTAJqNFK+CkXB+bQ5ylQmyaPwybgz
	MaVVklls62OnhM/qIA7PvEhrbD7m0rMCGZUCgyOtaKrObAVDO++W/ooa6EHPSolW
	qgZeB2FyNWxO+MN4qD2jEv4Va9RzqnScIs8UstD5upOTMn4mVtiAl1elRFSAgG68
	P9jd9ATnEqTKJ6grLt6Sh5yw5VvXfa6KqaaS2G+/OL9SIMW7xTwsaBpLJjSQNFtV
	/ga+kqJJNQmcTgKgAblod1TtfoEl1qsrkfbZ/vZYpJAmFufpKLGrP5JvRn6tt6wZ
	lfEekv1/gUR9NVimpnouzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762812548; x=
	1762898948; bh=VI7ijp6IJ9cElrucx5mus7kh4GWzi/YHisw1nnNzMGw=; b=q
	3YbsuUW2ftc+r3ndvN1pU49jcvG4PPceWFkSD3yX61nAcg7qAS3eyjwpJes8mMfl
	CEv1FQNuwd75vDgWzhEtsAiAqMK2/iCX/fJz6LVjMVXa0+bu29gnxdczJK9fsVXi
	mkgLaG145rTaAd1PX3WPli/Dp8ulfrmDh5RqjnYGslfNc9wDQXFtmtvJm5+8ev5/
	5dEyoswEnDaXsAvQ09Pj3j4y9podrnqhvhxziD4iAsKMwcvXeEbdLpqcMGBNYGtc
	wbpKNXgU0wIyW4Q84HEUwx/DOChrQygST7Ey1wIY0yrRf3/giH7+KEOXONMiV0Gg
	yQOSLk3HWbGEQqUBADM0Q==
X-ME-Sender: <xms:g2ISabyD_5Xyopy-BxYPN1uyBlqZieQdghHllMbtKuPUCr3TeePUrg>
    <xme:g2ISaUDO600WPJbWGrtbZfvyuJHkQ45HQv-bweGKSxC6hgATNNbFW4piq-mtqt69j
    OxRqUvSIIm-1U7SZBP3KOD_h6V_B3H6LUMtVXY5SsUPaeglvHKe>
X-ME-Received: <xmr:g2ISaRdw5Dp4CX3xEjveqT2bxVCVQjwt59027_08jSb9q7tvEjgKpl6-NcLE-HcujGFeIMKdDVx0DmczI-aYZMiXP92U2pSHHsfylirlYfoVXS_hrOqD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprg
    druggvvhdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:g2ISaWnaNKVNqAHE28Q-9b2YgnEqq-O4Plw0RfjoI7hDlS1BpphKXg>
    <xmx:g2ISaQFZVTlwkTRtuKyVjetUT11x3Rlp1qqbEVL3UDQaILtfXkFVVw>
    <xmx:g2ISaW6nfe2NCelRI7f6hVArkWa_DkOecYJOnYFkbePqGA-UIs2Gjg>
    <xmx:g2ISaQmMBE-FmPBiKcqwEgYdcSUG3b2rsiuflK_xZmEIKbpiNoxxPw>
    <xmx:hGISabVx779IBxFlAELwm-2NoMKVi80Uw2CvEUheUKR4RO1WabV6ldd1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 17:09:06 -0500 (EST)
Message-ID: <9544f973-8ffd-43f9-b943-f7398b40f952@bsbernd.com>
Date: Mon, 10 Nov 2025 23:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
 <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>
 <20251108000254.GK196391@frogsfrogsfrogs>
 <20251110175615.GY196362@frogsfrogsfrogs>
 <9736bed0-3221-4e47-aed4-b46150b253a8@bsbernd.com>
 <20251110185429.GZ196362@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251110185429.GZ196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/25 19:54, Darrick J. Wong wrote:
> On Mon, Nov 10, 2025 at 07:22:57PM +0100, Bernd Schubert wrote:
>>
>>
>> On 11/10/25 18:56, Darrick J. Wong wrote:
>>> On Fri, Nov 07, 2025 at 04:02:54PM -0800, Darrick J. Wong wrote:
>>>> On Fri, Nov 07, 2025 at 11:03:24PM +0100, Bernd Schubert wrote:
>>>>>
>>>>>
>>>>> On 11/7/25 05:26, Darrick J. Wong wrote:
>>>>>> [I read this email backwards, like I do]
>>>>>>
>>>>>> On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
>>>>>>> On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
>>>>>>>>
>>>>>>>> <snipping here because this thread has gotten very long>
>>>>>>>>
>>>>>>>>>>>> +       while (wait_event_timeout(fc->blocked_waitq,
>>>>>>>>>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
>>>>>>>>>>>> +                       HZ) == 0) {
>>>>>>>>>>>> +               /* empty */
>>>>>>>>>>>> +       }
>>>>>>>>>>>
>>>>>>>>>>> I'm wondering if it's necessary to wait here for all the pending
>>>>>>>>>>> requests to complete or abort?
>>>>>>>>>>
>>>>>>>>>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
>>>>>>>>>> be.  If someone kills a program with a large number of open unlinked
>>>>>>>>>> files and immediately calls umount(), then the fuse client could be in
>>>>>>>>>> the process of sending FUSE_RELEASE requests to the server.
>>>>>>>>>>
>>>>>>>>>> [background info, feel free to speedread this paragraph]
>>>>>>>>>> For a non-fuseblk server, unmount aborts all pending requests and
>>>>>>>>>> disconnects the fuse device.  This means that the fuse server won't see
>>>>>>>>>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
>>>>>>>>>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
>>>>>>>>>> with a lot of .fuseXXXXX files that nobody cleans up.
>>>>>>>>>>
>>>>>>>>>> If you make ->destroy release all the remaining open files, now you run
>>>>>>>>>> into a second problem, which is that if there are a lot of open unlinked
>>>>>>>>>> files, freeing the inodes can collectively take enough time that the
>>>>>>>>>> FUSE_DESTROY request times out.
>>>>>>>>>>
>>>>>>>>>> On a fuseblk server with libfuse running in multithreaded mode, there
>>>>>>>>>> can be several threads reading fuse requests from the fusedev.  The
>>>>>>>>>> kernel actually sends its own FUSE_DESTROY request, but there's no
>>>>>>>>>> coordination between the fuse workers, which means that the fuse server
>>>>>>>>>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
>>>>>>>>>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
>>>>>>>>>> processed, you end up with the same .fuseXXXXX file cleanup problem.
>>>>>>>>>
>>>>>>>>> imo it is the responsibility of the server to coordinate this and make
>>>>>>>>> sure it has handled all the requests it has received before it starts
>>>>>>>>> executing the destruction logic.
>>>>>>>>
>>>>>>>> I think we're all saying that some sort of fuse request reordering
>>>>>>>> barrier is needed here, but there's at least three opinions about where
>>>>>>>> that barrier should be implemented.  Clearly I think the barrier should
>>>>>>>> be in the kernel, but let me think more about where it could go if it
>>>>>>>> were somewhere else.
>>>>>>>>
>>>>>>>> First, Joanne's suggestion for putting it in the fuse server itself:
>>>>>>>>
>>>>>>>> I don't see how it's generally possible for the fuse server to know that
>>>>>>>> it's processed all the requests that the kernel might have sent it.
>>>>>>>> AFAICT each libfuse thread does roughly this:
>>>>>>>>
>>>>>>>> 1. read() a request from the fusedev fd
>>>>>>>> 2. decode the request data and maybe do some allocations or transform it
>>>>>>>> 3. call fuse server with request
>>>>>>>> 4. fuse server does ... something with the request
>>>>>>>> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
>>>>>>>>
>>>>>>>> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
>>>>>>>> out if there are other fuse worker threads that are somewhere in steps
>>>>>>>> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
>>>>>>>> that are waiting in fuse_session_receive_buf_internal, so fuse servers
>>>>>>>> can't ask the library about that either.
>>>>>>>>
>>>>>>>> Taking a narrower view, it might be possible for the fuse server to
>>>>>>>> figure this out by maintaining an open resource count.  It would
>>>>>>>> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
>>>>>>>> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
>>>>>>>> the only kind of request that can be pending when a FUSE_DESTROY comes
>>>>>>>> in, then destroy just has to wait for the counter to hit zero.
>>>>>>>
>>>>>>> I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
>>>>>>> if there are X worker threads that are all running fuse_do_work( )
>>>>>>> then if you get a FUSE_DESTROY on one of those threads that thread can
>>>>>>> set some se->destroyed field. At this point the other threads will
>>>>>>> have already called fuse_session_receive_buf_internal() on all the
>>>>>>> flushed background requests, so after they process it and return from
>>>>>>> fuse_session_process_buf_internal(), then they check if se->destroyed
>>>>>>> was set, and if it is they exit the thread, while in the thread that
>>>>>>> got the FUSE_DESTROY it sleeps until all the threads have completed
>>>>>>> and then it executes the destroy logic.That to me seems like the
>>>>>>> cleanest approach.
>>>>>>
>>>>>> Hrm.  Well now (scrolling to the bottom and back) that I know that the
>>>>>> FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
>>>>>> think that /could/ work.
>>>>>>
>>>>>> One tricky thing with having worker threads check a flag and exit is
>>>>>> that they can be sleeping in the kernel (from _fuse_session_receive_buf)
>>>>>> when the "just go away" flag gets set.  If the thread never wakes up,
>>>>>> then it'll never exit.  In theory you could have the FUSE_DESTROY thread
>>>>>> call pthread_cancel on all the other worker threads to eliminate them
>>>>>> once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
>>>>>> nightmares from adventures in pthread_cancel at Sun in 2002. :P
>>>>>>
>>>>>> Maybe an easier approach would be to have fuse_do_work increment a
>>>>>> counter when it receives a buffer and decrement it when it finishes with
>>>>>> that buffer.  The FUSE_DESTROY thread merely has to wait for that
>>>>>> counter to reach 1, at which point it's the only thread with a request
>>>>>> to process, so it can call do_destroy.  That at least would avoid adding
>>>>>> a new user of pthread_cancel() into the mt loop code.
>>>>>
>>>>> I will read through the rest (too tired right now) durig the weekend. 
>>>>> I was also thinking about counter. And let's please also do this right
>>>>> also handling io-uring. I.e. all CQEs needs to have been handled.
>>>>> Without io-uring it would be probably a counter in decreased in 
>>>>> fuse_free_req(), with io-uring it is a bit more complex.
>>>>
>>>> Oh right, the uring backend.
>>>>
>>>> Assuming that it's really true that the only requests pending during an
>>>> unmount are going to be FUSE_RELEASE (nobody's actually said that's
>>>> true) then it's *much* easier to count the number of open files in
>>>> fuse_session and make _do_destroy in the lowlevel library wait until the
>>>> open file count reaches zero.
>>>
>>> FWIW I tried this out over the weekend with the patch below and the
>>> wait_event() turned off in the kernel.  It seems to work (though I only
>>> tried it cursorily with iouring) so if the kernel fuse developers would
>>> rather not have a wait_event() in the unmount path then I suppose this
>>> is a way to move ahead with this topic.
>>>
>>> --D
>>>
>>> From: Darrick J. Wong <djwong@kernel.org>
>>> Subject: [PATCH] libfuse: wait in do_destroy until all open files are closed
>>>
>>> Joanne suggests that libfuse should defer a FUSE_DESTROY request until
>>> all FUSE_RELEASEs have completed.  Let's see if that works by tracking
>>> the count of open files.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  lib/fuse_i.h        |    4 ++++
>>>  lib/fuse_lowlevel.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++---
>>>  2 files changed, 55 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
>>> index 0ce2c0134ed879..dfe9d9f067498e 100644
>>> --- a/lib/fuse_i.h
>>> +++ b/lib/fuse_i.h
>>> @@ -117,6 +117,10 @@ struct fuse_session {
>>>  	 */
>>>  	uint32_t conn_want;
>>>  	uint64_t conn_want_ext;
>>> +
>>> +	/* destroy has to wait for all the open files to go away */
>>> +	pthread_cond_t zero_open_files;
>>> +	uint64_t open_files;
>>>  };
>>>  
>>>  struct fuse_chan {
>>> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
>>> index 12724ed66bdcc8..f12c6db0eb0e60 100644
>>> --- a/lib/fuse_lowlevel.c
>>> +++ b/lib/fuse_lowlevel.c
>>> @@ -52,6 +52,30 @@
>>>  #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
>>>  #define OFFSET_MAX 0x7fffffffffffffffLL
>>>  
>>> +static inline void inc_open_files(struct fuse_session *se)
>>> +{
>>> +	pthread_mutex_lock(&se->lock);
>>> +	se->open_files++;
>>> +	pthread_mutex_unlock(&se->lock);
>>> +}
>>> +
>>> +static inline void dec_open_files(struct fuse_session *se)
>>> +{
>>> +	pthread_mutex_lock(&se->lock);
>>> +	se->open_files--;
>>> +	if (!se->open_files)
>>> +		pthread_cond_broadcast(&se->zero_open_files);
>>> +	pthread_mutex_unlock(&se->lock);
>>> +}
>>
>> I think open files only decreases when destroy is received? Doesn't that
>> give us the chance to use an atomic (C11) and then to broadcast only
>> when FUSE_DESTROY is received? I.e. I would use an atomic for
>> 'open_files', set something like 'se->destroy_received' and then trigger
>> the broadcast only when that is set.
> 
> I'm sorry, but I'm not familiar enough with C11 atomics to know if that
> would work.  I suppose it /has/ been 3 years since the kernel went from
> C89 to C11 but some of us are still old dinosaurs who cut their teeth on
> C back when the paint was still fresh on C90. ;)

No worries, I'm personally catching up with C++ beyond C++98.

> 
> I think it would be ok to define open_files as _Atomic and then do
> something like:
> 
> 	if (atomic_fetch_sub(&se->open_files, -1) == 1)
> 		cnd_broadcast(&cse->zero_open_files);
> 
> without needing to take se->lock.  I'm not sure how you'd handle races
> between a thread setting destroy_received and dec_open_files testing
> the flag, though.  Maybe it'd be easier to bias open_files upward by one
> in the init method and downward by one in op_destroy so we'd never send
> the broadcast until unmount time?

I link that very much. Your patch didn't apply in fuse_reply_create,
because of your other changes, so I applied some parts manually.
I would like to test and merge this patch
as soon as possible, as we actually got an external ticket about it
around last week (tear down DLM issues) and generic/531 actually also
fails with passthrough_hp

generic/531       - output mismatch (see /home/fusetests/src/xfstests-dev/results//generic/531.out.bad)
    --- tests/generic/531.out   2023-02-02 15:37:23.979018084 +0100
    +++ /home/fusetests/src/xfstests-dev/results//generic/531.out.bad   2025-11-10 15:30:23.253431465 +0100
    @@ -1,2 +1,25 @@
     QA output created by 531
    +open?: Bad file descriptor
    +open?: Bad file descriptor
    +open?: Bad file descriptor
    +open?: Bad file descriptor
    +open?: Bad file descriptor
    +open?: Bad file descriptor
    ...
    (Run 'diff -u /home/fusetests/src/xfstests-dev/tests/generic/531.out /home/fusetests/src/xfstests-dev/res


My VM is currently busy with another patch set verification, I'm going
to try it after that.

Can I push the version below to libfuse for review/merge?

Subject: [PATCH] libfuse: wait in do_destroy until all open files are closed

From: Darrick J. Wong <djwong@kernel.org>

Joanne suggests that libfuse should defer a FUSE_DESTROY request until
all FUSE_RELEASEs have completed.  Let's see if that works by tracking
the count of open files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 lib/fuse_i.h        |    4 ++++
 lib/fuse_lowlevel.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index d35e1e51d823..b603e52b1b85 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -117,6 +117,10 @@ struct fuse_session {
 	 */
 	uint32_t conn_want;
 	uint64_t conn_want_ext;
+
+	/* destroy has to wait for all the open files to go away */
+	pthread_cond_t zero_open_files;
+	_Atomic uint64_t open_files;
 };
 
 struct fuse_chan {
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index d420b257b9dd..2e09027e6022 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -52,6 +52,30 @@
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
 
+static inline void inc_open_files(struct fuse_session *se)
+{
+	se->open_files++;
+}
+
+static inline void dec_open_files(struct fuse_session *se)
+{
+	int prev = atomic_fetch_sub(&se->open_files, 1);
+	if (unlikely(prev == 1)) {
+		pthread_mutex_lock(&se->lock);
+		pthread_cond_broadcast(&se->zero_open_files);
+		pthread_mutex_unlock(&se->lock);
+	}
+}
+
+static inline void wait_for_zero_open_files(struct fuse_session *se)
+{
+	pthread_mutex_lock(&se->lock);
+	while (se->open_files > 0) {
+		pthread_cond_wait(&se->zero_open_files, &se->lock);
+	}
+	pthread_mutex_unlock(&se->lock);
+}
+
 struct fuse_pollhandle {
 	uint64_t kh;
 	struct fuse_session *se;
@@ -522,17 +546,23 @@ int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 		      const struct fuse_file_info *f)
 {
+	struct fuse_session *se = req->se;
 	alignas(uint64_t) char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)];
 	size_t entrysize = req->se->conn.proto_minor < 9 ?
 		FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
 	struct fuse_entry_out *earg = (struct fuse_entry_out *) buf;
 	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
+	int error;
 
 	memset(buf, 0, sizeof(buf));
 	fill_entry(earg, e);
 	fill_open(oarg, f);
-	return send_reply_ok(req, buf,
+	error = send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
+	if (!error)
+		inc_open_files(se);
+
+	return error;
 }
 
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
@@ -583,10 +613,15 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
+	struct fuse_session *se = req->se;
+	int error;
 
 	memset(&arg, 0, sizeof(arg));
 	fill_open(&arg, f);
-	return send_reply_ok(req, &arg, sizeof(arg));
+	error = send_reply_ok(req, &arg, sizeof(arg));
+	if (!error)
+		inc_open_files(se);
+	return error;
 }
 
 static int do_fuse_reply_write(fuse_req_t req, size_t count)
@@ -1854,6 +1889,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	const struct fuse_release_in *arg = op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -1872,6 +1908,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.release(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_release(fuse_req_t req, const fuse_ino_t nodeid,
@@ -1976,6 +2013,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	struct fuse_release_in *arg = (struct fuse_release_in *)op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -1986,6 +2024,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.releasedir(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
@@ -2996,6 +3035,9 @@ static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
 	(void)op_in;
 	(void)in_payload;
 
+	se->open_files--;
+	wait_for_zero_open_files(se);
+
 	mountpoint = atomic_exchange(&se->mountpoint, NULL);
 	free(mountpoint);
 
@@ -3824,6 +3866,7 @@ void fuse_session_destroy(struct fuse_session *se)
 		fuse_ll_pipe_free(llp);
 	pthread_key_delete(se->pipe_key);
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 	free(se->cuse_data);
@@ -4202,6 +4245,9 @@ fuse_session_new_versioned(struct fuse_args *args,
 	sem_init(&se->mt_finish, 0, 0);
 	pthread_mutex_init(&se->mt_lock, NULL);
 
+	pthread_cond_init(&se->zero_open_files, NULL);
+	se->open_files = 1; /* decreased by FUSE_DESTROY */
+
 	err = pthread_key_create(&se->pipe_key, fuse_ll_pipe_destructor);
 	if (err) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to create thread specific key: %s\n",
@@ -4226,6 +4272,7 @@ fuse_session_new_versioned(struct fuse_args *args,
 
 out5:
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 out4:


Thanks,
Bernd

