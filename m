Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267E33B0B89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhFVRjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFVRjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 13:39:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834A0C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nQCqxnM73V29A4V7UB3NTuQMxcsvROpIgasfOwps6yA=; b=Nf+roimG7RiELIHWIphRFWUdhh
        wYsDHlEJgHOu3f4lA7gUxnog0VeZluRWY7xdJMMfhYqB2FAKqHBs84dJ2Vf76P8bnt3I+n4dVYeWP
        thZjey9SYjev//vfllF514H7neiXLkEwlh+93f0cAn7aUwLjXAPsNZZAGZO6poYe1caBKOKhB5sPu
        t+6KKmkn+PTNBQXrKLLDu8QiPOcOc5o8Zj9XxqxvXe+XbOqtef/c7UzRoMQFmTUGH1WxtQDS1c55H
        4ZkOKQ8K8kZH/Whlzva/hDrZBuWK5dSWozkRzd4WBBaJXw22OXfPtaUkOgpP7pRA8nOYty7e/srya
        myQnAeIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvkKJ-00EYnn-Sp; Tue, 22 Jun 2021 17:36:51 +0000
Date:   Tue, 22 Jun 2021 18:36:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Philipp Falk <philipp.falk@thinkparq.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Throughput drop and high CPU load on fast NVMe drives
Message-ID: <YNIfq8dCLEu/Wkc0@casper.infradead.org>
References: <YNIaztBNK+I5w44w@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIaztBNK+I5w44w@xps13>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 07:15:58PM +0200, Philipp Falk wrote:
> We are facing a performance issue on XFS and other filesystems running on
> fast NVMe drives when reading large amounts of data through the page cache
> with fio.
> 
> Streaming read performance starts off near the NVMe hardware limit until
> around the total size of system memory worth of data has been read.
> Performance then drops to around half the hardware limit and CPU load
> increases significantly. Using perf, we were able to establish that most of
> the CPU load is caused by a spin lock in native_queued_spin_lock_slowpath:
[...]
> When direct I/O is used, hardware level read throughput is sustained during
> the entire experiment and CPU load stays low. Threads stay in D state most
> of the time.
> 
> Very similar results are described around half-way through this article
> [1].
> 
> Is this a known issue with the page cache and high throughput I/O? Is there
> any tuning that can be applied to get around the CPU bottleneck? We have
> tried disabling readahead on the drives, which lead to very bad throughput
> (~-90%). Various other scheduler related tuning was tried as well but the
> results were always similar.

Yes, this is a known issue.  Here's what's happening:

 - The machine hits its low memory watermarks and starts trying to
   reclaim.  There's one kswapd per node, so both nodes go to work
   trying to reclaim memory (each kswapd tries to handle the memory
   attached to its node)
 - But all the memory is allocated to the same file, so both kswapd
   instances try to remove the pages from the same file, and necessarily
   contend on the same spinlock.
 - The process trying to stream the file is also trying to acquire this
   spinlock in order to add its newly-allocated pages to the file.

What you can do is force the page cache to only allocate memory from the
local node.  That means this workload will only use half the memory in
the machine, but it's a streaming workload, so that shouldn't matter?

The only problem is, I'm not sure what the user interface is to make
that happen.  Here's what it looks like inside the kernel:

        if (cpuset_do_page_mem_spread()) {
                unsigned int cpuset_mems_cookie;
                do {
                        cpuset_mems_cookie = read_mems_allowed_begin();
                        n = cpuset_mem_spread_node();
                        page = __alloc_pages_node(n, gfp, 0);
                } while (!page && read_mems_allowed_retry(cpuset_mems_cookie));

so it's something to do with cpusets?

