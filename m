Return-Path: <linux-fsdevel+bounces-24651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4776942482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C221F2444B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7A101C4;
	Wed, 31 Jul 2024 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZmR8iT5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C17748D
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393157; cv=none; b=TwGjG/CAvdKcOsVlTqy6142W73h94Dw7GhoesVb1Xf3ojBXcsWIJTLm5tLt5tDwe4BDTNQdI3ITQy91NREMrhPKOrN58Em/gTAZBGXIpygux//XWDGZBe/jO/q2tI30vm7kzC1C6d53DAj3WQafEQDSp+JsbS4KPRufF4iHWO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393157; c=relaxed/simple;
	bh=xCTL3LGMLQsU1WzASRPuBgv9x/JsRqj+iDbcca9b7Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Ba/6y+BCktsFLBEjGdeVnOFN4jZb1w/iEdSRFY91AN+gR7g1r81YU5ZkPHvk7H8r4AunL+bhox0oHNi8SgOtqtCyzyJL50PT/xtyaWV/E7SSgaEopkKy9o8ICxmoSgxRrMdk67zMaHvKn0WeAjCbhgIM1UEhwU3JBunI7dn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ZmR8iT5R; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46V2W8m0012113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 22:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722393134; bh=qnE57OT8Z0B+Ssv02mdrM/u+vEgcKzKQXjaCPzcW6oI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZmR8iT5RFT6erOD9fXHkKb7jaPp7O/KfuPeE68q66cZV/ecFF01ULO1CPGSTI8NQ+
	 S5TfuhEzcPk40rGX8tJ/yWUQ9+0sSzhjbXmBUxNYGwWWKa4E2NRwkKkbFHDfUx/9Zn
	 NM6cJN8BRtcuHUSJ1J7WPSO3MuS3Ski4CofinmVmM3/6qpdysavT8gI+jVBvLoLbms
	 gJN1Z8Rlv1w6B1rUmDoa3A/RBNFGml+AdcoAwShNCD2p0VVyIgHrcJkU4SnJrGfest
	 PkmrvzbvpAXnOU1csaX+59bNIMuonqnAUTgD8eZETTCND9iE57/TZjm7AfI/Y2Iypg
	 av7B3Crbf+6mg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8A2A215C032D; Tue, 30 Jul 2024 22:32:08 -0400 (EDT)
Date: Tue, 30 Jul 2024 22:32:08 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Paul Eggert <eggert@cs.ucla.edu>,
        libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240731023208.GD719392@mit.edu>
References: <20240729160951.GA30183@lst.de>
 <87a5i0krml.fsf@oldenburg.str.redhat.com>
 <20240729184430.GA1010@lst.de>
 <877cd4jajz.fsf@oldenburg.str.redhat.com>
 <20240729190100.GA1664@lst.de>
 <8734nsj93p.fsf@oldenburg.str.redhat.com>
 <20240730154730.GA30157@lst.de>
 <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
 <20240730162042.GA31109@lst.de>
 <87o76ezua1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o76ezua1.fsf@oldenburg.str.redhat.com>

On Tue, Jul 30, 2024 at 07:03:50PM +0200, Florian Weimer wrote:
> 
> At the very least, we should have a variant of ftruncate that never
> truncates, likely under the fallocate umbrella.  It seems that that's
> how posix_fallocate is used sometimes, for avoiding SIGBUS with mmap.
> To these use cases, whether extents are allocated or not does not
> matter.

Personally, what I advise any application authors I come across is
simply tell them to avoid using posix_fallocate(2) altogether; the
semantics are totally broken, as is common with anything mandated by a
committee that was trying to satify multiple legacy Unix
implementations.  And so, relying on it just going to be fraught.

What I tell them to do instead is to use the Linux fallocate(2) system
call directly, which is well-defined, and if the file system doesn't
support fallocate, and fallocate(2) returns ENOSPC, that the userspace
application should either accept the fact it won't be able to allocate
the space, or if it really needs to avoid things like the SIGBUS with
mmap(2), to have the userspace application do the zero-fill writes
itself.

So honestly, is it worth it to try "fixing" posix_fallocate(2)?  Just
tell people to avoid it like the plague....  That way, we don't have
to worry about breaking existing legacy applications.

If we are going to stick with the existing Linux fallocate(2) system
call, then the problem is trying to have the system mind-read about
what the application writer really was trying to get when they call
fallocate(2) --- are they trying to avoid SIGBUS with mmap?  Or are
they trying to guarantee that any writes to that file range will never
fail with ENOSPC (even in the face of something like dm-thin being in
the storage stack).  And so the solution is simple; we can define new
flag bits to the fallocate(2) system call to make it be explicit
exactly what the application is requesting of the system.

Adding new fallocate(2) flag bits seems to be a more general solution
adding a new ftruncate(2) variant,

In addition, we can also add a new flag which requests the file system
passes the allocation request down to the thin provisioned storage
(aassuming that this is something that is supported).  Although I'm
not sure how much this matters; after all, for decades there have been
thin-provisioned NetApp storage appliances where fallocate(2) or
posix_falloate(2) wouldn't necessarily guarantee a thin-provisioned
device might run out of space on a write(2), and application authors
seem to have been willing to live with it.  Still, if people really
want this to work, even in the face of a file system which supports
copy-on-write cloned ranges, then presumably this new fallocate(2)
system call with the "never shall a write fail with ENOSPC" bit set,
can also snap the COW region as well.  It's important, though, that
this be done usinga new fallocate(2) flag, as opposed to have this
magically be added to the existing fallocate(2) system call, since
that will likely cause surprises for some applications.

     	  	       		     - Ted

