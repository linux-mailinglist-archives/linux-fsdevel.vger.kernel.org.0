Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5424011F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 05:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgHJDLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Aug 2020 23:11:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgHJDLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597029066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EVsTKZVAhLuAKibZpYFBoxm72PqIuSfiBe/k0pSgc0c=;
        b=fBPUsgNq9vuSEfSSKsJN3hRGpeBH9zagjqCXDHLujuD7S5L2nasCbp57IQp1m3qoZqYObp
        nzwG6LtnxihVJ1/BBGEwj1rlD2Iybi+kPXonGJ0Q6rHwjDtBnE9YVqkBqQ3UtGu7hc1wOa
        YvQz4CbGUndBMngkGFi90ai1z1/ojEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-e-SOMQe-OtaQmNQwNTvuiA-1; Sun, 09 Aug 2020 23:11:02 -0400
X-MC-Unique: e-SOMQe-OtaQmNQwNTvuiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7F91005504;
        Mon, 10 Aug 2020 03:11:01 +0000 (UTC)
Received: from T590 (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F59D1001901;
        Mon, 10 Aug 2020 03:10:54 +0000 (UTC)
Date:   Mon, 10 Aug 2020 11:10:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Very slow qemu device access
Message-ID: <20200810031049.GA2202641@T590>
References: <20200807174416.GF17456@casper.infradead.org>
 <20200809024005.GC2134904@T590>
 <20200809142522.GI17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809142522.GI17456@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 09, 2020 at 03:25:22PM +0100, Matthew Wilcox wrote:
> On Sun, Aug 09, 2020 at 10:40:05AM +0800, Ming Lei wrote:
> > Hello Matthew,
> > 
> > On Fri, Aug 07, 2020 at 06:44:16PM +0100, Matthew Wilcox wrote:
> > > 
> > > Everything starts going very slowly after this commit:
> > > 
> > > commit 37f4a24c2469a10a4c16c641671bd766e276cf9f (refs/bisect/bad)
> > > Author: Ming Lei <ming.lei@redhat.com>
> > > Date:   Tue Jun 30 22:03:57 2020 +0800
> > > 
> > >     blk-mq: centralise related handling into blk_mq_get_driver_tag
> > 
> > Yeah, the above is one known bad commit, which is reverted in
> > 4e2f62e566b5 ("Revert "blk-mq: put driver tag when this request is completed")
> > 
> > Finally the fixed patch of 'blk-mq: centralise related handling into blk_mq_get_driver_tag'
> > is merged as 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag").
> > 
> > So please test either 4e2f62e566b5 or 568f27006577 and see if there is
> > such issue.
> 
> 4e2f62e566b5 is good
> 568f27006577 is bad

Please try the following patch, and we shouldn't take flush request
account into driver tag allocation, because it always shares the
data request's tag:

From d508415eee08940ff9c78efe0eddddf594afdb94 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 10 Aug 2020 11:06:15 +0800
Subject: [PATCH] block: don't double account of flush request's driver tag

In case of none scheduler, we share data request's driver tag for
flush request, so have to mark the flush request as INFLIGHT for
avoiding double account of this driver tag.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Fixes: 568f27006577 ("blk-mq: centralise related handling into blk_mq_get_driver_tag")
Reported-by: Matthew Wilcox <willy@infradead.org>
---
 block/blk-flush.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 6e1543c10493..53abb5c73d99 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -308,9 +308,16 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_ctx = first_rq->mq_ctx;
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
-	if (!q->elevator)
+	if (!q->elevator) {
 		flush_rq->tag = first_rq->tag;
-	else
+
+		/*
+		 * We borrow data request's driver tag, so have to mark
+		 * this flush request as INFLIGHT for avoiding double
+		 * account of this driver tag
+		 */
+		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
+	} else
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
-- 
2.25.2

 

thanks,
Ming

