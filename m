Return-Path: <linux-fsdevel+bounces-27753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6EA9638EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7041C21F0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990B4F5FB;
	Thu, 29 Aug 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ufm+SSLQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287101311B5;
	Thu, 29 Aug 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903212; cv=none; b=vGFvvuw9xaMKX2F9txIKT4dDUmwlqA9oASG43NOZ6FvZ2eycxNln+RKHH7L58augzECs71Fsl/8V1ajgN6kwWTu2qVih7kqvoOZgRW1FagGCRl9/SqqEpFPx3QZ1IcFRKXI2f0rxr+xMsGgal1PnwVjn6eAxjWNc8vPEXq9h2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903212; c=relaxed/simple;
	bh=exE1boHNZFrEfDTrvbJZH+wzQfx4OWMRdTtEVskU8NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWx0FlYBhJAJZ+o4L7avMS47EWIUqCk8tTJdh8oWIPOfyR538GIb0QTbX04bRCB1RREOSe+yV9FU9zDnzJeq29mwxVvOzOKdtzD8zT7VRdRMXto36aWNzeEfm7ZctAn0rEW9p/Ct9oVhHYT588eScureAn87SWR+29nN9jSNTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ufm+SSLQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GzovFI7t/OWhmistRsq0Mc9OErvtrGNeCKw3wXs+R5o=; b=Ufm+SSLQRtQ1+JgNp6f8tIzwGl
	hsnwwODNL9xcmIM/xQCCQ8letGVXhIl5SgDVuzNUl1pzQgC0o061jXG0IHIbiTXZ6mip9JaDYX+NK
	v289hQEjdqTfhiriKXDXOOhWgSQNvSmMzZZt3GY1lmVmk6aRdlgmfFj2J65HjWf61tXEvyweX5UsT
	t7HnXRYtB1z4P8Nti4wybDXGHixKecous6daNpS8OJ1DBJC5Mm92MxjQUytEed/L2UwyGiOHrY4Mm
	W8MJ0+4ysPnvUkVTmgBCDHoM82rzJO0JR13Hf0BvmrIVG9z8bWJsrnYe8pM8y3gjR/kk6En4gTTeV
	bEJH47rQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjW7N-00000001Ttc-2sX5;
	Thu, 29 Aug 2024 03:46:41 +0000
Date: Thu, 29 Aug 2024 04:46:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <Zs_vIaw8ESLN2TwY@casper.infradead.org>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>

On Tue, Aug 27, 2024 at 04:15:05PM -0700, Nathan Chancellor wrote:
> When building for a 32-bit architecture, where 'size_t' is 'unsigned
> int', there is a warning due to use of '%ld', the specifier for a 'long
> int':
> 
>   In file included from fs/xfs/xfs_linux.h:82,
>                    from fs/xfs/xfs.h:26,
>                    from fs/xfs/xfs_super.c:7:
>   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
>   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
>         |                                                        ~~~~~~~~~~~~~~
>         |                                                        |
>         |                                                        size_t {aka unsigned int}
>   ...
>   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         |                                                        ~~^
>         |                                                          |
>         |                                                          long int
>         |                                                        %d

Do we really need the incredibly verbose compiler warning messages?
Can't we just say "this is the wrong format specifier on 32 bit"
and be done with it?

> Use the proper 'size_t' specifier, '%zu', to resolve the warning.
> 
> Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 242271298a33..e8cc7900911e 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1651,7 +1651,7 @@ xfs_fs_fill_super(
>  
>  		if (mp->m_sb.sb_blocksize > max_folio_size) {
>  			xfs_warn(mp,
> -"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> +"block size (%u bytes) not supported; Only block size (%zu) or less is supported",
>  				mp->m_sb.sb_blocksize, max_folio_size);
>  			error = -ENOSYS;
>  			goto out_free_sb;
> 
> ---
> base-commit: f143d1a48d6ecce12f5bced0d18a10a0294726b5
> change-id: 20240827-xfs-fix-wformat-bs-gt-ps-967f3aa1c142
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 
> 

