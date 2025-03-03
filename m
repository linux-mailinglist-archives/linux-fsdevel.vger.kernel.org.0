Return-Path: <linux-fsdevel+bounces-42917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF4A4B794
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 06:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68BB18906C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 05:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0A1E285A;
	Mon,  3 Mar 2025 05:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DHoZ8Qpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5FD1E5706
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 05:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980033; cv=none; b=K7YYp4LVPkC3+N4jzEFRtLroTM0QvbzyjsOkWQ1uh2yHlmMzvTCd8cHGaGgc/1hS6764mIQoaNxo8BrGWnpOL27tcycFrqVwjFClcl+SnlRMl3PE7G6XtgxeZQXMVENhF6ttoVeNq5PssIR3MXk8cYLYWUTr7R6lpiPH6/OQS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980033; c=relaxed/simple;
	bh=WPM+b5EZw1HXLtmE8tQ4Hvr2yv2IohfqZGKj6mOIY0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIMNR7UZyh5Q/VBxqeAmfkvOdWtjWVvVeXQMs7QMuh+Mvf3GyEzEpzjXgqEQs8OjgX/K6Iknft7imUmRANUs+QIb8mLgsRtjvOtW2du8wE6nz2KmstRonxsfiQMIxHAXLQj6OEmvVLb691pWseBH0XqNJHzBPnp6iACCdq3ARQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DHoZ8Qpk; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740980022; x=1741584822; i=quwenruo.btrfs@gmx.com;
	bh=T9qWD7tGDCNRB9eH19Ibwdp9u/JsLq46Fdezmgrj/Uc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DHoZ8QpkvHb4zAWcuDThjflvGbWCPjVUApiYBrxlxXP5yFUxgyiKBJPwxNZuG7iK
	 YoZhkvJhtfyLEAmVs3ebaGtzvGFjpgEj08m8z2QzKEz+EVeLpHET89BPlkycsJV+S
	 RjoYRfOCY6ANyFfbFct4Gcso31fBEixeIHI0rPWJIE2E8gi35vvD/UuIkafR980nv
	 lOLr3YXabPTChcnUKHAL3qWUr9m5LPGb01cFCbQKCeIB0siGuFIRpsow3/oJ+qHdA
	 QFOtqeLvSKrTi1sb+WvEbYWaIhZ8WYEPBFOAI0NmqVooouYsL0HiobUZdw/HgGKF2
	 Y2mFB8lPu2vDF0C4Fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1u27ZV1TRw-00Fzbo; Mon, 03
 Mar 2025 06:33:41 +0100
