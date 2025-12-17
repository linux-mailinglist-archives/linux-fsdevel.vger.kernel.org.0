Return-Path: <linux-fsdevel+bounces-71547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B6CC7489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8AE2310092D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED834844F;
	Wed, 17 Dec 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vr2PS9XL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF034321D;
	Wed, 17 Dec 2025 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965932; cv=none; b=f9lDyR5jEQSVvXSB9iGLJmcRFAzwIR5V4xicyKQd/u/zWPwnmO8wEt9xZlmpzJFc0XYtkzas5tit/dR1sdGvWLgALtPJUo4oJwF5Ft5LPqkrUmv7BREamtFGfmn+fpT5hVNqsXnV6yTqJu0qTFONA4k4VrarV4nISosXFqnmzew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965932; c=relaxed/simple;
	bh=rGv74+siSNJFt8dgrH7blgn+LbjbbjzG7WytWqSTU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdp1JwyTS/aIIBp07e3+6Aq+fqw6JwgHbUdlbqkzPUVV7HGq0zUoE+9ekD5BkXgGuozlwehGcrSo2e4WPAd9FP9ZirozcmRoK9tfLKmSKwWeBCFbadAbq/HXr/OFr5e+r7S4Ekk24VVCTBu7vNP3XlD5X346ih6lkXyk9bucvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vr2PS9XL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=2VQ+Ha7ydeLFOxLPx4vqajJ6vBS5KmmxAj9dwhtCY1o=; b=vr2PS9XLOGEQeGl6JzdGr6tsTA
	DXCGLIvEsQRc9MGI9tYr1SnMlWBIbCwVzItH7GT/Dz3BlkPdSSylBufa1HzX+M+/rdQOm0q2BS2vp
	EFM7Ha1g1M0ypa2MxqBcjAkOWTBFMECp2ZMP0J6jUcYN/JVAazlCkXGGDw6EkrB5rMyXFUhQE7crf
	yxAZkRMZsxDU0TUjW/mHmgtWCpaAoc3KAW4WV469hIIJNiDku9NqvGGGa4k6NB0+5lvsyWJKrmQ2J
	B3zKF6+nRjxo+hJev9zS+ldQ96yzq40FPDfRCpgGruSKlGelYfRSkzzmK4DZE2EqIK97K0yVh3HO1
	cO39zMmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vVoQ1-0000000EdIg-0Ubb;
	Wed, 17 Dec 2025 10:06:05 +0000
Date: Wed, 17 Dec 2025 10:06:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, clm@meta.com
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
Message-ID: <20251217100605.GT1712166@ZenIV>
References: <20251217084704.2323682-1-mjguzik@gmail.com>
 <20251217090833.GS1712166@ZenIV>
 <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 17, 2025 at 10:11:04AM +0100, Mateusz Guzik wrote:
> On Wed, Dec 17, 2025 at 10:07 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Dec 17, 2025 at 09:47:04AM +0100, Mateusz Guzik wrote:
> > > One remaining weirdness is terminate_walk() walking the symlink stack
> > > after drop_links().
> >
> > What weirdness?  If we are not in RCU mode, we need to drop symlink bodies
> > *and* drop symlink references?
> 
> One would expect a routine named drop_links() would handle the
> entirety of clean up of symlinks.
> 
> Seeing how it only handles some of it, it should be renamed to better
> indicate what it is doing, but that's a potential clean up for later.

Take a look at the callers.  All 3 of them.

1) terminate_walk(): drop all symlink bodies, in non-RCU mode drop
all paths as well.

2) a couple in legitimize_links(): *always* called in RCU mode.  That's
the whole point - trying to grab references to a bunch of dentries/mounts,
so that we could continue in non-RCU mode from that point on.  What should
we do if we'd grabbed some of those references, but failed halfway through
the stack?

We *can't* do path_put() there - not under rcu_read_lock().  And we can't
delay dropping the link bodies past rcu_read_unlock().

Note that this state has
	nd->depth link bodies in stack, all need to be droped before
rcu_read_unlock()
	first K link references in stack that need to be dropped after
rcu_read_unlock()
	nd->depth - K link references in stack that do _not_ need to
be dropped.

Solution: have link bodies dropped, callbacks cleared and nd->depth
reset to K.  The caller of legitimate_links() immediately drops out
of RCU mode and we proceed to terminate_walk(), same as we would
on an error in non-RCU mode.

This case is on a slow path; we could microoptimize it, but result
would be really harder to understand.

