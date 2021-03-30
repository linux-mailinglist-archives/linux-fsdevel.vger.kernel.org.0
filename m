Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E824C34E664
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhC3Lf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhC3LfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:35:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F1C061574;
        Tue, 30 Mar 2021 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zbP8yBEd7Uhhavsg0dmtwHvg0HGNqmxGK6FuyZAJstc=; b=P4K8RN0v1//4jVOojrGbvKAggI
        SIOgFoXbhwI35UIn8n0SEearjP5QdDJz+G2lSLBRhU26sVkCdZDiVIgYRUoN+fenMs1iKCD35X9DJ
        xLhbgpM8SGEAw685ema1JLfth5s1nQoRdZcIV6RDviiorH0P622cQLpPIXjidxVDeCj0503f5E1xy
        0lO4gbzYcEkwam4e6wDCW+BABDh9QfgJq/tQLonYpHw68uxTxtuyHVwY3w5lCxKDKY9CpkFuf9E+M
        xtTxI5/4hU0ihvKUjdp/K1jqqFz+VMVM8VddouUfSCgVU3B3ZRMYfXDe47lOc4vGWoA4aQvKSopwW
        Cia6qQ8g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRCdz-002wzT-B1; Tue, 30 Mar 2021 11:34:52 +0000
Date:   Tue, 30 Mar 2021 12:34:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: fix obtain a reference to a freeing memcg css
Message-ID: <20210330113447.GM351017@casper.infradead.org>
References: <20210330092933.81311-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330092933.81311-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 05:29:33PM +0800, Muchun Song wrote:
> +++ b/fs/fs-writeback.c
> @@ -506,8 +506,10 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	/* find and pin the new wb */
>  	rcu_read_lock();
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> -	if (memcg_css)
> +	if (memcg_css && css_tryget(memcg_css)) {
>  		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +		css_put(memcg_css);
> +	}
>  	rcu_read_unlock();
>  	if (!isw->new_wb)
>  		goto out_free;

This seems like an unnecessary use of GFP_ATOMIC.  Why not:

	rcu_read_lock();
	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
	if (memcg_css && !css_tryget(memcg_css))
		memcg_css = NULL;
	rcu_read_unlock();
	if (!memcg_css)
		goto out_free;
	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
	css_put(memcg_css);
	if (!isw->new_wb)
		goto out_free;

(inode_switch_wbs can't be called in interrupt context because it takes
inode->i_lock, which is not interrupt-safe.  it's not clear to me whether
it is allowed to start IO or do FS reclaim, given where it is in the
I/O path, so i went with GFP_NOIO rather than GFP_KERNEL)

(also there's another use of GFP_ATOMIC in that function, which is
probably wrong)
