Return-Path: <linux-fsdevel+bounces-14843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181588071E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E63282354
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129AF4F21D;
	Tue, 19 Mar 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPlVI8+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD544F217;
	Tue, 19 Mar 2024 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886064; cv=none; b=VQhhoeawezFSzfmReoRDVtVVFC6BN4MXlK/lymCGlwsPKP9Uzf1g/Y4+CCtFu9pFJkz7g5UTA4Gehei07ZEeCk80So4MHJt8dAzIYjyl3rgwI25AJHmeE3xUXFmGexq26BZGq8ZwucCwdK5+9+vazuhKz7WdRui8gUXDiHCY9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886064; c=relaxed/simple;
	bh=h0l6BvmGc4RnVLcgjaZZBNAvFtveWCLZCTnIqDxlgao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRuw11ACy0uLmSFyZU7n0AkgDiF1Clkkg4Y+3QW5RxhPDanhi12QTPFGfuG+pwgpBNKQ9Xo3+sDFgQFzuWM11HoBWSttCWOHDNZ92moL0ac6dCOvT0inv3lw8apg0AsQ1j1lYAcl4zssgGeom8obuq5GdmuKzZChGqKLWgkqWjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPlVI8+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E3C433C7;
	Tue, 19 Mar 2024 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710886063;
	bh=h0l6BvmGc4RnVLcgjaZZBNAvFtveWCLZCTnIqDxlgao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPlVI8+i0+pIn7OhuRUCSBa++0XF33/hHvn9rdg/tykQ9vlRsHV424zMRriWUrqNz
	 Ht7Tb15MsXwHoEKSv398BaIyygVYi+f8LLf2gkAdqAX8kDPEIpF5AZJJIdp5p9Tyxf
	 wC1pwwCo1IU3o5PHdkgQzP2hEBcwUlKpx2jQElphs0TtQwW174t/VuVO59vVmN66IC
	 axceiUyBR7uRmDE1b3FPrC9vCK33mc3ERoHvaRE2UhIBVvZZBikekBAsPgXLV9eFkf
	 vkMFZAbXSNqxanwGdjPivpMhSe/0sBIb4dPBT/cnEkHAzJQAz9F7y3Ls89x5MlCF5T
	 6jcwjZmaaMUdQ==
Date: Tue, 19 Mar 2024 15:07:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, Mark Tinguely <tinguely@sgi.com>,
	Allison Henderson <allison.henderson@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCHSET v5.3] fs-verity support for XFS
Message-ID: <20240319220743.GF6226@frogsfrogsfrogs>
References: <20240317161954.GC1927156@frogsfrogsfrogs>
 <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <20240318163512.GB1185@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318163512.GB1185@sol.localdomain>

On Mon, Mar 18, 2024 at 09:35:12AM -0700, Eric Biggers wrote:
> On Sun, Mar 17, 2024 at 09:22:52AM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > From Darrick J. Wong:
> > 
> > This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
> > fsverity for XFS.
> 
> Is this ready for me to review, or is my feedback on v5 still being
> worked on?

It's still being worked on.  I figured it was time to push my work tree
back to Andrey so everyone could see the results of me attempting to
understand the fsverity patchset by working around in the codebase.

From your perspective, I suspect the most interesting patches will be 5,
6, 7+10+14, 11-13, and 15-17.  For everyone on the XFS side, patches
27-39 are the most interesting since they change the caching strategy
and slim down the ondisk format.

> From a quick glance, not everything from my feedback has been
> addressed.

That's correct.  I cleaned up the mechanics of passing merkle trees
around, but I didn't address the comments about per-sb workqueues,
fsverity tracepoints, or whether or not iomap should allocate biosets.
Roughly, here's what I did in the generic code:

I fixed the FS_XFLAG_VERITY handling so that you can't clear it via
FS_IOC_FSSETXATTR.

I also rewrote and augmented the "drop dead merkle tree" functions in
xfs_verity to clean out incomplete trees when ->end_enable tells us we
failed; and to clean out extra blocks in the ->begin_enable just in case
the file shrank since a failed attempt to enable fsverity.

As for online repair, the "fsverity: expose merkle tree geometry to
callers" enables the kernel to do some basic online checking that there
aren't excessive merkle tree blocks and that fsverity can read the
descriptor.  In my djwong-wtf tree, xfs_scrub gains the ability to read
the entire file into the pagecache (and hence validate the verity info)
via MADV_POPULATE READ, and now it has a patch to read the entire merkle
tree/descriptor/signature just to make sure those can actually be read.

Most of the things you gave feedback about in "fsverity: support
block-based Merkle tree caching" I think I cleaned up in "fsverity: fix
"support block-based Merkle tree caching"" and "fsverity: rely on cached
block callers to retain verified state".  I kept those separate so that
Andrey could see what I did, though they really ought to be merged into
the main support patch.

Note that I greatly expanded the usage of struct fsverity_blockbuf and
changed the verified flag handling so that the invalidation function was
no longer necessary.

--D

> - Eric

