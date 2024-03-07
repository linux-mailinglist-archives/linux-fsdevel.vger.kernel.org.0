Return-Path: <linux-fsdevel+bounces-13936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDC98759EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869D7B251FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C56131E3C;
	Thu,  7 Mar 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ILvu3lp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="paLnwyx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC213E7FB;
	Thu,  7 Mar 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849173; cv=none; b=fZ2E6KJm/EQRfgrLEgYZTBqRWaMIqj8HNraTWDpHNbdUwJPdQG5bWxolXLdUxJHZ8mwi3HQ1rv67yvMLD0MpDg8zmMZ/trcf4vDJnmiGtfo8dW+0Ni2/b/Oh+96FZ0fogIpBhCHyCYlT1UDNy7FG5rjtq7ZIOlcjGY7+HH+1L28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849173; c=relaxed/simple;
	bh=g4Ur026s0jZ67OPMk4K07/F2piTqVobx6D6IoPLP7rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ov+aeNC3L/OXV2cLm+R7/VjbwD3D2/zOAu4x/k+qPPP5n8EmOH3plXyrIQZ8NFzNgEhOnptBCckueNSsQ39pCg7d16k7HhJYfpTary83T0sz3LeIHfQIS9aQiDQ7qVNIcbCWPAhMr7GmkBB9pPrfZIR3RtpMQaHP2iiwm+rzNxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ILvu3lp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=paLnwyx1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7F2811140157;
	Thu,  7 Mar 2024 17:06:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 07 Mar 2024 17:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709849170;
	 x=1709935570; bh=WoUD1tlvlqWLjMirpHZ9jhS+d1WBIo/jBDVziwi3d60=; b=
	ILvu3lp4QaxU/PKWOk8CpGFli8gM0BsDsmpxlZf7Y+ElaIEq2FmrA6rxnvjtjF7p
	BleXmqlbYzbHzXGHIgNasEIkrpr3p5D0Ezz6DLiStRHek54+jxaU+NYff6aT5tso
	iojS10uXgdTSz1sqRFxnxLGCnC9fz3NWaqSR+ppFygn1jvgmA3zZiPiBfyDhkJ9o
	PMYgg4YjblLhS5PNGsAXOIB7H0tEKkXOYQXf2Y2aGaf0vBAILyI3oe291vnLSSDy
	ah2I/9q1UVTE61eCAQZWjv4bLUIWFzhjj684w8sMZnBnX74bDM9783g1deOPLDvD
	7OZ0Xbw4rTjMnK/hBV5Y4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709849170; x=
	1709935570; bh=WoUD1tlvlqWLjMirpHZ9jhS+d1WBIo/jBDVziwi3d60=; b=p
	aLnwyx1jUNXdpqRa5VFiDMtbQbr8j8jRDvoWazRZsP1ddzPxIMy1oJ+KZfz3Cl2i
	T6GV4c2Yj4qYAx/BmjiJ9M1DAGugUzsR8/noTSfuk2xVbJDxZQo5eZComWsQ112m
	+rfiVJnG4l2sZx2BcvaPLAQJLqGg/nNay7lYXlhuVEa5s+VXtduOm5VQbORosNcX
	A1z+Nb27AO8AOaDN5myP07HsVBadGolV3KOQPYpfMeq1/5HEJ5iDXiblDLjBXZxH
	rra7jXll0FBcjiGgV6cQsEDdr0ZNVlUZcmaz3r6digQIsYsDJxNIiJbPZafen/+Q
	QRSYsqJrj1CYV60EFIJWQ==
X-ME-Sender: <xms:UTrqZQw0CuU7qsgMX3OnZQnx9asVZuWILQK9qK3Od95gbdW7yHNrcg>
    <xme:UTrqZUQNIVsiuwoYcMS1VKuBneHWN1s4O1p84qvfCg6zLzYtlOlBC8N-4vxeXC7tf
    rKs83T9xp6ah9-A>
X-ME-Received: <xmr:UTrqZSUWDqkVa55xQ3RY2pBxfKcO9pTKBDJdMJYrQVhFTfZSklMp15elTzn4dNge5Z7gXFW_ySFaKyTWN-oLyaC-sAyrPjfP8wrLBLG2G0sDah0lJzYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeefkedtgefhheegvddtfeejheeh
    ueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:UTrqZegX5Gf_OdT3IW1Ok3PG_eUv6i7w-95Io7O6ZYJ8YnfSO-W3ag>
    <xmx:UTrqZSBivJ_9Kb2wzDSu57xMNnfMEsHJUCBSmCr87YB2NvnhJ3D_5A>
    <xmx:UTrqZfIjxfl6gye8ENVTDYyXC7aHmZdortvzSiPvwVSgN2eaYCsOQg>
    <xmx:UjrqZZ6EbCrbWoWQQRcDclt6OwMA98n_TsyMVkxIWnCfAtExgE0LRA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 17:06:08 -0500 (EST)
