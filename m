Return-Path: <linux-fsdevel+bounces-12801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCAF867572
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347CD287064
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C180021;
	Mon, 26 Feb 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XG8c2qGw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602907F7DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951461; cv=none; b=CqlwcrfdCed/VxKxrjdqSrOgM8EpfLhnjYyTz+CQUgC340V4v+h6HYHlVLoKT1VsUhOTZZ72G6oqMHt6xOK9Hf8HqYbCHZklELigv8UX8nLK+jJG/kNRy44035mgtDVpZ6Ji3nWUDYab/s0aUN5sSsnxNQ8wcrPB082TEw+iweU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951461; c=relaxed/simple;
	bh=uDBv6eovvwNdT+3GaN9kzuRnFK1pxbxDzvh1+/xK5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTkOFWT3NnEqxiZT5dljiUzRMEApNknMpyRKo35BYISpzb1A9FjFumdtXd39ufA2RIAJIIBNuTOPl9HKdk9Lrt6+RxqbW132AndaRFvdvBmP2hN5fN/bpCH10m4QGs6/iGwz6vbAgLjCAi3IDYSxB2Hy/krTs9MYtxGuJDkeLCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XG8c2qGw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4560664b5so2405301b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 04:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708951459; x=1709556259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V9GRrB7FsQKdoO/mCKPDN/I5gsB0+aF7FI7yJuEpIP4=;
        b=XG8c2qGwwog5aCdlYX22/9iHp1fPnl1zSe8AdP372N4BQhGeyQmhNl2lfBfviQaLUo
         HzJ1egMGO13VCCXpDg7QTGDNHMhlyHeC0xEv8ANxIZDIqru/U4SsESDGyeKlMKDNHJS2
         3AwzKJ8Irf2fp+X6BE28hZ6N3cUCovGHG+EtZFfgHYwX5JirOTu4B4pEruuMUiaxsBpA
         Xq7hz+dAte7cIJ0TX4t9GN4zeWzd1ZetN1houW4wQ0TesMNg7GQeRrvh95kIVU/bRsWw
         j+HAs9msJTgQplj8kkiW+nzjGgzXK3GsZtcwBVSBVdNKwjWiPb8DH6YuMRjU7CRoltUA
         z+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951459; x=1709556259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9GRrB7FsQKdoO/mCKPDN/I5gsB0+aF7FI7yJuEpIP4=;
        b=lYQeoiPOb5no3ZuxT4gxuvZQGuKklGilM6Vr5Fy9qVP4V8RpmkJrG8xiJnbZIQR64h
         JLnnd8xTL8ztWmcF5XqURSeckD+OIAtCxBCq/KHF4jetRNBnX2+3ACYZQS9PsOh9An9F
         liRHSDUs4GATmnc2rbJijViApxVvAoqkL42nZI6xsI/GHJMoo/3YrkYxvkSM0HW50KXP
         7ivQuWx2neYPGav4F4vcuEWBSY42mDjPfpiwG4f+28c6Lg/NImWYCJO3uEStbk34Q15B
         JumY2WXweMK8yq7+gzbnvcaByFEC+XHC3dQEBVc2BqACMRqQqBeOf7g5PqrI+aZamzC+
         MxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXmIfZ76yuIXmVDnU1/hjKdGhBI88wlsXY+VJcPfexS6RJAoKLo5cMdi4cBwbsfSnoDO/b62Cz5g/TutFl8K/hS99ZxA2SDkPJLMeIgWg==
X-Gm-Message-State: AOJu0YzRmEVRQAgJKEPFzqp/KtU9aN/p1A7J6EBSXehgTHQnfWyJjxS3
	bT6vt6oh1d3lNO4nmUJifHm80ZkIFHiVV6iy8dm2Sh0m6sN2RI2JjXZf9wWecJU=
X-Google-Smtp-Source: AGHT+IGVIPYZ6gPZ6GL6KlSqg0tncDkt7FDH+J+n2o4zbqRm8gNCsIbUHWADIPqxmkwXqGjloP0o5A==
X-Received: by 2002:aa7:9d9a:0:b0:6e4:59b7:1dd4 with SMTP id f26-20020aa79d9a000000b006e459b71dd4mr7434462pfq.31.1708951459543;
        Mon, 26 Feb 2024 04:44:19 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id b27-20020aa78edb000000b006e4195cccb5sm1385769pfr.133.2024.02.26.04.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:44:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1reaLA-00Bkux-1O;
	Mon, 26 Feb 2024 23:44:16 +1100
Date: Mon, 26 Feb 2024 23:44:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, chandan.babu@oracle.com,
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com,
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com,
	linux-mm@kvack.org, willy@infradead.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 11/13] xfs: expose block size in stat
Message-ID: <ZdyHoOHBQ19JJap2@dread.disaster.area>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-12-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094936.2677493-12-kernel@pankajraghav.com>

On Mon, Feb 26, 2024 at 10:49:34AM +0100, Pankaj Raghav (Samsung) wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> For block size larger than page size, the unit of efficient IO is
> the block size, not the page size. Leaving stat() to report
> PAGE_SIZE as the block size causes test programs like fsx to issue
> illegal ranges for operations that require block size alignment
> (e.g. fallocate() insert range). Hence update the preferred IO size
> to reflect the block size in this case.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> dd2d535e3fb29d ("xfs: cleanup calculating the stat optimal I/O size")]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Something screwed up there, and you haven't put your own SOB on
this.

> ---
>  fs/xfs/xfs_iops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..1b4edfad464f 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -543,7 +543,7 @@ xfs_stat_blksize(
>  			return 1U << mp->m_allocsize_log;
>  	}
>  
> -	return PAGE_SIZE;
> +	return max_t(unsigned long, PAGE_SIZE, mp->m_sb.sb_blocksize);
>  }

This function returns a uint32_t, same type as
mp->m_sb.sb_blocksize. The comparision should use uint32_t casts,
not unsigned long.

ALso, this bears no resemblence to the original patch I wrote back in
2018. Please remove my SOB from it - you can state that "this change
is based on a patch originally from Dave Chinner" to credit the
history of it, but it's certainly not the patch I wrote 6 years ago
and so my SOB does not belong on it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

