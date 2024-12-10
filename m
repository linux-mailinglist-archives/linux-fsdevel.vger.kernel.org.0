Return-Path: <linux-fsdevel+bounces-36974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF2B9EB89B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF55162CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107138634A;
	Tue, 10 Dec 2024 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GvFuag23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DE23ED5F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852895; cv=none; b=TZANF88jb4ODEluckBSKila9Khk5yjL/VZAyLazabWURtJBub6fujPDQWnOtmx3hV3MuoEi5D9TwKorBRkGZ8AHloUuGZjbfFFq3Z4utcoflJGnbqZA5Jr5f7IoL+zaDX7qqEWoYP/3zAJ8/k+2aU2SROp6nqNo5zhZ7fsKZVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852895; c=relaxed/simple;
	bh=IniIb9wf8leEh0eRbL9efdwPPi4p/67cAa3lmMvtFso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTkAhd2GhHr2V6J3mQ6d4f9MN4yQ5wDlY2cThURxD+sfsiy9gILnInfkGn4nrt10VRozyBNyFZ0P3DJQGfRgXajt6Og+uqNAyahcxXMsLbkLf7KCHOfRXSEj61Z8MDK6IfZ356EMcbtG0N0vqvJj0DN6GpqWac5k411maB+V2hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GvFuag23; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Dec 2024 12:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733852891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rttSw8XLykKtNbJpffW0QKW6zU8VjhP2ZygZysCIRUk=;
	b=GvFuag23ADtHGHAEnb7YUOQaGpRRgTgv9pA3A8BQIrAfK1u6vgtuGBI/64dawsrwdToExZ
	fdHETi9gMs0sY8zLfP4GQNmWk0wiJwr7g51zhNMTtnLpOcZzvyvBt0WXLawTrt/XmFpkmg
	IJuZ2FouJwCMZisjlgdui98UdSYpmk0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <uux26jxzm6dqoxvn45mu2kdwa5tdw6lebmzy7mn7izbhcqxt7g@axhtjbcki25e>
References: <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
 <20241209154850.GA2843669@perftesting>
 <4707aea6-addb-4dc3-96f7-691d2e94ab25@tnxip.de>
 <CAJnrk1apXjQw7LEgSTmjt1xywzjp=+QMfYva4k1x=H0q2S6mag@mail.gmail.com>
 <CAJnrk1YfeNNpt2puwaMRcpDefMVg1AhjYNY4ZsKNqr85=WLXDg@mail.gmail.com>
 <CAJnrk1aF-_N6aBHbuWz0e+z=B4cH3GjZZ60yHRPbctMMG6Ukxw@mail.gmail.com>
 <wfxmi5sqxwoiflnxokte5su2jycoefhgjm4pcp5e7lb5xe4nbd@4lqnzu2r2vmj>
 <20241210173151.GA2932546@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210173151.GA2932546@perftesting>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 10, 2024 at 12:31:51PM -0500, Josef Bacik wrote:
> This is a failure in testing.  And I don't mean "Joanne obviously didn't test
> this", I mean that we as a file system community forget that fstests isn't as
> exhaustive as we think.  I was honestly surprised to see that we don't actually
> have anything that purposely allocates large folios and then does O_DIRECT with
> them.  Now we know, Joanne already has followups for extending fsx to purposely
> allocate large folios so we can have testing coverage for this case.  Yay
> software development, we find gaps, we plug them, we move on.

Yeah, agreed.

Code coverage analysis would've also likely pointed this out.

