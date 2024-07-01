Return-Path: <linux-fsdevel+bounces-22835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF1791D62D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 04:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F53B2118A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C876BDDB1;
	Mon,  1 Jul 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QoYW8AT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0C8F45
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719801260; cv=none; b=Q+Wf0YQWFfzsZRi4xwqZOWTCqngc30K2Zv6Yrdqj0s493y2PuB13JCM7PMfcJU0iKNyOFZawoaOlGK2o97QjOr3yUMVrSFaS7F0Tz/MmN1GqZ1Nt8doJF2o/I/GidiIHFD54WVLN+ogZWDx++2myl1sRD7zL8zYTfjHJ6OrLSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719801260; c=relaxed/simple;
	bh=Bf7qvXvOfxSYVxXvw5f+Wqy+aRyboDpvp6TfbZFHb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwd/GcaA2HLOoVZE6BhlW0q95bYpR2Q2KPm5lYggXg+4FenTV1HoO60zjopocchiqnEfwNoNSLI12pifqFktqWIHB9c9wqiNoLahqysi4eLumN9sY8NlVjZ8fDEaKyLCchWW1+GxlptkSJmSgj8YagMnMTZ5QXw+QWV1cOz3JoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QoYW8AT7; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d5666a4860so1615682b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jun 2024 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1719801258; x=1720406058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QA3WiA5BkOYuP93eXhly5M9069HlqMUx74jdW74bq/w=;
        b=QoYW8AT7tK3n3Ja/9hWFt4fTTXLIINixFQqAebS+/BISQsidCbSFcG1HkOEsN3dHbQ
         TuI4xxg7t6qBCeopJ6kdDVrk34lFmbsqDOHE4GLdsvAJV77OJKlXjyx3AVEfJeHJkMqM
         rltcfaDXiMzxRZdgwSEQWuR+VmIqkgVGDOs2Wp5VobnoLFVR50eqyBUNWU35hM/mwgme
         UOcPzy9S+jt/8mZsIXh1AZ7BJMPr2+ODcE5uFXvj0k7yToKL4WOXBR1QfCKDVyUsqBHf
         /xL8VfQHCBthDUScoFIeaMNfFSYg1ue+E75CT4zV4iJKdXt5hSppyulywR+ggwyvSZEd
         Q+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719801258; x=1720406058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA3WiA5BkOYuP93eXhly5M9069HlqMUx74jdW74bq/w=;
        b=B7RfV/B/OdXaYQCzlPLNcNoVGN1vHEBPWdL03hd1HfHvlM+o/HG/Y5el4RRhg2G9ux
         mhwnowZl6w7xScCwwKt04ivc7jrA/QwICrPbCeLQAfGCEwWNUu5yBvMWTebRFlt6vKVE
         dkJGUH5kMPqjNzOWNI2DjCBIdIsezEin6MdcCeQ0V5pp1LfymDmBue6ZTXb/ER9D6CHC
         RLZdaesVG+ICGprK/1C+gQ7v6s5ga5tQwd8ToOr9ohPEOb0kDkn+MGozx+vxf6rD4Tj/
         uTlVAudhiRdQ2kchHs/R/XE7/AVfiG0wrcDJi4yFOUj0gJL0QUvkPIAoL7fSS7fBkWHu
         8wDw==
X-Forwarded-Encrypted: i=1; AJvYcCV092oCEz+3U5HvZKG+AtiW20qSZLGXPIaivir7Px8sHzDXwQr254JZD24DRpLGqGotA7snttvjdz3eugkczCA7Fi2mkLQt5HaeUSz1xw==
X-Gm-Message-State: AOJu0YzIWmkt7PyZUC1cUeQkW1htGc2tFMzfbO3i5eIbdAppnZBHmhZn
	/zV2ONtH/+ki0bZirr3IBj9akfFGJrewskFBe5Q0Rw6P3BqAQ9dj8uZn7d71rqQ=
X-Google-Smtp-Source: AGHT+IEhF1WaXX7e3DF7d8gDsYzeuaQr19iyJwzavDsUGQdMwQeS4CXpEwNMn23ORea7Cbyz40JGYA==
X-Received: by 2002:a05:6808:1909:b0:3d5:1eba:10b5 with SMTP id 5614622812f47-3d6b2b24eb2mr7205732b6e.12.1719801257454;
        Sun, 30 Jun 2024 19:34:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802664d6dsm5312897b3a.80.2024.06.30.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 19:34:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sO6ru-00HQzW-10;
	Mon, 01 Jul 2024 12:34:14 +1000
Date: Mon, 1 Jul 2024 12:34:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 09/10] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <ZoIVpskbpjVz6zfI@dread.disaster.area>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-10-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114420.719014-10-kernel@pankajraghav.com>

On Tue, Jun 25, 2024 at 11:44:19AM +0000, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/xfs/xfs_mount.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 09eef1721ef4..3949f720b535 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -132,11 +132,16 @@ xfs_sb_validate_fsb_count(
>  	xfs_sb_t	*sbp,
>  	uint64_t	nblocks)
>  {
> +	uint64_t		max_bytes;
> +
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  
> +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> +		return -EFBIG;
> +
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	if (max_bytes >> PAGE_SHIFT > ULONG_MAX)
>  		return -EFBIG;
>  	return 0;

looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com

