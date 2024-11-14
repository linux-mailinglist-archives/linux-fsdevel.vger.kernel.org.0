Return-Path: <linux-fsdevel+bounces-34779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE69C89C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F841F23DAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D31F9A82;
	Thu, 14 Nov 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="SrJDkRbl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gq6Art94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789311F8929;
	Thu, 14 Nov 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586892; cv=none; b=JbaWZmB9htkiJ0Ojoc9u9Cjx6QPOcRr7ibNE8v8nj2EKMELbnUd3ZfPw9wO7OqKO1R+QxiU7CgCjZI5Y+Ly1m8Y2FulZ04Jrd/JWBmm5hnmedi12fhuxZOsBUutAvxUyCKIcDAwG3Ij3JSDuwKK+zhi21Dt47V8zOOBKdN2BLw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586892; c=relaxed/simple;
	bh=iG7RL4zKb2RC8kFy4V0qXFiSGCO5dl0PKYPSdkdsYjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaZIWds0PojIPrvfhYKmN6n6ZjtBv7fsHRfFk3qmJewiwpmSBPoaTHF3+eYVOZl5BZJgQ0jnCyRtE3Jd48uaGDTIGPp0Hwxh+1lcnTRuvikuxiiEIqhVXGm0/ru1lisugjWAzth+5hI9Y8sTS3+vKLfX4gOXAoE6pZqdtxsoACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=SrJDkRbl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gq6Art94; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 537D913800A7;
	Thu, 14 Nov 2024 07:21:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 14 Nov 2024 07:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731586889;
	 x=1731673289; bh=Ofzr7/xD3eb4FLoTtj4hNipRDF4CMnF4lvsR1lJs0bI=; b=
	SrJDkRblCZZAX56Bl6Kr4AFlSB9zVG5MPDXS0IrdmObV3gP8GA/1bFjA6idGVkq4
	62nb6cnSs5v2eO+DBJGxIZ/2T2cbQ6yejZF9fQs5Pv1HBvSK1+T3jH2Waz7d530F
	sJtE2gdvcoWKEXW2QdMLSUfl0cYbRntBxMkwyzAJFn0DTt1S/E+MFcAyCOYqPuD8
	wN7zjWqXcYbhTOWWkl1SXEvjgtWdFVPAx5qpQv4nr7F94wkitvnaGqvbDIl9zal4
	4nsqg2hOg31CeajSTgnt1Ad6eDl7UNlVjRQf6pLMvlWIUTctd/C249gN2sNjM0hB
	hyCtejAcnBqH/3z3fFKT2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731586889; x=
	1731673289; bh=Ofzr7/xD3eb4FLoTtj4hNipRDF4CMnF4lvsR1lJs0bI=; b=G
	q6Art946xMY9BKA3deGqmqD5NK76zruElnqEhtbPtP1n0FLEhiKXLsZMY4Gz87bd
	gGsD6I7FRfOSKtKrPx/TLW4kwhMny5Sy83xDk8JavkunGLUmPqzejUwNR0vAHkmJ
	wefJQcbKbLUfjGMARwyOgBEPb2fyrLU4LMpIQLpsDnctaTtHtwR7LsTtreJqVO3R
	XtoInd6YZV2qWRj8JSBIpD7JQ5sEVru8a/gSKFdzztmCxeZUAhIGp3Ua/LtrkTev
	Hhck2QWj1+EjAUlTVMZnjxOVEWxei1NOdPAfiIUHDPZ9aTrx43r6y8twuLUBUykD
	T5TGw///lxYDIrsjnuD7Q==
X-ME-Sender: <xms:SOs1Z9n7bSgkVCXgc7A6iQdbKK0JxTULYy9uTvPbMLhJTYURjPO8Xg>
    <xme:SOs1Z41NG6kSBz2D4QLKjMYxA6uuqh9obNdjeah0ph1RjUOeIPaLmg5pWZ5xg0zUK
    N4I6cSehur7Qvj2e_k>
X-ME-Received: <xmr:SOs1ZzoLqUO1MxC7icTjGWBqrsLVNUuSfcmHCxuMCLf_1ns3XkAloisZTLws0tvvbAjTb72v5xqwl7_fvSXVqdtqHScc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepgeeghfejjeegtdfgfefhtdfhuedvjedu
    leeflefhjeetleeikeejgeeggefggedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhes
    sghrrghunhgvrhdrihhopdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtg
    homhdprhgtphhtthhopegslhhutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:SOs1Z9lPa5n5FqClthlzt60dvDDnS_L7W-cja_pjsnFY81vRNG9M3w>
    <xmx:SOs1Z725vcLoowRbHCO2ie35CfOfeoU3lWL_nHS8rOSWTaR5DzKscw>
    <xmx:SOs1Z8t_ygDVaRqW7Im1-__gBXP8qpXGUH47vTUPqa67l-RIKNTxTg>
    <xmx:SOs1Z_VcypBEDjDf-SShF4zfNK-eRtXKRiKk9nMhPNkkpGO9NHyFZg>
    <xmx:Ses1Z1oJpklVX0wp_n2SpgWQ4Lfy_35xm6AHjkROtiwEWkDkrMfKuWkq>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 07:21:27 -0500 (EST)
