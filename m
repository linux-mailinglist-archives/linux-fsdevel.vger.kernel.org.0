Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7A442708
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 07:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKBGV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhKBGV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:21:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2654C061714;
        Mon,  1 Nov 2021 23:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KdIhbeTBoLRUYR2IAPFmlM4VoN/TtUZV3//iIpzahwM=; b=gEliM4LypGip4U+QMQe7n5WPg+
        8eF6rmeTZnEHXk8zsn5+LTsHo0ig9kZOyN4e+FFEa6YZuPTo4iSXZQcldSvGmvKpllSlorZqwbgkT
        HKffEXvbAOcbwfsYA2+uU33ejwxMPoLiSRNY+d4hmrEY3vg4fS1/7E6nKilyDH/PiQvr7n9mSYnNs
        jikQKAvqUFNTxA184hcFBlOilNj0XyLf3a0Uy2RsW8ZONVAYEDmx+GxVHvRm0MqozQH3lYB1ZPVt5
        LxffLGlx8Gc5jttGyxDUerEAc3tqqv3LLUkq8lU5Hg3zMTTpnUOVYjoNmero8H6QeZnp+UkWZVzeg
        THCpn1ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhn8K-000eBZ-KX; Tue, 02 Nov 2021 06:18:56 +0000
Date:   Mon, 1 Nov 2021 23:18:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <YYDYUCCiEPXhZEw0@infradead.org>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028002451.GB2237511@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 05:24:51PM -0700, Darrick J. Wong wrote:
> ...so would you happen to know if anyone's working on solving this
> problem for us by putting the memory controller in charge of dealing
> with media errors?

The only one who could know is Intel..

> The trouble is, we really /do/ want to be able to (re)write the failed
> area, and we probably want to try to read whatever we can.  Those are
> reads and writes, not {pre,f}allocation activities.  This is where Dave
> and I arrived at a month ago.
> 
> Unless you'd be ok with a second IO path for recovery where we're
> allowed to be slow?  That would probably have the same user interface
> flag, just a different path into the pmem driver.

Which is fine with me.  If you look at the API here we do have the
RWF_ API, which them maps to the IOMAP API, which maps to the DAX_
API which then gets special casing over three methods.

And while Pavel pointed out that he and Jens are now optimizing for
single branches like this.  I think this actually is silly and it is
not my point.

The point is that the DAX in-kernel API is a mess, and before we make
it even worse we need to sort it first.  What is directly relevant
here is that the copy_from_iter and copy_to_iter APIs do not make
sense.  Most of the DAX API is based around getting a memory mapping
using ->direct_access, it is just the read/write path which is a slow
path that actually uses this.  I have a very WIP patch series to try
to sort this out here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-devirtualize

But back to this series.  The basic DAX model is that the callers gets a
memory mapping an just works on that, maybe calling a sync after a write
in a few cases.  So any kind of recovery really needs to be able to
work with that model as going forward the copy_to/from_iter path will
be used less and less.  i.e. file systems can and should use
direct_access directly instead of using the block layer implementation
in the pmem driver.  As an example the dm-writecache driver, the pending
bcache nvdimm support and the (horribly and out of tree) nova file systems
won't even use this path.  We need to find a way to support recovery
for them.  And overloading it over the read/write path which is not
the main path for DAX, but the absolutely fast path for 99% of the
kernel users is a horrible idea.

So how can we work around the horrible nvdimm design for data recovery
in a way that:

   a) actually works with the intended direct memory map use case
   b) doesn't really affect the normal kernel too much

?
