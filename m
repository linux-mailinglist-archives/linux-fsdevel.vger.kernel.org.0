Return-Path: <linux-fsdevel+bounces-46818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD71A954C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C9C3AB150
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99BF1E9B1F;
	Mon, 21 Apr 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeKMtDRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055671E0E1A;
	Mon, 21 Apr 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253763; cv=none; b=Rbdtskl0lAehD5esrLw08Yx8IRWdL+3z8iAhFg9/eR7g1nHR+nzn2yZqFcUHnqQYkP2lv9vmFFeaAuPnSeLn8JvC9T7jeOJTXgChAp/52zMfFbdwMOm4oVsOjHPdJlMDHCEBi3fYcKsur/Nc0RZ63T3WasuvfmwYVheVSbkfh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253763; c=relaxed/simple;
	bh=m3m6glZ88p1UicyITupTeA+hfX/BSoFrF6K0y4udo00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scTSEiOuSm2l69WwFzw7QlH70NIVt/WlYE6DE5gmwc/QeAeFL8ql+3ZiHDiGITGMFS5OnCee/1v4qlfH8Dd3jXdAolC8hRKWm0FuEKPRNi1FWqEMSVHBUOsdNIdW/+91o4/b+/gddsfSCblRl8Vg+MWwIPqq8hHsy54SUiTpDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeKMtDRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C9C4CEF0;
	Mon, 21 Apr 2025 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745253762;
	bh=m3m6glZ88p1UicyITupTeA+hfX/BSoFrF6K0y4udo00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeKMtDRPmgXNmdhOA2xuD1QtibJmcPrU2MV3eJXwpFfhIQw+NCP/LjD+7WTJfTrLZ
	 VyXdxSX6qP2Bb961hC0FJn3ZqerqqplYKwIhUnbAW8fLneHGm1lcA+vTlj4pmNBZhp
	 +3EEg7d6NI6mryu6B9O8Cp7eFn12cu0iRgAAC+uFM1xIhY6Gv5A2BKlSC+bLkaWnoL
	 PPoHHiDSmAJA6xr4IPmYwR3+nA69HxDAeJ93AMGLY+ERqa7oExNJXK+WjRWDZnXUFY
	 /d3XLatgTugglsFLw5yzg2WQuJit58K9D3U1x89Z6fRLnAWYextGfQfV6KyM1lmGU2
	 Lh0+VjqHWGzcA==
Date: Mon, 21 Apr 2025 09:42:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250421164241.GD25700@frogsfrogsfrogs>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <20250421040002.GU25675@frogsfrogsfrogs>
 <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2467484b-382b-47c2-ae70-4a41d63cf4fc@oracle.com>

On Mon, Apr 21, 2025 at 06:47:44AM +0100, John Garry wrote:
> On 21/04/2025 05:00, Darrick J. Wong wrote:
> > > @@ -843,6 +909,8 @@ xfs_file_dio_write(
> > >   		return xfs_file_dio_write_unaligned(ip, iocb, from);
> > >   	if (xfs_is_zoned_inode(ip))
> > >   		return xfs_file_dio_write_zoned(ip, iocb, from);
> > What happens to an IOCB_ATOMIC write to a zoned file?  I think the
> > ioend for an atomic write to a zoned file involves a similar change as
> > an outofplace atomic write to a file (one big transaction to absorb
> > all the mapping changes) but I don't think the zoned code quite does
> > that...?
> 
> Correct. For now, I don't think that we should try to support zoned device
> atomic writes. However we don't have proper checks for this. How about
> adding a xfs_has_zoned() check in xfs_get_atomic_write_{min, max, opt}()?

Well it turns out that was a stupid question -- zoned=1 can't be enabled
with reflink, which means there's no cow fallback so atomic writes just
plain don't work:

$ xfs_info /mnt
meta-data=/dev/sda               isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=0    bigtime=1 inobtcount=1 nrext64=1
         =                       exchange=1   metadir=1
data     =                       bsize=4096   blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=1
log      =internal log           bsize=4096   blocks=16384, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =internal               extsz=4096   blocks=5061632, rtextents=5061632
         =                       rgcount=78   rgsize=65536 extents
         =                       zoned=1      start=131072 reserved=0
$ xfs_io -c 'statx -r -m 0x10000' /mnt/a | grep atomic
stat.atomic_write_unit_min = 0
stat.atomic_write_unit_max = 0
stat.atomic_write_segments_max = 0
stat.atomic_write_unit_max_opt = 0

I /think/ all you'd have to do is create an xfs_zoned_end_atomic_io
function that does what xfs_zoned_end_io but with a single
tr_atomic_ioend transaction; figure out how to convey "this is an
atomic out of place write" to xfs_end_ioend so that it knows to call
xfs_zoned_end_atomic_io; and then update the xfs_get_atomic_write*
helpers.

--D

> Thanks,
> John

