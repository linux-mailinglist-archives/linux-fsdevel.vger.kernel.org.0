Return-Path: <linux-fsdevel+bounces-26473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E8959CA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8C9B28863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B2619994F;
	Wed, 21 Aug 2024 12:58:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CB196D90;
	Wed, 21 Aug 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245084; cv=none; b=XRhvEyue3exP5Z6LNlpu5yTzg7gXhNisOvb2nQUH0Aa5w6fnPgPa+SlcOuRgkoaev34JvQahxbDy3OxVkYsXaDqnzwUmu3c8Yx23gShIPRXiEcfZYmPJkV+f6DyH85o6kXDvsJfq05wjBgCtHGehFvDKxAqnqvmBEA8IicRn8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245084; c=relaxed/simple;
	bh=pEdNkLyzoPt/GXLAEATc+sxlUueSfClXdHmevpf9cec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct9xvLfAxiKchOI3G3I8wl38GnUFDIWb/drQU4aPBe+2vt8flHQNLqdPY2dTFSRVs/FkVEYsHhYWY9XdqTj+d2bM3ipq/s30i7xOVz2nGHW6cj8N4iIYsRdNlPBHlYggZFU6Jp5b0/k/Dwsj1Ek8K+2qV4uYJmUgWfSGFk8XvbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4D5F5227A87; Wed, 21 Aug 2024 14:57:56 +0200 (CEST)
Date: Wed, 21 Aug 2024 14:57:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <20240821125756.GA21319@lst.de>
References: <20240821063108.650126-1-hch@lst.de> <20240821063108.650126-7-hch@lst.de> <ZsXhL_pJhq2qyy-l@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsXhL_pJhq2qyy-l@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 21, 2024 at 08:44:31AM -0400, Brian Foster wrote:
> > +	error = xfs_reflink_unshare(XFS_I(inode), offset, len);
> > +	if (error)
> > +		return error;
> > +
> 
> Doesn't unshare imply alloc?

Yes, ooks like that got lost and no test noticed it

> > -	if (xfs_file_sync_writes(file))
> > +	if (!error && xfs_file_sync_writes(file))
> >  		error = xfs_log_force_inode(ip);
> 
> I'd think if you hit -ENOSPC or something after doing a partial alloc to
> a sync inode, you'd still want to flush the changes that were made..?

Persistence behavior on error is always undefined.  And that's also
what the current code does, as it jumps past the log force from all
error exits.


