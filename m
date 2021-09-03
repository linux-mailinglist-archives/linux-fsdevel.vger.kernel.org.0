Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C285400560
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbhICSzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351330AbhICSzn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:55:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 888A661051;
        Fri,  3 Sep 2021 18:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630695283;
        bh=QCfcug80tdQ1QAUPH0uRGAAB0pJI7fKgv+QxILjMEtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnwmUuqIk6KXoxFIjCuEsicWT1MuIK3y6nTujOVI13ZDF2ee01rhhwUKSbfxG+8Hi
         JjZc+rNIIHipx86/YaKZq3RXTOaQw9FPmcLuo3ZWU+tu0Av+oUn6uaBG31RxwYEJ9x
         L/UN/evtWJRQVfUoKJ7OAaSC4IVYseqhPlFkBj/qPRggJd+54yDavWsqTZ67EhQE1l
         k4DwiyrKsq9cghTLXyQx7rnQdzMheGcYbRZ2yxnbad6ac93UMJ8tUuWtBdR+tjQ7Ok
         nRX39TcblK4kh4hJvCS3sw+NTw4a92IF5Weg9cuYYCds3mSv2BT1Whp7BYgKtt/3Jz
         PDuHV2og8cOKg==
Date:   Fri, 3 Sep 2021 11:54:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 14/19] iomap: Fix iomap_dio_rw return value for user
 copies
Message-ID: <20210903185443.GF9892@magnolia>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-15-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-15-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:21PM +0200, Andreas Gruenbacher wrote:
> When a user copy fails in one of the helpers of iomap_dio_rw, fail with
> -EFAULT instead of returning 0.  This matches what iomap_dio_bio_actor
> returns when it gets an -EFAULT from bio_iov_iter_get_pages.  With these
> changes, iomap_dio_actor now consistently fails with -EFAULT when a user
> page cannot be faulted in.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9398b8c31323..8054f5d6c273 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -370,7 +370,7 @@ iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
>  {
>  	length = iov_iter_zero(length, dio->submit.iter);
>  	dio->size += length;
> -	return length;
> +	return length ? length : -EFAULT;
>  }
>  
>  static loff_t
> @@ -397,7 +397,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
>  		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
>  	}
>  	dio->size += copied;
> -	return copied;
> +	return copied ? copied : -EFAULT;
>  }
>  
>  static loff_t
> -- 
> 2.26.3
> 
