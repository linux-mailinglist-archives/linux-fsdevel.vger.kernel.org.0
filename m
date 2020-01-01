Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69F12DF0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2020 14:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgAANx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jan 2020 08:53:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39886 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgAANx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jan 2020 08:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577886835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwvLbKIvcaSue/UhCU7AMwSy+1EPkPc59XQUGBzzxDI=;
        b=iEEMJN4CHDBXwuQ3xAdvZuk7GFDMaHDbpv/TeojaKLLSzg09gaqsyyr4qrgCOXBC4sSxPo
        TuzGJ2bm4kWCTmKHOKkMHqqysnapw/B1rWdlT4GMoyVfOxGR5RwQgD9XTTg5Pyuw2IXwrV
        duFhibTOnTfmgKYrP7fe4FcxQGSAnDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-ZpcFGxb5NUiWVoSkctzOjg-1; Wed, 01 Jan 2020 08:53:52 -0500
X-MC-Unique: ZpcFGxb5NUiWVoSkctzOjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDCA8800D41;
        Wed,  1 Jan 2020 13:53:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5917D5C3FD;
        Wed,  1 Jan 2020 13:53:35 +0000 (UTC)
Date:   Wed, 1 Jan 2020 21:53:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andrea Vai <andrea.vai@unipv.it>,
        "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        USB list <linux-usb@vger.kernel.org>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: slow IO on USB media
Message-ID: <20200101135331.GA7688@ming.t460p>
References: <20191223162619.GA3282@mit.edu>
 <4c85fd3f2ec58694cc1ff7ab5c88d6e11ab6efec.camel@unipv.it>
 <20191223172257.GB3282@mit.edu>
 <bb5d395fe47f033be0b8ed96cbebf8867d2416c4.camel@unipv.it>
 <20191223195301.GC3282@mit.edu>
 <20191224012707.GA13083@ming.t460p>
 <20191225051722.GA119634@mit.edu>
 <20191226022702.GA2901@ming.t460p>
 <20191226033057.GA10794@mit.edu>
 <20200101074310.10904-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101074310.10904-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 01, 2020 at 03:43:10PM +0800, Hillf Danton wrote:
> 
> On Thu, 26 Dec 2019 16:37:06 +0800 Ming Lei wrote:
> > On Wed, Dec 25, 2019 at 10:30:57PM -0500, Theodore Y. Ts'o wrote:
> > > On Thu, Dec 26, 2019 at 10:27:02AM +0800, Ming Lei wrote:
> > > > Maybe we need to be careful for HDD., since the request count in scheduler
> > > > queue is double of in-flight request count, and in theory NCQ should only
> > > > cover all in-flight 32 requests. I will find a sata HDD., and see if
> > > > performance drop can be observed in the similar 'cp' test.
> > >
> > > Please try to measure it, but I'd be really surprised if it's
> > > significant with with modern HDD's.
> > 
> > Just find one machine with AHCI SATA, and run the following xfs
> > overwrite test:
> > 
> > #!/bin/bash
> > DIR=$1
> > echo 3 > /proc/sys/vm/drop_caches
> > fio --readwrite=write --filesize=5g --overwrite=1 --filename=$DIR/fiofile \
> >         --runtime=60s --time_based --ioengine=psync --direct=0 --bs=4k
> > 		--iodepth=128 --numjobs=2 --group_reporting=1 --name=overwrite
> > 
> > FS is xfs, and disk is LVM over AHCI SATA with NCQ(depth 32), because the
> > machine is picked up from RH beaker, and it is the only disk in the box.
> > 
> > #lsblk
> > NAME                            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> > sda                               8:0    0 931.5G  0 disk
> > =E2=94=9C=E2=94=80sda1                            8:1    0     1G  0 part /boot
> > =E2=94=94=E2=94=80sda2                            8:2    0 930.5G  0 part
> >   =E2=94=9C=E2=94=80rhel_hpe--ml10gen9--01-root 253:0    0    50G  0 lvm  /
> >   =E2=94=9C=E2=94=80rhel_hpe--ml10gen9--01-swap 253:1    0   3.9G  0 lvm  [SWAP]
> >   =E2=94=94=E2=94=80rhel_hpe--ml10gen9--01-home 253:2    0 876.6G  0 lvm  /home
> > 
> > 
> > kernel: 3a7ea2c483a53fc("scsi: provide mq_ops->busy() hook") which is
> > the previous commit of f664a3cc17b7 ("scsi: kill off the legacy IO path").
> > 
> >             |scsi_mod.use_blk_mq=N |scsi_mod.use_blk_mq=Y |
> > -----------------------------------------------------------
> > throughput: |244MB/s               |169MB/s               |
> > -----------------------------------------------------------
> > 
> > Similar result can be observed on v5.4 kernel(184MB/s) with same test
> > steps.
> 
> 
> The simple diff makes direct issue of requests take pending requests
> also into account and goes the nornal enqueue-and-dequeue path if any
> pending requests exist.
> 
> Then it sorts requests regardless of the number of hard queues in a
> bid to make requests as sequencial as they are. Let's see if the
> added sorting cost can make any sense.
> 
> --->8---
> 
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -410,6 +410,11 @@ run:
>  		blk_mq_run_hw_queue(hctx, async);
>  }
>  
> +static inline bool blk_mq_sched_hctx_has_pending_rq(struct blk_mq_hw_ctx *hctx)
> +{
> +	return sbitmap_any_bit_set(&hctx->ctx_map);
> +}
> +
>  void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
>  				  struct blk_mq_ctx *ctx,
>  				  struct list_head *list, bool run_queue_async)
> @@ -433,7 +438,8 @@ void blk_mq_sched_insert_requests(struct
>  		 * busy in case of 'none' scheduler, and this way may save
>  		 * us one extra enqueue & dequeue to sw queue.
>  		 */
> -		if (!hctx->dispatch_busy && !e && !run_queue_async) {
> +		if (!hctx->dispatch_busy && !e && !run_queue_async &&
> +		    !blk_mq_sched_hctx_has_pending_rq(hctx)) {
>  			blk_mq_try_issue_list_directly(hctx, list);
>  			if (list_empty(list))
>  				goto out;
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1692,7 +1692,7 @@ void blk_mq_flush_plug_list(struct blk_p
>  
>  	list_splice_init(&plug->mq_list, &list);
>  
> -	if (plug->rq_count > 2 && plug->multiple_queues)
> +	if (plug->rq_count > 1)
>  		list_sort(NULL, &list, plug_rq_cmp);
>  
>  	plug->rq_count = 0;

I guess you may not understand the reason, and the issue is related
with neither MQ nor plug.

AHCI/SATA is single queue drive, and for HDD. IO throughput is very
sensitive with IO order in case of sequential IO.

Legacy IO path supports ioc batching and BDI queue congestion. When
there are more than one writeback IO paths, there may be only one
active IO submission path, meantime others are blocked attributed to
ioc batching, so writeback IO is still dispatched to disk in strict
IO order.

But ioc batching and BDI queue congestion is killed when converting to
blk-mq.

Please see the following IO trace with legacy IO request path:

https://lore.kernel.org/linux-scsi/f82fd5129e3dcacae703a689be60b20a7fedadf6.camel@unipv.it/2-log_ming_20191128_182751.zip


Thanks,
Ming

