Return-Path: <linux-fsdevel+bounces-13821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF48741E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 22:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BB1284A82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A51B59E;
	Wed,  6 Mar 2024 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="O6ypum9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D1F199B8
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760179; cv=none; b=KqCu9Oq/4bJMWCHDq54EZZb7BYC5Dm29ohriji15c8tBRcCAJDritxG6nQ/oz8DlSQrXwb8t1B1zX2FKg9I7IyVNHepGTnl3YxplkR+X5TiDoCM0FB53GFk5vkaOO0epBbCY4or/j6g2tvcQ1Sr42qm7KMcvLsql/FwwQtb5afw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760179; c=relaxed/simple;
	bh=jDwU/FSgX0dPRWta9QWi+N1QVGUQfefYU1X1kDZhOeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA/mCPUTIroScMhF0hp4RjzGbk8sXcNkB4lWSTOXvRjwJp3+xM46Bgn33UIQxUXrHHNMb1a7en7kjNjNFqa2dbpbJuRLUORgjx43SCnT/p1s5xr/seN/zJOOegl4MApkV9DbniQoo47ZKbE7o3WYs+57n424PV6iOCVaoZd/73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=O6ypum9k; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce2aada130so148234a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709760177; x=1710364977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baJ4zqh9oXR7f9aDtD31POIXdOIpumdQpgWGwrDWDeI=;
        b=O6ypum9kwu8eEa+C7YqI1RgmjFIG3Hlr3Yz7dsPyFPU7SICPtDYTCfgcz/SNtiY0EW
         OibtuMacyl+TKwlOyrcqk/1QybUYVmR14QLeyqSc5aPKCrMlEZ9FvyRqwTP5Tb5fZTJL
         yAT7zmOcDwlot74aMq1HGkdzKPmxgF6tWwXcv0g5XwZEcSkWPPwg/W5+BXOm86tWFMN2
         FvJp8PEzXrt7AdbfoQqSDfUs908dtQ4pR/a3prrKjFysDsrRWA9I0WX3eF/WUxtW3ykN
         KOIua7VimliVmg0lAPdBevVR6nrFCcejej6wOZNQRLcdZJr/6HmBQ78OhrOpGjo25mp8
         d1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760177; x=1710364977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baJ4zqh9oXR7f9aDtD31POIXdOIpumdQpgWGwrDWDeI=;
        b=qf4DaoB4z2ip03EzIrZ3t8/G2WyDCIW+BhwObigD4RAnU7KWmuQmBeg2jopM/1WyWV
         Jb4smSwu81Wi/pohyZQ8kXp/vq3XPGZRxLVmWFMPo3kJaa56neCJw6Twrs1Uymv0ZXkn
         s3W8QhK8Rcr81NhXRw6rdE//Sxd0iei6Lb5eMQFnNVZHHCCML7AU4oHKx25TP5wur7mV
         hQjRE4iEMYa4Z1nqwQxf3Yq2M9P3N8pRcbr6xV92YEodKgAujRK/r5Re6z8IDxPph+wO
         un4Iye6yVawCMhfpge3C+jViQvjeFzIKbv06JGTKZOLMjZX8tiKtIHZNfP9ZKtl/2Rfl
         9/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXi0/9HJsVaRtr9JJfV6D+MM/MmaFQJ/nvUMGCKx3xQmVkpid40gzB7s2Nnr0Usu5bx8cNj6U3Ul0j40Pa6maIjhF0WtUQ1euN6SS+bsQ==
X-Gm-Message-State: AOJu0YxGeUJqM0vRR3A2WRHLV4nnhMjeMF9hIlIczfBU0BxdWwhTWelL
	0/NYazsjqXb+brgHAee5xKg3gIgZHGoTLki1jo32/WO20RlKs1Qh/pb7SjQpsCw=
X-Google-Smtp-Source: AGHT+IHFP+3O78AL/mN2ueWeIh6787k23eU38trFCaaTH7ta+c0RSWosJj0XfeW0j9oTouH0cszArg==
X-Received: by 2002:a05:6a20:80c3:b0:1a1:4d4d:ca8d with SMTP id d3-20020a056a2080c300b001a14d4dca8dmr4957747pza.50.1709760177149;
        Wed, 06 Mar 2024 13:22:57 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id b128-20020a62cf86000000b006e510c61d49sm11739679pfg.183.2024.03.06.13.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:22:56 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhyj0-00FyDL-0T;
	Thu, 07 Mar 2024 08:22:54 +1100
Date: Thu, 7 Mar 2024 08:22:54 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 13/14] fs: xfs: Validate atomic writes
Message-ID: <ZejersjddMNdkDqz@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-14-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-14-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:27PM +0000, John Garry wrote:
> Validate that an atomic write adheres to length/offset rules. Since we
> require extent alignment for atomic writes, this effectively also enforces
> that the BIO which iomap produces is aligned.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index d0bd9d5f596c..cecc5428fd7c 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -709,11 +709,20 @@ xfs_file_dio_write(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*from)
>  {
> -	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> +	struct inode		*inode = file_inode(iocb->ki_filp);
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
>  	size_t			count = iov_iter_count(from);
>  
> +	if (iocb->ki_flags & IOCB_ATOMIC) {
> +		if (!generic_atomic_write_valid(iocb->ki_pos, from,
> +			i_blocksize(inode),

a.k.a. mp->m_bsize. If you use that here, then the need for the VFS
inode goes away, too.

> +			XFS_FSB_TO_B(mp, xfs_get_extsz(ip)))) {
> +			return -EINVAL;
> +		}
> +	}

Also, I think the checks are the wrong way around here. We can only
do IOCB_ATOMIC IO on force aligned/atomic write inodes, so shouldn't
we be checking that first, then basing the rest of the checks on the
assumption that atomic writes are allowed and have been set up
correctly on the inode? i.e.

	if (iocb->ki_flags & IOCB_ATOMIC) {
		if (!xfs_inode_has_atomicwrites(ip))
			return -EINVAL;
		if (!generic_atomic_write_valid(iocb->ki_pos, from,
				mp->m_bsize, ip->i_extsize))
			return -EINVAL;
	}

because xfs_inode_has_atomicwrites() implies ip->i_extsize has been
set to the required atomic IO size?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

