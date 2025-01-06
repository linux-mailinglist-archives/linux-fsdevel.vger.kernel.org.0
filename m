Return-Path: <linux-fsdevel+bounces-38404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F8A01D27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 02:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847F43A169E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E42EB10;
	Mon,  6 Jan 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hl21yz8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E053594E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 01:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736128744; cv=none; b=U4tSGiGOoURUz2V++IxEd4WgmyJV459PHI184sdQotYyBiiMInrYHntYTlhNevbDu6nceSKtasbq2Pfnvw96EAO38Xl30s+M7it/Ggk4EAgJnFf71XcklH8R7d3ivqkR2wTVqIZ4wZRpVhH/7YHtYzBkSqLfqjA/oWiKfsNx5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736128744; c=relaxed/simple;
	bh=lstUc3XjqU2hXtSt+d7h1snoBe8xiGYexOnNeJYXWJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SFIzq2YJ8M5MZtYfSB80d6A3W60knctG/Fzzf7zSk7b9zf8lXeqQfmMy0UDRWbkzFeONW4IZvsxe9yYqqTF2drjuq99NMFujP+awEPSPBQxeizBGCl7w38+WKhbosVFh+yucd/gqRZoTWGPhALoU4k9z0xuWwNarGIuyuQ6q6Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hl21yz8J; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736128733; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pCwMJomk4tht82byOWjJJ+B/1/gr5LGEVA52SaN2De0=;
	b=Hl21yz8JHzsPLzPhNR58NbmlHhN4CLlgYYYbP+t9613Sl6onIPjKj9o4uTVxDC7ZAnuRKC/vLUFD8mTAX6oVjfuGWATXLmBKxyFJoLmlhCzd6a3gi3xWDaFYE6N+QzZftd7+5lsrZpJaQHla9ms1R7M6tyg+chAMfngB/1U/W4Y=
Received: from 30.221.147.161(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WMzguc8_1736128731 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 09:58:52 +0800
Message-ID: <b92d40c3-920e-4b19-888b-fe4121865eed@linux.alibaba.com>
Date: Mon, 6 Jan 2025 09:58:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: Set *nbytesp=0 in fuse_get_user_pages on
 allocation failure
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
 syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
References: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241203-fix-fuse_get_user_pages-v2-1-acce8a29d06b@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miklos and Christian,

I find that these two fixes for 6.13 [1]:

fuse: fix direct io folio offset and length calculation
fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation failure

are still out of v6.13-rc6 mainline, neither are they in
"linux-next/pending-fixes".  FYI in case of they got missed.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git/log/?h=for-next


On 12/3/24 7:01 AM, Bernd Schubert wrote:
> In fuse_get_user_pages(), set *nbytesp to 0 when struct page **pages
> allocation fails. This prevents the caller (fuse_direct_io) from making
> incorrect assumptions that could lead to NULL pointer dereferences
> when processing the request reply.
> 
> Previously, *nbytesp was left unmodified on allocation failure, which
> could cause issues if the caller assumed pages had been added to
> ap->descs[] when they hadn't.
> 
> Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> Changes in v2:
> - Set ret in the (!pages) condition only to avoid returning
>   ENOMEM when the while loop would not do anything
> - Remove the error check in fuse_copy_do(), that is a bit debatable.
>   I had added it to prevent kernel crashes on fuse error, but then
>   it causes 'visual clutter' (Joanne)
> - Link to v1: https://lore.kernel.org/r/20241202-fix-fuse_get_user_pages-v1-1-8b5cccaf5bbe@ddn.com
> ---
>  fs/fuse/file.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 88d0946b5bc98705e0d895bc798aa4d9df080c3c..ae74d2b7ad5be14e4d157495e7c00fcf3fc40625 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1541,8 +1541,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  	 */
>  	struct page **pages = kzalloc(max_pages * sizeof(struct page *),
>  				      GFP_KERNEL);
> -	if (!pages)
> -		return -ENOMEM;
> +	if (!pages) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	while (nbytes < *nbytesp && nr_pages < max_pages) {
>  		unsigned nfolios, i;
> @@ -1584,6 +1586,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>  	else
>  		ap->args.out_pages = true;
>  
> +out:
>  	*nbytesp = nbytes;
>  
>  	return ret < 0 ? ret : 0;
> 
> ---
> base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
> change-id: 20241202-fix-fuse_get_user_pages-6a920cb04184
> 
> Best regards,

-- 
Thanks,
Jingbo

