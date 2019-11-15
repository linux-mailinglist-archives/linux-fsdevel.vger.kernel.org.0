Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32778FE30B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfKOQpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 11:45:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfKOQpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fgQvum3QLVrdMFGmAv4Ff4UwCxQGnqqjYsqE9IiuPhA=; b=ZyOFhs34r9pHccgAmsHeIpJ+M
        CS5hmHfbxoA2N9qul5IbKplnFDaP7NoGn/7tI/66OaokTW6lBMYWzBFrc8PU25S0a0b+GOQvHcQDo
        U7QhFgv0JLxn3IHNokjhE1YAHsTp7zJq+xa915sdHEtNI5Q7rzfEVa70EJ/xvALMSHiThrvFNzdcB
        1yzeFeXIr2gfZWKtXdFLmorRARkoPhYmrVzWvIn9BODS5lOCJhNCs+mlGeflsZL6J9Yq7mSgGie8B
        Q5TXN+uQI6znsZ+tLMU8cI9gKwloBOuKkNpxp0urpgwrSnVTEXSdI4uWJcODzMIzw08rZVApP16si
        W9kGfYv3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVeif-0008IN-DO; Fri, 15 Nov 2019 16:45:13 +0000
Date:   Fri, 15 Nov 2019 08:45:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/7] btrfs: basic direct I/O read operation
Message-ID: <20191115164513.GA26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:16:55AM -0600, Goldwyn Rodrigues wrote:
> +/*
> + * get_iomap: Get the block map and fill the iomap structure
> + * @pos: file position
> + * @length: I/O length
> + * @iomap: The iomap structure to fill
> + */
> +
> +static int get_iomap(struct inode *inode, loff_t pos, loff_t length,
> +		struct iomap *iomap)

The function name probably wants a btrfs_ prefix.

> +{
> +	struct extent_map *em;
> +	iomap->addr = IOMAP_NULL_ADDR;

Please add an empty line after the variable declaration.

> +static int btrfs_dio_iomap_begin(struct inode *inode, loff_t pos,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	return get_iomap(inode, pos, length, iomap);
> +}

Or do we even need the separate helper for now?
