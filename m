Return-Path: <linux-fsdevel+bounces-55456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DEDB0AA07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096794E5E21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203102E7F13;
	Fri, 18 Jul 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHRMq9In"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C22E7639
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862393; cv=none; b=omBs/oLyDqvh063slGdtJZxz7hidurRW02HQDO8qqN2SighHgCQwqHQiXKlNankPsuLe6q1YBIh6usxScslqnMeLCWNEndXUv5OsXtD+ZB7lKI5d1aB3wFyAA8PuJHmpqhsgHdS+kw4wWvVIx7at5/kuBj6HeP72oMplkDAj4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862393; c=relaxed/simple;
	bh=iabhphZdA6yjsH6AiWTq1+qubzhuR7rJTmmw9YR656Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/PcwfmOOlns3SB9rViwif5ivdNkuHMZaxS67HtsgwzO4QNVa/PxyVJh/LIocxUX1lzA7BuI2ufjxOCGzVklFM7M5XkkvJLFgfa1BQw5jhqEOiHQZ1jdw308hNi0GnV9GtcTGFBsKmhd6jUOfeazTr2Leq48afH4ieYHM3nShY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHRMq9In; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D52C4CEEB;
	Fri, 18 Jul 2025 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752862393;
	bh=iabhphZdA6yjsH6AiWTq1+qubzhuR7rJTmmw9YR656Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SHRMq9Inmh9sUioxEmlIiyGPCCk5zZPfLwjPbuEr3gEHIb2RFZff8VmI9aaL+V41t
	 k89qAg17+5BPMqmceFSldwQy2BBxGi4AfL03zf9yVVNazw9LwQnr0JOGbZhKC0jzh/
	 ZPwUW0B2xF4py31HLg8SOx7Tf7Vw1hVzuXnc8Opdc7V/vBDR8ZyfR9UrMKciS9Cspa
	 Q+yti+EQNZqJxEGnSjdlQSyZqOAL3xDlpuTV5RtcBS2mSEgAwB4d7Bg0uTVuSADZD0
	 JWY+gQB2CW870dK+7TR50F6pc3WRgS2x4LDExNHZ6voXMT3sIDJf96s4MFFA9vWIhG
	 dP3tv6BLBSzqg==
Date: Fri, 18 Jul 2025 11:13:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	miklos@szeredi.hu, joannelkoong@gmail.com
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
Message-ID: <20250718181312.GW2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449522.710975.4006041367649303770.stgit@frogsfrogsfrogs>
 <3f65b1e1-828a-4023-9c1d-0535caf7c4be@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f65b1e1-828a-4023-9c1d-0535caf7c4be@bsbernd.com>

On Fri, Jul 18, 2025 at 07:10:37PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/18/25 01:27, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > The fuse_request_{send,end} tracepoints capture the value of
> > req->in.h.unique in the trace output.  It would be really nice if we
> > could use this to match a request to its response for debugging and
> > latency analysis, but the call to trace_fuse_request_send occurs before
> > the unique id has been set:
> > 
> > fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
> > fuse_request_end:     connection 8388608 req 6 len 16 error -2
> > 
> > Move the callsites to trace_fuse_request_send to after the unique id has
> > been set, or right before we decide to cancel a request having not set
> > one.
> 
> Sorry, my fault, I have a branch for that already. Just occupied and
> then just didn't send v4.
> 
> https://lore.kernel.org/all/20250403-fuse-io-uring-trace-points-v3-0-35340aa31d9c@ddn.com/

(Aha, that was before I started paying attention to the fuse patches on
fsdevel.)

> The updated branch is here
> 
> https://github.com/bsbernd/linux/commits/fuse-io-uring-trace-points/
> 
> Objections if we go with that version, as it adds a few more tracepoints
> and removes the lock to get the unique ID.

Let me look through the branch --

 * fuse: Make the fuse unique value a per-cpu counter

Is there any reason you didn't use percpu_counter_init() ?  It does the
same per-cpu batching that (I think) your version does.

 * fuse: Set request unique on allocation
 * fuse: {io-uring} Avoid _send code dup

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

 * fuse: fine-grained request ftraces

Are these three new tracepoints exactly identical except in name?
If you declare an event class for them, that will save a lot of memory
(~5K per tracepoint according to rostedt) over definining them
individually.

 * per cpu cntr fix

I think you can avoid this if you use the kernel struct percpu_counter.

--D

