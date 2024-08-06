Return-Path: <linux-fsdevel+bounces-25069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2894890A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 07:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C13EB22260
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCC1BB6AB;
	Tue,  6 Aug 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Fgt2R3DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF67F15D1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722923269; cv=none; b=rjYHPHKF0SlaNCKJvG1/e3zxsD4gc2am1T9qkii1ChKGuT39BrzoiKWFPB6RE+BCVhzqNy99Op0z+pxojo0YBYRh4o+uHIdAM5L4td6aae13lF4zPICaaDyFxl1mzgrcuoQqCrBs8qTttdThAMLLX+D15+i+SVC9pFoNe3MZ/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722923269; c=relaxed/simple;
	bh=ZAnCYbthDNaC6E3spLlTHxPvBgC/HXDFOy5xsaHj/to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxpziw2TvC+D3OPpsdhOhOak2qY3imISvX5uwCZfuWpcITmuZcHEojZbULoLE2r311DfE0m1NFj7QkSTWvWgQHPJjbSjTzpM0Yi2/p0A/1WVZAU3l2Bhz4pHZOSX+e3x2j+vmVBRWTydT7vY0HjddgjPdjxDyIvpM6IUgb8JVM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Fgt2R3DL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc52394c92so3948585ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 22:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722923267; x=1723528067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PCvu3jUWg5RiiqwS67xwu/LH+KoGJOwvz4tw35SS3VA=;
        b=Fgt2R3DLTqW2d+PUgUawxeBVAUX56LfZ6Av8nQhNk15nOJFgU/URSOfSfZFTkWLUAm
         P6d6czfFGQqwasMREJmPg6sju3s52WgepbJ8htq7w+MEuPTneMP4TBRDsmYJm+ZoJpSj
         bNM/AmW5WzNssofzCt5EfRAJ6+/orZ2qBEjd+eM90JM0IE8jb4O7VWZIYhQkk9hKxdWJ
         BU79wmH5cU57jRXrxOeycHkxY2XFrgCNMdenQZOfAqIOvyqpAAuDB/DNNDL8ro9VOxUW
         rdNOm9W8mlW+Aype9VcB6BJ2sXpUXRtTCbBO887/wIPk4FI9ukNp4XpAM2arxqHZGz6j
         ZMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722923267; x=1723528067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCvu3jUWg5RiiqwS67xwu/LH+KoGJOwvz4tw35SS3VA=;
        b=PyIwvXvfBF3dZITiKn1fNxRk9Spy4pGwzIhXfeGOKOYF4zkM8ATL8CvK6brpQt7IsH
         Jn8vnr0b6nE5XG2qOycEGt2ASrL4UB9AGxP6zPyqp1NrrPPQrUcdXKTVS0Av1g/Gb/5H
         lFhFZ6eMuZQXcMdg3i9zpG5mB02FqaTjRfrKLAjxttIIIisG808O29GfDu4IaIx9WF0x
         LDXwreByeUVm0II3y65ilsONk5jjFpPjrfr6lMMRSYeyUJNb4NrBUA2+5JxPO1uKYA/P
         olGjqWjZvmn5BE0lDTHIVZi55ketGrOV4LRN0znZAw+XIEOtkX9WTOtqKO0IJHD7i8f0
         DDgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhaQGw4CY8HFL62iJiXmnIQy3EpEeiomjRZhhgdIwxMNCG4HHU05Yrd1UXYh/9BYO0pKyCpxCO9mmys1DKGkwtq/n/DEYBXe7U28jh5g==
X-Gm-Message-State: AOJu0YzJhgtM+AoZ9rjwr8Llj7GlQPijfwixtFrDf/KzRxvK+5+ZG+v3
	Imv+q38+TbbRZe3X+o0QRQwzpgbbs2qXkuEiEJBEY60nhvGlgg/L85xng2EvN2hIxZjJ3pIoe6l
	m
