Return-Path: <linux-fsdevel+bounces-28217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C613968280
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37DC281F84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB67187347;
	Mon,  2 Sep 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WCJxxXNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvYWLP3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF148186E39;
	Mon,  2 Sep 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267352; cv=none; b=pTQPjoqBPSHHsAUHhYmKk4J/zExquBout8Wni2md7hjrUvEKtjD50G4JbV5JqZ3evBtQkloV26jWoDF1fDV2GhqTZzUF3/kSEMy8LiKPJD0fsLsU4yAoJvQpVxBXqMlgSt5aoZsKPZx4hfEHnKEkrdKXryyv6sHKicK2fuw11pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267352; c=relaxed/simple;
	bh=BsMRZ2X437PZQO1ciTfhruhMsAj9I0m3fSE6geobgtw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CQTMaAgt1tMflCdZalPVSaicf13otefYliWKJXAZfYWxt3CYvsn4//F9/Zx1+c6pamMHGjJE+qK+83oV6eXQJIaSA44Xu9galJOxUpzqCekeUihpUJVJKEN3+Xo4XY3s9CpzZ4NnbaCys87FdSez6xmGp+bmP2SBv9IiPnHTb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WCJxxXNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JvYWLP3R; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id CF70A13800A9;
	Mon,  2 Sep 2024 04:55:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 04:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725267349;
	 x=1725353749; bh=LF7xpMJNWj3ZriHPHEsj5u5MBL/vfCltp6iqjmEY5XQ=; b=
	WCJxxXNkjKBvaXKlDicxYmZiCkivs/xh8EF0IZyc54kt0ZOWzilCuljgNCUe/eOE
	kkJhY/2vZXsrXsbJcexM1UhtwFMjUJillVSUstEuRoMGhjD/Q7cW4CfNHaYBK7ey
	mB89omYgOo2bly2M0SBRFP4UFE0uI/2Wm5HMutNYWiX9WRZ2wuKZ+rbe7NPAbCK5
	lQ6XcbLVUIhWhrb3bwEbmm+t9Qdo1r6H3F0jDztY31OrkMCsI8G5J+AX2vijrsrG
	3M0FPtH9FESOiCRT0MrPqlpPUQj2t6GlKa8e+CJvOUKQvTk+Gb0YdnPrqCFTEb7b
	/Hs0+5PRNJFRqNRJmBW65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725267349; x=
	1725353749; bh=LF7xpMJNWj3ZriHPHEsj5u5MBL/vfCltp6iqjmEY5XQ=; b=J
	vYWLP3R6cWafAkSZmMItfGBr0wVqo4qGTfJqQGx+hf/riaN/E7OZA5Int4Zg8aib
	pwabqPE+1bho+JM7SnNcJLIpMw3+Nsw9AT275r/N6BFrsQEDgo9CiIvU9/M4hrEA
	4nKYz6v+wtdKl47Mw+YpWTVGqVzmjTNNPIdQaMfeOy8z5hnhUYg5NcqfTpoyymj5
	sKDoFbCmVqh2jKtFda1rXbUZ9lusw4DTz0aSPQ0/rdQdYCVex+zubqvA3IqAC4je
	0RSqOoNLAnR60Q38OldQ1MiMaHXJMr6MESe2+MFmfw0dPYK81PRKUSW9p9qWto3X
	iYMqnqN3qs0QmC5VOxCag==
