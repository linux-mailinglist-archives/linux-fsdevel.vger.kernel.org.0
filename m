Return-Path: <linux-fsdevel+bounces-5326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74880A58E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8C71F21157
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1F11E50B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvSOlLqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7071D552;
	Fri,  8 Dec 2023 13:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D31C433C9;
	Fri,  8 Dec 2023 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702043315;
	bh=HKakyx8zq6fOmZMYXMir1ka2znDXEo4ataLQzc31ar4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvSOlLqA2qq/XZBRLBixMaEvYWxt4NW3Lbbf2tJRbJnWW2vaiZptxhL0GhOW7ZTez
	 6AdtUtbjy2X6nFxvtSxXFxhhPK0V/RwrNvTTr4aTtdqOSBoaUgB3FT5kFpzp7AD5aa
	 7vhRx1i7jkWHdh+POPRxqmUX60WsoUnZZlxVuP3+jgL3qXcnMR9f4CszRcUbTS8h2j
	 ltzQu8O3/IlR/DztllzO/q7/RfhEr4OhDIqasNEZtfKcytZVuHbtkPqnnlo+dvGXET
	 h7790W94yku+ovP0+I9u5ZjjDu40FnVLp2usMbejEhdM5rfRgOGAb19mtxFBPcnsYf
	 YfCnL0ZORHRhQ==
Date: Fri, 8 Dec 2023 14:48:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <20231208-hitzig-charmant-6bbdc427bf7e@brauner>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
 <ZWjaSAhG9KI2i9NK@tycho.pizza>
 <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
 <87ttp3rprd.fsf@oldenburg.str.redhat.com>
 <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
 <87wmtog7ht.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmtog7ht.fsf@oldenburg.str.redhat.com>

On Fri, Dec 08, 2023 at 02:15:58PM +0100, Florian Weimer wrote:
> * Christian Brauner:
> 
> > File descriptors are reachable for all processes/threads that share a
> > file descriptor table. Changing that means breaking core userspace
> > assumptions about how file descriptors work. That's not going to happen
> > as far as I'm concerned.
> 
> It already has happened, though?  Threads are free to call
> unshare(CLONE_FILES).  I'm sure that we have applications out there that

If you unshare a file descriptor table it will affect all file
descriptors of a given task. We don't allow hiding individual or ranges
of file descriptors from close/dup. That's akin to a partially shared
file descriptor table which is conceptually probably doable but just
plain weird and nasty to get right imho.

This really is either LSM territory to block such operations or use
stuff like io_uring gives you.

