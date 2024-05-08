Return-Path: <linux-fsdevel+bounces-19129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A85938C059A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 22:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B10282C21
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889E130AFE;
	Wed,  8 May 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKWl4rGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D7128829;
	Wed,  8 May 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200014; cv=none; b=ZibldzVxUKJPtET4SdoCYJ6kx99sjt6ymId0J85zmmhZUay/8koI3ZYB/twDCp7llWLkh6CHzjYWucM72MrrMDMrjaMuWtpzO5JMF/tYr7nLSxeMU3zZAfaCUuqubeAN+1W+gJfyDHSNYXgJ/ume158jMUXfGG2HnYpzDbTXrHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200014; c=relaxed/simple;
	bh=5cplXGTHhLKevBVc9ttRuEVGAVIPeKWSB2YKGZ7YMTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhOe1PdOqt0RgXdTgHOtGha6nlPTw9AopC8sXRSb+2VJ/Fi9lUPneM+rQMjJ/JEQ7IKfSzyhNqGi67lQ+33/w5E5Q9+Nigs0Fr0JS0SwKJPzfInMsO5XcjhmLVZ3M2OvZ7dG+KkMhGLAJN/rzyEXky+p4kBAQYcrdn7gjPYuxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKWl4rGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AA5C113CC;
	Wed,  8 May 2024 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715200013;
	bh=5cplXGTHhLKevBVc9ttRuEVGAVIPeKWSB2YKGZ7YMTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKWl4rGy/Ywiyz659yIU8m1XShXBzZQIzM+TKinlzUPEWpPzhBsct0X2IEao9jm2+
	 1fqVrtRkJK2uPXpi/7wQNpYpu0Rml6ZRZ8Vp6BYufhlv7G91DUrSkaQ7xpA8bGIp/f
	 XoqD3PNVc+VDSgEM0bjuaAt7Q09Gt3O0DPAo1MCixQI4rVi/MwJLZKKioysOX1XGBf
	 IEQTV+H2ycRA9V63LCvGrKyqnVxQwNp1JY6NOu1aaX00W/d9RpkWMSK58dXkbqOA7T
	 ZvaRXn6NcaV2EDVd7QpakBV9AYH1FlScXRgRGKJh5YzhHFDztjTubwavc8OcAIkBQ0
	 TfD/iNzIasCpA==
Date: Wed, 8 May 2024 13:26:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, aalbersh@redhat.com,
	linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/26] xfs: don't bother storing merkle tree blocks for
 zeroed data blocks
Message-ID: <20240508202652.GD360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
 <ZjHle-WDezhehB6a@infradead.org>
 <20240501224736.GL360919@frogsfrogsfrogs>
 <20240502000132.GA1853833@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502000132.GA1853833@google.com>

On Thu, May 02, 2024 at 12:01:32AM +0000, Eric Biggers wrote:
> On Wed, May 01, 2024 at 03:47:36PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 30, 2024 at 11:47:23PM -0700, Christoph Hellwig wrote:
> > > On Mon, Apr 29, 2024 at 08:29:03PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > Now that fsverity tells our merkle tree io functions about what a hash
> > > > of a data block full of zeroes looks like, we can use this information
> > > > to avoid writing out merkle tree blocks for sparse regions of the file.
> > > > For verified gold master images this can save quite a bit of overhead.
> > > 
> > > Is this something that fsverity should be doing in a generic way?
> > 
> > I don't think it's all that useful for ext4/f2fs because they always
> > write out full merkle tree blocks even if it's the zerohash over and
> > over again.  Old kernels aren't going to know how to deal with that.
> > 
> > > It feels odd to have XFS behave different from everyone else here,
> > > even if this does feel useful.  Do we also need any hash validation
> > > that no one tampered with the metadata and added a new extent, or
> > > is this out of scope for fsverity?
> > 
> > If they wrote a new extent with nonzero contents, then the validation
> > will fail, right?
> > 
> > If they added a new unwritten extent (or a written one full of zeroes),
> > then the file data hasn't changed and validation would still pass,
> > correct?
> 
> The point of fsverity is to verify that file data is consistent with the
> top-level file digest.  It doesn't really matter which type of extent the data
> came from, or if the data got synthesized somehow (e.g. zeroes synthesized from
> a hole), as long as fsverity still gets invoked to verify the data.  If the data
> itself passes verification, then it's good.  The same applies to Merkle tree
> blocks which are an intermediate step in the verification.

<nod>

> In the Merkle tree, ext4 and f2fs currently just use the same concept of
> sparsity as the file data, i.e. when a block is unmapped, it is filled in with
> all zeroes.  As Darrick noticed, this isn't really the right concept of sparsity
> for the Merkle tree, as a block full of hashes of zeroed blocks should be used,
> not literally a zeroed block.  I think it makes sense to fix this in XFS, as
> it's newly adding fsverity support, and this is a filesystem-level
> implementation detail.  It would be difficult to fix this in ext4 and f2fs since
> it would be an on-disk format upgrade.  (Existing files should not actually have
> any sparse Merkle tree blocks, so we probably could redefine what they mean.
> But even if so, old kernels would not be able to read the new files.)

<nod>

--D

> - Eric
> 

