Return-Path: <linux-fsdevel+bounces-67499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA067C41CB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E17434F3D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771CD31280C;
	Fri,  7 Nov 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="CZmWxblc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CP5xXRX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C2311C36;
	Fri,  7 Nov 2025 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762553010; cv=none; b=R1JFf+4tJMPrzS0HJZRPaVYr/pPiyISEGWHY5v+nD1Xh4gTDOFykmTxyobjXWlCTyouMQpCcCQ0Cmn1H4/WC/U+0myzeDW1p3N1GAFlM6WSx1/u1NGAMmUJL8Nt75LuywZifsoYNA/BN9BQahPufFHj2HjfKWMbedOIo4UxzZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762553010; c=relaxed/simple;
	bh=l+xn9Wf8EeaB/YA9WbsXhkPyiQZlesRwad+kJhlC+JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw813MLE/UioJDclKPUkN55J3BpBNE0x7QOTrujzOPBIpqwOTlddzevvuf7F7uPTKOg9ziayqD7bkrwK0wzAey0JthoJTc2J9t1uK4ZP0PFxkSvJdhxY/kT1XlqQcGSfTGREA1A9lMzC9TUjxhpuL/kLkbPtrv5BX6PlZvzQcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=CZmWxblc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CP5xXRX8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4AB68EC0256;
	Fri,  7 Nov 2025 17:03:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 07 Nov 2025 17:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762553007;
	 x=1762639407; bh=jqzvBjkqy5NUMszdtfxo3uazfkkLkn9Yc/Ij8ycFGGM=; b=
	CZmWxblcjYTFVBknb0xdDiTLCZLoSE/gN/tnU4M6E3bZ2GjeYgrZImNf2R2kYrfV
	L2vCxCZDYyKfXW6tyjUVe2eCVNDITB0OeQMRPGsCUcwDroEnbdEkY1AuOej8oAPM
	DKu3AWx92sK00MDHxpfmD8ZbfSkSuCczik7WQADae3buFtutSC7X6reU8pup2pmO
	YBeqOvfnY4WK/Qm7PDL1fiSOZ3YbKB3OmD82ZwFNJFjmZWnFEC5p/V6iiPBpx66K
	xvmNiTbrdj6hbRw7qEbNL3VthjLBm05eFuYZTJRQM8LKLJu4MCxLb6tQW6szjVvu
	3o52TVTzPdeDdHoxFPPLvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762553007; x=
	1762639407; bh=jqzvBjkqy5NUMszdtfxo3uazfkkLkn9Yc/Ij8ycFGGM=; b=C
	P5xXRX8M3QgpV8+1I+YwysXfiEgCBZvyJQRnoRlMlvz+PmM9/DxBFwMzNHD7sNUl
	EE/t0yNPMk8RIa1kt5Insz3N9atvkzT0hckipAzvJV/ZEx7D8nn6Oc5FwKQAfj5A
	KlEbxwsAqCBRVp4tH7FPz1aqW0H3PfrPYK4G1reFKMCIMc1HYOMrmf6/TyQ3X1v/
	1I4Lu1G51+mQE7RExo3Fsy9Y+KCwS9Lb/PBOTMaO/8fNJigtPXxDZTV3ob0W/wHY
	AukJyrEyUJzAbmHK46nWvVtq0WzcFkSF10FThmgIPopk70IVAdzJUKTe4CtKgFXE
	Zfssn9b6lCPcb2HXaasFg==
X-ME-Sender: <xms:rmwOaU8l9uj3hu4riqpbVauHZdDIdZCUhXQkGIU_ElpcWU5QxV9Odw>
    <xme:rmwOaWBMFCF5C8rAt_f5nnmsg4Jc--CsnvpkGUVykCY7uADE1NfX9XkQIuvgrbdo5
    l-F5kCMlzUWKiqQuJKlcREUsDTapoZfFJ_eBDrHFfsSnuH0Rw>
X-ME-Received: <xmr:rmwOaRSUOGFY6MLHAMzRvfO5LBuLPAi1keD5XIPSPZFrhJLNcvIBn1wuEIPSU2c54uY6uv49TpqkbkxzgvCDPuHYouQ06quqlayClX3K-xPzVKRYE68w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtkeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rmwOaVsjwaOCu3Gqg7HIMpPcXpBMYamzlzx1ZyN5bfLcmqRGAjYkRQ>
    <xmx:rmwOaV1G7M63Kbnt5doKJk_Z6TysR8GLRnpcf-Fw75Mmi2p69PF9Ow>
    <xmx:rmwOaeWHW-SZiDR0RlD7n9tY9R6j7jkY3_xKoOXstOIUKFJdQfSdNA>
    <xmx:rmwOaYJ2cD968R9c0bcDOex3wqEUSCwLpegNuWoqWIx3TzY_7s5S9Q>
    <xmx:r2wOaRNGDG_gsitz2ej2E8oKhtRxKQTC9noNYW3UGYMulFCuVAuSKZhI>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 17:03:25 -0500 (EST)