X-ME-Sender: <xms:lX3VZqv7SM2Rc2Rs4sfSvRwiD-bRCtSRs2UD-JNfsyI79WU3BV3oHw>
    <xme:lX3VZvflyI2TtHFnqJbdW9b2MliflvvMMJsspU7Ea8ZD7lvThs2KB53iuo7rSU1xg
    JmQXPVSEVvsqxdCznw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrg
    hnnhesrghrmhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdr
    tghomhdprhgtphhtthhopegthihphhgrrhestgihphhhrghrrdgtohhmpdhrtghpthhtoh
    eprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopegsshgvghgrlhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:lX3VZlwsOgbUBtnEeR80dCbOpc_esF6F_IlwvTxzd-5bKUBxncmo3w>
    <xmx:lX3VZlP3UtxIBxk0_0nQFl1NhjqmAXOzhMTwAWStfvuryQTP2QZqhg>
    <xmx:lX3VZq-kT5DyyXyjwFmIeyCUr2Ygwiw3XweX9afDuf3t863YKxGusQ>
    <xmx:lX3VZtX0GBRv2ZfrJy-b6x5UkxilddUNe9nRwwn6bP6PpTVhxfbONg>
    <xmx:lX3VZgkDgKbamK4UOILT-fXFQeW3l2De0D4NVfqsOgkPPCRJ2v8ahhwW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 06AE52220083; Mon,  2 Sep 2024 04:55:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 08:55:28 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aleksa Sarai" <cyphar@cyphar.com>, "Ingo Molnar" <mingo@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Juri Lelli" <juri.lelli@redhat.com>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Benjamin Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
 "Valentin Schneider" <vschneid@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 shuah <shuah@kernel.org>
Cc: "Kees Cook" <kees@kernel.org>, "Florian Weimer" <fweimer@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org
Message-Id: <319c0da6-3d9c-4b45-a14c-07c5bbc3afb7@app.fastmail.com>
In-Reply-To: 
 <20240902-extensible-structs-check_fields-v1-1-545e93ede2f2@cyphar.com>
References: 
 <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
 <20240902-extensible-structs-check_fields-v1-1-545e93ede2f2@cyphar.com>
Subject: Re: [PATCH RFC 1/8] uaccess: add copy_struct_to_user helper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 07:06, Aleksa Sarai wrote:
> This is based on copy_struct_from_user(), but there is one additional
> case to consider when creating a syscall that returns an
> extensible-struct to userspace -- how should data in the struct that
> cannot fit into the userspace struct be handled (ksize > usize)?
>
> There are three possibilies:
>
>  1. The interface is like sched_getattr(2), where new information will
>     be silently not provided to userspace. This is probably what most
>     interfaces will want to do, as it provides the most possible
>     backwards-compatibility.
>
>  2. The interface is like lsm_list_modules(2), where you want to return
>     an error like -EMSGSIZE if not providing information could result in
>     the userspace program making a serious mistake (such as one that
>     could lead to a security problem) or if you want to provide some
>     flag to userspace so they know that they are missing some
>     information.

I'm not sure if EMSGSIZE is the best choice here, my feeling is that
the kernel should instead try to behave the same way as an older kernel
that did not know about the extra fields:

- if the structure has always been longer than the provided buffer,
  -EMSGSIZE should likely have been returned all along. If older
  kernels just provided a short buffer, changing it now is an ABI
  change that would only affect intentionally broken callers, and
  I think keeping the behavior unchanged is more consistent.

- if an extra flag was added along with the larger buffer size,
  the old kernel would likely have rejected the new flag with -EINVAL,
  so I think returning the same thing for userspace built against
  the old kernel headers is more consistent.


> +static __always_inline __must_check int
> +copy_struct_to_user(void __user *dst, size_t usize, const void *src,
> +		    size_t ksize, bool *ignored_trailing)

This feels like the kind of function that doesn't need to be inline
at all and could be moved to lib/usercopy.c instead. It should clearly
stay in the same place as copy_struct_from_user(), but we could move
that as well.

> +{
> +	size_t size = min(ksize, usize);
> +	size_t rest = max(ksize, usize) - size;
> +
> +	/* Double check if ksize is larger than a known object size. */
> +	if (WARN_ON_ONCE(ksize > __builtin_object_size(src, 1)))
> +		return -E2BIG;

I guess the __builtin_object_size() check is the reason for making
it __always_inline, but that could be done in a trivial inline
wrapper around the extern function.  If ksize is always expected
to be a constant for all callers, the check could even become a
compile-time check instead of a WARN_ON_ONCE() that feels wrong
here: if there is a code path where this can get triggered, there
is clearly a kernel bug, but the only way to find out is to have
a userspace caller that triggers the code path.

Again, the same code is already in copy_struct_from_user(), so
this is not something you are adding but rather something we
may want to change for both.

      Arnd

