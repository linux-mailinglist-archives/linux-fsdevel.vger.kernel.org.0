Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1CA6F3C3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 05:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjEBDEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 23:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjEBDD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 23:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00F3ABB
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 20:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682996591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBHdtbr5R5aE+/BDH3yA5uUokIjUDLmAGDFarLNOBCI=;
        b=OTFcmjFqpDWYMgDg5zoVd40EsE6mJHd6hiCftHm0qIICUB/g6eETCNl70ckIis1G+auyDu
        f7i33UuVrJ3eOaUZAhCpkCkF+DGxC+1CVDdRwXjkCIJ5y4HXewxCUevUOxEUpUxIo7hXqN
        LLOKcEbNGWtCyYf65r8gpC0WsLxRSlM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-tDBkuZFvPhScyupDgUob9w-1; Mon, 01 May 2023 23:03:02 -0400
X-MC-Unique: tDBkuZFvPhScyupDgUob9w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D63C299E742;
        Tue,  2 May 2023 03:03:02 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D6CE40F169;
        Tue,  2 May 2023 03:02:53 +0000 (UTC)
Date:   Tue, 2 May 2023 11:02:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZFB9WaRmy28zYWE4@ovpn-8-16.pek2.redhat.com>
References: <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <ZEyjY0W+8zafPAoh@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEyjY0W+8zafPAoh@mit.edu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 12:56:03AM -0400, Theodore Ts'o wrote:
> On Sat, Apr 29, 2023 at 11:16:14AM +0800, Ming Lei wrote:
> > 
> > bdi_unregister() is called in del_gendisk(), since bdi_register() has
> > to be called in add_disk() where major/minor is figured out.
> > 
> > > problem is that the block device shouldn't just *vanish*, with the
> > 
> > That looks not realistic, removable disk can be gone any time, and device
> > driver error handler often deletes disk as the last straw, and it shouldn't
> > be hard to observe such error.
> 
> It's not realistic to think that the file system can write back any
> dirty pages, sure.  At this point, the user has already yanked out the
> thumb drive, and the physical device is gone.  However, various fields
> like bdi->dev shouldn't get deinitialized until after the
> s_ops->shutdown() function has returned.

Yeah, it makes sense.

> 
> We need to give the file system a chance to shutdown any pending
> writebacks; otherwise, we could be racing with writeback happening in
> some other kernel thread, and while the I/O is certainly not going to
> suceed, it would be nice if attempts to write to the block device
> return an error, intead potentially causing the kernel to crash.
> 
> The shutdown function might need to sleep while it waits for
> workqueues or kernel threads to exit, or while it iterates over all
> inodes and clears all of the dirty bits and/or drop all of the pages
> associated with the file system on the disconnected block device.  So
> while this happens, I/O should just fail, and not result in a kernel
> BUG or oops.
> 
> Once the s_ops->shutdown() has returned, then del_gendisk can shutdown
> and/or deallocate anything it wants, and if the file system tries to
> use the bdi after s_ops->shutdown() has returned, well, it deserves
> anything it gets.
> 
> (Well, it would be nice if things didn't bug/oops in fs/buffer.c if
> there is no s_ops->shutdown() function, since there are a lot of
> legacy file systems that use the buffer cache and until we can add
> some kind of generic shutdown function to fs/libfs.c and make sure

One generic shutdown API is pretty nice, such as sb_force_shutdown() posted by Dave.

> that all of the legacy file systems that are likely to be used on a
> USB thumb drive are fixed, it would be nice if they were protected.
> At the very least, we should make that things are no worse than they
> currently are.)

Yeah, things won't be worse than now for legacy FS, given the generic
FS API could cover more generic FS cleanup, and block layer always calls
it before removing one disk.


Thanks, 
Ming

