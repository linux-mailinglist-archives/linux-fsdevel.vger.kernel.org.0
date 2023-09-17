Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBF7A3ECA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 01:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjIQXPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 19:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjIQXPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 19:15:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E39611B;
        Sun, 17 Sep 2023 16:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nv2p7fEiwt/74JfgCxfcZvTioovA33E8lFlj3CEAEjY=; b=vlYcZaSanHANq0jx23+xIJAUtb
        R+pJ1pDaY+TTfzmF/RZ7PEagoPruiVqP4bwz2L2G1nj6+zWT0Rfp3Yvon+qVu6poFMFKsjrXddv8p
        WKS/ZWK5SyBy7N+ldrYp3SXfpxAWyHNkJ05q/35j378ajKV5ZzgvyeZjPRFoUbV+B+NcwO5reZfqX
        5rAJjkm1CY8Rxdwkl4CQfn4Gx1/guKtGIK7lMCMzeS93PQhtEVeWBcXtgChNmxKeonN0fL6FZQ/Rs
        EkfoQi8/5LLxOtKmMGvQ+3ZudnmemS5E0EmaDei23ujrQTru96J4cafezjnM83wH83/5ThFPextK8
        w2/sgiAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qi0yW-007KHa-Tb; Sun, 17 Sep 2023 23:14:48 +0000
Date:   Mon, 18 Sep 2023 00:14:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, hch@infradead.org,
        djwong@kernel.org, dchinner@redhat.com, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 00/10] bdev: LBS devices support to coexist with
 buffer-heads
Message-ID: <ZQeIaN2WC+whc/OP@casper.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <ZQd/7RYfDZgvR0n2@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQd/7RYfDZgvR0n2@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:38:37AM +1000, Dave Chinner wrote:
> On Fri, Sep 15, 2023 at 02:32:44PM -0700, Luis Chamberlain wrote:
> > LBS devices. This in turn allows filesystems which support bs > 4k to be
> > enabled on a 4k PAGE_SIZE world on LBS block devices. This alows LBS
> > device then to take advantage of the recenlty posted work today to enable
> > LBS support for filesystems [0].
> 
> Why do we need LBS devices to support bs > ps in XFS?

It's the other way round -- we need the support in the page cache to
reject sub-block-size folios (which is in the other patches) before we
can sensibly talk about enabling any filesystems on top of LBS devices.
Even XFS, or for that matter ext2 which support 16k block sizes on
CONFIG_PAGE_SIZE_16K (or 64K) kernels need that support first.

[snipping the parts I agree with; this should not be the first you're
hearing about a format change to XFS]

> > There might be a better way to do this than do deal with the switching
> > of the aops dynamically, ideas welcomed!
> 
> Is it even safe to switch aops dynamically? We know there are
> inherent race conditions in doing this w.r.t. mmap and page faults,
> as the write fault part of the processing is directly dependent
> on the page being correctly initialised during the initial
> population of the page data (the "read fault" side of the write
> fault).
> 
> Hence it's not generally considered safe to change aops from one
> mechanism to another dynamically. Block devices can be mmap()d, but
> I don't see anything in this patch set that ensures there are no
> other users of the block device when the swaps are done. What am I
> missing?

We need to evict all pages from the page cache before switching aops to
prevent misinterpretation of folio->private.  If switching aops is even
the right thing to do.  I don't see the problem with allowing buffer heads
on block devices, but I haven't been involved with the discussion here.
