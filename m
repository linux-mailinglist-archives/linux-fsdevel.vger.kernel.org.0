Return-Path: <linux-fsdevel+bounces-34644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA39C7266
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41407B35864
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153521DF978;
	Wed, 13 Nov 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b="nteBtXEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUjkfAFf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219618FDA7;
	Wed, 13 Nov 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731505729; cv=none; b=Yj3Tj94cqFrDGH74+/z/ivYvCuV0K9+LmBrABwiMzm+4S6iRgpKsn/rktqw3giLjLPuE3EuycSkn1kJrnycTaLpN51b3padCQbMEkWcRwkD28y1OXfDJaUfRHjTfPrSjqHGnOfnZ09na1CR5xLVxa4/3OXI1H8pvsZzBN+zJDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731505729; c=relaxed/simple;
	bh=2/qOO3WfLsAgx120DsIn32kGFit5gvfT2AWz7ZKQh7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajtyUUE80u/kvEN0mbJp+/YilVqBXuqVWRpRx7GDZ4BwqmpRN+xJPZo28zyBqWaFEPSjPKDWaZwxxwx5XWbYevzVgv7P2NUN73w+Q7twO/L9UETGuDIcC7IDhczjE7NygqOGUroWCrCl2Rck70Hl3w29clq0PltleJVP5IcGERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu; spf=pass smtp.mailfrom=e43.eu; dkim=pass (2048-bit key) header.d=e43.eu header.i=@e43.eu header.b=nteBtXEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUjkfAFf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e43.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e43.eu
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B66F11401BE;
	Wed, 13 Nov 2024 08:48:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 13 Nov 2024 08:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e43.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731505726;
	 x=1731592126; bh=cRSif7e6kuYniyJgvhvmOatiZyLfuZrl3rZd/zzjdIA=; b=
	nteBtXEUPbws3H6NyH5Gt++tu+/Vz2Bt9hq5F2Z6u2aFLjQuaWL69yLTYwQQuBik
	kxj9mP25je1to49psWQvnFvVm0a54Awn//Lkg5P+AIb6fGZ68zwcB1OUFrhU4iFa
	beSQpyIUwFl7ZCz99cndZt2NFw/oT1XO3guH9Z6DGr0Xin5bZKnyx2OfEgqFK28z
	6GHP5PZF8znLADrdqPnwOdamWl9gH7YOSPpbBvlxByCpVgK04aDFMd9/qZStGzTi
	A6PdsD2ey3JbweaT4NPDhWh1y+XnSlSW5YoJgEXvUJkR1GE/ZoTlwqovuOZRv37d
	noVKWpuLEkWo6wBEoWv6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731505726; x=
	1731592126; bh=cRSif7e6kuYniyJgvhvmOatiZyLfuZrl3rZd/zzjdIA=; b=n
	UjkfAFfp6PXu9ikz2HqoAfeH0Vo4+cbeQbaRCSYkITDpaC/Zs37wr//iZA8aTwAh
	SxkzeoZuS9w+ehP+Ur48JnF6Rb5sfhhzVbeXo6Tl7mF1k+JFzbeL+13/jCdFl+Qf
	ZE29OFukJCoMaaokIuPM9f4OTzWDnmo0HRJFSxXgKOL8jQuDcsZzA3wRURC6dTRe
	ywkowUTD09mLn0BJYz4aSWifRZA0TAPGQPgsDnhfs5llXq48kNLJ86mXwh4ezkPQ
	zedzZqYGOcpZOB1vylst6cgNlPAKc0fRZ1SMsCU0pptUkN0odSDuVlR18oC8OAe3
	lZjysz4FN6ZE1Z22Ojt2A==
X-ME-Sender: <xms:Pa40Z4l3g0fgMUwbkzi2aLd1BOLdB7kawESGegd1vvunOUeuuKiigA>
    <xme:Pa40Z30Xodiz9J3vo4sblgzt3-Ojvvcr3OeE3w0XhGizv-LFg9q4dLp7TTgqIqM5D
    E6jJsrMqApkypqPocA>
