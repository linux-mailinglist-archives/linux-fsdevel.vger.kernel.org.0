Return-Path: <linux-fsdevel+bounces-18385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4F8B82CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 00:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62662284057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 22:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157F753E33;
	Tue, 30 Apr 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cKCuPwav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21905249E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517652; cv=none; b=dLd77HaTljTE+mBzq4GG9nET1EsH9A2/VarIzsAYx3+5MOq/I21nvs60DnL4xMNrgx2RgqYuvvLMWx2Sc0jQ45XcpqmVqDSaj9FIEy/4jZHU9swSTDL9kQ3/p2rvodzF27zR2icLA/ynmUZqCKillJ/t//+3IDlymSYVchHWeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517652; c=relaxed/simple;
	bh=ELCQBpWKeGyBAGZEDQIwR6I++BaU9ZU4JnHAqG4/FhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQTG9HiIPhawHhkgV/Crl9Y6koN4wi5etSQk+YhaJzbNUFp9htHHVuvaIswgqYcsDPF5LuTmsP/VTKBEQvdBLdtStpFa/LKUmwFBsg2lcRGDD9GgN5xpXTYbRRl8hM4qoeTJgMWfXP7w/WVTxpoKMofa+8UBg3tmiMAHX72eCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cKCuPwav; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3577052a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714517650; x=1715122450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0LVmUY7m8aRmrjgIR6OFP9AYQPOV0DVsJoP0m1MDb4=;
        b=cKCuPwavKW8/53jCuKCf2hdUZEfxJoZhAZz25IeyZabYCOfOES54qOyTkjSJEMBx/y
         J+M0YplwFNfTnGo07oY3FT5p4CJKzWDooZt7vF5/Bc8XCDIuFBimOIDZvDlCh9ahl4hP
         2ULKZJ71F23NU0b4rbvVvzynof7wUfzuzNGYqqQZITuGqYYYu6eTFQudxYqPzL7A+zPW
         nuT8G5IKvqDU6paOv1hFayOa6UwGYipyTxs4k9WYbXcYcJ5sB4p1rTrAkxQ+7n+D/IWg
         JBpHJyWNSVdZopoduD6dhavz9l5/N9t9Owf4TgMrfaYUbp/ENXy+pu66vuhsXBv3Vz2x
         kBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517650; x=1715122450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0LVmUY7m8aRmrjgIR6OFP9AYQPOV0DVsJoP0m1MDb4=;
        b=VYZY8EgYwJ1DVKPGpJzMwyKvyAXLx3T/10dbpk2ENkgNbs/dbDMZj1xY/lF9O5+ueI
         cnXqaiBl3S52UgFZ3MYWeT7ACd0p4Y31MSZh5mgVml00RyppVKYjtL5L800OL4V3HPNa
         PNFopYjNj4/ll4HGVGl1n2pJLkvAYR9lhA6047Ob+MxMW17Xt//ZuHyLzxe1L5WL01Sx
         A21I4XZg6JuUVlXVLxjS40LYxoD6xhMzzY1jTRD3Jx5Dp+OMUD88iFrXk8sAPQFuKc1A
         ZnotIvynTB9NM24ld9LAEN0umO9yPBLT5rPqOmv2humNFKT3FSCwEYQrZXw7cBFiEFkf
         GP4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFNH9KMe79Dw8fK2OmwO6GSCE8CDwg1NsqRH/uP2EH0+ckYL7YmN3RYKojWg+16IRwnyUrAIsuFZTnp7TbXXnt7aDDjjdwaWoDWrLY7A==
X-Gm-Message-State: AOJu0YzDuMfkWvTQbv+o3K73FYuagdQ1A2UQ/byZDzl+FSsNjbGa5nrE
	TR2I8llmYBIt0X02JO+GaD56INO0SkXFYQBPpeTYuJoRSYzhrhH5aSpE2JlAjXE=
X-Google-Smtp-Source: AGHT+IFdKgrs+o6HFaANKCFZe5u9KfE5HvS/5OT4u7VzSor1QeTJKbZboJYBHK46avlW+rVCuzXLCw==
X-Received: by 2002:a17:90b:3a89:b0:2ab:9819:64bc with SMTP id om9-20020a17090b3a8900b002ab981964bcmr813792pjb.32.1714517650271;
        Tue, 30 Apr 2024 15:54:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id pi17-20020a17090b1e5100b002b1dd7c71afsm122863pjb.40.2024.04.30.15.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 15:54:09 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1wMQ-00GhUA-2S;
	Wed, 01 May 2024 08:54:06 +1000
Date: Wed, 1 May 2024 08:54:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 09/21] xfs: Do not free EOF blocks for forcealign
Message-ID: <ZjF2jjtsA/C6ajtb@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-10-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:34PM +0000, John Garry wrote:
> For when forcealign is enabled, we want the EOF to be aligned as well, so
> do not free EOF blocks.

This is doesn't match what the code does. The code is correct - it
rounds the range to be trimmed up to the aligned offset beyond EOF
and then frees them. The description needs to be updated to reflect
this.

> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 19e11d1da660..f26d1570b9bd 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
>  	 * forever.
>  	 */
>  	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
> +
> +	/* Do not free blocks when forcing extent sizes */
> +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)

I see this sort of check all through the remaining patches.

Given there are significant restrictions on forced alignment,
shouldn't this all the details be pushed inside the helper function?
e.g.

/*
 * Forced extent alignment is dependent on extent size hints being
 * set to define the alignment. Alignment is only necessary when the
 * extent size hint is larger than a single block.
 *
 * If reflink is enabled on the file or we are in always_cow mode,
 * we can't easily do forced alignment.
 *
 * We don't support forced alignment on realtime files.
 * XXX(dgc): why not?
 */
static inline bool
xfs_inode_has_forcealign(struct xfs_inode *ip)
{
	if (!(ip->di_flags & XFS_DIFLAG_EXTSIZE))
		return false;
	if (ip->i_extsize <= 1)
		return false;

	if (xfs_is_cow_inode(ip))
		return false;
	if (ip->di_flags & XFS_DIFLAG_REALTIME)
		return false;

	return ip->di_flags2 & XFS_DIFLAG2_FORCEALIGN;
}

-Dave.
-- 
Dave Chinner
david@fromorbit.com

