Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5A267D7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Sep 2020 05:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgIMDkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 23:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgIMDkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 23:40:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C66C061573;
        Sat, 12 Sep 2020 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZYGqdYamY4+zA1k9YbkPZAzoov94etFgvoPUgrubo8I=; b=Co2zECnDOBV1f+thSQ7plIGWME
        bSemBFVqyXyzDaeb01IFgpK+aWoGXS2k1HDI+SJpZBJqwACUz7zBvNhDvtI8QbPX7NEw6qG5Jh6wp
        /YftdGpqRMe9CrI8WDCaqUM39jGK4l/IaE8DZ+AuCqJC2MSDaMtWQE2XLJldnADQymohGjJ0flrQ3
        YZ1GAuVzCs4zwAPbNl8+aSnnOsdP4VLJ055PPB6xPxChAkvEu/2ONjBmIcy1MYBS7KBaTjQAEWpVn
        6vfDm4MICOgSOVvB4d9ovAuq8wcwCvXSnx7buM0cAjWU3SqxsJqD+GfsmK3/qbft0mcXH6qFO4SPo
        AhITR88g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHIs0-0004kj-K4; Sun, 13 Sep 2020 03:40:04 +0000
Date:   Sun, 13 Sep 2020 04:40:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Kernel Benchmarking
Message-ID: <20200913034004.GF6583@casper.infradead.org>
References: <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
 <20200913004057.GR12096@dread.disaster.area>
 <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh5Lyr9Tr8wpNDXKeNt=Ngc3jwWaOsN_WbQr+1dAuhJSQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 07:39:31PM -0700, Linus Torvalds wrote:
> The real worry with (d) is that we are using the page lock for other
> things too, not *just* the truncate check. Things where the inode lock
> wouldn't be helping, like locking against throwing pages out of the
> page cache entirely, or the hugepage splitting/merging etc. It's not
> being truncated, it's just the VM shrinking the cache or modifying
> things in other ways.

Actually, hugepage splitting is done under the protection of page freezing
where we temporarily set the refcount to zero, so pagecache lookups spin
rather than sleep on the lock.  Quite nasty, but also quite rare.

> But the page locking code does have some extreme downsides, exactly
> because there are so _many_ pages and we end up having to play some

The good news is that the THP patchset is making good progress.  I have
seven consecutive successful three-hour runs of xfstests, so maybe we'll
see fewer pages in the future.

