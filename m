Return-Path: <linux-fsdevel+bounces-19823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796A38CA06E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE224B21734
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3C50248;
	Mon, 20 May 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILY1sWOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F728E7;
	Mon, 20 May 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220981; cv=none; b=aDte7AGmhinfqdbQyAWiugP56vup+OWlyAlksXFrqTFJ2E0Q1G6+LY7Be0u4HFYY25yaUG5OyS0jezcdHPu2pbddT7c8DT0KdWhdNw0QttxZdiymOVt/KbW+0bSI7tEir4ALkABedPV2qDiiqkf9AbDMbUh6HuF6rjgRX6Cw1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220981; c=relaxed/simple;
	bh=x4pQtNrsoD9GLUzcxphICTbPaHI4aq7I5znYggVn9t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up0p/PSpWfCJ/3cV4NHJtfHvWes0KysWqFMUrSF5tiAIkMy6g87IPk9sSWSctUU0TJxeXpsuNf57UevlxP29pUCog/wYKxBjjCJBmPfOTDxVeTJqzqvRPKL1E8mSw/UfuLirUYEBGc+ur4XH8HVr2HZ3dzCVJNBOqC27jbRwn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILY1sWOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5104EC2BD10;
	Mon, 20 May 2024 16:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716220981;
	bh=x4pQtNrsoD9GLUzcxphICTbPaHI4aq7I5znYggVn9t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILY1sWOun2yxTNj78UuuizIJB4E9D2O56aztH0eyLV0cZZsk/o2agJ81GZTKahxmK
	 RU3Uq/zpIMI0HS/HDdZJxjMISDwvSE9gZrH/pXPrvu9Dt6OCNqHMf3/FOhS84hcNuC
	 AAsUzOfURNTkr5GBRE9m/KGoezvflT3tGskzIGwAAq3gLFUgFM4PgkrUdrONTaU74d
	 kRNQE4ZyGC/n+OMPG2oMSp/gPNM81tdn9h76Ar2XodE8nhpTaKWrNALRVAci3VL56V
	 Tqh5x4UcQs8QvnQDUlVN2yzoh4M8VVE5y2xRxX7I8mq46ADgDtTvsGRAv+M8GAnj4D
	 mzYrfO3pi8quA==
Date: Mon, 20 May 2024 09:02:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240520160259.GA25546@frogsfrogsfrogs>
References: <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
 <20240509200250.GQ360919@frogsfrogsfrogs>
 <Zj2r0Ewrn-MqNKwc@infradead.org>
 <Zj28oXB6leJGem-9@infradead.org>
 <20240517171720.GA360919@frogsfrogsfrogs>
 <ZktEn5KOZTiy42c8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktEn5KOZTiy42c8@infradead.org>

On Mon, May 20, 2024 at 05:39:59AM -0700, Christoph Hellwig wrote:
> On Fri, May 17, 2024 at 10:17:20AM -0700, Darrick J. Wong wrote:
> > >   Note that the verity metadata *must* be encrypted when the file is,
> > >   since it contains hashes of the plaintext data.
> > 
> > Refresh my memory of fscrypt -- does it encrypt directory names, xattr
> > names, and xattr values too?  Or does it only do that to file data?
> 
> It does encrypt the file names in the directories, but nothing in
> xattrs as far as I can tell.

Do we want that for user.* attrs?  That seems like quite an omission.

> > And if we copy the ext4 method of putting the merkle data after eof and
> > loading it into the pagecache, how much of the generic fs/verity cleanup
> > patches do we really need?
> 
> We shouldn't need anything.  A bunch of cleanup

Should we do the read/drop_merkle_tree_block cleanup anyway?

One of the advantages of xfs caching merkle tree blocks ourselves
is that we neither extend the usage of PageChecked when merkle blocksize
== pagesize nor become subject to the 1-million merkle block limit when
merkle blocksize < pagesize.  There's a tripping hazard if you mount a 4k
merkle block filesystem on a computer with 64k pages -- now you can't
open 6T verity files.

That said, it also sounds dumb to maintain a separate index for
pagecache pages to track a single bit.  Maybe we should port verity to
use xbitmap64 from xfs instead of single static buffer?

>                                                 and the support for not
> generating a hash for holes might still be nice to have, though.

Yeah, though I think that's only usable for xfs if merkle blocksize ==
fs blocksize, since xfs doesn't store sub-fsblock unwritten state.

--D

