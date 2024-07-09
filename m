Return-Path: <linux-fsdevel+bounces-23419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9392C1F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1009E292FF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75E182A6B;
	Tue,  9 Jul 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdwmCL5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC5A17B057;
	Tue,  9 Jul 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720543848; cv=none; b=RatDSyr6c/PTatnuXjh3y2ohaEmdZrwKVflwlF/IwjuGDMG5la7XJld82SxTZBVHZTY1Lp3ut4uAOPToRhz7Eb9R9uhFRm1iGG/FGDOKLnew+VjUMyjvSsZgwGIWJdJQfffLovus4j7Sj2Uv7fiHWQvs7/qFL6UzMdGdVFru+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720543848; c=relaxed/simple;
	bh=znRxZ45h1cDZyCtgvwF+R25ShiH7+CYAc+wYck4CujA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBBdWpM/RERuBXuMSEUSygGWTwKpJ3E8jL28rMqtuTlC8N6eSv0CtzsQRVEwDL+TzRF8ca7m0yv+4v0DtGmpWcOonMelRWMI995gYg73IwczTCHMdQ8kykRpW4Iwza4yJdymipry8/o59NS5A5FSrel05NS/n60VVZ23ekpYYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdwmCL5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F1AC3277B;
	Tue,  9 Jul 2024 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720543848;
	bh=znRxZ45h1cDZyCtgvwF+R25ShiH7+CYAc+wYck4CujA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdwmCL5K4Pp+fpYhosmD6dCZS6cTj0UW0wCYxOUgaJOKuTEx5NQ3BbI3gccWvk8A+
	 hvDSBeFKAuCrwN5DF+iCq2TfuzBO5G9x78rT8hf6jBDCg+6fuMCdsWy380z56wO5xw
	 kdYNYnA7Fk370m00h8QmUlwcsh39TvCsR7uuutRX6Ld4kS3kiz3QgKZDUztLn6ma7E
	 iXC5i5PzVV33Kp2W7XJ0TIe3iYC0TTm7kuAwCYI7k86chLjj1vWxb9O72SMrghAyX3
	 5XG8RC+D8may4rwCSt1K6DiubW1tjggdkU/hrR4SWnANYCSwQ5MpdfNdXaqT7PVNVJ
	 tKv0Zmn2sLDKQ==
Date: Tue, 9 Jul 2024 09:50:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, willy@infradead.org, ryan.roberts@arm.com,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709165047.GS1998502@frogsfrogsfrogs>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <20240709162907.gsd5nf33teoss5ir@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709162907.gsd5nf33teoss5ir@quentin>

On Tue, Jul 09, 2024 at 04:29:07PM +0000, Pankaj Raghav (Samsung) wrote:
> For now, this is the only patch that is blocking for the next version.
> 
> Based on the discussion, is the following logical @ryan, @dave and
> @willy?
> 
> - We give explicit VM_WARN_ONCE if we try to set folio order range if
>   the THP is disabled, min and max is greater than MAX_PAGECACHE_ORDER.
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 14e1415f7dcf4..313c9fad61859 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -394,13 +394,24 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
>                                                  unsigned int min,
>                                                  unsigned int max)
>  {
> -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +               VM_WARN_ONCE(1, 
> +       "THP needs to be enabled to support mapping folio order range");
>                 return;
> +       }
>  
> -       if (min > MAX_PAGECACHE_ORDER)
> +       if (min > MAX_PAGECACHE_ORDER) {
> +               VM_WARN_ONCE(1, 
> +       "min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
>                 min = MAX_PAGECACHE_ORDER;
> -       if (max > MAX_PAGECACHE_ORDER)
> +       }
> +
> +       if (max > MAX_PAGECACHE_ORDER) {
> +               VM_WARN_ONCE(1, 
> +       "max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
>                 max = MAX_PAGECACHE_ORDER;
> +       }
> +
>         if (max < min)
>                 max = min;
> 
> - We make THP an explicit dependency for XFS:
> 
> diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> index d41edd30388b7..be2c1c0e9fe8b 100644
> --- a/fs/xfs/Kconfig
> +++ b/fs/xfs/Kconfig
> @@ -5,6 +5,7 @@ config XFS_FS
>         select EXPORTFS
>         select LIBCRC32C
>         select FS_IOMAP
> +       select TRANSPARENT_HUGEPAGE
>         help
>           XFS is a high performance journaling filesystem which originated
>           on the SGI IRIX platform.  It is completely multi-threaded, can
> 
> OR
> 
> We create a helper in page cache that FSs can use to check if a specific
> order can be supported at mount time:

I like this solution better; if XFS is going to drop support for o[ld]d
architectures I think we need /some/ sort of notice period.  Or at least
a better story than "we want to support 64k fsblocks on x64 so we're
withdrawing support even for 4k fsblocks and smallish filesystems on
m68k".

You probably don't want bs>ps support to block on some arcane discussion
about 32-bit, right? ;)

> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 14e1415f7dcf..9be775ef11a5 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -374,6 +374,14 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  #define MAX_XAS_ORDER          (XA_CHUNK_SHIFT * 2 - 1)
>  #define MAX_PAGECACHE_ORDER    min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
>  
> +
> +static inline unsigned int mapping_max_folio_order_supported()
> +{
> +    if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +      return 0;

Shouldn't this line be indented by two tabs, not six spaces?

> +    return MAX_PAGECACHE_ORDER;
> +}

Alternately, should this return the max folio size in bytes?

static inline size_t mapping_max_folio_size(void)
{
	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
	return PAGE_SIZE;
}

Then the validation looks like:

	const size_t	max_folio_size = mapping_max_folio_size();

	if (mp->m_sb.sb_blocksize > max_folio_size) {
		xfs_warn(mp,
 "block size (%u bytes) not supported; maximum folio size is %u.",
				mp->m_sb.sb_blocksize, max_folio_size);
		error = -ENOSYS;
		goto out_free_sb;
	}

(Don't mind me bikeshedding here.)

> +
> 
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index b8a93a8f35cac..e2be8743c2c20 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1647,6 +1647,15 @@ xfs_fs_fill_super(
>                         goto out_free_sb;
>                 }
>  
> +               if (mp->m_sb.sb_blocklog - PAGE_SHIFT >
> +                   mapping_max_folio_order_supported()) {
> +                       xfs_warn(mp,
> +"Block Size (%d bytes) is not supported. Check MAX_PAGECACHE_ORDER",
> +                       mp->m_sb.sb_blocksize);

You might as well print MAX_PAGECACHE_ORDER here to make analysis
easier on less-familiar architectures:

			xfs_warn(mp,
 "block size (%d bytes) is not supported; max folio size is %u.",
					mp->m_sb.sb_blocksize,
					1U << mapping_max_folio_order_supported());

(I wrote this comment first.)

--D

> +                       error = -ENOSYS;
> +                       goto out_free_sb;
> +               }
> +
>                 xfs_warn(mp,
>  "EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
>                         mp->m_sb.sb_blocksize);
> 
> 
> --
> Pankaj

