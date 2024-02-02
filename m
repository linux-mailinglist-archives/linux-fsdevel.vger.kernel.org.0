Return-Path: <linux-fsdevel+bounces-9977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA39846CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5761F255A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6CB79DB0;
	Fri,  2 Feb 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UpZI7/dm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3614182C5
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867034; cv=none; b=WPFQKEVcpU3Fm9ZRf/VTNWK085EV5YrGyjoEeytGT1SHR2FHdzULRUwDvYy5HcWCpZknmxTll0/+kTf4Hb5iPp9G/KmxNH4xfcGxUPnFGO+EqLL8InAP6e1ZbTPlCkQYWcRKX3ht2TpjRWKmdvKiPxjX4mzqZGI9aDWqkxJcmdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867034; c=relaxed/simple;
	bh=3f9D1y6PVibqHXEEwAA7mOJ7IK9aNhYWeugtRpv2jJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukZ8+Xh89KfHnCIOEv1SsgFSGSPavLroGbpY+ST1OxCG83O00rQ+OzvWNfk4pWg7piayGKIDJmhL5f1gRgdmdJvvIhp93wJGiVod1BOevhi4Y1/kqwD+nMnVKmsJG78RmC15He2FlXc8OKMIA3vHM4MjRJAH1TApWWdK0G1E0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UpZI7/dm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 2 Feb 2024 04:43:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706867020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cP0oRR5YByefU6AaquqTNRU3Kc+VM9PTtupCs9QuvV4=;
	b=UpZI7/dmWBH+yc92OxbMLYekpoU7Zx9sJST7r/+Iuxm72I/jn439rkK2l8rSZNgc1lNCR0
	sIcoCdTlkcuTmWlR5XMy1OHg8qA1uW5eIF7J6lePTjIRKoE4SU4TDKs6QN8b1aEyI1UgaJ
	B8z+l7rD5CAJ1eS5g3QWwQ2X36hXNUo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org, 
	Matthew Wilcox <willy@infradead.org>, dwmw2@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
Message-ID: <upsunciif2s554by65dpx6e5iw76ksl44jnqzssamv4wi422gr@pxyqmtyrpue4>
References: <2701318.1706863882@warthog.procyon.org.uk>
 <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 02, 2024 at 10:08:59AM +0100, Miklos Szeredi wrote:
> On Fri, 2 Feb 2024 at 09:51, David Howells <dhowells@redhat.com> wrote:
> >
> > Hi,
> >
> > We have various locks, mutexes, etc., that are taken on entry to filesystem
> > code, for example, and a bunch of them are taken interruptibly or killably (or
> > ought to be) - but filesystem code might be called into from uninterruptible
> > code, such as the memory allocator, fscache, etc..
> 
> Are you suggesting to make lots more filesystem/vfs/mm sleeps
> killable?  That would present problems with being called from certain
> contexts.
> 
> Or are there bugs already?

I believe it's both.

Potentially we could get rid of e.g. mutex_lock_interruptible() and
mutex_lock_killable() so our API surface goes down, and I've seen at
least one bug where we were checking for a signal pending and bailing
out where we really didn't want to be.

I think we'd need the new API prototyped in order to have a concrete
discussion though.

