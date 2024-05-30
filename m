Return-Path: <linux-fsdevel+bounces-20539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC868D4FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F51C21DC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 16:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4C210E7;
	Thu, 30 May 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZDqoIibk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A73208A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085410; cv=none; b=iJzjuyB7p2FsEsGl3Ep2pwfoBNou+OEzbhVVb1yv/Hi+7VJ2KBlJLXLILi3IgR4e9ZB75H8zVh2WGtFBJioNJRHLCsBPFffp/w+H/NU/f/SLJcl9lLyCvbe6Zy4R3FQs0lfZyvhQbM5FGhChG3HBmnXRUMJnr/VtdAZao4zWZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085410; c=relaxed/simple;
	bh=eky9KFR1Nfbhxq2hpON/XxipQzCyHD4DlpmijR76MDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxefdSnXxDH/ksuPyjN8TWNU6C+BIX+DVY5jBgYZbkjnq6lXRb0kPPdx4Op+Eg1J4XD8f5Gq/ajebpUrI4bahxFnAB85aNMOs9y7UHQcCI/17L0qEkbGgclDH4dgIxOns2y3+JtLw8TClGVbIGPJAZQKPOv3lZ/TqyNcqL8gE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZDqoIibk; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bernd.schubert@fastmail.fm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717085406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiTcEP6Pa5LKEim0NuYDG7k+chuGfMv3rkOy5FDKhZA=;
	b=ZDqoIibkVoem+zw2/+b7DjzDNmz86Nc1mXnpxY0UeCByeQ3sCqsAOWadn1A4EVP8S3jIUk
	vuPvMBysx/Ztlw0nj5XlH7zUzkJo6S7DDfbk6YMlZS2bCbaecAec7HWpdAiMpOQGeSleOA
	TpY9tOkou+qrYwabw+7lZbbzJrBHMbw=
X-Envelope-To: bschubert@ddn.com
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: amir73il@gmail.com
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: avagin@google.com
X-Envelope-To: io-uring@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: asml.silence@gmail.com
X-Envelope-To: josef@toxicpanda.com
Date: Thu, 30 May 2024 12:10:00 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
Message-ID: <owccqrazlyfo2zcsprxr7bhpgjrh4km3xlc4ku2aqhqhlqhtyj@djlwwccmlwhw>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <5mimjjxul2sc2g7x6pttnit46pbw3astwj2giqfr4xayp63el2@fb5bgtiavwgv>
 <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm>
X-Migadu-Flow: FLOW_OUT

On Thu, May 30, 2024 at 06:02:21PM +0200, Bernd Schubert wrote:
> Hmm, initially I had thought about writing my own ring buffer, but then 
> io-uring got IORING_OP_URING_CMD, which seems to have exactly what we
> need? From interface point of view, io-uring seems easy to use here, 
> has everything we need and kind of the same thing is used for ublk - 
> what speaks against io-uring? And what other suggestion do you have?
> 
> I guess the same concern would also apply to ublk_drv. 
> 
> Well, decoupling from io-uring might help to get for zero-copy, as there
> doesn't seem to be an agreement with Mings approaches (sorry I'm only
> silently following for now).
> 
> From our side, a customer has pointed out security concerns for io-uring. 
> My thinking so far was to implemented the required io-uring pieces into 
> an module and access it with ioctls... Which would also allow to
> backport it to RHEL8/RHEL9.

Well, I've been starting to sketch out a ringbuffer() syscall, which
would work on any (supported) file descriptor and give you a ringbuffer
for reading or writing (or call it twice for both).

That seems to be what fuse really wants, no? You're already using a file
descriptor and your own RPC format, you just want a faster
communications channel.

