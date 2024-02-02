Return-Path: <linux-fsdevel+bounces-10075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5A1847903
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5A41F26F33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D1126F05;
	Fri,  2 Feb 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2eUvkkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A885945;
	Fri,  2 Feb 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899679; cv=none; b=WMY/MG4Snk8SgFF7RpQ02eUNf5qD0UK/9Y9B1AJeByQrZmp5WpKkRbAffZ6VOc903mUFggoA86SbX/k54anavMHhAbF/Lq4ZMuu3x+i6Izk/Wyc9rwIDUIZwCbsu1j+CH3I+t1VmOYeKeVkeKYWZ4a1EDWPr3ZYl110W/ZUjBNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899679; c=relaxed/simple;
	bh=QcaaP/4jBnJB46G9guIEmeObnt6+/Id6kQQiWLBmNbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzFpA4diBcFU1C98tslUBn770mWB7hKYTlMywMjKj8snsYtT6EBChLdMD9ArmJRe7xepdi94CoRUgmXuk+aNHYuWRLYaQ2SpcHfGwr7Hzk4z/FF3Ob932+HHJh0HKwWQZ91KNbvsOLC/T3nvUA85U5scwPTCw2C/5HULglhQTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2eUvkkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23CC43390;
	Fri,  2 Feb 2024 18:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899679;
	bh=QcaaP/4jBnJB46G9guIEmeObnt6+/Id6kQQiWLBmNbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h2eUvkkEYHLCPDhfZVJ9aTeddxb6PdiJfiGQGBpuuxwaq+iEzg3P9l4OQo75Wjszq
	 Mw0zSz/rcx9tbV36HcT3iISdYMxMgjvpIE4xRiWYi9AAcSTw+nD1EJQ5nc/GioU+A6
	 8pjcuvz3TJj7fiAybhyT96Xvqxfn/3+3vXnNi7q1jXEKSyfjuQeWbdF6tDF7O0UQvL
	 XomMzk1c6OHzcqA6TaTDPYp+IPPAX5mTNY+qpf5vxzuwahugA7tSc7RVU+tZxemNdh
	 Bq2BEmbL9mu0E9GFBynBEwhj25IOzqK5Bi2aTk4SCl769dRXEFD7nSmHIDa1GgCk/Q
	 ToB1eS/xzzvPw==
Date: Fri, 2 Feb 2024 10:47:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Message-ID: <20240202184758.GA6226@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-6-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:44PM +0000, John Garry wrote:
> Ensure that when creating a mapping that we adhere to all the atomic
> write rules.
> 
> We check that the mapping covers the complete range of the write to ensure
> that we'll be just creating a single mapping.
> 
> Currently minimum granularity is the FS block size, but it should be
> possibly to support lower in future.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> I am setting this as an RFC as I am not sure on the change in
> xfs_iomap_write_direct() - it gives the desired result AFAICS.
> 
>  fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 18c8f168b153..758dc1c90a42 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -289,6 +289,9 @@ xfs_iomap_write_direct(
>  		}
>  	}
>  
> +	if (xfs_inode_atomicwrites(ip))
> +		bmapi_flags = XFS_BMAPI_ZERO;

Why do we want to write zeroes to the disk if we're allocating space
even if we're not sending an atomic write?

(This might want an explanation for why we're doing this at all -- it's
to avoid unwritten extent conversion, which defeats hardware untorn
writes.)

I think we should support IOCB_ATOMIC when the mapping is unwritten --
the data will land on disk in an untorn fashion, the unwritten extent
conversion on IO completion is itself atomic, and callers still have to
set O_DSYNC to persist anything.  Then we can avoid the cost of
BMAPI_ZERO, because double-writes aren't free.

> +
>  	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
>  			rblocks, force, &tp);
>  	if (error)
> @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> +	if (flags & IOMAP_ATOMIC) {
> +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
> +		unsigned int unit_min, unit_max;
> +
> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
> +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
> +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
> +
> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
> +			error = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		if ((offset & mp->m_blockmask) ||
> +		    (length & mp->m_blockmask)) {
> +			error = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		if (imap.br_blockcount == unit_min_fsb ||
> +		    imap.br_blockcount == unit_max_fsb) {
> +			/* ok if exactly min or max */
> +		} else if (imap.br_blockcount < unit_min_fsb ||
> +			   imap.br_blockcount > unit_max_fsb) {
> +			error = -EINVAL;
> +			goto out_unlock;
> +		} else if (!is_power_of_2(imap.br_blockcount)) {
> +			error = -EINVAL;
> +			goto out_unlock;
> +		}
> +
> +		if (imap.br_startoff &&
> +		    imap.br_startoff & (imap.br_blockcount - 1)) {

Not sure why we care about the file position, it's br_startblock that
gets passed into the bio, not br_startoff.

I'm also still not convinced that any of this validation is useful here.
The block device stack underneath the filesystem can change at any time
without any particular notice to the fs, so the only way to find out if
the proposed IO would meet the alignment constraints is to submit_bio
and see what happens.

(The "one bio per untorn write request" thing in the direct-io.c patch
sound sane to me though.)

--D

> +			error = -EINVAL;
> +			goto out_unlock;
> +		}
> +	}
> +
>  	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
>  		error = -EAGAIN;
>  		if (flags & IOMAP_NOWAIT)
> -- 
> 2.31.1
> 
> 

