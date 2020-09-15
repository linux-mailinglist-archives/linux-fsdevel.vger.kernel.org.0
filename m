Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50E226A5C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIONBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgIONA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEAFC061788;
        Tue, 15 Sep 2020 06:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lkoNIbONVqF9nSz1AszaHz6Z+J30dE2f9beUAwTaZcc=; b=i5K3OE7SFBGKzf1l2VQ+66Mgjc
        bAqGc9muaSLpQwTotBgO8IOZXrdplnjJkOelvBrS7Y2om70xTTevSBiI6srw7p9lO9YWSvXzR+3aT
        OI0QDSkVCwnpLyigJD4S+HMgv2Hke5iB274kwKSnVnHs6Tfm7OVNa92ecpFHVQ2+4HiHuVcgImdJs
        TXeO+8wDrn+X0IXPb0gSeid49s6FLwffFpoQnnZVT2JdkC1NFDBck5+NFyFV+oB6Y8fJg/6gb5a6Y
        k7dZT5Sv2ITb0v2FhsM2Wy21Yj1Zbj1lPhtsdJC4uBZQ/oE4XqI2iJLFZO0e+EVJVMelT+C1QfdeK
        4dM8T94Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIAZA-0000EE-Mf; Tue, 15 Sep 2020 13:00:12 +0000
Date:   Tue, 15 Sep 2020 14:00:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
Message-ID: <20200915130012.GC5449@casper.infradead.org>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:34:41AM -0400, Mikulas Patocka wrote:
> - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses 
> buffer cache for the mapping. The buffer cache slows does fsck by a factor 
> of 5 to 10. Could it be possible to change the kernel so that it maps DAX 
> based block devices directly?

Oh, because fs/block_dev.c has:
        .mmap           = generic_file_mmap,

I don't see why we shouldn't have a blkdev_mmap modelled after
ext2_file_mmap() with the corresponding blkdev_dax_vm_ops.
