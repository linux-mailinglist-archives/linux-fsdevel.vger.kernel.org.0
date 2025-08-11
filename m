Return-Path: <linux-fsdevel+bounces-57390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05913B210ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0963687189
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3867129BD8F;
	Mon, 11 Aug 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEQWWVXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCE1A9F80
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927256; cv=none; b=iC4eFO7nvkZdtcImtZ/mkwwExezBRsX2uBoh8UFpuceBdc5tTRD9ssbVtk3swEZb7Ok3IvSkQ8idRVJ5GbNvNMyRMnFn3VOd038GBUS9hRPCtmJzF1s1gMR4E9/iiQ7uf9f4yzVovQAwOTYvobOSNjYxqXrSPVHRzsYiCcKd5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927256; c=relaxed/simple;
	bh=62s7pHkfZXQddVr69Jud/Lebur8IfTeoNILu429KoBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNEXQ0GLQCa0aJAuMW4T2CJqvFYzKaOeNUD78lRYfjTReXi9Eih6R5PVHazAFnOflF76nvw6VTnh78b029ImChPYnioe1avpCYtYaera7vI4Lh3bKDTAGO+czpzGSSloASiPxo5oiGfPUBV3zzCET/XFlfExx4sMGvl/pmOuX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEQWWVXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1201FC4CEED;
	Mon, 11 Aug 2025 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927256;
	bh=62s7pHkfZXQddVr69Jud/Lebur8IfTeoNILu429KoBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEQWWVXOzcPjPhk1tIx3USZw2/muXqVDBWAsIY0IHB1Cm9iu9whF2aG+fMwVg9auf
	 NT/56y09MqB7bhfm/KncbTnRAiu7dlHQbMsUCRlh5UuEMhaRXWTEE6AdKazHM9X/+3
	 v3GOBgcsMWKlwTjmO5O52JiXYOuO8EMzEWV9iks4TRClHHHOeuoxgOLuC0fCsQb4p0
	 lm/H5OKx+CsGWRdUjyeRG2M4rzYqlL6syT12c51iR/D7w1CJv8sCdOipRmiOsm0l98
	 MyCbg8wauLnQU7Jt/+aku09ji41mqARtd+oyjKS1ndfQ3WYGtz2hYCsnXcM12JtsCH
	 il2sfSfPlQfZw==
Date: Mon, 11 Aug 2025 08:47:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: mszeredi@redhat.com, bschubert@ddn.com, fweimer@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Message-ID: <20250811154735.GC7942@frogsfrogsfrogs>
References: <20250805183017.4072973-1-mszeredi@redhat.com>
 <20250807062425.694-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807062425.694-1-luochunsheng@ustc.edu>

On Thu, Aug 07, 2025 at 02:24:25PM +0800, Chunsheng Luo wrote:
> On Thu, Aug 07 2025, Chunsheng Luo wrote:
> 
> > On Tue, Aug 05 2025, Miklos Szeredi wrote:
> >
> > +	bytes_copied = fc->no_copy_file_range_64 ?
> > +		outarg.size : outarg_64.bytes_copied;
> > +
> >  	truncate_inode_pages_range(inode_out->i_mapping,
> >  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
> > -				   ALIGN(pos_out + outarg.size, PAGE_SIZE) - 1);
> > +				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);
> >  
> >  	file_update_time(file_out);
> > -	fuse_write_update_attr(inode_out, pos_out + outarg.size, outarg.size);
> > +	fuse_write_update_attr(inode_out, pos_out + bytes_copied, bytes_copied);
> 
> The copy_file_range syscall returns bytes_copied, a value provided by
> the userspace filesystem that the kernel cannot control. If
> bytes_copied > len, how should the application handle this? Similarly,
> if pos_out + bytes_copied < pos_outdue to integer overflow, could this
> cause any issues? Since vfs_copy_file_range->generic_copy_file_checks
> already check that pos_out + len does not overflow, so just need check
> bytes_copied > len.

if (WARN_ON_ONCE(bytes_copied > len))
	return -EIO;

perhaps?

--D

> 
> Thanks
> Chunsheng Luo
> 

