Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631933EB5CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhHMMyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 08:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233416AbhHMMyJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:54:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 210C560F91;
        Fri, 13 Aug 2021 12:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628859223;
        bh=xpS807ZsmUqY4wbbSw6MbqCagTEFVPHlwkp24KlCBRw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L4OKBlfk2A+1+BR3+zqIganxq6pQ7QNQEY+R8SyOMmwSQOciazevmv1RnQDKHCZTZ
         IODAYTRzF0UxGu6wAbhD0TvzN8IWvSh/Y2Mwczfu85PxU1qn2vMPwEG3pLrCdfhEqk
         CfHaIp15QLs20Gt4BFGXqhfRw6SArSp+EmjBj1FkvMjodFVxmS7ZQ5exbtt591JNc5
         Su1hnJ97Dx+LYUOarYiH4ocoKxLxBVD/T4x7mdeBd8gX4ZmSp340dDk0PcChyd6LPG
         JvFuDfvJrq8c+DxYXmE83b4xf/3D9H7MroKFkp793q8lfyqc7cX0Q5wD8MeLPNAaW4
         2j7Idwp4gNBEQ==
Message-ID: <a786d17996459d1ed5530d7f193013c04d183e8c.camel@kernel.org>
Subject: Re: [PATCH] netfs: Fix READ/WRITE confusion when calling
 iov_iter_xarray()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Aug 2021 08:53:41 -0400
In-Reply-To: <162729351325.813557.9242842205308443901.stgit@warthog.procyon.org.uk>
References: <162729351325.813557.9242842205308443901.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-07-26 at 10:58 +0100, David Howells wrote:
> Fix netfs_clear_unread() to pass READ to iov_iter_xarray() instead of WRITE
> (the flag is about the operation accessing the buffer, not what sort of
> access it is doing to the buffer).
> 
> Fixes: 3d3c95046742 ("netfs: Provide readahead and readpage netfs helpers")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-afs@lists.infradead.org
> cc: ceph-devel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: linux-nfs@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
>  fs/netfs/read_helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 0b6cd3b8734c..994ec22d4040 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -150,7 +150,7 @@ static void netfs_clear_unread(struct netfs_read_subrequest *subreq)
>  {
>  	struct iov_iter iter;
>  
> -	iov_iter_xarray(&iter, WRITE, &subreq->rreq->mapping->i_pages,
> +	iov_iter_xarray(&iter, READ, &subreq->rreq->mapping->i_pages,
>  			subreq->start + subreq->transferred,
>  			subreq->len   - subreq->transferred);
>  	iov_iter_zero(iov_iter_count(&iter), &iter);
> 
> 

That's better!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

