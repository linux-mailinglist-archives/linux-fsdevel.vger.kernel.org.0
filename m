Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC12C89A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgK3Qg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 11:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgK3Qg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:36:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5916DC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R/mYrAuM6HJ5dplwYrxtauyrJsCnlcPUH62gURHkukM=; b=WPLp/2czeIoARj8uA2AnAXatRN
        MeICvSZiLjGS5aN2+lX2557O+eXW6JLOOPPM2nR+WjpWDmVS0o8qTkqPE0tPQtVhmCZ6VnZCvbe4V
        h24mPylFlAtvN7tr4hnYFeuRuMPHvBL9pJJaJTC0OafA8zQpjA07Dq9kqzsUL8SgmAtztHRkwP4CC
        6S9ShxQNFAQyVQ96T6HuBalRieK3bvJAcc0++jOszPX49rMQgVesMczJPh7+n76c0gw440FMHgyC8
        Wjva69Eqtr7xUgSNFKJQZ7n9DL6lWPGNPRuQaoE3i26MB3baTxcbiYFZPTePAyHzngbCvtn0y2Wtc
        bGsiHtwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjm9t-0000qT-EN; Mon, 30 Nov 2020 16:36:13 +0000
Date:   Mon, 30 Nov 2020 16:36:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201130163613.GE4327@casper.infradead.org>
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz>
 <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
 <20201130150923.GM11250@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130150923.GM11250@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 04:09:23PM +0100, Jan Kara wrote:
> On Mon 30-11-20 06:22:42, Amy Parker wrote:
> > > > +/*
> > > > + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> > > > + * definition helps with checking if an entry is a PMD size.
> > > > + */
> > > > +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> > > > +
> > >
> > > Firstly, if you define a macro, we usually wrap it inside braces like:
> > >
> > > #define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)
> > >
> > > to avoid unexpected issues when macro expands and surrounding operators
> > > have higher priority.
> > 
> > Oops! Must've missed that - I'll make sure to get on that when
> > revising this patch.
> > 
> > > Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
> > > other bits for that matter). XA_ZERO_ENTRY is defined as
> > > xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
> > > the bits xarray internal entries are using and things will break.
> > 
> > Could you provide an example of this overlap? I can't seem to find any.
> 
> Well XA_ZERO_ENTRY | DAX_PMD == ((257 << 2) | 2) | (1 << 1). So the way
> you've defined XA_ZERO_PMD_ENTRY the DAX_PMD will just get lost. AFAIU (but
> Matthew might correct me here), for internal entries (and XA_ZERO_ENTRY is
> one instance of such entry) low 10-bits of the of the entry values are
> reserved for internal xarray usage so DAX could use only higher bits. For
> classical value entries, only the lowest bit is reserved for xarray usage,
> all the rest is available for the user (and so DAX uses it).

The XArray entries are pretty inventive in how they are used ...

1. If bit 0 is set, it's a value entry.  That is, it encodes an integer
between 0 and LONG_MAX.
2. If bits 0 & 1 are clear, it's a pointer.
3. If bit 0 is clear and bit 1 is set, it's _either_ an internal entry,
_or_ it's a pointer that's only 2-byte aligned.  These can exist on m68k,
alas.

Internal entries above -MAX_ERRNO are used for returning errors.
Internal entries below 1024 (256 << 2) are used for sibling entries.
Internal entry 256 is the retry entry.
Internal entry 257 is the zero entry.
Internal entries 258-1023 are not currently used.
Internal entries between 4096 and MAX_ERRNO are pointers to the next
level of the tree.

The m68k pointer problem is "solved" by only allowing them to be in a
node which is the bottom of the tree.  This means that the optimisation
of placing a single pointer at index 0 in the root of the tree has to be
disabled for these pointers.  That's unfortunate, but there's no other
way to solve it, given the need for RCU readers.  You also can't use
an m68k pointer for a multi-index entry.

There's also support for pointers tagged in their lower bits.  Those are
incompatible with value entries.  And you can't use pointer tag 2 ...
