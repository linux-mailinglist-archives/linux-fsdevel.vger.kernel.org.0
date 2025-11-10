Return-Path: <linux-fsdevel+bounces-67740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5FC48856
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421783B06FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02CD32A3FD;
	Mon, 10 Nov 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="F8V9Isaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAXkMgJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392332863B;
	Mon, 10 Nov 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798984; cv=none; b=gWb8zdEy7pMrp/qcPJCMuoW5jE21J2slvIro60QW92ZvuMMX/vmJ8SuJwrJ84H+BF4b3bg8GUxz7VddLkweMWJNBeNqNb+VUTI+gEM8+sNOkT+W/KBn+D+QrNw/qHnb6J4Hk1UNzeBa3q0Fi281vzXbQ8v/ZFkK9aDzo0r6g0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798984; c=relaxed/simple;
	bh=qAHmkZgLqIyZ+z+pknjZolG+9V0ubQWufNnfw8Xea0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyQTGYpp6kWYe/yG5NwKzgjpVqDkb+R0AnZetDraMS7RoF8nXPBpYq+XGEHrEmvwnRTxu+QTx9h8eBq12i1g2KfO9z27E0mZAeRWekkimRcrJYESv4hCOG8XuU2XsbfZT5cJKLQ+ZtiPyJXE6YBGHhCFb7PM64hpfeEMcBSDqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=F8V9Isaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAXkMgJz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6246A14001FC;
	Mon, 10 Nov 2025 13:23:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 13:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762798980;
	 x=1762885380; bh=L7abSfm1+gi8E+m+duIplBkmlmo9pXY2L3ABIR6yhZQ=; b=
	F8V9Isajkmc6lAKerR3GXsLuEyApHN3lKDgO/kMjBKYfHVU3XqVrXxloEkCVzKLr
	5DCUBBIcpFDkg/g8GXDnAxksqimINixO3vs2wdEY3/RR04uM6ee4XzEss1Xk3pq8
	ys/2J1Q/Oh6g744AKUmUWsyBwe+cs76GwY2d9FVbyU2lonQ9+pID04/y3I9+HsF3
	amzawPaEtG9j88Xf6bOaqHtTAoqcu9GTxJvR5QvtB292aQBbHLSa/ewdav3Afbdp
	IN6WrDOWI+Eux0HIbdv/HVxYHQ+btGC7yXjv+0279dsC3nBlCCuxjBNqJjlhpCGN
	uW8AHuApZqvji65PpeuKYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762798980; x=
	1762885380; bh=L7abSfm1+gi8E+m+duIplBkmlmo9pXY2L3ABIR6yhZQ=; b=h
	AXkMgJz9S3tjCg8pvhO//ovoofTaYieFdHMydGp4mN6Rug0mWJGh4IanwVr23sgf
	mu7evbWznVCYKILGHqxKQsUZF8aQUAmrEBUeRWWubVSwOu8SVWZgw4S93NPDNYKM
	2pQwACGptNHiZlyWIQr2yn1xsbweI4M/S6LkIyoPgVQqBZBXWTe105J5tt2rEbnL
	RlRxMQXBpWiwKm705C8ibatqv6eO5dl+QT/fwPEgUZ3zCiUXuJ7SX4AjkT+gDh8r
	Ms2TvsrsukoI1h3F3/4DMmFxhm0Sd7Hm0tTecxRcoftjdgZFvU5F/dH5E+4AK4NL
	WSa4r5gnZgy7EB83on4lw==
X-ME-Sender: <xms:gy0Saf8jlsyCfaf6iD47MqKFf2ubiz4EYUUGZ-oTh4QGL5TBi0VOhA>
    <xme:gy0SaVDdRTU1WKF3HqsOhuevKvqpeEFcQPjJbfNh_29ww9PAFyH2c1QL6SgZ-4JMz
    22E2gR-XTyLX0AQTIFOpM9khTEAzhzF78G27F6fF4KcCqtZc_Y>
X-ME-Received: <xmr:gy0SaUTqyj_VmmZ-4IDDJESCxPnvBr9MyBPjUiBZNmYGTugQjg3MmkmVSM4bTKq4mZxpGbUi9-HbypqyPJUXut3fbojv3sbRpAcK0YK9EaC0CAzs-Ud6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeltddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:gy0Sacv1vvVXdSm2WM0ZooyCp32eautwGQV6cpDW5mor-H0xeyeRMw>
    <xmx:gy0SaQ2AT-IohjbNpl6TVJOG5I7Qilfk9UBc7xtJ4OXKUTUagvfYaw>
    <xmx:gy0SadU3rxlxFHblHnKFFu0G_ksazYPF11r5R97ewgOWEKS9ZYdcMQ>
    <xmx:gy0SabL_Y3Uo95ghLBWVV6xMOJWGHijXM4ela7g4fageySQ_uSpfLg>
    <xmx:hC0SaQn55tG7tzmmu7uxXCchroB_QNgGN-gWKARtrjqiQWybk976k6if>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 13:22:58 -0500 (EST)
