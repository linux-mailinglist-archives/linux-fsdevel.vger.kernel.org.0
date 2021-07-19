Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572BF3CE295
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348501AbhGSPa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 11:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345967AbhGSP1l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:27:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E9B61244;
        Mon, 19 Jul 2021 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626710900;
        bh=Mz7TLVouzL9wlLWjb9B+xXfuPQcK66yf+eEa7aWT6dI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKWSMHCX/WvxCJLVwULeb1cnvPf+5uaHgcQLCA6w2RiVnHGLAVKVh7hOKXJYFOsyH
         FN9xI/tZepHCLDmuLX6mlH4mwQpB/MDA+2UP0Rw1ofa5n89faohdxDsMrrUqOK/RPl
         YYmQTeM99/7fD59sVupKy60jGZZ4I6v8+Y8sxepC8N6QD1czSF7mclQYy7H/vXo4dH
         JW1FKrWwaHyDisdTxV89XRqOuvwFCOS1weHUe1AqpthcmQCnMQEbkn5waOjmQr+HlJ
         sVGEX9goHy8EZUXzCcwefrjwBeLWSk/MsfmYrdrmJhFF2E/kQq9ysHFf4eF8FL2+Cf
         PSgqHF+5duo+g==
Date:   Mon, 19 Jul 2021 09:08:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 03/27] iomap: mark the iomap argument to iomap_sector
 const
Message-ID: <20210719160820.GE22402@magnolia>
References: <20210719103520.495450-1-hch@lst.de>
 <20210719103520.495450-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719103520.495450-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:34:56PM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

/me wonders, does this have any significant effect on the generated
code?

It's probably a good idea to feed the optimizer as much usage info as we
can, though I would imagine that for such a simple function it can
probably tell that we don't change *iomap.

IMHO, constifiying functions is a good way to signal to /programmers/
that they're not intended to touch the arguments, so

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/iomap.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 093519d91cc9cc..f9c36df6a3061b 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -91,8 +91,7 @@ struct iomap {
>  	const struct iomap_page_ops *page_ops;
>  };
>  
> -static inline sector_t
> -iomap_sector(struct iomap *iomap, loff_t pos)
> +static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
>  {
>  	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
>  }
> -- 
> 2.30.2
> 
