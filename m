Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC2A4D35B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiCIRFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiCIREI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:04:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F39AD8A;
        Wed,  9 Mar 2022 08:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C30E61B45;
        Wed,  9 Mar 2022 16:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F6CC340EC;
        Wed,  9 Mar 2022 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646844755;
        bh=wIeGbE6Q41oIhTY+lLUbah8qqKEMzvsX86DStRQLx9g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ajZf+msEiuAWYsEHyAa1la9mmAEWm9CLYkJ001PCn+OQvcazGSJy3d9bN2D8B8QOl
         5AmoJJMr61AzJpz/9+Ut/VwC1v4hD8jL5NrR+B7Tcg/own5k4BGYTnt/h4otdOlDEa
         5nzPVdlP12f35p/OQIYWEAYEpd+EMx+VJpxJ9RwcIpFERATK2geEjU5UtMXmU3dMTt
         8+VCsgjtIlQWdTx6ECnl08vIoCehsmH4HavcgIT1iTq9WjSopxA4kmJQ4PjDaBaak/
         zxymJkFfufPzJLXiDgcXeJwV6wBNC7DrdpaFm2CX46qY7OsD49zaSn1Xoof0/8QlTi
         63TkLPMr13Wtg==
Message-ID: <4cbb2bb06eafb8f03135fc377ced779102004ea7.camel@kernel.org>
Subject: Re: [PATCH v2 11/19] netfs: Change ->init_request() to return an
 error code
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Mar 2022 11:52:32 -0500
In-Reply-To: <164678212401.1200972.16537041523832944934.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
         <164678212401.1200972.16537041523832944934.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-03-08 at 23:28 +0000, David Howells wrote:
