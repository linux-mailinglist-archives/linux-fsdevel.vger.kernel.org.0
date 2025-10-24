Return-Path: <linux-fsdevel+bounces-65519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D540FC069DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47904189B331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E8320A1A;
	Fri, 24 Oct 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jgBWFQvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k46Or4Da"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C231D742;
	Fri, 24 Oct 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314844; cv=none; b=eAqAGg/WnRj9WVGvLI4MWQvAbURyjD+VZu+56Je3BhNwfTFlZKavZwTlsWuTqJZ3A+vn/k+2tluwqoW+8DVWn+4OmuL7LmWNq1fd3vyaXhDSI0Ez7tUwUncRf86goAOASbqHqHgNX5xUMuDteIlcWwqATWGr1jwcnJn5L0DBozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314844; c=relaxed/simple;
	bh=seTjJ9cm6Zi9cqnUGd6+2HjOK4qyMZwn9gNNu1eyosw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g7V6Z01vZfhamlW0btokzqJphHmYC/hOBJ++ZXXRcd0xHMFyJj6Xgejre+D1TomB3+sxaiUd/wn0I0j1FgItcwOv6sBqywqTEG9SD7Tcx5uei3M80kMCpMZuHcfCx95S7xCrMg4yFNXV1OiYd7eUTA1Zt7C+Ms+MUjScLKLCNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jgBWFQvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k46Or4Da; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 54B501300260;
	Fri, 24 Oct 2025 10:07:20 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 10:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761314840;
	 x=1761322040; bh=miSsXPm4+M0zwlfLzYyT4CIr/q9mDcjy6aC2hB/hyk4=; b=
	jgBWFQvqDqbz/Zq/xSrEgs0hq9MPBcOZ2dNhQ1yMZYMTDANg0IEMjS0xYuS1njKK
	jI43y9Ow4+ENflZ5QpoeKG+EruCmIBM/OPIqHcRBUvA5YgSoW4SJGuPkSO+YdZw8
	kojKnVaT8q0cmTKXGEGJHtpuKYP0O780K6pQYGEw5kSMU6ezFwz1bIfQepykAvVr
	ohXELdiiKsCBZoglf271iR+wQp0SoDuv0DYZiM4KLLo9grpJoGgllmDHvO3OacPk
	WO0aws6DWT6GsFBL3gm+v3yl63taVN22FUe9lzN0NNMgmCZJLLIn0nFvDLYCyAQg
	H4fxkgWnFHYv1QwhzeKjWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761314840; x=
	1761322040; bh=miSsXPm4+M0zwlfLzYyT4CIr/q9mDcjy6aC2hB/hyk4=; b=k
	46Or4Daocr+xA9L6d1Xsx5qKTMN0FQGxQqFeTMfZPV0ekpgNTq96i1c5m7K8dHY2
	XZSatkEfkiD50NN+A4SoOGc/m3JKVlHpSN7EW0FBm3xbaeAzR458klY3gcUzFPGh
	b49S2e/27nSPuZOx5AsxlJPVkhcLyNHAJTfw9xWJ8DiMxXdR+MPr9vOvsfxH4fwc
	JT37LSRscqR8GsePIWdOJxo4GrlMRqzTjBPNGboraqPiRA1qLhMgxDOEpAPLkXwv
	4BxoAuhZuQCIDLWy2E97Wx6iJpMxVVoxKLyZ7JoUjS/6dz0Hh0xpwJ2d4SK8lL1Q
	al6bnjiSx+RnTeLMjltvQ==
X-ME-Sender: <xms:Foj7aG4NuYtOpcaRWHfUIksbaBlZerYvV3Q7w7tCjS8W4AVYj4bqwA>
    <xme:Foj7aKtf0mBz2cBRu6i0sDJ2VsejI9GVBRjz64SoCOswlE9XKD20WfXKnZy5LLCpu
    PN1psAfiI6zQcaQZ5oDZlrPFJT_d-mL8yLH2lUa5QIdxxcxZ3-5Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmiiigrhgvrghrhiestdhpohhinhhtvghrrdguvgdprhgtphhtth
    hopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtthhopegthihphhgrrhes
    tgihphhhrghrrdgtohhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuggrrghnrdhjrdguvghmvgihvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrg
    hnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopeiisgihshiivghksehinhdrfigr
    fidrphhlpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Foj7aHDM4oeTEXhqauXmthr2GR6ilhZI57zYSak8FJlFgBge84kUOg>
    <xmx:Foj7aJN7IEPHUfIw4pYnNqv5_h9BJtW4TkoBBCnnlSAJzv0fVOSc0A>
    <xmx:Foj7aNQIp8WDI5COISvW5X4bvl8bLoIlnrmE5gKB-F8Bh54FDnNoBw>
    <xmx:Foj7aKuBpwOj5PR8C59xW1chma9wqxV8TWIH3K-1xSO_aL-K7MCCFQ>
    <xmx:GIj7aH8aRQ5olxoTtA5Lw-Je7GEAi6eHUZb1YU-y6f6Bko96GGTE0ukv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F1B6700063; Fri, 24 Oct 2025 10:07:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9aggTBZhXf3
Date: Fri, 24 Oct 2025 16:06:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Mike Yuan" <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 "Lennart Poettering" <mzxreary@0pointer.de>,
 "Daan De Meyer" <daan.j.demeyer@gmail.com>,
 "Aleksa Sarai" <cyphar@cyphar.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 Netdev <netdev@vger.kernel.org>
Message-Id: <481c973c-3ae5-4184-976e-96ab633dd09a@app.fastmail.com>
In-Reply-To: 
 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: 
 <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 24, 2025, at 12:52, Christian Brauner wrote:
> Add a new listns() system call that allows userspace to iterate through
> namespaces in the system. This provides a programmatic interface to
> discover and inspect namespaces, enhancing existing namespace apis.

I double-checked that the ABI is well-formed and works the same
way on all supported architectures, though I did not check the functional
aspects.

Acked-by: Arnd Bergmann <arnd@arndb.de>

One small thing I noticed:

> +SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
> +		u64 __user *, ns_ids, size_t, nr_ns_ids, unsigned int, flags)
> +{
> +	struct klistns klns __free(klistns_free) = {};
> +	const size_t maxcount = 1000000;
> +	struct ns_id_req kreq;
> +	ssize_t ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (unlikely(nr_ns_ids > maxcount))
> +		return -EOVERFLOW;
> +
> +	if (!access_ok(ns_ids, nr_ns_ids * sizeof(*ns_ids)))
> +		return -EFAULT;

I'm a bit worried about hardcoding the maxcount value here, which
seems to limit both the size of the allocation and prevent overflowing
the multiplication of the access_ok() argument, though that isn't
completely clear from the implementation.

Allowing 8MB of vmalloc space to be filled can be bad on 32-bit
systems that may only have 100MB in total. The access_ok() check
looks like it tries to provide an early-fail error return but
should not actually be needed since there is a single copy_to_user()
in the end, and that is more likely to fail for unmapped memory than
an access_ok() failure.

Would it make sense to just drop the kvmalloc() completely and
instead put_user() the output values individually? That way you
can avoid both a hardwired limit and a potential DoS from vmalloc
exhaustion.

     Arnd

