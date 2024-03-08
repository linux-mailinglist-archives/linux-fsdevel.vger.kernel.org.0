Return-Path: <linux-fsdevel+bounces-13971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C399C875CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3D6B21A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062F2C1BF;
	Fri,  8 Mar 2024 03:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC+C2F2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF42C684;
	Fri,  8 Mar 2024 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869611; cv=none; b=hj7D+llAjbjZp0aWC62NRVeHpSz0MlY9mfPwmt+Y01T2JC2cP+itGBu2b4y1waxGzQociuEvouAkhFR+MycBxPqDTnS6yphiiN2q9ANZmgSqi1yGfEjZRKbc9icMrELVT4wHIjSfpD1+5mDvJMJ/wgGOJHAVxJxFevlaqPuu8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869611; c=relaxed/simple;
	bh=oQk7cd/qHHyOv3KLFTmF8/QIv4fbVxWjplVBVoniVGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugup/A7XCuear0BbKXBfnVrIoXiya041+4cpgXPn0GLQs0oFeskKwckk8rfWJgx0U9JtKSetuQJ1G7Syx5t6TVkfaBExkgnlreWmDj+NxTZ79dc9G1f3CMmAleJbCx5+BWbLyaz7FuBgyzZi0+7rtlPcRidwsjMq/Tix6ghICC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC+C2F2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91A9C433C7;
	Fri,  8 Mar 2024 03:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709869610;
	bh=oQk7cd/qHHyOv3KLFTmF8/QIv4fbVxWjplVBVoniVGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bC+C2F2wKb4s1byQ0FNOllz/fcGCssl6nguGqxS7U5Zxxi7XLUP/R524yyUleTcPA
	 /H5TXbQgG7dXSgezwmqAocsCZ4OCOUKVEMeekgFjoCaqy8n0yLGzYdCJon1Yt7jfMn
	 yfVTg1uEghbWBSJh7fme1SkgQvs8Cj6i0esmMinNAkNVzYFb0/eMgCcR5MxGdDDur6
	 FuEFdsG3bfKRP7wjOLxY8zVmmz+33qnVYPX9cJQwsUQ6cOdTU1Pk777nMVCJ06Ynck
	 iXEgIds13e0+mUOy06LgH1Fmbq2Lv/ibx/lSnwSNes++8LyM7hYffHVXJeA/mxrI1o
	 hl/MKFKgk69Og==
Date: Thu, 7 Mar 2024 19:46:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 06/24] fsverity: pass tree_blocksize to
 end_enable_verity()
Message-ID: <20240308034650.GK1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-8-aalbersh@redhat.com>
 <20240305005242.GE17145@sol.localdomain>
 <20240306163000.GP1927156@frogsfrogsfrogs>
 <20240307220224.GA1799@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307220224.GA1799@sol.localdomain>

On Thu, Mar 07, 2024 at 02:02:24PM -0800, Eric Biggers wrote:
> On Wed, Mar 06, 2024 at 08:30:00AM -0800, Darrick J. Wong wrote:
> > Or you could leave the unfinished tree as-is; that will waste space, but
> > if userspace tries again, the xattr code will replace the old merkle
> > tree block contents with the new ones.  This assumes that we're not
> > using XATTR_CREATE during FS_IOC_ENABLE_VERITY.
> 
> This should work, though if the file was shrunk between the FS_IOC_ENABLE_VERITY
> that was interrupted and the one that completed, there may be extra Merkle tree
> blocks left over.

What if ->enable_begin walked the xattrs and trimmed out any verity
xattrs that were already there?  Though I think ->enable_end actually
could do this since one of the args is the tree size, right?

(Hmm that still wouldn't be any guarantee of success since those xattr
remove calls are each separate transactions...)

> BTW, is xfs_repair planned to do anything about any such extra blocks?

Sorry to answer your question with a question, but how much checking is
$filesystem expected to do for merkle trees?

In theory xfs_repair could learn how to interpret the verity descriptor,
walk the merkle tree blocks, and even read the file data to confirm
intactness.  If the descriptor specifies the highest block address then
we could certainly trim off excess blocks.  But I don't know how much of
libfsverity actually lets you do that; I haven't looked into that
deeply. :/

For xfs_scrub I guess the job is theoretically simpler, since we only
need to stream reads of the verity files through the page cache and let
verity tell us if the file data are consistent.

For both tools, if something finds errors in the merkle tree structure
itself, do we turn off verity?  Or do we do something nasty like
truncate the file?

Is there an ioctl or something that allows userspace to validate an
entire file's contents?  Sort of like what BLKVERIFY would have done for
block devices, except that we might believe its answers?

Also -- inconsistencies between the file data and the merkle tree aren't
something that xfs can self-heal, right?

--D

> - Eric
> 

