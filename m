Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02B31ECE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhBRRJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhBRNlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:41:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA4C061574;
        Thu, 18 Feb 2021 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+g04nYcgHm57vXiMw7FLF8aVogUiyuLVI7n97khJ/44=; b=EJwzndAej/ewZc44I7Ko3b93rN
        X2Qexg+1AiQp4lVELcVlpAxQD7ShjVbmbIo0BH4gpq2AMYbJ1KSMUMtZ5asd0p5/jz2mJU725+agV
        oPBXrfQHcesCA817pPYeaMwvDaykADLcuarbF7OBJbus1b8dyq4WHiAuBMXDXqA5/oLhyh71IGxiS
        bPsV3WAXGr78Y8IPRFsO2bC2pcQJ/VriQb+9jBWV4Ed38e+EOYNmHkaj92+hNu6BO/40MvkiBiU2B
        Vib64t8URvk5Ip47AvRSicxr/OOnND1AZ7qYL2og7vZpHWt4nXUSh9XjBHwi6UVyy4LxjkyoipA5E
        DQEUQcwA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCjX8-001iBM-2Q; Thu, 18 Feb 2021 13:40:09 +0000
Date:   Thu, 18 Feb 2021 13:39:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210218133954.GR2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 08:42:14PM +0800, Qu Wenruo wrote:
> On 2021/2/18 下午8:15, Matthew Wilcox wrote:
> > Yes, this is a known limitation.  Some vendors have gone to the trouble
> > of introducing a new page_index_t.  I'm not convinced this is a problem
> > worth solving.  There are very few 32-bit systems with this much storage
> > on a single partition (everything should work fine if you take a 20TB
> > drive and partition it into two 10TB partitions).
> What would happen if a user just tries to write 4K at file offset 16T
> fir a sparse file?
> 
> Would it be blocked by other checks before reaching the underlying fs?

/* Page cache limit. The filesystems should put that into their s_maxbytes 
   limits, otherwise bad things can happen in VM. */ 
#if BITS_PER_LONG==32
#define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX << PAGE_SHIFT)
#elif BITS_PER_LONG==64
#define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
#endif

> This is especially true for btrfs, which has its internal address space
> (and it can be any aligned U64 value).
> Even 1T btrfs can have its metadata at its internal bytenr way larger
> than 1T. (although those ranges still needs to be mapped inside the device).

Sounds like btrfs has a problem to fix.

> And considering the reporter is already using 32bit with 10T+ storage, I
> doubt if it's really not worthy.
> 
> BTW, what would be the extra cost by converting page::index to u64?
> I know tons of printk() would cause warning, but most 64bit systems
> should not be affected anyway.

No effect for 64-bit systems, other than the churn.

For 32-bit systems, it'd have some pretty horrible overhead.  You don't
just have to touch the page cache, you have to convert the XArray.
It's doable (I mean, it's been done), but it's very costly for all the
32-bit systems which don't use a humongous filesystem.  And we could
minimise that overhead with a typedef, but then the source code gets
harder to work with.
