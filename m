Return-Path: <linux-fsdevel+bounces-8434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCA58364B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710F11C23295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820643D0D2;
	Mon, 22 Jan 2024 13:48:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2733D0B4;
	Mon, 22 Jan 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931312; cv=none; b=UVMW1ky+tQamkKonBbunBGw1nVRvKqG0wxmdkbCqtlRJOQgyrHxZlbnBENLhgtbVjCS9hvmVm58g6hHYSE2p+6CpCBsbcLQPu96v0EFV0HdZb7fChqJN1Jv64HDQqs2snxZTi1FwmmTL4Se0Gsche4/fEshjSZ1ej9m1dbL4kxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931312; c=relaxed/simple;
	bh=BquSct0x/3PHrMNBVC2M3NsXYQeqttQn96LV68l/gxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5wbwGUkLWqM8ZeBSLjYZ20kQtg4whTQDqGdElmajjA4VvHYI0xM/vG86SM1Ql3SRWrAaNacrifZ5VFcN0p3w8jAOdA549vhHWPN5Gt2QZTm2j88E0k1J/i0Bse9VcElw3QlcXoQLjw2kQc1n3yz+/SZbC2FdpRONqhnpE14bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W.9eXi4_1705931303;
Received: from 30.221.145.129(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.9eXi4_1705931303)
          by smtp.aliyun-inc.com;
          Mon, 22 Jan 2024 21:48:24 +0800
Message-ID: <7790423f-665e-44cc-b4ae-d3f3d2996af5@linux.alibaba.com>
Date: Mon, 22 Jan 2024 21:48:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] cachefiles, erofs: Fix NULL deref in when
 cachefiles is not doing ondemand-mode
Content-Language: en-US
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>
Cc: Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122123845.3822570-7-dhowells@redhat.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240122123845.3822570-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/24 8:38 PM, David Howells wrote:
> cachefiles_ondemand_init_object() as called from cachefiles_open_file() and
> cachefiles_create_tmpfile() does not check if object->ondemand is set
> before dereferencing it, leading to an oops something like:
> 
> 	RIP: 0010:cachefiles_ondemand_init_object+0x9/0x41
> 	...
> 	Call Trace:
> 	 <TASK>
> 	 cachefiles_open_file+0xc9/0x187
> 	 cachefiles_lookup_cookie+0x122/0x2be
> 	 fscache_cookie_state_machine+0xbe/0x32b
> 	 fscache_cookie_worker+0x1f/0x2d
> 	 process_one_work+0x136/0x208
> 	 process_scheduled_works+0x3a/0x41
> 	 worker_thread+0x1a2/0x1f6
> 	 kthread+0xca/0xd2
> 	 ret_from_fork+0x21/0x33
> 
> Fix this by making the calls to cachefiles_ondemand_init_object()
> conditional.
> 
> Fixes: 3c5ecfe16e76 ("cachefiles: extract ondemand info field from cachefiles_object")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: Yue Hu <huyue2@coolpad.com>
> cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> cc: linux-erofs@lists.ozlabs.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 7ade836beb58..180594d24c44 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -473,9 +473,11 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
>  	if (!cachefiles_mark_inode_in_use(object, file_inode(file)))
>  		WARN_ON(1);
>  
> -	ret = cachefiles_ondemand_init_object(object);
> -	if (ret < 0)
> -		goto err_unuse;
> +	if (object->ondemand) {
> +		ret = cachefiles_ondemand_init_object(object);
> +		if (ret < 0)
> +			goto err_unuse;
> +	}

I'm not sure if object->ondemand shall be checked by the caller or
inside cachefiles_ondemand_init_object(), as
cachefiles_ondemand_clean_object() is also called without checking
object->ondemand. cachefiles_ondemand_clean_object() won't trigger the
NULL oops as the called cachefiles_ondemand_send_req() will actually
checks that.

Anyway this patch looks good to me.  Thanks.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

>  
>  	ni_size = object->cookie->object_size;
>  	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
> @@ -579,9 +581,11 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
>  	}
>  	_debug("file -> %pd positive", dentry);
>  
> -	ret = cachefiles_ondemand_init_object(object);
> -	if (ret < 0)
> -		goto error_fput;
> +	if (object->ondemand) {
> +		ret = cachefiles_ondemand_init_object(object);
> +		if (ret < 0)
> +			goto error_fput;
> +	}
>  
>  	ret = cachefiles_check_auxdata(object, file);
>  	if (ret < 0)

-- 
Thanks,
Jingbo

