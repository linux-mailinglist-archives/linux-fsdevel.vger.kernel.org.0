Return-Path: <linux-fsdevel+bounces-67006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92556C3319F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 22:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214C24E3226
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812F346785;
	Tue,  4 Nov 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="NiAD7qnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROpU75sE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D92BDC29;
	Tue,  4 Nov 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292879; cv=none; b=r38SXU47SJ3XfzhxgjO6QokZDimRZukxp4jpk/TmQq1YKI6ixsn/wloF9z8fm8ILrsPCxGByHjc+EB2HP6c3LMUHmaNOB9/mOJ98PK7TO/JK9TvOERKgUhwvFuo/MhwTrjkBuHu0IIzaQGK0yN3IYLe5ER6cBVM7ZZBp6XBaI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292879; c=relaxed/simple;
	bh=CBRzfv5gGBC5Uc9eN6jFEVJRkhOC4OpydzBhjBIX7Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQGNlGJVnc8SXZBGhodhusbmBX4nepw1jpxxN2o9QIYejp7cYSL0aZ13fZkyDyB4kNc8koLTJiBhN8GfENrod3+eb48vRYTzOTlcrsX1+c8L4ApBZiS61DhoW3QzYnCKqqP7Rfs4L5d3s3u2AsE3Ba3nBW01hcqxvFsAtaZYPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=NiAD7qnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ROpU75sE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C6D5E1D0010A;
	Tue,  4 Nov 2025 16:47:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 04 Nov 2025 16:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1762292875;
	 x=1762379275; bh=UZMkskdZGEy/ZOhbY3vVwwld6Sejbwuvlzt3XY//SHU=; b=
	NiAD7qndnvk0POVlL5bhlXqiRi9EhQ2cWOCtR6Jhq8hY9qnZxEm2qDwSAzQUQYQL
	o5tjJwYBmYpUAPssZP9tRIomoHzNwK1qifRTxX4lWKRCvqFiKlZ34pdfRQhywymI
	TYO0ikCv6MVo8eEZc1+h2yIZ/M/Pg2JgMpaYpzPPNwDcBkldU9nh9/cO4F1Mu87P
	GJE9lFpDpid9CG8/lfQQ5gesDOmNMO3A8dkcOOt8YfWTYt28py/y9mG2YPXrU5nP
	UBLBRgBXmZeWl8f+iiKJ2HcoXEBad03U+sGvxk2GSx0DnQ4uLQzr9njVuoetUL+F
	IucJbsXdCeoLwmuvVoXI3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762292875; x=
	1762379275; bh=UZMkskdZGEy/ZOhbY3vVwwld6Sejbwuvlzt3XY//SHU=; b=R
	OpU75sET0evUjVM3eqSCE+JlF7u//GfZlrweHiidZG86aiUKkC6Hi9pV4hyKHEUp
	4poSlmC6DvVZslBQPe0RSYEJs5EAm/0AnSzSfpdRbDiIg+fREyNK1jZq9knJYPK0
	SHHBLIIs7G1Fe/oasStNfSpVhTY+ptz8dhkvMgYEXQ/tCN6l5uHBdCpM8h3pRwi6
	8Yxb6LtlVzkLLw+FlhVtgx5AnBELwP+pexM9Dcp9siS/M3kjzfjXkhB3YoS77Kct
	gs4V06j1Eifapp2zHHXl7zxqWoW36KFpFIvd6akDjF7sZDZ5ce6S0esTVUDyat5g
	/ov5LPWoduYTAx90+5GXA==
X-ME-Sender: <xms:inQKaRk24Y_dMuayXEvWfnPoycoL_rBwU7Y2uog4qzQ3NGEIWmvPEg>
    <xme:inQKaWLudwo9jJvlh8aFvy02CLcSjO8XJHE3AvQY3ImYgZKgY2Ilzznna3i5aJhS-
    AwMZqi6SNHhF_WsqpV5CHi14a7Nifg8BhfmJOHscDohKqgHiKGK>
