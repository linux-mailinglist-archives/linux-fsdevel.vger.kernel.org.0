Return-Path: <linux-fsdevel+bounces-30978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A4990303
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DE1B22ABE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1021D2B1C;
	Fri,  4 Oct 2024 12:35:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3CC1D27BB;
	Fri,  4 Oct 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045325; cv=none; b=TvLhIQFJVDU8C631igfXVNHfDxhwMpTeLvLTnpyujEEa0Nkd2AoXX5yaMTsimWfavAhfabAtzriB7ypLXIEM5WLkoFQdxAGdOb6JODMx4ZPSj/u6CQvpa/uW1DCes7Hg5Vb/kX1jfonSovDTQlBLBNu3WJAGjcXM1gaLbGDKedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045325; c=relaxed/simple;
	bh=bpKSUChLpzZNY8hazCt92uAs/Z3eTaCFsDwefZpl6/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob9HhyIPjM41axmE0cQ1s2R2gAQt+SH0SJ0Hi4toX4A2V0MDCYP8LI4NMXox968jRhBJItBlh2Xszk3hH94POjUNIn0kNXL0tbU6BrMjZAj/dceh9uxZljBZXw+lkeoklX/QFZEXN0Gv1dDCJDY96gL+Zss7flbj4+/dIiLUL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83978227A87; Fri,  4 Oct 2024 14:35:20 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:35:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com,
	hch@lst.de, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
Message-ID: <20241004123520.GB19295@lst.de>
References: <20241004092254.3759210-1-john.g.garry@oracle.com> <20241004092254.3759210-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004092254.3759210-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 04, 2024 at 09:22:51AM +0000, John Garry wrote:
> Add initial support for new flag FS_XFLAG_ATOMICWRITES.
> 
> This flag is a file attribute that mirrors an ondisk inode flag.  Actual
> support for untorn file writes (for now) depends on both the iflag and the
> underlying storage devices, which we can only really check at statx and
> pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
> the fs that we should try to enable the fsdax IO path on the file (instead
> of the regular page cache), but applications have to query STAT_ATTR_DAX to
> find out if they really got that IO path.
> 
> Current kernel support for atomic writes is based on HW support (for atomic
> writes). Since for regular files XFS has no way to specify extent alignment
> or granularity, atomic write size is limited to the FS block size.

I'm still confused why this flag is needed for the current version
of this patch set.  We should always be able to support atomic writes
<= block size if support by the block device.