Message-ID: <6a3ed633-311d-47ff-8a7e-5121d6186139@e43.eu>
Date: Thu, 14 Nov 2024 13:21:25 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Content-Language: en-GB
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 christian@brauner.io, paul@paul-moore.com, bluca@debian.org
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <20241113-erlogen-aussehen-b75a9f8cb441@brauner>
 <65e22368-d4f8-45f5-adcb-4d8c297ae293@e43.eu>
 <20241113-entnimmt-weintrauben-3b0b4a1a18b7@brauner>
 <d71126d4-68e5-491a-be2d-3212636e7b60@e43.eu>
 <20241114-minigolf-merkmal-613de487cfbb@brauner>
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241114-minigolf-merkmal-613de487cfbb@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 14/11/2024 11:29, Christian Brauner wrote:
>> Moudlo namespaces, the pid in fid->pid is the same one passed to pidfd_open().
>> In the root namespace, you could replace name_to_handle_at(...) with
>> pidfd_open(fid->pid, 0) and get the same result (if both are successful, at least).
>>
>> The resulting pidfd points to the same struct pid. The only thing that should differ
>> is whether PIDFD_THREAD is set in f->f_flags.
> I see what you mean but then there's another problem afaict.
>
> Two cases:
>
> (1) @pidfd_thread_group = pidfd_open(1234, 0)
>
>     The pidfd_open() will succeed if the struct pid that 1234 resolves
>     to is used as a thread-group leader.
>
> (2) @pidfd_thread = pidfd_open(5678, PIDFD_THREAD)
>
>     The pidfd_open() will succeed even if the struct pid that 5678
>     resolves to isn't used as a thread-group leader.
>
>     The resulting struct file will be marked as being a thread pidfd by
>     raising O_EXCL.
>
> (1') If (1) is passed to name_to_handle_at() a pidfs file handle is
>      encoded for 1234. If later open_by_hande_at() is called then by
>      default a thread-group leader pidfd is created. This is fine
>
> (2') If (2) is passed to name_to_handle_at() a pidfs file handle is
>      encoded for 5678. If later open_by_handle_at() is called then a
>      thread-group leader pidfd will be created again.
>
> So in (2') the caller has managed to create a thread-group leader pidfd
> even though the struct pid isn't used as a thread-group leader pidfd.
> Consequently, that pidfd is useless when passed to any of the pidfd_*()
> system calls.
>
> So basically, you need to verify that if O_EXCL isn't specified with
> open_by_handle_at() that the struct pid that is resolved is used as a
> thread-group leader and if not, refuse to create a pidfd.
>
> Am I making sense?

Ah, I fully see what you mean now.

I could implement pidfs_file_operations.open and check the flags there, but
that runs into the issue of vfs_open resetting the flags afterwards so its
entirely pointless. If PIDFD_THREAD wasn't in the set O_CREAT / O_EXCL /
O_NOCTTY / O_TRUNC then this would be much easier, but alas; and its ABI now
too.

I guess the options are

1. Let an FS specify that it doesn't want O_EXCL cleared, but this is getting
   to be some gnarly VFS surgery, or
2. We just detect we're working on a pidfd early in open_by_handle_at and
   skip straight into dedicated logic.

I know you suggested (2) earlier and I increasingly think you're right about
it being the best approach. It also fits better with the special casing PIDFD_SELF
will want when that lands.

So I'll see what an implementation with that approach looks like.

>> If they want a PIDFD_THREAD pidfd, yes. I see it as similar to O_RDONLY, where its a
>> flag that applies to the file descriptor but not to the underlying file.
> This is probably fine.
>> While ideally we'd implement it from an API completeness perspective, practically I'm
>> not sure how often the option would ever be used. While there are hundreds of reasons
>> why you might want to track the state of another process, I struggle to think of cases
>> where Process A needs to track Process B's threads besides a debugger (and a debugger
>> is probably better off using ptrace), and it can happily track its own threads by just
>> holding onto the pidfd.
> We recently imlemented PIDFD_THREAD support because it is used inside
> Netflix. I forgot the details thought tbh. So it's actually used. We
> only implemented it once people requested it.
Oh, I entirely understand the utility of PIDFD_THREAD - I'm just not sure how mnay of
those use cases are cross-process (and in the cases where they are cross process, how many
of those uses would benefit from file handles vs fd passing)

