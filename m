Return-Path: <linux-fsdevel+bounces-27043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBF95DF6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEAE1F21C5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A7D7DA82;
	Sat, 24 Aug 2024 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mo1fjLQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D705B5D6;
	Sat, 24 Aug 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522716; cv=none; b=OZFPYy1Nfm2NM4ZOS4J8YbukaONTnSj5J7uZDSer5AfcLQjPMyjHTiRdgHi0EYqSEePVU27gMUsB/WrhVXwpWn1pa3VE3223q20UgEaHmdiSfJ6nswoOfzL5tDr4aNAfTE1zy8GZfl5nIjphq/asRi8ozfDRFAPWJdlbn6cxVHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522716; c=relaxed/simple;
	bh=3555bKMnNEKgCGvyYxyDocSSkZ7vDR6VBb9ZKzp7r+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw9XDIxRjFS0SpH6zN4asLDWz2v4jVjljxfMpUjXuIEcIcTHB2x8AA7hq7pwZ9/P990gdUJZRb4MfBrTVPUchvplP1WAYkvdyM5C+ppCAXVrpCwQ2i/7iUlOjUMtke8ED5JoMqBoPzKN43Z/o2PhMrD0OtNL+7o2Ev0OoxA5Pgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Mo1fjLQz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724522708;
	bh=3555bKMnNEKgCGvyYxyDocSSkZ7vDR6VBb9ZKzp7r+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mo1fjLQzCq2GtY3v0uJPzV74fiuuHF6yh+H6VQ57NIHhzEwg8PnCX2qyMBN+XFqUV
	 /RwWg2wiSzmY6Vs/bcY1Q8g0FJhCl3qZdAq9JuS/RG5lsbsH8uKhOwTN12gUOaHAG0
	 0XXyPZcmzBMMs2MoakLLYgwH7RK6lv7YZr0kKUQE=
Date: Sat, 24 Aug 2024 20:05:08 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sysctl: avoid spurious permanent empty tables
Message-ID: <ef0dd949-e8a3-4b61-9d2d-3593b139cc4f@t-8ch.de>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
 <20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805-sysctl-const-api-v2-1-52c85f02ee5e@weissschuh.net>

Hi Joel,

On 2024-08-05 11:39:35+0000, Thomas Weißschuh wrote:
> The test if a table is a permanently empty one, inspects the address of
> the registered ctl_table argument.
> However as sysctl_mount_point is an empty array and does not occupy and
> space it can end up sharing an address with another object in memory.
> If that other object itself is a "struct ctl_table" then registering
> that table will fail as it's incorrectly recognized as permanently empty.
> 
> Avoid this issue by adding a dummy element to the array so that is not
> empty anymore.
> Explicitly register the table with zero elements as otherwise the dummy
> element would be recognized as a sentinel element which would lead to a
> runtime warning from the sysctl core.
> 
> While the issue seems not being encountered at this time, this seems
> mostly to be due to luck.
> Also a future change, constifying sysctl_mount_point and root_table, can
> reliably trigger this issue on clang 18.
> 
> Given that empty arrays are non-standard in the first place it seems
> prudent to avoid them if possible.
> 
> Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
> Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Any updates on this?
I fear it can theoretically also happen on v6.11.

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
> -- 
> 2.46.0
> 

