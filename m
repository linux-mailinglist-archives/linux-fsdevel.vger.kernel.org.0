Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42A62F0A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 01:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbhAKATW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Jan 2021 19:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAKATW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Jan 2021 19:19:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD43C061786;
        Sun, 10 Jan 2021 16:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rRfpg+NyeZkkosMsL/GGMa7wDSV2EgRrAhugKvP5dDc=; b=Cmobwypg8XD0xhRhTMPT42v6yB
        JpO7FS8VhJnwoM1xHAgY4CdiW7p8pAr5BU04gfn0jxSV+ZUs4lM7dpuWyqdfToqwtXYOka2xbcp6o
        ekdFuKVrTVJppbf2qKHuvmaAdWpcpnMPcnmD8daVivpg/EKIEhLbAFBD8+dQ5P7Kduf29K4q4KBpB
        O3jZNpHmE2JNSoNCbJGIW0efQA2rFOi4bSHwRcVmLgq3bVf9RVXZqHbMZtvbAZmYor53RRtYjeAU8
        TVjFldcEI1vdSFednSXxNpES+myoShOyo4NL8vjm4Emj2g4c39xFX6e7mzuSzv/jO7f6tBC1EZ92l
        Wpzw+lBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kykuL-002VOv-NN; Mon, 11 Jan 2021 00:18:06 +0000
Date:   Mon, 11 Jan 2021 00:18:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Wang Jianchao <jianchao.wan9@gmail.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh" <rajesh.tadakamadla@hpe.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Subject: Re: Expense of read_iter
Message-ID: <20210111001805.GD35215@casper.infradead.org>
References: <alpine.LRH.2.02.2101061245100.30542@file01.intranet.prod.int.rdu2.redhat.com>
 <20210107151125.GB5270@casper.infradead.org>
 <alpine.LRH.2.02.2101071110080.30654@file01.intranet.prod.int.rdu2.redhat.com>
 <20210110061321.GC35215@casper.infradead.org>
 <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2101101458420.7366@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 10, 2021 at 04:19:15PM -0500, Mikulas Patocka wrote:
> I put counters into vfs_read and vfs_readv.
> 
> After a fresh boot of the virtual machine, the counters show "13385 4". 
> After a kernel compilation they show "4475220 8".
> 
> So, the readv path is almost unused.
> 
> My reasoning was that we should optimize for the "read" path and glue the 
> "readv" path on the top of that. Currently, the kernel is doing the 
> opposite - optimizing for "readv" and glueing "read" on the top of it.

But it's not about optimising for read vs readv.  read_iter handles
a host of other cases, such as pread(), preadv(), AIO reads, splice,
and reads to in-kernel buffers.

Some device drivers abused read() vs readv() to actually return different
information, depending which you called.  That's why there's now a
prohibition against both.

So let's figure out how to make iter_read() perform well for sys_read().
