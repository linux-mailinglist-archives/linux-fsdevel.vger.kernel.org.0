Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D24374C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhJVJgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 05:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhJVJgX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:36:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4BE761163;
        Fri, 22 Oct 2021 09:34:03 +0000 (UTC)
Date:   Fri, 22 Oct 2021 10:34:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
Message-ID: <YXKFiBzaBcz9EiOI@arm.com>
References: <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
 <YWR2cPKeDrc0uHTK@arm.com>
 <CAHk-=wjvQWj7mvdrgTedUW50c2fkdn6Hzxtsk-=ckkMrFoTXjQ@mail.gmail.com>
 <YWSnvq58jDsDuIik@arm.com>
 <CAHk-=wiNWOY5QW5ZJukt_9pHTWvrJhE2=DxPpEtFHAWdzOPDTg@mail.gmail.com>
 <CAHc6FU7bpjAxP+4dfE-C0pzzQJN1p=C2j3vyXwUwf7fF9JF72w@mail.gmail.com>
 <YXE7fhDkqJbfDk6e@arm.com>
 <CAHc6FU5xTMOxuiEDyc9VO_V98=bvoDc-0OFi4jsGPgWJWjRJWQ@mail.gmail.com>
 <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgvnU2PXFMpsNErdwE=tXGymLHe275jWkBhCbGiixWU5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 04:30:30PM -1000, Linus Torvalds wrote:
> On Thu, Oct 21, 2021 at 4:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > But probing the entire memory range in fault domain granularity in the
> > page fault-in functions still doesn't actually make sense. Those
> > functions really only need to guarantee that we'll be able to make
> > progress eventually. From that point of view, it should be enough to
> > probe the first byte of the requested memory range
> 
> That's probably fine.
> 
> Although it should be more than one byte - "copy_from_user()" might do
> word-at-a-time optimizations, so you could have an infinite loop of
> 
>  (a) copy_from_user() fails because the chunk it tried to get failed partly
> 
>  (b) fault_in() probing succeeds, because the beginning part is fine
> 
> so I agree that the fault-in code doesn't need to do the whole area,
> but it needs to at least do some <N bytes, up to length> thing, to
> handle the situation where the copy_to/from_user requires more than a
> single byte.

From a discussion with Al some months ago, if there are bytes still
accessible, copy_from_user() is not allowed to fail fully (i.e. return
the requested copy size) even when it uses word-at-a-time. In the worst
case, it should return size - 1. If the fault_in() then continues
probing from uaddr + 1, it should eventually hit the faulty address.

The problem appears when fault_in() restarts from uaddr rather than
where copy_from_user() stopped. That's what the btrfs search_ioctl()
does. I also need to check the direct I/O cases that Andreas mentioned,
maybe they can be changed not to attempt the fault_in() from the
beginning of the block.

-- 
Catalin