X-ME-Received: <xmr:inQKae5aCloYVEy_C_D6igdMFrqJnO4Xk9B2SmwQQjhDY0vfc8ZyFrDdwwICFIeEoLzLSVt74-1XPuxjWWxxcrPBVKUmV11faI8WjFc9i9b85SmYzjOL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprg
    druggvvhdprhgtphhtthhopehlihhnuhigqdgvgihtgeesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:inQKaS2qsmqL_uKPjQvwGw3jQndSM-fibuuw8uTd_3VdYaSiqTeXWg>
    <xmx:inQKacdZe-gbjj6NDPm4WRh_ctRbI7Cpmtj_frGh1QaAHfIsRJ0-ig>
    <xmx:inQKaQcIcCOkey21-HneT8PDV2IB-4_SopnMkB5cIqGRb2Ai4xzbSg>
    <xmx:inQKafyQoSGlyuHuqhFcv3sseD-qs8Q452h_3YEdpJnXY6Cal2ZI8Q>
    <xmx:i3QKaXuC4bilb_h6UIL9ESHlPwaghv8dh5pI6eFyGRBHVrsL1H41Rvt1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 16:47:53 -0500 (EST)
Message-ID: <a9c0c66e-c3ce-4cdd-bd83-dd04bc5f9379@bsbernd.com>
Date: Tue, 4 Nov 2025 22:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
To: Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/4/25 20:22, Joanne Koong wrote:
> On Mon, Nov 3, 2025 at 2:13 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>
>> On Mon, Nov 03, 2025 at 09:20:26AM -0800, Joanne Koong wrote:
>>> On Tue, Oct 28, 2025 at 5:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>
>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>
>>>> generic/488 fails with fuse2fs in the following fashion:
>>>>
>>>> generic/488       _check_generic_filesystem: filesystem on /dev/sdf is inconsistent
>>>> (see /var/tmp/fstests/generic/488.full for details)
>>>>
>>>> This test opens a large number of files, unlinks them (which really just
>>>> renames them to fuse hidden files), closes the program, unmounts the
>>>> filesystem, and runs fsck to check that there aren't any inconsistencies
>>>> in the filesystem.
>>>>
>>>> Unfortunately, the 488.full file shows that there are a lot of hidden
>>>> files left over in the filesystem, with incorrect link counts.  Tracing
>>>> fuse_request_* shows that there are a large number of FUSE_RELEASE
>>>> commands that are queued up on behalf of the unlinked files at the time
>>>> that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
>>>> aborted, the fuse server would have responded to the RELEASE commands by
>>>> removing the hidden files; instead they stick around.
>>>>
>>>> For upper-level fuse servers that don't use fuseblk mode this isn't a
>>>> problem because libfuse responds to the connection going down by pruning
>>>> its inode cache and calling the fuse server's ->release for any open
>>>> files before calling the server's ->destroy function.
>>>>
>>>> For fuseblk servers this is a problem, however, because the kernel sends
>>>> FUSE_DESTROY to the fuse server, and the fuse server has to close the
>>>> block device before returning.  This means that the kernel must flush
>>>> all pending FUSE_RELEASE requests before issuing FUSE_DESTROY.
>>>>
>>>> Create a function to push all the background requests to the queue and
>>>> then wait for the number of pending events to hit zero, and call this
>>>> before sending FUSE_DESTROY.  That way, all the pending events are
>>>> processed by the fuse server and we don't end up with a corrupt
>>>> filesystem.
>>>>
>>>> Note that we use a wait_event_timeout() loop to cause the process to
>>>> schedule at least once per second to avoid a "task blocked" warning:
>>>>
>>>> INFO: task umount:1279 blocked for more than 20 seconds.
>>>>       Not tainted 6.17.0-rc7-xfsx #rc7
>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag.
>>>> task:umount          state:D stack:11984 pid:1279  tgid:1279  ppid:10690
>>>>
>>>> Earlier in the threads about this patch there was a (self-inflicted)
>>>> dispute as to whether it was necessary to call touch_softlockup_watchdog
>>>> in the loop body.  Because the process goes to sleep, it's not necessary
>>>> to touch the softlockup watchdog because we're not preventing another
>>>> process from being scheduled on a CPU.
>>>>
>>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>>> ---
>>>>  fs/fuse/fuse_i.h |    5 +++++
>>>>  fs/fuse/dev.c    |   35 +++++++++++++++++++++++++++++++++++
>>>>  fs/fuse/inode.c  |   11 ++++++++++-
>>>>  3 files changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>>>> index c2f2a48156d6c5..aaa8574fd72775 100644
>>>> --- a/fs/fuse/fuse_i.h
>>>> +++ b/fs/fuse/fuse_i.h
>>>> @@ -1274,6 +1274,11 @@ void fuse_request_end(struct fuse_req *req);
>>>>  void fuse_abort_conn(struct fuse_conn *fc);
>>>>  void fuse_wait_aborted(struct fuse_conn *fc);
>>>>
>>>> +/**
>>>> + * Flush all pending requests and wait for them.
>>>> + */
>>>> +void fuse_flush_requests_and_wait(struct fuse_conn *fc);
>>>> +
>>>>  /* Check if any requests timed out */
>>>>  void fuse_check_timeout(struct work_struct *work);
>>>>
>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>> index 132f38619d7072..ecc0a5304c59d1 100644
>>>> --- a/fs/fuse/dev.c
>>>> +++ b/fs/fuse/dev.c
>>>> @@ -24,6 +24,7 @@
>>>>  #include <linux/splice.h>
>>>>  #include <linux/sched.h>
>>>>  #include <linux/seq_file.h>
>>>> +#include <linux/nmi.h>
>>>>
>>>>  #include "fuse_trace.h"
>>>>
>>>> @@ -2430,6 +2431,40 @@ static void end_polls(struct fuse_conn *fc)
>>>>         }
>>>>  }
>>>>
>>>> +/*
>>>> + * Flush all pending requests and wait for them.  Only call this function when
>>>> + * it is no longer possible for other threads to add requests.
>>>> + */
>>>> +void fuse_flush_requests_and_wait(struct fuse_conn *fc)
>>>> +{
>>>> +       spin_lock(&fc->lock);
>>>
>>> Do we need to grab the fc lock? fc->connected is protected under the
>>> bg_lock, afaict from fuse_abort_conn().
>>
>> Oh, heh.  Yeah, it does indeed take both fc->lock and fc->bg_lock.
>> Will fix that, thanks. :)
>>
>> FWIW I don't think it's a big deal if we see a stale connected==1 value
>> because the events will all get cancelled and the wait loop won't run
>> anyway, but I agree with being consistent about lock ordering. :)
>>
>>>> +       if (!fc->connected) {
>>>> +               spin_unlock(&fc->lock);
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       /* Push all the background requests to the queue. */
>>>> +       spin_lock(&fc->bg_lock);
>>>> +       fc->blocked = 0;
>>>> +       fc->max_background = UINT_MAX;
>>>> +       flush_bg_queue(fc);
>>>> +       spin_unlock(&fc->bg_lock);
>>>> +       spin_unlock(&fc->lock);
>>>> +
>>>> +       /*
>>>> +        * Wait for all pending fuse requests to complete or abort.  The fuse
>>>> +        * server could take a significant amount of time to complete a
>>>> +        * request, so run this in a loop with a short timeout so that we don't
>>>> +        * trip the soft lockup detector.
>>>> +        */
>>>> +       smp_mb();
>>>> +       while (wait_event_timeout(fc->blocked_waitq,
>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
>>>> +                       HZ) == 0) {
>>>> +               /* empty */
>>>> +       }
>>>
>>> I'm wondering if it's necessary to wait here for all the pending
>>> requests to complete or abort?
>>
>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
>> be.  If someone kills a program with a large number of open unlinked
>> files and immediately calls umount(), then the fuse client could be in
>> the process of sending FUSE_RELEASE requests to the server.
>>
>> [background info, feel free to speedread this paragraph]
>> For a non-fuseblk server, unmount aborts all pending requests and
>> disconnects the fuse device.  This means that the fuse server won't see
>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
>> with a lot of .fuseXXXXX files that nobody cleans up.
>>
>> If you make ->destroy release all the remaining open files, now you run
>> into a second problem, which is that if there are a lot of open unlinked
>> files, freeing the inodes can collectively take enough time that the
>> FUSE_DESTROY request times out.
>>
>> On a fuseblk server with libfuse running in multithreaded mode, there
>> can be several threads reading fuse requests from the fusedev.  The
>> kernel actually sends its own FUSE_DESTROY request, but there's no
>> coordination between the fuse workers, which means that the fuse server
>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
>> processed, you end up with the same .fuseXXXXX file cleanup problem.
> 
> imo it is the responsibility of the server to coordinate this and make
> sure it has handled all the requests it has received before it starts
> executing the destruction logic. imo the only responsibility of the
> kernel is to actually send the background requests before it sends the
> FUSE_DESTROY. I think non-fuseblk servers should also receive the
> FUSE_DESTROY request.

Hmm, good idea, I guess we can add that in libfuse, maybe with some kind
of timeout.

There is something I don't understand though, how can FUSE_DESTROY
happen before FUSE_RELEASE is completed?

->release / fuse_release
   fuse_release_common
      fuse_file_release
         fuse_file_put
            fuse_simple_background
            <userspace>
            <userspace-reply>
               fuse_release_end
                  iput()

I.e. how can it release the superblock (which triggers FUSE_DESTROY)


Thanks,
Bernd

