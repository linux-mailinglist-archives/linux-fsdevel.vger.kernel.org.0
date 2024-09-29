Return-Path: <linux-fsdevel+bounces-30320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CF989867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 01:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53D31F21650
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 23:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5C17E012;
	Sun, 29 Sep 2024 23:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MBtavOo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62E18EB0
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727652206; cv=none; b=pi1pOag086t6Udqs/AwpxFPjREaPauhx42M45lcnHOLtt1KQQ56/q6LTQWV8iuMe5fvLXEzf1QcUW+Yn3mExDMpNETTCH0uIIylMvAszMIoOyqZZD5rxsRslXV5iX+JKC2lKcfHBFN+u4qB7kYDswLfusUfu5ji3d7f9HCkWneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727652206; c=relaxed/simple;
	bh=NjiUM8DYsZYO33SPbNfp1mswW0oLD2KvstRs8zVWDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd+5+kyC1w76n0J6RGoM9AKusjh9tOOkmc3j94qsgA9u2N/3gpJtUnvO/URWC9CI+Qy3lMQopB1/r9VbGMmYVO/aph02TLO7jCr+vE0XdbCLPOcFBXZ85PLoFUElKRpvDVuPJPcsBw6yLM5uEyobSKzAYa46Mk5+dYgtulXFAGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MBtavOo4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71b00a97734so3274495b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727652204; x=1728257004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XVPIcDr0WvhWO6ztyJnBinOFQAeaT2H7Vw3yuyZBPq8=;
        b=MBtavOo4vy8+DmhGPFAeMfLcn6/KWI6gQTyv8Z7IprIHWVPZY0rbK8W2j075BGxtey
         V7ssnDzLWw/OdfOwD9JlIggRmh6CVCsnZWr4NuXsi//7GYqzpCBW+S7rQnzblGA5Nae6
         FfvNh46hMc18xt7Qkrkw9ybomjYRPo4dv0XvhHxoPouF3WkSbRk1LgPkSntthMThfi3+
         Iq+W/On9v1vzkP/W/j6GMH/a4Izx4wLNkGUUf8EINO5a7iwjoRWL4yLuKrss9Oq/DUhC
         CX3+3beT6B9LmYgYDWzyhDRYXHl8cdEo9AwOh1SvdlLXSc8582THK2hUJjZCgBNSmWfz
         Sn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727652204; x=1728257004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVPIcDr0WvhWO6ztyJnBinOFQAeaT2H7Vw3yuyZBPq8=;
        b=KPNejP1YkLCLIhgXN/+p43/w2iKG3XmX21QECcK8673sqh/b2voPJb9caBaLPSM84M
         OG9Z6fLzi6Fra0IfqUnXUYkYvL+L0jOQSBo4QTv3IsZliHHQxqTbpy7NoRjfFN6/+HlB
         fO3goIWZ0eSS8LEoiDou3H+AFHq0vre4yW5tjbvtzTu4nmdgXYhyeoKfX3xPqa6rJD8g
         ndYlAgiv/qzswWn3EnxXA++w3HnUG52hsf8rFiBUmZXXNPH1Fe99Nj2JnxL/9VvFblhX
         ltSiREsjk//zLAZHKDgPuvpB6dcIpbE2yvo7NwjgMIA2Y8J0CGnryunt6fsEoKhrPZPR
         L8xw==
X-Gm-Message-State: AOJu0YzDevtZTvrh/M1l7sFf3wD5/Wuv0dTk/U8QbVdnOk1cglDs/MDr
	rkgJbnNxOGZ6tkFmxy8ouWmbCL88EKR5MB0DuSL9wogNWWUbPxGXt1R4Q4hB5UwW29JfJvyBUas
	G
X-Google-Smtp-Source: AGHT+IETKSJ63nh9ktOURi5w3NTuSOfHNMzqx2xmG7CM0+NLIe1yHGjGOw5Md0rPA1rcYe66pV5mYg==
X-Received: by 2002:a05:6a00:1956:b0:717:900d:7cbd with SMTP id d2e1a72fcca58-71b25f0b1e4mr15305266b3a.5.1727652204243;
        Sun, 29 Sep 2024 16:23:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db610c99sm5341934a12.76.2024.09.29.16.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 16:23:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sv3G4-00BoaP-1q;
	Mon, 30 Sep 2024 09:23:20 +1000
Date: Mon, 30 Sep 2024 09:23:20 +1000
From: Dave Chinner <david@fromorbit.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, hch@lst.de,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] xfs: do not unshare any blocks beyond eof
Message-ID: <ZvnhaPWplOK4cNa3@dread.disaster.area>
References: <20240927065344.2628691-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927065344.2628691-1-sunjunchao2870@gmail.com>

On Fri, Sep 27, 2024 at 02:53:44PM +0800, Julian Sun wrote:
> Attempting to unshare extents beyond EOF will trigger
> the need zeroing case, which in turn triggers a warning.
> Therefore, let's skip the unshare process if blocks are
> beyond EOF.
> 
> This patch passed the xfstests using './check -g quick', without
> causing any additional failure
> 
> Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
> Fixes: 32a38a499104 ("iomap: use write_begin to read pages to unshare")
> Inspired-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/xfs/xfs_iomap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 72c981e3dc92..81a0514b8652 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -976,6 +976,7 @@ xfs_buffered_write_iomap_begin(
>  	int			error = 0;
>  	unsigned int		lockmode = XFS_ILOCK_EXCL;
>  	u64			seq;
> +	xfs_fileoff_t eof_fsb;
>  
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
> @@ -1016,6 +1017,13 @@ xfs_buffered_write_iomap_begin(
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
>  
> +	/* Don't try to unshare any blocks beyond EOF. */
> +	eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +	if (flags & IOMAP_UNSHARE && end_fsb > eof_fsb) {
> +		xfs_trim_extent(&imap, offset_fsb, eof_fsb - offset_fsb);
> +		end_fsb = eof_fsb;
> +	}

No. The EOF check/limiting needs to be at a higher level - probably
in xfs_falloc_unshare_range() because the existing
xfs_falloc_newsize() call implements the wrong file size growing
semantics for UNSHARE...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

