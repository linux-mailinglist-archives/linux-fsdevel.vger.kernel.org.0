Return-Path: <linux-fsdevel+bounces-46576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9161A908CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6151906068
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A236721323F;
	Wed, 16 Apr 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAVkrKNC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EB212D69;
	Wed, 16 Apr 2025 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820810; cv=none; b=I+EsxZvDU7tHaFY5bHgDWYZEZYCz9e9GrgcHrshSxlq4/iyQoMDdFZKQS2pOj5WtBAmA0lbPQyT/zzU5AB5vX29wrOCr2lvLYEBWwNhAp9hNlGxL16rMkJ/GHs5QUTE9KLJ4BDjIdoPjsLINrjt/Ema9Hi1f6j96PBZ2ScJHyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820810; c=relaxed/simple;
	bh=RYGOuCC7qfaii7HzSw7mAkhXbeZOScoiAgqxLmoftKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kL3EUtCSgokgVYT5lZQ9JyElhSktr1AVKO70yKZQjrv0dHkt5ijpRabiZQIjalsSnbIwS4f+Uy2FfeMtRV4MUsg1FI09umD0nC5IvBl1OvfIzPDK6W7GpdmkmLhNeE0LI5xnTnqkJdpMEMfotQVWzfXVR+LLWmyqJ8C63/9gOeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAVkrKNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA67C4CEED;
	Wed, 16 Apr 2025 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744820809;
	bh=RYGOuCC7qfaii7HzSw7mAkhXbeZOScoiAgqxLmoftKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAVkrKNCwP2vYfhZWMcATIhRkbwS1dCVXvWCnD05O1ekkxGPTF8zXweoSQBwFjexo
	 qjf9Wwp14Jt1OUMD+GtBi6kO3Crcp8dkvF7c3SNxbvb4M+ZW0BuePMWQZH6rGvKBej
	 wLZCk2/LkAtfYfymKuipf04MyynDKNmNI5P+PDAJm0AIVSEBssXElV3JQBGuKSrOrG
	 l+2MRXGhhvi05MK7a5oiDkxZZicr4oMa5lXqCKCa1xAHWOdVScStdjTdUTIUuya5hr
	 fkb3cekkDXV0N2cT0o2zqYso0b4v1TZrfy9AdDgk4B6ZiYafukL57X9jXZ8XNesnAz
	 YSGeXiT6ov/yQ==
Date: Wed, 16 Apr 2025 09:26:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7.1 14/14] xfs: allow sysadmins to specify a maximum
 atomic write limit at mount time
Message-ID: <20250416162649.GJ25675@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-15-john.g.garry@oracle.com>
 <20250415223625.GV25675@frogsfrogsfrogs>
 <81f0fe3e-4c1a-497d-b20e-1f8d182ed208@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f0fe3e-4c1a-497d-b20e-1f8d182ed208@oracle.com>

On Wed, Apr 16, 2025 at 11:08:25AM +0100, John Garry wrote:
> On 15/04/2025 23:36, Darrick J. Wong wrote:
> 
> Thanks for this, but it still seems to be problematic for me.
> 
> In my test, I have agsize=22400, and when I attempt to mount with
> atomic_write_max=8M, it passes when it shouldn't. It should not because
> max_pow_of_two_factor(22400) = 128, and 8MB > 128 FSB.
> 
> How about these addition checks:
> 
> > +
> > +	if (new_max_bytes) {
> > +		xfs_extlen_t	max_write_fsbs =
> > +			rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
> > +		xfs_extlen_t	max_group_fsbs =
> > +			max(mp->m_groups[XG_TYPE_AG].blocks,
> > +			    mp->m_groups[XG_TYPE_RTG].blocks);
> > +
> > +		ASSERT(max_write_fsbs <= U32_MAX);
> 
> 		if (!is_power_of_2(new_max_bytes)) {
> 			xfs_warn(mp,
>  "max atomic write size of %llu bytes is not a power-of-2",
> 					new_max_bytes);
> 			return -EINVAL;
> 		}

Long-term I'm not convinced that we really need to have all these power
of two checks because the software fallback can remap just about
anything, but for now I see no harm in doing this because
generic_atomic_write_valid enforces that property on the IO length.

> > +
> > +		if (new_max_bytes % mp->m_sb.sb_blocksize > 0) {
> > +			xfs_warn(mp,
> > + "max atomic write size of %llu bytes not aligned with fsblock",
> > +					new_max_bytes);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (new_max_fsbs > max_write_fsbs) {
> > +			xfs_warn(mp,
> > + "max atomic write size of %lluk cannot be larger than max write size %lluk",
> > +					new_max_bytes >> 10,
> > +					XFS_FSB_TO_B(mp, max_write_fsbs) >> 10);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (new_max_fsbs > max_group_fsbs) {
> > +			xfs_warn(mp,
> > + "max atomic write size of %lluk cannot be larger than allocation group size %lluk",
> > +					new_max_bytes >> 10,
> > +					XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> 
> 	if (new_max_fsbs > max_pow_of_two_factor(max_group_fsbs)) {
> 		xfs_warn(mp,
>  "max atomic write size of %lluk not aligned with allocation group size
> %lluk",
> 				new_max_bytes >> 10,
> 				XFS_FSB_TO_B(mp, max_group_fsbs) >> 10);
> 		return -EINVAL;

I think I'd rather clean up these bits:

	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
		max_agsize = max_pow_of_two_factor(mp->m_sb.sb_agblocks);
	else
		max_agsize = mp->m_ag_max_usable;

and

	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
		max_rgsize = max_pow_of_two_factor(rgs->blocks);
	else
		max_rgsize = rgs->blocks;

into a shared helper for xfs_compute_atomic_write_unit_max so that we
use the exact same logic in both places.  But I agree with the general
direction.

--D

> 	}
> 
> thanks,
> John
> 

