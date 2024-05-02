Return-Path: <linux-fsdevel+bounces-18461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E78B92A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 02:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495E51F22484
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518551BDDB;
	Thu,  2 May 2024 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoJpL8tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1C168BE;
	Thu,  2 May 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714608094; cv=none; b=UgErs1MZgZBW0LbFhNYgmpNFxjNgrrc6qiQ/4EXiZlwwft3u334I5ACWKlYXE/Uq/jrLpI/8FYp2ji/S22fVbNuBGv7WcmOr36rS/qc/j2pzr2VI9p3PPoYGU8PAc3ATpyWvqiP1x2uWc1XBdoy2+xH4rBLjuZp9JWCoYvIsjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714608094; c=relaxed/simple;
	bh=i7dDQlc3ax61NHoWEnWMespgdGiluS9z/zBMuCiSVFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcXqG2/rQk7WP+0A2JfcjEkO74l2EsokneLxOfqpeft0TUDJ/zZwrP1gyH/WdjR8agya3aqB4Two8B0cSBZ0rJTm6m4GUdqL5xR5n0l8dOwqNqq5odYYtAEmHIjgWAWkGp1qqAz9s3Edkv+lnfm/tObyRP6Sym2qCFxqbT79C+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoJpL8tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F5AC072AA;
	Thu,  2 May 2024 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714608094;
	bh=i7dDQlc3ax61NHoWEnWMespgdGiluS9z/zBMuCiSVFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoJpL8trdyXXa50yWlddS8NSEzUgHsvkFrMgqFkFsOQHpHqxSYM7SYIPdIv3bvTYC
	 UiIPEiIZs0ubq4COpk6YIvOa8t5kmOf0K9xPTz8mwbC8HzLNl2k8gM0diGm3kKZrfU
	 9tyXvkRbcI8/Xs981NgdOoeakrhXlDdlFaP2IdtkLNqKgQgu3ABOfuIEMhv64+Z9Hl
	 qeeGhKBlxSMTJYgZjhfQpWWJccLw+2PRV2EOzUNLKZUbGtl5Jm7ZR39AmHRXGS3NHN
	 d1guCnMy7kQ0wizrqskGTKZjxdAZeSiklNUmZtO+cE4fjNdtXzeZQnWebGiMihfHKq
	 an0FWQTyXHmmg==
Date: Thu, 2 May 2024 00:01:32 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/26] xfs: don't bother storing merkle tree blocks for
 zeroed data blocks
Message-ID: <20240502000132.GA1853833@google.com>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
 <ZjHle-WDezhehB6a@infradead.org>
 <20240501224736.GL360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501224736.GL360919@frogsfrogsfrogs>

On Wed, May 01, 2024 at 03:47:36PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 30, 2024 at 11:47:23PM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 29, 2024 at 08:29:03PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Now that fsverity tells our merkle tree io functions about what a hash
> > > of a data block full of zeroes looks like, we can use this information
> > > to avoid writing out merkle tree blocks for sparse regions of the file.
> > > For verified gold master images this can save quite a bit of overhead.
> > 
> > Is this something that fsverity should be doing in a generic way?
> 
> I don't think it's all that useful for ext4/f2fs because they always
> write out full merkle tree blocks even if it's the zerohash over and
> over again.  Old kernels aren't going to know how to deal with that.
> 
> > It feels odd to have XFS behave different from everyone else here,
> > even if this does feel useful.  Do we also need any hash validation
> > that no one tampered with the metadata and added a new extent, or
> > is this out of scope for fsverity?
> 
> If they wrote a new extent with nonzero contents, then the validation
> will fail, right?
> 
> If they added a new unwritten extent (or a written one full of zeroes),
> then the file data hasn't changed and validation would still pass,
> correct?

The point of fsverity is to verify that file data is consistent with the
top-level file digest.  It doesn't really matter which type of extent the data
came from, or if the data got synthesized somehow (e.g. zeroes synthesized from
a hole), as long as fsverity still gets invoked to verify the data.  If the data
itself passes verification, then it's good.  The same applies to Merkle tree
blocks which are an intermediate step in the verification.

In the Merkle tree, ext4 and f2fs currently just use the same concept of
sparsity as the file data, i.e. when a block is unmapped, it is filled in with
all zeroes.  As Darrick noticed, this isn't really the right concept of sparsity
for the Merkle tree, as a block full of hashes of zeroed blocks should be used,
not literally a zeroed block.  I think it makes sense to fix this in XFS, as
it's newly adding fsverity support, and this is a filesystem-level
implementation detail.  It would be difficult to fix this in ext4 and f2fs since
it would be an on-disk format upgrade.  (Existing files should not actually have
any sparse Merkle tree blocks, so we probably could redefine what they mean.
But even if so, old kernels would not be able to read the new files.)

- Eric

