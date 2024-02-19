Return-Path: <linux-fsdevel+bounces-12066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA6285AFBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AEEB2845BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362C56757;
	Mon, 19 Feb 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="A/UWKMKO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nxdeca9t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124B54F94
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384953; cv=none; b=k5birYZ0xW2ojrDqydEAxxrMju2HzT4ITD8uvZVT5esZ+fnJlQc9LdjDiQXG7BZrpRZFwSbsTR7Zcc+GI1n2eC8h+uKNWnm3PAHqnVdqiML+fjnD1Wbg1PlxNqRk8ApnS7dGLI10dcsXS/IsxEQ+4Hhy5dyD9SYhrAtIlhxeDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384953; c=relaxed/simple;
	bh=tsrk0wq0FxaFnkL9RZWU40hQu9UjwON1DnIg79P83YU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iJCPtg2pvAzhOmEy+6ThEvTk0mjq6VuiAGt9eeIlzY3H4AxCtqfYEeI9GTu+lh8GJDVCZYRAXNRwVT56s4aZatoiDd4spq+N7U4Yg0T1WNMYCVHurS6WET+CiQ+MFCTWiwF8dA0SICPTNIyDuqZw2zJZg5wRanE6g5fMxyvg+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=A/UWKMKO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nxdeca9t; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 534131C00070;
	Mon, 19 Feb 2024 18:22:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Feb 2024 18:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708384948;
	 x=1708471348; bh=S17CsvAiJHs2PsjGZCH4jEHEMfNqGmsr5RV9RLbdyRw=; b=
	A/UWKMKOdBhvGjjcXd5MdLhwcB66rJaubXVe+swYgjKofvIYfh0MZUbeWwlUT+Di
	JHz70YwH3/NpjAoF3I5nPw28yHX3ueHIYiSrH/tqSWgoQLqIzjKx2kDwS06rApGl
	UD+6nP9EmB/c4SZNNNMunqe990nNFFGRVpDZYDz0qSXrXmivWO+ykr27tIC5jvfg
	jmSXJnvXTGdRBl+W8awQLYmBMM3tMK3KBqQ4DzOoNu5O5VI4oZzAY98CUJww033c
	tstxTkppAwVUOEQhMfOPTZFteSdO3pKRSxAMvBDxD3cShy14qWuBubRSzcjk4lP2
	3Kib+YScDXbDDUPJkFjw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708384948; x=
	1708471348; bh=S17CsvAiJHs2PsjGZCH4jEHEMfNqGmsr5RV9RLbdyRw=; b=N
	xdeca9tIHeF0Ty44gj4hfa1bJ2m7eTa1OewzSAiaYmK7nLO7sxLfb2G3NpGOPXsr
	b22jqLzsLsK2SdAyRXiVdsIgG9ZuGCEBsLhYcGoHkqvphPDcNfA/QYqoYzCI8WDI
	1ymu0bhIfcCtZQazoBm9TzN8E2a1WgIdO+UQ0m6d0nIz1LQJzorphaphXlwulGOn
	lgp6gAiHE0e4xN4Gqf5Cu2gZ5Uz8c0DJDeGhc6qPeJWEfVtV5HJYiDtPKxAxC38k
	iaueSFc9mAmY81cqJ6XmFBPcqnlvMFocU7kH1syLrMaZ8FuE2u8y9H0GEYyH7HLx
	mxyKYOAuw2bFNi0VdFRPQ==
X-ME-Sender: <xms:tOLTZWFLdlUAzQG73aYC_rH9Uoajs6rloGXYFqtLyhHSHOeqWhzDTA>
    <xme:tOLTZXVaeY751oIfAL-flxB5vsxDC0rgpilg2p73IEZa6n6oKbL_hU2BrDTEn4iYI
    VGUxUKvLAXwx83z>
X-ME-Received: <xmr:tOLTZQL6LIL-Qy6ZdVfgWH-iT8zMbzJKdtcDq7BJoDHDP4fHx7bZR0HhdSG3v28yQOd3pxcpUy31KLy6rhiWu6snwmomjytOMFlMbxWd-Ap_TdELAO5y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuhffvvehfjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeeikeefvdeltefgffdvveefledvfeffgefhteeg
    geffudduheeiueetveeuudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:tOLTZQGrf1AXr_OetgMeHDoZyGok3LWFRAg5DwNxsSBjXdiFMcF3lg>
    <xmx:tOLTZcV5LrmlF8yvk6YlID522Aj2urYQ95cm0SlJwcWetCSlvgR7CQ>
    <xmx:tOLTZTNzszI3G2BhuzD-RmYOBQux3lpL31_IqJE5g8jhURzgmMcPuA>
    <xmx:tOLTZWf8L70H9s_c6GUgAqVWVF5Lizkd6qf0XzzkFJ6IPiN9QtnMEzlNu44>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 18:22:27 -0500 (EST)
Message-ID: <4341aed4-3a68-482f-b785-40cbe6031e7e@fastmail.fm>
Date: Tue, 20 Feb 2024 00:22:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
 Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 fuse-devel <fuse-devel@lists.sourceforge.net>
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link>
 <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <8fd58ae6-164c-4653-a979-b12ee577fe65@fastmail.fm>
 <CAJfpegvgwZsoFpEUnqPkAXCST3bZYgWNy4NXKHOfnWQic_yvHw@mail.gmail.com>
 <0aec3014-ba3a-48d3-840a-4f61ff4d6f60@fastmail.fm>
In-Reply-To: <0aec3014-ba3a-48d3-840a-4f61ff4d6f60@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/24 22:14, Bernd Schubert wrote:
> 
> 
> On 2/19/24 20:58, Miklos Szeredi wrote:
>> On Mon, 19 Feb 2024 at 20:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>
>>>
>>>
>>> On 2/19/24 20:38, Miklos Szeredi wrote:
>>>> On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>>>>
>>>>> This is what I see from the kernel:
>>>>>
>>>>> lookup(nodeid=3, name=.);
>>>>> lookup(nodeid=3, name=..);
>>>>> lookup(nodeid=1, name=dir2);
>>>>> lookup(nodeid=1, name=..);
>>>>> forget(nodeid=3);
>>>>> forget(nodeid=1);
>>>>
>>>> This is really weird.  It's a kernel bug, no arguments, because kernel
>>>> should never send a forget against the root inode.   But that
>>>> lookup(nodeid=1, name=..); already looks bogus.
>>>
>>> Why exactly bogus?
>>>
>>> reconnect_path()
>>>                 if (IS_ROOT(dentry))
>>>                         parent = reconnect_one(mnt, dentry, nbuf);
>>
>> It's only getting this far if (dentry->d_flags & DCACHE_DISCONNECTED),
>> but that doesn't make sense on the root dentry.  It does happen,
>> though, I'm just not seeing yet how.
> 
> I see the BUG_ON(), but on the other the "if IS_ROOT(dentry)" condition
> triggers.

Oh I see, IS_ROOT() triggers if parent is not known yet.