Message-ID: <5b361973-5b31-4bb7-9229-fe2e7ed7969f@gmx.com>
Date: Mon, 3 Mar 2025 16:03:37 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Calling folio_end_writeback() inside a spinlock under task
 context?
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org
References: <14bd34c8-8fe0-4440-8dfd-e71223303edc@gmx.com>
 <Z8U1f4g5av7L1Tv-@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <Z8U1f4g5av7L1Tv-@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jGLn0ulbVhrQ7XGi+wvnOD91hEzkcflzJ7sRSkozhYhTjGqGzcm
 cpEjFD7CZoh0LDccv9erJ7NNJdvHMgwuLdkAzbApMAxMxXno3S+YkLBuNwlrj7CG1SJVGeo
 5lW77KNRG6tysmk/mKKlr5lahBWklQ6LxDUGVn78SLB2FzcbSMY31AQKqfFjAeQcssviNtA
 UTOe4uB6t6fe5RTtDesEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A/zZCA22IIc=;bD24oqunkw19dcHcGMb7z3AbcQw
 1taBTpWxGsHOmgFQe9EMvgOUf1N7tJeggG3Ns2RmLgor81p2UFblNZ8G6PD7evzoS3SWkJnm+
 dCU/d3ETaA1g5KDENJJoaQ5tDhOuQWMgYp8Z8CqOiHkCpmvMKBYxsVcfAMcBpzRFaX1LGOeWV
 Ya9GzLC2r/6kIXHfFkW6308LLBOTeJd3uoPHdhddYgu8HNSFGKSi5abqfC6K5Itx9R4kafSSH
 9+R6rKnn6naCyZXFYXEpfRJoQLIVrcTfPlmJkl0XUgwAjYIdL3axS8ZdsMHTXaW68SnpmLQ90
 aOEymo6col0uELjSxfjATv55rF/evunyEnw1ne2NCtYvqIcDS3KJTr1KsQCLcnikgfrqy9MYj
 wizZuMwl0ocaQh5a/HO9WHbMwwGCqTcUVxwNMOjws43hjr65ZoUtts8UAYTyvHM6NzZpdTO26
 JlQVvDiVmCQzCGP1fc8YkwZ9xSyAESngPeiGNB9GTGaYb1I0W23t0ZGFel0jzQqvmIRvYug0J
 tKQA4TAnJk1xixhk/7ZqCnvTI7/DkkkZjpi0oxgdTtYtuaxfiaLFI6ztMyEKN/zIgMxZuxVPl
 WRvHwEwgwVlYOqOaZeITdxRMoYtQk6RidyqCsA4wWkBchqyvVhlt0BWsMkuoVrWmJuXx9eqEt
 z6mlLNeO3pZWOQJrU/xCuXHbXdLWbaco64YI1ooqdxyMLXm/LWBuxH67rAQcKHKgTGJ1fMk/s
 MaOk9IY9Uq5NnVkXTj5WeMbuszBjElmJPx0qA7J8qlyoR1sOrHoVBo6Ht/KTaIWoLtOunJtlP
 lAExvxSbAdrW3rZvRIOHxekkinhEYghyRQ2kfO1zPthlZ8d6jIdDHiTGJJyfw8ZpN12tZzVgy
 cidPB2MgsWstDbuc06o4wQ8vgreuKfd2x1I+TcLOPAiXrvHrb+hk8DR+qcdx2ro28ADR97woM
 gnsNkrjUP/70rxcGwampnH5UD2HGNai3PeZ/z/iFB11TyT7lbL1Q+R+iYhRQue+dazVlAINle
 9Dv4rGffFhJnVnfQ9SCrPvCrtgoI24SyMihEscwOrsX/HYOVNMWkhMH3gvMEZLZLGWQVKKr0+
 VgXIuZNqORihkHLgKv/S9ZTJVeL2KIAdN5FxeL0d1Ap4UXYFsk6nV1ZcT6LX/EVXHG6eOhPlq
 2446wVMnFk26vSc8Xhrr15IBcUiExwcpCwx4apzmPbKG/WFuLgx6mREPKdDCijJPJgn9CSKbw
 0odyAvZDzAVVIsND5IhwklcTNhNYXmsKSYjjwhdJr5EB8T9JOGgq0og62Skj0Ale8iP6VLdB7
 nbbp8rIsnFqq5OUwJdl033ItpwrpeMXm2h4JAAmIWjvf/KZsaCMX3fVNSQ9/WHuxDj/yMRiBa
 4pNm9qK8elssLL34Nk94T7I3KoRGQIlnX3N4WgIAXzvcwE2iQjlgPZ2+HB



