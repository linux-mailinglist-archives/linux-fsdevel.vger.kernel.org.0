Return-Path: <linux-fsdevel+bounces-30512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A676F98C03F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A79DB29AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F121C1C7B9C;
	Tue,  1 Oct 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsbM7X21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F791C6F42;
	Tue,  1 Oct 2024 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793440; cv=none; b=quU7sqiemnFx5AEe/I+oWq450RyPgGYVwIrJocYktsgIdQ6PE5JX1ZFV2APDL52fweXbZXBx5nqLrW/3iR+H/e8MKk9eEY61LQGt27FD5p9j3q6lVGrk7gALiSfbwi6h6yaQ0nYUzoMLZJWuCM84XhoQq8OptLSyyI/tU95OLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793440; c=relaxed/simple;
	bh=dJD9wGB+Ev02NFnH9B5JBKORnGcYzbFjn6n/UpHrFts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDshOw1CprGviifA7Kvm/VE3DYMWR20NaIPE/CvuujDIeHdEAfUQ7g9wGyhY3PkimmSbpl9klm6A7sBHlPR8HQyg54YdD8k/sWLRCgJjgmh5jwxTbyzFawurx3LZCWSy4539RB6vkM0BFUYlBhxN2gOqGtYHXf5hd/qrQezm32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsbM7X21; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5DBC4CEC6;
	Tue,  1 Oct 2024 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727793439;
	bh=dJD9wGB+Ev02NFnH9B5JBKORnGcYzbFjn6n/UpHrFts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsbM7X218LEEjKEkgF5wYVF+jASMzRaZkmACauR7ZkP3TbCGOgPYlEshvNmMVRUr4
	 YDmhjJ0q2N3exx9sdTX2ZhYTZZ1lx70e2NVtNBno6hF6N/FzW8Z0oJhKPPWV4yPGr7
	 ZuZGvhp9ddAL6k1fW7wfOWyg2ELqdjKxELAU/bji4A14rTI86zEXjw52/IbW1MceOF
	 m9ODC++tT+jRcwHbVfa56AdajhL5fTyx222fCQV4w7BK5umcAGgWglZn+hOMVwApmG
	 74Et13PXEBsQUriSGyIVXCsPkJiNKgwKv/RC65cGonS/K9dDMDmOZFtrSEfktMWbsT
	 PBgEDIE97UAmQ==
Date: Tue, 1 Oct 2024 07:37:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	hare@suse.de, martin.petersen@oracle.com,
	catherine.hoang@oracle.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v6 3/7] fs: iomap: Atomic write support
Message-ID: <20241001143719.GV21853@frogsfrogsfrogs>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-4-john.g.garry@oracle.com>
 <20240930155520.GM21853@frogsfrogsfrogs>
 <b7c74954-f4f0-44b7-ac7a-87518f0808fa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7c74954-f4f0-44b7-ac7a-87518f0808fa@oracle.com>

On Tue, Oct 01, 2024 at 09:05:17AM +0100, John Garry wrote:
> 
> > 
> > This new flag needs a documentation update.  What do you think of this?
> > 
> > diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
> > index 8e6c721d23301..279db993be7fa 100644
> > --- a/Documentation/filesystems/iomap/operations.rst
> > +++ b/Documentation/filesystems/iomap/operations.rst
> > @@ -513,6 +513,16 @@ IOMAP_WRITE`` with any combination of the following enhancements:
> >      if the mapping is unwritten and the filesystem cannot handle zeroing
> >      the unaligned regions without exposing stale contents.
> > + * ``IOMAP_ATOMIC``: This write must be persisted in its entirety or
> > +   not at all.
> > +   The write must not be split into multiple I/O requests.
> > +   The file range to write must be aligned to satisfy the requirements
> > +   of both the filesystem and the underlying block device's atomic
> > +   commit capabilities.
> > +   If filesystem metadata updates are required (e.g. unwritten extent
> > +   conversion or copy on write), all updates for the entire file range
> > +   must be committed atomically as well.
> > +
> >   Callers commonly hold ``i_rwsem`` in shared or exclusive mode before
> >   calling this function.
> 
> Sure, but I would make a couple of tweaks to the beginning:
> 
>  * ``IOMAP_ATOMIC``: This write is to be be issued with torn-write
>    protection. Only a single bio can be created for the write, and the
>    bio must not be split into multiple I/O requests, i.e. flag
>    REQ_ATOMIC must be set.
>    The file range to write must be aligned to satisfy the requirements
>    of both the filesystem and the underlying block device's atomic
>    commit capabilities.
>    If filesystem metadata updates are required (e.g. unwritten extent
>    conversion or copy on write), all updates for the entire file range
>    must be committed atomically as well.
> 
> ok?

Yep, sounds good.

--D

> Thanks,
> John
> 
> 
> 

