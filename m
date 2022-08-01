Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17509586DC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiHAPbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiHAPby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:31:54 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA2248C7
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 08:31:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id a9so8264736qtw.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Aug 2022 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=b8eKRy3g11ioTTuIDRpimxoFALRtFmTHxY4IpUGDgIw=;
        b=nAUirjKV/lTKFYIG+ILEc34Sbwjj/bFiN4yH9LpGQy2mJfGqaXK9MY10dYjyfhGNS5
         FWiXHnGWxYLHZAFR4uehNWZ9UAQcsIFn5N9xQKI+GS95E+NXMOQs7eJ+R+lHau5BNtoi
         fPTX870tFW2MEUOlZ+Zgc9LcjR8jGdtCMNTPqGRiqjIUTD7NZKjBztjSUshyfgMkgEos
         ZDoM5ORbFjbq0xA6sRtGeFTeagO9HJmNdcAJjTdHinRfP9i0jeV0RAMzEwL4XfD2OZFc
         yKYJBV1VLvHrxupX5PldyblZZ+E7I45ThmgQW2W8gM1Y9CJb4ZSakcTOqKuTxS+sJbnW
         0mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=b8eKRy3g11ioTTuIDRpimxoFALRtFmTHxY4IpUGDgIw=;
        b=ihN1LiN3UQ18q2eZWY+WHBlMIucOPGq05feUJycyHpi7FNRuBHrO0BhPLCQT2qUs8r
         JANi4ou3RkenvpNxTwtScRsAdsIY5pskMId96WW/uRYpEOFVn/tZ1wPxuQRlY/Xps7ZN
         o6SeWf0J7CYrycecddr95xw8u6RaZMjYmXc6PnwBLSUurdEwXYS3hzatxTxpt55hCZ8f
         +O5QwIXCXq+Ck6F7xMDYrRCDXfzYbet63PUmTGnz6geWtoCTzklC5G8T/znJdH1U7sVb
         NoDWKJYvXLAOkaY/orOiz3RLUgjmGuALc6TcAltbB19YBwZzTBbSYlUDD1yc8XAiKN4w
         bm4g==
X-Gm-Message-State: AJIora/1JLYME6vBPsfBkQRsAwT+VMUos+Dx+VBub0mHsGoi3gGkyrYv
        7nx2qeQuHPlSBn593O/C5+jzEg==
X-Google-Smtp-Source: AGRyM1vXWP/IvVdz9h7ZSPwp5oBBTw3kGf28P7hqbodtJE91QbR8pRw9BoRmFvjH6p+BSxlNYcGIzw==
X-Received: by 2002:ac8:5e07:0:b0:31f:73:1394 with SMTP id h7-20020ac85e07000000b0031f00731394mr14655440qtx.502.1659367911431;
        Mon, 01 Aug 2022 08:31:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ad0f])
        by smtp.gmail.com with ESMTPSA id z1-20020ac84541000000b0031f338f95c0sm7391385qtn.0.2022.08.01.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:31:51 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:31:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove iomap_writepage v2
Message-ID: <Yufx5jpyJ+zcSJ4e@cmpxchg.org>
References: <20220719041311.709250-1-hch@lst.de>
 <20220728111016.uwbaywprzkzne7ib@quack3>
 <20220729092216.GE3493@suse.de>
 <20220729141145.GA31605@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729141145.GA31605@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:11:45PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 29, 2022 at 10:22:16AM +0100, Mel Gorman wrote:
> > There is some context missing because it's not clear what the full impact is
> > but it is definitly the case that writepage is ignored in some contexts for
> > common filesystems so lets assume that writepage from reclaim context always
> > failed as a worst case scenario. Certainly this type of change is something
> > linux-mm needs to be aware of because we've been blind-sided before.
> 
> Between willy and Johannes pushing or it I was under the strong assumption
> that linux-mm knows of it..

Yes, the context was an FS session at LSFMM. FS folks complained about
the MM relying on single-page writeouts. On the MM side we've invested
a lot into eliminating this dependency over the last decade or so, and
I would argue it's gone today. But the calls are still in the code,
and so FS folks continue to operate under the old assumption. You
can't blame them. I suggested we remove the callbacks to clarify
things and eliminate that murky corner from the FS/MM interface.

Compaction/migration is easy. It simply never calls writepage when
there is a migratepage callback - which major filesystems have.

Reclaim may still call it, but the invocation rules are so restrictive
nowadays that it's unlikely to actually help when it matters (and we
know it makes things worse in many cases).

For example, cgroup reclaim isn't ever allowed to call writepage.
This covers the small system scenario.

Whether writepage helps under OOM is not clear. OOMing systems tend to
have thundering herds of direct reclaimers, any one of which can
declare OOM if they fail, yet none of them can write pages. They
already rely on another thread to make progress. That thread can be
the flushers writing in offset order, or kswapd writing in LRU
order. You could argue that LRU order, while less efficient IO,
launders pages closer to the scanner. From an OOM perspective that
doesn't matter, though, because scanners will work through the entire
LRU list several times before giving up. They won't miss flusher
progress. That leaves reclaim efficiency - having to scan fewer pages
before potentially finding clean ones. But it's an IO bound scenario,
so arguably efficient IO would seem more important than efficient CPU.

The risk of this change, IMO, is exposing reclaim to flat out bugs in
the flusher code, or bugs in the code that matches reclaim to flushing
speed. However, a) cgroup has been relying on those for a decade. And
b) we've been treating writepage calls like bugs due to the latency
they inject into workloads, and tuned the MM to rely more on flushers
(e.g. c55e8d035b28 ("mm: vmscan: move dirty pages out of the way until
they're flushed")). So we know this stuff works at scale and with real
workloads. I think the risk of dragons there is quite low.

XFS hasn't had a ->writepage call for a while. After LSF I internally
tested dropping btrfs' callback, and the results looked good: no OOM
kills with dirty/writeback pages remaining, performance parity. Then I
went on vacation and Christoph beat me to the patch :)

I think it's a really good cleanup that makes things cleaner and more
predictable in both the fs and the mm.

> > I don't think it would be incredibly damaging although there *might* be
> > issues with small systems or cgroups. 
> 
> Johannes specifically mentioned that cgroup writeback will never call
> into ->writepage anyway.

Yes, cgroup has relied on the flushers since

commit ee72886d8ed5d9de3fa0ed3b99a7ca7702576a96
Author: Mel Gorman <mel@csn.ul.ie>
Date:   Mon Oct 31 17:07:38 2011 -0700

    mm: vmscan: do not writeback filesystem pages in direct reclaim

since cgroup reclaim == direct reclaim.
