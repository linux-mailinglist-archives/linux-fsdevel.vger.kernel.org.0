Return-Path: <linux-fsdevel+bounces-7142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102478222AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 21:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885AD2847F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 20:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928FF16438;
	Tue,  2 Jan 2024 20:37:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC516402;
	Tue,  2 Jan 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0VzrTmRn_1704227842;
Received: from 30.25.242.23(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzrTmRn_1704227842)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 04:37:25 +0800
Message-ID: <ae2502e0-af39-469b-9036-0fd9771904a8@linux.alibaba.com>
Date: Wed, 3 Jan 2024 04:37:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 33/40] netfs, cachefiles: Pass upper bound length to
 allow expansion
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
 Steve French <smfrench@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Jia Zhu <zhujia.zj@bytedance.com>, Xin Yin <yinxin.x@bytedance.com>,
 Yiqun Leng <yqleng@linux.alibaba.com>
References: <750e8251-ba30-4f53-a17b-73c79e3739ce@linux.alibaba.com>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-34-dhowells@redhat.com>
 <198744.1704215477@warthog.procyon.org.uk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <198744.1704215477@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/3 01:11, David Howells wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>>>    	down = start - round_down(start, PAGE_SIZE);
>>>    	*_start = start - down;
>>>    	*_len = round_up(down + len, PAGE_SIZE);
>>> +	if (down < start || *_len > upper_len)
>>> +		return -ENOBUFS;
>>
>> Sorry for bothering. We just found some strange when testing
>> today-next EROFS over fscache.
>>
>> I'm not sure the meaning of
>>      if (down < start
>>
>> For example, if start is page-aligned, down == 0.
>>
>> so as long as start > 0 and page-aligned, it will return
>> -ENOBUFS.  Does it an intended behavior?
> 
> Yeah, I think that's wrong.
> 
> Does the attached help?

(+cc more people for testing)

Will test and feedback later.

Thanks,
Gao Xiang

> 
> David
> ---
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index bffffedce4a9..7529b40bc95a 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   			       bool no_space_allocated_yet)
>   {
>   	struct cachefiles_cache *cache = object->volume->cache;
> -	loff_t start = *_start, pos;
> -	size_t len = *_len, down;
> +	unsigned long long start = *_start, pos;
> +	size_t len = *_len;
>   	int ret;
>   
>   	/* Round to DIO size */
> -	down = start - round_down(start, PAGE_SIZE);
> -	*_start = start - down;
> -	*_len = round_up(down + len, PAGE_SIZE);
> -	if (down < start || *_len > upper_len)
> +	start = round_down(*_start, PAGE_SIZE);
> +	if (start != *_start) {
> +		kleave(" = -ENOBUFS [down]");
> +		return -ENOBUFS;
> +	}
> +	if (*_len > upper_len) {
> +		kleave(" = -ENOBUFS [up]");
>   		return -ENOBUFS;
> +	}
> +
> +	*_len = round_up(len, PAGE_SIZE);
>   
>   	/* We need to work out whether there's sufficient disk space to perform
>   	 * the write - but we can skip that check if we have space already
> @@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   
>   	pos = cachefiles_inject_read_error();
>   	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_DATA);
> +		pos = vfs_llseek(file, start, SEEK_DATA);
>   	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
>   		if (pos == -ENXIO)
>   			goto check_space; /* Unallocated tail */
> @@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>   		goto check_space; /* Unallocated region */
>   
>   	/* We have a block that's at least partially filled - if we're low on
> @@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   
>   	pos = cachefiles_inject_read_error();
>   	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_HOLE);
> +		pos = vfs_llseek(file, start, SEEK_HOLE);
>   	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
>   		trace_cachefiles_io_error(object, file_inode(file), pos,
>   					  cachefiles_trace_seek_error);
>   		return pos;
>   	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>   		return 0; /* Fully allocated */
>   
>   	/* Partially allocated, but insufficient space: cull. */
> @@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   	ret = cachefiles_inject_remove_error();
>   	if (ret == 0)
>   		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				    *_start, *_len);
> +				    start, *_len);
>   	if (ret < 0) {
>   		trace_cachefiles_io_error(object, file_inode(file), ret,
>   					  cachefiles_trace_fallocate_error);
> 

