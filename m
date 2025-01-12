Return-Path: <linux-fsdevel+bounces-38988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D0A0AB66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191FA163CB4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42A1C07CF;
	Sun, 12 Jan 2025 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdBhyjQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9315278E;
	Sun, 12 Jan 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736705522; cv=none; b=VZGLgH+pJ5E5JKZ6ipBpxRzij9rkWfW0XRLdh8IhmLJ2WVHFvdnRHcSkAH6WA7xMsfAzaY7eUK788ODriHRNd68+Jx+3TjwWnQAnXh16uWhqlbw16i/Nghsb/w1Gl7ErI4HbHkbecGoBOxR4sSYTEkEZKAhNoeQj/Sh8EnITVYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736705522; c=relaxed/simple;
	bh=yYsFIniUJAsFQBpqPKu13hSoQ0FshXLlzQk2uT8sBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RygwldJzCWsHVUSj/iHjwprLrZrlrgk9hZ+wbr2OUjcFSf4HABK++FbwCIIBJpv+/tZmRXnud68sYR9LSFQp6CyMW1+c6HAv2FxuZsIpaBOZRKZ+YvIWeZaLH1pdlr39Ra3KhIImUoxNp2XX/MNtKERk34y/5WUrGZqe3aL/jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdBhyjQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69383C4CEDF;
	Sun, 12 Jan 2025 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736705522;
	bh=yYsFIniUJAsFQBpqPKu13hSoQ0FshXLlzQk2uT8sBwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdBhyjQKAM2UYd2uQAjmwIUN3j3LtZerkQB1Da04xh2RBxTKDmRO4y0/r+hTgd6EE
	 CqDLpNedy+xQ10dnqxOGkzCK6d3bxkc3LHr6yZZwITqWlIB6vYHnoduO3P/o8db5bp
	 5vOWbpSBj4YUr9LXnPaZJK+ISdx79JcATCVZshnQ+H2QfJQApSzvxujVEuQiNkGrMA
	 6iBmcMrkYPkNi89LCw7FRDfjKMf+T6Gii47OKVCOqhbLGJhTVPA1lP+Tc2n3vXd58y
	 /U4BeitxYxGrAqKO/Attko3hdCrqnNEI9RAtbLUetaSqTeQVzwWQzFmB9qOg0eV+Z3
	 p5xgJ+P49ir5Q==
Date: Sun, 12 Jan 2025 10:12:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Artem S. Tashkinov" <aros@gmx.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
Message-ID: <20250112181201.GL6156@frogsfrogsfrogs>
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
 <20250112052743.GH1323402@mit.edu>
 <Z4OufXVYupmI8yuN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4OufXVYupmI8yuN@casper.infradead.org>

On Sun, Jan 12, 2025 at 11:58:53AM +0000, Matthew Wilcox wrote:
> On Sun, Jan 12, 2025 at 12:27:43AM -0500, Theodore Ts'o wrote:
> > So yes, it basically exists, although in practice, it doesn't work as
> > well as you might think, because of the need to read potentially a
> > large number of the metdata blocks.  But for example, if you make sure
> > that all of the inode information is already cached, e.g.:
> > 
> >    ls -lR /path/to/large/tree > /dev/null
> > 
> > Then the operation to do a bulk update will be fast:
> > 
> >   time chown -R root:root /path/to/large/tree
> > 
> > This demonstrates that the bottleneck tends to be *reading* the
> > metdata blocks, not *writing* the metadata blocks.
> 
> So if we presented more of the operations to the kernel at once, it
> could pipeline the reading of the metadata, providing a user-visible
> win.
> 
> However, I don't know that we need a new user API to do it.  This is
> something that could be done in the "rm" tool; it has the information
> it needs, and it's better to put heuristics like "how far to read ahead"
> in userspace than the kernel.

nr_cpus=$(getconf _NPROCESSORS_ONLN)
find $path -print0 | xargs -P $nr_cpus -0 chown root:root

deltree is probably harder, because while you can easily parallelize
deleting the leaves, find isn't so good at telling you what are the
leaves.  I suppose you could do:

find $path ! -type d -print0 | xargs -P $nr_cpus -0 rm -f
rm -r -f $path

which would serialize on all the directories, but hopefully there aren't
that many of those?

FWIW as Amir said, xfs truncates and frees inodes in the background now
so most of the upfront overhead of rm -r -f is reading in metadata,
deleting directory entries, and putting the files on the unlinked list.

--D

