Return-Path: <linux-fsdevel+bounces-8502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2348381D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 03:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F35B1C27219
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11A537EF;
	Tue, 23 Jan 2024 01:33:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627851008;
	Tue, 23 Jan 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705973584; cv=none; b=OonXxavJZK8YQdbffwlHNnxvdzL26BqSEIFft7HEG4OvaI3h65icbsgo0K5ciL3unC+R+aLZbubTrGPnpk0rHjucVIJHjgjQ6dQAxsj+W/Ke7L49X94U8DtdlTACTd8BldGnpIiOOXjep561916l2YNTAtJNsUREsopXBPAV+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705973584; c=relaxed/simple;
	bh=2JHya8zw5vfik3Fy0mpAMmr+pW0n5iF6d2DFfFJs8JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWVdfws+UeIh541YKZExU8P4Y+EWiIWSNzwC9uwolsuNkhWkuw7A7ptjrXZxlR45OraAc+3BCZCCPkRh/dyAZoyzmc0AQ8Jcv+BRDGLPlOKWiCVgOKOtiXdwPUBiNfzQ0p5c8FYk1jRYwVMjEz8s9lJ8xJ2Zn97S9oSyi9+KomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W.Avp97_1705973576;
Received: from 30.221.145.142(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.Avp97_1705973576)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 09:32:57 +0800
Message-ID: <9bbf3d38-71bd-49c0-9148-6066420d1d91@linux.alibaba.com>
Date: Tue, 23 Jan 2024 09:32:56 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] cachefiles, erofs: Fix NULL deref in when
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
References: <20240122223230.4000595-1-dhowells@redhat.com>
 <20240122223230.4000595-7-dhowells@redhat.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240122223230.4000595-7-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 6:32 AM, David Howells wrote:
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
> Fix this by making cachefiles_ondemand_init_object() return immediately if
> cachefiles->ondemand is NULL.
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
> 
> Notes:
>     Changes
>     =======
>     ver #2)
>      - Move check of object->ondemand into cachefiles_ondemand_init_object()
> 
>  fs/cachefiles/ondemand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 5fd74ec60bef..4ba42f1fa3b4 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -539,6 +539,9 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>  	struct fscache_volume *volume = object->volume->vcookie;
>  	size_t volume_key_size, cookie_key_size, data_len;
>  
> +	if (!object->ondemand)
> +		return 0;
> +
>  	/*
>  	 * CacheFiles will firstly check the cache file under the root cache
>  	 * directory. If the coherency check failed, it will fallback to


Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>

-- 
Thanks,
Jingbo

