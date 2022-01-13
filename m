Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23E48D0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiAMDLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:11:06 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57093 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231916AbiAMDLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:11:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V1i735m_1642043457;
Received: from 30.225.24.62(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V1i735m_1642043457)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 11:10:58 +0800
Message-ID: <9eafb56b-809c-c340-5627-a54a6265122b@linux.alibaba.com>
Date:   Thu, 13 Jan 2022 11:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [Linux-cachefs] [PATCH v1 05/23] netfs: add inode parameter to
 netfs_alloc_read_request()
Content-Language: en-US
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>
Cc:     tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
        gerry@linux.alibaba.com, linux-cachefs@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-6-jefflexu@linux.alibaba.com>
In-Reply-To: <20211227125444.21187-6-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

What would you think about this cleanup? We need this in prep for the
following fscache-based on-demand reading feature. It would be great if
it could be cherry picked in advance.

I also simplify the commit message as suggested by Gao Xiang. I could
resend a v2 patch with the updated commit message if you'd like.

    netfs: add inode parameter to netfs_alloc_read_request()

    Make the @file parameter optional, and derive inode from the @folio
    parameter instead.

    @file parameter can't be removed completely, since it also works as
    the private data of ops->init_rreq().

    Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>


On 12/27/21 8:54 PM, Jeffle Xu wrote:
> When working as the local cache, the @file parameter of
> netfs_alloc_read_request() represents the backed file inside netfs. It
> is for two use: 1) we can derive the corresponding inode from file,
> 2) works as the argument for ops->init_rreq().
> 
> In the new introduced demand-read mode, netfs_readpage() will be called
> by the upper fs to read from backing files. However in this new mode,
> the backed file may not be opened, and thus the @file argument is NULL
> in this case.
> 
> For netfs_readpage(), @file parameter represents the backed file inside
> netfs, while @folio parameter represents one page cache inside the
> address space of this backed file. We can still derive the inode from
> the @folio parameter, even when @file parameter is NULL.
> 
> Thus refactor netfs_alloc_read_request() somewhat for this change.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/netfs/read_helper.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 8c58cff420ba..ca84918b6b5d 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -39,7 +39,7 @@ static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
>  
>  static struct netfs_read_request *netfs_alloc_read_request(
>  	const struct netfs_read_request_ops *ops, void *netfs_priv,
> -	struct file *file)
> +	struct inode *inode, struct file *file)
>  {
>  	static atomic_t debug_ids;
>  	struct netfs_read_request *rreq;
> @@ -48,7 +48,7 @@ static struct netfs_read_request *netfs_alloc_read_request(
>  	if (rreq) {
>  		rreq->netfs_ops	= ops;
>  		rreq->netfs_priv = netfs_priv;
> -		rreq->inode	= file_inode(file);
> +		rreq->inode	= inode;
>  		rreq->i_size	= i_size_read(rreq->inode);
>  		rreq->debug_id	= atomic_inc_return(&debug_ids);
>  		INIT_LIST_HEAD(&rreq->subrequests);
> @@ -870,6 +870,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  		     void *netfs_priv)
>  {
>  	struct netfs_read_request *rreq;
> +	struct inode *inode = file_inode(ractl->file);
>  	unsigned int debug_index = 0;
>  	int ret;
>  
> @@ -878,7 +879,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  	if (readahead_count(ractl) == 0)
>  		goto cleanup;
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, ractl->file);
>  	if (!rreq)
>  		goto cleanup;
>  	rreq->mapping	= ractl->mapping;
> @@ -948,12 +949,13 @@ int netfs_readpage(struct file *file,
>  		   void *netfs_priv)
>  {
>  	struct netfs_read_request *rreq;
> +	struct inode *inode = folio_file_mapping(folio)->host;
>  	unsigned int debug_index = 0;
>  	int ret;
>  
>  	_enter("%lx", folio_index(folio));
>  
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, file);
>  	if (!rreq) {
>  		if (netfs_priv)
>  			ops->cleanup(folio_file_mapping(folio), netfs_priv);
> @@ -1122,7 +1124,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	}
>  
>  	ret = -ENOMEM;
> -	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, inode, file);
>  	if (!rreq)
>  		goto error;
>  	rreq->mapping		= folio_file_mapping(folio);
> 

-- 
Thanks,
Jeffle
