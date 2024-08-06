Return-Path: <linux-fsdevel+bounces-25095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961F1948DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85A11C23135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A391C37A1;
	Tue,  6 Aug 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGHyQujT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8D41C233E;
	Tue,  6 Aug 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944203; cv=none; b=kmhEStGOOBG2QEOk/J675loASU20t0OFjA1+LDj1faEhzQm6vnh6+WicG7Y9qy3M6VoPcjJKdIPNfKOtNqmDngF8v2RotlTRDsCc2Zimaxzx0Mu2Zw9h+FbDf6u26Pyz4n3UHmmxLp+werCUhivIJy44aRC/gBNbu7geI7Fyj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944203; c=relaxed/simple;
	bh=jz6yCqEVMFawe+him2biFxt4l/OkRAWECspSFfxLL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY5Rg9FUPR603GqOspjt3l++cT8iifZzV7xOes4HNE3uz+Ieu0qeRzwuHp6zcfxilGs6wDAL4G9aTAMNHDRVVYRZMIpGVK6q+SZfp06/PAg1DAeNlLD6NeqbUArA6mRDNNm7C6E7c5E3dwbStlooJoJmcY563mz8glnaWerm9yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGHyQujT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790BAC32786;
	Tue,  6 Aug 2024 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722944202;
	bh=jz6yCqEVMFawe+him2biFxt4l/OkRAWECspSFfxLL4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGHyQujT9p25T/dDGpPOCwaAu6ugowsI7Wbj+pBdopX8hFvFh8q05/MILFgRYlI4e
	 duGi/4Nqd7Hl7YUBmscIA98Y9Fe36WhoRV/Ta7RTP1dashKqLCZTwtFcfsb1ZBjOLn
	 2c3+c5YZlutK6puu1gFM6dbCmbnRw8N3k92v/2gvEHTk2jQhhNw2Tgd4A2gqxLDLW0
	 TVCxcQF+mzmcUmLlqWzTd4fTs/+EwmeN92AbK9Oq83En1AU47H2aBTY4e6XE9AdXiW
	 6OBr8WEZJwvWJmZczIoZQQ3eFTPEebJhu51nD05a2JiXK25BEoo2UXWLE2ai7P08Cb
	 ++bfQG+yTw6rQ==
Date: Tue, 6 Aug 2024 13:36:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle
 contention better
Message-ID: <20240806-moosbedeckt-laufbahn-b11f1488a0d6@brauner>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
 <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
 <r6gyrzb265f5w6sev6he3ctfjjh7wfhktzwxyylwwkeopkzkpj@fo3yp2lkgp7l>
 <CAGudoHHLcKoG6Y2Zzm34gLrtaXmtuMc=CPcVpVQUaJ1Ysz8EDQ@mail.gmail.com>
 <7ff040d4a0fb1634d3dc9282da014165a347dbb2.camel@kernel.org>
 <CAGudoHFn5Fu2JMJSnqrtEERQhbYmFLB7xR58iXeGJ9_n7oxw8Q@mail.gmail.com>
 <808181ffe87d83f8cb36ebb4afbf6cd90778c763.camel@kernel.org>
 <20240805-unser-viren-4f1860143b6e@brauner>
 <d011c2c46732cc0794e787196d71fb90477ff4b8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d011c2c46732cc0794e787196d71fb90477ff4b8.camel@kernel.org>

On Mon, Aug 05, 2024 at 08:52:28AM GMT, Jeff Layton wrote:
> On Mon, 2024-08-05 at 13:44 +0200, Christian Brauner wrote:
> > > Audit not my favorite area of the kernel to work in either. I don't see
> > > a good way to make it rcu-friendly, but I haven't looked too hard yet
> > > either. It would be nice to be able to do some of the auditing under
> > > rcu or spinlock.
> > 
> > For audit your main option is to dodge the problem and check whether
> > audit is active and only drop out of rcu if it is. That sidesteps the
> > problem. I'm somewhat certain that a lot of systems don't really have
> > audit active.
> > 
> 
> I did have an earlier version of 4/4 that checked audit_context() and
> stayed in RCU mode if it comes back NULL. I can resurrect that if you
> think it's worthwhile.

Let's at least see what it looks like. Maybe just use a helper local to
fs/namei.c that returns ECHILD if audit is available and 0 otherwise?

> > From a brief look at audit it would be quite involved to make it work
> > just under rcu. Not just because it does various allocation but it also
> > reads fscaps from disk and so on. That's not going to work unless we add
> > a vfs based fscaps cache similar to what we do for acls. I find that
> > very unlikely. 
> 
> Yeah. It wants to record a lot of (variable-length) information at very
> inconvenient times. I think we're sort of stuck with it though until
> someone has a vision on how to do this in a non-blocking way.
> 
> Handwavy thought: there is some similarity to tracepoints in what
> audit_inode does, and tracepoints are able to be called in all sorts of
> contexts. I wonder if we could leverage the same infrastructure
> somehow? The catch here is that we can't just drop audit records if
> things go wrong.

I can't say much about the tracepoint idea as I lack the necessary
details around their implementation.

I think the better way forward is a model with a fastpath and a
slowpath. Under RCU audit_inode() returns -ECHILD if it sees that it
neeeds to end up doing anything it couldn't do in a non-blocking way and
then path lookup can drop out of RCU and call audit_inode() again.

I think this wouldn't be extremly terrible. It would amount to adding a
flag to audit_inode() AUDIT_MAY_NOT_BLOCK and then on ECHILD
audit_inode() gets called again without that flag.

Over time if people are interested they could then make more and more
stuff available under rcu for audit.

