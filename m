Return-Path: <linux-fsdevel+bounces-12062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DE85AE6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 23:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FF31C22C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBF055E51;
	Mon, 19 Feb 2024 22:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Eo7QiUrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582356777
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381729; cv=none; b=jhGe8EUqal3B5G58v2zQGKy3iPl6WG6mBli+KqeC0cqx6vby/Nkm/hkc+eRsv9MT/SnJQ8F+Mvgs9TfSabnt8B6KSmLFV3PlQHO0QCjlnc9yTHq8CMcGv2OZ2zD58NvAayGvirloNQ/kfra/eXGvxlJd42Fw7MAJNrsvkY3QOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381729; c=relaxed/simple;
	bh=69e7kVPN/Z3SH6Is7oQo68JrXDtUBF6qZahWkHqh+7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GofWtn3vXoJl10k44SRcPGRrG7jdhDsycAdSpEO1l1cZDv8gEhQsV2A5xtQa/Firh2CKfeqLwT3ze4UZiipIndUaWYgpZYPL3OGsfoqhKzRE+TaImsXJ1TsOFlgjsh51lnHDsk3VHwaa2maaXah/IoKWHUb7Lfw7m5GnB8ekdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Eo7QiUrE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0e5b223eso5394955ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708381727; x=1708986527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl5GKAX3dlaK9635suuwAaWFkidsg1LZ0Wt1MsG+2JM=;
        b=Eo7QiUrEwSYhaJWG5CYDmFY8qzWsm8HqNf9yftgk3QxW7yhgamkJs0idwtYvIx2F4O
         RSOHv9L+OIE2wJEeSF1rigqXbk9hg26ShWyJy4wXxqoyqnW1hYErH8tKBOhW85cBAtqW
         MKFQYzLu3nmEGiRgrTcx+goUEHIhkQ1MiE2xeSvteU63Z9a3j9MK7t46PjSPGtikCEef
         M18272AscOXxeMR1FrTPTLX2ZO4UboMWFDlV7dUO3WFzZib63zx1h9JG2A6awBSLG4Ok
         HvcOo/+HZh+c+XuZwVtVvlntWST77EN1XK8Pu9qevk9diZBjLj79Z8yGt18BkPepP3ii
         aHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708381727; x=1708986527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bl5GKAX3dlaK9635suuwAaWFkidsg1LZ0Wt1MsG+2JM=;
        b=bHyyxlppMbLG25JS7Fn6c4EEn+9Aqh88KYHIZMNEPOGSvCQv36BFuglxtzTP99Tz80
         urP0w6yoncYqdQyvVdSqZdgY7I6juWzNnyXMcGdD8pECQhE7+tLUw1VeiGNYbWyOZGXW
         kxYDHu/GSuzBQGs0SwUWq4svLn0vWGbxY/WolpngAbEhP9ZVX9s76IelbPlsgVRLm+n+
         r0DWz9YRCIwRV0VP/loADQ5Q6R/CSL4bh3PyWeWTI/k1Pveoaoyg2e5b7YoiDh38HDId
         tUm9n5It/wlhVjl7RVSln2V4EAHENpKdWTP6AAolWH5mTXjLUcHyOuDQV27/vHW5cZuh
         vOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsTI4pKnAzhbBqHKw36AeCIymY1kbyIliMY2dZq4K2VkdbjZX3/AKifLjaUjKt+LuNYyB9R7g+V/SGUCI2gbwNja8rMZY9QozjXatnMQ==
X-Gm-Message-State: AOJu0YwCT0/yw+kDANYmtj8qyjMa6C62bAhmJT2kyN4cuowxUeW0eAkJ
	wXjvnfLTNWtbml4tFoEWhCYmAfpmMI+ai/Fg+pM7iDMIFblaVXQd+q6OTmlT52Y=
X-Google-Smtp-Source: AGHT+IHlEqzTbeqGZugXvJDuwYCJATCsRA1NiGwC9reCuuiCgxtV1VeURbikH3d/YTo82RrU7aljog==
X-Received: by 2002:a17:902:cecf:b0:1db:d66e:cd15 with SMTP id d15-20020a170902cecf00b001dbd66ecd15mr6464817plg.59.1708381727050;
        Mon, 19 Feb 2024 14:28:47 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902d04400b001d949e663d5sm4933240pll.31.2024.02.19.14.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 14:28:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rcC7v-008o4I-26;
	Tue, 20 Feb 2024 09:28:43 +1100
Date: Tue, 20 Feb 2024 09:28:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 04/11] fs: Add initial atomic write support info to
 statx
Message-ID: <ZdPWGwntYMvstbpc@dread.disaster.area>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-5-john.g.garry@oracle.com>

On Mon, Feb 19, 2024 at 01:01:02PM +0000, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support for a file.
> 
> Helper function generic_fill_statx_atomic_writes() can be used by FSes to
> fill in the relevant statx fields.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> #jpg: relocate bdev support to another patch
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/stat.c                 | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/fs.h        |  3 +++
>  include/linux/stat.h      |  3 +++
>  include/uapi/linux/stat.h |  9 ++++++++-
>  4 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 77cdc69eb422..522787a4ab6a 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -89,6 +89,37 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
>  }
>  EXPORT_SYMBOL(generic_fill_statx_attr);
>  
> +/**
> + * generic_fill_statx_atomic_writes - Fill in the atomic writes statx attributes
> + * @stat:	Where to fill in the attribute flags
> + * @unit_min:	Minimum supported atomic write length
> + * @unit_max:	Maximum supported atomic write length
> + *
> + * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
> + * atomic write unit_min and unit_max values.
> + */
> +void generic_fill_statx_atomic_writes(struct kstat *stat,
> +				      unsigned int unit_min,
> +				      unsigned int unit_max)
> +{
> +	/* Confirm that the request type is known */
> +	stat->result_mask |= STATX_WRITE_ATOMIC;
> +
> +	/* Confirm that the file attribute type is known */
> +	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
> +
> +	if (unit_min) {
> +		stat->atomic_write_unit_min = unit_min;
> +		stat->atomic_write_unit_max = unit_max;
> +		/* Initially only allow 1x segment */
> +		stat->atomic_write_segments_max = 1;
> +
> +		/* Confirm atomic writes are actually supported */
> +		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
> +	}
> +}
> +EXPORT_SYMBOL(generic_fill_statx_atomic_writes);

What units are these in? Nothing in the patch or commit description
tells us....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

