Return-Path: <linux-fsdevel+bounces-20555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF348D5191
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B75E28A0FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4031482D7;
	Thu, 30 May 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYEiP+1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412B224D4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091902; cv=none; b=RmDGZPx6OGzS7DGv4lM/3vHnc8FNBAqpJA2gDzuqkQX2jmXLyGpyoJksoFLFrmMqtu5YZRhIsCUJ6GkSR1198haodZavoZ+FN/FReMjc3Mh7rNlzX2VgzYv0RYUTebmskkglAZbyIp80ro/bp0SWMQYH6DFOscDjAD7GSK6IuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091902; c=relaxed/simple;
	bh=A1Y/pr/6li6bjB2ihduinpoMIcWHGvm1kvQW3uuD19o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhdOp1HKs0wD4CWwsWiewCUeDu+LwWQMKtNAtsIZNkdfANTMDWpD8vc8wFVBUJ0ykMlGFEtsNtJbebYba/HWOE5p5kVGBVY+Hbn4R2dfTToy7Cx+Qd13mYLk0WWKg8r8HPftvs8pwNJmP7+UUBeY+lcXi2RUUToQZkylfsvqafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYEiP+1F; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717091896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1Y/pr/6li6bjB2ihduinpoMIcWHGvm1kvQW3uuD19o=;
	b=GYEiP+1FctP5FtgCF6cHt+gAs/crZAlukd1ip8oze1YLxzQnHFZ7dn3/zPeHNtAlEirw8S
	DWBve9RLxK6BoxrEtDPAKVoe6L6Ji2Qg/LvF7Cq/cv2KYP3q+uauHrzv18s9hH7KbD15ZY
	iY7CjPfjRzp4LxcenUtiHNAVdFbg4yI=
X-Envelope-To: bernd.schubert@fastmail.fm
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
X-Envelope-To: ming.lei@redhat.com
X-Envelope-To: asml.silence@gmail.com
X-Envelope-To: josef@toxicpanda.com
Date: Thu, 30 May 2024 13:58:12 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
Message-ID: <ioqqlwed5pzaucsfwbnroun5rd2l3loqo53slmc5vos2ha5njm@5aqt6kglccx4>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <5mimjjxul2sc2g7x6pttnit46pbw3astwj2giqfr4xayp63el2@fb5bgtiavwgv>
 <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm>
 <9db5fc0c-cce5-4d01-af60-f28f55c3aa99@kernel.dk>
 <tpdo6jfuhouew6stoy7y7sy5dvzphetqic2tzf74c47vr7s5qi@c5ttwxatvwbi>
 <360b1a11-252d-48d9-a680-eda879b676a5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360b1a11-252d-48d9-a680-eda879b676a5@kernel.dk>
X-Migadu-Flow: FLOW_OUT

On Thu, May 30, 2024 at 11:28:43AM -0600, Jens Axboe wrote:
> I have addressed it several times in the past. tldr is that yeah the
> initial history of io_uring wasn't great, due to some unfortunate
> initial design choices (mostly around async worker setup and
> identities).

Not to pick on you too much but the initial history looked pretty messy
to me - a lot of layering violations - it made aio.c look clean.

I know you were in "get shit done" mode, but at some point we have to
take a step back and ask "what are the different core concepts being
expressed here, and can we start picking them apart?". A generic
ringbuffer would be a good place to start.

I'd also really like to see some more standardized mechanisms for "I'm a
kernel thread doing work on behalf of some other user thread" - this
comes up elsewhere, I'm talking with David Howells right now about
fsconfig which is another place it is or will be coming up.

> Those have since been rectified, and the code base is
> stable and solid these days.

good tests, code coverage analysis to verify, good syzbot coverage?

