Return-Path: <linux-fsdevel+bounces-28094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285D9966CDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 01:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F3B23088
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3018E35D;
	Fri, 30 Aug 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkVH0fSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134014AD38;
	Fri, 30 Aug 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060515; cv=none; b=TUUP5szOdHfo54aR5BuqjxwmY8oIG/WS06bGl16vPKfNRovJWtUNAv9ML7L8scpsiW0bL6OFh7+ogacDFfpR8ekmPWuI4e0lZRtlU1vcxmqaEf2398AglPPKGL3OxjR7U37RQJ6tyaQ+xqyUpfR4GcEOusugdIYY2sf6GOYfEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060515; c=relaxed/simple;
	bh=FYXkqFsgNb/8gCjouT5pUAt0OvgofYv5WL6oD57x8yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P99CaMsLbbWFBA7B/HXz0+5CoG1KBPdQWRswwDNMa302O9XReN5Iyq89lDNAsF8R37QQFD/K789SzU/wfdnujCvsEkBu+2Bn7mTWwmGVxO/1SKauQb3fIs+x03cnotKWKW49bNMJgK5r0ohVb8gDo3GjOQw9Chl62DPdEagHPf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkVH0fSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949BFC4CEC2;
	Fri, 30 Aug 2024 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060514;
	bh=FYXkqFsgNb/8gCjouT5pUAt0OvgofYv5WL6oD57x8yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkVH0fSvUCtMt0tZVjLSm0ta/2G5gV6SiZawHAtm1UOrGjwwYNNL0oOQb0eEyJwZR
	 ukvz7Xf6q75v2vXxA82+2hjTd0pilLlml0YXu/+UlhhlID2hzNSDURGF8OTlrVKz3W
	 mcuV0P4n8PjVDGI758BBvUCRF7YfHgCf4v1VBVsdauawjgUjBj9zk4kcycqshn4Jdo
	 1TN13ZZLyTYRGRhnOsvuMA4ZQjaUa9bIlCB6cPImqtDuRa48e19ZSGIKxIs+QMh4FK
	 prRxo26R3aDRRk8S6sDofUts6JHvOUG16GZ2heo1jgKbxbPDJvvKJCvEI7vQ9xT9yn
	 SsxThN/LHOaTg==
Date: Fri, 30 Aug 2024 16:28:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <20240830232833.GR6216@frogsfrogsfrogs>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <631039816bbac737db351e3067520e85a8774ba1.1723670362.git.josef@toxicpanda.com>
 <20240829111753.3znmdajndwwfwh6n@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829111753.3znmdajndwwfwh6n@quack3>

On Thu, Aug 29, 2024 at 01:17:53PM +0200, Jan Kara wrote:
> On Wed 14-08-24 17:25:34, Josef Bacik wrote:
> > xfs has it's own handling for write faults, so we need to add the
> > pre-content fsnotify hook for this case.  Reads go through filemap_fault
> > so they're handled properly there.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Looks good to me but it would be great to get explicit ack from some XFS
> guy...  Some selection CCed :)

Looks decent to me, but I wonder why xfs_write_fault has to invoke
filemap_maybe_emit_fsnotify_event itself?  Can that be done from
whatever calls ->page_mkwrite and friends?

--D

> 
> 								Honza
> 
> > ---
> >  fs/xfs/xfs_file.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index 4cdc54dc9686..e61c4c389d7d 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1283,6 +1283,10 @@ xfs_write_fault(
> >  	unsigned int		lock_mode = XFS_MMAPLOCK_SHARED;
> >  	vm_fault_t		ret;
> >  
> > +	ret = filemap_maybe_emit_fsnotify_event(vmf);
> > +	if (unlikely(ret))
> > +		return ret;
> > +
> >  	sb_start_pagefault(inode->i_sb);
> >  	file_update_time(vmf->vma->vm_file);
> >  
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

