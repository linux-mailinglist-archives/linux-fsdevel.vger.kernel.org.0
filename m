Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B0C271E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 11:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIUJLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 05:11:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgIUJLp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:11:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07B54AC2B;
        Mon, 21 Sep 2020 09:12:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7415C1E12E1; Mon, 21 Sep 2020 11:11:43 +0200 (CEST)
Date:   Mon, 21 Sep 2020 11:11:43 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
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
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around
 filemap_map_pages())
Message-ID: <20200921091143.GB5862@quack2.suse.cz>
References: <20200623052059.1893966-1-david@fromorbit.com>
 <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz>
 <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils>
 <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils>
 <20200921082600.GO12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921082600.GO12131@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-09-20 18:26:00, Dave Chinner wrote:
> On Thu, Sep 17, 2020 at 12:47:10AM -0700, Hugh Dickins wrote:
> > It's because POSIX demanded that when a file
> > is truncated, the user will get SIGBUS on trying to access even the
> > COWed pages beyond EOF in a MAP_PRIVATE mapping.  Page lock on the
> > cache page does not serialize the pages COWed from it very well.
> 
> And there's the "why". I don't find the "page lock doesn't
> serialise COW faults very well" particularly reassuring in this
> case....
> 
> > But there's no such SIGBUS requirement in the case of hole-punching,
> > and trying to unmap those pages racily instantiated just after the
> > punching cursor passed, would probably do more harm than good.
> 
> There isn't a SIGBUS requirement for fallocate operations, just a
> "don't expose stale data to userspace" requirement.
> 
> FWIW, how does a COW fault even work with file backed pages? We can
> only have a single page attached to the inode address space for a given
> offset, so if there's been a COW fault and a new page faulted in for
> the write fault in that VMA, doesn't that imply the user data then
> written to that page is never going to be written back to storage
> because the COW page is not tracked by the inode address space?

Correct. Private file mappings work so that on first write fault on some
page offset we allocate anonymous page for that offset, copy to it current
contents of the corresponding file page, and from that moment on it behaves
as an anonymous page. Except that on truncate, we have to unmap these
anonymous pages in private file mappings as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
