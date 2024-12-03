Return-Path: <linux-fsdevel+bounces-36384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779009E2DDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E27283B9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 21:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70C4208990;
	Tue,  3 Dec 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uVAtYIn3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DC11F7547
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260332; cv=none; b=l5INT3lm8zhmvawX/NTaJd28TJqTbGYkPg0Y3D+z2W2KzGmF9XuL9OhKtXlX032N2Iv+ZtWMpRHxEsiq9rRcVfW1DtEYKuO/6oXa3snUiOU2Uyz/DZA27ta+OWWyEDgQAl+wQZL2kujAFV7HomfQhP2w9Ghb1KyksSA4lhtFAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260332; c=relaxed/simple;
	bh=5sQ+r+gbaqUsvU0ZrDznyVUb0oZpkSP9jGY029J7Grc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjpPszgKBiOVnXalIxOFsa4MGvb3JGvh14vrFerw+CidttXTPEszfyjtgd/AvsaSwdVIUDvwhtTlo5WFDlg+bfDAVyqNAD9YG1dZHmh1hCSqzd2xU7Tg7L+P2DRzaYVazQsY3R3rTk1H3q3IT7gZEEnPeP+POfNpNloamQy4gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uVAtYIn3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215666ea06aso1800125ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733260329; x=1733865129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+ODrYc33qbZzhbzDaQ4IUD7ZD8/LSAYfpty7Q0W2PI=;
        b=uVAtYIn31bZs1eqet+AO3VkNAKhBwjFLEi6sXX0yQpWURq/rQIc+KUKsX09d/hL8C9
         qZeK0HhydbdS58L8QiimOP5roGmhGp9sPsHkeURVhxfXwGjyzHlwh4sXRy0qIhYy9iTu
         F9oXT6+RvJqwCSAHiAZbdLcdCmWYufNidsR2hLmkqJrHqpqUfgxMdXRifc5D01UZEmql
         HcGBkTgJk6CMfOVkMJ19qSUp8JPREGPH/22w5BYIXe20aywKiIPN0a1RGhpjzzr2cts4
         DVXuc0MEq39FZPgqiz0jOjVCXbX7XmSB8l/g0kK+JpGNjBA/dU6W2RtQqwA9g7MuBQvk
         lC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260329; x=1733865129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+ODrYc33qbZzhbzDaQ4IUD7ZD8/LSAYfpty7Q0W2PI=;
        b=piiQHIGNcKaWFEFQRU31TijZho79OOSMFBEeIC2SYP331oCM3TeAu/TzHtdvVvF54y
         vfeTWqJeQNRzFQDcfV9/j0sOoo8UYv4AfnbCDRiBh9iihHXeLJMGJyc0dl0ooB8Ywbw6
         sU+WTQc38M+5VhRBL4D/BzwMiLk/S6Dsx0czGx5orbtSgKRmTANReG+6AKrXqYjmLjyt
         S2DLfF7371QZ/Yc63teBfL0oEplVPLXpbsfRpEH1bAjEX+s2Lp8NVRfuPqpSX6bG1zJ9
         XXMtTN7P3yWJOdqcIobehQgXqVMKmKSos+JLiFcnG8LKljFWRqNzBcJcaSW0Qrld/vZo
         D6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZQdO+wo8sDKkIWyaYMf93WDZ8eTRW215ebDj2MQgJb9f2ZuCG4mEeb3ysZY1OfBD1jDIMaLeoumnnMa4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dADj67xdb0ROba+qCJq5byhm6j4SdQlUjt6Mh+o3xe4/0h26
	/Fx0RkCEyCxO88+DmxrSstJUtbfyg+L7SE0FohXgEcLhEVeeZd0tHjGJzkBj2fI=
X-Gm-Gg: ASbGncvN/iPUvBFY5MitEYQ9HGQO5XKIZFUHtj8fTlcudGhYzJoGPuwpi2VADSJRT2X
	BKRwHbcTd7cYnmRGNawZXLR2h+qs3YlTQyNz6ZrrflRfd2HLk4W5k9Q6SVgWufZ9p9mDm4hcNDH
	d6930sLtrGeGGkTLYINRW6oRnTNHqonW49RjNR7PpEcLL9KFe2242vt3Hxum6rGXpzZEKKqgkJV
	xmtfjgPCk2CejIeegcF3TqO3aORTtG2+nSi8yhdZgut7MP6Xyooc4sp8Wqm7Y+aILMcdttVJ9q8
	tN40lKEfjw0eZKG/9zNav2S+xw==
