Return-Path: <linux-fsdevel+bounces-18792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2D8BC612
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 05:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D201C20FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 03:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473541A88;
	Mon,  6 May 2024 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bgaxpav/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F56358A7;
	Mon,  6 May 2024 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964954; cv=none; b=ZS+BNAgtr6X+GKA/OI8zjPJWR080r3Qn8m4dvSWNLOyPalJNmGc9kb+DH1+Y9X0aP1yuJwsO1Gr7wRKuX9Gbk27LkUc154oavnsqJN/ho2vJa+AO+6lyOPSZ/N1fQCc5m4dqTVl6qy+BT8tB4PLD1CjArtMDtZunZGc+Hq6kYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964954; c=relaxed/simple;
	bh=S/Ajd4gIOZDBgz/1XvoiLuSZ7ZD3B1/wz2XJi1Un59Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3xoYNRjxekiTXi0N+7QYDxHF69zDGCJPBwx5pWQKpWu4dKq35+hMSPGbXjZW1X3rPLfBHl06xpz+FI06vLfIcKWfwjcEfp5GU0wdSqukeEm2K3DrgdTCHPeNkho3hamrJr5tcARIsew7pabTbe3CHliWmwdwavp63NwhWAU3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bgaxpav/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714964950; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JRlGN2mptAj2Ko2vwpIZlWC6irfwwV0f+NG6BmfBNHY=;
	b=bgaxpav/wihm7Q+DiZbibH3iZqW2kjycp6gQ/BBD6iLWEdIntHgo502lqiIO+3MOmIM+vcrMB/MqMFItlLdItMDwYeGLQrPdzuACng7Dl5pWwKA1HRjQ5nsIZhaLt8JFRgWlz6WbIPo1TAP62MbTsa2sPov+K6zRZYSHyr+CC/8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W5rA8vh_1714964947;
Received: from 30.221.146.217(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W5rA8vh_1714964947)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 11:09:09 +0800
Message-ID: <625acc9e-b871-4912-965e-82fe3f9228d7@linux.alibaba.com>
Date: Mon, 6 May 2024 11:09:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] cachefiles: never get a new anon fd if ondemand_id
 is valid
To: libaokun@huaweicloud.com, netfs@lists.linux.dev
Cc: dhowells@redhat.com, jlayton@kernel.org, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
References: <20240424033916.2748488-1-libaokun@huaweicloud.com>
 <20240424033916.2748488-9-libaokun@huaweicloud.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240424033916.2748488-9-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/24 11:39 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Now every time the daemon reads an open request, it requests a new anon fd
> and ondemand_id. With the introduction of "restore", it is possible to read
> the same open request more than once, and therefore have multiple anon fd's
> for the same object.
> 
> To avoid this, allocate a new anon fd only if no anon fd has been allocated
> (ondemand_id == 0) or if the previously allocated anon fd has been closed
> (ondemand_id == -1). Returns an error if ondemand_id is valid, letting the
> daemon know that the current userland restore logic is abnormal and needs
> to be checked.

I have no obvious preference on strengthening this on kernel side or
not.  Could you explain more about what will happen if the daemon gets
several distinct anon fd corresponding to one same object?  IMHO the
daemon should expect the side effect if it issues a 'restore' command
when the daemon doesn't crash.  IOW, it's something that shall be fixed
or managed either on the kernel side, or on the daemon side.

> ---
>  fs/cachefiles/ondemand.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index b5e6a851ef04..0cf63bfedc9e 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -14,11 +14,18 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
>  					  struct file *file)
>  {
>  	struct cachefiles_object *object = file->private_data;
> -	struct cachefiles_cache *cache = object->volume->cache;
> -	struct cachefiles_ondemand_info *info = object->ondemand;
> +	struct cachefiles_cache *cache;
> +	struct cachefiles_ondemand_info *info;
>  	int object_id;
>  	struct cachefiles_req *req;
> -	XA_STATE(xas, &cache->reqs, 0);
> +	XA_STATE(xas, NULL, 0);
> +
> +	if (!object)
> +		return 0;
> +
> +	info = object->ondemand;
> +	cache = object->volume->cache;
> +	xas.xa = &cache->reqs;
>  
>  	xa_lock(&cache->reqs);
>  	spin_lock(&info->lock);
> @@ -269,22 +276,39 @@ static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  		goto err_put_fd;
>  	}
>  
> +	spin_lock(&object->ondemand->lock);
> +	if (object->ondemand->ondemand_id > 0) {
> +		spin_unlock(&object->ondemand->lock);
> +		ret = -EEXIST;
> +		/* Avoid performing cachefiles_ondemand_fd_release(). */
> +		file->private_data = NULL;
> +		goto err_put_file;
> +	}
> +
>  	file->f_mode |= FMODE_PWRITE | FMODE_LSEEK;
>  	fd_install(fd, file);
>  
>  	load = (void *)req->msg.data;
>  	load->fd = fd;
>  	object->ondemand->ondemand_id = object_id;
> +	spin_unlock(&object->ondemand->lock);
>  
>  	cachefiles_get_unbind_pincount(cache);
>  	trace_cachefiles_ondemand_open(object, &req->msg, load);
>  	return 0;
>  
> +err_put_file:
> +	fput(file);
>  err_put_fd:
>  	put_unused_fd(fd);
>  err_free_id:
>  	xa_erase(&cache->ondemand_ids, object_id);
>  err:
> +	spin_lock(&object->ondemand->lock);
> +	/* Avoid marking an opened object as closed. */
> +	if (object->ondemand->ondemand_id <= 0)
> +		cachefiles_ondemand_set_object_close(object);
> +	spin_unlock(&object->ondemand->lock);
>  	cachefiles_put_object(object, cachefiles_obj_put_ondemand_fd);
>  	return ret;
>  }
> @@ -367,10 +391,8 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  
>  	if (msg->opcode == CACHEFILES_OP_OPEN) {
>  		ret = cachefiles_ondemand_get_fd(req);
> -		if (ret) {
> -			cachefiles_ondemand_set_object_close(req->object);
> +		if (ret)
>  			goto out;
> -		}
>  	}
>  
>  	msg->msg_id = xas.xa_index;

-- 
Thanks,
Jingbo

