Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203AD74D96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 13:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfGYLyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 07:54:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfGYLyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vft2ETrgGQMFjnBPVXnK+szXAKyWSwkuzQojY/OB7mk=; b=L1ggSMImEzygnsESy11qvIbQD
        qW34SLS9Z6cvIvcVNgL99uNJUh0dqkIO5BPDr41LX/WyBOfrnAnOXpiHBTIyTTHEPAFRM7zfw1Kt7
        JHhZjMhgQrxFBxKfbMqAT5zx1RI9GrLS//QQ0Ykp5uGtsg/Y0m9DScZjRv7GM6tngHHTowdVpNANh
        n8Q4A4FYHvCdfOHYGyTbEAslF3ZdNNVHDcCS68O9tAH9xOc4tk7HcXkaaei2iv/HJ5HOGWjbEesrA
        kkfZnUKVHMAcuaEqK+bffCLSBU2KhN+F3EoRtItQ3hj4rpiWL2Nfmd96uaJ5fMmgBZXYZvWMqAOi6
        IN+Iskzng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hqcKY-0004Ea-Uf; Thu, 25 Jul 2019 11:54:42 +0000
Date:   Thu, 25 Jul 2019 04:54:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Message-ID: <20190725115442.GA15733@infradead.org>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725093358.30679-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:33:58PM +0900, Damien Le Moal wrote:
> +	gfp_t gfp_mask;
> +
>  	switch (ext4_inode_journal_mode(inode)) {
>  	case EXT4_INODE_ORDERED_DATA_MODE:
>  	case EXT4_INODE_WRITEBACK_DATA_MODE:
> @@ -4019,6 +4019,14 @@ void ext4_set_aops(struct inode *inode)
>  		inode->i_mapping->a_ops = &ext4_da_aops;
>  	else
>  		inode->i_mapping->a_ops = &ext4_aops;
> +
> +	/*
> +	 * Ensure all page cache allocations are done from GFP_NOFS context to
> +	 * prevent direct reclaim recursion back into the filesystem and blowing
> +	 * stacks or deadlocking.
> +	 */
> +	gfp_mask = mapping_gfp_mask(inode->i_mapping);
> +	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));

This looks like something that could hit every file systems, so
shouldn't we fix this in common code?  We could also look into
just using memalloc_nofs_save for the page cache allocation path
instead of the per-mapping gfp_mask.

>  }
>  
>  static int __ext4_block_zero_page_range(handle_t *handle,
> -- 
> 2.21.0
> 
---end quoted text---
