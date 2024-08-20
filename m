Return-Path: <linux-fsdevel+bounces-26332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22991957B57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 04:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE51C210FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F7C22EF0;
	Tue, 20 Aug 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vUvqvmkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192F22EF2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724119811; cv=none; b=C4wFDZ17p1aU4kuDA4wAmF04aEutsapqm/0L8YdrDTzsVoJMPSi2L+Uygz/IF5H8ehuUKKl7f7vVyq9eU/+J9letzeSJ6ZRvRiJESvzNWHFTkch/An0kp4bXypIQ9J2DeCd1REdS7Pbv6YFkVh06p+dPSUca6Ta7FE7XLXcFbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724119811; c=relaxed/simple;
	bh=aWVcWk6hwmdfngQNuqazj73yxa3QywFzLV8od+KERaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpOBlIIHww8nupwIka7hCzoCi2wfuVSj9VnhX/k0yPofNhYY47m8ZEhUJyKgc/u26tMErOvMJlaKTjvdY475AZOqj9oBR8pQp9ZwXsL6Fva+pxXxYQPf/Ux/J7HF3phIakSiCjQ93L3BKKxviojS2HqBocbMacsGBm7jxVUf5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vUvqvmkC; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724119805; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sja6If0k6r9RqqlJrsjJLBZciX8BbWmN/n6Io+3Nxzs=;
	b=vUvqvmkCqITq22FHWi342Hw6g+OaHhLMl7NUQcVwBoI1mFrFsSDui/C/Alrus3+3cGDUXKMT6Ct/zwXxsN+BBy11m6FpSwLEJMlQ5pX6gc7ViLxbM8ZzjS41I2HzznRqVx2i46DJHKbA5LbCDo1VEr3uBlDjB6COIJiOVNwu/YE=
Received: from 30.221.146.21(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDGhGAe_1724119803)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 10:10:04 +0800
Message-ID: <b17f0ab0-af46-4d0c-ab4c-44d1ee858c26@linux.alibaba.com>
Date: Tue, 20 Aug 2024 10:10:02 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback
 list
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, kernel-team@meta.com
References: <20240819182417.504672-1-joannelkoong@gmail.com>
 <20240819182417.504672-2-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240819182417.504672-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/20/24 2:24 AM, Joanne Koong wrote:
> In the case where the aux writeback list is dropped (eg the pages
> have been truncated or the connection is broken), the stats for
> its pages and backing device info need to be updated as well.
> 
> Fixes: e2653bd53a98 ("fuse: fix leaked aux requests")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 63fd5fc6872e..7ac56be5fee6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1831,10 +1831,11 @@ __acquires(fi->lock)
>  	fuse_writepage_finish(wpa);
>  	spin_unlock(&fi->lock);
>  
> -	/* After fuse_writepage_finish() aux request list is private */
> +	/* After rb_erase() aux request list is private */
>  	for (aux = wpa->next; aux; aux = next) {
>  		next = aux->next;
>  		aux->next = NULL;
> +		fuse_writepage_finish(aux);
>  		fuse_writepage_free(aux);
>  	}
>  

LGTM.

Besides, there is similar logic of decreasing stats info for replaced
aux (temp) request inside fuse_writepage_add(), though without waking up
fi->page_waitq.

I wonder if we could factor out a new helper function, saying
fuse_writepage_dec_stat(), which could be called both from
fuse_writepage_add() and fuse_send_writepage().


-- 
Thanks,
Jingbo

