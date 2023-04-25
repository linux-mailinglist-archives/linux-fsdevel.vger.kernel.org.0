Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDDB6EDD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjDYIBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 04:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDYIA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:00:57 -0400
Received: from outbound-smtp42.blacknight.com (outbound-smtp42.blacknight.com [46.22.139.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E04C39
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 01:00:55 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp42.blacknight.com (Postfix) with ESMTPS id 789CC1D69
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 09:00:54 +0100 (IST)
Received: (qmail 23226 invoked from network); 25 Apr 2023 08:00:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Apr 2023 08:00:54 -0000
Date:   Tue, 25 Apr 2023 09:00:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Ying <ying.huang@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
Message-ID: <20230425080052.63dik4aadlrjvd2p@techsingularity.net>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230421151135.v2.1.I2b71e11264c5c214bc59744b9e13e4c353bc5714@changeid>
 <20230424082254.gopb4y2c7d65icpl@techsingularity.net>
 <CAD=FV=XRMiDxKyLKGKL3ekk8CjRt6puT1PReD+pE21JGgF4TQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAD=FV=XRMiDxKyLKGKL3ekk8CjRt6puT1PReD+pE21JGgF4TQw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:22:55AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Mon, Apr 24, 2023 at 1:22???AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > > @@ -1295,10 +1296,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
> > >               /* Loop until we've been woken or interrupted */
> > >               flags = smp_load_acquire(&wait->flags);
> > >               if (!(flags & WQ_FLAG_WOKEN)) {
> > > +                     if (!timeout)
> > > +                             break;
> > > +
> >
> > An io_schedule_timeout of 0 is valid so why the special handling? It's
> > negative timeouts that cause schedule_timeout() to complain.
> 
> It's not expected that the caller passes in a timeout of 0 here. The
> test here actually handles the case that the previous call to
> io_schedule_timeout() returned 0. In my patch, after the call to
> io_schedule_timeout() we unconditionally "continue" and end up back at
> the top of the loop. The next time through the loop if we don't see
> the WOKEN flag then we'll check for the two "error" conditions
> (timeout or signal pending) and break for either of them.

Ah, I see!

> 
> To make it clearer, I'll add this comment for the next version:
> 
> /* Break if the last io_schedule_timeout() said no time left */

Yes please.

-- 
Mel Gorman
SUSE Labs
