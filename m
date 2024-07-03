Return-Path: <linux-fsdevel+bounces-23075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729A9269B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 22:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C12B21AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905DA190469;
	Wed,  3 Jul 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Z4vjL+rV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBYbV2gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CC28379
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039474; cv=none; b=ksyQOeamTUvziskRN4pD+z3tK3vDJPRg8Li3z+/T6Yg1X8sAhp+rm4o7sGbhLLA1Frljnu+Gwr5RBgdZV9hpledi+Jzkfzn8nVhG2WSVgfsg8aM67PepOEz02Xihb93cP8kn28vCH85I3nWX3HsVWXvMGP3Zo2eLDIIv/44sFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039474; c=relaxed/simple;
	bh=l0/CIb+HitcwPtWnIpskhSL846b8eqsSliF/jn+6PtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyhJFnnWysKmtfJJkTlmudIey8qU5EP9lwOGp+g7wtv4jhuz5oRs9S1pCe2GyjN+rygixy9bw2Q/0QQeU+V4y1PoOK1B79cBuK4dNgegPjau8EH5cRIqD0wBE8srktDsk/D3uVSl+Si35DR3SAcvwaaSZUDeJ/91JRHtP2xMang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Z4vjL+rV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBYbV2gr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7AAD01380459;
	Wed,  3 Jul 2024 16:44:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jul 2024 16:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720039471;
	 x=1720125871; bh=k5LN5VJag3bLTKZSV0yKh0YZ61en/zk2sNX1yxHq+aI=; b=
	Z4vjL+rVTWUo1eDl2Ompg/89xngw2bK/p/BeppuZli7IX93BaBvEILi0Gwa9PU+l
	eMPXNQRPxaA+W1UiNlbTuXoxbQ+aeOEJBIrB8ayK/MFDDSgUBHDjN+KJmLNLC3Uq
	MBqQRqOUdnvkn9wCzPeL3FfnTQMOhNWeno0gmJSWRHqSSo8+ZToElc6luit61hyn
	S7Z8zlHLQLxD0w7s2NOTuPlJCYDHi5S1evz81mxWoaFgHvd5L5pcK+FdJ/vMnQ22
	WIJLMJyF2UnIz34CfM3TgvHkywxLG9Z+/3aUcsiLFeEoZDu1XqXt23xCgZtrU7Ac
	LH8dRcRLLp1ttXeWMt+ksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720039471; x=
	1720125871; bh=k5LN5VJag3bLTKZSV0yKh0YZ61en/zk2sNX1yxHq+aI=; b=j
	BYbV2grgNeHGvt+XjKSr6oZVyFdtO8W+vPGXAMPf30Pig3NVonPRDRBZFIWjIvMq
	sRRl/rtbp21g6AFL3UY7KZeDD5D9wIHZd/5XEbksjEejuHfXr9jODQxDGGgHjJ3d
	T8IJd9kNoDIUd2+3njKk7bhNVvKzQ7KNn7briX7JWutEW3E4tfk95dbmILRrNJ57
	W+M47/NIgF+kEAUEBbe1uiG79fqTDcJ+mQ7obCwk8uLXhI6Kg5jhV4E4xgwOXFUA
	lFjsUNpDt583PZpMiMT/++2ECUFwcAp1vBspEL3j+NsdqMkxwBPNCFSLkovfdWfn
	Z5xPa++hIJ24U/h8lcf3g==
X-ME-Sender: <xms:L7iFZul9SHZdDcXOTTeV5xkUOB7-oDlO0_mGiD-qX5rxaEImoeYOfg>
    <xme:L7iFZl0Ov-aTry3WMkBO515pJ7sMRDcTCCzp4hyv8acWBovNugpV_wovRNSDASfY1
    IRb28DcqCtyPyNA>
X-ME-Received: <xmr:L7iFZsoDXcH2wgAg-sI8zOIkC-6kAXQhioSF1S3L3RvpAr08EFrUnGnHim94xxICmN7bt7Xitrf0Lwah4VyxEgCZzq_MRmKLPDQP2Run_jxvJUL2b0Dz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepuedtkeeileeghedukefghfdtuddvudfgheel
    jeejgeelueffueekheefheffveelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgu
    rdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:L7iFZimFHdWjwEK1REYp5tMVjYE_y-BkL9jBN8qG_C4X9MmfsHFLsg>
    <xmx:L7iFZs1MRM-blj4HK_VxqfZFsbtgdUEMaU-dlPjpmReWKZ6KYV8ZHQ>
    <xmx:L7iFZpt997BHiIHvmVLUxCv9qtgamD6Ewa_WYttTGYJg35idreHRsQ>
    <xmx:L7iFZoVOu1usKNFLY3m_dTQTe5utfGepfByxdN0S-cMVPKop5YO0Vw>
    <xmx:L7iFZg8-Z9mbmW8Fcme3kfijempRGgKJhehj8rKX0nmZYpPdOi52B_kV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 16:44:30 -0400 (EDT)
