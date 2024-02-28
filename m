Return-Path: <linux-fsdevel+bounces-13142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5F86BC3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C0F286F08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB2C70055;
	Wed, 28 Feb 2024 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LtAr9CAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24513D2EC
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163254; cv=none; b=RgtE66h48zD7i8gxe4VKVHHEh42v5mj4Knp31WunlggO7R3Qi9cQPCnFdaV7zXroaQe+9n0tMQ6/YGlrwl5ihGNlCwr1U5ZbKlN5OhMqkAMZltYToQ4/3xvz2jXPBzuel1NMpVpNS9fiilvYrn7mhnyH3dlK/qe8BwqrrTtppEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163254; c=relaxed/simple;
	bh=Moml5CruD20uJWNnLu5BMjX4/RhS8SagolaWVoHDD18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/pcGfqqXPGJUPQNwNrNVySxbDeb6+O2ZZ6EFJdqD9d2Bwzoegcq0I8bCuRCqpuKqAQ8on2GTcTPT8ErSGJwd4KCzIKdkVqMQRr6vucBh7IkuUOZsFMBDSF2ckXHeUkdDPBaK999peHkr9pJXUVTj4meAskuPeszzphihplAdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LtAr9CAe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41SNXtho015776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709163237; bh=Cw9owdyW56cAXnWXdSRMc6KqAjpPFWobVCNSzlRNVrA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LtAr9CAeCbJZfDGyZYqTwGLxIt4xeZAduEgnfNyhZ5iTGc+t5YYiBfkTo5Sx4lonE
	 lSbfrSehNqyXSEokd64cQeKBrj/hGjEup+QinNRDW2oQzAzTLvUbQE63zKjhyGDWdn
	 GnMzPd4BInw9LHeOhWR02xo8kLw0dhG43+ZAsQ+fcDN74Nwu4E/leI4+buqe1eY+pn
	 gKO24Pbyb48KLF8lKHOVxJlM53nliSBc0e3eugbrEZQIiCO9LaJBM/fLwnBowKCZd8
	 i+robjRUT2OAxKgR1wMmGwO79Aaxx/pPjd4BAFrIHKQqa/g2gzcQtxdWGYgcQCbntS
	 fb1vQkxptF9hQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0538F3404B0; Wed, 28 Feb 2024 17:33:55 -0600 (CST)
Date: Wed, 28 Feb 2024 17:33:54 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <20240228233354.GC177082@mit.edu>
References: <20240228061257.GA106651@mit.edu>
 <Zd8--pYHdnjefncj@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd8--pYHdnjefncj@casper.infradead.org>

On Wed, Feb 28, 2024 at 02:11:06PM +0000, Matthew Wilcox wrote:
> I'm not entirely sure that it does become a mess.  If our implementation
> of this ensures that each write ends up in a single folio (even if the
> entire folio is larger than the write), then we will have satisfied the
> semantics of the flag.

What if we do a 32k write which spans two folios?  And what
if the physical pages for those 32k in the buffer cache are not
contiguous?  Are you going to have to join the two 16k folios
together, or maybe two 8k folios and an 16k folio, and relocate pages
to make a contiguous 32k folio when we do a buffered RWF_ATOMIC write
of size 32k?

Folios have to consist of physically contiguous pages, right?  But we
can do send a single 32k write request using scatter-gather even if
the pages are not physically contiguous.  So it would seem to me that
trying to overload the folio size to represent the "atomic write
guarantee" of RWF_ATOMIC seems unwise.

(And yes, the database might not need it to be 32k untorn write, but
what if it sends a 32k write, for example because it's writing a set
of pages to the database journal file?  The RWF_ATOMIC interface
doesn't *know* what is really required, the only thing it knows is the
overly strong guarantees that we set in the definition of that
interface.  Or are we going to make the RWF_ATOMIC interface fail all
writes that aren't exactly 16k?  That seems.... baroque.)

> I think we'd be better off treating RWF_ATOMIC like it's a bs>PS device.
> That takes two somewhat special cases and makes them use the same code
> paths, which probably means fewer bugs as both camps will be testing
> the same code.

But for a bs > PS device, where the logical block size is greater than
the page size, you don't need the RWF_ATOMIC flag at all.  All direct
I/O writes *must* be a multiple of the logical sector size, and
buffered writes, if they are smaller than the block size, *must* be
handled as a read-modify-write, since you can't send writes to the
device smaller than the logical sector size.

This is why I claim that LBS devices and untorn writes are largely
orthogonal; for LBS devices no special API is needed at all, and
certainly not the highly problematic RWF_ATOMIC API that has been
proposed.  (Well, not problematic for Direct I/O, which is what we had
originally focused upon, but highly problematic for buffered I/O.)

	   	   	     	    		    - Ted

