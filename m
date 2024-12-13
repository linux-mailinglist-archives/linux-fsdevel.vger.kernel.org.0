Return-Path: <linux-fsdevel+bounces-37256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1BC9F0272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 02:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE82859BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F53FB0E;
	Fri, 13 Dec 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="woD9qGFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141127715
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054712; cv=none; b=drpBSCP87Me9Id8bHUSt6okyHiqIrs0lN9fer6qKrbwRWqQco6+tRqQT6NhmcJTlKHMFwXYMxwdYkCkLablBpIqZqmYRzPiOGligq55gI2CTWK/3XdqlN5w29zWKNpgJPDRsHF0EjZS62oJeTIC5xZTHMByxek3VvQTXVyPxkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054712; c=relaxed/simple;
	bh=NfFMIPTvI3yPp9IjwghGupYmvw9jGZQKgyaSaf7xEa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqHMS6KPg557fik1JrVocVmrTxv7+zr/Th5LodanAFyJeaMcyfJTeFvCVlxYYHXkub0WwluXM3xv3RQnGntPcLY6uqesgIN6R+OA04lj7cuF8kikvHKjs8QzJYMrJJBhMFXpb1p7k4TYiDhyuMzfLqQkW9kMMNfuFT52HkRVRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=woD9qGFp; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734054700; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3yLk2L2fs9qlY3yZztUx5KVTRRfTdL+BBfgrYkcEsx8=;
	b=woD9qGFpiOCfCfW4dW/j1zwx0pwvyCHgQvUbTcHDQmqD/peZolSgFmamjyX33g4MR99MKvk3L90EpQ8nVvL43Rb6V2a2pXlrqdtzUt+Jj9WdJp0oHtupiMjkXtH/HFikwAHWUZI+gt1JTHTiQJUznWQyGcUSXiV2Lppe3IjZe5Q=
Received: from 30.221.145.11(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLNFBl-_1734054699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 09:51:39 +0800
Message-ID: <d0a982f7-3b85-4ce4-a29f-a9adbc969357@linux.alibaba.com>
Date: Fri, 13 Dec 2024 09:51:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fuse: Allocate only namelen buf memory in
 fuse_notify_
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
 <20241212-fuse_name_max-limit-6-13-v1-1-92be52f01eca@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241212-fuse_name_max-limit-6-13-v1-1-92be52f01eca@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 5:50 AM, Bernd Schubert wrote:
> fuse_notify_inval_entry and fuse_notify_delete were using fixed allocations
> of FUSE_NAME_MAX to hold the file name. Often that large buffers are not
> needed as file names might be smaller, so this uses the actual file name
> size to do the allocation.
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/fuse/dev.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 27ccae63495d14ea339aa6c8da63d0ac44fc8885..c979ce93685f8338301a094ac513c607f44ba572 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1525,14 +1525,10 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
>  				   struct fuse_copy_state *cs)
>  {
>  	struct fuse_notify_inval_entry_out outarg;
> -	int err = -ENOMEM;
> -	char *buf;
> +	int err;
> +	char *buf = NULL;
>  	struct qstr name;
>  
> -	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
> -	if (!buf)
> -		goto err;
> -
>  	err = -EINVAL;
>  	if (size < sizeof(outarg))
>  		goto err;
> @@ -1549,6 +1545,11 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
>  	if (size != sizeof(outarg) + outarg.namelen + 1)
>  		goto err;
>  
> +	err = -ENOMEM;
> +	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
> +	if (!buf)
> +		goto err;
> +
>  	name.name = buf;
>  	name.len = outarg.namelen;
>  	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
> @@ -1573,14 +1574,10 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
>  			      struct fuse_copy_state *cs)
>  {
>  	struct fuse_notify_delete_out outarg;
> -	int err = -ENOMEM;
> -	char *buf;
> +	int err;
> +	char *buf = NULL;
>  	struct qstr name;
>  
> -	buf = kzalloc(FUSE_NAME_MAX + 1, GFP_KERNEL);
> -	if (!buf)
> -		goto err;
> -
>  	err = -EINVAL;
>  	if (size < sizeof(outarg))
>  		goto err;
> @@ -1597,6 +1594,11 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
>  	if (size != sizeof(outarg) + outarg.namelen + 1)
>  		goto err;
>  
> +	err = -ENOMEM;
> +	buf = kzalloc(outarg.namelen + 1, GFP_KERNEL);
> +	if (!buf)
> +		goto err;
> +
>  	name.name = buf;
>  	name.len = outarg.namelen;
>  	err = fuse_copy_one(cs, buf, outarg.namelen + 1);
> 

-- 
Thanks,
Jingbo

