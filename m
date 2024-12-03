Return-Path: <linux-fsdevel+bounces-36296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE89E1112
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EA81647BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC6A2837B;
	Tue,  3 Dec 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="gIWjTcqd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118D219E4
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733191724; cv=none; b=omUmOpDGUgjO8qyw5dbh3TIbFswFn0/vje6Heefz0nmNCY/lFbvDv6Vv8PHeTib/NhsGXKI2G6nh5rBdA2879gx8ZpPgOBYIeA3bZoWxU+bXqqAzx8bB5XDW9BO3WTRgv+KyUbnzT06/SmRuAZOnkUjhrNb9Mc66y337qplv2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733191724; c=relaxed/simple;
	bh=3xbNMSuoTY76HJ54i9cI2muZAvCs6Ji9bMTcKsjtq0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/lQH30+oQ/MxpvRgbgBztrPlZT22OjixlIxNBrlbKLfJFuiFEx+4nMYgR+HWpCdDB3OUoN56eWA4tug5bV/n+ya3cThTgGNrodKApfWJ/H0Sxrx9AUJ8DMmLKiJ06dgF60nEGgbLEeIaA/BMYEuDqFJQZDc+cmDShedr60KbuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=gIWjTcqd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-214d1c6d724so38755475ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733191722; x=1733796522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ulRhgl6sSGlPss0FstKOo/ji4E1mOA7mkokYmdFtl0=;
        b=gIWjTcqd4IJzcyGGo4W62JZ3UY2JAp8XF1DS7LZwFcI1Xfpqk13Y3ts/TLP9Ht1Sej
         0iVwrQsJ4XCme7V3VzcZ6U+XE15oKHA/HJTAABF9DHWb4SjCtpqaSoxD+n9KO++cKs0A
         SWkg0vHZMyNBtv64Wgl2aYOtywgrm7oE1yw62SBqa9ZaLRgI8W0gb59RzCFhChHnSEn8
         LrF7zdhTP2n+luSoKfg5NY67keRWtmQB3N1x6D/UGu9aKilms8n3VBMBwo4L51YE/VuP
         LtGNj6JOKKm0dQcWDSj8Ap0KQftjzMeWYa/h5g3uC/i+YpSLoJ65zxFrFxZ3bwPCho3A
         LUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733191722; x=1733796522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ulRhgl6sSGlPss0FstKOo/ji4E1mOA7mkokYmdFtl0=;
        b=Re7Obk5e+7YkMn/TqIKLMocXm8NIAFXqAg6i+owTNvVdOt0mabIVrLs/hh1IyaraEN
         VkPHFS0pxSZhrCAK9Trut64zjoYfSn+JEKjfYzzIywVP/KvXSTP227QgbtHRroBQv0AV
         rWhuB10dThGoDNu9A1WnDThCobmw+ieRoB871p9D31g3VyKaNl03DupIRhhv/XXSHiIt
         F8E1TObn3UBUj+WYED1TLlUe6V+n0XKSnLtCXVmQw8WD1umXuqSEMZnczuSWRYQ6Vs8f
         JM6deIyJoBDEBK0Et3uJgLNQCvzXrALqsAF9s+qVe/xqYcgUJTVUW3wMVuNwLxCEqdgr
         amaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVre/19F/bk7Qx4GNwsAVe7IEJUhSijTsmgmU7724ZHMxLA8NyhqgM4ZOt9DbbkT3u+Vb5LOIQcOeKrHSTQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oCKf2BXytmCbYojsO3iH5GYlNE+aoxRZh2qoUFqjXBG1mLMo
	99chHm5bwOErTo1ncdGMjJXeYFRhMmExDUsFGW8pGI6yhjh1DogXfJLO76+Wn4s=
X-Gm-Gg: ASbGncvMvP5aVsPj/SMiM7QGJMXWAc66whj5TfZEzcfbzVwLRn98Lwbk8KMuosbsKzL
	RzCNw5KS91UGLzU8rISXaGqkp/I/PF1zFyCU8WoR4FMDRYmUnUuaR0G2YfPWdElGOfOqab3knrR
	pLTXrXcF6ePE+8P99tBjk8qa9WzuyGQtkbc9WTXIXVJ4hWw1JBCY/CI1kc4f8SY/9U7V84vfiUj
	UxZzOjQWeyOl8b2emq1s9d3SLCLMiAjyWm85Jyhn4DDPskDm5BEohi1a/iISZ240rPRHi7fja5U
	2oM8Ho/dcL+QZrS0yJAysEoj1g==
X-Google-Smtp-Source: AGHT+IEou4A13iLbfo2HuRojU2zmAGq7hnAq4Qnpabte2bos6rG1SB7t2DbjOnuzWiFzDD8IFAT2wg==
X-Received: by 2002:a17:902:dad0:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-215bd0d8973mr8953385ad.20.1733191722070;
        Mon, 02 Dec 2024 18:08:42 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21589aa5478sm30139775ad.59.2024.12.02.18.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 18:08:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tIIL8-00000005xYL-1K4A;
	Tue, 03 Dec 2024 13:08:38 +1100
Date: Tue, 3 Dec 2024 13:08:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: Brian Foster <bfoster@redhat.com>
Cc: Long Li <leo.lilong@huawei.com>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z05oJqT7983ifKqv@dread.disaster.area>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03RlpfdJgsJ_glO@bfoster>

