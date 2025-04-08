Return-Path: <linux-fsdevel+bounces-46029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C59CA81942
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 01:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562704A0275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367C2566F9;
	Tue,  8 Apr 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKoNIRl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96B13AD38;
	Tue,  8 Apr 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154492; cv=none; b=oIjtY7E0ULGZoSYYV72t8oDqUEJgVRYEkeOuMrkX8tmCzk1xWpJUC9dEy8vozb7hhup0Bogy8+6WoynbTaEU1uMwMdAe5+5S9bOmG05mXNLPJHTvDDTFvaDjrXZ7W+allczH5hIwcJ+qTj8PVsF3N/dfKDYkq8r0htf8tM/VQXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154492; c=relaxed/simple;
	bh=6d8DS2c1XUJ/qszREAImQZ2aWdY7e6kZYhcPZ2KqisM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8jQAxJd/q9dYe/6bKL9CGO5QmimsGg+R632scBzFyVKe6Wno6Co+BKkSZd40hkieTQQFuSvF1rE7kr53JN1X/h3vru1PlTnXPBMqteYLl5nEnPCCCqXpiJnX/10R3rNOEeZy1z03hkZJ0PksIsr9qVOXwaANHpkZ+lmZlktfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKoNIRl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D9BC4CEE5;
	Tue,  8 Apr 2025 23:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744154492;
	bh=6d8DS2c1XUJ/qszREAImQZ2aWdY7e6kZYhcPZ2KqisM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKoNIRl3AfJ6MpOlDh2bENqi4sqXN8MN0J8Hhv3PMsHen1hiyo9AJ714mRJ+xiDyy
	 JdENxrecA1Tnmtde/N0Upfa9gxycU7ONjZwFhyN96fc4hfl7/j2tUKUDpptoOJmNxL
	 gqE0X7Lo3DiZwcQCJoPXnvNVZuVH830YxKtFiepQ91OgheKbOMvWxEgk2alhUcBarK
	 s9hs1Hmg7UIlp3hVy9LBXzjai9nozWNG9VUC7B64GysUNtyzwe2smGQdLT5c1gW8p8
	 OzkoyDElVWAm7FZSoHEVCA0QgIxxF1twdjw3RkQXNOlSHsD3g+/w7CsXfGUejqkKG0
	 awVimNjrkq57A==
Date: Tue, 8 Apr 2025 16:21:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, brauner@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v6 02/12] xfs: add helpers to compute log item overhead
Message-ID: <20250408232131.GK6307@frogsfrogsfrogs>
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-3-john.g.garry@oracle.com>
 <Z_WoUawfJ_QFF5kP@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_WoUawfJ_QFF5kP@dread.disaster.area>

On Wed, Apr 09, 2025 at 08:50:57AM +1000, Dave Chinner wrote:
> On Tue, Apr 08, 2025 at 10:41:59AM +0000, John Garry wrote:
> > From: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Add selected helpers to estimate the transaction reservation required to
> > write various log intent and buffer items to the log.  These helpers
> > will be used by the online repair code for more precise estimations of
> > how much work can be done in a single transaction.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/libxfs/xfs_trans_resv.c |  6 +++---
> >  fs/xfs/libxfs/xfs_trans_resv.h |  4 ++++
> >  fs/xfs/xfs_bmap_item.c         | 10 ++++++++++
> >  fs/xfs/xfs_bmap_item.h         |  3 +++
> >  fs/xfs/xfs_buf_item.c          | 19 +++++++++++++++++++
> >  fs/xfs/xfs_buf_item.h          |  3 +++
> >  fs/xfs/xfs_extfree_item.c      | 10 ++++++++++
> >  fs/xfs/xfs_extfree_item.h      |  3 +++
> >  fs/xfs/xfs_log_cil.c           |  4 +---
> >  fs/xfs/xfs_log_priv.h          | 13 +++++++++++++
> >  fs/xfs/xfs_refcount_item.c     | 10 ++++++++++
> >  fs/xfs/xfs_refcount_item.h     |  3 +++
> >  fs/xfs/xfs_rmap_item.c         | 10 ++++++++++
> >  fs/xfs/xfs_rmap_item.h         |  3 +++
> >  14 files changed, 95 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
> > index 13d00c7166e1..ce1393bd3561 100644
> > --- a/fs/xfs/libxfs/xfs_trans_resv.c
> > +++ b/fs/xfs/libxfs/xfs_trans_resv.c
> > @@ -47,7 +47,7 @@ xfs_buf_log_overhead(void)
> >   * will be changed in a transaction.  size is used to tell how many
> >   * bytes should be reserved per item.
> >   */
> > -STATIC uint
> > +uint
> >  xfs_calc_buf_res(
> >  	uint		nbufs,
> >  	uint		size)
> > @@ -84,7 +84,7 @@ xfs_allocfree_block_count(
> >   * in the same transaction as an allocation or a free, so we compute them
> >   * separately.
> >   */
> > -static unsigned int
> > +unsigned int
> >  xfs_refcountbt_block_count(
> >  	struct xfs_mount	*mp,
> >  	unsigned int		num_ops)
> > @@ -129,7 +129,7 @@ xfs_rtrefcountbt_block_count(
> >   *	  additional to the records and pointers that fit inside the inode
> >   *	  forks.
> >   */
> > -STATIC uint
> > +uint
> >  xfs_calc_inode_res(
> >  	struct xfs_mount	*mp,
> >  	uint			ninodes)
> > diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
> > index 0554b9d775d2..e76052028cc9 100644
> > --- a/fs/xfs/libxfs/xfs_trans_resv.h
> > +++ b/fs/xfs/libxfs/xfs_trans_resv.h
> > @@ -97,6 +97,10 @@ struct xfs_trans_resv {
> >  
> >  void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
> >  uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
> > +unsigned int xfs_refcountbt_block_count(struct xfs_mount *mp,
> > +		unsigned int num_ops);
> > +uint xfs_calc_buf_res(uint nbufs, uint size);
> > +uint xfs_calc_inode_res(struct xfs_mount *mp, uint ninodes);
> 
> Why are these exported? They aren't used in this patch, and any code
> that doing calculate log reservation calculation should really be
> placed in xfs_trans_resv.c along with all the existing log
> reservation calculations...

I've redone this in a different manner, will send a full patchset after
it runs through QA.

--D

> -Dave
> -- 
> Dave Chinner
> david@fromorbit.com

