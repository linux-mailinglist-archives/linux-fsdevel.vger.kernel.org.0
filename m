Return-Path: <linux-fsdevel+bounces-18952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAA8BEEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AFA1F2624F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946EA7603A;
	Tue,  7 May 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drW1aEEl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF02A18732F;
	Tue,  7 May 2024 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117095; cv=none; b=Qy1qayJCskt0Wc494TGkz5B6A5EKQMsaU3b7wm9/GzNpqfLf/gSfNVaGLF0e+YrrBsoQBD4+IvUjITbVnooHogYD9d620rvSHwr7Dwnrw4DI36+tURB7zFiMM0fkY4NljdPooDkQ3TRPtXvVosCONeVLgctbfTwhTu+acHhMPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117095; c=relaxed/simple;
	bh=cy7st7EyP+EM7doY/mAhsWHVlF3KUN+bu8pmqtqkyeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TspHHe+HiKLWREdBKIxKREJ4vEGOI7KLce3wXpf02CdkJVUsAh+NmziC4g4kZtHNLr3KLFw1j9GriUdFy1MCe5Adr4dYdLWCrsf/luDoPlRZlSC0BzjCUQFuTl6bipPLmGSe8XuiMg/9CTtFtPq472nDivCCvfJB2s/qOnnZKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drW1aEEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A28C2BBFC;
	Tue,  7 May 2024 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715117094;
	bh=cy7st7EyP+EM7doY/mAhsWHVlF3KUN+bu8pmqtqkyeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drW1aEElx5HczBAMt6e7l2fZIh9ts4GDER7Xny9szpa20MHAAzPOw4P8iB6oYJR0K
	 RJsyLOLg56/87vaR4Oj0AKzpxB7SW7LZZGn8bLYOGq2fGJHjercq4hQvdfORyEE48Y
	 snUgc/pQyx0KngBMTM980C7IDy4UR2JfbJOlCp8k0VTvkDHvpGI/EZx6yjzyPqCc3K
	 L0sRzY2RAplvUAeXpSQQrtjIcz+h7qHOTo32PTqi1ovLrsT3Sak6MpcCSaKsimwjTO
	 +FV3xAehoZwdrgavdGZw+a7TbueMSJzUEyb9XXc28VkGY+09lKBjQRr6lS1v2dN7wn
	 xCo9kgPFnYaWg==
Date: Tue, 7 May 2024 14:24:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240507212454.GX360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjHt1pSy4FqGWAB6@infradead.org>

On Wed, May 01, 2024 at 12:23:02AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 30, 2024 at 11:53:00PM -0700, Christoph Hellwig wrote:
> > This and the header hacks suggest to me that shoe horning the fsverity
> > blocks into attrs just feels like the wrong approach.
> > 
> > They don't really behave like attrs, they aren't key/value paris that
> > are separate, but a large amount of same sized blocks with logical
> > indexing.  All that is actually nicely solved by the original fsverity
> > used by ext4/f2fs, while we have to pile workarounds ontop of
> > workarounds to make attrs work.
> 
> Taking this a bit further:  If we want to avoid the problems associated
> with the original scheme, mostly the file size limitation, and the (IMHO
> more cosmetic than real) confusion with post-EOF preallocations, we
> can still store the data in the attr fork, but not in the traditional
> attr format.  The attr fork provides the logical index to physical
> translation as the data fork, and while that is current only used for
> dabtree blocks and remote attr values, that isn't actually a fundamental
> requirement for using it.
> 
> All the attr fork placement works through xfs_bmap_first_unused() to
> find completely random free space in the logic address space.
> 
> Now if we reserved say the high bit for verity blocks in verity enabled
> file systems we can simply use the bmap btree to do the mapping from
> the verity index to the on-disk verify blocks without any other impact
> to the attr code.

Since we know the size of the merkle data ahead of time, we could also
preallocate space in the attr fork and create a remote ATTR_VERITY xattr
named "merkle" that points to the allocated space.  Then we don't have
to have magic meanings for the high bit.

Though I guess the question is, given the format:

struct xfs_attr_leaf_name_remote {
	__be32	valueblk;		/* block number of value bytes */
	__be32	valuelen;		/* number of bytes in value */
	__u8	namelen;		/* length of name bytes */
	/*
	 * In Linux 6.5 this flex array was converted from name[1] to name[].
	 * Be very careful here about extra padding at the end; see
	 * xfs_attr_leaf_entsize_remote() for details.
	 */
	__u8	name[];			/* name bytes */
};

Will we ever have a merkle tree larger than 2^32-1 bytes in length?  If
that's possible, then either we shard the merkle tree, or we have to rev
the ondisk xfs_attr_leaf_name_remote structure.

I think we have to rev the format anyway, since with nrext64==1 we can
have attr fork extents that start above 2^32 blocks, and the codebase
will blindly truncate the 64-bit quantity returned by
xfs_bmap_first_unused.

--D

