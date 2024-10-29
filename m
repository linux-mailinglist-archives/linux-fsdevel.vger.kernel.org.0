Return-Path: <linux-fsdevel+bounces-33120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9A99B4BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4321C2294F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0064206E9E;
	Tue, 29 Oct 2024 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOq8Dgrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D3206E8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211501; cv=none; b=AqQpx0UbnD7u7+3HAbhcqyyK02iB0PtQmwKPJ7oM5c4LSfX1tUetMPp4EvV/2VPzvrOQNOkL9TCdNePuGuu+b8DVPQC16uBY48mrg+mjOnm6ZcjZDlBnGuccSuz5CjwyMjFqcfYiC1bB9rDV+LSFcnmSuAr01XtWaJisBd55wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211501; c=relaxed/simple;
	bh=5ag6fwy5h6rOD1KOfl/Rn8eS20VZmgo8OM/Ombzptbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjT4Jszj/+GYkYLf8ePMsO1e/qC2/kNorMr5OLcFYcT7OMOHqQHgk24i5f6DHOO4FpV6+dKotgZF00W65BuZTqUh/DctWKh3WRe/9kkOEEYlCHIQ2xm5vc99nPldVZf+DWoLvcRnGFRNrd2gij99nX0dVmIpl4JOwWyuea1vQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOq8Dgrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8B5C4CEE3;
	Tue, 29 Oct 2024 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730211500;
	bh=5ag6fwy5h6rOD1KOfl/Rn8eS20VZmgo8OM/Ombzptbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOq8DgrhEOL32ySo1CtqICEF/ws8mDSuYOZXyAWeAoNjF13OEXcb3Pjprv6EfZNux
	 IkjeOJInxu7dj/Ke+/6zaSYLY8r+mts4OIjR3k5IoLblAZz0+uZZ2XDMc1Tlkr0TDo
	 I5B0UFcLatQvIXhI6VAcqIUS+4lqe5L8Hfx96XCy2tnQVlbLDFv8ZO2tVJwuF2RHuy
	 WQAcMIWA0X72OweLzTkKaCykvk0rfMfkhfZMvbAUg39DlmAYsySa6iuzxlVjMk8+RO
	 C1w2IOM9w6E3bykUDrIMhv1R7ZdZA5dJXnzvby/KcmNq7YuRv14iaU8/pDbIgkBYkA
	 /ltftOxB7eDPg==
Date: Tue, 29 Oct 2024 15:18:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 3/3] fs: port files to file_ref
Message-ID: <20241029-funkverkehr-erstversorgung-a73ca1841fd2@brauner>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
 <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
 <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com>
 <20241028-umschalten-anzweifeln-e6444dee7ce2@brauner>
 <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>

On Mon, Oct 28, 2024 at 08:30:39AM -1000, Linus Torvalds wrote:
> On Mon, 28 Oct 2024 at 01:17, Christian Brauner <brauner@kernel.org> wrote:
> >
> > Thanks for catching this. So what I did is:
> 
> You had better remove the __randomize_layout from 'struct file' too,
> otherwise your patch is entirely broken.

Yeah, it has actively been baffling me why this ever made it to struct
file in the first place.

> 
> We should damn well remove it anyway, the whole struct randomization
> is just a bad joke. Nobody sane enables it, afaik. But for your patch
> in particular, it's now an active bug.

I'm aware and so I did end up just initializing things manually instead
of the proposed patch. We do always call init_file() and we do
initialize a bunch of field in there already anyway. So might just as
well do the rest of the fields.

> 
> Also, I wonder if we would be better off with f_count _away_ from the
> other fields we touch, because the file count ref always ends up
> making it cpu-local, so no shared caching behavior. We had that
> reported for the inode contents.
> 
> So any threaded use of the same file will end up bouncing not just the
> refcount, but also won't be caching some of the useful info at the
> beginning of the file, that is basically read-only and could be shared
> across CPUs.

Yes, I'm aware of that and I commented on that in the commit message
that we will likely end up reordering fields to prevent such false
sharing.

