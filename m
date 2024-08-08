Return-Path: <linux-fsdevel+bounces-25482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC994C6AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66D81C21584
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762F15B149;
	Thu,  8 Aug 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="jzLEKBpg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6152AE91
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154627; cv=none; b=jwIExmXl0KLhjjzIa0zSx3sL2IYjdS8dL1O25A8LBYVDuMvwvkSy17UOJJI+4hplj0JN8uaVlMRbiKRvtK4zyAmlXNKE8EsUTdfxosBM2zVbmiC5asGBzmXAELBK9EfS72xrtSU1woGexgduge0QqAHSBiWpWan7/1s+DfqKQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154627; c=relaxed/simple;
	bh=uNcUY8yHRyYsZM3h0TFO6DExo7cRKiSaWW9bFFCHjf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI7GlZFxqARJBByv1zQeaQ7xGGiDvOSovGjJFEnu43zyvxllPTwyrUjIjkTep4bDj1Xnhtk1P0pZSN9YW/7iNOgw7cxY0ZmHhT7IuES5QKq6nOox1Wt8OLFQKaHozR8zh/D86Ickg5nsCXKEIHh8hmTixMintoypy9qIrAGBZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=jzLEKBpg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so1300174b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723154625; x=1723759425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VovAhXzqSeyRFjRdkVXxIjBd1uS33PY0oNHckm00eHs=;
        b=jzLEKBpgDSGybXWZWEJmJrumuBvpNLa5JQwtVUDab5B9Puo1Z3d3i/lTW1OKBVURyI
         qz1KErkRRI4RfZs4YSAz7aSjlhvk/Daq3plAdNQAiPOT6Gcd3xkr6Zs5dPtawnCdDKb0
         GkdIpCEu6G9atrZpms55nFu+ghHAXvIzEb+mdMqUnjVIViJS00XyEfjVAmphmLtUrAPq
         +zsAKPuk+BMd2wBDSmhzWnHMYvxnfW7P65uuj1O8SFPJwDaVtX5Gk0OdH5o2LsYhj5bh
         gerMzAnXmmezNKc4bIJbuot1vdgxY8NRZ6Ygo9crXj0xI2I54L3RlJ0zfSAe83Gzhjsb
         +Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154625; x=1723759425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VovAhXzqSeyRFjRdkVXxIjBd1uS33PY0oNHckm00eHs=;
        b=W6emvPpNWGxhz9BM+xAmwPteqEBdQ62Q1FhV0jx4Mbr7irKNE/GwfT1KyV6v9O4wR9
         zSG5x6O00KjLFkUat2rQmGz8DMtV0/64u7zIJ2QrU50iqQWzusrBOXK4E024NUr201Zr
         3b1oBR6Wnhdpa4jbNLU0HD1XYwlfeDvtnpUVZTwovJi20Pmm+HXktTfUnIk+ZsWgH6la
         4+Zkdssd1g85q7pxwvnzkm9MZTfT3pQl5OshyKjuOWEMvfo36yMf7x7zWt6OaOlFbuvT
         YtZX5Pl1ufcvrmhLvZX9lRj8v/2qHk12g8DoEG5pr9HpGdjhlhJPXvb+/+ZInnTe+PSO
         M7hA==
X-Forwarded-Encrypted: i=1; AJvYcCUsMmI0Hn2CnY9vo8ow1O04XDWaZRgBMGlRyIwKtvaW758BR/2yne4BO4xnBD0ZTcPrXyfjbumPYrGw+zMsV2YuB4bvG/ilD0iSTPLInw==
X-Gm-Message-State: AOJu0YxJyENlErVJnqR0Ca2HMEeqxYBqq27aTwJSpN5X7mUT8JB/MttG
	aKoyx+JFa8RLARb2APes6eVUHA9qUdncZQJZv+DtakUx4zkvLwRG7PdOQxS+Dkk=
X-Google-Smtp-Source: AGHT+IE5dO8WHZC6Pz9g72R0dboQ8rfRXb+Uzl5pZcpIdVcM7rWuMMHNr1EwN1H2Ba6s/xKz5Hjnbw==
X-Received: by 2002:a05:6a21:271e:b0:1c4:c160:2859 with SMTP id adf61e73a8af0-1c6fcf32732mr3245526637.31.1723154624900;
        Thu, 08 Aug 2024 15:03:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9f03csm1642587a91.26.2024.08.08.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 15:03:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scBET-00ACDg-2F;
	Fri, 09 Aug 2024 08:03:41 +1000
Date: Fri, 9 Aug 2024 08:03:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 16/16] xfs: add pre-content fsnotify hook for write
 faults
Message-ID: <ZrVAvQLfP8fNSJwx@dread.disaster.area>
References: <cover.1723144881.git.josef@toxicpanda.com>
 <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa122a96b7fde9bb49176a1b6c26fcb1e0291a37.1723144881.git.josef@toxicpanda.com>

On Thu, Aug 08, 2024 at 03:27:18PM -0400, Josef Bacik wrote:
> xfs has it's own handling for write faults, so we need to add the
> pre-content fsnotify hook for this case.  Reads go through filemap_fault
> so they're handled properly there.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/xfs/xfs_file.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 4cdc54dc9686..585a8c2eea0f 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1325,14 +1325,28 @@ __xfs_filemap_fault(
>  	bool			write_fault)
>  {
>  	struct inode		*inode = file_inode(vmf->vma->vm_file);
> +	struct file		*fpin = NULL;
> +	vm_fault_t		ret;
>  
>  	trace_xfs_filemap_fault(XFS_I(inode), order, write_fault);
>  
> -	if (write_fault)
> -		return xfs_write_fault(vmf, order);
>  	if (IS_DAX(inode))
>  		return xfs_dax_read_fault(vmf, order);
> -	return filemap_fault(vmf);
> +
> +	if (!write_fault)
> +		return filemap_fault(vmf);

Doesn't this break DAX read faults? i.e. they have to go through
xfs_dax_read_fault(), not filemap_fault().

-Dave.
-- 
Dave Chinner
david@fromorbit.com

