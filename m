Return-Path: <linux-fsdevel+bounces-7510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E7E8264F5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235651C21491
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jan 2024 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3D13AED;
	Sun,  7 Jan 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je4QSk1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B17513AD1;
	Sun,  7 Jan 2024 16:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDAAC433C8;
	Sun,  7 Jan 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643764;
	bh=vtEdJ8x0t9Cig7F/OQ58765CvJpN5U3pnuPNn8bEtX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Je4QSk1Xsi5jvomPOikxCGlVFwk8iqkAbNF6aVYGaBGYI1jkUw+CADMBs0/wZQr36
	 xy22SDkRZMP5sMid5EvoeH3h/Kwf68Tcbn77GX8EDm+cjFQlFTs6TguY93Et6BFDPv
	 UlIs+e2Jheeb2/ck0biFbtZrf0Vw9LMCbIX3TaJmqJZgdrEhhfSfxUMIfjU8lZxJF7
	 Q+aCdvG3kA6VLZkjLHS+Vga8pwGe2Z6VghL3LobYtAq3sM2rUGAW8uNlztGT7uqIEc
	 x+WdUyce0Wh+SeZcYOdm2MG39rO2B8pkIyqp3viKoDClILrK1BwA1eJJXlvP2hGICM
	 kq7yyH7rMCZgg==
Date: Sun, 7 Jan 2024 16:09:16 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yiqun Leng <yqleng@linux.alibaba.com>,
	Jia Zhu <zhujia.zj@bytedance.com>
Subject: Re: [PATCH 1/5] cachefiles: Fix __cachefiles_prepare_write()
Message-ID: <20240107160916.GA129355@kernel.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-2-dhowells@redhat.com>

On Wed, Jan 03, 2024 at 02:59:25PM +0000, David Howells wrote:
> Fix __cachefiles_prepare_write() to correctly determine whether the
> requested write will fit correctly with the DIO alignment.
> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Tested-by: Jia Zhu <zhujia.zj@bytedance.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/cachefiles/io.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index bffffedce4a9..7529b40bc95a 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -522,16 +522,22 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  			       bool no_space_allocated_yet)
>  {
>  	struct cachefiles_cache *cache = object->volume->cache;
> -	loff_t start = *_start, pos;
> -	size_t len = *_len, down;
> +	unsigned long long start = *_start, pos;
> +	size_t len = *_len;
>  	int ret;
>  
>  	/* Round to DIO size */
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
>  		return -ENOBUFS;
> +	}
> +
> +	*_len = round_up(len, PAGE_SIZE);
>  
>  	/* We need to work out whether there's sufficient disk space to perform
>  	 * the write - but we can skip that check if we have space already
> @@ -542,7 +548,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  
>  	pos = cachefiles_inject_read_error();
>  	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_DATA);
> +		pos = vfs_llseek(file, start, SEEK_DATA);
>  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {

Hi David,

I realise these patches have been accepted, but I have a minor nit:
pos is now unsigned, and so cannot be less than zero.

Flagged by Smatch and Coccinelle.

>  		if (pos == -ENXIO)
>  			goto check_space; /* Unallocated tail */
> @@ -550,7 +556,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  					  cachefiles_trace_seek_error);
>  		return pos;
>  	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>  		goto check_space; /* Unallocated region */
>  
>  	/* We have a block that's at least partially filled - if we're low on
> @@ -563,13 +569,13 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  
>  	pos = cachefiles_inject_read_error();
>  	if (pos == 0)
> -		pos = vfs_llseek(file, *_start, SEEK_HOLE);
> +		pos = vfs_llseek(file, start, SEEK_HOLE);
>  	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {

Ditto.

>  		trace_cachefiles_io_error(object, file_inode(file), pos,
>  					  cachefiles_trace_seek_error);
>  		return pos;
>  	}
> -	if ((u64)pos >= (u64)*_start + *_len)
> +	if (pos >= start + *_len)
>  		return 0; /* Fully allocated */
>  
>  	/* Partially allocated, but insufficient space: cull. */
> @@ -577,7 +583,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
>  	ret = cachefiles_inject_remove_error();
>  	if (ret == 0)
>  		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -				    *_start, *_len);
> +				    start, *_len);
>  	if (ret < 0) {
>  		trace_cachefiles_io_error(object, file_inode(file), ret,
>  					  cachefiles_trace_fallocate_error);
> 

