Return-Path: <linux-fsdevel+bounces-41961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F42A39358
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 07:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AC172809
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE01B21B4;
	Tue, 18 Feb 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cYEiOyLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2629A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739859343; cv=none; b=tdlcJ/FIiLpk79/dch+GilRuyDe1QFCHywYX2kdwSCqvMhWwoc4lvgud7iYmq7Dun1i8b69R2wHeU6Qm9XCU5dloCqf0HeChv2tJ5YcXScOtoC+YgnDB6aWvSlNrPNpbR3+PZbGQu06y97Q99DfEEURqgg2jn726qGqUGMeUiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739859343; c=relaxed/simple;
	bh=fNx5h03me5S+z+NJlNI6lij4WcuTFkFyq7y8Fd2B3C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yia7DJsV/lxE6zxFQQ65lRgZn6wYTXmB+49saCre5sd67NRBrLxIxzX8nEa7BQNiH+f++zWflXK6tfccE0oh2R2F/oZnt+Bg6ImzyXJkSBrTGmTeocf1ILIoy1XSFU0ZSbgO9cFAkkuMgrwhRkl/ZQB0AQ7TxSrVgk4r4suKNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cYEiOyLW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220d132f16dso72531575ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 22:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739859340; x=1740464140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmcf5B5KdUSe3Q6Yowv+NxabA9TljnEmIKiC4o0zqD8=;
        b=cYEiOyLW2C5M+VJGS/YXAIPyKS9vrLlkCOLmCCGBd/aDFw59sb2l6PxqSlEg3v2KFM
         k9OtLa5uNGHv8zP2dMuh9d8Avvw8CrhEWpImHvUPQf68oL4aB+yN7J+lCUNYIcxa/GGA
         yuMhUmhfPpysyfduk7QJ7SjcBTVyD3msG/SbNETKhY+P31OeIuRq4LSnHT07AYyP9fVX
         L1gzA8osIToq8xFysNAO43/q8m35uTo8qlg/d01zvcVofIlY8uLhQJwLvOFGrNrOV0OJ
         bA8qd4jkLYJ/Np9eUEl9J55XmaPkfmNBZzyzuQfReSYBMfqdTfx6jB4LBSPLz98lGByp
         /Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739859340; x=1740464140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmcf5B5KdUSe3Q6Yowv+NxabA9TljnEmIKiC4o0zqD8=;
        b=S2Y9PXsBETRAACK6vPL63W7p2DPEeP/UqSjLHnovwHaG3ftgojsUIsjfh7Msf0JUbW
         mFZZcORzuY/dHsnCuYQaqH8mmQcwkUFmEbwA/DGZbv5efCz1cufYGUF1ffSdlwA4OONb
         2UW79pPK7iWT91wB7/nMB9d1Ciq2F+0HgV80zEDLdcYPTmrZKqsLiReFzqPRvmTasJJ0
         nmL7Tk9pghJ7mcw1jJVNjtk/iofZmS7LUbv8JIPHD8M36v5+2b/nwZZEUHilz0+017V4
         bnNT6X9HCFTlTkKvIrkowshx8WRhLCImglIB9IkOlP5mv8YojVCqGxwW8SbhCuQaDeZZ
         9buQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHGQHLl1566MfFj+c9QlRM2guTMnlAbDVhnVkoW23PNj9+GgqZ9MygYNVXX13z/LJ5vbr4FshIn5FxvdRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6m45aROMmfRpuhDIe832ubmWK1LvNrcOd9lURYLuUoJCnfRo
	GqCTlr17wrdGuQqyMGCKD0eH4ii1YeI6UpDyMF85GV/tGMfz4gJge8L7gofGrMo=
