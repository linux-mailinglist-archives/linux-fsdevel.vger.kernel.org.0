Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCC54C1355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 13:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiBWM5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 07:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiBWM5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:57:33 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 04:57:04 PST
Received: from outbound-smtp62.blacknight.com (outbound-smtp62.blacknight.com [46.22.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0A6336
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 04:57:03 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp62.blacknight.com (Postfix) with ESMTPS id DF02CFAAFF
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 12:50:04 +0000 (GMT)
Received: (qmail 528 invoked from network); 23 Feb 2022 12:50:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Feb 2022 12:50:04 -0000
Date:   Wed, 23 Feb 2022 12:50:02 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shuang Zhai <szhai2@cs.rochester.edu>
Cc:     akpm@linux-foundation.org, djwong@kernel.org, efault@gmx.de,
        hakavlad@inbox.lv, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        regressions@lists.linux.dev, riel@surriel.com, vbabka@suse.cz
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress'
Message-ID: <20220223125002.GE4423@techsingularity.net>
References: <20220215144924.GS3366@techsingularity.net>
 <20220222172731.31949-1-szhai2@cs.rochester.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220222172731.31949-1-szhai2@cs.rochester.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 22, 2022 at 12:27:31PM -0500, Shuang Zhai wrote:
> Mel Gorman wrote:
> > On Mon, Feb 14, 2022 at 04:10:50PM -0500, Shuang Zhai wrote:
> > > Hi Mel,
> > > 
> > > Mel Gorman wrote:
> > > >
> > > > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > > > problems due to reclaim throttling for excessive lengths of time.
> > > > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > > > several minutes before stalling. In Mike and Darrick's cases, a small
> > > > memcg environment stalled excessively even though the system had enough
> > > > memory overall.
> > > >
> > > 
> > > I recently found a regression when I tested MGLRU with fio on Linux
> > > 5.16-rc6 [1]. After this patch was applied, I re-ran the test with Linux
> > > 5.16, but the regression has not been fixed yet. 
> > > 
> > 
> > Am I correct in thinging that this only happens with MGLRU?
> 
> Sorry about the confusion and let me clarify on this. The regression happens
> on upstream Linux with the default page replacement mechanism.

Ok, the fio command for me simply exits with an error and even if it didn't
the test machine I have with persistent memory does not have enough pmem
to trigger memory reclaim issues with fio. Can you do the following please?

# echo 1 > vmscan/mm_vmscan_throttled/enable
# cat /sys/kernel/debug/tracing/trace_pipe > trace.out

and run the test? Compress trace.out with xz and send it to me by mail.
If the trace is too large, send as much as you can.

-- 
Mel Gorman
SUSE Labs