=E5=9C=A8 2025/3/3 15:22, Matthew Wilcox =E5=86=99=E9=81=93:
> Adding Jens to the cc.  As you well know, he added this code, so I'm
> mystified why you didn't cc him.  Also adding linux-fsdevel (I presume
> this was a mistake and you inadvertently cc'd f2fs-devel instead.)
>
> On Mon, Mar 03, 2025 at 10:34:26AM +1030, Qu Wenruo wrote:
>> [SPINLOCK AND END WRITEBACK]
>>
>> Although folio_end_writeback() can be called in an interruption context
>> (by the in_task() check), surprisingly it may not be suitable to be
>> called inside a spinlock (in task context):
>
> It's poor practice to do that; you're introducing a dependency between
> your fs lock and the i_mapping lock, which is already pretty intertwined
> with ... every other lock in the system.
>
>> For example the following call chain can lead to sleep:
>>
>> spin_lock()
>> folio_end_writeback()
>> |- folio_end_dropbehind_write()
>>     |- folio_launder()
>>        Which can sleep.
>>
>> My question is, can and should we allow folio_end_writeback() inside a
>> spinlock?
>>
>> [BTRFS' ASYNC EXTENT PROBLEM]
>>
>> This is again a btrfs specific behavior, that we have to call
>> folio_end_writeback() inside a spinlock to make sure really only one
>> thread can clear the writeback flag of a folio.
>>
>> I know iomap is doing a pretty good job preventing early finished
>> writeback to clear the folio writeback flag, meanwhile we're still
>> submitting other blocks inside the folio.
>>
>> Iomap goes holding one extra writeback count before starting marking
>> blocks writeback and submitting them.
>> And after all blocks are submitted, reduce the writeback count (and cal=
l
>> folio_end_writeback() if it's the last one holding the writeback flag).
>>
>> But the iomap solution requires that, all blocks inside a folio to be
>> submitted at the same time.
>
> I aactually don't like the iomap solution as it's currently written; it
> just hasn't risen high enough up my todo list to fix it.
>
> What we should do is initialise folio->ifs->write_bytes_pending to
> bitmap_weight(ifs->state, blocks_per_folio) * block_size in
> iomap_writepage_map() [this is oversimplified; we'd need to handle eof
> and so on too]

So you mean setting every block writeback (I know iomap doesn't track
per-block writeback) at the beginning, and clear the per-block writeback
flags for hole/eof etc, and let the to-be-submitted blocks to continue
their endio?

That's indeed solves the problem without the extra count.

I can go definitely that solution in btrfs first.

>
> That would address your problem as well as do fewer atomic operations.
>
>> This is not true in btrfs, due to the design of btrfs' async extent,
>> which can mark the blocks for writeback really at any timing, as we kee=
p
>> the lock of folios and queue them into a workqueue to do compression,
>> then only after the compression is done, we submit and mark them
>> writeback and unlock.
>>
>> If we do not hold a spinlock calling folio_end_writeback(), but only
>> checks if we're the last holder and call folio_end_writeback() out of
>> the spinlock, we can hit the following race where folio_end_writeback()
>> can be called on the same folio:
>>
>>       0          32K         64K
>>       |<- AE 1 ->|<- AE 2 ->|
>>
>>              Thread A (AE 1)           |            Thread B (AE 2)
>> --------------------------------------+------------------------------
>> submit_one_async_extent()             |
>> |- process_one_folio()                |
>>       |- subpage_set_writeback()       |
>>                                        |
>> /* IO finished */                     |
>> end_compressed_writeback()            |
>> |- btrfs_folio_clear_writeback()      |
>>       |- spin_lock()                   |
>>       |  /* this is the last writeback |
>>       |     holder, should end the     |
>>       |     folio writeback flag */    |
>>       |- last =3D true                   |
>>       |- spin_unlock()                 |
>>       |                                | submit_one_async_extent()
>>       |                                | |- process_one_folio()
>>       |                                |    |- subpage_set_writeback()
>
> This seems weird.  Why are you setting the "subpage" writeback bit
> while the folio writeback bit is still set?  That smells like a
> bug-in-waiting if not an actual bug to me.  Surely it should wait on
> the folio writeback bit to clear?

I considered waiting for the writeback, before setting it.
But it can still race, between the folio_wait_writeback() and the next
folio_start_writeback() call.

Where another async extent can start setting the the flag, and we're
hitting the same problem.

The key problem is still the async extent behavior, which I have to say
is way too problematic, and doesn't take fs block size < page size cases
into consideration at all.

>
>>       |                                | /* IO finished */
>>       |                                | end_compressed_writeback()
>>       |                                | |btrfs_folio_clear_writeback()
>>       |                                |    | /* Again the last holder =
*/
>>       |                                |    |- spin_lock()
>>       |                                |    |- last =3D true
>>       |                                |    |- spin_unlock()
>>       |- folio_end_writeback()         |    |- folio_end_writeback()
>>
>> I know the most proper solution would to get rid of the delayed unlock
>> and submission, but mark blocks for writeback without the async extent
>> mechanism completely, then follow the iomap's solution.
>>
>> But that will be a huge change (although we will go that path
>> eventually), meanwhile the folio_end_writeback() inside spinlock needs
>> to be fixed asap.
>
> I'd suggest the asap solution is for btrfs to mark itself as not
> supporting dropbehind.

Thanks a lot for this solution, that indeed solves the problem by
completely avoid folio release inside folio_end_writeback().

That will be the hot fix, and pushed for backports.

Just wondering what else will be affected other than the DONTCACHE writes?



I also have a middle ground solution, by disabling async extent for
ranges which are not page aligned (so no more than one async per folio,
thus no race), then use your improved writeback flag tracking and move
the folio_clear_writeback() out of the spinlock, but that's not a good
candidate for backport at all...

Thanks,
Qu

>
>> So my question is, can we allow folio_end_writeback() to be called
>> inside a spinlock, at the cost of screwing up the folio reclaim for
>> DONTCACHE?
>>
>> Thanks,
>> Qu
>>


