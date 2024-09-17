Return-Path: <linux-fsdevel+bounces-29598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729497B4ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 22:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0DE1C229FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED793191F95;
	Tue, 17 Sep 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="If+Ajxd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B427470;
	Tue, 17 Sep 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606461; cv=none; b=aky+/oOTf/i6t9WBkAq1vJc1tYF9elBuvBr6WcxBL/tdOs/GGctEwAwgG5XoMqHNfPGDWlM1orOiPhBNXOx2Yp2y8/TbX4DGVXhiLDjPoYfzCR5xgqwktFv/zAkb+iWmaj93roviN2UsQdQ8sM60YDsG3HcSVntrL5Ej+GzOR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606461; c=relaxed/simple;
	bh=qyGaWpfb/w0UzJgTsTCKxut6trVk3jG6V7ahLPFoNa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t29rmObzyKSVRY8DwWbBctCSOp49H/QEqBIvibUJKH5jUq7meVw5C5KSUY6ufq5ylhieg1OYifLZ1m1TlTMeYk6B4FdCSJ6NBUIgN1YFiP7V4WCqqQj+guOTu+xEV78AFM67HPLA5yjIg7ZUxOciZ1qVd1ILB2uJgdftZGjBvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=If+Ajxd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08EEC4CEC5;
	Tue, 17 Sep 2024 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726606460;
	bh=qyGaWpfb/w0UzJgTsTCKxut6trVk3jG6V7ahLPFoNa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=If+Ajxd+MuwQa3wddNVbppCmbR0L95q8B6vFAyAiqWSsALuKQnuu72loovaKoHfWk
	 zo45fqyBiJsyKufUo2p8fHreKgAr5VT00QhOL7xReFiQFDoddYZkWJYSGAK2tNcC/v
	 gDKnu1FlzooiIEK1L65eW7I5jBc+0ARX0879A98SVRrq+I/v5izYbwKEYsHKhfgnZH
	 5yLdwwdZYYSutoxeeQm1ybNR8XO8QSkMtYJHMChZTWDmfbxbPp4C3c61ztJcUG3iNv
	 SxZCItjm9joUVUyLJ5embJuQhH0LwSllzleQezi4KawMeW+EUQgXaj+PXNOMkTJKk+
	 vlJm88FhAGvLw==
Date: Tue, 17 Sep 2024 13:54:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <20240917205420.GB182177@frogsfrogsfrogs>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <877cbq3g9i.fsf@gmail.com>
 <ZtlQt/7VHbOtQ+gY@dread.disaster.area>
 <8734m7henr.fsf@gmail.com>
 <ZufYRolfyUqEOS1c@dread.disaster.area>
 <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com>

On Mon, Sep 16, 2024 at 11:24:56AM +0100, John Garry wrote:
> On 16/09/2024 08:03, Dave Chinner wrote:
> > OTOH, we can't do this with atomic writes. Atomic writes require
> > some mkfs help because they require explicit physical alignment of
> > the filesystem to the underlying storage.

Forcealign requires agsize%extsize==0, it's atomicwrites that adds the
requirement that extsize be a power of 2...

> If we are enabling atomic writes at mkfs time, then we can ensure agsize %
> extsize == 0. That provides the physical alignment guarantee. It also makes
> sense to ensure extsize is a power-of-2.
> 
> However, extsize is re-configurble per inode. So, for an inode enabled for
> atomic writes, we must still ensure agsize % new extsize == 0 (and also new
> extsize is a power-of-2)

...so yes.

> > Hence we'll eventually end
> > up with atomic writes needing to be enabled at mkfs time, but force
> > align will be an upgradeable feature flag.
> 
> Could atomic writes also be an upgradeable feature? We just need to ensure
> that agsize % extsize == 0 for an inode enabled for atomic writes. Valid
> extsize values may be quite limited, though, depending on the value of
> agsize.

I don't see why forcealign and atomicwrites can't be added to the sb
featureset after the fact, though you're right that callers of xfs_io
chattr might be hard pressed to find an fsx_extsize value that fits.

--D

> Thanks,
> John
> 
> 

