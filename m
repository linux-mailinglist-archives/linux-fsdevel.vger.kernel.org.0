Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF1466BE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 22:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349141AbhLBWBx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 17:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbhLBWBw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:01:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1244DC06174A;
        Thu,  2 Dec 2021 13:58:30 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6338B823B7;
        Thu,  2 Dec 2021 21:58:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F1B760E0B;
        Thu,  2 Dec 2021 21:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638482307;
        bh=u54M8TvqFCoqyWizAXfj0p458N8cswh37sQPhuz+PE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRmuD2cdMj0JpWJeCh8p6a6Bco8m3d04KtZ8Kd+lRiv0KNpbc5QDnURexbd5oeFqK
         hjvtOIAthwV4+RummH/wrQf59WNK6NBbdnu+FVNXQ+164xA8DRwsskjqDPshxg9uKX
         zMEACX/Rr8Fh+5Fwymwac7m8oa/bN1rwC0xjXqbU=
Date:   Thu, 2 Dec 2021 13:58:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Message-Id: <20211202135824.33d2421bf5116801cfa2040d@linux-foundation.org>
In-Reply-To: <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
References: <20211130201652.2218636d@mail.inbox.lv>
        <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Dec 2021 21:05:01 +0300 ValdikSS <iam@valdikss.org.ru> wrote:

> This patchset is surprisingly effective and very useful for low-end PC 
> with slow HDD, single-board ARM boards with slow storage, cheap Android 
> smartphones with limited amount of memory. It almost completely prevents 
> thrashing condition and aids in fast OOM killer invocation.
> 
> The similar file-locking patch is used in ChromeOS for nearly 10 years 
> but not on stock Linux or Android. It would be very beneficial for 
> lower-performance Android phones, SBCs, old PCs and other devices.
> 
> With this patch, combined with zram, I'm able to run the following 
> software on an old office PC from 2007 with __only 2GB of RAM__ 
> simultaneously:
> 
>   * Firefox with 37 active tabs (all data in RAM, no tab unloading)
>   * Discord
>   * Skype
>   * LibreOffice with the document opened
>   * Two PDF files (14 and 47 megabytes in size)
> 
> And the PC doesn't crawl like a snail, even with 2+ GB in zram!
> Without the patch, this PC is barely usable.
> Please watch the video:
> https://notes.valdikss.org.ru/linux-for-old-pc-from-2007/en/
> 

This is quite a condemnation of the current VM.  It shouldn't crawl
like a snail.

The patch simply sets hard limits on page reclaim's malfunctioning. 
I'd prefer that reclaim not malfunction :(

That being said, I can see that a blunt instrument like this would be
useful.

I don't think that the limits should be "N bytes on the current node". 
Nodes can have different amounts of memory so I expect it should scale
the hard limits on a per-node basis.  And of course, the various zones
have different size as well.

We do already have a lot of sysctls for controlling these sort of
things.  Was much work put into attempting to utilize the existing
sysctls to overcome these issues?

