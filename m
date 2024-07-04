Return-Path: <linux-fsdevel+bounces-23144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8F927A74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16CD7B24E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEF1B012A;
	Thu,  4 Jul 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HRIVMEEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6aymbh9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DE1BC23
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108182; cv=none; b=qZm+StJG/4F6yuy283EfUfMb78rOagnOW040Mf+Tvd3YFjmTGNlUOxYhCVdc10ljrvhNwzDXMJghLRhLqkhFdvXoSGyvYdkTbBlroKCjHrwcKnnFCX4xcEpdB6DUvmhLyefcbFR4trIiSxbObXwnCSctb3iAeJ7U3e4vH5x1Ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108182; c=relaxed/simple;
	bh=4vH+xEGII3O6B3xkPhpQr49+18hcWiT3D8tgwBcrThU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4MyPP854zT/QX7yQxMkRUxTWn6pCVkDqh3XQQyiTF8PpGb3vyHeeiRHhay1RFFHYEfI2ZbYGnbFLLnrBFGZxYXSGkfCkJF75+3auuPY+Al6OMzMoY/6N3YnzxjdZbSpr5s5mC95Nhrta+XhpfmDL/dqx8F6Jx8HV2B6IJ7lY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HRIVMEEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6aymbh9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8D5F11380292;
	Thu,  4 Jul 2024 11:49:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Jul 2024 11:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720108179;
	 x=1720194579; bh=6x9Wa88xtgBi1HIek1vtrocK/3lOv/Tq4sSviJFVrZI=; b=
	HRIVMEEc1Tf46MIYiNN4t7/rTQa8pDlx2kpU5RP8rntH62Iia0pqhJ9iJMMVPVx8
	3Uu0HwOO6YOhiIqEFC5kux1q91k3wa0rBY6ijT1E5BLZJdlSHad1JwVPTnlvmz60
	Ek+Qz9wSbFrf8yH7+QuHnGCZmbp2LIZWyTUdkATn13vJ800TEuGPNowZfL9RU2av
	VyRKPw5hbLtZiUbJnpizOQo64FEjYPOoghmkOKY2YT1FhjDf9bHMDiFVxM0eJe3d
	BXltdGO3tTBRg9OP+ejZvg+TKJd0T4jfvLAPuIgmE0LGrarGPaPbJDct1XlqrmT+
	4knC0aSEEgQBFQGKnjxTzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720108179; x=
	1720194579; bh=6x9Wa88xtgBi1HIek1vtrocK/3lOv/Tq4sSviJFVrZI=; b=Y
	6aymbh9t1D8JSwzHz5bOzjptyqo7ZrGwZDzerVNdZMvgXoTz4dOKXfAQyyo8gJcS
	2x9+0J3uZHq1XPrFM5wvdfCyIbtvgILRlNYGePGXE7U+jODidOx9lgs4jycbAYy3
	+ipI+dkZtxkOEg0it6aQgg+By/wLxHPDx6JJupAXTuKf+kHMIgIM8sfuv7eT81wj
	CGRoIR49j6TMhfTjUE7c/+LFQyg2y9Ev3o0RZJNgBQs+J56JwnEzVRRk5L/QfVhI
	f4CrBayFTMUf9GRPvBaxM4SNJBW+JFWIR2RpbkYOIDQsjtwnXrU5DZkxgMfXX6Ku
	e+if4PZTlOIPS7gSkLQRA==
X-ME-Sender: <xms:k8SGZpr7Dsg87_X_7NRMLbSnlGdgHolRa_BT_yoDn6DchhXgHu2KLg>
    <xme:k8SGZrqYW2qU351jorwQAUZYme8Zoo9Yu9W0CVmDa0PGto6ogNh8mvekj2wATBtpZ
    VxtOjwY2Xn3wJuM>
