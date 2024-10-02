Return-Path: <linux-fsdevel+bounces-30781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A53B98E428
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42890B21125
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC13216A34;
	Wed,  2 Oct 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u9FxHfDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1EC1D0DE9
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900925; cv=none; b=U09zncPlyv5aXV2am9TEUGspxVcVBpzxlVW5VEyD4bHRNxRMshdVS06z6386otAAAgHEtLBCAZapx9xOtjdAvVfVana6hQf3HOuIGgbPveXnS1vyBsR+i/gIXaeywAi3lTDFSoO5SuhXY5NesJZ5C+yEsJupHmmz9FCwTFMRv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900925; c=relaxed/simple;
	bh=u7epyHgrXNNPgoaTNce3zowVHT8mqM/hjL9tq+IwRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCSfskrRxqUqPiDLcCw/4+W6pcAAg+/O9shO2leMCZaZdNrseOV5q8HOAivcp2AcgX941ZnU2+a2uMj8x/xrKmD47Q5RLqkEzjLSBNFnECR687qEyU4zeFmpIyYhEFrvt3Bxc7/zetEbbr+404O6wq/9bkyOwvFB7VVz91A3Ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u9FxHfDi; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 16:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727900921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDAEh5a6x1sIzQQsYJRE3WTSv5uPargztvqJnvAoJ0k=;
	b=u9FxHfDibLMSk6ke7KCejYY+hF6zfgKFGePO7emesQ9F08apjLTTZx/+a+3mtgsRKpfYJs
	gp2GII8FeT3SWD9e0Haam4lYhU301V/qVl+kwjQB+XNq8mbAuJl+sXh+j9DDtqoCgDkahB
	7CdZHM3auqCSC+HFutl80XqRW4zthSo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 02, 2024 at 12:49:13PM GMT, Linus Torvalds wrote:
> On Wed, 2 Oct 2024 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> >
> > > I don't have big conceptual issues with the series otherwise. The only
> > > thing that makes me a bit uneasy is that we are now providing an api
> > > that may encourage filesystems to do their own inode caching even if
> > > they don't really have a need for it just because it's there.  So really
> > > a way that would've solved this issue generically would have been my
> > > preference.
> >
> > Well, that's the problem, isn't it? :/
> >
> > There really isn't a good generic solution for global list access
> > and management.  The dlist stuff kinda works, but it still has
> > significant overhead and doesn't get rid of spinlock contention
> > completely because of the lack of locality between list add and
> > remove operations.
> 
> I much prefer the approach taken in your patch series, to let the
> filesystem own the inode list and keeping the old model as the
> "default list".
> 
> In many ways, that is how *most* of the VFS layer works - it exposes
> helper functions that the filesystems can use (and most do), but
> doesn't force them.
> 
> Yes, the VFS layer does force some things - you can't avoid using
> dentries, for example, because that's literally how the VFS layer
> deals with filenames (and things like mounting etc). And honestly, the
> VFS layer does a better job of filename caching than any filesystem
> really can do, and with the whole UNIX mount model, filenames
> fundamentally cross filesystem boundaries anyway.
> 
> But clearly the VFS layer inode list handling isn't the best it can
> be, and unless we can fix that in some fundamental way (and I don't
> love the "let's use crazy lists instead of a simple one" models) I do
> think that just letting filesystems do their own thing if they have
> something better is a good model.

Well, I don't love adding more indirection and callbacks.

The underlying approach in this patchset of "just use the inode hash
table if that's available" - that I _do_ like, but this seems like
the wrong way to go about it, we're significantly adding to the amount
of special purpose "things" filesystems have to do if they want to
perform well.

Converting the standard inode hash table to an rhashtable (or more
likely, creating a new standard implementation and converting
filesystems one at a time) still needs to happen, and then the "use the
hash table for iteration" approach could use that without every
filesystem having to specialize.

Failing that, or even regardless, I think we do need either dlock-list
or fast-list. "I need some sort of generic list, but fast" is something
I've seen come up way too many times.

