Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839072789E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgIYNqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 09:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgIYNqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:46:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5EFC0613CE;
        Fri, 25 Sep 2020 06:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gxYQEqxQVKFciJ6yJktcdqQMmFwlDZtQg21Tebq6OO8=; b=QJ2dJwXHdqKR0VRC2/LuNQtmzG
        0UqfgLjogisPQzkvFGvlND1mTmAVehVwums51Xinw0J/H4SHhUNfQqkeKnhzm9vXQHZdIT+gYMej7
        pkcjNbn7iTJJwFARLGqXdz8bRPItYHCLgtO0u9J8yeqyWStRhjxSpkooLkszUZ5m3roTXRzoQKFP8
        csVHGAgCx+kMKWtG3KBLgxGvlx1N/rDkNmkEOkM0qY3B/IlcNH3JDv3cao8hhGAJ9cbimXCml6zYb
        nX1xQ7WOZrzKTNyZezUoRmDVHjLjwbywGapDpw+oYNY2wMejKKscNfpioyrlq5YwapK2xoP+W5Qk4
        htTRShUw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLo36-00023d-Ke; Fri, 25 Sep 2020 13:46:08 +0000
Date:   Fri, 25 Sep 2020 14:46:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200925134608.GE32101@casper.infradead.org>
References: <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
 <20200924163635.GZ32101@casper.infradead.org>
 <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org>
 <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org>
 <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:36:01PM +0200, Sedat Dilek wrote:
> > I have applied your diff on top of Linux v5.9-rc6+ together with
> > "iomap: Set all uptodate bits for an Uptodate page".
> >
> > Run LTP tests:
> >
> > #1: syscalls (all)
> > #2: syscalls/preadv203
> > #3: syscalls/dirtyc0w
> >
> > With #1 I see some failures with madvise0x tests.

Why do you think these failures are related to my patches?

> [Fri Sep 25 15:29:46 2020] LTP: starting madvise09
> [Fri Sep 25 15:29:47 2020] madvise09 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> [Fri Sep 25 15:29:47 2020] CPU: 1 PID: 539680 Comm: madvise09 Tainted: G            E     5.9.0-rc6-5-amd64-clang-cfi #5~bullseye+dileks1
> [Fri Sep 25 15:29:47 2020] Hardware name: SAMSUNG ELECTRONICS CO., LTD. 530U3BI/530U4BI/530U4BH/530U3BI/530U4BI/530U4BH, BIOS 13XK 03/28/2013
> [Fri Sep 25 15:29:47 2020] Call Trace:
> [Fri Sep 25 15:29:47 2020]  dump_stack+0x64/0x9b
> [Fri Sep 25 15:29:47 2020]  dump_header+0x50/0x230
> [Fri Sep 25 15:29:47 2020]  oom_kill_process+0xa1/0x170
> [Fri Sep 25 15:29:47 2020]  out_of_memory+0x265/0x330
> [Fri Sep 25 15:29:47 2020]  mem_cgroup_oom+0x313/0x360
> [Fri Sep 25 15:29:47 2020]  try_charge+0x51f/0x730
> [Fri Sep 25 15:29:47 2020]  mem_cgroup_charge+0x100/0x300
> [Fri Sep 25 15:29:47 2020]  do_anonymous_page+0x229/0x690

... madvise09 took a page fault and was killed by mem_cgroup_oom

> [Fri Sep 25 15:29:47 2020] memory: usage 8192kB, limit 8192kB, failcnt 485

because it had used up all the memory it was allowed to

