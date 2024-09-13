Return-Path: <linux-fsdevel+bounces-29368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12383978BE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2024 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBFC28463A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04118E367;
	Fri, 13 Sep 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1mZg9YK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C6818BB9C;
	Fri, 13 Sep 2024 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726270851; cv=none; b=FSpLIkGWwjOrmiorsR42UjkisbXW0UplCM/J/I90MMp/rzyU7mN55317F7Ljn6897BDl3loiJB4Zu1awO5nxsrxhxxi9fz8Itoqiy2obAr6mr63KYNUZh5sK9A/pgLCzxIfHH2VAb1RbxaBehgJus/6p7a8SObzaW1aJq5VRc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726270851; c=relaxed/simple;
	bh=4wZaUaJ8H8Ng3OW6XVFKGqs5eZqlRcswTUZcQFdyhw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehEN4pYdwz5/dITO1Oe7vXK8cqW9u6YTbxRRb1abkgALW807jiS7OUk2mMbjDd0lmZSm5sGQvnQGbUNhnUb2BhNTMyo9Pl2hJDkUCMD87+HaImwKkeB22J91f9KAw7pf+4uWNfhSW1KsFR7Otau1KKhSkebk5DilVYTY9PTiJcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1mZg9YK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F78BC4CEC5;
	Fri, 13 Sep 2024 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726270851;
	bh=4wZaUaJ8H8Ng3OW6XVFKGqs5eZqlRcswTUZcQFdyhw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P1mZg9YKr9yEnnBu66byf0lBOaD7hz2bsnQ826e+yymT1acxxNlRzkVb7M2wV47NQ
	 Y9dM4mRUge97KCcAR+J0uLbQQy32YCZZr8n1kAEXCEhmn40/grylh5UoHF87buMxrs
	 ZgAsciNM/8WECaAjFzyqi5avtRR2Yczzk9HJMs54X1SHXow+/tR0lzEcuIUdI3sGmS
	 S6LcXWbJVdCVCjVztPNcAtDA5t+5wdTa3VfHQWtR42ciqlW7PRa5Hxlkmo4FNzwoLM
	 Z8VD6Leen6Q4GBZgy+Do37Wm4GfiaCWFrmmQecVW2kYoo0whJR2mv1QQQigRUWDVkV
	 SZcIv3/x2aqPQ==
Date: Fri, 13 Sep 2024 16:40:49 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] sysctl: avoid spurious permanent empty tables
Message-ID: <20240913234049.GA1539142@thelio-3990X>
References: <20240827-sysctl-const-shared-identity-v1-1-2714a798c4ff@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827-sysctl-const-shared-identity-v1-1-2714a798c4ff@weissschuh.net>

Hi Thomas,

Sorry for the delay in my response.

On Tue, Aug 27, 2024 at 11:54:43AM +0200, Thomas Weiﬂschuh wrote:
> The test if a table is a permanently empty one, inspects the address of
> the registered ctl_table argument.
> However as sysctl_mount_point is an empty array and does not occupy and
> space it can end up sharing an address with another object in memory.
> If that other object itself is a "struct ctl_table" then registering
> that table will fail as it's incorrectly recognized as permanently empty.
> 
> Avoid this issue by adding a dummy element to the array so that the
> array is not empty anymore and the potential address sharing is avoided.
> Explicitly register the table with zero elements as otherwise the dummy
> element would be recognized as a sentinel element which would lead to a
> runtime warning from the sysctl core.
> 
> While the issue seems unlikely to be encountered at this time, this
> seems mostly be due to luck.
> Also a future change, constifying sysctl_mount_point and root_table, can
> reliably trigger this issue on clang 18.
> 
> Given that empty arrays are non-standard in the first place,
> avoid them if possible.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408051453.f638857e-lkp@intel.com
> Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
> Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> This was originally part of a feature series [0], but is resubmitted on
> its own to make it into v6.11To.

It might be too late for 6.11 final since nobody seems to have picked it
up at this point but maybe it could make 6.12-rc1 and be backported in
one of the first couple of stable releases?

Regardless, thanks for sending the patch.

Acked-by: Nathan Chancellor <nathan@kernel.org>

> [0] https://lore.kernel.org/lkml/20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net/
> ---
>  fs/proc/proc_sysctl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 9553e77c9d31..d11ebc055ce0 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -29,8 +29,13 @@ static const struct inode_operations proc_sys_inode_operations;
>  static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
>  
> -/* Support for permanently empty directories */
> -static struct ctl_table sysctl_mount_point[] = { };
> +/*
> + * Support for permanently empty directories.
> + * Must be non-empty to avoid sharing an address with other tables.
> + */
> +static struct ctl_table sysctl_mount_point[] = {
> +	{ }
> +};
>  
>  /**
>   * register_sysctl_mount_point() - registers a sysctl mount point
> @@ -42,7 +47,7 @@ static struct ctl_table sysctl_mount_point[] = { };
>   */
>  struct ctl_table_header *register_sysctl_mount_point(const char *path)
>  {
> -	return register_sysctl(path, sysctl_mount_point);
> +	return register_sysctl_sz(path, sysctl_mount_point, 0);
>  }
>  EXPORT_SYMBOL(register_sysctl_mount_point);
>  
> 
> ---
> base-commit: 3e9bff3bbe1355805de919f688bef4baefbfd436
> change-id: 20240827-sysctl-const-shared-identity-9ab816e5fdfb
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

