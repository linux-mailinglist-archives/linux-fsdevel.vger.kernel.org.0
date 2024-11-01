Return-Path: <linux-fsdevel+bounces-33440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FEE9B8BD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7095282B72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B4155757;
	Fri,  1 Nov 2024 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMRI8Rsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B814F9F8;
	Fri,  1 Nov 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445131; cv=none; b=Ur7pbVeUarOyDPaai415GHKlfMAfQJmmwwjtDXHIGA5ANZe+mY1kTrPJsewZwrhDtuHM4YiGQI4gDj6fRrvEa0fOM9QVymqIRX+SZ0W0NvD/8nM26eZaJBfgp7GW1FdhhIte2m+VafkxN5zQRh0oPB+p12MrtDFN9LMIWgSeyAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445131; c=relaxed/simple;
	bh=a/tbdQUSfOoajn7Fe/W07LDP68zjdcZFeLkrzJjOTSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDD0KNbfM9h6XTyROeICduJVO8awBOgQjYqKxa0XufbebSSuFNbZU3tIOROElNanVVjXA3BJL4aqTJxrv48/JqsuG/JxpTM9GyHR9GKHhLstLEdsui3KV+3LXHjfVlrd94RkalZKu/gn4dmZl7oGcr1pXFCblcbZ+J7/tc90JO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMRI8Rsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2D4C4CECD;
	Fri,  1 Nov 2024 07:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730445131;
	bh=a/tbdQUSfOoajn7Fe/W07LDP68zjdcZFeLkrzJjOTSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMRI8Rsg+7PnP3Yfh2jP13/tA5tkLnaNc4hAxMh2dJg3XlZ8HAag1BkAACTBvQ+0T
	 Gc21GvomD8lpt0UgG/+NzfnFqZrNGAR2HhVamFTzZJ+or93fnqSfjP0TGE5iH6ROvm
	 x9CnDTTVXgAc/lltzVyf77oom6FLrunoF6C3cffmUqXV3dFlXCFPvHN5rJbByNkquc
	 eksrK7KoR46wxleJ9G6QAoOca1pwGbOBqm8LZbr8iQYel7SZtQtO+qBeQuWu30elOB
	 VEmAytygiy2QX2nSB0V5BJzdsz+HcQJcKH7PiQMY892vzFlcCab/jyvEH6/KUVNCXP
	 4bxMR/0Y4PgJg==
Date: Fri, 1 Nov 2024 00:12:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 2/3] tmpfs: Fix type for sysfs' casefold attribute
Message-ID: <20241101071208.GA2962282@thelio-3990X>
References: <20241101013741.295792-1-andrealmeid@igalia.com>
 <20241101013741.295792-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101013741.295792-3-andrealmeid@igalia.com>

On Thu, Oct 31, 2024 at 10:37:40PM -0300, André Almeida wrote:
> DEVICE_STRING_ATTR_RO should be only used by device drivers since it
> relies on `struct device` to use device_show_string() function. Using
> this with non device code led to a kCFI violation:
> 
> > cat /sys/fs/tmpfs/features/casefold
> [   70.558496] CFI failure at kobj_attr_show+0x2c/0x4c (target: device_show_string+0x0/0x38; expected type: 0xc527b809)
> 
> Like the other filesystems, fix this by manually declaring the attribute
> using kobj_attribute() and writing a proper show() function.
> 
> Also, leave macros for anyone that need to expand tmpfs sysfs' with
> more attributes (as seen in fs/btrfs/sysfs.c).
> 
> Fixes: 5132f08bd332 ("tmpfs: Expose filesystem features via sysfs")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/lkml/20241031051822.GA2947788@thelio-3990X/
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  mm/shmem.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b86f526a1cb1..6038e1d11987 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -5548,13 +5548,38 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
>  
>  #if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
> +
> +#define __INIT_KOBJ_ATTR(_name, _mode, _show, _store)			\
> +{									\
> +	.attr	= { .name = __stringify(_name), .mode = _mode },	\
> +	.show	= _show,						\
> +	.store	= _store,						\
> +}
> +
> +#define TMPFS_ATTR_W(_name, _store)				\
> +	static struct kobj_attribute tmpfs_attr_##_name =	\
> +			__INIT_KOBJ_ATTR(_name, 0200, NULL, _store)
> +
> +#define TMPFS_ATTR_RW(_name, _show, _store)			\
> +	static struct kobj_attribute tmpfs_attr_##_name =	\
> +			__INIT_KOBJ_ATTR(_name, 0644, _show, _store)
> +
> +#define TMPFS_ATTR_RO(_name, _show)				\
> +	static struct kobj_attribute tmpfs_attr_##_name =	\
> +			__INIT_KOBJ_ATTR(_name, 0444, _show, NULL)
> +
>  #if IS_ENABLED(CONFIG_UNICODE)
> -static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
> +static ssize_t casefold_show(struct kobject *kobj, struct kobj_attribute *a,
> +			char *buf)
> +{
> +		return sysfs_emit(buf, "supported\n");

Small nit, I think this might be overindented?

> +}
> +TMPFS_ATTR_RO(casefold, casefold_show);
>  #endif
>  
>  static struct attribute *tmpfs_attributes[] = {
>  #if IS_ENABLED(CONFIG_UNICODE)
> -	&dev_attr_casefold.attr.attr,
> +	&tmpfs_attr_casefold.attr,
>  #endif
>  	NULL
>  };
> -- 
> 2.47.0
> 

