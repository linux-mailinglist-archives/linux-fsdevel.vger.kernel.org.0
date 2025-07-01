Return-Path: <linux-fsdevel+bounces-53445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F008DAEF178
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAC53A840C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D1226CE0B;
	Tue,  1 Jul 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqYMOQ3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8251022;
	Tue,  1 Jul 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359267; cv=none; b=Boim5Dvj40qJ4k6PoXSXEvaRAPL52NZOd8EXJfCOQKdcI5n2kWoDrxU3J9BoAARZkWQtNzbg3Yfg7sZLu5FrzULSGgjjXoVUZa/SQoi0YIGt2uO8CvJV44HpO+YdLwNeTzsy+JjxcqmCZqHaErrqIT+QR6w6sgfEwngv0QT3z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359267; c=relaxed/simple;
	bh=GE1FdSfW6he+GnVWYoQZBrWesQRe1qmmmvrnDmUzBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAVQCdcyQ6Jx8sdKPTFAthCBIkySoXh6wQaQu+kZWOP0nV90ltTAM1R6MHKH26cSh7aI9gmhztxq1m7VdEmpgWQwfSFH4nB3MKpsO1pWxjE5glTBahXDhHaaWP4YrxYoA09cH8ftSJ6ZFMkNv9JiF5iuIDUqH2G2WSdWH4JFZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqYMOQ3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D407C4CEEE;
	Tue,  1 Jul 2025 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751359266;
	bh=GE1FdSfW6he+GnVWYoQZBrWesQRe1qmmmvrnDmUzBNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqYMOQ3vrk2jwiOUfIt4fIC6B8GLLExBCIZt3+WLzN8NfStvVaHsyp4PyNHIdzBnY
	 jcHxiYmxA7JiTIfW9yblevPtL473Nad0VFsjcedArsJ8/kpQy0M5T/Sq94tW8gR18N
	 /QvRxsPQhq/VNxblvnLMopmtPN4c0pUkGhyKnFcciW3VCOLw3MGi3p9kmOeYhq2DJE
	 8sYqCFR62tlA5NLCEKo016ifFxvoL6mN0ZDl3s2OHm6njCnXZZ29K7IRbp8hMFD48r
	 Pogr99rfgSbX6JS1uB4vER8VLSme0vWUNUcX60uPexNE2vSbvOpx4ZpB3NGV5TRQXN
	 kF1C5uNvAMW0w==
Date: Tue, 1 Jul 2025 10:41:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <20250701-beziffern-penetrant-ed93dbc57654@brauner>
References: <cover.1751347436.git.wqu@suse.com>
 <6164b8c708b6606c640c066fbc42f8ca9838c24b.1751347436.git.wqu@suse.com>
 <aGN8zsyYEArKr0DV@infradead.org>
 <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <baec02a0-e2fb-4801-b2ad-f602fc4d1cfc@gmx.com>

On Tue, Jul 01, 2025 at 04:05:03PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/1 15:44, Christoph Hellwig 写道:
> > On Tue, Jul 01, 2025 at 03:02:34PM +0930, Qu Wenruo wrote:
> > > To allow those multi-device filesystems to be integrated to use
> > > fs_holder_ops:
> > > 
> > > - Rename shutdown() call back to remove_bdev()
> > >    To better describe when the call back is called.
> > 
> > What is renamed back here?
> 
> Rename the old shutdown to remove_bdev().
> 
> > 
> > > -static void exfat_shutdown(struct super_block *sb)
> > > +static void exfat_shutdown(struct super_block *sb, struct block_device *bdev)
> > >   {
> > >   	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
> > >   }
> > > @@ -202,7 +202,7 @@ static const struct super_operations exfat_sops = {
> > >   	.put_super	= exfat_put_super,
> > >   	.statfs		= exfat_statfs,
> > >   	.show_options	= exfat_show_options,
> > > -	.shutdown	= exfat_shutdown,
> > > +	.remove_bdev	= exfat_shutdown,
> > 
> > Please also rename the function so that they match the method name.
> 
> I prefer not, and it is intentionally left as is.
> 
> This give us a very clear view what a fs is expected to do.

Qu, would you please rename the individual functions?

The NAK later just because of this is unnecessary. I will say clearly
that I will ignore gratuitous NAKs that are premised on large scale
rewrites that are out of scope for the problem.

Here the requested rework has an acceptable scope though and we can
sidestep the whole problem and solve it so everyone's happy.