Message-ID: <65af4ae5-b8c8-4145-af2d-f722e50d68de@fastmail.fm>
Date: Wed, 3 Jul 2024 22:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Josef Bacik <josef@toxicpanda.com>, "miklos@szeredi.hu"
 <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
 <20240703173017.GB736953@perftesting>
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
 <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
 <CAJnrk1a2_qDkEYSCCSOf-jpumLZv5neAgSwW6XGA__eTjBfBCw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: fr
In-Reply-To: <CAJnrk1a2_qDkEYSCCSOf-jpumLZv5neAgSwW6XGA__eTjBfBCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/3/24 22:28, Joanne Koong wrote:
> On Wed, Jul 3, 2024 at 11:08 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 7/3/24 19:49, Joanne Koong wrote:
>>> On Wed, Jul 3, 2024 at 10:30 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>
>>>> On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
>>>>>
>>>>>
>>>>> On 7/3/24 17:15, Josef Bacik wrote:
>>>>>> On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
>>>>>>> Read/writes IOs should be page aligned as fuse server
>>>>>>> might need to copy data to another buffer otherwise in
>>>>>>> order to fulfill network or device storage requirements.
>>>>>>>
>>>>>>> Simple reproducer is with libfuse, example/passthrough*
>>>>>>> and opening a file with O_DIRECT - without this change
>>>>>>> writing to that file failed with -EINVAL if the underlying
>>>>>>> file system was using ext4 (for passthrough_hp the
>>>>>>> 'passthrough' feature has to be disabled).
>>>>>>>
>>>>>>> Given this needs server side changes as new feature flag is
>>>>>>> introduced.
>>>>>>>
>>>>>>> Disadvantage of aligned writes is that server side needs
>>>>>>> needs another splice syscall (when splice is used) to seek
>>>>>>> over the unaligned area - i.e. syscall and memory copy overhead.
>>>>>>>
>>>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>>>>>
>>>>>>> ---
>>>>>>> From implementation point of view 'struct fuse_in_arg' /
>>>>>>> 'struct fuse_arg' gets another parameter 'align_size', which has to
>>>>>>> be set by fuse_write_args_fill. For all other fuse operations this
>>>>>>> parameter has to be 0, which is guranteed by the existing
>>>>>>> initialization via FUSE_ARGS and C99 style
>>>>>>> initialization { .size = 0, .value = NULL }, i.e. other members are
>>>>>>> zero.
>>>>>>> Another choice would have been to extend fuse_write_in to
>>>>>>> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
>>>>>>> arch/PAGE_SIZE depending struct size and would also require
>>>>>>> lots of stack usage.
>>>>>>
>>>>>> Can I see the libfuse side of this?  I'm confused why we need the align_size at
>>>>>> all?  Is it enough to just say that this connection is aligned, negotiate what
>>>>>> the alignment is up front, and then avoid sending it along on every write?
>>>>>
>>>>> Sure, I had forgotten to post it
>>>>> https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad68061b11e7c
>>>>>
>>>>> We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and always use
>>>>> sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse and would
>>>>> avoid to send it inside of fuse_write_in. We still need to add it to struct fuse_in_arg,
>>>>> unless you want to check the request type within fuse_copy_args().
>>>>
>>>> I think I like this approach better, at the very least it allows us to use the
>>>> padding for other silly things in the future.
>>>>
>>>
>>> This approach seems cleaner to me as well.
>>> I also like the idea of having callers pass in whether alignment
>>> should be done or not to fuse_copy_args() instead of adding
>>> "align_writes" to struct fuse_in_arg.
>>
>> There is no caller for FUSE_WRITE for fuse_copy_args(), but it is called
>> from fuse_dev_do_read for all request types. I'm going to add in request
>> parsing within fuse_copy_args, I can't decide myself which of both
>> versions I like less.
> 
> Sorry I should have clarified better :) By callers, I meant callers to
> fuse_copy_args(). I'm still getting up to speed with the fuse code but
> it looks like it gets called by both fuse_dev_do_read and
> fuse_dev_do_write (through copy_out_args() -> fuse_copy_args()). The
> cleanest solution to me seems like to pass in from those callers
> whether the request should be page-aligned after the headers or not,
> instead of doing the request parsing within fuse_copy_args() itself. I
> think if we do the request parsing within fuse_copy_args() then we
> would also need to have some way to differentiate between FUSE_WRITE
> requests from the dev_do_read vs dev_do_write side (since, as I
> understand it, writes only needs to be aligned for dev_do_read write
> requests).

fuse_dev_do_write() is used to submit results from fuse server
(userspace), i.e. not interesting here. If we don't parse in
fuse_copy_args(), we would have to do that in fuse_dev_do_read() - it
doesn't have knowledge about the request it handles either - it just
takes from lists what is there. So if we don't want to have it encoded
in fuse_in_arg, there has to request type checking. Given the existing
number of conditions in fuse_dev_do_read, I would like to avoid adding
in even more there.


Thanks,
Bernd