X-Google-Smtp-Source: AGHT+IHFTpAHjz3EovSN28pXHU1iJT+oStk7lktwtXwZ4u08NHEMzBz0zDgs2fVQX/+3WWAVHowaRw==
X-Received: by 2002:a17:903:1d2:b0:215:b01a:6288 with SMTP id d9443c01a7336-215be5fd866mr64834825ad.21.1733260328811;
        Tue, 03 Dec 2024 13:12:08 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21548aec039sm78008175ad.113.2024.12.03.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:12:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tIaBh-00000006HX4-1lgM;
	Wed, 04 Dec 2024 08:12:05 +1100
Date: Wed, 4 Dec 2024 08:12:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Brian Foster <bfoster@redhat.com>
Cc: Long Li <leo.lilong@huawei.com>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v5 1/2] iomap: fix zero padding data issue in concurrent
 append writes
Message-ID: <Z090Jd06yjgh_Q-y@dread.disaster.area>
References: <20241127063503.2200005-1-leo.lilong@huawei.com>
 <Z0sVkSXzxUDReow7@localhost.localdomain>
 <Z03RlpfdJgsJ_glO@bfoster>
 <Z05oJqT7983ifKqv@dread.disaster.area>
 <Z08bsQ07cilOsUKi@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z08bsQ07cilOsUKi@bfoster>

On Tue, Dec 03, 2024 at 09:54:41AM -0500, Brian Foster wrote:
> On Tue, Dec 03, 2024 at 01:08:38PM +1100, Dave Chinner wrote:
> > On Mon, Dec 02, 2024 at 10:26:14AM -0500, Brian Foster wrote:
> > > On Sat, Nov 30, 2024 at 09:39:29PM +0800, Long Li wrote:
> > We hold the MMAP_LOCK (filemap_invalidate_lock()) so no new pages
> > can be instantiated over the range whilst we are running
> > xfs_itruncate_extents(). hence once truncate_setsize() returns, we
> > are guaranteed that there will be no IO in progress or can be
> > started over the range we are removing.
> > 
> > Really, the issue is that writeback mappings have to be able to
> > handle the range being mapped suddenly appear to be beyond EOF.
> > This behaviour is a longstanding writeback constraint, and is what
> > iomap_writepage_handle_eof() is attempting to handle.
> > 
> > We handle this by only sampling i_size_read() whilst we have the
> > folio locked and can determine the action we should take with that
> > folio (i.e. nothing, partial zeroing, or skip altogether). Once
> > we've made the decision that the folio is within EOF and taken
> > action on it (i.e. moved the folio to writeback state), we cannot
> > then resample the inode size because a truncate may have started
> > and changed the inode size.
> > 
> > We have to complete the mapping of the folio to disk blocks - the
> > disk block mapping is guaranteed to be valid for the life of the IO
> > because the folio is locked and under writeback - and submit the IO
> > so that truncate_pagecache() will unblock and invalidate the folio
> > when the IO completes.
> > 
> > Hence writeback vs truncate serialisation is really dependent on
> > only sampling the inode size -once- whilst the dirty folio we are
> > writing back is locked.
> > 
> 
> Not sure I see how this is a serialization dependency given that
> writeback completion also samples i_size.

Ah, I didn't explain what I meant very clearly, did I?

What I mean was we can't sample i_size in the IO path without
specific checking/serialisation against truncate operations. And
that means once we have partially zeroed the contents of a EOF
straddling folio, we can't then sample the EOF again to determine
the length of valid data in the folio as this can race with truncate
and result in a different size for the data in the folio than we
prepared it for.

> But no matter, it seems a
> reasonable implementation to me to make the submission path consistent
> in handling eof.

Yes, the IO completion path does sample it again via xfs_new_eof().
However, as per above, it has specific checking for truncate down
races and handles them:

/*
 * If this I/O goes past the on-disk inode size update it unless it would
 * be past the current in-core inode size.
 */
static inline xfs_fsize_t
xfs_new_eof(struct xfs_inode *ip, xfs_fsize_t new_size)
{
        xfs_fsize_t i_size = i_size_read(VFS_I(ip));

>>>>    if (new_size > i_size || new_size < 0)
>>>>            new_size = i_size;
        return new_size > ip->i_disk_size ? new_size : 0;
}

If we have a truncate_setsize() called for a truncate down whilst
this IO is in progress, then xfs_new_eof() will see the new, smaller
inode isize. The clamp on new_size handles this situation, and we
then only triggers an update if the on-disk size is still smaller
than the new truncated size (i.e. the IO being completed is still
partially within the new EOF from the truncate down).

So I don't think there's an issue here at all at IO completion;
it handles truncate down races cleanly...

> I wonder if this could just use end_pos returned from
> iomap_writepage_handle_eof()?

Yeah, that was what I was thinking, but I haven't looked at the code
for long enough to have any real idea of whether that is sufficient
or not.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

