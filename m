Return-Path: <linux-fsdevel+bounces-17672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903708B14F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 22:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426031F23AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE90156C40;
	Wed, 24 Apr 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAcJojcm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B92156991;
	Wed, 24 Apr 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992383; cv=none; b=moFl+ZAr8MQWMn2vyAFN+NBeInTAa8AZKoNc4aYgrXlUB/LobdrdLn9coWBp2d/VzNaP2eBQGPEdI4Ig/Qezdmb/ggrqrnXOnq/qYu50/XvpvqDyobUoRX/YmF7UT9CNKVwubwfCO/GMuBS+Yyc0vGTPMdeV26dvDGKgRtfcydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992383; c=relaxed/simple;
	bh=poQjUdR+ED3x6rhuUZ2OdPcuE8Vz4ArVRzNyvCxyngI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIR8kpYKRibUaWoJPC6+9oWfMm82RYCnNpSRkQQxNoL8u/a2W0yq4CJNDtt61HOCafi06QOgoTLvER/Cr7lblxmQ35gAThqHuQr5BJ/CYDnWWqjGPrQ46IE8V+2X2f46ytQxKxX0S/51+W0eA511NMasSOR6CWigyFAlyayCrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAcJojcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A6C113CD;
	Wed, 24 Apr 2024 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992383;
	bh=poQjUdR+ED3x6rhuUZ2OdPcuE8Vz4ArVRzNyvCxyngI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAcJojcm+FEmBCKHHoTbCF5av9wj7Rh0n6M27yDHKFxtAsPaxVXiHducQ+rpUg4m3
	 M2PPAM2bZJFc5oGa6iMu6L1oQQ6mqtbhXGUMckpp5jlD5ayrra8Q7jU8KspexOuGfW
	 ulH4oqSz1dxYqZONwDjgSdMaEz/ztFHkSLtKxiKdHcpQimdushRmlGA4RVlJG+HzM/
	 fBj7xbMoNUfLdFPP6qzMMFXsMyp+vm7+60ZXhfKtVudWjZFRfO56l4begTKGux8Cm/
	 5Zsde4OZ7j4xzphBrbw+t3LgcGVSqwisXwoU7T1TutC22r1CnJrGBd9bRS/qhjkONj
	 Dg3F/iYW0ELAg==
Date: Wed, 24 Apr 2024 20:59:41 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 10/13] fsverity: pass the zero-hash value to the
 implementation
Message-ID: <20240424205941.GB749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868031.1987804.13138670908694064691.stgit@frogsfrogsfrogs>
 <20240405025750.GH1958@quark.localdomain>
 <20240424190246.GL360919@frogsfrogsfrogs>
 <20240424191950.GA749176@google.com>
 <20240424202348.GN360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424202348.GN360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 01:23:48PM -0700, Darrick J. Wong wrote:
> > > How about "the hash of an i_blocksize-sized buffer of zeroes" for all
> > > three?
> > 
> > It's the Merkle tree block size, not the filesystem block size.  Or did you
> > actually intend for this to use the filesystem block size?
> 
> I actually did intend for this to be the fs block size, not the merkle
> tree block size.  It's the bottom level that I care about shrinking.
> Let's say that data[0-B] are the data blocks:
> 
> root
>  +-internal0
>  |   +-leaf0
>  |   |   +-data0
>  |   |   +-data1
>  |   |   `-data2
>  |   `-leaf1
>  |       +-data3
>  |       +-data4
>  |       `-data5
>  `-internal1
>      +-leaf2
>      |   +-data6
>      |   +-data7
>      |   `-data8
>      `-leaf3
>          +-data9
>          +-dataA
>          `-dataB
> 
> (thanks to https://arthursonzogni.com/Diagon/#Tree )
> 
> If data[3-5] are completely zeroes (unwritten blocks, sparse holes,
> etc.) then I want to skip writing leaf1 of the merkle tree to disk.
> 
> If it happens that the hashes of leaf[0-1] match hash(data3) then it's
> frosting on top (as it were) that we can also skip internal0.  However,
> the merkle tree has a high fanout factor (4096/32==128 in the common
> case), so I care /much/ less about eliding those levels.
> 
> > In struct merkle_tree_params, the "block size" is always the Merkle tree block
> > size, so the type of block size seems clear in that context.  My complaint was
> > just that it used the term "data block" to mean a block that is not necessarily
> > a file contents block (which is what "data block" means elsewhere).
> 
> Hm.  Given the confusion, would it help if I said that zero_digest
> should only be used to elide leaf nodes of the merkle tree that hash the
> contents of file content blocks?  Or is "the hash of an
> i_blocksize-sized buffer of zeroes" sufficient?
> 
> What do you think of the commit message saying:
> 
> "Compute the hash of one filesystem block's worth of zeroes.  Any merkle
> tree leaf block containing only this hash can be elided at write time,
> and its contents synthesized at read time.
> 
> "Let's pretend that there's a file containing six data blocks and whose
> merkle tree looks roughly like this:
> 
> root
>  +--leaf0
>  |   +--data0
>  |   +--data1
>  |   `--data2
>  `--leaf1
>      +--data3
>      +--data4
>      `--data5
> 
> "If data[0-2] are sparse holes, then leaf0 will contain a repeating
> sequence of @zero_digest.  Therefore, leaf0 need not be written to disk
> because its contents can be synthesized."

It sounds like you're assuming that the file data is always hashed in filesystem
block sized units.  That's not how it works.  The block size that's selected for
fsverity (which is a power of 2 between 1024 and min(fs_block_size, PAGE_SIZE),
inclusively) is used for both the data blocks and the Merkle tree blocks.

This is intentional, so that people can e.g. calculate the fsverity digest of a
file using a 4K block size, and deploy the file to both filesystems that use a
4K filesystem block size and filesystems that use a 16K filesystem block size,
and get the same fsverity file digest each time.

I've considered offering the ability to configure the data block size separately
from the Merkle tree block size, like what dm-verity does.  This hasn't seemed
useful, though.  And in any case, it should not be tied to the FS block size.

A better way to think about things might be that the Merkle tree actually
*includes* the data, as opposed to being separate from it.  In this respect,
it's natural that the Merkle tree parameters including block size, hash
algorithm, and salt apply both to blocks that contain file data and to blocks
that contain hashes.  In general, all the fsverity code and documentation
probably needs to be clearer about whether, when referring to the Merkle tree,
it means just the hash blocks, or if it means the conceptual full tree that
includes the file's data.

- Eric

