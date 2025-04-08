Return-Path: <linux-fsdevel+bounces-46006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B6A8134F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4278A145E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B01235C04;
	Tue,  8 Apr 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdv3uxZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF123372D;
	Tue,  8 Apr 2025 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132433; cv=none; b=GJycXKrWBkahbcAfHxEVNTB+iOipC0luG1aP7RiVw71UnhoAH72YAtbwUuGkpmZhRCx0tRpLB3HpDGxrAgT7C+rmh0AazAr93pV5u4h+d3ZN7jJ4Jl2EKyXuK2hbKJqaC2icSZmgLH5iB7rvQEgRgTWKHSJkmHrvZuLtq2CVYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132433; c=relaxed/simple;
	bh=zMsBri3MCQyGuUFjFhMfP7oC09omGu5tlgKMnWc55OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WimQZ3m+NYcUVDq3laqAbIYqkKJCV6nhFmxQKMbqncyzgVSDlUqpeSWvbw8Oe3GAi1a09KpwS8NAuIomlD1CT2GuCq4Tzi+1QBjQ1/yhXfsJ0d424V/S2AsADKKJEcHLHMZzQQ65ufvtOI1LNN8iUONgI8b/5d95AOydKduVWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdv3uxZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD7C4CEE5;
	Tue,  8 Apr 2025 17:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744132433;
	bh=zMsBri3MCQyGuUFjFhMfP7oC09omGu5tlgKMnWc55OI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdv3uxZwyyd06KpRj9uYbprjrPc6GutaFkXCtxht9Ch7Ff4m7bP0ZWv56nVKgTZJx
	 O6zsbj+ACBVOmIcBL0SwZ6idGd1Bg486CI+6qs0TZTPHudi30jPJo0IH0dz+aH80f9
	 XrB/vcRpWIBokuEUBfubh9egpqpIsyhbJc4RuVAJKkCqbjoxNDF0MlpwhGPZM+3GsC
	 FfQqoBdrLvJMalZFkxadzSbg5I/zziHjoyx7Hjx0elDAGlj9CBLWA6bsfbgJv4KeAk
	 BrGt0/O72S/IzRW3SplTfAdDYrxW+fA++IK5+H/b8otl7r10U1O0HYCRZFgdVZ+rwa
	 9LwnhyqLUq73w==
Date: Tue, 8 Apr 2025 10:13:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
Message-ID: <Z_VZT9UhPdLT-rk_@bombadil.infradead.org>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
 <ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>
 <mnrpsfnhhp2xag62qmgdscbmtmskd6wcgytf6p44snkgdjeejc@ohpom722mvpn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnrpsfnhhp2xag62qmgdscbmtmskd6wcgytf6p44snkgdjeejc@ohpom722mvpn>

On Tue, Apr 08, 2025 at 12:51:37PM +0200, Jan Kara wrote:
> On Tue 08-04-25 12:39:52, Jan Kara wrote:
> > Hi!
> > 
> > On Tue 08-04-25 06:33:53, Phillip Lougher wrote:
> > > A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> > > and any filesystem which doesn't check the result may behave unexpectedly as a
> > > result.  This change has recently affected Squashfs, and checking the kernel code,
> > > a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> > > check the result.  This is a courtesy email to warn others of this change.
> > > 
> > > The following emails give the relevant details.
> > > 
> > > https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> > > https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/
> > 
> > Indeed. Thanks for the heads up!
> 
> But isofs is actually fine since setting bdev block size needs exclusive open
> (i.e., has to happen before filesystem mount begins and claims bdev) and
> isofs does:
> 
> 	if (bdev_logical_block_size(s->s_bdev) > 2048)
> 		bail
> 
> in its isofs_fill_super().

Regardless, we added commit a64e5a596067bddb ("bdev: add back PAGE_SIZE
block size validation for sb_set_blocksize()" to effectively revert back
to the original behaviour, and so only filesystems which have FS_LBS are
not blocked by PAGE_SIZE.

Let me know if you still are seeing issues even with this patch merged.

  Luis