X-Gm-Gg: ASbGnctNW9qWUrlMHZ6LzTZuIZkwKQwxgeyj2gyt0MdMXLI4QxdqLFMmAjWxRXmNSIP
	CSK4KSysjpjNyasmBgzX6VzlGWXjvUWuVCEJwAUM4uXm6FR2y1BPCRqxZeKxncj1+ryGVDIvSrC
	szfW60RmYvd9alz1X4gPrnSm+4npzg+hSClxTzdqBLYwU/Y8YfcjICoRK0gcwMwcy0tjSzTEzQ1
	8CvWp9FsidVK14U2AT4/u0nmdj6LjOXTLijThJ7T+BqbydtdpAg5NAjCPtPXXzT/17iGqzbjtiD
	bseOO3Dr1FsgoI6qgtX1Z3C7Eb72l7rRFWfcTcEJftH+eEomTNaiBBQtSiFWA+UZRfg=
X-Google-Smtp-Source: AGHT+IEgl4G26U11CY36YATathuCAnpF80E386MMKenKBlIE6WvmLXyrOHUjBTkfhZHvj9d6jB7Llw==
X-Received: by 2002:a05:6a20:43a9:b0:1ee:6032:b1ed with SMTP id adf61e73a8af0-1ee8cad55a2mr20416483637.17.1739859340119;
        Mon, 17 Feb 2025 22:15:40 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732642d908esm5645953b3a.159.2025.02.17.22.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 22:15:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkGtL-00000002hNN-3xgZ;
	Tue, 18 Feb 2025 17:15:35 +1100
Date: Tue, 18 Feb 2025 17:15:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Kun Hu <huk23@m.fudan.edu.cn>
Subject: Re: [PATCH v2] fs/ntfs3: Update inode->i_mapping->a_ops on
 compression state
Message-ID: <Z7Qlh9856tVuzrYK@dread.disaster.area>
References: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
 <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>

On Fri, Jan 31, 2025 at 04:18:31PM +0300, Konstantin Komarov wrote:
> Update inode->i_mapping->a_ops when the compression state changes to
> ensure correct address space operations.
> Clear ATTR_FLAG_SPARSED/FILE_ATTRIBUTE_SPARSE_FILE when enabling
> compression to prevent flag conflicts.
> 
> v2:
> Additionally, ensure that all dirty pages are flushed and concurrent access
> to the page cache is blocked.
> 
> Fixes: 6b39bfaeec44 ("fs/ntfs3: Add support for the compression attribute")
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c  |  3 ++-
>  fs/ntfs3/file.c    | 22 ++++++++++++++++++++--
>  fs/ntfs3/frecord.c |  6 ++++--
>  3 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index af94e3737470..e946f75eb540 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -2664,8 +2664,9 @@ int attr_set_compress(struct ntfs_inode *ni, bool compr)
>  		attr->nres.run_off = cpu_to_le16(run_off);
>  	}
>  
> -	/* Update data attribute flags. */
> +	/* Update attribute flags. */
>  	if (compr) {
> +		attr->flags &= ~ATTR_FLAG_SPARSED;
>  		attr->flags |= ATTR_FLAG_COMPRESSED;
>  		attr->nres.c_unit = NTFS_LZNT_CUNIT;
>  	} else {
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 4d9d84cc3c6f..9b6a3f8d2e7c 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  	/* Allowed to change compression for empty files and for directories only. */
>  	if (!is_dedup(ni) && !is_encrypted(ni) &&
>  	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
> -		/* Change compress state. */
> -		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
> +		int err = 0;
> +		struct address_space *mapping = inode->i_mapping;
> +
> +		/* write out all data and wait. */
> +		filemap_invalidate_lock(mapping);
> +		err = filemap_write_and_wait(mapping);
> +
> +		if (err >= 0) {
> +			/* Change compress state. */
> +			bool compr = flags & FS_COMPR_FL;
> +			err = ni_set_compress(inode, compr);
> +
> +			/* For files change a_ops too. */
> +			if (!err)
> +				mapping->a_ops = compr ? &ntfs_aops_cmpr :
> +							 &ntfs_aops;
> +		}
> +
> +		filemap_invalidate_unlock(mapping);

Holding the invalidate lock doesn't make it safe to change aops
methods. We've been down this road before - find some other way to
switch modes internally to the ntfs filesystem, because changing
aops pointers like this is *not safe* and not maintainable.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