Message-ID: <9736bed0-3221-4e47-aed4-b46150b253a8@bsbernd.com>
Date: Mon, 10 Nov 2025 19:22:57 +0100
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
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
 <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>
 <20251108000254.GK196391@frogsfrogsfrogs>
 <20251110175615.GY196362@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251110175615.GY196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/25 18:56, Darrick J. Wong wrote:
> On Fri, Nov 07, 2025 at 04:02:54PM -0800, Darrick J. Wong wrote:
>> On Fri, Nov 07, 2025 at 11:03:24PM +0100, Bernd Schubert wrote:
>>>
>>>
>>> On 11/7/25 05:26, Darrick J. Wong wrote:
>>>> [I read this email backwards, like I do]
>>>>
>>>> On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
>>>>> On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
>>>>>>
>>>>>> <snipping here because this thread has gotten very long>
>>>>>>
>>>>>>>>>> +       while (wait_event_timeout(fc->blocked_waitq,
>>>>>>>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
>>>>>>>>>> +                       HZ) == 0) {
>>>>>>>>>> +               /* empty */
>>>>>>>>>> +       }
>>>>>>>>>
>>>>>>>>> I'm wondering if it's necessary to wait here for all the pending
>>>>>>>>> requests to complete or abort?
>>>>>>>>
>>>>>>>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
>>>>>>>> be.  If someone kills a program with a large number of open unlinked
>>>>>>>> files and immediately calls umount(), then the fuse client could be in
>>>>>>>> the process of sending FUSE_RELEASE requests to the server.
>>>>>>>>
>>>>>>>> [background info, feel free to speedread this paragraph]
>>>>>>>> For a non-fuseblk server, unmount aborts all pending requests and
>>>>>>>> disconnects the fuse device.  This means that the fuse server won't see
>>>>>>>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
>>>>>>>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
>>>>>>>> with a lot of .fuseXXXXX files that nobody cleans up.
>>>>>>>>
>>>>>>>> If you make ->destroy release all the remaining open files, now you run
>>>>>>>> into a second problem, which is that if there are a lot of open unlinked
>>>>>>>> files, freeing the inodes can collectively take enough time that the
>>>>>>>> FUSE_DESTROY request times out.
>>>>>>>>
>>>>>>>> On a fuseblk server with libfuse running in multithreaded mode, there
>>>>>>>> can be several threads reading fuse requests from the fusedev.  The
>>>>>>>> kernel actually sends its own FUSE_DESTROY request, but there's no
>>>>>>>> coordination between the fuse workers, which means that the fuse server
>>>>>>>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
>>>>>>>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
>>>>>>>> processed, you end up with the same .fuseXXXXX file cleanup problem.
>>>>>>>
>>>>>>> imo it is the responsibility of the server to coordinate this and make
>>>>>>> sure it has handled all the requests it has received before it starts
>>>>>>> executing the destruction logic.
>>>>>>
>>>>>> I think we're all saying that some sort of fuse request reordering
>>>>>> barrier is needed here, but there's at least three opinions about where
>>>>>> that barrier should be implemented.  Clearly I think the barrier should
>>>>>> be in the kernel, but let me think more about where it could go if it
>>>>>> were somewhere else.
>>>>>>
>>>>>> First, Joanne's suggestion for putting it in the fuse server itself:
>>>>>>
>>>>>> I don't see how it's generally possible for the fuse server to know that
>>>>>> it's processed all the requests that the kernel might have sent it.
>>>>>> AFAICT each libfuse thread does roughly this:
>>>>>>
>>>>>> 1. read() a request from the fusedev fd
>>>>>> 2. decode the request data and maybe do some allocations or transform it
>>>>>> 3. call fuse server with request
>>>>>> 4. fuse server does ... something with the request
>>>>>> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
>>>>>>
>>>>>> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
>>>>>> out if there are other fuse worker threads that are somewhere in steps
>>>>>> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
>>>>>> that are waiting in fuse_session_receive_buf_internal, so fuse servers
>>>>>> can't ask the library about that either.
>>>>>>
>>>>>> Taking a narrower view, it might be possible for the fuse server to
>>>>>> figure this out by maintaining an open resource count.  It would
>>>>>> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
>>>>>> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
>>>>>> the only kind of request that can be pending when a FUSE_DESTROY comes
>>>>>> in, then destroy just has to wait for the counter to hit zero.
>>>>>
>>>>> I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
>>>>> if there are X worker threads that are all running fuse_do_work( )
>>>>> then if you get a FUSE_DESTROY on one of those threads that thread can
>>>>> set some se->destroyed field. At this point the other threads will
>>>>> have already called fuse_session_receive_buf_internal() on all the
>>>>> flushed background requests, so after they process it and return from
>>>>> fuse_session_process_buf_internal(), then they check if se->destroyed
>>>>> was set, and if it is they exit the thread, while in the thread that
>>>>> got the FUSE_DESTROY it sleeps until all the threads have completed
>>>>> and then it executes the destroy logic.That to me seems like the
>>>>> cleanest approach.
>>>>
>>>> Hrm.  Well now (scrolling to the bottom and back) that I know that the
>>>> FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
>>>> think that /could/ work.
>>>>
>>>> One tricky thing with having worker threads check a flag and exit is
>>>> that they can be sleeping in the kernel (from _fuse_session_receive_buf)
>>>> when the "just go away" flag gets set.  If the thread never wakes up,
>>>> then it'll never exit.  In theory you could have the FUSE_DESTROY thread
>>>> call pthread_cancel on all the other worker threads to eliminate them
>>>> once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
>>>> nightmares from adventures in pthread_cancel at Sun in 2002. :P
>>>>
>>>> Maybe an easier approach would be to have fuse_do_work increment a
>>>> counter when it receives a buffer and decrement it when it finishes with
>>>> that buffer.  The FUSE_DESTROY thread merely has to wait for that
>>>> counter to reach 1, at which point it's the only thread with a request
>>>> to process, so it can call do_destroy.  That at least would avoid adding
>>>> a new user of pthread_cancel() into the mt loop code.
>>>
>>> I will read through the rest (too tired right now) durig the weekend. 
>>> I was also thinking about counter. And let's please also do this right
>>> also handling io-uring. I.e. all CQEs needs to have been handled.
>>> Without io-uring it would be probably a counter in decreased in 
>>> fuse_free_req(), with io-uring it is a bit more complex.
>>
>> Oh right, the uring backend.
>>
>> Assuming that it's really true that the only requests pending during an
>> unmount are going to be FUSE_RELEASE (nobody's actually said that's
>> true) then it's *much* easier to count the number of open files in
>> fuse_session and make _do_destroy in the lowlevel library wait until the
>> open file count reaches zero.
> 
> FWIW I tried this out over the weekend with the patch below and the
> wait_event() turned off in the kernel.  It seems to work (though I only
> tried it cursorily with iouring) so if the kernel fuse developers would
> rather not have a wait_event() in the unmount path then I suppose this
> is a way to move ahead with this topic.
> 
> --D
> 
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: [PATCH] libfuse: wait in do_destroy until all open files are closed
> 
> Joanne suggests that libfuse should defer a FUSE_DESTROY request until
> all FUSE_RELEASEs have completed.  Let's see if that works by tracking
> the count of open files.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/fuse_i.h        |    4 ++++
>  lib/fuse_lowlevel.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/fuse_i.h b/lib/fuse_i.h
> index 0ce2c0134ed879..dfe9d9f067498e 100644
> --- a/lib/fuse_i.h
> +++ b/lib/fuse_i.h
> @@ -117,6 +117,10 @@ struct fuse_session {
>  	 */
>  	uint32_t conn_want;
>  	uint64_t conn_want_ext;
> +
> +	/* destroy has to wait for all the open files to go away */
> +	pthread_cond_t zero_open_files;
> +	uint64_t open_files;
>  };
>  
>  struct fuse_chan {
> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> index 12724ed66bdcc8..f12c6db0eb0e60 100644
> --- a/lib/fuse_lowlevel.c
> +++ b/lib/fuse_lowlevel.c
> @@ -52,6 +52,30 @@
>  #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
>  #define OFFSET_MAX 0x7fffffffffffffffLL
>  
> +static inline void inc_open_files(struct fuse_session *se)
> +{
> +	pthread_mutex_lock(&se->lock);
> +	se->open_files++;
> +	pthread_mutex_unlock(&se->lock);
> +}
> +
> +static inline void dec_open_files(struct fuse_session *se)
> +{
> +	pthread_mutex_lock(&se->lock);
> +	se->open_files--;
> +	if (!se->open_files)
> +		pthread_cond_broadcast(&se->zero_open_files);
> +	pthread_mutex_unlock(&se->lock);
> +}

I think open files only decreases when destroy is received? Doesn't that
give us the chance to use an atomic (C11) and then to broadcast only
when FUSE_DESTROY is received? I.e. I would use an atomic for
'open_files', set something like 'se->destroy_received' and then trigger
the broadcast only when that is set.

(A later further optimization with io-uring will be to have that counter
per queue.)


Thanks,
Bernd

