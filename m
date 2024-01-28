Return-Path: <linux-fsdevel+bounces-9250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA3B83F984
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 20:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41609B216AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CD3219F;
	Sun, 28 Jan 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lB5VtcFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1A31A94
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706470690; cv=none; b=n9YK2JJZups5SnNqorAC0dKYerwiTnoXtz/S1R54l56yidSNjSIK2ICeO4ym+v0dlKs7HYWZjbZRMzYqKEAvqzlAxvP7fB/sa4sfWqPKjMgtgcJxgEiTcsPKj+8TIP1cIGaUeEvt+z6XHNOmP5zacCpZLEmhZhNcNGlM+B5mR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706470690; c=relaxed/simple;
	bh=fX9kLBzWyB/CMt5krU9aRo2/9LWbOP//s9WREBYu03U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBkC2f3Mnsb7hfFC4zD7rW/NsqAu18JIDY+e+IiSvg30CR7Ar+t/nwZZ5ieuRhyTzDmXZtR9Q+XBQq4nrF5yI7P7PIcfyyz0pNcuO+2yIF5Zfxc/GpQ4Te1opeNY9pn0avHv6PDinW6wEc1ZDl1zfQlwqRrdFeG6rsQewTQwyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lB5VtcFy; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 28 Jan 2024 14:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706470686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/XSVKc6w+A+XmgwvfzwCcqpDMcWCgObA9/bvZvw48qU=;
	b=lB5VtcFy7aF6cpkgma6yez8sMpMAz/mpV/YD1xJVy1FuCar5hxpJTFi3bXxiuHfPR8T3mx
	7OqKn9T7SJlh2lOz/oCvxWjLIIlfuiaupGHKe3sIwWauc3J+ctzrPr+EvTIOTQ/AFWHEB7
	4LKC5jHFfK6Wrvnby/iaqtNonDci1xc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: boqun.feng@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 4/4] af_unix: convert to lock_cmp_fn
Message-ID: <suyvonwf55vfeumeujeats2mtozs2q4wcx6ijz4hqfd54mibjj@6dt26flhrfdh>
References: <20240127020833.487907-5-kent.overstreet@linux.dev>
 <20240128082838.3961-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128082838.3961-1-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jan 28, 2024 at 12:28:38AM -0800, Kuniyuki Iwashima wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> Date: Fri, 26 Jan 2024 21:08:31 -0500
> > Kill
> >  - unix_state_lock_nested
> >  - _nested usage for net->unx.table.locks[].
> > 
> > replace both with lock_set_cmp_fn_ptr_order(&u->lock).
> > 
> > The lock ordering in sk_diag_dump_icons() looks suspicious; this may
> > turn up a real issue.
> 
> Yes, you cannot use lock_cmp_fn() for unix_state_lock_nested().
> 
> The lock order in sk_diag_dump_icons() is
> 
>   listening socket -> child socket in the listener's queue
> 
> , and the inverse order never happens.  ptr comparison does not make
> sense in this case, and lockdep will complain about false positive.

Is that a real lock ordering? Is this parent -> child relationship well
defined?

If it is, we should be able to write a lock_cmp_fn for it, as long as
it's not some handwavy "this will never happen but _nested won't check
for it" like I saw elsewhere in the net code... :)

