Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A58350E54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 07:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhDAFGG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 01:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDAFFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:05:47 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8293C0613E6;
        Wed, 31 Mar 2021 22:05:46 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRpWT-001Yh4-F8; Thu, 01 Apr 2021 05:05:37 +0000
Date:   Thu, 1 Apr 2021 05:05:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
 <20210330210929.GR351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330210929.GR351017@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:09:29PM +0100, Matthew Wilcox wrote:

> That's a very Intel-centric way of looking at it.  Other architectures
> support a multitude of page sizes, from the insane ia64 (4k, 8k, 16k, then
> every power of four up to 4GB) to more reasonable options like (4k, 32k,
> 256k, 2M, 16M, 128M).  But we (in software) shouldn't constrain ourselves
> to thinking in terms of what the hardware currently supports.  Google
> have data showing that for their workloads, 32kB is the goldilocks size.
> I'm sure for some workloads, it's much higher and for others it's lower.
> But for almost no workload is 4kB the right choice any more, and probably
> hasn't been since the late 90s.

Out of curiosity I looked at the distribution of file sizes in the
kernel tree:
71455 files total
0--4Kb		36702
4--8Kb		11820
8--16Kb		10066
16--32Kb	6984
32--64Kb	3804
64--128Kb	1498
128--256Kb	393
256--512Kb	108
512Kb--1Mb	35
1--2Mb		25
2--4Mb		5
4--6Mb		7
6--8Mb		4
12Mb		2 
14Mb		1
16Mb		1

... incidentally, everything bigger than 1.2Mb lives^Wshambles under
drivers/gpu/drm/amd/include/asic_reg/

Page size	Footprint
4Kb		1128Mb
8Kb		1324Mb
16Kb		1764Mb
32Kb		2739Mb
64Kb		4832Mb
128Kb		9191Mb
256Kb		18062Mb
512Kb		35883Mb
1Mb		71570Mb
2Mb		142958Mb

So for kernel builds (as well as grep over the tree, etc.) uniform 2Mb pages
would be... interesting.
