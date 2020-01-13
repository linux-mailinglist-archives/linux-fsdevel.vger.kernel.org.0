Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DABB1139C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgAMWKs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:10:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgAMWKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iiatjSK+rStDx5yHwZUI6kusSNUrnB2tu8ZxYcMa6Lw=; b=V+o4mHVpSIrVUgND6g6d6216j
        C/6cpAwvBjIA0PgMlkugnc3UZYigzupLZAfBEQKWwzJAjylcHqfQrab1Hp5yOv9V15mS2Sz/VXK+u
        nxuY2JiqZGHsPJ/XF5b5tAFrNS5TloZ+6y0sirsXq9QHxShL0/G+IDekM6dhutfrQv4hHzbvBrH1E
        EBe6Jv0SGbqq4F0S8Qv4/LegR5bXwvDxO7mlzZaGvh+Z849fpOnZ2GJy+hX78sb4XPpOuwX3+fblh
        YqtKdyRdBgK0FSw3Feb5gN5g738GiphuM1dK0T0yQYVCsolDALtj7D/wPxBuGqiaKBQnF5e6jIDQi
        PIy6SAHWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir7v5-0007Xf-TZ; Mon, 13 Jan 2020 22:10:47 +0000
Date:   Mon, 13 Jan 2020 14:10:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200113221047.GB18216@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
> > On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
> >> This is true, I didn't explain that part well ;)  Depending on 
> >> compression etc we might end up poking the xarray inside the actual IO 
> >> functions, but the main difference is that btrfs is building a single 
> >> bio.  You're moving the plug so you'll merge into single bio, but I'd 
> >> rather build 2MB bios than merge them.
> > 
> > Why don't we store a bio pointer inside the plug?  You're opencoding that,
> > iomap is opencoding that, and I bet there's a dozen other places where
> > we pass a bio around.  Then blk_finish_plug can submit the bio.
> 
> Plugs aren't necessarily a bio, they can be callbacks too.

I'm thinking something as simple as this:

@@ -1711,6 +1711,7 @@ void blk_start_plug(struct blk_plug *plug)
 
        INIT_LIST_HEAD(&plug->mq_list);
        INIT_LIST_HEAD(&plug->cb_list);
+       plug->bio = NULL;
        plug->rq_count = 0;
        plug->multiple_queues = false;
 
@@ -1786,6 +1787,8 @@ void blk_finish_plug(struct blk_plug *plug)
 {
        if (plug != current->plug)
                return;
+       if (plug->bio)
+               submit_bio(plug->bio);
        blk_flush_plug_list(plug, false);
 
        current->plug = NULL;
@@ -1160,6 +1160,7 @@ extern void blk_set_queue_dying(struct request_queue *);
 struct blk_plug {
        struct list_head mq_list; /* blk-mq requests */
        struct list_head cb_list; /* md requires an unplug callback */
+       struct bio *bio;
        unsigned short rq_count;
        bool multiple_queues;
 };

with accessors to 'get_current_bio()' and 'set_current_bio()'.
