Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710B6466358
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 13:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357713AbhLBMSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 07:18:45 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:52486 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346715AbhLBMSo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:18:44 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 05D0C11181C5;
        Thu,  2 Dec 2021 14:15:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638447320; bh=4j2nijv3X12i2A61/XXLhOx/Qk6/8t3KG3IAb8uqORE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=PcyYJg9D3XMUFHryaZ60I9fQTfegzVtjXlIddCQiG/O885mr+xQVGGPlF+w871UtM
         L0eCuZDAa9ZXjpIymr6lAn+kCj1dSRjXSOeqUxCDCrL+4nNpmSzBdGY+KhE0ueKhyM
         no9VpGZdbBrhXUvQDBV/rXrBfDN7Hof5wKfMZKJo=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id F3E7C11181BF;
        Thu,  2 Dec 2021 14:15:19 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 4fNXQX0fpT_4; Thu,  2 Dec 2021 14:15:19 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id B57AA11181B7;
        Thu,  2 Dec 2021 14:15:19 +0200 (EET)
Date:   Thu, 2 Dec 2021 21:14:56 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202211456.3517014f@mail.inbox.lv>
In-Reply-To: <20211202204229.5ed83f31@mail.inbox.lv>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211129150117.GO3366@techsingularity.net>
        <20211201010348.31e99637@mail.inbox.lv>
        <20211130172754.GS3366@techsingularity.net>
        <20211201033836.4382a474@mail.inbox.lv>
        <20211201140005.GU3366@techsingularity.net>
        <20211202204229.5ed83f31@mail.inbox.lv>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQ3gB6gdL+J/+N+YY6uLix9W6UVIlviLmvc49ixdFz9PMtNdrcW+QBYXqHxy6dn8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

and trace.out with swappiness=0:

typical entries:

 Chrome_~dThread-3463    [003] .....  5492.490187: mm_vmscan_throttled: nid=0 usec_timeout=20000 usect_delayed=4000 reason=VMSCAN_THROTTLE_ISOLATED
 DNS Res~ver #12-5720    [005] .....  5492.490207: mm_vmscan_throttled: nid=0 usec_timeout=20000 usect_delayed=4000 reason=VMSCAN_THROTTLE_ISOLATED
            tail-6015    [001] .....  5492.490545: mm_vmscan_throttled: nid=0 usec_timeout=20000 usect_delayed=4000 reason=VMSCAN_THROTTLE_ISOLATED

https://drive.google.com/file/d/1oXOVPFyNmDe2-PFUIAMHMPffZo1N_7vl/view
