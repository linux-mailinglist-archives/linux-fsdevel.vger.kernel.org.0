Return-Path: <linux-fsdevel+bounces-27750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6596388C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B621C22129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2847781;
	Thu, 29 Aug 2024 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zV8Q8Kv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB5723746
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724900617; cv=none; b=fz55dFVX7rLYgavjZ/NlftyvU7+E9ayz05azmYaWZMSzye/iwnSkNCoGWlRsxntwmOigDnRlO40BfutZ0CtW8aAm99lHjKD7CAlEIW2cYuUfzK5WZ0WLK470i9e8UR5JqzT9RzTuTWU1N+iYv/YxNzDIBYX1HsPizVh2XRM3fdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724900617; c=relaxed/simple;
	bh=Y5TFWF6UZ5bQXyp+AvYM1eMv+pzyDjlsxCBBIQxDZRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbIRsnJwmxKTCHlXI3RINpTwuHQm+KSfpdHz6BwUewmkwNfF4CiydbD7UJoA2qgX5ekVqkOnJdTIUm9/fU1SVIC2Bwymo1kVqo81dtvTp8OWiaxhD220sKxeD89++Jkese2gbogzi2D1odkxa44mzLNe1tPfsTb52mYrYLIQNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zV8Q8Kv0; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so96620a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724900615; x=1725505415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/z6toI6voQ0IKlbU4L2/8KMYJeJaGPdDqgqk9fjkIQ=;
        b=zV8Q8Kv0tREVC0ieTlWeVUwMPIx0Jj6eJlilhSO2ALZjaw7oDA2tJfsWPGudI1y4DB
         WVWF6mEal/8hog63XImi5GyT9c6nXbOd//00lRGA+jJVyZZbuZjNy4y9GnQrf0L4Dnc/
         hce6YvhGkVm/D9tCqB1R9AUvH6irJMDi6gvJAM500CjcONe4t03oo0OlY00nwqkGN3OB
         BpBb+VB1/dB3Rmf7O+kITD9xPRO5vnGddjYtPkNc1QxM1tvzHAZM8L/ZKDdNTJ1ZREPD
         Ajq2oxokP+SuyTC2nTBq70/1RalT3h9RV051mPOswWX6iSUUbkB+nQcuXBpnCSY3mB3E
         MvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724900615; x=1725505415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/z6toI6voQ0IKlbU4L2/8KMYJeJaGPdDqgqk9fjkIQ=;
        b=edVPt3Et3XfjLLGFdAiXn/GcO2tN0WPx4knnO57DU5gczvwIS44Y9k+diqJf1JnDVf
         N9MNv5SuPfX0L3t90uOZScHutuatxGduUKcTaikJqeilZmZz9uF9OLeFFXHZc1TDIE6P
         nxHP1T0GntVwCIBP475UhB5+1Z8TvaiCaKHszRiTNMU1A8nJw/jzufPtgAagyYyBgP0j
         Xnhf0uB8VRyPUkyksdJ0jJpIOz8ReDE5irdG8kt2wVmMTzuWwJFyEFzatXlughQp1Ghg
         3RPvhu4hZUrZ32ditAgbiZIcde4dvm/XregebKiO+faL4e5Upp6ACyD4bmAwl2XdJmRn
         wsTg==
X-Forwarded-Encrypted: i=1; AJvYcCWckpYNZij/VSrEWmCdGqqXgXmkA331H5YQtb0FPxGTKfgHQAxdjvf0R0i4G+iaAeMLcqdC3/6NHVmfl4o5@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRhK1QUey4CFMCmbMKbhD06N65iK80IvaVZTy/KHhmA39edOh
	++I+shFaKiHlHDYh6HxBPvjFW8dEdAioQZk6zNpkZfCVy4jAVV0GRoxiF2nZKXc=
X-Google-Smtp-Source: AGHT+IGsjijU+KkW6jFzBT/TWTjdXr9y3F1MJJ71ZQJHmm+Lxp/ogvEjvW4gS5LrA1D6exxUROszQg==
X-Received: by 2002:a05:6a21:10a:b0:1c3:b143:303b with SMTP id adf61e73a8af0-1cce111d93emr1276501637.54.1724900614723;
        Wed, 28 Aug 2024 20:03:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd8d6sm1780325ad.71.2024.08.28.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:03:34 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjVRb-00GS83-3A;
	Thu, 29 Aug 2024 13:03:32 +1000
Date: Thu, 29 Aug 2024 13:03:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Brian Foster <bfoster@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/6] xfs: call xfs_flush_unmap_range from
 xfs_free_file_space
Message-ID: <Zs/lA5FJoF0Zd9Ip@dread.disaster.area>
References: <20240827065123.1762168-1-hch@lst.de>
 <20240827065123.1762168-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827065123.1762168-5-hch@lst.de>

On Tue, Aug 27, 2024 at 08:50:48AM +0200, Christoph Hellwig wrote:
> Call xfs_flush_unmap_range from xfs_free_file_space so that
> xfs_file_fallocate doesn't have to predict which mode will call it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_bmap_util.c |  8 ++++++++
>  fs/xfs/xfs_file.c      | 21 ---------------------
>  2 files changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index fe2e2c93097550..187a0dbda24fc4 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -848,6 +848,14 @@ xfs_free_file_space(
>  	if (len <= 0)	/* if nothing being freed */
>  		return 0;
>  
> +	/*
> +	 * Now AIO and DIO has drained we flush and (if necessary) invalidate
> +	 * the cached range over the first operation we are about to run.
> +	 */
> +	error = xfs_flush_unmap_range(ip, offset, len);
> +	if (error)
> +		return error;
> +
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);

Ok, so if we ever change the zeroing implementation to not punch a
hole first, we're going to have to make sure we add this to whatever
new zeroing implementation we have.

Can you leave a comment in the FALLOC_FL_ZERO_RANGE implementation
code that notes it currently relies on the xfs_flush_unmap_range()
in xfs_free_file_space() for correct operation?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

