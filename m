Return-Path: <linux-fsdevel+bounces-63271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC1BB3869
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 11:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B521C3B4100
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A3130649C;
	Thu,  2 Oct 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OihJm6Ve"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE202FE581
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399013; cv=none; b=XlkZgUZUN0MtQNkaZV8mwB246t8pNDJ2CEt2KYIz8kVgOBqNeCUTTtaKxobSbaL+Rfkq1y6iAzMzGit/c71cRpY9nc0PgBJmyr5rVYA3icFZsWkQpedc9Z0Whg/LKNh9gCBMrGwUyxZSseKIgrrp1HJyg7mhCYEM6qIqYLtYgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399013; c=relaxed/simple;
	bh=Y/Nn8qWD/ZgNQlLIKI+LcYsbn+69CosCCOT1Y+G83IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUUfWRbQY0jUXFuOLs7zErkTqZ9JTQp7WsdNtgsrawYv4pu2UQjUyaAcO+KersJE9KWWvL6n89GDzGuErkjJ5n7suhFOnXndu8wVsvjk9gHFLk00FY0VY+m0mGwl4Hw6mFVFduHZEUdf+76L/hgixXnDwPFQ9aL9BekBBvALwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OihJm6Ve; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759399000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zU/ZYJ+D2n8/dVgVgaXyjGrPm+1HugcI+uSWE2FIKfs=;
	b=OihJm6VeKmF34K0pP416dxUF9bDpM6d6J7+xyQPa9DpBsEiGI+PNgqENBxLbDDM4gf4gpdIFPrOoSik7oOCuzBnnQ0I9JmADKUB4MXFO0kqpkky8XWpbb0hfXkrjXWJNhWY4inH9U5sOkabfwWkezwUbvilZotimDSZ+ntGD7dE=
Received: from 30.180.0.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpHewx5_1759398998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 17:56:39 +0800
Message-ID: <68b155c5-65b2-4b03-a8a3-69dffc41dd1c@linux.alibaba.com>
Date: Thu, 2 Oct 2025 17:56:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: fix assertion in dax_iomap_rw()
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-fsdevel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, chao@kernel.org,
 linux-erofs@lists.ozlabs.org,
 syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com,
 Yuezhang Mo <yuezhang.mo@sony.com>
References: <20251002081311.10488-2-jack@suse.cz>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251002081311.10488-2-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2025/10/2 16:13, Jan Kara wrote:
> dax_iomap_rw() asserts that inode lock is held when reading from it. The
> assert triggers on erofs as it indeed doesn't hold any locks in this
> case - naturally because there's nothing to race against when the
> filesystem is read-only. Check the locking only if the filesystem is
> actually writeable.
> 
> Reported-by: syzbot+47680984f2d4969027ea@syzkaller.appspotmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/dax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 20ecf652c129..187f8c325744 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1752,7 +1752,7 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>   	if (iov_iter_rw(iter) == WRITE) {
>   		lockdep_assert_held_write(&iomi.inode->i_rwsem);
>   		iomi.flags |= IOMAP_WRITE;
> -	} else {
> +	} else if (!IS_RDONLY(iomi.inode)) {

Thanks, Yuezheng also wrote a similiar patch
days ago (but it seems he didn't cc more related
people),
https://lore.kernel.org/r/20250930054256.2461984-2-Yuezhang.Mo@sony.com

both patches look good to me, thanks for the fix.

Thanks,
Gao Xiang

>   		lockdep_assert_held(&iomi.inode->i_rwsem);
>   	}
>   


