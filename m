Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2B273CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 09:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIVHy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 03:54:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgIVHy2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:54:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E840ACC2;
        Tue, 22 Sep 2020 07:55:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7D0771E12E3; Tue, 22 Sep 2020 09:54:26 +0200 (CEST)
Date:   Tue, 22 Sep 2020 09:54:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20200922075426.GA15112@quack2.suse.cz>
References: <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
 <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils>
 <20200921082600.GO12131@dread.disaster.area>
 <20200921091143.GB5862@quack2.suse.cz>
 <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
 <20200921175943.GW32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921175943.GW32101@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-09-20 18:59:43, Matthew Wilcox wrote:
> On Mon, Sep 21, 2020 at 09:20:25AM -0700, Linus Torvalds wrote:
> > On Mon, Sep 21, 2020 at 2:11 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Except that on truncate, we have to unmap these
> > > anonymous pages in private file mappings as well...
> > 
> > I'm actually not 100% sure we strictly would need to care.
> > 
> > Once we've faulted in a private file mapping page, that page is
> > "ours". That's kind of what MAP_PRIVATE means.
> > 
> > If we haven't written to it, we do keep things coherent with the file,
> > but that's actually not required by POSIX afaik - it's a QoI issue,
> > and a lot of (bad) Unixes didn't do it at all.
> > So as long as truncate _clears_ the pages it truncates, I think we'd
> > actually be ok.
> 
> We don't even need to do that ...
> 
> "If the size of the mapped file changes after the call to mmap()
> as a result of some other operation on the mapped file, the effect of
> references to portions of the mapped region that correspond to added or
> removed portions of the file is unspecified."
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html
> 
> As you say, there's a QoI here, and POSIX permits some shockingly
> bad and useless implementations.

Something from ftruncate(2) POSIX definition [1] for comparison:

If the effect of ftruncate() is to decrease the size of a memory mapped
file or a shared memory object and whole pages beyond the new end were
previously mapped, then the whole pages beyond the new end shall be
discarded.

References to discarded pages shall result in the generation of a SIGBUS
signal.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/ftruncate.html

Now pick... ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
