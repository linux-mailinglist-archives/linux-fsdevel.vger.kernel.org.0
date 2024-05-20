Return-Path: <linux-fsdevel+bounces-19852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94648CA5DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913441F218AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF327101F2;
	Tue, 21 May 2024 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EsxrTMEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A07C8E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255320; cv=none; b=NcCmLQz/nnZSGjOiM3z6xXXBlunOKuO9Lu4P7beIK72uf4NgpRqmvT5B2+wz//OymUiG1XswNPdhxN+n/OXxYyTj1zCw/BLb2ktrwJNTjiTv6yfy5wMpMWQxVmApGJN86czl4qTd1J/kOXekVgBFwnakT8hdeLMH4rxVpmFqzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255320; c=relaxed/simple;
	bh=GZvg6qIVVRe4Tn0OqMp/t+emZBIh8LVggvkdXbw2s3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/1bBY0qxAWOdD3fCUBEdEfxAbNfaaFj4wBOQO87YGtrph9Wu7jhWiDUSHu3acvP0AGmrH5d2jn7CdA4idKeeWcekqN/cYHojrRLDhGT2oyIpDXeEnQI22N7GUIKRESKhCQWcw/l8i+Pj34q0xzZ3qzvRoA0d+E4dC9NBXUfwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EsxrTMEo; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44L1Yl4a002946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 21:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1716255288; bh=vZnvRw73C6FL22j1ckxJCtMB5MIs3YjZkV+PCrgUi/A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=EsxrTMEoeDCsIYqaQo3moICu8P18Fp6NyAjQC+EWhDthO44lG6CpY1UIDRoqPm5k3
	 a3aWB0LM8OH2AsPZkeMDs5Lz4BDVmlwLRHBbexUi0Amjv8LLj0Hd1zu/WiQB22hjmq
	 VxbaPV+ReiCHS3a7Ek/S0E9cG3IjWtYGcaraFXNtpMbnDKxWne9O0sxV0KybV4ppSn
	 vZWtGGWfou0eUxYxHPZOA6pzRXErV1kmKSeJbNqfvkZN0YlR+YdwxM8QBFgD/kRYdt
	 FOOftg47nlXzGLWYTaPE4ldCutDHEbSXJE0Cz2skAX5d3MUgD/i9XKDbgcxkL7jSI0
	 ni1ADaMbFW5oA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6928D3409CD; Mon, 20 May 2024 00:58:20 -0400 (EDT)
Date: Mon, 20 May 2024 00:58:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240520045820.GA1017232@mit.edu>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
 <20240520132326.52392f8d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520132326.52392f8d@canb.auug.org.au>

On Mon, May 20, 2024 at 01:23:26PM +1000, Stephen Rothwell wrote:
> On Tue, 14 May 2024 23:57:36 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > At LSFMM we're talking about the need to do more integrated testing with
> > the various fs trees, the fs infrastructure and the vfs.  We'd like to
> > avoid that testing be blocked by a bad patch in, say, a graphics driver.
> > 
> > A solution we're kicking around would be for linux-next to include a
> > 'fs-next' branch which contains the trees which have opted into this
> > new branch.  Would this be tremendously disruptive to your workflow or
> > would this be an easy addition?
> 
> How would this be different from what happens at the moment with all
> the separate file system trees and the various "vfs" trees?  I can
> include any tree.

What we were hoping for was that you would merge together the vfs,
iomap, and various fs-specific trees (e.g., bcachefs, btrfs, ext4,
f2fs, xfs, etc.) together, and then publish it as "fs-next".

You could then use fs-next as something that would be merged into
linux-next instead of the component fs trees, so hopefully it wouldn't
be a significant amount of extra work for you.

As Willy stated, the advantages of having an official daily "fs-next"
tree is that multiple file system developers would be able to test the
same branch and compare notes when regressions are found.  And the
advantage of fs-next versus the full linux-next is that it reduces the
chances of tests getting blocked by non-fs-relevant changes.

Cheers,

					- Ted