X-ME-Received: <xmr:Pa40Z2qmTfz22oaYPHn_dBFws0v__GMN7BFaY9kKRifOGahCy5KjL8hLVUUtCQmi4KCLWnLA69Cnp1rvT7pzXaSYiOw5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepgfhrihhnucfuhhgvphhhvghrugcuoegvrhhinhdrshhhvghphhgvrhguse
    gvgeefrdgvuheqnecuggftrfgrthhtvghrnhepjeeftdelheduueetjeehvdefhfefvddv
    ieekleejfeevffdtheduheejledvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepvghrihhnrdhshhgvphhhvghrugesvgegfedrvghupdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruh
    hnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhes
    sghrrghunhgvrhdrihhopdhrtghpthhtohepphgruhhlsehprghulhdqmhhoohhrvgdrtg
    homhdprhgtphhtthhopegslhhutggrseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:Pa40Z0mDLsvW9jkwrvAOa0-qjkcyBXcDmuT7T4hU2FREOZiuBxVamA>
    <xmx:Pa40Z21AUd5nV5QOC3dzHVsG7aJylXoR-yXnp7nyjTXdi-xl4jPGtg>
    <xmx:Pa40Z7v43BMxBjjb6TU_X7kTVm8iuBfVnfhGeWx0Btcz-JxBU0eg4w>
    <xmx:Pa40ZyV7j-XGdXhoCHiF-G3nfYUAQHxiT3afqsQ87GNnOGi0ZzK37g>
    <xmx:Pq40ZwrR0WQuwZ9r3_SwxQS0Aqre2DTGMm5_kJ9Ssn_G-plIQ-UhHnhw>
Feedback-ID: i313944f9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 08:48:44 -0500 (EST)
Message-ID: <d71126d4-68e5-491a-be2d-3212636e7b60@e43.eu>
Date: Wed, 13 Nov 2024 14:48:43 +0100
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
From: Erin Shepherd <erin.shepherd@e43.eu>
In-Reply-To: <20241113-entnimmt-weintrauben-3b0b4a1a18b7@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/11/2024 14:26, Christian Brauner wrote:

> On Wed, Nov 13, 2024 at 02:06:56PM +0100, Erin Shepherd wrote:
>> On 13/11/2024 13:09, Christian Brauner wrote:
>>
>>> Hm, a pidfd comes in two flavours:
>>>
>>> (1) thread-group leader pidfd: pidfd_open(<pid>, 0)
>>> (2) thread pidfd:              pidfd_open(<pid>, PIDFD_THREAD)
>>>
>>> In your current scheme fid->pid = pid_nr(pid) means that you always
>>> encode a pidfs file handle for a thread pidfd no matter if the provided
>>> pidfd was a thread-group leader pidfd or a thread pidfd. This is very
>>> likely wrong as it means users that use a thread-group pidfd get a
>>> thread-specific pid back.
>>>
>>> I think we need to encode (1) and (2) in the pidfs file handle so users
>>> always get back the correct type of pidfd.
>>>
>>> That very likely means name_to_handle_at() needs to encode this into the
>>> pidfs file handle.
>> I guess a question here is whether a pidfd handle encodes a handle to a pid
>> in a specific mode, or just to a pid in general? The thought had occurred
>> to me while I was working on this initially, but I felt like perhaps treating
>> it as a property of the file descriptor in general was better.
>>
>> Currently open_by_handle_at always returns a thread-group pidfd (since
>> PIDFD_THREAD) isn't set, regardless of what type of pidfd you passed to
>> name_to_handle_at. I had thought that PIDFD_THREAD/O_EXCL would have been
> I don't think you're returning a thread-groupd pidfd from
> open_by_handle_at() in your scheme. After all you're encoding the tid in
> pid_nr() so you'll always find the struct pid for the thread afaict. If
> I'm wrong could you please explain how you think this works? I might
> just be missing something obvious.

Moudlo namespaces, the pid in fid->pid is the same one passed to pidfd_open().
In the root namespace, you could replace name_to_handle_at(...) with
pidfd_open(fid->pid, 0) and get the same result (if both are successful, at least).

The resulting pidfd points to the same struct pid. The only thing that should differ
is whether PIDFD_THREAD is set in f->f_flags.

>> I feel like leaving it up to the caller of open_by_handle_at might be better
>> (because they are probably better informed about whether they want poll() to
>> inform them of thread or process exit) but I could lean either way.
> So in order to decode a pidfs file handle you want the caller to have to
> specify O_EXCL in the flags argument of open_by_handle_at()? Is that
> your idea?

If they want a PIDFD_THREAD pidfd, yes. I see it as similar to O_RDONLY, where its a
flag that applies to the file descriptor but not to the underlying file.

While ideally we'd implement it from an API completeness perspective, practically I'm
not sure how often the option would ever be used. While there are hundreds of reasons
why you might want to track the state of another process, I struggle to think of cases
where Process A needs to track Process B's threads besides a debugger (and a debugger
is probably better off using ptrace), and it can happily track its own threads by just
holding onto the pidfd.


