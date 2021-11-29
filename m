Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA75A461029
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhK2IcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 03:32:18 -0500
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:53375 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351363AbhK2IaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:30:15 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 5B2E61BAC
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 08:26:57 +0000 (GMT)
Received: (qmail 10607 invoked from network); 29 Nov 2021 08:26:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Nov 2021 08:26:57 -0000
Date:   Mon, 29 Nov 2021 08:26:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211129082654.GM3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211126165211.GL3366@techsingularity.net>
 <20211128042635.543a2d04@mail.inbox.lv>
 <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <252cd5acd9bf6588ec87ce02884925c737b6a8b7.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 28, 2021 at 11:00:59AM +0100, Mike Galbraith wrote:
> On Sun, 2021-11-28 at 04:26 +0900, Alexey Avramov wrote:
> > I will present the results of the new tests here.
> >
> > TLDR;
> > =====
> > No one Mel's patch doesn't prevent stalls in my tests.
> 
> Seems there may be a problem with the THROTTLE_WRITEBACK bits..
> 
> > $ for i in {1..10}; do tail /dev/zero; done
> > -- 1. with noswap
> 
> ..because the bandaid below (made of 8cd7c588 shards) on top of Mel's
> last pulled that one-liner's very pointy fangs.
> 

This disables writeback throttling in most cases as bdi congested is not
updated by the block layer.

-- 
Mel Gorman
SUSE Labs
