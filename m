Return-Path: <linux-fsdevel+bounces-60472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C6B482B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 04:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DEA16D624
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3E1DF74F;
	Mon,  8 Sep 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P+hTpgzV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C835947
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757299900; cv=none; b=C9FNVK1hCgztEqStgP6THcBFEKdxyVwPyrnaCUBUQCvMVYFGynEJjeMfIaPBqLxnDt5gAfwN/PVlPaU9O47CY9LOnIqYT2mxMvlhDyE+XY09AYjPc750ulsx1MescPFDSfeJvBLSk4PHnD9BH1hEZ5EsKrGIBDr8GgFLrUJ481Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757299900; c=relaxed/simple;
	bh=BIdFIBzPtj86MMuVFvb+/q8N4lYfmuAda8XTIjGrBEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF5yvWiUg5dFKS5w2lzS9BsGEbqPV4jLdl18yVIFFGg5XiWlZt+Y4A92Lgf/vFOBfqiwdcHwxG6g/nAARerERKNIgibW/Oxz0+2/BX47InIFCyNHL43NVr7d9qfHnS5E7fGSSXv4bHlQJxsS+HZup8Y5F3unC9s4xa7ZOeHnnEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P+hTpgzV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7JuMC3D6U6F7AmOe8rzzgyjfjnf6BOyPdV7tpsRN6Tw=; b=P+hTpgzVoxBAvJ/tlwIzosCbiz
	ym8qslnntJXxRNhk3uTxNEeA3727ocZ+tOkkSL5I/zA9FlA/cMd8YoOPlSqvYf9Klpqjg6KmDU5EV
	VFvnQ3BpuBJ45Jsk5EVYl9vW/Opy9hPxvTUKpHbaGS21+Gjoua/bUMu86j6ipBtWZyQly/Yte1IhS
	qQMenz1CcieMNcL1u4rQnYd5Y8AFD3Mb72g2pVGpXRYAMgfN/dxAvKY9avShwTV0b15We+y1tzmao
	zkdX3BBGfWBeFnUa+A+Q4PkbY1B+LQJxgrtKMYB0PLlBFQ26ZzZM3hND7vb1XDL+vzawQyK/YGh8l
	7wYgWi/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvRyh-0000000CQM4-1EPs;
	Mon, 08 Sep 2025 02:51:35 +0000
Date: Mon, 8 Sep 2025 03:51:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250908025135.GG31600@ZenIV>
References: <20250907203255.GE31600@ZenIV>
 <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
 <20250908000617.GF31600@ZenIV>
 <CAHk-=wiDHb4Q4tJwOJqDYJd=L_0kJeYrYq3x0W9fEpDcUoCQHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDHb4Q4tJwOJqDYJd=L_0kJeYrYq3x0W9fEpDcUoCQHA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 07, 2025 at 05:47:31PM -0700, Linus Torvalds wrote:
> On Sun, 7 Sept 2025 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:

> I would expect that you *only* do this for the functions where the
> name isn't stable (ie it's called without the parent locked).
> 
> So rmdir/mknod/link/etc would continue to just pass the dentry,
> because the name is stable and filesystems using dentry->d_name is
> perfectly fine.

Absolute majority of those ~800 hits *are* in those or in functions
called only from them.

> Ie we'd end up using take_dentry_name_snapshot().
> 
> Would that be horribly bad?

In some cases we'll have to (trace shite, mostly - racy, but not "the
sky is falling" stuff), but that (and any real crap) drowns in the
false positives.

> Don't a lot of routines already have the parent locked - all the
> normal functions where we actually _modify_ the directory - so the
> name is stable. No?

Yes, it is.

> Then, the other thing we could do is just mark "struct qstr d_name" as
> 'const' in struct dentry, and then the (very very few) places that
> actually modify the name will have to use an alias to do the
> modification.

Yes, and I have that (that's what I mentioned as the first and easy part
of those audits - see #work.qstr, doing exactly that).

> Wouldn't that deal with at least a majority of the worries of people
> playing games?
> 
> This is where you go "Oh, Linus, you sweet summer child", and shake
> your head. You've been walking through the call-chains, I haven't.

The problem is that a regression (e.g. somebody suddenly starting to read
->d_name in their ->open() or ->setattr(), or... - we had such cases) is
always possible and the way the things are it's fucking hard to spot.

Most of the uses *are* done to stable dentries; it's just that we have no
way to tell which ones are like that.  That's exactly the reason why I'm
thinking about such annotations.  The only way to catch regressions is
to grep, go over the list and manually verify that all of those places
still are reachable only from the "safe" methods.  Worse, comparing
the grep output from the previous cycle (modulo line number shifts,
etc.) doesn't help - if you have one in a function 3 levels down from a
method and its caller grows an extra call site, you would see nothing
in the diff anywhere near the places where ->d_name is used or any of
the directory methods.

I'm not so worried about anyone malicious - honest fuckups happen and
AFAICS all of them so far had been of that sort.  I would really like
to be able to find such fuckups without ~8--12 hours of digging;
needs breaks, too, since it's monotonous enough to cause something
similar to highway hypnosis, IME ;-/

