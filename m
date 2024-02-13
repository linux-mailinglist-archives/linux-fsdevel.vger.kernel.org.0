Return-Path: <linux-fsdevel+bounces-11440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D09853D39
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A20D28E048
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4F261673;
	Tue, 13 Feb 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mT4kZqkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1826E61675
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860046; cv=none; b=X1DMq6osZ7o9fc6izqbqV0A9dqdOKEr1f4I17jbvBXVvmY2R8NGJSk8Tk09WbXLbu9ykGdi4dBzQMsww1v4bvSgfO6L4WxN8I4IN0ILUKtYjeSrhMTKe/xSmKDbiiycb7kilwHfcZJCk13YClHxO8KsVYALOuo5QsBbcQpBLsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860046; c=relaxed/simple;
	bh=tczYnlV7Pr8X3MlzIngKo1f157AZrBw0PbLNu1TEpug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlMnhvxLzBHp/eFfeaKnFp1weVD81WsEDU4ETH798YFtaUO/pr7/T415u7/kIY3Cft5gIzTQieQXubHfstQzONrhbeSz7Njq9lcZki8bReIiU4vabUTZ54VOl3Kq1UIhBx2XOtl6X1HGYJQBk1bLN5bE4rQOojKJcISEwnCbdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mT4kZqkR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70b0e521eso36859965ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707860044; x=1708464844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3Dh7id3ipnoR2TxmXquXUcK+gi6YFcV7mpm+5XHZi8=;
        b=mT4kZqkRysOVCDZaWeggYO8ymCIjeOHvAaujfE9WxcjeXUYStM3F9A2RpGl3Ltrstg
         FZEfEw+SGhGUaJUyMib9ZMxchoq1vtvIBet0+e+DA3BJccFV/jdUmox4JB2r9ZlYHk5s
         EaBik5M0y2cWNbP2NsRXOyVisO5dJrEA+R00x9NRLsip50UOPthpLNykr/QyJjmD2gt9
         t2yai3NPjvFUbSbUKyunyj9NYGm/JvEyGV87hyoGNPImFFmyp7hb5xl8bLNexliiYuOa
         2gnPV0iq8XBaPHgScmNpBf0cE5SN+wt+GIroLtTiVW9Y4oqpIhH8RxqY54r+GupFGHoI
         AJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860044; x=1708464844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3Dh7id3ipnoR2TxmXquXUcK+gi6YFcV7mpm+5XHZi8=;
        b=ltQsZKRn/U6DPPFeBd/HghtD4bQ3memrv8c7zxQ87IKUJtdIvrme/cqU3KmNw+X4ny
         wQG8vmkY8coCVy8MXTllBrZrcPN9fDV7teW/sIta5N/nOwJN8G5WV4V/KgB1WQiyr4Js
         vWPdwXpWvCzf7jkAMN6nxMwyISIuu0ZcPWpfSJCRly2iCc4tP4saD9eu2uop8Gk9PpWZ
         nX/MBYpnOJiCf9oE5EFhmyrYiCN+2orDX47H5NHqesqiqvROzmu6yZscez8RfBhoFnSO
         2qt+IomL6xu9Q6GrCTWrMyztjxTvqHUQ6Dctv3Z+WkuUdqPU8AORUFDhV/DGXpptcBYe
         H0gw==
X-Forwarded-Encrypted: i=1; AJvYcCUuLmoYndEmRMSdDPQy0xmaHHRQjZ0927wvxTPh80a1LxnJ3U7hgVkD0HnOBSXL2qohicqECoP77ijci9v7B6VgxRD94PXBXJ5GjEBLGA==
X-Gm-Message-State: AOJu0Yzz6SDmJyKf+XOW1koFRv+2gCU6J0nTu6VpXLEK+nCfkxyrIBoG
	I1Ofnx+bVrhzqmtHH4WxS+FNq0tzqMrO6UK1DNOVM6D+2b8LWa7OwEkKQpKHItc=
