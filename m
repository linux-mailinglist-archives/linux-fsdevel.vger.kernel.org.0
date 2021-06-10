Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3BB3A31B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 19:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFJRJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhFJRJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:09:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89791C061760;
        Thu, 10 Jun 2021 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=UeDB78cqlh0ABfZXEzycqO5HqcebSm6GINH+C9GPq1s=; b=go0WQGsINEcelVgijsBHi64OAE
        3QIEI4xKr28hrz3EkwpbOdf/sCvwfVPkXn2SZFBtmV1JMRyKkasl2jz7t9kSTieUDnsebsyn9yH1A
        fQ6Bzsh8YehpKwbkECiZIvT/U/LXotQdHsNmr3FyAOU2LvjtvzlbcAwF3qxkU8HH2p3u6fmxIxCFQ
        pPJxuAC9usiYDh0orgvIZm0hDgHJinVbHqScDKyAj1cNecfYJQsxTiJbatiO0BUuzRjaYZuydCWKs
        RsazK+GcpykV0uWIkER+SIDlUAYydoAY33oBe6Y8KK5poEbqHKLlYZZP+ovOnfaC/Tj9Q0VyX/PeY
        ppbpWU4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lrO8o-001o7U-NE; Thu, 10 Jun 2021 17:06:53 +0000
Date:   Thu, 10 Jun 2021 18:06:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk.kim@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
Message-ID: <YMJGqkwL87KczMS+@casper.infradead.org>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <CAOtxgyeRf=+grEoHxVLEaSM=Yfx4KrSG5q96SmztpoWfP=QrDg@mail.gmail.com>
 <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 12:22:40PM -0400, Ric Wheeler wrote:
> On 6/9/21 5:32 PM, Jaegeuk Kim wrote:
> > On Wed, Jun 9, 2021 at 11:47 AM Bart Van Assche <bvanassche@acm.org
> > <mailto:bvanassche@acm.org>> wrote:
> > 
> >     On 6/9/21 11:30 AM, Matthew Wilcox wrote:
> >     > maybe you should read the paper.
> >     >
> >     > " Thiscomparison demonstrates that using F2FS, a flash-friendly file
> >     > sys-tem, does not mitigate the wear-out problem, except inasmuch asit
> >     > inadvertently rate limitsallI/O to the device"
> > 
> > 
> > Do you agree with that statement based on your insight? At least to me, that
> > paper is missing the fundamental GC problem which was supposed to be
> > evaluated by real workloads instead of using a simple benchmark generating
> > 4KB random writes only. And, they had to investigate more details in FTL/IO
> > patterns including UNMAP and LBA alignment between host and storage, which
> > all affect WAF. Based on that, the point of the zoned device is quite promising
> > to me, since it can address LBA alignment entirely and give a way that host
> > SW stack can control QoS.
> 
> Just a note, using a pretty simple and optimal streaming write pattern, I
> have been able to burn out emmc parts in a little over a week.
> 
> My test case creating a 1GB file (filled with random data just in case the
> device was looking for zero blocks to ignore) and then do a loop to cp and
> sync that file until the emmc device life time was shown as exhausted.
> 
> This was a clean, best case sequential write so this is not just an issue
> with small, random writes.

How many LBAs were you using?  My mental model of a FTL (which may
be out of date) is that it's essentially a log-structured filesystem.
When there are insufficient empty erase-blocks available, the device
finds a suitable victim erase-block, copies all the still-live LBAs into
an active erase-block, updates the FTL and erases the erase-block.

So the key is making sure that LBAs are reused as much as possible.
Short of modifying a filesystem to make this happen, I force it by
short-stroking my SSD.  We can model it statistically, but intuitively,
if there are more "live" LBAs, the higher the write amplification and
wear on the drive will be because the victim erase-blocks will have
more live LBAs to migrate.

This is why the paper intrigued me; it seemed like they were rewriting
a 100MB file in place.  That _shouldn't_ cause ridiculous wear, unless
the emmc device was otherwise almost full.
