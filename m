Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76B689909
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 13:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjBCMty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 07:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBCMtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBAC9A802
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675428542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6FdsJyiq+RmJhVtsn85gvD0158vqz/CqvwgLQNLO1g=;
        b=Px9zf6VntcLjkab2ah0tmCvNNqcXpGgYgJ7Ny+7yC8kVlaePmiFaPiLdynHLDmln8J+Hts
        LEJz1nd7gLN+MNiE0glZRCStrU1S2W46JY8iMbJclub+F/usqOV3hTRNacYWWP+zlm1Z0i
        kZOtym7sI3kNeAKmhlIgZggLUIpbq3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-4WJnpLtXOfGopeJD3IXWVg-1; Fri, 03 Feb 2023 07:48:59 -0500
X-MC-Unique: 4WJnpLtXOfGopeJD3IXWVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5B9811E6E;
        Fri,  3 Feb 2023 12:48:58 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE412166B36;
        Fri,  3 Feb 2023 12:48:58 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id B0FFE401346DD; Thu,  2 Feb 2023 23:04:11 -0300 (-03)
Date:   Thu, 2 Feb 2023 23:04:11 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>, P J P <ppandit@redhat.com>
Subject: Re: [PATCH v3] fs/buffer.c: update per-CPU bh_lru cache via RCU
Message-ID: <Y9xrm25NlbEReI7n@tpad>
References: <Y9qM68F+nDSYfrJ1@tpad>
 <20230202223653.GF937597@dread.disaster.area>
 <Y9w+b1MJ10uPDROI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9w+b1MJ10uPDROI@casper.infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:51:27PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 03, 2023 at 09:36:53AM +1100, Dave Chinner wrote:
> > On Wed, Feb 01, 2023 at 01:01:47PM -0300, Marcelo Tosatti wrote:
> > > 
> > > umount calls invalidate_bh_lrus which IPIs each
> > 
> > via invalidate_bdev(). So this is only triggered on unmount of
> > filesystems that use the block device mapping directly, right?

While executing:
mount -o loop alpine-standard-3.17.1-x86_64.iso /mnt/loop/

           mount-170027  [004] ...1 53852.213367: invalidate_bdev <-__invalidate_device
           mount-170027  [004] ...1 53852.213468: invalidate_bdev <-bdev_disk_changed.part.0
           mount-170027  [000] ...1 53852.222326: invalidate_bh_lrus <-set_blocksize
           mount-170027  [000] ...1 53852.222398: invalidate_bh_lrus <-set_blocksize
   systemd-udevd-170031  [011] ...1 53852.239794: invalidate_bh_lrus <-blkdev_flush_mapping
   systemd-udevd-170029  [004] ...1 53852.240947: invalidate_bh_lrus <-blkdev_flush_mapping

> > 
> > Or is the problem that userspace is polling the block device (e.g.
> > udisks, blkid, etc) whilst the filesystem is mounted and populating
> > the block device mapping with cached pages so invalidate_bdev()
> > always does work even when the filesystem doesn't actually use the
> > bdev mapping?
> > 
> > > CPU that has non empty per-CPU buffer_head cache:
> > > 
> > >        	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
> > > 
> > > This interrupts CPUs which might be executing code sensitive
> > > to interferences.
> > > 
> > > To avoid the IPI, free the per-CPU caches remotely via RCU.
> > > Two bh_lrus structures for each CPU are allocated: one is being
> > > used (assigned to per-CPU bh_lru pointer), and the other is
> > > being freed (or idle).
> > 
> > Rather than adding more complexity to the legacy bufferhead code,
> > wouldn't it be better to switch the block device mapping to use
> > iomap+folios and get rid of the use of bufferheads altogether?
> 
> Pretty sure ext4's journalling relies on the blockdev using
> buffer_heads.  At least, I did a conversion of blockdev to use
> mpage_readahead() and ext4 stopped working.

And its actually pretty simple: the new invalidate_bh_lrus should be
straightforward use of RCU:

1. for_each_online(cpu)
	cpu->bh_lrup = bh_lrus[1]	(or 0)

2. synchronize_rcu_expedited()		(wait for all previous users of
					 bh_lrup pointer to stop
					 referencing it).

3. free bh's in bh_lrus[0]		(or 1)



