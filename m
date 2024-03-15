Return-Path: <linux-fsdevel+bounces-14486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718387D175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C521C227F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F574596F;
	Fri, 15 Mar 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MgqYNQWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D583EA97
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521448; cv=none; b=lvfHJOKxbIGoMONj6xkmvyeMqH8fC9dtUjzOd7fAmSFymTU9SLdBs6W9ALusJTqRz//umbfWi7ZHt7BTE7OeL5nlc3t1dAMc18qQwll+qHwsOqFXAIkFm7L9vRT6Sjr2jJXKkp46RdeNxYoQ0fAeOkyVEoKQYD8rWeL6ffEdUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521448; c=relaxed/simple;
	bh=+1zM7cQOmjEK5zeishajGM7/9lDXdEAF+fHjVpsU/Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYfSa6TWFyIGf4IBwMjtnfivdkrtHqDxe5f5IV9Nv/83N1nhcmRKJIuJG/m72Vu8TYjTc9d2PGGg+07cTpvmvrJbh091ExLCUCoEPxQNTewltbmlY1WcKfFjfzKlt0HA/5FPZsE+vIqh4UvmpZt6d7pI3QEehTS8U+FyCYLytO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MgqYNQWp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Mar 2024 12:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710521444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zo40Qzdo/CwJ9JXAYKrTmNI4kAnF/70CKG12hoxZK9Q=;
	b=MgqYNQWpAaz6mM9OZjN7rmNmF0vafWaVA8KED7+Ndu/K95ZiQrE2cVoEeiPFjucxxg9B0O
	kHkPtxxI8ntiXVQcbV04nI979FbHGa3TjPLCSzVc/3CvMb32jpwnTJ214U84SExTcMMovV
	jw+oi871WIej0aScuSii64lkDdON3JM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Message-ID: <l3dzlrzaekbxjryazwiqtdtckvl4aundfmwff2w4exuweg4hbc@2zsrlptoeufv>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
 <20240315035308.3563511-4-kent.overstreet@linux.dev>
 <20240315164550.GD324770@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315164550.GD324770@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 15, 2024 at 12:45:50PM -0400, Theodore Ts'o wrote:
> On Thu, Mar 14, 2024 at 11:53:02PM -0400, Kent Overstreet wrote:
> > the new sysfs path ioctl lets us get the /sys/fs/ path for a given
> > filesystem in a fs agnostic way, potentially nudging us towards
> > standarizing some of our reporting.
> > 
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> >  #endif
> >  	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
> > +	super_set_sysfs_name_bdev(sb);
> 
> Should we perhaps be hoisting this call up to the VFS layer, so that
> all file systems would benefit?

I did as much hoisting as I could. For some filesystems (single device
filesystems) the sysfs name is the block device, for the multi device
filesystems I've looked at it's the UUID.

