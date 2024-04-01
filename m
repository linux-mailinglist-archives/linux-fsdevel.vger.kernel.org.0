Return-Path: <linux-fsdevel+bounces-15825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA4B893BA3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CD4C1C21439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932B740860;
	Mon,  1 Apr 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c29yWJov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5AC3F8F1;
	Mon,  1 Apr 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979639; cv=none; b=tQWzCsmlMbfa4nu4nMmBeNLBSw/Wa18pE4srCoW/WALjyTW3Xk/AcipeATv+JqWKfAbNJw9lYl7wvp/GNd4e3YGHmtto4f0VbP4C/WIlCB84O2qSiN/RlrL2PO2gQjA3Adxh30lRR96/7qnIp0TceatzAxC3urqzGxj7im+MjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979639; c=relaxed/simple;
	bh=dmYCendNfZLK2ZYRN4P3XHXSgHmLS9K4qfGr3Ifd3v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6zYjs94S03IZeCtmtIlyX/0RK17WPiPjQkkDmYDdljlVx5Ikj7KZ0xlYzZkJBOfdBVG1MpITp77wpluPmQpDILA0kJhTsyLJuHYzRXhvMhIcA7cyKxg5+Zg8gi+oK1VsYYFRNPRyFN8P2/SZACqIjf4YrJy966YDreftmU1DIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c29yWJov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0CC433C7;
	Mon,  1 Apr 2024 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711979638;
	bh=dmYCendNfZLK2ZYRN4P3XHXSgHmLS9K4qfGr3Ifd3v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c29yWJov1MPD3KNJnAc3J10X31RIJx5rJ8pZ9aMASTtRIDHTlXt3YBkMhR/2MmTeW
	 zKg7sKvzusvvzXvEpqIv8nO9JilxGOlGDD9rpErvCQJiT/+cOIdnykZR54Pb5hp73A
	 n3db2XvRlrrFuw27hXNlQVFklZF/bwBt1Tvksi8eyn/LaeBo2QoMfURHysv0Ra+tcm
	 5GNCZFCSDd/aMOWF7fV3ver/b2jE5QU8+WhPmhCzIjV1dmrOHawVXzxIdY9jTI6kkp
	 3RzhX7bCaKGHmMTJC3G9ZTma+EDhOVW6r/AdWBj3gvJJLSd3U3a0S7GGRMCCfrXnpN
	 BcEw/0JlvpOew==
Date: Mon, 1 Apr 2024 14:53:51 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
	linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/26] netfs, afs: Use writeback retry to deal with
 alternate keys
Message-ID: <20240401135351.GD26556@kernel.org>
References: <20240328163424.2781320-1-dhowells@redhat.com>
 <20240328163424.2781320-27-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328163424.2781320-27-dhowells@redhat.com>

On Thu, Mar 28, 2024 at 04:34:18PM +0000, David Howells wrote:

...

> +void afs_issue_write(struct netfs_io_subrequest *subreq)
>  {
> +	struct netfs_io_request *wreq = subreq->rreq;
>  	struct afs_operation *op;
> -	struct afs_wb_key *wbk = NULL;
> -	loff_t size = iov_iter_count(iter);
> +	struct afs_vnode *vnode = AFS_FS_I(wreq->inode);
> +	unsigned long long pos = subreq->start + subreq->transferred;
> +	size_t len = subreq->len - subreq->transferred;
>  	int ret = -ENOKEY;
>  
> -	_enter("%s{%llx:%llu.%u},%llx,%llx",
> +	_enter("R=%x[%x],%s{%llx:%llu.%u},%llx,%zx",
> +	       wreq->debug_id, subreq->debug_index,
>  	       vnode->volume->name,
>  	       vnode->fid.vid,
>  	       vnode->fid.vnode,
>  	       vnode->fid.unique,
> -	       size, pos);
> +	       pos, len);
>  
> -	ret = afs_get_writeback_key(vnode, &wbk);
> -	if (ret) {
> -		_leave(" = %d [no keys]", ret);
> -		return ret;
> -	}
> +#if 0 // Error injection
> +	if (subreq->debug_index == 3)
> +		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
>  
> -	op = afs_alloc_operation(wbk->key, vnode->volume);
> -	if (IS_ERR(op)) {
> -		afs_put_wb_key(wbk);
> -		return -ENOMEM;
> +	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
> +		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
> +		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
>  	}
> +#endif
> +
> +	op = afs_alloc_operation(wreq->netfs_priv, vnode->volume);
> +	if (IS_ERR(op))
> +		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
>  
>  	afs_op_set_vnode(op, 0, vnode);
> -	op->file[0].dv_delta = 1;
> +	op->file[0].dv_delta	= 1;
>  	op->file[0].modification = true;
> -	op->store.pos = pos;
> -	op->store.size = size;
> -	op->flags |= AFS_OPERATION_UNINTR;
> -	op->ops = &afs_store_data_operation;
> +	op->store.pos		= pos;
> +	op->store.size		= len,

nit: this is probably more intuitively written using len;

> +	op->flags		|= AFS_OPERATION_UNINTR;
> +	op->ops			= &afs_store_data_operation;
>  
> -try_next_key:
>  	afs_begin_vnode_operation(op);
>  
> -	op->store.write_iter = iter;
> -	op->store.i_size = max(pos + size, vnode->netfs.remote_i_size);
> -	op->mtime = inode_get_mtime(&vnode->netfs.inode);
> +	op->store.write_iter	= &subreq->io_iter;
> +	op->store.i_size	= umax(pos + len, vnode->netfs.remote_i_size);
> +	op->mtime		= inode_get_mtime(&vnode->netfs.inode);
>  
>  	afs_wait_for_operation(op);
> -
> -	switch (afs_op_error(op)) {
> +	ret = afs_put_operation(op);
> +	switch (ret) {
>  	case -EACCES:
>  	case -EPERM:
>  	case -ENOKEY:
>  	case -EKEYEXPIRED:
>  	case -EKEYREJECTED:
>  	case -EKEYREVOKED:
> -		_debug("next");
> -
> -		ret = afs_get_writeback_key(vnode, &wbk);
> -		if (ret == 0) {
> -			key_put(op->key);
> -			op->key = key_get(wbk->key);
> -			goto try_next_key;
> -		}
> +		/* If there are more keys we can try, use the retry algorithm
> +		 * to rotate the keys.
> +		 */
> +		if (wreq->netfs_priv2)
> +			set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  		break;
>  	}
>  
> -	afs_put_wb_key(wbk);
> -	_leave(" = %d", afs_op_error(op));
> -	return afs_put_operation(op);
> +	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len, false);
>  }
>  
>  /*

...