Message-ID: <b24ed720-5490-46e7-8f64-0410d6ea23b5@fastmail.fm>
Date: Thu, 7 Mar 2024 23:06:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: increase FUSE_MAX_MAX_PAGES limit
To: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangjiachen.jaycee@bytedance.com
References: <20240124070512.52207-1-jefflexu@linux.alibaba.com>
 <CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com>
 <6e6bef3d-dd26-45ce-bc4a-c04a960dfb9c@linux.alibaba.com>
 <b4e6b930-ed06-4e0d-b17d-61d05381ac92@linux.alibaba.com>
 <27b34186-bc7c-4f3c-8818-ee73eb3f82ba@linux.alibaba.com>
 <CAJfpegvLUrqkCkVc=yTXcjZyNNQEG4Z4c6TONEZHGGmjiQ5X2g@mail.gmail.com>
 <7e79a9fa-99a0-47e5-bc39-107f89852d8d@linux.alibaba.com>
 <5343dc29-83cb-49b4-91ff-57bbd0eaa1df@fastmail.fm>
 <cb39ba49-eada-44b4-97fd-ea27ac8ba1f4@linux.alibaba.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <cb39ba49-eada-44b4-97fd-ea27ac8ba1f4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jingbo,

On 3/7/24 03:16, Jingbo Xu wrote:
> Hi Bernd,
> 
> On 3/6/24 11:45 PM, Bernd Schubert wrote:
>>
>>
>> On 3/6/24 14:32, Jingbo Xu wrote:
>>>
>>>
>>> On 3/5/24 10:26 PM, Miklos Szeredi wrote:
>>>> On Mon, 26 Feb 2024 at 05:00, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>> Hi Miklos,
>>>>>
>>>>> On 1/26/24 2:29 PM, Jingbo Xu wrote:
>>>>>>
>>>>>>
>>>>>> On 1/24/24 8:47 PM, Jingbo Xu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/24/24 8:23 PM, Miklos Szeredi wrote:
>>>>>>>> On Wed, 24 Jan 2024 at 08:05, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>>>
>>>>>>>>> From: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>>>>
>>>>>>>>> Increase FUSE_MAX_MAX_PAGES limit, so that the maximum data size of a
>>>>>>>>> single request is increased.
>>>>>>>>
>>>>>>>> The only worry is about where this memory is getting accounted to.
>>>>>>>> This needs to be thought through, since the we are increasing the
>>>>>>>> possible memory that an unprivileged user is allowed to pin.
>>>>>>
>>>>>> Apart from the request size, the maximum number of background requests,
>>>>>> i.e. max_background (12 by default, and configurable by the fuse
>>>>>> daemon), also limits the size of the memory that an unprivileged user
>>>>>> can pin.  But yes, it indeed increases the number proportionally by
>>>>>> increasing the maximum request size.
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> This optimizes the write performance especially when the optimal IO size
>>>>>>>>> of the backend store at the fuse daemon side is greater than the original
>>>>>>>>> maximum request size (i.e. 1MB with 256 FUSE_MAX_MAX_PAGES and
>>>>>>>>> 4096 PAGE_SIZE).
>>>>>>>>>
>>>>>>>>> Be noted that this only increases the upper limit of the maximum request
>>>>>>>>> size, while the real maximum request size relies on the FUSE_INIT
>>>>>>>>> negotiation with the fuse daemon.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Xu Ji <laoji.jx@alibaba-inc.com>
>>>>>>>>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>>>>>>>>> ---
>>>>>>>>> I'm not sure if 1024 is adequate for FUSE_MAX_MAX_PAGES, as the
>>>>>>>>> Bytedance floks seems to had increased the maximum request size to 8M
>>>>>>>>> and saw a ~20% performance boost.
>>>>>>>>
>>>>>>>> The 20% is against the 256 pages, I guess.
>>>>>>>
>>>>>>> Yeah I guess so.
>>>>>>>
>>>>>>>
>>>>>>>> It would be interesting to
>>>>>>>> see the how the number of pages per request affects performance and
>>>>>>>> why.
>>>>>>>
>>>>>>> To be honest, I'm not sure the root cause of the performance boost in
>>>>>>> bytedance's case.
>>>>>>>
>>>>>>> While in our internal use scenario, the optimal IO size of the backend
>>>>>>> store at the fuse server side is, e.g. 4MB, and thus if the maximum
>>>>>>> throughput can not be achieved with current 256 pages per request. IOW
>>>>>>> the backend store, e.g. a distributed parallel filesystem, get optimal
>>>>>>> performance when the data is aligned at 4MB boundary.  I can ask my folk
>>>>>>> who implements the fuse server to give more background info and the
>>>>>>> exact performance statistics.
>>>>>>
>>>>>> Here are more details about our internal use case:
>>>>>>
>>>>>> We have a fuse server used in our internal cloud scenarios, while the
>>>>>> backend store is actually a distributed filesystem.  That is, the fuse
>>>>>> server actually plays as the client of the remote distributed
>>>>>> filesystem.  The fuse server forwards the fuse requests to the remote
>>>>>> backing store through network, while the remote distributed filesystem
>>>>>> handles the IO requests, e.g. process the data from/to the persistent store.
>>>>>>
>>>>>> Then it comes the details of the remote distributed filesystem when it
>>>>>> process the requested data with the persistent store.
>>>>>>
>>>>>> [1] The remote distributed filesystem uses, e.g. a 8+3 mode, EC
>>>>>> (ErasureCode), where each fixed sized user data is split and stored as 8
>>>>>> data blocks plus 3 extra parity blocks. For example, with 512 bytes
>>>>>> block size, for each 4MB user data, it's split and stored as 8 (512
>>>>>> bytes) data blocks with 3 (512 bytes) parity blocks.
>>>>>>
>>>>>> It also utilize the stripe technology to boost the performance, for
>>>>>> example, there are 8 data disks and 3 parity disks in the above 8+3 mode
>>>>>> example, in which each stripe consists of 8 data blocks and 3 parity
>>>>>> blocks.
>>>>>>
>>>>>> [2] To avoid data corruption on power off, the remote distributed
>>>>>> filesystem commit a O_SYNC write right away once a write (fuse) request
>>>>>> received.  Since the EC described above, when the write fuse request is
>>>>>> not aligned on 4MB (the stripe size) boundary, say it's 1MB in size, the
>>>>>> other 3MB is read from the persistent store first, then compute the
>>>>>> extra 3 parity blocks with the complete 4MB stripe, and finally write
>>>>>> the 8 data blocks and 3 parity blocks down.
>>>>>>
>>>>>>
>>>>>> Thus the write amplification is un-neglectable and is the performance
>>>>>> bottleneck when the fuse request size is less than the stripe size.
>>>>>>
>>>>>> Here are some simple performance statistics with varying request size.
>>>>>> With 4MB stripe size, there's ~3x bandwidth improvement when the maximum
>>>>>> request size is increased from 256KB to 3.9MB, and another ~20%
>>>>>> improvement when the request size is increased to 4MB from 3.9MB.
>>>>
>>>> I sort of understand the issue, although my guess is that this could
>>>> be worked around in the client by coalescing writes.  This could be
>>>> done by adding a small delay before sending a write request off to the
>>>> network.
>>>>
>>>> Would that work in your case?
>>>
>>> It's possible but I'm not sure. I've asked my colleagues who working on
>>> the fuse server and the backend store, though have not been replied yet.
>>>  But I guess it's not as simple as increasing the maximum FUSE request
>>> size directly and thus more complexity gets involved.
>>>
>>> I can also understand the concern that this may increase the risk of
>>> pinning more memory footprint, and a more generic using scenario needs
>>> to be considered.  I can make it a private patch for our internal product.
>>>
>>> Thanks for the suggestions and discussion.
>>
>> It also gets kind of solved in my fuse-over-io-uring branch - as long as
>> there are enough free ring entries. I'm going to add in a flag there
>> that other CQEs might be follow up requests. Really time to post a new
>> version.
> 
> Thanks for the information.  I've not read the fuse-over-io-uring branch
> yet, but sounds like it would be much helpful .  Would there be a flag
> in the FUSE request indicating it's one of the linked FUSE requests?  Is
> this feature, say linked FUSE requests, enabled only when io-uring is
> upon FUSE?


