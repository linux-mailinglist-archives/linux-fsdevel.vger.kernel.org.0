Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363D2201C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbgFSUMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbgFSUMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:12:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9F1C06174E;
        Fri, 19 Jun 2020 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WWsx+pVx9piQcNEsHsBJIPa3fmY2toq8I9FnSM+ryZ4=; b=hMYgCBWIu7277TNYsJDgCbquy4
        /91lhyU/OpohJkij0iD8PIz9tiWQ8qAO7Mrd8Wi9pK/n2xfpYRUFOfAWS1xXrMOO6Osk8DS9khIo4
        DETgCGskQTnR2aba10rsox2965+iEfQHZd6HwIzdJbdkKtqnNdI7r4ApPFnDJ+p8F3GHE/C/AQHaY
        ejpOCYwpIAuA1OF+iOlpcNa7x4B/dzg6OUUhWu0jkqHbicOE8LNokxW0ZgQF1CY+b7ba7wgIxPXZ9
        DCD+U5D8+R736SMLnJNW0SN25qBTzRn/5I+HJ/QTT2EO7KLwLdiSh6MQnRCkm1LNX8IlPIh6awvOO
        Q0aTU9Dg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmNN2-00050h-HG; Fri, 19 Jun 2020 20:12:16 +0000
Date:   Fri, 19 Jun 2020 13:12:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200619201216.GA8681@bombadil.infradead.org>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <BYAPR04MB49655EAA09477CB716D39C8986980@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49655EAA09477CB716D39C8986980@BYAPR04MB4965.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 07:06:19PM +0000, Chaitanya Kulkarni wrote:
> On 6/19/20 8:50 AM, Matthew Wilcox wrote:
> > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > The advantage of this patch is that we can avoid taking any filesystem
> > lock, as long as the pages being accessed are in the cache (and we don't
> > need to readahead any pages into the cache).  We also avoid an indirect
> > function call in these cases.
> 
> I did a testing with NVMeOF target file backend with buffered I/O
> enabled with your patch and setting the IOCB_CACHED for each I/O ored 
> '|' with IOCB_NOWAIT calling call_read_iter_cached() [1].
>
> The name was changed from call_read_iter() -> call_read_iter_cached() [2]).
> 
> For the file system I've used XFS and device was null_blk with memory
> backed so entire file was cached into the DRAM.

Thanks for testing!  Can you elaborate a little more on what the test does?
Are there many threads or tasks?  What is the I/O path?  XFS on an NVMEoF
device, talking over loopback to localhost with nullblk as the server?

The nullblk device will have all the data in its pagecache, but each XFS
file will have an empty pagecache initially.  Then it'll be populated by
the test, so does the I/O pattern revisit previously accessed data at all?

> Following are the performance numbers :-
> 
> IOPS/Bandwidth :-
> 
> default-page-cache:      read:  IOPS=1389k,  BW=5424MiB/s  (5688MB/s)
> default-page-cache:      read:  IOPS=1381k,  BW=5395MiB/s  (5657MB/s)
> default-page-cache:      read:  IOPS=1391k,  BW=5432MiB/s  (5696MB/s)
> iocb-cached-page-cache:  read:  IOPS=1403k,  BW=5481MiB/s  (5747MB/s)
> iocb-cached-page-cache:  read:  IOPS=1393k,  BW=5439MiB/s  (5704MB/s)
> iocb-cached-page-cache:  read:  IOPS=1399k,  BW=5465MiB/s  (5731MB/s)

That doesn't look bad at all ... about 0.7% increase in IOPS.

> Submission lat :-
> 
> default-page-cache:      slat  (usec):  min=2,  max=1076,  avg=  3.71,
> default-page-cache:      slat  (usec):  min=2,  max=489,   avg=  3.72,
> default-page-cache:      slat  (usec):  min=2,  max=1078,  avg=  3.70,
> iocb-cached-page-cache:  slat  (usec):  min=2,  max=1731,  avg=  3.70,
> iocb-cached-page-cache:  slat  (usec):  min=2,  max=2115,  avg=  3.69,
> iocb-cached-page-cache:  slat  (usec):  min=2,  max=3055,  avg=  3.70,

Average latency unchanged, max latency up a little ... makes sense,
since we'll do a little more work in the worst case.

> @@ -264,7 +267,8 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
> 
>          if (req->ns->buffered_io) {
>                  if (likely(!req->f.mpool_alloc) &&
> -                               nvmet_file_execute_io(req, IOCB_NOWAIT))
> +                               nvmet_file_execute_io(req,
> +                                       IOCB_NOWAIT |IOCB_CACHED))
>                          return;
>                  nvmet_file_submit_buffered_io(req);

You'll need a fallback path here, right?  IOCB_CACHED can get part-way
through doing a request, and then need to be finished off after taking
the mutex.

