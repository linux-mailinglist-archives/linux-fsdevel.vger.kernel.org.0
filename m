Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F511B3895
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 09:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgDVHMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 03:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgDVHMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:12:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C805CC03C1A6;
        Wed, 22 Apr 2020 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tKRtOF2AB7kDWsb4QG4ECyPWPTRwKsuq3B30I2Zar6w=; b=LZ9bLGtUvmC5vkvma34usMEMF0
        6jiVpQ+hILuiLZnqq6x6MRbc/+tNYrzzUPrlqJBt1U+ETOYrj3+DplO5+QHABaxI4jpz4JB2T8G1m
        MrURYBwCdOEUktkz4847EAey9kE2p7b+XvoC+kcvoOhIC7Yu7d561QMAYfzOIgL4kRHSvrf8UWL3J
        UloJWAMKAKVj2bFTfjlGpSvkA2Qu9L0gOnbnW9ylzL8FdE7ElCLbAwce6DqvqwS2SZZZo5bM5DCyT
        i9DwxIg+vGLTaV0Tyxl06IQntzMQp5bNRxe4+RZegfhKHwRRP9PeeT/qdoPyI0GbgQujm7/w3sLcT
        q47lG8vw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9YF-00056g-7f; Wed, 22 Apr 2020 07:12:07 +0000
Date:   Wed, 22 Apr 2020 00:12:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] blktrace: move blktrace debugfs creation to
 helper function
Message-ID: <20200422071207.GB19116@infradead.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-3-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:45:21PM +0000, Luis Chamberlain wrote:
> Move the work to create the debugfs directory used into a helper.
> It will make further checks easier to read. This commit introduces
> no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/trace/blktrace.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index ca39dc3230cb..2c6e6c386ace 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -468,6 +468,18 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
>  	}
>  }
>  
> +static struct dentry *blk_trace_debugfs_dir(struct blk_user_trace_setup *buts,
> +					    struct blk_trace *bt)
> +{
> +	struct dentry *dir = NULL;
> +
> +	dir = debugfs_lookup(buts->name, blk_debugfs_root);
> +	if (!dir)
> +		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> +

This creates an > 80 char line.  But I also think it is rather confusing
anyway, why not:

	dir = debugfs_lookup(buts->name, blk_debugfs_root);
	if (dir)
		return dir;
	bt->dir = debugfs_create_dir(buts->name, blk_debugfs_root);
	return bt->dir;
