Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541D62C8772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgK3PKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:10:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:48040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgK3PKE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:10:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7FBA5AB63;
        Mon, 30 Nov 2020 15:09:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AF5E1E131B; Mon, 30 Nov 2020 16:09:23 +0100 (CET)
Date:   Mon, 30 Nov 2020 16:09:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201130150923.GM11250@quack2.suse.cz>
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz>
 <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 30-11-20 06:22:42, Amy Parker wrote:
> > > +/*
> > > + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> > > + * definition helps with checking if an entry is a PMD size.
> > > + */
> > > +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> > > +
> >
> > Firstly, if you define a macro, we usually wrap it inside braces like:
> >
> > #define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)
> >
> > to avoid unexpected issues when macro expands and surrounding operators
> > have higher priority.
> 
> Oops! Must've missed that - I'll make sure to get on that when
> revising this patch.
> 
> > Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
> > other bits for that matter). XA_ZERO_ENTRY is defined as
> > xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
> > the bits xarray internal entries are using and things will break.
> 
> Could you provide an example of this overlap? I can't seem to find any.

Well XA_ZERO_ENTRY | DAX_PMD == ((257 << 2) | 2) | (1 << 1). So the way
you've defined XA_ZERO_PMD_ENTRY the DAX_PMD will just get lost. AFAIU (but
Matthew might correct me here), for internal entries (and XA_ZERO_ENTRY is
one instance of such entry) low 10-bits of the of the entry values are
reserved for internal xarray usage so DAX could use only higher bits. For
classical value entries, only the lowest bit is reserved for xarray usage,
all the rest is available for the user (and so DAX uses it).
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