X-Google-Smtp-Source: AGHT+IEKKRBjFY/OMGyEJSARsnlWwcOJg63a0b03/HVwkXmRoNqqRj2uuiNV3+rkhc602v8myGOeag==
X-Received: by 2002:a17:902:e885:b0:1fb:4693:d0d8 with SMTP id d9443c01a7336-1ff5725879amr171629145ad.18.1722923266933;
        Mon, 05 Aug 2024 22:47:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592afe6fsm78380985ad.296.2024.08.05.22.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 22:47:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sbD2t-0072Ho-2w;
	Tue, 06 Aug 2024 15:47:43 +1000
Date: Tue, 6 Aug 2024 15:47:43 +1000
From: Dave Chinner <david@fromorbit.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <ZrG4/8pjGRC2v1PX@dread.disaster.area>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804080251.21239-1-laoar.shao@gmail.com>

On Sun, Aug 04, 2024 at 04:02:51PM +0800, Yafang Shao wrote:
> Background
> ==========
> 
> Our big data workloads are deployed on XFS-based disks, and we frequently
> encounter hung tasks caused by xfs_ilock. These hung tasks arise because
> different applications may access the same files concurrently. For example,
> while a datanode task is writing to a file, a filebeat[0] task might be
> reading the same file concurrently. If the task writing to the file takes a
> long time, the task reading the file will hang due to contention on the XFS
> inode lock.
>
> This inode lock contention between writing and reading files only occurs on
> XFS, but not on other file systems such as EXT4. Dave provided a clear
> explanation for why this occurs only on XFS[1]:
> 
>   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
>   : Atomic means that all the bytes from a single operation that started
>   : out together end up together, without interleaving from other I/O
>   : operations. [2]
>   : XFS is the only linux filesystem that provides this behaviour.
> 
> As we have been running big data on XFS for years, we don't want to switch
> to other file systems like EXT4. Therefore, we plan to resolve these issues
> within XFS.

I've been looking at range locks again in the past few days because,
once again, the need for range locking to allow exclusive range
based operations to take place whilst concurrent IO is occurring has
arisen. We need to be able to clone, unshare, punch holes, exchange
extents, etc without interrupting ongoing IO to the same file.

This is just another one of the cases where range locking will solve
the problems you are having without giving up the atomic write vs
read behaviour posix asks us to provide...

> Proposal
> ========
> 
> One solution we're currently exploring is leveraging the preadv2(2)
> syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
> lock hung task. This can be illustrated as follows:
> 
>   retry:
>       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
>           sleep(n)
>           goto retry;
>       }

Hmmm.

> Since the tasks reading the same files are not critical tasks, a delay in
> reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT but
> also enables IOCB_NOIO. Therefore, if the file is not in the page cache, it
> will loop indefinitely until someone else reads it from disk, which is not
> acceptable.
> 
> So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). This
> flag will allow reading from the disk if the file is not in the page cache
> but will not allow waiting for the lock if it is held by others. With this
> new flag, we can resolve our issues effectively.
> 
> Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/ [0]
> Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.html [2]
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Dave Chinner <david@fromorbit.com>
> ---
>  include/linux/fs.h      | 6 ++++++
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..5df7b5b0927a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3472,6 +3472,12 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
>  			return -EPERM;
>  		ki->ki_flags &= ~IOCB_APPEND;
>  	}
> +	if (flags & RWF_IOWAIT) {
> +		kiocb_flags |= IOCB_NOWAIT;
> +		/* IOCB_NOIO is not allowed for RWF_IOWAIT */
> +		if (kiocb_flags & IOCB_NOIO)
> +			return -EINVAL;
> +	}

I'm not sure that this will be considered an acceptible workaround
for what is largely considered by most Linux filesystem developers
an anchronistic filesystem behaviour. I don't really want people to
work around this XFS behaviour, either - waht I'd like to see is
more people putting effort into trying to solve the range locking
problem...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