X-ME-Received: <xmr:k8SGZmN7D6MgRYWjvb_LP_gMxt80twDidc83DJ1Ghy9GBW0FBVb87f61566_zb9fNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeeutdekieelgeehudekgffhtdduvddugfehleej
    jeegleeuffeukeehfeehffevleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:k8SGZk7nmTR5dfBdb0OwuPNBlRL2kYl-1CphzC4L_xOdHMijCZ0sGA>
    <xmx:k8SGZo5Ug8egGcinHEwNfFkCoNWofLCPT1VuKFB68c8L2iCvEMe59Q>
    <xmx:k8SGZsgwsYhgWB3P1huAnoT7ybICnuh3dah6DkGzt9K_w4gay02zZw>
    <xmx:k8SGZq4GQ0A_-N8lC2_7swe4Cu1jX8bxwjiO5HuxIdVRqPshK2FtDQ>
    <xmx:k8SGZiQXDMDtQdVUHRyGXw0Uy7ImAqxYsOa7rxuv6npunpiZUSoUdloV>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jul 2024 11:49:38 -0400 (EDT)
Message-ID: <d28e579f-fdb8-4de6-b615-f4f80faa72d1@fastmail.fm>
Date: Thu, 4 Jul 2024 17:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Allow to align reads/writes
To: Josef Bacik <josef@toxicpanda.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert
 <bschubert@ddn.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20240702163108.616342-1-bschubert@ddn.com>
 <20240703151549.GC734942@perftesting>
 <e6a58319-e6b1-40dc-81b8-11bd3641a9ca@fastmail.fm>
 <20240703173017.GB736953@perftesting>
 <CAJnrk1bYf85ipt2Hf1id-OBOzaASOeegOxnn3vGtUxYHNp3xHg@mail.gmail.com>
 <03aba951-1cab-4a40-a980-6ac3d52b2c91@ddn.com>
 <CAJnrk1a2_qDkEYSCCSOf-jpumLZv5neAgSwW6XGA__eTjBfBCw@mail.gmail.com>
 <65af4ae5-b8c8-4145-af2d-f722e50d68de@fastmail.fm>
 <20240704151047.GB865828@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <20240704151047.GB865828@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/4/24 17:10, Josef Bacik wrote:
