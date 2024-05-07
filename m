Return-Path: <linux-fsdevel+bounces-18867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98C8BD865
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 02:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B652F1F23E58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 00:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3565C;
	Tue,  7 May 2024 00:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IUyxVQE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8B389
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040341; cv=none; b=hR5h4N/eDeWaNE9TBZM623AnglxZGI9GlO9ZZRc7bkfcaoyfV37dbYnbNLk/Yp6B8tSs8/VLNx72pE8ygDN8UM1CyK6Opfez1rEGzMeKMuBtqNr9J9XI03CVQ6ZDGwsQ7vi6v2Sm6Y8RjQ/eBBusZ2GwWxeDx9kfSJDdp58EHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040341; c=relaxed/simple;
	bh=+r96OpFsdE3OiCouE0MboKQhCrMK+ry6ELfJeJnog1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8BTKRjndk1EdUMSyfu2u4ohVhItMAccW0lgKn8QYAQAp99UY3sn6nVOKCjZ4IAsfV1752t8UTZVWNWooegnv6FyOxKT/dH7D6z6JF5N5nnt4qquL4kqDTqCVJV0mchjRUoeWuURktFdZThctbQ/gYicv1jUZhxwC1J2I6+IbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IUyxVQE7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1edc696df2bso18493275ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 17:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1715040339; x=1715645139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/mO8RAIpI3ciXCmAN8uZAWkBK2a+XdI/Wl85E3eh0Xg=;
        b=IUyxVQE7r4mBofKiCzu+Q0FePdp2ilg3FpDTBZak3xlnXkJ01fqpceRZRzYFnWokOX
         e63nJ+KFJvdDjwEPV+fL0PpXQRIsFrH0Nn9eHNNBQ/55jGVmU3yikpReTmY2B8HD+up/
         vkFLxvBw68l2/BL5/pMTYyFdC9WFMkntDvc1a8GHgAUo5NgDiQVnAqzBtL2bkW2twxIH
         KEm3Hb4i5JOIkYKqoWNLBqSQWRtEYe9HpnF6EPcoPs3aPty3ryTXGoJC7azoUIwtMpY+
         P2ZxepmzKX9sFZ/p72kOKOpYuO4u+MwNf//NpHJR/0opNGgtRDGSEVs6Mw4Id4oP3RAN
         yt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715040339; x=1715645139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mO8RAIpI3ciXCmAN8uZAWkBK2a+XdI/Wl85E3eh0Xg=;
        b=pezVb6aRiShM4V2WsLRN+dmsepqQFgcFcLsuyrx0wth93fyW49PnqMhNbsMqM68EpD
         dJJKUXDOJY5xofN6bB8xWiIetkZ4RGKAEFIPzY3nTTlzl1RKC4nGWBHZgxz/AAhCzKDs
         cIaHR4Fr8/Opsad+TQUuFbQ249RYaDXn7GkXvhxIlnkWiniM0fQUO+Flnt/s8FSLjEFW
         aey8HxsCpdNSXPx0JU9n7Es0YKXzkVpeN1+hXtxtnxTxXKA4ezE+EXiWJdLGu2vyWv5Y
         5B5lbn0NC2VDlkVFy+SpCptyrGxGVETOtp8ZBqxQCitOjf34Pvg3QaTreB8a9LRvG+h5
         ioZA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ42jp1Xx4l+SeiAmE368cA2GYVhquHpMx2RwX6caiIjr+0uZfF/6gD497d/MAKa03REKXSyIhqKDB8jfD0J9re5M1m8fakGRzo0lwpQ==
X-Gm-Message-State: AOJu0YyzBvuy7GbZeABhsvMjX9N1XW19YzWlJ6I0xwIfkqNLR/7J5UjI
	Xp5hVMV3k5UG5xmD5eKa3fQArSO6sWkyniOteX40TePK/EADScb/0oBZWnWdSak=
X-Google-Smtp-Source: AGHT+IFMS+uzDdaAPRHwq/U9jqHYjfdEca1j76tOxwxbkz7wqlqDtFC+MYf5HxlMEVl3x/q1hzXhRw==
X-Received: by 2002:a17:903:2306:b0:1eb:1af8:309f with SMTP id d6-20020a170903230600b001eb1af8309fmr18304829plh.4.1715040338808;
        Mon, 06 May 2024 17:05:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001e088a9e2bcsm8829552plc.292.2024.05.06.17.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 17:05:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s48Kt-006745-2E;
	Tue, 07 May 2024 10:05:35 +1000
Date: Tue, 7 May 2024 10:05:35 +1000
From: Dave Chinner <david@fromorbit.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
	brauner@kernel.org, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 11/11] xfs: enable block size larger than page size
 support
Message-ID: <ZjlwT65S9wJVW98w@dread.disaster.area>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-12-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503095353.3798063-12-mcgrof@kernel.org>

On Fri, May 03, 2024 at 02:53:53AM -0700, Luis Chamberlain wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Page cache now has the ability to have a minimum order when allocating
> a folio which is a prerequisite to add support for block size > page
> size.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

.....

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index bce020374c5e..db3b82c2c381 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1623,16 +1623,10 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
>  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
>  		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> -				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> +"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
> +			mp->m_sb.sb_blocksize);
>  	}

We really don't want to have to test and support this on V4
filesystems as tehy are deprecated, so can you make this conditional
on being a V5 filesystem?

i.e:
	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
		if (!xfs_has_crc(mp)) {
			xfs_warn(mp,
"V4 File system with blocksize %d bytes. Only pagesize (%ld) is supported.",
				mp->m_sb.sb_blocksize, PAGE_SIZE);
			error = -ENOSYS;
			goto out_free_sb;
		}

		xfs_warn(mp,
"EXPERIMENTAL: V5 Filesystem with Large Block Size (%d bytes) enabled.",
			mp->m_sb.sb_blocksize);
	}

-Dave.
-- 
Dave Chinner
david@fromorbit.com

