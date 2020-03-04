Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048351794ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgCDQVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:21:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59402 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388215AbgCDQVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:21:14 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9WlP-005GmR-La; Wed, 04 Mar 2020 16:20:51 +0000
Date:   Wed, 4 Mar 2020 16:20:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCHSET] sanitized pathwalk machinery (v3)
Message-ID: <20200304162051.GQ23230@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200301215125.GA873525@ZenIV.linux.org.uk>
 <CAHk-=wh1Q=H-YstHZRKfEw2McUBX2_TfTc=+5N-iH8DSGz44Qg@mail.gmail.com>
 <20200302003926.GM23230@ZenIV.linux.org.uk>
 <87o8tdgfu8.fsf@x220.int.ebiederm.org>
 <20200304002434.GO23230@ZenIV.linux.org.uk>
 <87wo80g0bo.fsf@x220.int.ebiederm.org>
 <20200304065547.GP23230@ZenIV.linux.org.uk>
 <20200304132812.GE29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304132812.GE29971@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 05:28:12AM -0800, Matthew Wilcox wrote:
> On Wed, Mar 04, 2020 at 06:55:47AM +0000, Al Viro wrote:
> > On Tue, Mar 03, 2020 at 11:23:39PM -0600, Eric W. Biederman wrote:
> > > Do the xfs-tests cover that sort of thing?
> > > The emphasis is stress testing the filesystem not the VFS but there is a
> > > lot of overlap between the two.
> > 
> > I do run xfstests.  But "runs in KVM without visible slowdowns" != "won't
> > cause them on 48-core bare metal".  And this area (especially when it
> > comes to RCU mode) can be, er, interesting in that respect.
> > 
> > FWIW, I'm putting together some litmus tests for pathwalk semantics -
> > one of the things I'd like to discuss at LSF; quite a few codepaths
> > are simply not touched by anything in xfstests.
> 
> Might be more appropriate for LTP than xfstests?  will-it-scale might be
> the right place for performance benchmarks.

Might be...  I do run LTP as well, but it's still a 4-way KVM on a 6-way
amd64 host (phenom II X6 1100T) - not well-suited for catching scalability
issues.

Litmus tests mentioned above are more about verifying the semantics;
I hadn't moved past the "bunch of home-grown scripts creating setups
that would exercise the codepaths in question + trivial pieces
in C, pretty much limited to syscall()" stage with that; moving those
to LTP framework is something I'll need to look into.  Might very well
make sense; for now I just want a way to get test coverage of that code
with minimal headache.