> On Wed, Jul 03, 2024 at 10:44:28PM +0200, Bernd Schubert wrote:
>>
>>
>> On 7/3/24 22:28, Joanne Koong wrote:
>>> On Wed, Jul 3, 2024 at 11:08 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> On 7/3/24 19:49, Joanne Koong wrote:
>>>>> On Wed, Jul 3, 2024 at 10:30 AM Josef Bacik <josef@toxicpanda.com> wrote:
>>>>>>
>>>>>> On Wed, Jul 03, 2024 at 05:58:20PM +0200, Bernd Schubert wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 7/3/24 17:15, Josef Bacik wrote:
>>>>>>>> On Tue, Jul 02, 2024 at 06:31:08PM +0200, Bernd Schubert wrote:
>>>>>>>>> Read/writes IOs should be page aligned as fuse server
>>>>>>>>> might need to copy data to another buffer otherwise in
>>>>>>>>> order to fulfill network or device storage requirements.
>>>>>>>>>
>>>>>>>>> Simple reproducer is with libfuse, example/passthrough*
>>>>>>>>> and opening a file with O_DIRECT - without this change
>>>>>>>>> writing to that file failed with -EINVAL if the underlying
>>>>>>>>> file system was using ext4 (for passthrough_hp the
>>>>>>>>> 'passthrough' feature has to be disabled).
>>>>>>>>>
>>>>>>>>> Given this needs server side changes as new feature flag is
>>>>>>>>> introduced.
>>>>>>>>>
>>>>>>>>> Disadvantage of aligned writes is that server side needs
>>>>>>>>> needs another splice syscall (when splice is used) to seek
>>>>>>>>> over the unaligned area - i.e. syscall and memory copy overhead.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>  From implementation point of view 'struct fuse_in_arg' /
>>>>>>>>> 'struct fuse_arg' gets another parameter 'align_size', which has to
>>>>>>>>> be set by fuse_write_args_fill. For all other fuse operations this
>>>>>>>>> parameter has to be 0, which is guranteed by the existing
>>>>>>>>> initialization via FUSE_ARGS and C99 style
>>>>>>>>> initialization { .size = 0, .value = NULL }, i.e. other members are
>>>>>>>>> zero.
>>>>>>>>> Another choice would have been to extend fuse_write_in to
>>>>>>>>> PAGE_SIZE - sizeof(fuse_in_header), but then would be an
>>>>>>>>> arch/PAGE_SIZE depending struct size and would also require
>>>>>>>>> lots of stack usage.
>>>>>>>>
>>>>>>>> Can I see the libfuse side of this?  I'm confused why we need the align_size at
>>>>>>>> all?  Is it enough to just say that this connection is aligned, negotiate what
>>>>>>>> the alignment is up front, and then avoid sending it along on every write?
>>>>>>>
>>>>>>> Sure, I had forgotten to post it
>>>>>>> https://github.com/bsbernd/libfuse/commit/89049d066efade047a72bcd1af8ad68061b11e7c
>>>>>>>
>>>>>>> We could also just act on fc->align_writes / FUSE_ALIGN_WRITES and always use
>>>>>>> sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) in libfuse and would
>>>>>>> avoid to send it inside of fuse_write_in. We still need to add it to struct fuse_in_arg,
>>>>>>> unless you want to check the request type within fuse_copy_args().
>>>>>>
>>>>>> I think I like this approach better, at the very least it allows us to use the
>>>>>> padding for other silly things in the future.
>>>>>>
>>>>>
>>>>> This approach seems cleaner to me as well.
>>>>> I also like the idea of having callers pass in whether alignment
>>>>> should be done or not to fuse_copy_args() instead of adding
>>>>> "align_writes" to struct fuse_in_arg.
>>>>
>>>> There is no caller for FUSE_WRITE for fuse_copy_args(), but it is called
>>>> from fuse_dev_do_read for all request types. I'm going to add in request
>>>> parsing within fuse_copy_args, I can't decide myself which of both
>>>> versions I like less.
>>>
>>> Sorry I should have clarified better :) By callers, I meant callers to
>>> fuse_copy_args(). I'm still getting up to speed with the fuse code but
>>> it looks like it gets called by both fuse_dev_do_read and
>>> fuse_dev_do_write (through copy_out_args() -> fuse_copy_args()). The
>>> cleanest solution to me seems like to pass in from those callers
>>> whether the request should be page-aligned after the headers or not,
>>> instead of doing the request parsing within fuse_copy_args() itself. I
>>> think if we do the request parsing within fuse_copy_args() then we
>>> would also need to have some way to differentiate between FUSE_WRITE
>>> requests from the dev_do_read vs dev_do_write side (since, as I
>>> understand it, writes only needs to be aligned for dev_do_read write
>>> requests).
>>
>> fuse_dev_do_write() is used to submit results from fuse server
>> (userspace), i.e. not interesting here. If we don't parse in
>> fuse_copy_args(), we would have to do that in fuse_dev_do_read() - it
>> doesn't have knowledge about the request it handles either - it just
>> takes from lists what is there. So if we don't want to have it encoded
>> in fuse_in_arg, there has to request type checking. Given the existing
>> number of conditions in fuse_dev_do_read, I would like to avoid adding
>> in even more there.
>>
> 
> Your original alternative I think is better, leave it in fuse_in_arg and take it
> out of the write arg.  Thanks,

Thank you! I'm going to send out a new version in one or two days. 
Currently I believe we don't need the actual alignment size at all and 
can just use:

fuse_copy_align()
cs->offset += cs->len;
cs->len = 0;

Because offset and len are for for the current page.

I need to ponder about it a bit, checking if there is any exception...


Thanks,
Bernd


