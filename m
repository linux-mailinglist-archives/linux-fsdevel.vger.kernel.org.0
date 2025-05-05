Return-Path: <linux-fsdevel+bounces-48092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B24AA959B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3C4189AED0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2D225C6EA;
	Mon,  5 May 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV3Z2C4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F509846C;
	Mon,  5 May 2025 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454957; cv=none; b=hFaWWnfxjgGRVs2B3nr1sOWoZBhS61HwljPnd57NHs+eF4ZFaUL/+rJESD1X0oUJmVD9OMbUMSPVmMoox/cE8zyk3Q5nOSGGaOcJZmt2V9mOA4akswMMk10Dl+G/Zk/JMhS3QT5sXw3DTzyuXaGjaZcprISzNzNWNbc33Y8ovc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454957; c=relaxed/simple;
	bh=YKNW51Oj6jwIFNQC6Q50xPijXy2UdxETS26563QVe3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnxpFmSieyTMyDU+HKA8UHdIJCG18vlUxAnLLQu/xkUHV6xhgKL6ztS/kLe1JmCmo1yJMKS2JaYB8a7rx3gsBDJmTAVk9KMwp7UgMctM0/l6LmK0ak3KOirltoZtoFtnxxmkIT7Vw9P3/0cFFVa6URYmvd/0fdHfzecXCt8AXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV3Z2C4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D48C4CEE4;
	Mon,  5 May 2025 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746454955;
	bh=YKNW51Oj6jwIFNQC6Q50xPijXy2UdxETS26563QVe3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TV3Z2C4+UL/Mk5nBP3PIITQF9fiKzEQ5TYSxDbr50CbBn+Jk3bqvlHN8onbP2G1oO
	 H+RmQHSy0s0DmE/dM6Ep61r5S4aeoWY0Q1Cwe4rlWwF5VfmccNIH0h2mZJftjZi6se
	 ZTqb6giZBEH9co6ScHyhyWwlhdLKyprgbEZweKnn6Q+adHKDc2tT+4JHcWwBqyK082
	 zPFAgIjiuJMBAseIz7Ms2EMiD3u1C8PDB6E+/s/XaKuUGQapwv79B65BUjWDF67Avp
	 AaWzjCvne0Urzo+Eobo5axLk7aHbBYf8PW6/RStfGUuoRqL0z6ARhR9n1Raxu/Uaa2
	 8C5gkmFeIgrAQ==
Date: Mon, 5 May 2025 07:22:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 02/16] xfs: only call xfs_setsize_buftarg once per
 buffer target
Message-ID: <20250505142234.GG1035866@frogsfrogsfrogs>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-3-john.g.garry@oracle.com>
 <20250505054031.GA20925@lst.de>
 <8ea91e81-9b96-458e-bd4e-64eada31e184@oracle.com>
 <20250505104901.GA10128@lst.de>
 <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8efa28-19e6-42f5-9a26-cdc0bc48926e@oracle.com>

On Mon, May 05, 2025 at 11:55:13AM +0100, John Garry wrote:
> On 05/05/2025 11:49, Christoph Hellwig wrote:
> > On Mon, May 05, 2025 at 11:04:55AM +0100, John Garry wrote:
> > > @@ -503,6 +509,9 @@ xfs_open_devices(
> > >   		mp->m_logdev_targp = xfs_alloc_buftarg(mp, logdev_file);
> > >   		if (!mp->m_logdev_targp)
> > >   			goto out_free_rtdev_targ;
> > > +		error = sync_blockdev(mp->m_logdev_targp->bt_bdev);
> > > +		if (error)
> > > +			goto out_free_rtdev_targ;
> > >   	} else {
> > >   		mp->m_logdev_targp = mp->m_ddev_targp;
> > >   		/* Handle won't be used, drop it */
> > > 
> > > 
> > > Right?
> > Yes.  Or in fact just folding it into xfs_alloc_buftarg, which might
> > be even simpler.
> 
> Yes, that was my next question..
> 
> >  While you're at it adding a command why we are doing
> > the sync would also be really useful, and having it in just one place
> > helps with that.
> 
> ok, there was such comment in xfs_preflush_devices().
> 
> @Darrick, please comment on whether happy with changes discussed.

I put the sync_blockdev calls in a separate function so that the
EIO/ENOSPC/whatever errors that come from the block device sync don't
get morphed into ENOMEM by xfs_alloc_buftarg before being passed up.  I
suppose we could make that function return an ERR_PTR, but I was trying
to avoid making even more changes at the last minute, again.

--D

> Thanks,
> John
> 
> 

