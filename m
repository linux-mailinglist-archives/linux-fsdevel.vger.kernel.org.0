Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F406340541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 13:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCRMPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 08:15:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhCRMPA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:15:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BFB6AD8A;
        Thu, 18 Mar 2021 12:14:59 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id c1198254;
        Thu, 18 Mar 2021 12:16:15 +0000 (UTC)
Date:   Thu, 18 Mar 2021 12:16:14 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <YFNEjnjF+RujYOL0@suse.de>
References: <CAJfpegu+T-4m=OLMorJrZyWaDNff1eviKUaE2gVuMmLG+g9JVQ@mail.gmail.com>
 <YEtc54pWLLjb6SgL@suse.de>
 <20210312131123.GZ3479805@casper.infradead.org>
 <YE8tQc66C6MW7EqY@suse.de>
 <20210315110659.GT2577561@casper.infradead.org>
 <YFMct4z1gEa8tXkh@suse.de>
 <CAJfpeguX7NrdTH4JLbCtkQ1u7TFvUh+8s7RmwB_wmuPHJsQyiA@mail.gmail.com>
 <20210318110302.nxddmrhmgmlw4adq@black.fi.intel.com>
 <YFM5mEZ8dZBhZWLI@suse.de>
 <20210318115543.GM3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318115543.GM3420@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:55:43AM +0000, Matthew Wilcox wrote:
> On Thu, Mar 18, 2021 at 11:29:28AM +0000, Luis Henriques wrote:
> > On Thu, Mar 18, 2021 at 02:03:02PM +0300, Kirill A. Shutemov wrote:
> > > On Thu, Mar 18, 2021 at 11:59:59AM +0100, Miklos Szeredi wrote:
> > > > > [16247.536348] page:00000000dfe36ab1 refcount:673 mapcount:0 mapping:00000000f982a7f8 index:0x1400 pfn:0x4c65e00
> > > > > [16247.536359] head:00000000dfe36ab1 order:9 compound_mapcount:0 compound_pincount:0
> > > > 
> > > > This is a compound page alright.   Have no idea how it got into fuse's
> > > > pagecache.
> > > 
> > > 
> > > Luis, do you have CONFIG_READ_ONLY_THP_FOR_FS enabled?
> > 
> > Yes, it looks like Tumbleweed kernels have that config option enabled by
> > default.  And it this feature was introduced in 5.4 (the bug doesn't seem
> > to be reproducible in 5.3).
> 
> Can you try adding this patch?
> 
> https://git.infradead.org/users/willy/pagecache.git/commitdiff/369a4fcd78369b7a026bdef465af9669bde98ef4

Yep, sure.  Unfortunately, the testing round-trip can be a bit high.  I'll
push a new kernel build and ask the reporter to give it a try.

[ I'll add this patch on top of the s/BUG_ON/VM_BUG_ON_PAGE change. ]

Cheers,
--
Luís
