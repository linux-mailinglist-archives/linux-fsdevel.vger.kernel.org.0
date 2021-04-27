Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26036CC7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhD0Uob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhD0Uob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:44:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6799C061574;
        Tue, 27 Apr 2021 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2m3ePEN/b0N6S7FfXEnTbvQ+rj6eA3/8NDXHz1WfGDc=; b=vLyGFxYEG9pHXrRCGL8NP5D2m3
        DL6FnWLtyJYrL7lduj8SDBojHQ7RAdrLiKT82ajmh189BAzJcWwqG8fKZa7OsjTpTeMlBqeTNPIVx
        W6aTEhv0NwUzEjEKHimVsgS+/ZG9sKzaNMiKFE/VqXGK32g0nTFNpZJ+1lwczuGyHsHpq0+ht2Ea/
        +HnEFrLYMrRkK6nRNlpZpxe2GhXz9P5nyKnRRW34lWcBl8WkBb4YRK0t0oYBHZn9R4xjblXcQdjyq
        RQlZfBYR3cEzq5+PdWqlILFjgBuzL/eXZLuZx8a+SdQ8wzJLbid93pRwMCGjLJBzwy4SIL2G93d+r
        q5yhmF3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbUYB-007Nog-Uo; Tue, 27 Apr 2021 20:43:21 +0000
Date:   Tue, 27 Apr 2021 21:43:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Eryu Guan <eguan@linux.alibaba.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 3/3] Use --yes option to lvcreate
Message-ID: <20210427204319.GD235567@casper.infradead.org>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-4-kent.overstreet@gmail.com>
 <20210427170339.GA9611@e18g06458.et15sqa>
 <YIh0Iy+BiY4zzhB1@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIh0Iy+BiY4zzhB1@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:29:23PM -0400, Kent Overstreet wrote:
> On Wed, Apr 28, 2021 at 01:03:39AM +0800, Eryu Guan wrote:
> > On Tue, Apr 27, 2021 at 12:44:19PM -0400, Kent Overstreet wrote:
> > > This fixes spurious test failures caused by broken pipe messages.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > > ---
> > >  tests/generic/081 | 2 +-
> > >  tests/generic/108 | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/081 b/tests/generic/081
> > > index 5dff079852..26702007ab 100755
> > > --- a/tests/generic/081
> > > +++ b/tests/generic/081
> > > @@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> > >  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > >  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
> > >  # (like 2.02.95 in RHEL6) don't support --yes option
> > > -yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > > +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > 
> > Please see above comments, we use yes pipe intentionally. I don't see
> > how this would result in broken pipe. Would you please provide more
> > details? And let's see if we could fix the broken pipe issue.
> 
> If lvcreate never ask y/n - never reads from standard input, then echo sees a
> broken pipe when it tries to write. That's what I get without this patch.

I think it's something in how ktest sets up the environment.  I also see
the SIGPIPEs when using your ktest scripts, but not when ssh'ing into
the guest and running the test.

What that thing is, I don't know.  I'm not tall enough to understand
signal handling.