X-Google-Smtp-Source: AGHT+IHbs+SB1OAwKdQv4FKE5O0WNqesf8jQbsn5a+dVy174Ibcc6He4LWUJox+5v9FAkWcAj7o37A==
X-Received: by 2002:a17:903:245:b0:1d9:b749:d279 with SMTP id j5-20020a170903024500b001d9b749d279mr898647plh.50.1707860044272;
        Tue, 13 Feb 2024 13:34:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWlnI3L91uv5pob/Jz5WI+4ura4qD1cse3IW1Up+u1tb0s52riHCk7ERx4gpDtQGkKH+iy+wzE4fteO+0hNQZLlUvxe6yq62f9R4dWECVk3zq7w1BAXIYVUqDNngHjANkxT4IoypDfmUYXQRVnnxLnZx4MqoXaOHddJuTATZ0H6sQDkIo1195KoZFyTqQ1V6QasL3XGfL7yZq8DevcRsajIornkiMKQinjM90biJMDTZ5C1PJw4it5PUylz09PHHoNJIdSVXjjSNer5kuk4clcdqzTZfQ2z5wLZGg0MyLuJYUxmO9ex/Oh+I31pWnrNMeqZNtINhLwZezh0l/WhWL17HtSKai7VgBvGDalE/sSF1mZZKnBotGpdAc8P6Iy8U8PW/IIV+gT60+Yuf/tDQ0eAM/wysKhMpZG4hA=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902f1cc00b001db474154d1sm957268plc.87.2024.02.13.13.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:34:03 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ra0Ph-00671z-0j;
	Wed, 14 Feb 2024 08:34:01 +1100
Date: Wed, 14 Feb 2024 08:34:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	willy@infradead.org, linux-mm@kvack.org
Subject: Re: [RFC v2 14/14] xfs: enable block size larger than page size
 support
Message-ID: <ZcvgSSbIqm4N6TVJ@dread.disaster.area>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-15-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-15-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:13AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size. Enable it in XFS under CONFIG_XFS_LBS.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_icache.c | 8 ++++++--
>  fs/xfs/xfs_super.c  | 8 +++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
> index dba514a2c84d..9de81caf7ad4 100644
> --- a/fs/xfs/xfs_icache.c
> +++ b/fs/xfs/xfs_icache.c
> @@ -73,6 +73,7 @@ xfs_inode_alloc(
>  	xfs_ino_t		ino)
>  {
>  	struct xfs_inode	*ip;
> +	int			min_order = 0;
>  
>  	/*
>  	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
> @@ -88,7 +89,8 @@ xfs_inode_alloc(
>  	/* VFS doesn't initialise i_mode or i_state! */
>  	VFS_I(ip)->i_mode = 0;
>  	VFS_I(ip)->i_state = 0;
> -	mapping_set_large_folios(VFS_I(ip)->i_mapping);
> +	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
> +	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);

That's pretty nasty. You're using max() to hide underflow in the
subtraction to clamp the value to zero. And you don't need ilog2()
because we have the log of the block size in the superblock already.

	int			min_order = 0;
	.....
	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
		min_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;

But, really why recalculate this -constant- on every inode
allocation?  That's a very hot path, so this should be set in the
M_IGEO(mp) structure (mp->m_ino_geo) at mount time and then the code
is simply:

	mapping_set_folio_orders(VFS_I(ip)->i_mapping,
			M_IGEO(mp)->min_folio_order, MAX_PAGECACHE_ORDER);

We already access the M_IGEO(mp) structure every inode allocation,
so there's little in way of additional cost here....

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 5a2512d20bd0..6a3f0f6727eb 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1625,13 +1625,11 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
> -	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> +	if (!IS_ENABLED(CONFIG_XFS_LBS) && mp->m_sb.sb_blocksize > PAGE_SIZE) {
>  		xfs_warn(mp,
>  		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> +		"Only pagesize (%ld) or less will currently work. "
> +		"Enable Experimental CONFIG_XFS_LBS for this support",
>  				mp->m_sb.sb_blocksize, PAGE_SIZE);
>  		error = -ENOSYS;
>  		goto out_free_sb;

This should just issue a warning if bs > ps.

	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
  		xfs_warn(mp,
"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
			mp->m_sb.sb_blocksize);
	}

-Dave.
-- 
Dave Chinner
david@fromorbit.com

