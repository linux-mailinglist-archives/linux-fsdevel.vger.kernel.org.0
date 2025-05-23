Return-Path: <linux-fsdevel+bounces-49798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C087AC2B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E322E3B5253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 21:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C73F202F79;
	Fri, 23 May 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QHTcvnGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DE7202C52
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035804; cv=none; b=Gap0UPfzG3KW6auWRpmuilvo+2NS3NPqxLbb/wm6ynB1UVFlurGriKlbbKxvLVV6bB+NW6ooM6QX0r9EM0naaFUT5iDxpStYNTP9MiPkykoQ6Z7hXEcVZQXzcF3HU24X5IiUfuGe3JwGoHhneGTTLMmmkb5lfgqBDQK9mCfIPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035804; c=relaxed/simple;
	bh=GzWaa32ueHI30c0Y2w5L31cZWOoRZq5gYw4tDabgfsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ3v1C1sNKcn6fM3Kv+wTN4Nl9neUbI6+5SQmWnT/lwFzHxZMf5IJMHqZMGsJN2nzBKyyBj/2IAe0AlZJ0Jaht4q/G202T9FdJMXPdi4kj7DmlQMXQMnUqgv19tozxoyn0gb2FvLq+Hg8I7auZQPeUJXFmnZvjbDoDkGwXOoIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QHTcvnGI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Ho9hIQLAmiWB1yf2Xt5/tUfqiMONGzWMvE4dwrbO3I=; b=QHTcvnGIfopDlyaAEAPB9loEj3
	HB+nGYF6gbR/NXeg3O82soJdsrViW5SYuNH7oVCCiF9qEAR7xAfO6q+dhErAjXCnnViWhayyw/ZQL
	VcwBA0qx1GjljlOiA1c1nJYFBE6/Xw4asMBPvwsetJSKFU5g82sfYqY3VzcpFgAtWc4s77zCVtdNI
	4hXohlgpkM+b9KOOXO/uag4rj8o+FXQ61faG6ArwTfOkbw1HEjwjszb1yc/BJQ9ppDWU+m1X85dok
	Mdr61ZKMHnZwzoxDRzBP4wZ/s8mk7kP61JrXm3qwzrB+KQb5ye4V5HiC2oNCj6FTKQCa6DnVbvZiY
	X6g13hRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIZxm-0000000FIoW-3BAw;
	Fri, 23 May 2025 21:29:58 +0000
Date: Fri, 23 May 2025 22:29:58 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250523212958.GJ2023217@ZenIV>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
 <20250523063238.GI2023217@ZenIV>
 <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 23, 2025 at 10:41:14AM +0200, Christian Brauner wrote:
> On Fri, May 23, 2025 at 07:32:38AM +0100, Al Viro wrote:
> > On Thu, May 15, 2025 at 01:25:27PM +0200, Christian Brauner wrote:
> > 
> > > Al, I want to kill this again and restore the pre v6.15 behavior.
> > > Allowing mount propagation for detached trees was a crazy
> > > idea on my part. It's a pain and it regresses userspace. If composefs is
> > > broken by this then systemd will absolutely get broken by my change as
> > > well.
> > > 
> > > Something like this will allow to restore the status-quo:
> > 
> > > -#define IS_MNT_NEW(m) (!(m)->mnt_ns)
> > > +#define IS_MNT_NEW(m) (!(m)->mnt_ns || is_anon_ns((m)->mnt_ns))
> > 
> > FWIW, I'm not sure that ever had been quite correct, no matter how you
> > call the macro.  I'm not up to building a counterexample right now,
> > will do in the morning...
> 
> The point is that we can't do mount propagation with detached trees
> without regressing userspace. And we didn't do it before. I don't
> specifically care how we block this but it needs to go out again.
> Otherwise we release a kernel with the new semantics that regress
> userspace.

The problem is not in propagation *into* detached trees.  All you need
is
	A -> B -> C
(all in your normal namespace, nothing detached, etc.) followed by make-private
on B.

C should (and does) keep getting events from A.  Now, have open_tree() create
a detached clone of B.  Shouldn't affect anything between A, B and C, right?

With your patch doing open_tree before make-private B ends up with
no propagation from A to C... until the detached tree is closed.

See the problem?  You have nodes on detached trees still in propagation graph.
And your variant _stops_ propagation at nodes in anon namespaces, not just
skips such nodes themselves.

This is bogus, IMO.  I'm perfectly fine with propagate_one() returning 0
on anon_ns(m->mnt); that would refuse to propagate into *any* anon ns,
but won't screw the propagation between the mounts that are in normal, non-anon
namespaces.

