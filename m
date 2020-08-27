Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F8253BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 03:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgH0B7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgH0B7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:59:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58216C061364;
        Wed, 26 Aug 2020 18:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=beWNVzgZ354ZbYDM6UV+ImYXsPQb9Cek38D6FY5zogI=; b=kHlQVYZ0dfhndpz3lruubqFXd7
        kDM4vgr2g4JnOsZ5zEZYuY5WSd+PYVvD7KvsZJfnk4TnSzTYv1ADR1vWWrJRseC/g7vqWZP/I85Qp
        hqbr5AuxYNCSNfrz+wVO/13obIwhIVlPsQkFwqOqV11exTPtkUhG+/6URj82GigTXKL4warHFqgWa
        d8Ii9JN19GyA4t+ZjCnZBT3YQ6k2cKDICQ3Ci4SBGMcXDMTfxYkzfU7dcYbBuWbrMUaNgWZRLpZto
        POa4gXz8hOzblVz49gvxAd6+rTKpbYWChHoRAvjmikEj1ZBMHiSIxEOxFhCsCtw5Fj+5hicQ4jGCt
        klwkeiHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kB7Bl-0006Wb-O0; Thu, 27 Aug 2020 01:58:53 +0000
Date:   Thu, 27 Aug 2020 02:58:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 2/2] xfs: avoid transaction reservation recursion
Message-ID: <20200827015853.GA14765@casper.infradead.org>
References: <20200827013444.24270-1-laoar.shao@gmail.com>
 <20200827013444.24270-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827013444.24270-3-laoar.shao@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:34:44AM +0800, Yafang Shao wrote:
> @@ -1500,9 +1500,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
>  
>  	/*
>  	 * Given that we do not allow direct reclaim to call us, we should
> -	 * never be called in a recursive filesystem reclaim context.
> +	 * never be called while in a filesystem transaction.
>  	 */
> -	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
> +	if (WARN_ON_ONCE(wbc->fstrans_recursion))
>  		goto redirty;

Erm, Dave said:

> I think we should just remove
> the check completely from iomap_writepage() and move it up into
> xfs_vm_writepage() and xfs_vm_writepages().

ie everywhere you set this new bit, just check current->journal_info.
