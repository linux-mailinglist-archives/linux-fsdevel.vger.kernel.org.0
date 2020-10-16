Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2272F290592
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 14:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407852AbgJPMwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 08:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406441AbgJPMwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602852734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z0/LoGe906XEgLwCWaskAdP2HbSkFXb4cQI3gy/W0QA=;
        b=cjfIj8MlHkAuCgV9On72mjfsMvj0b+DE9VJsjp7p97CiIPd0a/wzfeIvYpxsnthlKuaKk0
        HgbIvCUHg/MzunMRs6tJDAXUYHoXxNimgoEeJBnVdJy9fzJcgRWfQTb4KlFyhLolZNMcg+
        Piap7UuBgBmjUQv4ruegietwmHwgi3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-e8fknLUeOEGE7zKF53MdjQ-1; Fri, 16 Oct 2020 08:52:10 -0400
X-MC-Unique: e8fknLUeOEGE7zKF53MdjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A26288EF31;
        Fri, 16 Oct 2020 12:52:06 +0000 (UTC)
Received: from T590 (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDB5427C21;
        Fri, 16 Oct 2020 12:51:55 +0000 (UTC)
Date:   Fri, 16 Oct 2020 20:51:51 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH v3 1/2] block: disable iopoll for split bio
Message-ID: <20201016125151.GC1218835@T590>
References: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
 <20201016091851.93728-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016091851.93728-2-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:18:50PM +0800, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-merge.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..924db7c428b4 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,20 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	/*
> +	 * bio splitting may cause more trouble for iopoll which isn't supposed
> +	 * to be used in case of big IO.
> +	 * iopoll is initially for small size, latency sensitive IO. It doesn't
> +	 * work well for big IO, especially when it needs to be split to multiple
> +	 * bios. In this case, the returned cookie of __submit_bio_noacct_mq()
> +	 * is indeed the cookie of the last split bio. The completion of *this*
> +	 * last split bio done by iopoll doesn't mean the whole original bio has
> +	 * completed. Callers of iopoll still need to wait for completion of
> +	 * other split bios.
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
> +
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }

The above change may not be enough, since caller of submit_bio() still
can call into blk_poll() even though REQ_HIPRI is cleared for splitted
bio, for avoiding this issue:

- Either we may add check in blk_poll() to only allow hctx with HCTX_TYPE_POLL
to poll,
- or return BLK_QC_T_NONE from blk_mq_submit_bio() if REQ_HIPRI is cleared.



thanks,
Ming

