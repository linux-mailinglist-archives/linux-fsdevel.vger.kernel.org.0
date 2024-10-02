Return-Path: <linux-fsdevel+bounces-30681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AD98D3A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE301F22809
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407841D0142;
	Wed,  2 Oct 2024 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pIezcUtD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L9iXoc4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA548198E7F;
	Wed,  2 Oct 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873316; cv=none; b=l+IQCWGVA5hH1G7lS3/hRW2XQIqlLYX28hge0qFYdaObOCzmfA4VTka4pTFBrb9msWTUIAcqwFdkl3XFi9s5OY9ckNsf0HbjPslOjNYN5wb7IIxAoO8QYWVAtmykn2XjXzMBL033sb6JHSffLo+kfKw8GJGVX+LWTW1fgTzviic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873316; c=relaxed/simple;
	bh=nv/lsJscdkXumBmEHB7B0V3BILhKeMoO4w1QEWB+ipI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FmBwtR/XeSaiRmyaYBnmAw7DtcaPmW4F+P7SRrrwYXgg7Da30ivyV7/SBk81HN9oBojIUgzHruAQwN9BLF1KWftJu9VlfW/jLGBkiNMKw3UYdTXRQVrVmNRwsjIMMtTBQ4NEosNjDbWZNXUWaeWsoelLkn+KO8pkA9yXP289nzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pIezcUtD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L9iXoc4J; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D135711400F4;
	Wed,  2 Oct 2024 08:48:33 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 08:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727873313;
	 x=1727959713; bh=05cQwclux3S3pqYYfznkobdBnmxOoukYv72rEPNKpUk=; b=
	pIezcUtDGDb7syYFoqR8SemGAu7qmkcxQwS2IB5bXeGbOuwkNyltG91BFCQ2Sdt3
	+BK67HZ/RyRtwi/SlgTGbPCcrgdujg1aIiUtDIjVjkzYwl/JBuFN0HvK4rhRwNUf
	+y6PfjhB8MjruJVbCbzQ7ev1oCZc+YmiW1sBEILg/HkCsb5acS+UzdW9tBgo1LjL
	Kfe0ajjVzQrYPyUkM5xkd5GrGtvKDzfWU5DfxINEVCeY2O9fXHzq2wEFi4wy5ESM
	0ghN0S6UqOJtj9UhJoLBBVQ2CLmurL6o3AuvAKXVuvrDGO3wARUAGu2/QRaERI+t
	s8CzhpPttWZFX/3iq8NgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727873313; x=
	1727959713; bh=05cQwclux3S3pqYYfznkobdBnmxOoukYv72rEPNKpUk=; b=L
	9iXoc4J5A/qRF8qQGQtHojVPi8cOB+fAcpy1EYHr9Vm0PdAcQtIyxKCTsl7BF/2Y
	bGlEenjFScn6J5Bx5ZfZ76SEecV0jIvPXxhLXDKLoCHE2iVKqjTf31w4oCVM4V9B
	mxH8foQAaOYg2YMGHBfEv8/vHHyj3ylEB8yfExBfurDFt6utyd8a77zo286id6kf
	oUYwS0Vv7OmJycTdlA4B9W+59X2/fXC44GefmSpA/1w8q62WtzSqUJFYY6ddccHI
	XKgpr5AB2ywK0T0N+bt2s7wTYTe2R7CK1x5nwI8CtBH2UnD0Ledy9tVmTLO3HXAo
	GmIowYf9iKpuWN5NCHXAA==
X-ME-Sender: <xms:IEH9Zt9YKXGQd_bGU-GwK6YYKjuM0GyzDndXTJNvaRFOLOQsgg2dwA>
    <xme:IEH9ZhtN_euGpFzPnabOiYARp4PDJ8eYsrtKt1psiX4np0aGzZVdj8EiXP6GAdzRd
    jdY5sylL9Dj6Nt0W3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphht
    thhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrdhhih
    hnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IEH9ZrBuZIQ95er61bn8Z_tmR0sMrCN6qpJdOn4b7RV7fmr_tjwgEA>
    <xmx:IUH9ZhetWIm8WMT8ctgjZbZB2SgUnVsHW_gkaqWlPEdD7CSHjy85Gg>
    <xmx:IUH9ZiMhvOWqV38spHscYOVacbVClK92xFHGXxw2jMy35WWMmuLzDQ>
    <xmx:IUH9ZjkqCj6qddIYGuXH273u5nscdodyoGEJ0f8aYn1ljick2IeXmw>
    <xmx:IUH9Zpk3DMc5xh0ViPpmB4WlFcZxGX38DDjEh6qgJ9kFb6nGhT4XkWjO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C91432220071; Wed,  2 Oct 2024 08:48:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 12:48:12 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alice Ryhl" <aliceryhl@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <af1bf81f-ae37-48b9-87c0-acf39cf7eca7@app.fastmail.com>
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 1, 2024, at 08:22, Alice Ryhl wrote:
> +#[cfg(CONFIG_COMPAT)]
> +unsafe extern "C" fn fops_compat_ioctl<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    cmd: c_uint,
> +    arg: c_ulong,
> +) -> c_long {
> +    // SAFETY: The compat ioctl call of a file can access the private 
> data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Ioctl calls can borrow the private data of the file.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) 
> };
> +
> +    match T::compat_ioctl(device, cmd as u32, arg as usize) {
> +        Ok(ret) => ret as c_long,
> +        Err(err) => err.to_errno() as c_long,
> +    }
> +}

I think this works fine as a 1:1 mapping of the C API, so this
is certainly something we can do. On the other hand, it would be
nice to improve the interface in some way and make it better than
the C version.

The changes that I think would be straightforward and helpful are:

- combine native and compat handlers and pass a flag argument
  that the callback can check in case it has to do something
  special for compat mode

- pass the 'arg' value as both a __user pointer and a 'long'
  value to avoid having to cast. This specifically simplifies
  the compat version since that needs different types of
  64-bit extension for incoming 32-bit values.

On top of that, my ideal implementation would significantly
simplify writing safe ioctl handlers by using the information
encoded in the command word:

 - copy the __user data into a kernel buffer for _IOW()
   and back for _IOR() type commands, or both for _IOWR()
 - check that the argument size matches the size of the
   structure it gets assigned to

We have a couple of subsystems in the kernel that already
do something like this, but they all do it differently.
For newly written drivers in rust, we could try to do
this well from the start and only offer a single reliable
way to do it. For drivers implementing existing ioctl
commands, an additional complication is that there are
many command codes that encode incorrect size/direction
data, or none at all.

I don't know if there is a good way to do that last bit
in rust, and even if there is, we may well decide to not
do it at first in order to get something working.

      Arnd

