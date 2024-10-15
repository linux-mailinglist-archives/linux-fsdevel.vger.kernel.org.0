Return-Path: <linux-fsdevel+bounces-32028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB299F607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE351C20A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196251B6CEE;
	Tue, 15 Oct 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="LEN1CdK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoSoNW77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756D20370F;
	Tue, 15 Oct 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018245; cv=none; b=iLU+nQju4Fz21iXfZlIByVB7B54bg7KLqE8PXVgNqyHSL9NMdVLA66wxCJMv/J7ZVsVuifNrX9/HxuHGE0WKkXT+ULg2/ObYIlYQ4HazRFJIennj+UxL3ysKf8bvWDzsj5PCSvxud8PGgEt4hzZQ28td2jIRx4T7JYFJy0sWW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018245; c=relaxed/simple;
	bh=bvS+d+mzsX/e+OeWng1r7+WDCtvvpwqft88GOX+IR5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ML0m1T31wHpmU274EM403RwTqEAB/Rx4JXgZmaQVGEQ3OlnhHpd2WHxR/diDf4MRemjcjLuhvdr3KgOGNddhdzfEreitD3QP2V3XKGQbeLvpENUQW91ZTlW63XVU7arhYXWP1zQLYa8tiF0nuPUhrxmNuYMupzoMeg1yqAFw5g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=LEN1CdK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoSoNW77; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD84D1140196;
	Tue, 15 Oct 2024 14:50:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Oct 2024 14:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729018242;
	 x=1729104642; bh=rw/wOUJB4u9XmB8hYuCI+/JCDumTEPnWgFre56JTot4=; b=
	LEN1CdK3zqAl6H891bIKprvY36vRHbrabKaedDDgs1UsK0hwzFnSZZI50FxdaXwj
	QqejxkQrecFGfDYvfhKOaXUyOzvXgZDvHYnrjL/nvHCBtqRBTbXyTbTbyQ/uNbav
	sKZDnn5zYuWD537CMFcgC5iMy9coclogcjEbSPyXIL5ME4YUKmWLTQDk5WiQOcHf
	g8/5nxFUajcL/GGftKvkOhg8Ht3J24PDw+uKM4q4e7DdpZNc0+Qa1XIRo9EvrXzc
	imOg4GULAWu9pGscfPsKM8SLJnoLIri83xKoBEQpqnbPdCzsEA5ZYBQtzyL/a7A9
	acJbIJv1h4qpRoib3UmsYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729018242; x=
	1729104642; bh=rw/wOUJB4u9XmB8hYuCI+/JCDumTEPnWgFre56JTot4=; b=V
	oSoNW77iWqvlE0TZdpxMORuPA/FfYoKIaKl1prRx6Dl6AfW087QhEZkC/pu6vnMr
	WSortSOV/V990gEXVPn7I7hw1mqi1xuiuY8PFgNUPX3+eeXFdvSqNwmXnayl7UKp
	/WycL0r+hp/WrQ/MZDMaXHtvwPjHLv70WIo/D9Msqz28UnWENi2mLirRpvfbTy8V
	B8oJ5aOMp/QflIy94bGZuyjiO0QdXmC5QYLEx4EJaLoGFtdt3A11mMs9lsvQ7dd1
	6DNY2Cch1gvW6f3Hk5A2VpfyHkKL6/toErOBNQQyWcmgnelMOBImP1A52skk5oCs
	BeVoKdw2RHDMMLXV6GBHA==
X-ME-Sender: <xms:grkOZ_Tx-x7KYVJF8K8dr-Zc4EY7YgcTRu7mLuwkT63keEKeXzENRQ>
    <xme:grkOZwxZjXm8pmfReUJOi7mnBaTow3kBIglfxrDDKcliunkzdBvNHiAb7j0QizYQi
    Rm5eAlmllOP-Fj6IA>
