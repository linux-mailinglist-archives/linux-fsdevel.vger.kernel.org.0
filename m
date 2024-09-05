Return-Path: <linux-fsdevel+bounces-28740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF996DADC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07292287EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5919D8AA;
	Thu,  5 Sep 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="h1S+UO08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA12145B10
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544467; cv=none; b=NUXrmIbFXKWr+RIbE4U5kz5FZXKHXWU2pRMXnbCOM5k3XOqc87QTKAWn+5pIvI7OOfOVE83oEtVYu6ltr1Jrt2NUL2Iz1vI5rmfNznSItNQtKLNhM8Heuk8Z9I5X4gD0Dm1F2FGyV/qStgI31AC+FE49qZrnDkIAk6HvxImz5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544467; c=relaxed/simple;
	bh=89eTR3ds69z8RUvRwzGHLCMj5E0DqW6ePx39Zak+vtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoWytsyVyVikcTRio35FKnzbvBmZM+W4oksKOFl4iR/g3Tx45nDvc0fH1cyJkxJmmZxvQH+dFIJxYMXVHOxd72wvHZi9+j8qIGfpC0tDr1R3n0iDK/j6FTNjcs5Zjuc6aSb1AAd+UHZ33PyLTVgodZBt++ldbOFpwDdlzOpXYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=h1S+UO08; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485DrQUd030840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 09:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725544412; bh=XBNj3KHe7DuZpKVxVCA9zURNDJAF8QFjg3YArsA6zRA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=h1S+UO08dOUuPvbuUYg4xCtN3hwTpd8U8iHTnZ57kQtu3ngdZyMQCrpxb0cVl1hnO
	 kAnh0KhRN6gOt/MKk2OzgdPPZ6JcXoVdichJUmxDnCgZ9L9Dzi7YxTUZcKKCxDp+go
	 TNSKBU696FyLxDtUULiBYhT7JSyEaHO9FBP1mQOb9aRmdGbh25Qt9ISUgVS48X2nk0
	 mJ6bowqneHcB9SZu+dxoYfOYPOrf7cGeCKq9YjTkAgkoBxYW7jBMjacelHLhkBu4QH
	 sxLy0OBwi7QsAUdbWSLkct+8+Xls9RBw/tcEjLCNt/OYnbL6t3na9M4BU7jQsIc6PA
	 pTfxwI1xAeGyQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7501415C02C6; Thu, 05 Sep 2024 09:53:26 -0400 (EDT)
Date: Thu, 5 Sep 2024 09:53:26 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Michal Hocko <mhocko@suse.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
        jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <20240905135326.GU9627@mit.edu>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <qlkjvxqdm72ijaaiauifgsnyzx3mw4edl2hexfabnsdncvpyhd@dvxliffsmkl6>
 <ZtgI1bKhE3imqE5s@tiehlicka>
 <xjtcom43unuubdtzj7pudew3m5yk34jdrhim5nynvoalk3bgbu@4aohsslg5c5m>
 <ZtiOyJ1vjY3OjAUv@tiehlicka>
 <pmvxqqj5e6a2hdlyscmi36rcuf4kn37ry4ofdsp4aahpw223nk@lskmdcwkjeob>
 <ZtmVej0fbVxrGPVz@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtmVej0fbVxrGPVz@tiehlicka>

On Thu, Sep 05, 2024 at 01:26:50PM +0200, Michal Hocko wrote:
> > > > > This is exactly GFP_KERNEL semantic for low order allocations or
> > > > > kvmalloc for that matter. They simply never fail unless couple of corner
> > > > > cases - e.g. the allocating task is an oom victim and all of the oom
> > > > > memory reserves have been consumed. This is where we call "not possible
> > > > > to allocate".
> > > > 
> > > > Which does beg the question of why GFP_NOFAIL exists.
> > > 
> > > Exactly for the reason that even rare failure is not acceptable and
> > > there is no way to handle it other than keep retrying. Typical code was 
> > > 	while (!(ptr = kmalloc()))
> > > 		;
> > 
> > But is it _rare_ failure, or _no_ failure?
> >
> > You seem to be saying (and I just reviewed the code, it looks like
> > you're right) that there is essentially no difference in behaviour
> > between GFP_KERNEL and GFP_NOFAIL.

That may be the currrent state of affiars; but is it
****guaranteed**** forever and ever, amen, that GFP_KERNEL will never
fail if the amount of memory allocated was lower than a particular
multiple of the page size?  If so, what is that size?  I've checked,
and this is not documented in the formal interface.

> The fundamental difference is that (appart from unsupported allocation
> mode/size) the latter never returns NULL and you can rely on that fact.
> Our docummentation says:
>  * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
>  * cannot handle allocation failures. The allocation could block
>  * indefinitely but will never return with failure. Testing for
>  * failure is pointless.

So if the documentation is going to give similar guarantees, as
opposed to it being an accident of the current implementation that is
subject to change at any time, then sure, we can probably get away
with all or most of ext4's uses of __GFP_NOFAIL.  But I don't want to
do that and then have a "Lucy and Charlie Brown" moment from the
Peanuts comics strip where the football suddenly gets snatched away
from us[1] (and many file sytem users will be very, very sad and/or
angry).

[1] https://www.cracked.com/article_37831_good-grief-how-lucy-pulling-the-football-away-from-charlie-brown-became-a-signature-peanuts-gag.html

It might be that other file systems have requirements which isblarger
than the not-formally-defined GFP_KMALLOC guarantee, but it's true we
can probably reduce the usage of GFP_NOFAIL if this guarantee is
formalized.

						- Ted