On Mon, Dec 02, 2024 at 10:26:14AM -0500, Brian Foster wrote:
> On Sat, Nov 30, 2024 at 09:39:29PM +0800, Long Li wrote:
> > When performing fsstress test with this patch set, there is a very low probability of
> > encountering an issue where isize is less than ioend->io_offset in iomap_add_to_ioend.
> > After investigation, this was found to be caused by concurrent with truncate operations.
> > Consider a scenario with 4K block size and a file size of 12K.
> > 
> > //write back [8K, 12K]           //truncate file to 4K
> > ----------------------          ----------------------
> > iomap_writepage_map             xfs_setattr_size

folio is locked here

> >   iomap_writepage_handle_eof
> >                                   truncate_setsize
> > 				    i_size_write(inode, newsize)  //update inode size to 4K

truncate_setsize() is supposed to invalidate whole pages beyond
EOF before completing, yes?

/**
 * truncate_setsize - update inode and pagecache for a new file size
 * @inode: inode
 * @newsize: new file size
 *
 * truncate_setsize updates i_size and performs pagecache truncation (if
 * necessary) to @newsize. It will be typically be called from the filesystem's
 * setattr function when ATTR_SIZE is passed in.
 *
 * Must be called with a lock serializing truncates and writes (generally
 * i_rwsem but e.g. xfs uses a different lock) and before all filesystem
 * specific block truncation has been performed.
 */
void truncate_setsize(struct inode *inode, loff_t newsize)
{
        loff_t oldsize = inode->i_size;

        i_size_write(inode, newsize);
        if (newsize > oldsize)
                pagecache_isize_extended(inode, oldsize, newsize);
        truncate_pagecache(inode, newsize);
}
EXPORT_SYMBOL(truncate_setsize);

Note that this says "serialising truncates and writes" - the
emphasis needs to be placed on "writes" here, not "writeback". The
comment about XFS is also stale - it uses the i_rwsem here like
all other filesystems now.

The issue demonstrated above is -write back- racing against
truncate_setsize(), not writes. And -write back- is only serialised
against truncate_pagecache() by folio locks and state, not inode
locks. hence any change to the inode size in truncate can and will
race with writeback in progress.

Hence writeback needs to be able to handle folios end up beyond
EOF at any time during writeback. i.e. once we have a folio locked
in writeback and we've checked against i_size_read() for validity,
it needs to be considered a valid offset all the way through to
IO completion.


> >   iomap_writepage_map_blocks
> >     iomap_add_to_ioend
> >            < iszie < ioend->io_offset>
> > 	   <iszie = 4K,  ioend->io_offset=8K>

Ah, so the bug fix adds a new call to i_size_read() in the IO
submission path? I suspect that is the underlying problem leading
to the observed behaviour....

> > 
> > It appears that in extreme cases, folios beyond EOF might be written back,
> > resulting in situations where isize is less than pos. In such cases,
> > maybe we should not trim the io_size further.
> > 
> 
> Hmm.. it might be wise to characterize this further to determine whether
> there are potentially larger problems to address before committing to
> anything. For example, assuming truncate acquires ilock and does
> xfs_itruncate_extents() and whatnot before this ioend submits/completes,

I don't think xfs_itruncate_extents() is the concern here - that
happens after the page cache and writeback has been sorted out and
the ILOCK has been taken and the page cache state should
have already been sorted out. truncate_setsize() does that for us;
it guarantees that all writeback in the truncate down range has
been completed and the page cache invalidated.

We hold the MMAP_LOCK (filemap_invalidate_lock()) so no new pages
can be instantiated over the range whilst we are running
xfs_itruncate_extents(). hence once truncate_setsize() returns, we
are guaranteed that there will be no IO in progress or can be
started over the range we are removing.

Really, the issue is that writeback mappings have to be able to
handle the range being mapped suddenly appear to be beyond EOF.
This behaviour is a longstanding writeback constraint, and is what
iomap_writepage_handle_eof() is attempting to handle.

We handle this by only sampling i_size_read() whilst we have the
folio locked and can determine the action we should take with that
folio (i.e. nothing, partial zeroing, or skip altogether). Once
we've made the decision that the folio is within EOF and taken
action on it (i.e. moved the folio to writeback state), we cannot
then resample the inode size because a truncate may have started
and changed the inode size.

We have to complete the mapping of the folio to disk blocks - the
disk block mapping is guaranteed to be valid for the life of the IO
because the folio is locked and under writeback - and submit the IO
so that truncate_pagecache() will unblock and invalidate the folio
when the IO completes.

Hence writeback vs truncate serialisation is really dependent on
only sampling the inode size -once- whilst the dirty folio we are
writing back is locked.

I suspect that we can store and pass the sampled inode size through
the block mapping and ioend management code so it is constant for
the entire folio IO submission process, but whether we can do that
and still fix the orginal issue that we are trying to fix is not
something I've considered at this point....

> does anything in that submission or completion path detect and handle
> this scenario gracefully? What if the ioend happens to be unwritten
> post-eof preallocation and completion wants to convert blocks that might
> no longer exist in the file..?

That can't happen because writeback must complete before
truncate_setsize() will be allowed to remove the pages from the
cache before xfs_itruncate_extents() can run.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

