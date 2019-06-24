Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9250916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 12:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfFXKlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 06:41:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:45774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729093AbfFXKlK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:41:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25CE6AD4A;
        Mon, 24 Jun 2019 10:41:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB76B1E2F23; Mon, 24 Jun 2019 12:41:06 +0200 (CEST)
Date:   Mon, 24 Jun 2019 12:41:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Liu Bo <obuil.liubo@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: a few questions about pagevc_lookup_entries
Message-ID: <20190624104106.GC32376@quack2.suse.cz>
References: <CANQeFDCCGED3BR0oTpzQ75gtGpdGCw8FLf+kspBYytw3YteXAw@mail.gmail.com>
 <20190620083628.GH13630@quack2.suse.cz>
 <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
 <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-06-19 09:25:00, Miklos Szeredi wrote:
> [cc: vivek, stefan, dgilbert]
> 
> On Fri, Jun 21, 2019 at 12:04 AM Liu Bo <obuil.liubo@gmail.com> wrote:
> >
> > On Thu, Jun 20, 2019 at 1:36 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > [added some relevant lists to CC - this can safe some people debugging by
> > > being able to google this discussion]
> > >
> > > On Wed 19-06-19 15:57:38, Liu Bo wrote:
> > > > I found a weird dead loop within invalidate_inode_pages2_range, the
> > > > reason being that  pagevec_lookup_entries(index=1) returns an indices
> > > > array which has only one entry storing value 0, and this has led
> > > > invalidate_inode_pages2_range() to a dead loop, something like,
> > > >
> > > > invalidate_inode_pages2_range()
> > > >   -> while (pagevec_lookup_entries(index=1, indices))
> > > >     ->  for (i = 0; i < pagevec_count(&pvec); i++) {
> > > >       -> index = indices[0]; // index is set to 0
> > > >       -> if (radix_tree_exceptional_entry(page)) {
> > > >           -> if (!invalidate_exceptional_entry2()) //
> > > >                   ->__dax_invalidate_mapping_entry // return 0
> > > >                      -> // entry marked as PAGECACHE_TAG_DIRTY/TOWRITE
> > > >                  ret = -EBUSY;
> > > >           ->continue;
> > > >           } // end of if (radix_tree_exceptional_entry(page))
> > > >     -> index++; // index is set to 1
> > > >
> > > > The following debug[1] proved the above analysis,  I was wondering if
> > > > this was a corner case that  pagevec_lookup_entries() allows or a
> > > > known bug that has been fixed upstream?
> > > >
> > > > ps: the kernel in use is 4.19.30 (LTS).
> > >
> > > Hum, the above trace suggests you are using DAX. Are you really? Because the
> > > stacktrace below shows we are working on fuse inode so that shouldn't
> > > really be DAX inode...
> > >
> >
> > So I was running tests against virtiofs[1] which adds dax support to
> > fuse, with dax, fuse provides posix stuff while dax provides data
> > channel.
> >
> > [1]: https://virtio-fs.gitlab.io/
> > https://gitlab.com/virtio-fs/linux

OK, thanks for the explanation and the pointer. So if I should guess, I'd
say that there's some problem with multiorder entries (for PMD pages) in
the radix tree. In particular if you lookup index 1 and there's
multiorder entry for indices 0-511, radix_tree_next_chunk() is updating
iter->index like:

iter->index = (index &~ node_maxindex(node)) | (offset << node->shift);

and offset is computed by radix_tree_descend() as:

offset = (index >> parent->shift) & RADIX_TREE_MAP_MASK;

So this all results in iter->index being set to 0 and thus confusing the
iteration in invalidate_inode_pages2_range(). Current kernel has xarray
code from Matthew which maintains originally passed index in xas.xa_index
and thus the problem isn't there.

So to sum up: Seems like a DAX-specific bug with PMD entries in older
kernels fixed by xarray rewrite.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
