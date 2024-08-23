Return-Path: <linux-fsdevel+bounces-26922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2056395D25E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5D7B28351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD83218A6DA;
	Fri, 23 Aug 2024 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IN50sgtq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837F18953D;
	Fri, 23 Aug 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429018; cv=none; b=AMm15MCf/CR6IWjco5xpJUCFwAVYYh6nQI0/CHWjji22qs4p4K7U45JAZjQlQ6QdtY/9LPess59x29qV2IALQ4TqgDzBHUm8kiICyWEi0RiPRzgvjhs734DVc1oY6EGqw1jofIPgXdiB8A/+wrDStDygTtE6bu8L7tsPvqAb7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429018; c=relaxed/simple;
	bh=sAXWLmq5dCO5ShdooN53JdvnZT7SiGU/RUtmqaz6qbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekJXDT1X4Asd/R5pQdFjHYoX0YXuzehE8NsUxbOrvWJ12pATtwDcketiV8U8pJKTS9SApHSDy0PK6rJmngL7/ktV418bjs67F6L/j6adQ7OvjfcYsmllrEsQo3voq9BNsflOZQhZbPWix83Mr+a90XGqt8R2iYUzFeraLJz+vzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IN50sgtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A2C4AF0B;
	Fri, 23 Aug 2024 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724429017;
	bh=sAXWLmq5dCO5ShdooN53JdvnZT7SiGU/RUtmqaz6qbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN50sgtqrPVIzkoHO4a0F3/Y59lc8ASOmMQbGkDUnDwpfB5fDG9+W2giqHuleMonm
	 lnPbpvKgNhnbEN7JH6Rcv8xCMn++bj2xTAeRfVU8EIKfJp6QkL0yPeqY6wv07YDw7n
	 p8yPQgNHlPUieuuFDmB7y2Dsz63NsKzyBr2RZLfvAoZTALAhjobDtKgYF0auRAgoNp
	 9OYoZ868xAeDxMYBjYiwZZEcQxeoy9ej795pxgvFQqC/aqdVtuPJAzNGcJdc1mL8SJ
	 xjQEaCnVm2cu7e1xKd/8QuRfU5TMaSddx5ibXvXFNQ3BY1SByH5H63oTj2LhHcONgD
	 o/GuGB996tc8w==
Date: Fri, 23 Aug 2024 09:03:37 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 4/7] xfs: Support FS_XFLAG_ATOMICWRITES for forcealign
Message-ID: <20240823160337.GA865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-5-john.g.garry@oracle.com>
 <20240821170734.GJ865349@frogsfrogsfrogs>
 <a2a0ec49-37e5-4e0f-9916-d9d05cf5bb96@oracle.com>
 <20240822203842.GT865349@frogsfrogsfrogs>
 <d4e9baa3-d7d2-4e89-bc5d-91c85dbd4b8b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e9baa3-d7d2-4e89-bc5d-91c85dbd4b8b@oracle.com>

On Fri, Aug 23, 2024 at 09:39:44AM +0100, John Garry wrote:
> On 22/08/2024 21:38, Darrick J. Wong wrote:
> > > > This (atomicwrites && !forcealign) ought to be checked in the superblock
> > > > verifier.
> > > You mean in xfs_fs_validate_params(), right?
> > xfs_validate_sb_common, where we do all the other ondisk superblock
> > validation.
> 
> I don't see any other xfs_has_XXX checks in xfs_validate_sb_common(), but
> this could be the first...

The superblock verifier runs at a lower level in the filesystem -- it
checks that the ondisk superblock doesn't contain any inconsistent
fields or impossible feature combinations, etc.  Once the ondisk
superblock is verified, the information there is used to set XFS_FEAT_*
bits in m_features, which is what the xfs_has_* predicates access.

Therefore, you have to look at the raw superblock fields, not the
xfs_has_ predicates:

	if ((sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES) &&
	    !(sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)) {
		xfs_warn(mp, "atomic writes feature requires force align feature.");
		return -EINVAL;
	}

The reason for checking this state here is that atomicwrites absolutely
requires forcealign and that dependency will always be true.

> The only other place in which I see a pattern of similar SB feature flag
> checks is in xfs_finish_flags() for checking xfs_has_crc() &&
> xfs_has_noattr2().
> 
> So if we go with xfs_validate_sb_common(), then should the check in
> xfs_fs_fill_super() for xfs_has_forcealign() && xfs_has_realtime()/reflink()
> be relocated to xfs_validate_sb_common() also:

No.  Contrast the above with (forcealign && !realtime), which at least
in theory is temporary, so that should live in xfs_fs_fill_super.  Or
put another way, xfs_fs_fill_super is where we screen out the kernel
being too stupid to support something it found on disk.

--D

> 
> https://lore.kernel.org/linux-xfs/20240813163638.3751939-8-john.g.garry@oracle.com/
> 
> Cheers,
> John
> 

