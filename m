Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE92C27315C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgIUSAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUSAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:00:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CE5C061755;
        Mon, 21 Sep 2020 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EYalxu71FXkhieQDqm3YOx3Lopqwd5EDbAcvH4qgOhs=; b=cn1ZppxwRY81oXiNm0vRnLyCFs
        Xl5xURoMhBnqr2NAEHsKV+Yt0xLaL5tT+bhVHEInqaezHoHp5ln5P0NE4NbQUyQ/JA7hTmee5MQSv
        Gx4g48bXYVJSDGVL4YSAf+VQIzMvlFAv+o8q5hLXRp9CBiHnAy1AqXzqyUH3ZR65gj3A2LQVw0lqH
        Qz1GsKVlFrTrf5GNRFnMVYe2c2MMzmOpjxQ4I5XffgCWR2Hb9GG0Zo+JWhEMO7d11kCVug0WBiHsk
        uzjFDYrt1qxk0nMox3iIjPWlwC0J4P5ST6FeF54rmXxKGGMdxudBsLGdsbKrQKVjihsLADUoJVGzn
        QR0vNZKg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKQ6J-0007Cd-IL; Mon, 21 Sep 2020 17:59:43 +0000
Date:   Mon, 21 Sep 2020 18:59:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Hugh Dickins <hughd@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200921175943.GW32101@casper.infradead.org>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
 <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils>
 <20200921082600.GO12131@dread.disaster.area>
 <20200921091143.GB5862@quack2.suse.cz>
 <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:20:25AM -0700, Linus Torvalds wrote:
> On Mon, Sep 21, 2020 at 2:11 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Except that on truncate, we have to unmap these
> > anonymous pages in private file mappings as well...
> 
> I'm actually not 100% sure we strictly would need to care.
> 
> Once we've faulted in a private file mapping page, that page is
> "ours". That's kind of what MAP_PRIVATE means.
> 
> If we haven't written to it, we do keep things coherent with the file,
> but that's actually not required by POSIX afaik - it's a QoI issue,
> and a lot of (bad) Unixes didn't do it at all.
> So as long as truncate _clears_ the pages it truncates, I think we'd
> actually be ok.

We don't even need to do that ...

"If the size of the mapped file changes after the call to mmap()
as a result of some other operation on the mapped file, the effect of
references to portions of the mapped region that correspond to added or
removed portions of the file is unspecified."

https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html

As you say, there's a QoI here, and POSIX permits some shockingly
bad and useless implementations.
