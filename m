Return-Path: <linux-fsdevel+bounces-7120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3D4821D53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A6322815B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164241171B;
	Tue,  2 Jan 2024 14:04:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43699101FA;
	Tue,  2 Jan 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VzqtEDH_1704204253;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzqtEDH_1704204253)
          by smtp.aliyun-inc.com;
          Tue, 02 Jan 2024 22:04:14 +0800
Message-ID: <750e8251-ba30-4f53-a17b-73c79e3739ce@linux.alibaba.com>
Date: Tue, 2 Jan 2024 22:04:12 +0800
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
 Steve French <smfrench@gmail.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-34-dhowells@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20231221132400.1601991-34-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 2023/12/21 21:23, David Howells wrote:
> Make netfslib pass the maximum length to the ->prepare_write() op to tell
> the cache how much it can expand the length of a write to.  This allows a
> write to the server at the end of a file to be limited to a few bytes
> whilst writing an entire block to the cache (something required by direct
> I/O).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>   fs/cachefiles/internal.h |  2 +-
>   fs/cachefiles/io.c       | 10 ++++++----
>   fs/cachefiles/ondemand.c |  2 +-
>   fs/netfs/fscache_io.c    |  2 +-
>   fs/netfs/io.c            |  2 +-
>   fs/netfs/objects.c       |  1 +
>   fs/netfs/output.c        | 25 ++++++++++---------------
>   fs/smb/client/fscache.c  |  2 +-
>   include/linux/netfs.h    |  5 +++--
>   9 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index 2ad58c465208..1af48d576a34 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -233,7 +233,7 @@ extern bool cachefiles_begin_operation(struct netfs_cache_resources *cres,
>   				       enum fscache_want_state want_state);
>   extern int __cachefiles_prepare_write(struct cachefiles_object *object,
>   				      struct file *file,
> -				      loff_t *_start, size_t *_len,
> +				      loff_t *_start, size_t *_len, size_t upper_len,
>   				      bool no_space_allocated_yet);
>   extern int __cachefiles_write(struct cachefiles_object *object,
>   			      struct file *file,
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 009d23cd435b..bffffedce4a9 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -518,7 +518,7 @@ cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
>    */
>   int __cachefiles_prepare_write(struct cachefiles_object *object,
>   			       struct file *file,
> -			       loff_t *_start, size_t *_len,
> +			       loff_t *_start, size_t *_len, size_t upper_len,
>   			       bool no_space_allocated_yet)
>   {
>   	struct cachefiles_cache *cache = object->volume->cache;
> @@ -530,6 +530,8 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>   	down = start - round_down(start, PAGE_SIZE);
>   	*_start = start - down;
>   	*_len = round_up(down + len, PAGE_SIZE);
> +	if (down < start || *_len > upper_len)
> +		return -ENOBUFS;

Sorry for bothering. We just found some strange when testing
today-next EROFS over fscache.

I'm not sure the meaning of
     if (down < start

For example, if start is page-aligned, down == 0.

so as long as start > 0 and page-aligned, it will return
-ENOBUFS.  Does it an intended behavior?

Thanks,
Gao Xiang

