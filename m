Return-Path: <linux-fsdevel+bounces-63555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85033BC1D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7525F19A48EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE102E2F14;
	Tue,  7 Oct 2025 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+8+armH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DC2E2845;
	Tue,  7 Oct 2025 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849124; cv=none; b=ju5jV6tWg5nwvMUi0vyowcXOkWE0m0WDG5f0PJahMLWca3z+DBUNIhrTfTSdNZZyHxh2bpCF72dPYADweI2j2NpM+g31OvRZDcqCtjHJdQanDbjNuOvOaE2xb6oBUfeVt3enecTpMCJKl8fF/u9Mf4t339u+ZDTnrTKU2E0BMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849124; c=relaxed/simple;
	bh=ER1En4QJKE/S/4PnTjjPEYBl+nf+z07UL9R+K1xALb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9QDyPB8mproOgeWJ5L8EpvGjo/fweXvvbDxu8G93IuT2SKJ6X9jK+uCZowkm9eS1DFzaPzdLyXyi0+csuocuxnPzyLpKzRvhRs3safLJAjy+XXA5Fmdux9u1UF0xFMnR10kGHG66xVO+IwXwtuElj/TEikqpk8z7+wW0XM/inU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+8+armH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3359EC4CEF1;
	Tue,  7 Oct 2025 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759849124;
	bh=ER1En4QJKE/S/4PnTjjPEYBl+nf+z07UL9R+K1xALb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+8+armHrsAMyuklQMD/0wUyNVOymqghxOII/n+I2k5E2dNs9cO3S1jn+VAXCHxwO
	 te2KcX2UlIXUa9xYdFQEsIPnudbmqSd8PaKSL2eK0USRDDuDD/PZwWJ8sw4uDV5R53
	 KrLuwftujWcEf2k9Zg0pIGG2ZdF2gHeFqR3NQfW159+5E6bn0STNJ11vsPlFNmGbgv
	 pCpwDyK7RAgEjXfu/yX8N+nJuiYsLgeJ9IFtNy71ECgZLt9gqntPpGiiYXWTmM2l/2
	 J3Cg49k1oZ75G27BthPdP3pXDSSKDMNIPBybtumYb3U2vKZya+1tb/RualrqpxaD/a
	 IXlKaPFKInf4g==
Date: Tue, 7 Oct 2025 07:58:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-bcachefs@vger.kernel.org
Subject: Re: Direct IO reads being split unexpected at page boundary, but in
 the middle of a fs block (bs > ps cases)
Message-ID: <20251007145843.GP1587915@frogsfrogsfrogs>
References: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
 <aOPbMs4_wML4qxUg@casper.infradead.org>
 <c9fae0e3-88ad-4e50-a54e-8a73cdc72e38@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9fae0e3-88ad-4e50-a54e-8a73cdc72e38@gmx.com>

On Tue, Oct 07, 2025 at 01:00:58PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/10/7 01:37, Matthew Wilcox 写道:
> > On Wed, Oct 01, 2025 at 10:59:18AM +0930, Qu Wenruo wrote:
> > > Recently during the btrfs bs > ps direct IO enablement, I'm hitting a case
> > > where:
> > > 
> > > - The direct IO iov is properly aligned to fs block size (8K, 2 pages)
> > >    They do not need to be large folio backed, regular incontiguous pages
> > >    are supported.
> > > 
> > > - The btrfs now can handle sub-block pages
> > >    But still require the bi_size and (bi_sector << 9) to be block size
> > >    aligned.
> > > 
> > > - The bio passed into iomap_dio_ops::submit_io is not block size
> > >    aligned
> > >    The bio only contains one page, not 2.
> > 
> > That seems like a bug in the VFS/iomap somewhere.  Maybe try cc'ing the
> > people who know this code?
> > 
> 
> Add xfs and bcachefs subsystem into CC.
> 
> The root cause is that, function __bio_iov_iter_get_pages() can split the
> iov.
> 
> In my case, I hit the following dio during iomap_dio_bio_iter();
> 
>  fsstress-1153      6..... 68530us : iomap_dio_bio_iter: length=81920
> nr_pages=20 enter
>  fsstress-1153      6..... 68539us : iomap_dio_bio_iter: length=81920
> realsize=69632(17 pages)
>  fsstress-1153      6..... 68540us : iomap_dio_bio_iter: nr_pages=3 for next
> 
> Which bio_iov_iter_get_pages() split the 20 pages into two segments (17 + 3
> pages).
> That 17/3 split is not meeting the btrfs' block size requirement (in my case
> it's 8K block size).

Just out of curiosity, what are the corresponding
iomap_iter_{src,dst}map tracepoints for these iomap_dio_bio_iters?

I'm assuming there's one mapping for all 80k of data?

> I'm seeing XFS having a comment related to bio_iov_iter_get_pages() inside
> xfs_file_dio_write(), but there is no special checks other than
> iov_iter_alignment() check, which btrfs is also doing.
> 
> I guess since XFS do not need to bother data checksum thus such split is not
> a big deal?

I think so too.  The bios all point to the original iomap_dio so the
ioend only gets called once for the the full write IO, so a completion
of an out of place write will never see sub-block ranges.

> On the other hand, bcachefs is doing reverting to the block boundary instead
> thus solved the problem.
> However btrfs is using iomap for direct IOs, thus we can not manually revert
> the iov/bio just inside btrfs.
> 
> So I guess in this case we need to add a callback for iomap, to get the fs
> block size so that at least iomap_dio_bio_iter() can revert to the fs block
> boundary?

Or add a flags bit to iomap_dio_ops to indicate that the fs requires
block sized bios?

I'm guessing that you can't do sub-block directio writes to btrfs
either?

--D

> Thanks,
> Qu
> 

