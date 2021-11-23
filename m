Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E574145AF23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 23:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhKWWgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 17:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhKWWgf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:36:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACB4B60F5B;
        Tue, 23 Nov 2021 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637706806;
        bh=SG6EdrV2iuRFaD+Ge9einOddVfpnmRARc8QmBaBuuzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a28vYZhcK/L0+J3l2uz5lhbmBhpTNulgccQeW1VL7mEr/zZaDVT126YrHPn7DruBK
         8Dy2V7WvHSnxPoMv3Gmu/1GTlY8EPd2dzNH9XHbolRma1e6Zpqtzf6JbsTjbYzzl6q
         /LVxnqhglf1xKWmfXFryoBxBdoHQQS2TGBau2wxcst2u36MyQbyUVzIbr1colB13gR
         wQzb+Dj6/firAkz9pcYUjB0iNOa3KRetffwJcQeOR7c+gKFW1h2B5nylwGkZa95fAU
         cFRVmzlVAG8TbWgvsCffLBfLECxv6dPoy5cc+WVPS/yPlzYpaMN7vsLCMga9wFzZD7
         Bx6joLa58GHEQ==
Date:   Tue, 23 Nov 2021 14:33:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 12/29] fsdax: remove a pointless __force cast in
 copy_cow_page_dax
Message-ID: <20211123223326.GG266024@magnolia>
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109083309.584081-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 09:32:52AM +0100, Christoph Hellwig wrote:
> Despite its name copy_user_page expected kernel addresses, which is what
> we already have.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 4e3e5a283a916..73bd1439d8089 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -728,7 +728,7 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  		return rc;
>  	}
>  	vto = kmap_atomic(to);
> -	copy_user_page(vto, (void __force *)kaddr, vaddr, to);
> +	copy_user_page(vto, kaddr, vaddr, to);
>  	kunmap_atomic(vto);
>  	dax_read_unlock(id);
>  	return 0;
> -- 
> 2.30.2
> 
