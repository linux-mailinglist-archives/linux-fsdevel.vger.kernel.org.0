Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E64D3D9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfJKKmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:42:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKKmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6MPGx8ztZUSpNezxLbEEgHnbQ79k7SdA33nvNtLhz1E=; b=gWaodQztqNrlA4Xy2ysX7usz+
        /ZlmkFFqQ0nBJJhzcIuKHGWukFs4hQlFxV1SbmB85n9oRfYdtm2gwQlLrEIbMg9RBrRLhxGKehkjE
        K1A65zvvKCjCg/08RkkU6ZfYYV4kSoolEMQD0PiLBJ3cYKRSNDBUPq0xIfu3sLqDdqdMTyLzStWMA
        v3ONYVsJsXAi5id/ZOtnGte65bmVubIrSUQCqWrfPLi510YXXwo1ci0t1AlcnqsPZEQMVi881StmZ
        xQEaWzzokjv+eVw3Jx0GU7BGiLHu4R1narSy024BLpqB4nz8oER462aYWqAiTM2MDF20f99v80c97
        gValx/WJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsN3-00072B-RN; Fri, 11 Oct 2019 10:42:05 +0000
Date:   Fri, 11 Oct 2019 03:42:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/26] xfs: track reclaimable inodes using a LRU list
Message-ID: <20191011104205.GD12811@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-23-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-23-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> @@ -1542,6 +1545,15 @@ xfs_mount_alloc(
>  	if (!mp)
>  		return NULL;
>  
> +	/*
> +	 * The inode lru needs to be associated with the superblock shrinker,
> +	 * and like the rest of the superblock shrinker, it's memcg aware.
> +	 */
> +	if (list_lru_init_memcg(&mp->m_inode_lru, &sb->s_shrink)) {
> +		kfree(mp);
> +		return NULL;
> +	}

This collides with the mount API work from Ian, where xfs_mount_alloc
doesn't get passed an sb anymore.  It might make sense to move this
to fill_super instead.
