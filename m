Return-Path: <linux-fsdevel+bounces-7642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16171828C29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E11B21EFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC23C099;
	Tue,  9 Jan 2024 18:11:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E813BB3E;
	Tue,  9 Jan 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0W-JAUV5_1704823869;
Received: from 30.25.253.88(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-JAUV5_1704823869)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 02:11:12 +0800
Message-ID: <97d0e776-d672-405a-9359-fb7f16969dc3@linux.alibaba.com>
Date: Wed, 10 Jan 2024 02:11:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] erofs: Don't use certain internal folio_*() functions
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Steve French <smfrench@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Marc Dionne <marc.dionne@auristor.com>, Paulo Alcantara <pc@manguebit.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20240109180117.1669008-1-dhowells@redhat.com>
 <20240109180117.1669008-4-dhowells@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240109180117.1669008-4-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/1/10 02:01, David Howells wrote:
> Filesystems should not be using folio->index not folio_index(folio) and
> folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
> code.
> 
> Change this automagically with:
> 
> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Gao Xiang <xiang@kernel.org>
> cc: Chao Yu <chao@kernel.org>
> cc: Yue Hu <huyue2@coolpad.com>
> cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org

Thank you, David!

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

(I've asked Jingbo to find some free slot to refine
  this part for later compressed data adaption.  Yet that
  is another separate story.  The patch looks good to me.)

Thanks,
Gao Xiang

> ---
>   fs/erofs/fscache.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 87ff35bff8d5..bc12030393b2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -165,10 +165,10 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>   static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>   {
>   	int ret;
> -	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
> +	struct erofs_fscache *ctx = folio->mapping->host->i_private;
>   	struct erofs_fscache_request *req;
>   
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>   				folio_pos(folio), folio_size(folio));
>   	if (IS_ERR(req)) {
>   		folio_unlock(folio);
> @@ -276,7 +276,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>   	struct erofs_fscache_request *req;
>   	int ret;
>   
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>   			folio_pos(folio), folio_size(folio));
>   	if (IS_ERR(req)) {
>   		folio_unlock(folio);
> 

