Return-Path: <linux-fsdevel+bounces-32477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92049A68AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D852B1C20ECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A231F5850;
	Mon, 21 Oct 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEGYXcO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED31F4FDA
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514317; cv=none; b=II6YmehLhW3hPy46HldKd0XIiJt1gTl/ht9XYzDnzKQQoCSiyzPpeRUYR66vA8nsyXc5hqMQCRiw8SPcJsfCPe1hpYlbHw22wkAR+YdVWwue+73LFZiOpkFP04KD8oXpCGyWTtVWA3EVhwI69ePv7fPNCewAwFLT6rIuwtHEzSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514317; c=relaxed/simple;
	bh=qpVausC3ml4a2DJ/STiDa+QpmNrbtsnBiHt+Rk9zC20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZhgUHHQ69vQ+tkk9MKDvNfgr1TJg6QldT2HHzTb0l5G9crKe6qDuxDt17USavUyVXmhi/LeZ9Z1WvPhLfGY8DAmONTCZtz5fQeoNk9uKyVMgK0qc7KgoS9beTCQo4xxvhkoaoCNx3rjC429cG60MCSHCE+bP1Q6T4PR/+336ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEGYXcO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9AAC4CEE5;
	Mon, 21 Oct 2024 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514317;
	bh=qpVausC3ml4a2DJ/STiDa+QpmNrbtsnBiHt+Rk9zC20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEGYXcO1tdr0Jl/De5onjKDYAazQMrYLo/a4GF2mjUkEdHX2EDDm0u7jmGj/T6tzV
	 VOUZ2WgywlVXNpZYZcT4SJkmHUN6mxnfxFeRsI3Y/4Ei+SvQPUUl9PqBdU0yYZkUCk
	 IEAbzJrAOwvlSzd8WfAY/H+loCG+XKRIp2QA70Lj4Mmm78JL8iebDwVcJfdBFyhAgr
	 f08VaQXfFTB0G5doIb6TRYWBZq4XV1ZArt+7YT6zM/MLSw+mP9Z0ehrivURrpvPepm
	 CKyVKZr6zLpvdQ4HtBVl6+N8vTAazu/JO49xR5+w0Cqmusp4BJjxU8JTMgA3k2zPei
	 PEOhk2/r0Q/3Q==
Date: Mon, 21 Oct 2024 14:38:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021-quast-relaxen-05a71dc5a445@brauner>
References: <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
 <20241019171118.GE1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241019171118.GE1172273@ZenIV>

On Sat, Oct 19, 2024 at 06:11:18PM +0100, Al Viro wrote:
> On Sat, Oct 19, 2024 at 09:15:32AM -0700, Linus Torvalds wrote:
> 
> > IOW, I think the (NULL, AT_EMPTY_PATH) tuple makes sense as a way to
> > pass just an 'fd', but I'm _not_ convinced it makes sense as a way to
> > pass in AT_FDCWD.
> > 
> > Put another way: imagine you have a silly library implementation that does
> > 
> >     #define fstat(fd,buf) fstatat(fd, NULL, buf, AT_EMPTY_PATH)
> > 
> > and I think *that* is what we want to support. But if 'fd' is not a
> > valid fd, you should get -EBADF, not "fstat of current working
> > directlry".
> > 
> > Hmm?
> 
> There'd been an example of live use of that posted upthread:
> 
> https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71
> 
> "" rather than NULL, but...

Which I think is really broken testing nonsense anyway so really we
could easily get them to change this and not even have to worry about
this. We've done stuff like that before. But I'm fine either way.

