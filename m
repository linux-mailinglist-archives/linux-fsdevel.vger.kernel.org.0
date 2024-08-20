Return-Path: <linux-fsdevel+bounces-26336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4B957B7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE5283F80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45CB4501E;
	Tue, 20 Aug 2024 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr0dkDEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0D376F1;
	Tue, 20 Aug 2024 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121373; cv=none; b=cKJZdkI8i+a3MbXXpOVaP1+yUuD7BTgJHsATegruUMxx2y+O812MNR6w9noBLF7zwFGHpV3VN0WNlMWCzrOQA5euvVaqfwXjT5iRyqgG+X23DrFQbkULOMzyTpJSrAdCWI4FcZXAXPfhxieVSiU4bRrsBAsYP0iarMhbjuak4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121373; c=relaxed/simple;
	bh=12cr/hbwQKqkr5tTboxeAWJWK4VicP7eoqPbiF2HlG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkXEg7DKmWHNKkfR0KomyrVDLOdnsSFqPe7WKOo7SH9IlIV2ZkOt86diBa4Hp5zvqy13cUHF8nWVh2LvBNY31uKnrNNuKRFwWaAcumsEsWu6R9dssGySFRrpuFKUxKxtY2DyXYbDeeWwzLmQTER8vcydhQ/yCMnjOqsrdFcNdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr0dkDEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FA7C32782;
	Tue, 20 Aug 2024 02:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724121372;
	bh=12cr/hbwQKqkr5tTboxeAWJWK4VicP7eoqPbiF2HlG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mr0dkDEKInTMdt3g+6wda/6vUnMDji+lh+78jE+MQX7XaTQO63jyJUAGURy1E1wkl
	 2EVhDu9zanyD8YmHJUOovMdKp2DXIKeSoshmbjd0EqtMSyun2iUZ+P/Jt2qtx6cUrQ
	 OAnYEQo1gcuG68XEkF90g7ZUCWtxLDQ2XdUPBPkteGr492v+p7gib4JFrYeYQU6VYr
	 Li/35+evsg50rhIstrMn7b87pLJBJJpZVS3W4ZGZhF1ugcPtSUvWCSJ7WfVuSDhuTo
	 Esc/97nIJdWIinhqA4iG7mHx7KjIiedSgl+Ql+YQoyeMDZ9mVMGkr1cIMC/mh3EuEU
	 K2U2pkqLqnSRw==
Date: Mon, 19 Aug 2024 19:36:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Karsten <mkarsten@uwaterloo.ca>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Joe Damato <jdamato@fastly.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, netdev@vger.kernel.org, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jan Kara
 <jack@suse.cz>, Jiri Pirko <jiri@resnulli.us>, Johannes Berg
 <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FILESYSTEMS
 (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [RFC net-next 0/5] Suspend IRQs during preferred busy poll
Message-ID: <20240819193610.5f416199@kernel.org>
In-Reply-To: <4dc65899-e599-43e3-8f95-585d3489b424@uwaterloo.ca>
References: <ZrqU3kYgL4-OI-qj@mini-arch>
	<d53e8aa6-a5eb-41f4-9a4c-70d04a5ca748@uwaterloo.ca>
	<Zrq8zCy1-mfArXka@mini-arch>
	<5e52b556-fe49-4fe0-8bd3-543b3afd89fa@uwaterloo.ca>
	<Zrrb8xkdIbhS7F58@mini-arch>
	<6f40b6df-4452-48f6-b552-0eceaa1f0bbc@uwaterloo.ca>
	<CAAywjhRsRYUHT0wdyPgqH82mmb9zUPspoitU0QPGYJTu+zL03A@mail.gmail.com>
	<d63dd3e8-c9e2-45d6-b240-0b91c827cc2f@uwaterloo.ca>
	<66bf61d4ed578_17ec4b294ba@willemb.c.googlers.com.notmuch>
	<66bf696788234_180e2829481@willemb.c.googlers.com.notmuch>
	<Zr9vavqD-QHD-JcG@LQ3V64L9R2>
	<66bf85f635b2e_184d66294b9@willemb.c.googlers.com.notmuch>
	<02091b4b-de85-457d-993e-0548f788f4a1@uwaterloo.ca>
	<66bfbd88dc0c6_18d7b829435@willemb.c.googlers.com.notmuch>
	<e4f6639e-53eb-412d-b998-699099570107@uwaterloo.ca>
	<66c1ef2a2e94c_362202942d@willemb.c.googlers.com.notmuch>
	<4dc65899-e599-43e3-8f95-585d3489b424@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Aug 2024 10:51:04 -0400 Martin Karsten wrote:
> >> I believe this would take away flexibility without gaining much. You'd
> >> still want some sort of admin-controlled 'enable' flag, so you'd still
> >> need some kind of parameter.
> >>
> >> When using our scheme, the factor between gro_flush_timeout and
> >> irq_suspend_timeout should *roughly* correspond to the maximum batch
> >> size that an application would process in one go (orders of magnitude,
> >> see above). This determines both the target application's worst-case
> >> latency as well as the worst-case latency of concurrent applications, if
> >> any, as mentioned previously.  
> > 
> > Oh is concurrent applications the argument against a very high
> > timeout?  
> 
> Only in the error case. If suspend_irq_timeout is large enough as you 
> point out above, then as long as the target application behaves well, 
> its batching settings are the determining factor.

Since the discussion is still sort of going on let me ask something
potentially stupid (I haven't read the paper, yet). Are the cores
assumed to be fully isolated (ergo the application can only yield 
to the idle thread)? Do we not have to worry about the scheduler
deciding to schedule the process out involuntarily?

