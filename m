Return-Path: <linux-fsdevel+bounces-57570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E560FB23941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3957F1B666BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B629BD92;
	Tue, 12 Aug 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2d0frQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DC12C499
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028155; cv=none; b=E0IjFmPl9iqad5eQsEiGPXblRQfwPqXLKtWNNQ6CoqlDITu/SclphRxgwDuqeo8XZ70Cjs6MkiHkqLzejCdn3lAYVH5A9s25rLqPm1603WPRo3HmbkD1nPzvNFA20uc44K0n/TDv6xLVAd7pbcMCI0/tFQgPC0u7BDotOqhW9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028155; c=relaxed/simple;
	bh=TPLa+qqF5k70+ftpYmmborCTSswIb0xWi2JIIw9G0XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBmNS3vao4c1jCcUa5k9VJ195xojIAM+FdvWwU6MGhB/BIWCyn6u/oWH+hnJeJ4ryPVFGUjgF55uo6yygtGeKHsMKh2OdaH85n2jyq1vl9AlyIn41X2A+ebFPDjq2DUoX8v12WKl0quTafBXQyoMnvt5+poYX+krHgBXuQZunNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2d0frQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CB9C4CEF0;
	Tue, 12 Aug 2025 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028155;
	bh=TPLa+qqF5k70+ftpYmmborCTSswIb0xWi2JIIw9G0XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2d0frQZtu5k+XpvdcLfTPoRukBHHtEOGBbZd4AftOWkzQZ1mL86oEA/6Fa9kVsbH
	 3b1I/GyheN2xp5MBTw87LX6xAkwIOjcaA07y4PPxWPquYgEwu+fEVj4SspWwg830IR
	 u0/zjtLPC85VosYSDEs+n+MKxIjvcaH/5+CmaNKSohnQaKZg/KIz5xKW9+0lerPs1h
	 lPPXM2NGDD93lkoVuo5c3AXqmMd6Zxw3MDfr3F+G4kSVIFDiTeVrvd8Ri3r4AL9TVB
	 N7mAuWv874Bnus90Pm/4MseLwbxJGSVOC+4sLi2lgJn7fPSP5MO/XZGNBX91CxQGAH
	 sp+5TqII/y4iQ==
Date: Tue, 12 Aug 2025 12:49:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: bschubert@ddn.com, fweimer@redhat.com, linux-fsdevel@vger.kernel.org,
	luis@igalia.com, mszeredi@redhat.com
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Message-ID: <20250812194914.GK7942@frogsfrogsfrogs>
References: <3bf4f5f5-bfab-47cb-815b-979b56821cc5@ddn.com>
 <20250812090818.2810-1-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812090818.2810-1-luochunsheng@ustc.edu>

On Tue, Aug 12, 2025 at 05:08:18PM +0800, Chunsheng Luo wrote:
> On 8/6/25 19:43, Bernd Schubert wrote: 
> 
> > On 8/6/25 11:17, Luis Henriques wrote:
> >> On Tue, Aug 05 2025, Miklos Szeredi wrote:
> >> 
> >>> The FUSE protocol uses struct fuse_write_out to convey the return value of
> >>> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
> >>> interface supports a 64-bit size copies.
> >>>
> >>> Currently the number of bytes copied is silently truncated to 32-bit, which
> >>> is unfortunate at best.
> >>>
> >>> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
> >>> number of bytes copied is returned in a 64-bit value.
> >>>
> >>> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
> >>> COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.
> >> 
> >> I was wondering if it wouldn't make more sense to truncate the size to
> >> MAX_RW_COUNT instead.  My reasoning is that, if I understand the code
> >> correctly (which is probably a big 'if'!), the VFS will fallback to
> >> splice() if the file system does not implement copy_file_range.  And in
> >> this case splice() seems to limit the operation to MAX_RW_COUNT.
> >
> > I personally don't like the hard coded value too much and would use
> > 
> > inarg.len = min_t(size_t, len, (UINT_MAX - 4096));
> > 
> > (btw, 0xfffff000 is UINT_MAX - 4095, isn't it?).
> > 
> > Though that is all nitpick. The worst part that could happen are
> > applications that do not handle partial file copy and then wouldn't
> > copy the entire file. For these it probably would be better to return
> > -ENOSYS.
> > 
> > LGTM, 
> > 
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> 
> Abot "truncate the size to UINT_MAX - 4096":
> 4096 refers to PAGE_SIZE (the standard memory page size in most systems)?
> If so, wouldn't UINT_MAX & PAGE_MASK be more appropriate? 
> like: `#define MAX_RW_COUNT (INT_MAX & PAGE_MASK)`
> UINT_MAX & PAGE_MASK ensures the operation does not cross a page boundary.

Yeah, I was wondering that too -- if we're going to cap a
copy_file_range to something resembling MAX_RW_COUNT, then why not use
that symbol directly? :)

--D

> Thanks
> Chunsheng Luo
> 

