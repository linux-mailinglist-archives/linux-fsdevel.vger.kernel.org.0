Return-Path: <linux-fsdevel+bounces-67216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99486C38238
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1851318C80CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC02EE5FE;
	Wed,  5 Nov 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="3njmQrny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WRO9tFQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22221CC6A;
	Wed,  5 Nov 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380377; cv=none; b=Kc2Ejg+VU3iDSkdmnvnvR5VOsPCcK9E1p55je6Kmi7xWRvCIeE1XZEctA6DahFcLVYvG+W1a696/yX0SMOsgeoQN6bJ8OHHHsSoWtlAogLz25Q5Zm0G61iCKjMdwDHpq8gLABtqfp7AnoHczgIGyrvGafkJYDaQPyLIgR820bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380377; c=relaxed/simple;
	bh=DzQh4kxg/4ygyLP3ZVccFl3kjnSCQtYKQw4Js/JV5jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHR/AB/buHiW+6BpwKDaGmuGAQEGK1H8HFpdWT4RygeYGhxw0z6yT1P1/mX14nYy1U9Yll9xTzp5MoAXtzYfxZMQKYCoB//QRe6GUpHW1OnjYQ8MuVv1jJDvX+EZC2N35NwuG6xkA6v9CaBfyo6GGi1w1TK3gH7yhAKgK+/z3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=3njmQrny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WRO9tFQP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6BE7140017A;
	Wed,  5 Nov 2025 17:06:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 17:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1762380372;
	 x=1762466772; bh=v+Aj5i40+XHx8nMoLGrv2roa2VgMjDCHFpJIsN+G8gg=; b=
	3njmQrnyOM8vqtgatf92767AIQ1ydfzpuToHrnDLirDdl8uGonJpTrw5jr5Yzrdm
	7yUh+kE2zbIh0RkM0Z+YMrtNcLFuLRPChYvkUSCD1tEx7T/zQCU0kfgnqBXmWL21
	qtKoX0APsOYAfKMs4T1pvRBIVO0PLPLAAmm+94T5/onuELe5csZWqTQP5Ljv8kf8
	7N3aEs14VcWB6iUSpc164npbK9yCAN6NcL/UjPTYLH9diw7H6Nqk4XFc3yNazIVT
	8lCipKLwE+AGIhpTyZFg8qXCcjtAi3LVtUqg12qX0/zRKfz8Ec1U6FibZyIp8qFS
	so/ivflvS5yWIDrDQLhuUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762380372; x=
	1762466772; bh=v+Aj5i40+XHx8nMoLGrv2roa2VgMjDCHFpJIsN+G8gg=; b=W
	RO9tFQPl71wnYQC4PpicXSPuk4iu+nFg47EBgskYxna74OKbdM60uy7PXZhwRYRK
	bmcKOFxpg76OpzEcziowdKbM0NxWvUpgC9v3cQ6pjUU5wVI4Y/RfvhZ7FgU1cuGp
	OmQM7goF+GPaBL45M6kxVwJVFUsJ+BIyCrfPLHkrn7Wqkqqt46qvPeKJaVxIWe7/
	GkGSLf+ufs8RKVYZAVbDCVNrJCf+Ph/3g7piFIJDOTLjn6/Vp+ydvc2EsqU3Udp1
	1UQTbGnquqMfjZ4kWrzSyUqA7hTzN7qAg5Mb81cAAr+/wkfP4wk4WU1y+4DR60z1
	ouBvLwlNTkTnhpT8RpEeg==
X-ME-Sender: <xms:VMoLaSEFvMPdtZUiPnYrTW9B-olCuwpAQkHSbSbqF8y9gt5LFXkRlg>
    <xme:VMoLaWbWiswKj3_4PqxNftWtcYpeC7D_Pf9sC3O7VZRmUqK663Z9Ds75dhA4V4lUg
    IIKa11-vcWqwz5MKQqaRSD3CYTlTOn_yZYADY8Mk01RpG007QsReQ>
