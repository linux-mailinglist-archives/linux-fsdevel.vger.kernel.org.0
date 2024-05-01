Return-Path: <linux-fsdevel+bounces-18389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0608B83D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 02:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDB01C229CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218BE440C;
	Wed,  1 May 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BnqI8ZTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EB4C6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524814; cv=none; b=XXKXorfxew+zUlqyU9099ESsApmKhWdrO0fVBVSdJjLX8POpXDE/j0JEfeQYyM2v/L1hGP2r6GGHQlaCHNDwzK76x86Flix4TIHlw72uDLDJ3Frg9A8jt7ERqDIB3XVRqrju3lITZQXSAL5w8H/zhIdb4YKYjHJWuXwOrV68Dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524814; c=relaxed/simple;
	bh=MDzDjSaA1/WpmCCAzCXM2+Luq9xOpdvAzwI6pGAgE+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLPMRQgy/5kN+ST2uV8gxZBqmB8E0SJpsFKI8m7ORFzJCiZ6JXtvaTiCpNqQr85C+7beYkkXJOfkV8S7YmB5v/ma/mpowTxqUJPKN665oEOhMkkPHYXJwa+80ttxwh1iodMYf8e0lvUA4BFLlki8PSA28vfcDqagn361AMeatmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BnqI8ZTp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso41949605ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714524812; x=1715129612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AGLi6nbOQ03oujc7OG5PvbXaIns/xPkQnLtcmi6hQCc=;
        b=BnqI8ZTpdx3iE5LE27Q1tLaqSLSfLaIWQqPhPPY5PBvWzsmnHIYUJw7fQGOzeXYXQq
         0tgxCRbd07dIqunH3uWGcewSy9SkrpgFbLpHzk1LsDDo/NvGKcwK09hP/ZeTq6fQ4DnH
         8SCpnyK0tFSypLGv+5eR5wdwnF7iPHYRRwx2R6dRnBhdHuoFFjiW5b9jxM8Sn2UINqSo
         GmmzOqAzhQ0IojHNQz1O7H1j6WStlUwv22CZWo639AGngX3feK1LpPixMmChLvtgF9XZ
         E4uuQr+WUlxj6/lEvvRqlCx47vgtIUsHYCRFTGEl1MdTDjK39Gq3N+rKK5gpEv1ziRVa
         k+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714524812; x=1715129612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGLi6nbOQ03oujc7OG5PvbXaIns/xPkQnLtcmi6hQCc=;
        b=b4uuj4mJ7nvPOl4CPS3t6/Glrpi72tJeMEwAXJgp67uZSZ3HfVd7QGxj7i4WgaDrcY
         kQ9PJCOFcQGviMNh2waE2E2mMHNeamlKlpfATqh3otgle+FIj9qPlmUicgsS+EBXSrsh
         PXbgZ4Bxo83T7/p24VEtcMbUZyt178J2+lLy9114RKM9pTJ2u1I1vbDG8kCM2MMUeXHf
         m9QQ1G/2EWHjcEANPZfPzASxJtkeaT4CajP678B+7Ik884o6qR/bvxUFec1Kr9lWHIsE
         1DWNKiH++kGWMQiYH4aB3lxPGq4jmLPHJ+SFyKZNXNPMIITQmVZdLKRIbgt1zJ/ILjW+
         wghA==
X-Forwarded-Encrypted: i=1; AJvYcCV0IrZqtKuIkqOwbq0Q0gSZ5Gau6vmS0Y41lgnsJsL7CXXTLwrHmwl9nsBrlc7qUKKzCev5msW4lZKcRtYpA9XU/Ee0wWJ2PpjpsQcqwQ==
X-Gm-Message-State: AOJu0YzmJuO1pTd+xd0Pqdm2Z/ioQ2LRTZghc90p8qrx7XnM1U8SPB5w
	6RgIQqVtA9wbbRLwm6WTJ6qCybQ/uUt74hKutyZyOKnjlQRLqq5nGle5ZDNHx5I=
X-Google-Smtp-Source: AGHT+IEcjKeGPxGhskLd8MVp4LvWIcfr6LSxhM+g0y29FpuVsAo7RcPCoihhteq0i/ufZpW41gNqOg==
X-Received: by 2002:a17:902:da8e:b0:1e4:3b58:7720 with SMTP id j14-20020a170902da8e00b001e43b587720mr1157220plx.2.1714524812077;
        Tue, 30 Apr 2024 17:53:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b001eb4a71cb58sm7345268plg.114.2024.04.30.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 17:53:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1yDw-00GnPV-2z;
	Wed, 01 May 2024 10:53:28 +1000
Date: Wed, 1 May 2024 10:53:28 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
Message-ID: <ZjGSiOt21g5JCOhf@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-13-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:37PM +0000, John Garry wrote:
> Like we already do for rtvol, only free full extents for forcealign in
> xfs_free_file_space().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index f26d1570b9bd..1dd45dfb2811 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -847,8 +847,11 @@ xfs_free_file_space(
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>  
> -	/* We can only free complete realtime extents. */
> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> +	/* Free only complete extents. */
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
> +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> +	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
>  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
>  	}

When you look at xfs_rtb_roundup_rtx() you'll find it's just a one
line wrapper around roundup_64().

So lets get rid of the obfuscation that the one line RT wrapper
introduces, and it turns into this:

	rounding = 1;
	if (xfs_inode_has_forcealign(ip)
		rounding = ip->i_extsize;
	else if (XFS_IS_REALTIME_INODE(ip))
		rounding = mp->m_sb.sb_rextsize;

	if (rounding > 1) {
		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
	}

What this points out is that the prep steps for fallocate operations
also need to handle both forced alignment and rtextsize rounding,
and it does neither right now.  xfs_flush_unmap_range() is the main
offender here, but xfs_prepare_shift() also needs fixing.

Hence:

static inline xfs_extlen_t
xfs_extent_alignment(
	struct xfs_inode	*ip)
{
	if (xfs_inode_has_forcealign(ip))
		return ip->i_extsize;
	if (XFS_IS_REALTIME_INODE(ip))
		return mp->m_sb.sb_rextsize;
	return 1;
}


In xfs_flush_unmap_range():

	/*
	 * Make sure we extend the flush out to extent alignment
	 * boundaries so any extent range overlapping the start/end
	 * of the modification we are about to do is clean and idle.
	 */
	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
	rounding = max(rounding, PAGE_SIZE);
	...

in xfs_free_file_space()

	/*
	 * Round the range we are going to free inwards to extent
	 * alignment boundaries so we don't free blocks outside the
	 * range requested.
	 */
	rounding = xfs_extent_alignment(ip);
	if (rounding > 1 ) {
		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
	}

and in xfs_prepare_shift()

	/*
	 * Shift operations must stabilize the start block offset boundary along
	 * with the full range of the operation. If we don't, a COW writeback
	 * completion could race with an insert, front merge with the start
	 * extent (after split) during the shift and corrupt the file. Start
	 * with the aligned block just prior to the start to stabilize the boundary.
	 */
	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
	offset = round_down(offset, rounding);
	if (offset)
		offset -= rounding;

Also, I think that the changes I suggested earlier to 
xfs_is_falloc_aligned() could use this xfs_extent_alignment()
helper...

Overall this makes the code a whole lot easier to read and it also
allows forced alignment to work correctly on RT devices...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