> Change the request initialisation function to return an error code so that
> the network filesystem can return a failure (ENOMEM, for example).
> 
> This will also allow ceph to abort a ->readahead() op if the server refuses
> to give it a cap allowing local caching from within the netfslib framework
> (errors aren't passed back through ->readahead(), so returning, say,
> -ENOBUFS will cause the op to be aborted).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---
> 
>  fs/9p/vfs_addr.c       |    3 ++-
>  fs/afs/file.c          |    3 ++-
>  fs/netfs/objects.c     |   41 ++++++++++++++++++++++++-----------------
>  fs/netfs/read_helper.c |   20 ++++++++++++--------
>  include/linux/netfs.h  |    2 +-
>  5 files changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
> index fdc1033a1546..91d3926c9559 100644
> --- a/fs/9p/vfs_addr.c
> +++ b/fs/9p/vfs_addr.c
> @@ -56,12 +56,13 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
>   * @rreq: The read request
>   * @file: The file being read from
>   */
> -static void v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
> +static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
>  {
>  	struct p9_fid *fid = file->private_data;
>  
>  	refcount_inc(&fid->count);
>  	rreq->netfs_priv = fid;
> +	return 0;
>  }
>  
>  /**
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index b19d635eed12..6469d7f98ef5 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -359,9 +359,10 @@ static int afs_symlink_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  
> -static void afs_init_request(struct netfs_io_request *rreq, struct file *file)
> +static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
>  {
>  	rreq->netfs_priv = key_get(afs_file_key(file));
> +	return 0;
>  }
>  
>  static bool afs_is_cache_enabled(struct inode *inode)
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 986d7a9d25dd..ae18827e156b 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -20,27 +20,34 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>  {
>  	static atomic_t debug_ids;
>  	struct netfs_io_request *rreq;
> +	int ret;
>  
>  	rreq = kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> -	if (rreq) {
> -		rreq->start	= start;
> -		rreq->len	= len;
> -		rreq->origin	= origin;
> -		rreq->netfs_ops	= ops;
> -		rreq->netfs_priv = netfs_priv;
> -		rreq->mapping	= mapping;
> -		rreq->inode	= file_inode(file);
> -		rreq->i_size	= i_size_read(rreq->inode);
> -		rreq->debug_id	= atomic_inc_return(&debug_ids);
> -		INIT_LIST_HEAD(&rreq->subrequests);
> -		INIT_WORK(&rreq->work, netfs_rreq_work);
> -		refcount_set(&rreq->ref, 1);
> -		__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> -		if (ops->init_request)
> -			ops->init_request(rreq, file);
> -		netfs_stat(&netfs_n_rh_rreq);
> +	if (!rreq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rreq->start	= start;
> +	rreq->len	= len;
> +	rreq->origin	= origin;
> +	rreq->netfs_ops	= ops;
> +	rreq->netfs_priv = netfs_priv;
> +	rreq->mapping	= mapping;
> +	rreq->inode	= file_inode(file);
> +	rreq->i_size	= i_size_read(rreq->inode);
> +	rreq->debug_id	= atomic_inc_return(&debug_ids);
> +	INIT_LIST_HEAD(&rreq->subrequests);
> +	INIT_WORK(&rreq->work, netfs_rreq_work);
> +	refcount_set(&rreq->ref, 1);
> +	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> +	if (rreq->netfs_ops->init_request) {
> +		ret = rreq->netfs_ops->init_request(rreq, file);
> +		if (ret < 0) {
> +			kfree(rreq);
> +			return ERR_PTR(ret);
> +		}
>  	}
>  
> +	netfs_stat(&netfs_n_rh_rreq);
>  	return rreq;
>  }
>  
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index dea085715286..b5176f4320f4 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -768,7 +768,7 @@ void netfs_readahead(struct readahead_control *ractl,
>  				   readahead_pos(ractl),
>  				   readahead_length(ractl),
>  				   NETFS_READAHEAD);
> -	if (!rreq)
> +	if (IS_ERR(rreq))
>  		goto cleanup;
>  
>  	if (ops->begin_cache_operation) {
> @@ -842,11 +842,9 @@ int netfs_readpage(struct file *file,
>  	rreq = netfs_alloc_request(folio->mapping, file, ops, netfs_priv,
>  				   folio_file_pos(folio), folio_size(folio),
>  				   NETFS_READPAGE);
> -	if (!rreq) {
> -		if (netfs_priv)
> -			ops->cleanup(folio_file_mapping(folio), netfs_priv);
> -		folio_unlock(folio);
> -		return -ENOMEM;
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
> +		goto alloc_error;
>  	}
>  
>  	if (ops->begin_cache_operation) {
> @@ -887,6 +885,11 @@ int netfs_readpage(struct file *file,
>  out:
>  	netfs_put_request(rreq, false, netfs_rreq_trace_put_hold);
>  	return ret;
> +alloc_error:
> +	if (netfs_priv)
> +		ops->cleanup(folio_file_mapping(folio), netfs_priv);
> +	folio_unlock(folio);
> +	return ret;
>  }
>  EXPORT_SYMBOL(netfs_readpage);
>  
> @@ -1007,12 +1010,13 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  		goto have_folio_no_wait;
>  	}
>  
> -	ret = -ENOMEM;
>  	rreq = netfs_alloc_request(mapping, file, ops, netfs_priv,
>  				   folio_file_pos(folio), folio_size(folio),
>  				   NETFS_READ_FOR_WRITE);
> -	if (!rreq)
> +	if (IS_ERR(rreq)) {
> +		ret = PTR_ERR(rreq);
>  		goto error;
> +	}
>  	rreq->no_unlock_folio	= folio_index(folio);
>  	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
>  	netfs_priv = NULL;
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 7dc741d9b21b..4b99e38f73d9 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -193,7 +193,7 @@ struct netfs_io_request {
>   */
>  struct netfs_request_ops {
>  	bool (*is_cache_enabled)(struct inode *inode);
> -	void (*init_request)(struct netfs_io_request *rreq, struct file *file);
> +	int (*init_request)(struct netfs_io_request *rreq, struct file *file);
>  	int (*begin_cache_operation)(struct netfs_io_request *rreq);
>  	void (*expand_readahead)(struct netfs_io_request *rreq);
>  	bool (*clamp_length)(struct netfs_io_subrequest *subreq);
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