X-ME-Received: <xmr:VMoLaWzF4kmnURSfqK-IQxgtyJgaLW-jo2Dv7yIZgvEJDgQ9ir9QxpfUTpDvq475jkhToH-qaPpkJqoRjxlzfj9IS-6LXsSvw7NAG31i8SZmKYdLP7qn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprh
    gtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhr
    jeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtg
    homhdprhgtphhtthhopehthihtshhosehmihhtrdgvughupdhrtghpthhtohepmhhikhhl
    ohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgthhgvnhesuggunhdrtg
    homh
X-ME-Proxy: <xmx:VMoLaYSOf7MLucSIjm6_P9FlfIgXvmnlcTul1D2onfMtkFQHhqYtbw>
    <xmx:VMoLaTKvynQzflbKST642-rNkjG_-T_iqEvdex0-NHS2fmENfSMEmw>
    <xmx:VMoLafWUPXSXhqFM9IDvw-oUnaqVnxZJqNTeTKqKxqfANe6J2B_I5w>
    <xmx:VMoLaXRMYyNv8yKK8Yi8g4KZu1rWxV8nUTl5pWqW6qwW4RzCvu1c9Q>
    <xmx:VMoLaQc1Y53Skwb_V-ilLISMlUZTyHeq5ljwSRh1-54_5f0VOL0aVzP4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 17:06:11 -0500 (EST)
Message-ID: <ed5084e4-af1c-4185-b66f-2b42d56d37a3@bsbernd.com>
Date: Wed, 5 Nov 2025 23:06:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: Bernd Schubert <bschubert@ddn.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>,
 Matt Harvey <mharvey@jumptrading.com>
References: <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <87cy5x7sud.fsf@wotan.olymp>
 <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
 <87ecqcpujw.fsf@wotan.olymp>
 <CAOQ4uxg+w5LHnVbYGLc_pq+zfAw5UXbfo0M2=dxFGKLmBvJ+5Q@mail.gmail.com>
 <20251105213855.GL196362@frogsfrogsfrogs>
 <cb7c4237-74b4-4220-90f7-caf59d673bc4@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <cb7c4237-74b4-4220-90f7-caf59d673bc4@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/5/25 22:46, Bernd Schubert wrote:
> 
> 
> On 11/5/25 22:38, Darrick J. Wong wrote:
>> On Wed, Nov 05, 2025 at 04:30:51PM +0100, Amir Goldstein wrote:
>>> On Wed, Nov 5, 2025 at 12:50 PM Luis Henriques <luis@igalia.com> wrote:
>>>>
>>>> Hi Amir,
>>>>
>>>> On Wed, Nov 05 2025, Amir Goldstein wrote:
>>>>
>>>>> On Tue, Nov 4, 2025 at 3:52 PM Luis Henriques <luis@igalia.com> wrote:
>>>>
>>>> <...>
>>>>
>>>>>>> fuse_entry_out was extended once and fuse_reply_entry()
>>>>>>> sends the size of the struct.
>>>>>>
>>>>>> So, if I'm understanding you correctly, you're suggesting to extend
>>>>>> fuse_entry_out to add the new handle (a 'size' field + the actual handle).
>>>>>
>>>>> Well it depends...
>>>>>
>>>>> There are several ways to do it.
>>>>> I would really like to get Miklos and Bernd's opinion on the preferred way.
>>>>
>>>> Sure, all feedback is welcome!
>>>>
>>>>> So far, it looks like the client determines the size of the output args.
>>>>>
>>>>> If we want the server to be able to write a different file handle size
>>>>> per inode that's going to be a bigger challenge.
>>>>>
>>>>> I think it's plenty enough if server and client negotiate a max file handle
>>>>> size and then the client always reserves enough space in the output
>>>>> args buffer.
>>>>>
>>>>> One more thing to ask is what is "the actual handle".
>>>>> If "the actual handle" is the variable sized struct file_handle then
>>>>> the size is already available in the file handle header.
>>>>
>>>> Actually, this is exactly what I was trying to mimic for my initial
>>>> attempt.  However, I was not going to do any size negotiation but instead
>>>> define a maximum size for the handle.  See below.
>>>>
>>>>> If it is not, then I think some sort of type or version of the file handles
>>>>> encoding should be negotiated beyond the max handle size.
>>>>
>>>> In my initial stab at this I was going to take a very simple approach and
>>>> hard-code a maximum size for the handle.  This would have the advantage of
>>>> allowing the server to use different sizes for different inodes (though
>>>> I'm not sure how useful that would be in practice).  So, in summary, I
>>>> would define the new handle like this:
>>>>
>>>> /* Same value as MAX_HANDLE_SZ */
>>>> #define FUSE_MAX_HANDLE_SZ 128
>>>>
>>>> struct fuse_file_handle {
>>>>         uint32_t        size;
>>>>         uint32_t        padding;
>>>
>>> I think that the handle type is going to be relevant as well.
>>>
>>>>         char            handle[FUSE_MAX_HANDLE_SZ];
>>>> };
>>>>
>>>> and this struct would be included in fuse_entry_out.
>>>>
>>>> There's probably a problem with having this (big) fixed size increase to
>>>> fuse_entry_out, but maybe that could be fixed once I have all the other
>>>> details sorted out.  Hopefully I'm not oversimplifying the problem,
>>>> skipping the need for negotiating a handle size.
>>>>
>>>
>>> Maybe this fixed size is reasonable for the first version of FUSE protocol
>>> as long as this overhead is NOT added if the server does not opt-in for the
>>> feature.
>>>
>>> IOW, allow the server to negotiate FUSE_MAX_HANDLE_SZ or 0,
>>> but keep the negotiation protocol extendable to another value later on.
>>>
>>>>>> That's probably a good idea.  I was working towards having the
>>>>>> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
>>>>>> include:
>>>>>>
>>>>>>  - An extra inarg: the parent directory handle.  (To be honest, I'm not
>>>>>>    really sure this would be needed.)
>>>>>
>>>>> Yes, I think you need extra inarg.
>>>>> Why would it not be needed?
>>>>> The problem is that you cannot know if the parent node id in the lookup
>>>>> command is stale after server restart.
>>>>
>>>> Ah, of course.  Hence the need for this extra inarg.
>>>>
>>>>> The thing is that the kernel fuse inode will need to store the file handle,
>>>>> much the same as an NFS client stores the file handle provided by the
>>>>> NFS server.
>>>>>
>>>>> FYI, fanotify has an optimized way to store file handles in
>>>>> struct fanotify_fid_event - small file handles are stored inline
>>>>> and larger file handles can use an external buffer.
>>>>>
>>>>> But fuse does not need to support any size of file handles.
>>>>> For first version we could definitely simplify things by limiting the size
>>>>> of supported file handles, because server and client need to negotiate
>>>>> the max file handle size anyway.
>>>>
>>>> I'll definitely need to have a look at how fanotify does that.  But I
>>>> guess that if my simplistic approach with a static array is acceptable for
>>>> now, I'll stick with it for the initial attempt to implement this, and
>>>> eventually revisit it later to do something more clever.
>>>>
>>>
>>> What you proposed is the extension of fuse_entry_out for fuse
>>> protocol.
>>>
>>> My reference to fanotify_fid_event is meant to explain how to encode
>>> a file handle in fuse_inode in cache, because the fuse_inode_cachep
>>> cannot have variable sized inodes and in most of the cases, a short
>>> inline file handle should be enough.
>>>
>>> Therefore, if you limit the support in the first version to something like
>>> FANOTIFY_INLINE_FH_LEN, you can always store the file handle
>>> in fuse_inode and postpone support for bigger file handles to later.
>>
>> I suggest that you also provide a way for the fuse server to tell the
>> kernel that it can construct its own handles from {fuse_inode::nodeid,
>> inode::i_generation} if they want something more efficient than
>> uploading 128b blobs.
> 
> Isn't that covered by handle size defined in FUSE_INIT reply? I.e.
> handle size would be 0B in this case? 

Sorry my fault, yeah, this needs a special flag.

