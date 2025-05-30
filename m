Return-Path: <linux-fsdevel+bounces-50228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F2AC9160
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178621C05A1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875EB23182E;
	Fri, 30 May 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H6llCjH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544E228CBC;
	Fri, 30 May 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748614848; cv=none; b=N2U4EDV6WiCb8vZmFeC0UzSGpRXQMygI9QpMXaiYYxhmRnnhELKQmoDEDcBygMr1E8xQKvpW3nzOUUq45+hYzpLvSOzbrGy00QBT+7w3ZYwf49CN/OJ8Gy+7SO0TIXvQpQiJCfVOQJJMSvvAHu6SByBa7uebRiufFYgNPQNVhcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748614848; c=relaxed/simple;
	bh=wVfhNS5DZdeGUEmvBL1W3Fh416DAmXU8kLYPsve4Nm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCCFrRmrmzD4pd2F9IJCdUGMW6VCCJGw+kiCKZ2mLx7upMLYQ1lu9y9wYhXgopgKuJCq05eTLqYBHRYPVI1BNzQB/m+mRm08AbhbvrfjCh/oYFCYJr6avpC4MPgmHSZCja6hqCuwc0zQsZWgVGlDrnEB4u2un1wqAk0O1N7Wytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H6llCjH0; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b854T5N7Qz44B;
	Fri, 30 May 2025 16:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1748614841;
	bh=ZXHN7tFICGoD90DDmay+SaYrC/AhNESocYWzHIeiWic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6llCjH06gKMuY55FMcGmNuqHn8ZSo7f8/B8ajYTkZXAKFNSpn3ZOFZauTMaJk2+m
	 6wnbI0IE/P4PiaVM5vIdKwVpRSyeMX8WEpmrMO6VyZaj86pz2esfigkq0nIEkft1jG
	 HJY5+dFI/gGj+d+3ctIFhf34+502lqMd3+AG3Oyg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4b854S2J8fz8yh;
	Fri, 30 May 2025 16:20:40 +0200 (CEST)
Date: Fri, 30 May 2025 16:20:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250530.oh5pahH9Nui9@digikod.net>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
 <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, May 29, 2025 at 10:05:59AM -0700, Song Liu wrote:
> On Thu, May 29, 2025 at 9:57 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> [...]
> > >
> > > How about we describe this as:
> > >
> > > Introduce a path iterator, which safely (no crash) walks a struct path.
> > > Without malicious parallel modifications, the walk is guaranteed to
> > > terminate. The sequence of dentries maybe surprising in presence
> > > of parallel directory or mount tree modifications and the iteration may
> > > not ever finish in face of parallel malicious directory tree manipulations.
> >
> > Hold on. If it's really the case then is the landlock susceptible
> > to this type of attack already ?
> > landlock may infinitely loop in the kernel ?
> 
> I think this only happens if the attacker can modify the mount or
> directory tree as fast as the walk, which is probably impossible
> in reality.

Yes, so this is not an infinite loop but an infinite race between the
kernel and a very fast malicious user space process with an infinite
number of available nested writable directories, that would also require
a filesystem (and a kernel) supporting infinite pathname length.

> 
> Thanks,
> Song
> 

