Return-Path: <linux-fsdevel+bounces-25357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E794B27D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103651F21ADD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC7153801;
	Wed,  7 Aug 2024 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="A6u4GmoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B9o2A2BX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E577F1B;
	Wed,  7 Aug 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067828; cv=none; b=S182auXJ5gWYBFJ4RgeV0hkg1dxhu5b/pLA0YxyqkdndOd8iDxXSP4/FcCckO2Eur0+GEqXIv1m5HMoltBI90EfuySKzmZ/YSa589M5kH70VZDSt/x7hwKmZgJLt9fFFzDmr8/tZKWHwjX68HEyudDxPM7DO5ThdWj+nPoYfQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067828; c=relaxed/simple;
	bh=IXPJdU6pmr08+Nf1pc1cFAxF41ilQaCrPxISoF1pSP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okvN6VKZB8Rx91r1+vsvnTYrfJU1cPT6TAusonEmV/zObqX5Y6u5h40kubLYF8wPEREcAaG5aFLHf3eqi4WmgRl0ZWFhUDtIAozNRhCV4wBWW+PCwLfnETuAF+5gJN36yROUHrox2767IVSUevtKqh/C40epyBzt7aR7gSDzDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=A6u4GmoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B9o2A2BX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 00059114FFD9;
	Wed,  7 Aug 2024 17:57:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 07 Aug 2024 17:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723067824;
	 x=1723154224; bh=F1x0QI2mdpIAiCDsMu+p8sIP7cQyxdWc2/mkuJXriQc=; b=
	A6u4GmoC30M4hWD2ftm89wIZq2+xcWd6ASelvqEjrmPuKeBTrPPwGyICxNbJgqyM
	NzPWMIFbvTJvCDn4uobV/SP1zx16yM0uJum3k2qacfUo89OVyBYLGHRAhjEURWt7
	dT+uKupIbBC9QBw6Dl+Qf7vVo8NA9+MTHa44YGPlFka0oRPF+AEO6SP7NASTVXW0
	qU9+zxtFkWJt/3eGIMUiChRaLkvvGbrLXK/euhUj6XzMQwnunNWEKCGtY13L929J
	RGvwY4nUETiLhdfoymqNEVfZu70G88Q5me5P1u3gTny0pGS+isVBfAu51qRmM0xg
	swoGsjkhFR8Z3WI5N852Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723067824; x=
	1723154224; bh=F1x0QI2mdpIAiCDsMu+p8sIP7cQyxdWc2/mkuJXriQc=; b=B
	9o2A2BXooCg66bmhNWNGIglb1Cs1FiTAVNTV9fAOQbDxhD2pe1Ld79T0I8Br71Lq
	f6WsX4ZKiim/hEesrMSCaTzjnOLeIdQe+7+du+mPnxgqJEc7MpFklR2kp65ULUz0
	2oXuZxxurXTuCkYCkWAGBQa3PeeE+OBHh2zT5X1fpaX8RIVEdVC5IUTf3hPZrDIT
	14PvyBMyggY/RKjCbOegkfVkA15ULi0pkS/BjVDFRqxskp5Ty8E4rUHehqaoegYn
	Posa1DaKYG75llZ/mbwDpGLkjhe/MjIfwS+5rX6JVegAqaiOcgNlBanSymGi4mgq
	Q45fo21kBC38OqM8JSkNQ==
X-ME-Sender: <xms:sO2zZtcVdLFl4DDAxxs5Gx0ClthrwXu55A9adc_bRqAfivmzTS3RYg>
    <xme:sO2zZrOSNrbWINOLzmwLQA0shE8ypIM2disO34sSRSAf-YvdWcYhzKTakmCPau8p-
    T0pqL1mUt33npl6og>
X-ME-Received: <xmr:sO2zZmigbQsIwjjHw07HFaApijR4RfRSKAa4YqzxV2vmSyZHPdf-wg-5fl78AnvcNS6OQBsPnT1pnAcyhJQmHs8HNPG4URUnOXeh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepke
    fgieeigeehgfdvffeltdevuefgtdfhfeehgfegtddtjeejtefhvdfhtdehkeetnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrh
    ihhhhlrdhiohdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:sO2zZm8ojrB14ds1GZrVdRZGxN_h0wk-erguNVdHAdw661_qc9hwPw>
    <xmx:sO2zZpu1cql5d3IHwRmvtNg5Xd83kUGtLT5o-imewGJoUAtta44dgA>
    <xmx:sO2zZlExy4pkuv2NGnvhhYD_rnVqofAHgVSPKHE4B4Un_mQQ3whPLg>
    <xmx:sO2zZgNXHM4Cfd1TCwHHd1aX1Y2cVgJGz8F0PP6QqqanorGevSI_1Q>
    <xmx:sO2zZsUxE0wG5ULTinVOmQHdWAgAyedj0-cBiCV2PBtPeWzmS7IcVeOZ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 17:56:58 -0400 (EDT)
Message-ID: <51199e48-fd36-4669-a93a-97e5c10aea26@ryhl.io>
Date: Wed, 7 Aug 2024 23:59:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
 <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
 <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>
 <ZrJ5kORJHsITlxr6@boqun-archlinux>
 <CAH5fLgj2XEvjourzW4aoRDQwMGkKTNiE7Wu9FVRrG=7ae1hiWA@mail.gmail.com>
 <ZrOIsLH2JsoFzCZB@boqun-archlinux>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <ZrOIsLH2JsoFzCZB@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/24 4:46 PM, Boqun Feng wrote:
> On Wed, Aug 07, 2024 at 10:50:32AM +0200, Alice Ryhl wrote:
>> On Tue, Aug 6, 2024 at 9:30 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>
>>> On Tue, Aug 06, 2024 at 10:48:11AM +0200, Alice Ryhl wrote:
>>> [...]
>>>>>> +    /// Returns the flags associated with the file.
>>>>>> +    ///
>>>>>> +    /// The flags are a combination of the constants in [`flags`].
>>>>>> +    #[inline]
>>>>>> +    pub fn flags(&self) -> u32 {
>>>>>> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
>>>>>> +        //
>>>>>> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
>>>>>> +        //
>>>>>> +        // FIXME(read_once): Replace with `read_once` when available on the Rust side.
>>>>>
>>>>> Do you know the status of this?
>>>>
>>>> It's still unavailable.
>>>>
>>>
>>> I think with our own Atomic API, we can just use atomic_read() here:
>>> yes, I know that to make this is not a UB, we need the C side to also do
>>> atomic write on this `f_flags`, however, my reading of C code seems to
>>> suggest that FS relies on writes to this field is atomic, therefore
>>> unless someone is willing to convert all writes to `f_flags` in C into
>>> a WRITE_ONCE(), nothing more we can do on Rust side. So using
>>> atomic_read() is the correct thing to begin with.
>>
>> Huh? The C side uses atomic reads for this?
>>
> 
> Well, READ_ONCE(->f_flags) is atomic, so I thought you want to use
> atomic here. However, after a quick look of `->f_flags` accesses, I find
> out they should be protected by `->f_lock` (a few cases rely on
> data race accesses, see p4_fd_open()), so I think what you should really
> do here is the similar: make sure Rust code only accesses `->f_flags`
> if `->f_lock` is held. Unless that's not the case for binder?


Binder just has an `if (filp->f_flags & O_NONBLOCK)` block somewhere in 
the ioctl, where filp is the `struct file *` passed to the ioctl. Binder 
doesn't take the lock.

Alice

