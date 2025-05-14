Return-Path: <linux-fsdevel+bounces-48985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE566AB71CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8657165560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7727F4D0;
	Wed, 14 May 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZCWKAh+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434421A43D;
	Wed, 14 May 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240851; cv=none; b=vD7UZ75ARX/6oSdV4SIT4qf4Dpq2yPc2cs6DsTJRyK7VhGuEYiIq+OS07BGsi8n3qLcYUKyfuVBa7WhrRzMlfmG2AT6oukA8OWMWOP7NcGoqHsd9Q2yhmw9ncOCNhF3fctCBmYnexGeJRFiSSqR73H9PDi3EhnkaIn6lnrH+3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240851; c=relaxed/simple;
	bh=Tg9C901ofpLKI1AlrlddjyGB9DtPfTWjz18Sw31T6xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udi/JEy1n+vIHEKFfnyoYuvNV94XNfIWLhguNMeaEQ4JUXZXBfXTK2Ts4V2pg2M7cB4SryQMXTc8Oska73wzsbNlOLuGuioGVD/NIJxwkQVEy5eA4YpwKOFVK4VLNp9G5WWMi9sQHmbk1RSEAGmiYz4CafOkQK9WOL4oIT0P1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZCWKAh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF5C4CEE3;
	Wed, 14 May 2025 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747240850;
	bh=Tg9C901ofpLKI1AlrlddjyGB9DtPfTWjz18Sw31T6xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZCWKAh+aqNfoA9pLteOL1vI0c/EZebZiZxINFP2oUgor6t5Avo3rB68oPNdgRQ91
	 h2Xi+VoUTkvRHZPqIpcJd2W62u+CccOMjAF6wCxl8eq0Q8Gc+JcdUF2eb2Hz4o2wZi
	 cn+uRBGelArfGGGv/q6KsBvJuqJxrd8P9KvnA1dNzq02+H90/Tcsbtjr6qur+AND+A
	 eaxMhYCFdWaqEF3AgkOD1vvn9Zs77QqFpq83NZHW7tNDVrgCOIteDZHURjiM4+8uYJ
	 iEMHESeTVZ2Eq2R32eD4FVtl0+bGWMgpgnpJ2YoMCdUVkP77FHANpndck09Bjy0YI8
	 4O7HKzHM0ZPKg==
Date: Wed, 14 May 2025 09:40:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] ext4: Add multi-fsblock atomic write support with
 bigalloc
Message-ID: <20250514164050.GN25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <87h61t65pl.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h61t65pl.fsf@gmail.com>

On Fri, May 09, 2025 at 11:12:46PM +0530, Ritesh Harjani wrote:
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> 
> > This is v3 of multi-fsblock atomic write support using bigalloc. This has
> > started looking into much better shape now. The major chunk of the design
> > changes has been kept in Patch-4 & 5.
> >
> > This series can now be carefully reviewed, as all the error handling related
> > code paths should be properly taken care of.
> >
> 
> We spotted that multi-fsblock changes might need to force a journal
> commit if there were mixed mappings in the underlying region e.g. say WUWUWUW...
> 
> The issue arises when, during block allocation, the unwritten ranges are
> first zeroed out, followed by the unwritten-to-written extent
> conversion. This conversion is part of a journaled metadata transaction
> that has not yet been committed, as the transaction is still running.
> If an iomap write then modifies the data on those multi-fsblocks and a
> sudden power loss occurs before the transaction commits, the
> unwritten-to-written conversion will not be replayed during journal
> recovery. As a result, we end up with new data written over mapped
> blocks, while the alternate unwritten blocks will read zeroes. This
> could cause a torn write behavior for atomic writes.
> 
> So we were thinking we might need something like this. Hopefully this
> should still be ok, as mixed mapping case mostly is a non-performance
> critical path. Thoughts?

I agree the journal has to be written out before the atomic write is
sent to the device.

--D

> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2642e1ef128f..59b59d609976 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3517,7 +3517,8 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
>   * underlying short holes/unwritten extents within the requested range.
>   */
>  static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
> -                               struct ext4_map_blocks *map, int m_flags)
> +                               struct ext4_map_blocks *map, int m_flags,
> +                               bool *force_commit)
>  {
>         ext4_lblk_t m_lblk = map->m_lblk;
>         unsigned int m_len = map->m_len;
> @@ -3537,6 +3538,11 @@ static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
>         map->m_len = m_len;
>         map->m_flags = 0;
> 
> +       /*
> +        * slow path means we have mixed mapping, that means we will need
> +        * to force txn commit.
> +        */
> +       *force_commit = true;
>         return ext4_map_blocks_atomic_write_slow(handle, inode, map);
>  out:
>         return ret;
> @@ -3548,6 +3554,7 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>         handle_t *handle;
>         u8 blkbits = inode->i_blkbits;
>         int ret, dio_credits, m_flags = 0, retries = 0;
> +       bool force_commit = false;
> 
>         /*
>          * Trim the mapping request to the maximum value that we can map at
> @@ -3610,7 +3617,8 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>                 m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> 
>         if (flags & IOMAP_ATOMIC)
> -               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags);
> +               ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
> +                                                  &force_commit);
>         else
>                 ret = ext4_map_blocks(handle, inode, map, m_flags);
> 
> @@ -3626,6 +3634,9 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>         if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>                 goto retry;
> 
> +       if (ret > 0 && force_commit)
> +               ext4_force_commit(inode->i_sb);
> +
>         return ret;
>  }
> 
> 
> -ritesh
> 

