Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1766C22E764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 10:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgG0IOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 04:14:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbgG0IOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595837672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IY4OegseFyVH/DUlzMVrRnb9yo4KDwtMwLRH1768Rd8=;
        b=guslZ+Ni2M3J7t48CGAu+kkMb3zpyn6p03FLJUBEpN3qeBnvvD5pF5I00nSCPtnbkxbIPx
        snWvbVRqguboIVtbE1a25lo8dn3hLG0w+eaynMsz7MjI7XJsgoeF9Z6qlq3nY8KYkE+imW
        fq4g1BZD2GNAA5rhxjHTKn+YsJHGHEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-gh-Hn-vwNNedtzwxAzImGw-1; Mon, 27 Jul 2020 04:14:30 -0400
X-MC-Unique: gh-Hn-vwNNedtzwxAzImGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074C8805723;
        Mon, 27 Jul 2020 08:14:28 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E9896FEC6;
        Mon, 27 Jul 2020 08:14:20 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:14:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fs-writeback.c: not WARN on unregistered BDI
Message-ID: <20200727081416.GB1146643@T590>
References: <20200611072251.474246-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611072251.474246-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:22:51PM +0800, Ming Lei wrote:
> BDI is unregistered from del_gendisk() which is usually done in device's
> release handler from device hotplug or error handling context, so BDI
> can be unregistered anytime.
> 
> It should be normal for __mark_inode_dirty to see un-registered BDI,
> so kill the WARN().
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: Dave Chinner <dchinner@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  fs/fs-writeback.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a605c3dddabc..5e718580d4bf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2318,10 +2318,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  			wb = locked_inode_to_wb_and_lock_list(inode);
>  
> -			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
> -			     !test_bit(WB_registered, &wb->state),
> -			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
> -
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
>  				inode->dirtied_time_when = jiffies;

Hello Alexander,

Could you merge this patch if you are fine? 

Thanks,
Ming

