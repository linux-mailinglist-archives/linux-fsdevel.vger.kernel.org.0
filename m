Return-Path: <linux-fsdevel+bounces-65525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4ADC06D01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790CF1C23093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6D2580DE;
	Fri, 24 Oct 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLepm41x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB121323C;
	Fri, 24 Oct 2025 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317666; cv=none; b=Wt4j4VQ/FHpmMLbr6QXnDCqhzQxBBMuYic/9XswoqQZd8D0EfmLy3ACwONiunf3/7Flk5IU7zZlMvZTQ5Lkn7gNg+1pf+mDFfbTqSvKmLxHDIqTnxClAV2va6jOMYYvAU6bz12fm9k2A/yHiz53sCkvcKrBHTgMpyf3Xx0KjIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317666; c=relaxed/simple;
	bh=QCuErcoHkMUtqZQSuo3uLUgI7AVMoP/uLuwfJx/I91o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iep4HiQNdx/CA41pY3gDso38ekhAznU1w8x8cPYNq2/v3SFslTUwBVXsfuGmmyM1r7daRUQDiKlqDSwtOr/CspOQRj7XM1bS8Oo5rwnX3Wtgp9XI0iW6ib06ncqL1wRdMD7sO6kjr4wEUH4lty+PZG/wKwIDIFyZ3xcJGlx/V6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLepm41x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB180C4CEF5;
	Fri, 24 Oct 2025 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761317665;
	bh=QCuErcoHkMUtqZQSuo3uLUgI7AVMoP/uLuwfJx/I91o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLepm41xerG9DOHd/e4SyjCd92AXhNFocFrtqhZkcZ59mnkMFuEUpbt3yil9Mijku
	 rmRJQnKB0fMVs/PI2WswGgCaTMbHKBe7G33+CQcGqBAdsgPt8U96683B3UPnrG/XFi
	 8Uibt36FZV6It3i2eaxl2wWEHgyFJHvlWqa6b3Yhf896G/MupJ5JQRYzgMdZRE5cCZ
	 2DimPYPqkoSlgi2x9EX4c4iso8VaVz31XTMOm1uHKYDCi7zlaLcG8QpYXpUmN04Y2G
	 HUOXrE8iTGvR/5/jFjE61DjfMmlwK5ukPT8nLXNMFtLyrVHc2BqnDr5O/OYC8c8Sbv
	 ODnIA2jLOsWvA==
Date: Fri, 24 Oct 2025 16:54:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
Message-ID: <20251024-seemeilen-flott-bffe304f560b@brauner>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
 <97bb1f9baba905e0e8bde62cce858b0def091d5c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97bb1f9baba905e0e8bde62cce858b0def091d5c.camel@kernel.org>

> > So that punches a whole in the active reference count tracking. So this
> > will have to be handled as right now socket file descriptors that pin a
> > network namespace that don't have an active reference anymore (no live
> > processes, not explicit persistence via namespace fds) can't be used to
> > issue a SIOCGSKNS ioctl() to open the associated network namespace.
> > 
> 
> Is this capability something we need to preserve? It seems like the
> fact that SIOCGSKNS works when there are no active references left
> might have been an accident. Is there a legit use-case for allowing
> that?

I've solved that use-case now and have added a large testsuite to verify
that it works.

> 
> I don't see a problem with active+passive refcounts. They're more
> complicated to deal with, but we've used them elsewhere so it's a
> pattern we all know (even if we don't necessarily love them).

+1

> I'll also point out that net namespaces already have two refcounts for
> this exact reason. Do you plan to replace the passive refcount in
> struct net with the new passive refcount you're implementing here?

Yeah, that's an option. I think that in the future it should also be
possible to completely drop the net/ internal network namespace tracking
and rely on the nstree infrastructure only. But that's work for the
future.

> 
> > So two options I see if the api is based on ids:
> > 
> > (1) We use the active reference count and somehow also make it work with
> >     sockets.
> > (2) The active reference count is not needed and we say that listns() is
> >     an introspection system call anyway so we just always list
> >     namespaces regardless of why they are still pinned: files,
> >     mm_struct, network devices, everything is fair game.
> > (3) Throw hands up in the air and just not do it.
> > 
> 
> Is listns() the only reason we'd need a active/passive refcounts? It
> seems like we might need them for other reasons (e.g. struct net).

Yes.

> IMO, even if you keep the active+passive refcounts, it would be good to
> be able to tell listns() to return all the namespaces, and not just the
> ones that are still active. Maybe that can be the first flag for this
> new syscall?

Certainly possible but that would be pure introspection. But as I said
elsewhere, I have implemented the nstree infrastructure in a way that
it will allow bpf to walk the namespace trees and that would obviously
also include all namespaces that are not active anymore. 


