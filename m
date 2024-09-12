Return-Path: <linux-fsdevel+bounces-29173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE89769DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672B7285603
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B731A4E8A;
	Thu, 12 Sep 2024 13:01:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC11D52B;
	Thu, 12 Sep 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146115; cv=none; b=FOsR8ssRH/bvnA6zEdBfwN57PfFSZ2SvVF3DtywI/yXwlb9nHleRbFRB2YDkf7Lo9shScvFAF5IQLgmRuXctjorHXaAc6PJrTVZv0cQjPeYRwjzPDpFqhUcvgORHfKyNetzVWko3wYFDQzcu3IKxcghpXbPsqPINIyvK1/w7mkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146115; c=relaxed/simple;
	bh=kH79LqiIuTLWjSww/u+3I1mSIoVtmHevHvgBlcg3G7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fkpf9q68iIRoW3HWnfbdyyXEMiAdI+g4W1B8d3iGUGLpsGIaDdtR4aNbMaR6ttvblXUfCc/HEWvcM9ytDf3+fiiBdAi1TcHczeERT3RRiMFt0r468yUbZOZKjRl9tMNQtXaCFDc8cMc37Yc67/q/APeByUjSLRFi31kBHB06aJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 944E4227AB6; Thu, 12 Sep 2024 15:01:46 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:01:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com,
	vishak.g@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Message-ID: <20240912130146.GA28535@lst.de>
References: <20240910150200.6589-1-joshi.k@samsung.com> <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com> <20240910150200.6589-4-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 10, 2024 at 08:31:58PM +0530, Kanchan Joshi wrote:
> This is similar to existing F_{SET/GET}_RW_HINT but more
> generic/extensible.
> 
> F_SET/GET_RW_HINT_EX take a pointer to a struct rw_hint_ex as argument:
> 
> struct rw_hint_ex {
>         __u8    type;
>         __u8    pad[7];
>         __u64   val;
> };
> 
> With F_SET_RW_HINT_EX, the user passes the hint type and its value.
> Hint type can be either lifetime hint (TYPE_RW_LIFETIME_HINT) or
> placement hint (TYPE_RW_PLACEMENT_HINT). The interface allows to add
> more hint add more hint types in future.

What is the point of multiplexing these into a single call vs having
one fcntl for each?  It's not like the code points are a super
limited resource.

And the _EX name isn't exactly descriptive either and screams of horrible
Windows APIs :)

> +	WRITE_ONCE(inode->i_write_hint, hint);
> +	if (file->f_mapping->host != inode)
> +		WRITE_ONCE(file->f_mapping->host->i_write_hint, hint);

This doesn't work.  You need a file system method for this so that
the file system can intercept it, instead of storing it in completely
arbitrary inodes without any kind of checking for support or intercetion
point.

> --- a/include/linux/rw_hint.h
> +++ b/include/linux/rw_hint.h
> @@ -21,4 +21,17 @@ enum rw_lifetime_hint {
>  static_assert(sizeof(enum rw_lifetime_hint) == 1);
>  #endif
>  
> +#define WRITE_HINT_TYPE_BIT	BIT(7)
> +#define WRITE_HINT_VAL_MASK	(WRITE_HINT_TYPE_BIT - 1)
> +#define WRITE_HINT_TYPE(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				TYPE_RW_PLACEMENT_HINT : TYPE_RW_LIFETIME_HINT)
> +#define WRITE_HINT_VAL(h)	((h) & WRITE_HINT_VAL_MASK)
> +
> +#define WRITE_PLACEMENT_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 WRITE_HINT_VAL(h) : 0)
> +#define WRITE_LIFETIME_HINT(h)	(((h) & WRITE_HINT_TYPE_BIT) ? \
> +				 0 : WRITE_HINT_VAL(h))
> +
> +#define PLACEMENT_HINT_TYPE	WRITE_HINT_TYPE_BIT
> +#define MAX_PLACEMENT_HINT_VAL	(WRITE_HINT_VAL_MASK - 1)

That's a whole lot of undocumented macros.  Please turn these into proper
inline functions and write documentation for them.