Current development branch is this
https://github.com/bsbernd/linux/tree/fuse-uring-for-6.8
(It sometimes gets rebase/force pushes and incompatible changes - the
corresponding libfuse branch is also persistently updated).

Patches need clean up before I can send the next RFC version. And I
first want to change fixed single request size (not so nice to use 1MB
requests when 4K would be sufficient, for things like metadata and small
IO).


I just checked, struct fuse_write_in has a write_flags field

/**
 * WRITE flags
 *
 * FUSE_WRITE_CACHE: delayed write from page cache, file handle is guessed
 * FUSE_WRITE_LOCKOWNER: lock_owner field is valid
 * FUSE_WRITE_KILL_SUIDGID: kill suid and sgid bits
 */
#define FUSE_WRITE_CACHE	(1 << 0)
#define FUSE_WRITE_LOCKOWNER	(1 << 1)
#define FUSE_WRITE_KILL_SUIDGID (1 << 2)


I guess we could extend that and add flag that more pages are available
and will come in the next request - would avoid guessing and timeout on
the daemon/server side.
With uring that would be helpful as well, but then with uring one can
just look through available CQEs and see if these belong together. I
don't think there is much control right now on the kernel side to submit
multiple requests together but even without that I had seen consecutive
requests in a CQE completion round.


Bernd

