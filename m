Return-Path: <linux-fsdevel+bounces-63193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D1BB11DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 17:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964101C10DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FDB18CBE1;
	Wed,  1 Oct 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgnMXPct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C92628D;
	Wed,  1 Oct 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333174; cv=none; b=hy/bH+TLsA7cuy70e/AgMQDsg8kZNDjM6rT5QSvcEbqhrs+RJe47o/HtmrAwN2melS83zGKkG8tYnddCsF1cPpdECVLn4dHz2+qh54wxsONUZ3NwX7lVMXlMcU3j19+SQh3fkaK1RLyRPUYOwsHZxHxd1k6QFbR0qwdnMUfjoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333174; c=relaxed/simple;
	bh=WtEVlB/YEbSlFvYtNBcdguT+bm4fsIj2BYpq1A7Iniw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQIvgTk3s9B9IfMmF54MKfM477mSyzI2BOU84eeFixNf2NhYuw4nsd9yl5JOe/+ob3d4p9UPP/0l6vCOsB3NnvHHRXZnWkvfrJ5tzBbxYhH4R2Y2ryokE5tAaI2VIQnAa/N5CTUG2L3ex20JSzh6q2iS7VtgFZPnzleZZpxqy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgnMXPct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C530C4CEF5;
	Wed,  1 Oct 2025 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333173;
	bh=WtEVlB/YEbSlFvYtNBcdguT+bm4fsIj2BYpq1A7Iniw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XgnMXPctSvRuwYy/18hRVob5/ZdSKRwjcttZoPJW9cvfReYnVs79jLDqVP9p3UlUp
	 lgCO02MmMfh8AbPYGs1FFj5Wez195JQWlCDMlsq3nDR9k4CrCgd3gyVf5mK+VAnWWr
	 piJ5zMQSkHv8zmJKBBMBk44Bkg4ZDdTxK/H3befI6YE0ZPDu+GYeXOjwEN7/JeuRON
	 bM3IF8JBEjFWdzAIirezKoDlCWJ5XQzzhJrAEIBG4PmTffoxfkmKVlkdexk9feEiJ2
	 XX//65JSYAdjxaOMRs31yBiKgQFk6+2dd0YWgt8uw9VbiZbIeYUwUtZXkLK3+34XI2
	 p3tr0APudIlNg==
Date: Wed, 1 Oct 2025 15:39:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	oe-lkp@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
Message-ID: <aN1LM3C3Dc1TrQTq@google.com>
References: <202509301450.138b448f-lkp@intel.com>
 <20250930232957.14361-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>

On 10/01, Mateusz Guzik wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2619cbbd7d2d..26ec31eb8c80 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
>  			sb_end_intwrite(inode->i_sb);
>  
>  			spin_lock(&inode->i_lock);
> -			iput(inode);
> +			atomic_dec(&inode->i_count);

It seems this was applied by Josef [1], added in 6.18-rc1. Let me apply this fix
after my f2fs pull request, since I don't have this issue in my -next tree yet.

[1] https://lore.kernel.org/all/b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com/

>  		}
>  		trace_f2fs_drop_inode(inode, 0);
>  		return 0;
> -- 
> 2.43.0
> 

