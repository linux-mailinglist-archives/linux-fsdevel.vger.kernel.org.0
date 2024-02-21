Return-Path: <linux-fsdevel+bounces-12353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079E85E96F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40711F22C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B4126F0B;
	Wed, 21 Feb 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GN1UAiLa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CD86646
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549508; cv=none; b=LOm/nEU5xcELs28Oyd+phMzaQt/MOeYCWmLG4pVybtvmfftg9F6/2Fd6KDAsGxRIquoUGrAG2CnG7RiJt7/7TaC5E4fo39LZxAqrwXtTlPdE9WSC/0mj9lImajJKlciE29HrBRVZxS43arPtYN9v6OnQgrM9Gd6bn+oECba7OGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549508; c=relaxed/simple;
	bh=43K2olQjRDLoK2JMYHwSGAyFBao6TRTJN3RH0Z7TSso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpk5NBZccV3DYtac70B3eqGmt2pYKH9pNlfR/vEiH0LDDoRL7oUeFwhlOeXjNkWQ0paJyG5pOIkr1YWwifg7moqAtG71d+gucSM0lyECEEWKkSh5SVinvf+Bp6WO3Pj4Ym5RqtUfo3eyQ7ZITJQzzOIgQLwuoDftHXIjRmfQpfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GN1UAiLa; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 21 Feb 2024 16:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708549504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTsivf6BMqQt+BMiZsHRmWuFS0uMyL6NGhUqEyvJOuc=;
	b=GN1UAiLazx0hAHCknbnw+5J5Jk4KgDCGiMBtjacLlmDCfCDnypK0OiNv0O54sjDEFM5cDr
	Owr9egG5ffC6VA2iPwiYqkMRQMHQENEgUoGGmJQSMXAeDpv/iI8/f6RUH2jXdW1/yZ+gqg
	+dXYq/BJcaIgLAfpcT1URpK4q5B5Fvg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	NeilBrown <neilb@suse.de>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems &
 more
Message-ID: <l4o3zai7j5a4g3masz3a4tah3lji3bnro7vylcuitleixjmg4p@j4bpnwffgldg>
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Recently we had a pretty long discussion on statx extensions, which
> > eventually got a bit offtopic but nevertheless hashed out all the major
> > issues.
> >
> > To summarize:
> >  - guaranteeing inode number uniqueness is becoming increasingly
> >    infeasible, we need a bit to tell userspace "inode number is not
> >    unique, use filehandle instead"
> 
> This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> together uniquely identify the file within the system."
> 
> Adding a bit that says "from now the above POSIX rule is invalid"
> doesn't instantly fix all the existing applications that rely on it.

Even POSIX must bend when faced with reality. 64 bits is getting
uncomfortably cramped already and with filesystems getting bigger it's
going to break sooner or later.

We don't want to be abusing st_dev, and snapshots and inode number
sharding mean we're basically out of bits today.

> doing (see documentation) is generally the right direction.  It makes
> various compromises but not to uniqueness, and we haven't had
> complaints (fingers crossed).

I haven't seen anything in overlayfs that looked like a real solution,
just hacks that would break sooner or later if more filesystems are
being stacked.

> Nudging userspace developers to use file handles would also be good,
> but they should do so unconditionally, not based on a flag that has no
> well defined meaning.

If we define it, it has a perfectly well defined meaning.

I wouldn't be against telling userspace to use file handles
unconditionally; they should only need to query it for a file that has
handlinks, anyways.

But I think we _do_ need this bit, if nothing else, as exactly that
nudge.

