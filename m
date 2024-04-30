Return-Path: <linux-fsdevel+bounces-18387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B108B830A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5104B1F2388D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2549B1C0DD3;
	Tue, 30 Apr 2024 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OB8Lb87u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAE29A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520124; cv=none; b=X86qg1dJP5q12umI28EZvnLsyAJaWo004XooHPlcrMEW2W+TaZyUZCCL3zoyuuf0Ao7WrZgCDMKcX7HThat0xPdgX3sQRc2NXcJj6gQy7H0ywcj3v1226JR6SDAu9EtSd5r6bocwYexNC8jDWFtFAU2ZBMr4ZIsCTc3s3jWLCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520124; c=relaxed/simple;
	bh=zPLAG6BC9oqdmiJPIVvNKy2SbltyL+Qt1bdLKj01Us8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ori4oFAB7qarEB7itbztkm1IrD62cFHfY+MVvZGyKYs1PO3bUi77RRUXAaNJ+O12sYbs4gruxu8Yc3S1UqEhhlbsH3qe/3kUm0ES1JeTQtvw7sZBrnpC1mfup4e9vO9wcEH03YW79zwarWSrGmxLnXzziKUc/oG14h4GhVOypHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OB8Lb87u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec41d82b8bso12673385ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714520122; x=1715124922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebJ+P7E3aPLzGdXLYVSI2foIXw8t4rGULdg+JhpGfGw=;
        b=OB8Lb87u/3QqijEVkcv43sf0DSe4BNdNBWcFn2i8Y8hMd4lHZY+sRMdDhkukp1CTZz
         bed9P3Hy6+rW4/hjOg7Uvp20Po4sBx/1vYyeDfXMG5q1TJk8RsuWUSLIcMSbp0a+GorD
         7jP2TknkPKtpd5J0E67wp+JCFFWh91KQI+Vv9WG5qPIqCzfIa+RXwwzZiBF0PIzs8lyf
         qJBJ22SUyol+9NBZYCWryewVVjv0LhYx+MjTj7CirvD+Dcpmy538+JFMk2kI2Z2J9/27
         xGJOI2HJsGC/lxRbdBqS9HLNqnwI+/wOzDpy8jJH/NK97f6pJ9RgDHa6dY9iXNLFE41H
         KX1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714520122; x=1715124922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebJ+P7E3aPLzGdXLYVSI2foIXw8t4rGULdg+JhpGfGw=;
        b=iuuj1P+0ZIj22D7vN5X0zHknI3mHkjgeQ5e2GOKTQ6b7KwFQzCF1/NKGvddmH7isT8
         aghnr/26jHw+JbMigVE4vGbURi+2uO4G32KBm3KhlUjVMmZ1bIZwj1DHKUKDIKyuKEH6
         WnajSx/d/8npvhyXRL9wXu6fb4dALJT7zSLPzkqhe6Njn4wMUS8nGk5A7bcOxqRxiG3k
         dmgZZL1WHVDNpppQ7t6G8b+lJPprxUXMiC4dCyuEuQrsMWuIrWAJxz2s6tR3xGT+JYFB
         jxRuFVodSxYugIR4V+wKqOKpxqJrkvNQS/bhiVAXIOrHxyRIeFJP942kOhVcYoTCB54Z
         z/zA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpBbm+uhF1njoNBu+nAOOdsVEmsWCvrKf9fmmWRDTUqE8c0ZbutfOT4++ZxTFA4kT7vSoYTCyRurV04K/hyIK6tIIhNLdEel704+NYw==
X-Gm-Message-State: AOJu0Yypy63vAb/r42tMXXeqc0k9lYVD7lSLfuOVF9PbxLSRHGdrXFgP
	cmA+Vh/6ldwWWtuYH8VSFD6GgEQZK9GnKGBDHJYicixxtatTosR2SiCnjIhtw3w=
X-Google-Smtp-Source: AGHT+IE3t6+966YIcpEKzQ8cccfZ2BAKj6uBcJiHH6Y92YMU+lJ5oaeNPKZc5ddIgEnzUQ298y/KoQ==
X-Received: by 2002:a17:902:bb17:b0:1ec:6b87:e125 with SMTP id im23-20020a170902bb1700b001ec6b87e125mr867641plb.50.1714520122398;
        Tue, 30 Apr 2024 16:35:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902c78900b001ea699b79cbsm1603839pla.213.2024.04.30.16.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:35:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s1x0J-00GjfX-18;
	Wed, 01 May 2024 09:35:19 +1000
Date: Wed, 1 May 2024 09:35:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 10/21] xfs: Update xfs_is_falloc_aligned() mask for
 forcealign
Message-ID: <ZjGAN8g3yqH01g1w@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429174746.2132161-11-john.g.garry@oracle.com>

On Mon, Apr 29, 2024 at 05:47:35PM +0000, John Garry wrote:
> For when forcealign is enabled, we want the alignment mask to cover an
> aligned extent, similar to rtvol.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 632653e00906..e81e01e6b22b 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -61,7 +61,10 @@ xfs_is_falloc_aligned(
>  		}
>  		mask = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize) - 1;
>  	} else {
> -		mask = mp->m_sb.sb_blocksize - 1;
> +		if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> +			mask = (mp->m_sb.sb_blocksize * ip->i_extsize) - 1;
> +		else
> +			mask = mp->m_sb.sb_blocksize - 1;
>  	}
>  
>  	return !((pos | len) & mask);

I think this whole function needs to be rewritten so that
non-power-of-2 extent sizes are supported on both devices properly.

	xfs_extlen_t	fsbs = 1;
	u64		bytes;
	u32		mod;

	if (xfs_inode_has_forcealign(ip))
		fsbs = ip->i_extsize;
	else if (XFS_IS_REALTIME_INODE(ip))
		fsbs = mp->m_sb.sb_rextsize;

	bytes = XFS_FSB_TO_B(mp, fsbs);
	if (is_power_of_2(fsbs))
		return !((pos | len) & (bytes - 1));

	div_u64_rem(pos, bytes, &mod);
	if (mod)
		return false;
	div_u64_rem(len, bytes, &mod);
	return mod == 0;

-Dave.
-- 
Dave Chinner
david@fromorbit.com

