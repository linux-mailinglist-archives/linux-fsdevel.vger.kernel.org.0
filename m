Return-Path: <linux-fsdevel+bounces-40004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B41CA1AB2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7733ABAD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF201C5D4F;
	Thu, 23 Jan 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j1aCEUK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA511C3C1A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663893; cv=none; b=A3EvwUV+6RNQdj22DELgdolCAOdXJJSSI8K6rtmMR/zpui66vc9Wb4P8awWpR9++XOGze4GbA5qvYHmWhiYKmdjVClS8DUmai0LaPIY1N6e7LykQNcyRonVravzpq0xI0xHbHG42dNSYdz8BCEHmnOITsA1EkAqUK8c6lRijyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663893; c=relaxed/simple;
	bh=kLTU6pzyItby0Xy68IXUlVww8A5hyuVx1r9o6Jn2yyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KImM54eHcw9dDu+aSytAsbosiVq4cOOo/wsebtAS0rJSheguENZO6gTEJ4jpDKuYGMSN/O2sxnMkKnQnMHAcrN0IXMWtLm4CFjSN7WIFajh6Vjhfkn6wYner61B23wDJZFSNpw9WkqapMgdqA8zf4kw7RB4zXytcwDP0XHgzb58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=j1aCEUK9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso2565795a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737663890; x=1738268690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwxbQH9kgdkSqlPoE+manNQA8Ci31FJ9FZBvSpHLAn4=;
        b=j1aCEUK9CeXYTu6E7K5BTbm808nRVGCB49cJv1QTWBtIqyvzcarBnWikBgwuFUQxPH
         /zsDcvxnKoYDXUv0OfFOVq2RzuQKgCMhxqADDWt1JLXu4SkwE6cjky/iqdMlpcbtslia
         QCc8iqZdLZoxAqcDIbuPRfeGY5YLP8c/e6LmlAAz0A+0VQ2XpiLIuNMBqBtJf/laWbUZ
         yT3R7poIgIPOAPFB6G0dnnVONec1i7aD6dLFfzUdwLWgjfdpEVi88+ag7I8kzwM/pSlf
         hlbou0XBkkaK/3x7GM75QGxrUFZsfEp1+Ee5+ImIhaA3KR/rZ5HKgs1nVwK+UUZbu52s
         q29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663890; x=1738268690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwxbQH9kgdkSqlPoE+manNQA8Ci31FJ9FZBvSpHLAn4=;
        b=IrAzRHfnr/vUnkNf0YEg5QhNXsjqTbpzdPgYErXDnqWUjXLSxntVvItIjmvSsfD/CD
         VizqQX8luOs6GVIVXr/XTBt1Rb+/SHo/hli0zgQz2PsSTK6MA+NB4jENsY8YNWwZQ45w
         abzKo3uZEcT92xDM2+R7TANFGAGBi2RBpmzU6XzvA9T4VnLrr6tEhCPC5mQJLfFS8qTe
         4zAf2IKHJrYq66iuMgvNMp2M34iDc5Y8qc6jb4bhaf2ywXBf0cGB4G2viJubEwOZT6fi
         PL/rlErG/FmkXJ5s7VooQH/eveJfXvoBHbSvJrtXRj1KD7lqauS/yUgBoOQJutdKFoIc
         4saA==
X-Forwarded-Encrypted: i=1; AJvYcCUlCWPvtLkodb5xmfVdLp0lxGe6TPnoMr27xRjGgCeB5zbeQbUwf3j3Alv+zxiMdGC1pxAAGRF+w9GqO8MT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2H7/Hsrl4ITLqRBdKTsoGEiTkmA0Kuv5pMAWk5kF5Yvtls0rw
	obRzsgNqG/2AivS3lMb21lsbmjy2M5AbOnU2BgBoYyx1Pi5hm9937E6VLj+cYFo=
X-Gm-Gg: ASbGncs5RC2pM/xgkHopnH2odm2m2cmua+AtrqUgZPfw2gTY46ps/Km94c6z9UmOO4O
	NEMMDGc8f+4x014KNorIpLIh/6AhhD2vZqL2rOq8wNFO7q9AFgCJiW5xxdHEU1UO2KK7TPgrGk/
	otVCgBteZmf+NN7tXAO0ZSAPYrpvZV50KYTnWo2I8DcejhvPAq3MEorA22tzgMei3hhqGfKYils
	AwIsMJ86VdMW5TN9aGeSnF2irfFfJ7YlICGwbIz31v89WsNI4nZPu0ZpIiqNXyXxqMNdlU/cWFj
	91j6iHzdd44i29+xQvxtaco19P9pwGkYcuibFnjqYDOsEsJmGhASTW6/
X-Google-Smtp-Source: AGHT+IEDWgzC0RvHUKB4IxqckjyA0ZkEijLZzCLsb3DH4LWINRo1G1cTO4KJdVOfn7eQaWHn0DCVVA==
X-Received: by 2002:a17:90b:3a08:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-2f782c8f352mr40851352a91.8.1737663889811;
        Thu, 23 Jan 2025 12:24:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6acd0sm151904a91.28.2025.01.23.12.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:24:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tb3kr-00000009dTo-2VTC;
	Fri, 24 Jan 2025 07:24:45 +1100
Date: Fri, 24 Jan 2025 07:24:45 +1100
From: Dave Chinner <david@fromorbit.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jiaji Qin <jjtan24@m.fudan.edu.cn>,
	Kun Hu <huk23@m.fudan.edu.cn>
Subject: Re: [PATCH] fs/ntfs3: Update inode->i_mapping->a_ops on compression
 state change
Message-ID: <Z5KljQpaTp9ZlJxj@dread.disaster.area>
References: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>

On Thu, Jan 23, 2025 at 04:53:35PM +0300, Konstantin Komarov wrote:
> Update inode->i_mapping->a_ops when the compression state changes to
> ensure correct address space operations.
> Clear ATTR_FLAG_SPARSED/FILE_ATTRIBUTE_SPARSE_FILE when enabling
> compression to prevent flag conflicts.
> 
> Fixes: 6b39bfaeec44 ("fs/ntfs3: Add support for the compression attribute")
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/attrib.c  | 1 +
>  fs/ntfs3/file.c    | 2 ++
>  fs/ntfs3/frecord.c | 6 ++++--
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
> index af94e3737470..d2410ab6c7bf 100644
> --- a/fs/ntfs3/attrib.c
> +++ b/fs/ntfs3/attrib.c
> @@ -2666,6 +2666,7 @@ int attr_set_compress(struct ntfs_inode *ni, bool compr)
>  
>  	/* Update data attribute flags. */
>  	if (compr) {
> +		attr->flags &= ATTR_FLAG_SPARSED;
>  		attr->flags |= ATTR_FLAG_COMPRESSED;
>  		attr->nres.c_unit = NTFS_LZNT_CUNIT;
>  	} else {
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 3f96a11804c9..e8f452f47cd5 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -105,6 +105,8 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
>  		if (err)
>  			return err;
> +		inode->i_mapping->a_ops =
> +			(flags & FS_COMPR_FL) ? &ntfs_aops_cmpr : &ntfs_aops;

It is not safe to change a_ops dynamically like this.

There can be other operations running concurrently using the
existing aops, and some functionality (e.g. the page fault paths)
have dependencies between aops methods and swapping the aops between
those operations can cause all sorts of problem (including crashing
the kernel).

This is the reason why we cannot turn functionality like FSDAX on
and off via fileattr_set() methods setting/clearing inode flags.
The inode has to transition out of cache and be re-instantiated to
change the inode aops methods safely...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

