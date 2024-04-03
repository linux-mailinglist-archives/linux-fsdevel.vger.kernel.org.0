Return-Path: <linux-fsdevel+bounces-16065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FC897804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D341F24957
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823F153831;
	Wed,  3 Apr 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LSLrjg6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EA153818
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168254; cv=none; b=aSbu6hnxOkjS3z6XbQ7ZKmPvksniWizWiz2yvar5SDv4D4Y4RZf3l1/q7pjQSNN/CZTDg7R9n9T+4bALAgrOQvksXtMafthhNFlEZNwiqRIGtTxqmLJN5OWGcDvdkdrVQhVWp+tRGaMo8w/gJnOeea6IRLJw35dx3Ik9b5HjTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168254; c=relaxed/simple;
	bh=hJWw3B+mhvk+J/b6HFC0YpI4aiSW9INrwrydReU7mY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spAAuB3gbLC4TOLo2htpnWK+myN+RVS48FdgPaBU3pdEMUanORFk/91OPRKs8lYAGDDgAuLuZi596wlYZIuWxJhWZKX3OYpYp9cCQuSFbTT1x8oQDZVKWp/5OB6pyvGkm4egQ4AzIgXhrCe/9NxPA3iShrQG15EYr3T+2uipZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LSLrjg6F; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 14:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712168250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxp27ZGGEkSjJwr51ZwgsY5W3CkCmszrW+4Pomr214w=;
	b=LSLrjg6F62U8rN5fLqsO7nbZDAU3JIcXeYeB4CrF8JqMW9VRrf4nyVis3m0zywfS0giGC6
	enXhqfzZrX4UgUK7Z0Lhi26cYVInkVcP6YKMw2CUFNDWFkV6OJDXwN4InhSowAkbC/dbdA
	LYsEXK5LLyfXOwoAEk/SvmMiqpaOo8Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Brian Foster <bfoster@redhat.com>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	djwong@kernel.org
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
Message-ID: <vf4k3yagvb6vf3vfu7st7uj7asv4zbf5c3b2tef2g2xic5fkvj@olqxfakmkoew>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 03, 2024 at 03:22:41AM -0400, Sweet Tea Dorminy wrote:
> For many years, various btrfs users have written programs to discover
> the actual disk space used by files, using root-only interfaces.
> However, this information is a great fit for fiemap: it is inherently
> tied to extent information, all filesystems can use it, and the
> capabilities required for FIEMAP make sense for this additional
> information also.
> 
> Hence, this patchset adds various additional information to fiemap,
> and extends filesystems (but not iomap) to return it.  This uses some of
> the reserved padding in the fiemap extent structure, so programs unaware
> of the changes will be unaffected.
> 
> This is based on next-20240403. I've tested the btrfs part of this with
> the standard btrfs testing matrix locally and manually, and done minimal
> testing of the non-btrfs parts.
> 
> I'm unsure whether btrfs should be returning the entire physical extent
> referenced by a particular logical range, or just the part of the
> physical extent referenced by that range. The v2 thread has a discussion
> of this.

I believe there was some talk of using the padding for a device ID, so
that fiemap could properly support multi device filesystems. Are we sure
this is the best use of those bytes?

> 
> Changelog:
> 
> v3: 
>  - Adapted all the direct users of fiemap, except iomap, to emit
>    the new fiemap information, as far as I understand the other
>    filesystems.
> 
> v2:
>  - Adopted PHYS_LEN flag and COMPRESSED flag from the previous version,
>    as per Andreas Dilger' comment.
>    https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
>  - https://lore.kernel.org/linux-fsdevel/cover.1711588701.git.sweettea-kernel@dorminy.me/T/#t
> 
> v1: https://lore.kernel.org/linux-fsdevel/20240315030334.GQ6184@frogsfrogsfrogs/T/#t
> 
> Sweet Tea Dorminy (13):
>   fs: fiemap: add physical_length field to extents
>   fs: fiemap: update fiemap_fill_next_extent() signature
>   fs: fiemap: add new COMPRESSED extent state
>   btrfs: fiemap: emit new COMPRESSED state.
>   btrfs: fiemap: return extent physical size
>   nilfs2: fiemap: return correct extent physical length
>   ext4: fiemap: return correct extent physical length
>   f2fs: fiemap: add physical length to trace_f2fs_fiemap
>   f2fs: fiemap: return correct extent physical length
>   ocfs2: fiemap: return correct extent physical length
>   bcachefs: fiemap: return correct extent physical length
>   f2fs: fiemap: emit new COMPRESSED state
>   bcachefs: fiemap: emit new COMPRESSED state
> 
>  Documentation/filesystems/fiemap.rst | 35 ++++++++++----
>  fs/bcachefs/fs.c                     | 17 +++++--
>  fs/btrfs/extent_io.c                 | 72 ++++++++++++++++++----------
>  fs/ext4/extents.c                    |  3 +-
>  fs/f2fs/data.c                       | 36 +++++++++-----
>  fs/f2fs/inline.c                     |  7 +--
>  fs/ioctl.c                           | 11 +++--
>  fs/iomap/fiemap.c                    |  2 +-
>  fs/nilfs2/inode.c                    | 18 ++++---
>  fs/ntfs3/frecord.c                   |  7 +--
>  fs/ocfs2/extent_map.c                | 10 ++--
>  fs/smb/client/smb2ops.c              |  1 +
>  include/linux/fiemap.h               |  2 +-
>  include/trace/events/f2fs.h          | 10 ++--
>  include/uapi/linux/fiemap.h          | 34 ++++++++++---
>  15 files changed, 178 insertions(+), 87 deletions(-)
> 
> 
> base-commit: 75e31f66adc4c8d049e8aac1f079c1639294cd65
> -- 
> 2.43.0
> 

