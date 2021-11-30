Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6A9463DEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbhK3SmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 13:42:07 -0500
Received: from shark2.inbox.lv ([194.152.32.82]:33306 "EHLO shark2.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhK3SmH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:42:07 -0500
Received: from shark2.inbox.lv (localhost [127.0.0.1])
        by shark2-out.inbox.lv (Postfix) with ESMTP id 79DF9C0199;
        Tue, 30 Nov 2021 20:38:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638297526; bh=BEyYRApqsqPgfBPxdS8CKfzax9QZDjnvQ2ldgIGpwDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Z0N8nheiRV6C73uvKwMTkSaSi09rbNlTDXASywsnAJ5hFAkXKLZ0/yGBAme1NuQtr
         fFaXzWOK0F2Pfk7JGQ1p6nZUYIlg6fm9BRdcWaYZzBWB+kkprL+cuNSPi9MhptC5Lg
         jNLfaITvChpzI4O9B/m+/cI6j1S3Rfb7PxunxUa8=
Received: from localhost (localhost [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 6B929C0179;
        Tue, 30 Nov 2021 20:38:46 +0200 (EET)
Received: from shark2.inbox.lv ([127.0.0.1])
        by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id yMbWe0OGI621; Tue, 30 Nov 2021 20:38:46 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 2504CC00DB;
        Tue, 30 Nov 2021 20:38:46 +0200 (EET)
Date:   Wed, 1 Dec 2021 03:38:36 +0900
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
Message-ID: <20211201033836.4382a474@mail.inbox.lv>
In-Reply-To: <20211130172754.GS3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211129150117.GO3366@techsingularity.net>
        <20211201010348.31e99637@mail.inbox.lv>
        <20211130172754.GS3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdhRs1tcG/N/0M6uTt2NezU0Qivi7kzL4y9QEqu9Gkr7wBfW6TGofmHgq/cWbD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>due to the
>underlying storage.

I agree.

>and send me the trace.out file please?

https://drive.google.com/file/d/1FBjAmXwXakWPPjcn6K-B50S04vyySQO6/view

Typical entries:

           Timer-10841   [006] ..... 14341.639496: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
           gmain-1246    [004] ..... 14341.639498: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
          php7.0-11149   [001] ..... 14341.647498: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
      obfs-local-908     [001] ..... 14341.651510: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
     Web Content-10876   [000] ..... 14341.651522: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
  NetworkManager-812     [004] ..... 14341.667495: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
             tor-941     [000] ..... 14341.667495: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
   IndexedDB #18-11165   [007] ..... 14341.667520: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
           Timer-10755   [002] ..... 14341.667538: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
     JS Watchdog-10884   [000] ..... 14341.699489: mm_vmscan_throttled: nid=0 usec_timeout=100000 usect_delayed=100000 reason=VMSCAN_THROTTLE_WRITEBACK