X-ME-Received: <xmr:grkOZ00KoDXfFJx7q-RVE6M02svOrb3V1kv7046hKXnl_3t8cgViTpSO-BpZ5YvbLSUequullayWj7ZmyoPX-PpLatKmsPHJzBtE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqne
    cuggftrfgrthhtvghrnhepfefguefgtdeghfeuieduffejhfevueehueehkedvteefgfeh
    hedtffdutdfgudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepudehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtoheprg
    hlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgr
    rhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:grkOZ_D8RCgH8A2_oBfRgG9WgtpVB37tonzwNsE5vN2WXtsX9iZ8TA>
    <xmx:grkOZ4gWI6r-kwgnf2ZMRrYdpCMkPsYdtM53gSSGRwyoPj3dlokLVA>
    <xmx:grkOZzpkdS29jXiXgTYzXW4HVHu4BMjh0u5ZUlW1EQiSWxD2zcyhQA>
    <xmx:grkOZzhaHfczW_lvKN5RhmRYYbWY2HaeaRVz64UpE1sWuI6nDOav4A>
    <xmx:grkOZ0zLSwl_aYzVMJKfbG14HlIK_Njlmg84uFE_b9Ye7HPJ8m68M1T1>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:50:39 -0400 (EDT)
Message-ID: <54f1e546-1fe0-40f7-87e6-109006b762a6@ryhl.io>
Date: Tue, 15 Oct 2024 20:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: task: adjust safety comments in Task methods
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Christian Brauner
 <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015-task-safety-cmnts-v1-1-46ee92c82768@google.com>
 <Zw6zZ00LOa1fkTTF@boqun-archlinux>
 <23a73a6f-160d-4d06-8d45-ec77293ff258@ryhl.io>
 <Zw64XYHtjGmbnfTO@boqun-archlinux>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <Zw64XYHtjGmbnfTO@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 8:45 PM, Boqun Feng wrote:
> On Tue, Oct 15, 2024 at 08:37:36PM +0200, Alice Ryhl wrote:
>> On 10/15/24 8:24 PM, Boqun Feng wrote:
>>> On Tue, Oct 15, 2024 at 02:02:12PM +0000, Alice Ryhl wrote:
>>>> The `Task` struct has several safety comments that aren't so great. For
>>>> example, the reason that it's okay to read the `pid` is that the field
>>>> is immutable, so there is no data race, which is not what the safety
>>>> comment says.
>>>>
>>>> Thus, improve the safety comments. Also add an `as_ptr` helper. This
>>>> makes it easier to read the various accessors on Task, as `self.0` may
>>>> be confusing syntax for new Rust users.
>>>>
>>>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>>> ---
>>>> This is based on top of vfs.rust.file as the file series adds some new
>>>> task methods. Christian, can you take this through that tree?
>>>> ---
>>>>    rust/kernel/task.rs | 43 ++++++++++++++++++++++++-------------------
>>>>    1 file changed, 24 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
>>>> index 1a36a9f19368..080599075875 100644
>>>> --- a/rust/kernel/task.rs
>>>> +++ b/rust/kernel/task.rs
>>>> @@ -145,11 +145,17 @@ fn deref(&self) -> &Self::Target {
>>>>            }
>>>>        }
>>>> +    /// Returns a raw pointer to the task.
>>>> +    #[inline]
>>>> +    pub fn as_ptr(&self) -> *mut bindings::task_struct {
>>>
>>> FWIW, I think the name convention is `as_raw()` for a wrapper type of
>>> `Opaque<T>` to return `*mut T`, e.g. `kernel::device::Device`.
>>>
>>> Otherwise this looks good to me.
>> Both names are in use. See e.g. Page and File that use as_ptr.
>>
> 
> `Page` is a different case because it currently is a pointer.
> 
>> In fact, I was asked to change the name on File *to* as_ptr.
>>
> 
> I'm not able to find the discussion on that ask. Appreciate it if you
> can share a link.

Hmm, it's possible that I misremember. I can't find it either. But it is 
called as_ptr on File.

> Anyway, this is not important for now, and might not be in the future.
> So:
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Alice