Message-ID: <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>
Date: Fri, 7 Nov 2025 23:03:24 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
To: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251107042619.GK196358@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/7/25 05:26, Darrick J. Wong wrote:
> [I read this email backwards, like I do]
> 
> On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
>> On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>
>>> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
>>>
>>> <snipping here because this thread has gotten very long>
>>>
>>>>>>> +       while (wait_event_timeout(fc->blocked_waitq,
>>>>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
>>>>>>> +                       HZ) == 0) {
>>>>>>> +               /* empty */
>>>>>>> +       }
>>>>>>
>>>>>> I'm wondering if it's necessary to wait here for all the pending
>>>>>> requests to complete or abort?
>>>>>
>>>>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
>>>>> be.  If someone kills a program with a large number of open unlinked
>>>>> files and immediately calls umount(), then the fuse client could be in
>>>>> the process of sending FUSE_RELEASE requests to the server.
>>>>>
>>>>> [background info, feel free to speedread this paragraph]
>>>>> For a non-fuseblk server, unmount aborts all pending requests and
>>>>> disconnects the fuse device.  This means that the fuse server won't see
>>>>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
>>>>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
>>>>> with a lot of .fuseXXXXX files that nobody cleans up.
>>>>>
>>>>> If you make ->destroy release all the remaining open files, now you run
>>>>> into a second problem, which is that if there are a lot of open unlinked
>>>>> files, freeing the inodes can collectively take enough time that the
>>>>> FUSE_DESTROY request times out.
>>>>>
>>>>> On a fuseblk server with libfuse running in multithreaded mode, there
>>>>> can be several threads reading fuse requests from the fusedev.  The
>>>>> kernel actually sends its own FUSE_DESTROY request, but there's no
>>>>> coordination between the fuse workers, which means that the fuse server
>>>>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
>>>>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
>>>>> processed, you end up with the same .fuseXXXXX file cleanup problem.
>>>>
>>>> imo it is the responsibility of the server to coordinate this and make
>>>> sure it has handled all the requests it has received before it starts
>>>> executing the destruction logic.
>>>
>>> I think we're all saying that some sort of fuse request reordering
>>> barrier is needed here, but there's at least three opinions about where
>>> that barrier should be implemented.  Clearly I think the barrier should
>>> be in the kernel, but let me think more about where it could go if it
>>> were somewhere else.
>>>
>>> First, Joanne's suggestion for putting it in the fuse server itself:
>>>
>>> I don't see how it's generally possible for the fuse server to know that
>>> it's processed all the requests that the kernel might have sent it.
>>> AFAICT each libfuse thread does roughly this:
>>>
>>> 1. read() a request from the fusedev fd
>>> 2. decode the request data and maybe do some allocations or transform it
>>> 3. call fuse server with request
>>> 4. fuse server does ... something with the request
>>> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
>>>
>>> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
>>> out if there are other fuse worker threads that are somewhere in steps
>>> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
>>> that are waiting in fuse_session_receive_buf_internal, so fuse servers
>>> can't ask the library about that either.
>>>
>>> Taking a narrower view, it might be possible for the fuse server to
>>> figure this out by maintaining an open resource count.  It would
>>> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
>>> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
>>> the only kind of request that can be pending when a FUSE_DESTROY comes
>>> in, then destroy just has to wait for the counter to hit zero.
>>
>> I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
>> if there are X worker threads that are all running fuse_do_work( )
>> then if you get a FUSE_DESTROY on one of those threads that thread can
>> set some se->destroyed field. At this point the other threads will
>> have already called fuse_session_receive_buf_internal() on all the
>> flushed background requests, so after they process it and return from
>> fuse_session_process_buf_internal(), then they check if se->destroyed
>> was set, and if it is they exit the thread, while in the thread that
>> got the FUSE_DESTROY it sleeps until all the threads have completed
>> and then it executes the destroy logic.That to me seems like the
>> cleanest approach.
> 
> Hrm.  Well now (scrolling to the bottom and back) that I know that the
> FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
> think that /could/ work.
> 
> One tricky thing with having worker threads check a flag and exit is
> that they can be sleeping in the kernel (from _fuse_session_receive_buf)
> when the "just go away" flag gets set.  If the thread never wakes up,
> then it'll never exit.  In theory you could have the FUSE_DESTROY thread
> call pthread_cancel on all the other worker threads to eliminate them
> once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
> nightmares from adventures in pthread_cancel at Sun in 2002. :P
> 
> Maybe an easier approach would be to have fuse_do_work increment a
> counter when it receives a buffer and decrement it when it finishes with
> that buffer.  The FUSE_DESTROY thread merely has to wait for that
> counter to reach 1, at which point it's the only thread with a request
> to process, so it can call do_destroy.  That at least would avoid adding
> a new user of pthread_cancel() into the mt loop code.

I will read through the rest (too tired right now) durig the weekend. 
I was also thinking about counter. And let's please also do this right
also handling io-uring. I.e. all CQEs needs to have been handled.
Without io-uring it would be probably a counter in decreased in 
fuse_free_req(), with io-uring it is a bit more complex.

Thanks,
Bernd


