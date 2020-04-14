Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498461A8BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505365AbgDNUAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 16:00:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:10312 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505359AbgDNUAV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:00:21 -0400
IronPort-SDR: Adh2bSGjpAj5C5lb+kuGh7dFOpnidmodv17mXdXnZ8tvgWLcRe0IoTJPbR3XdIFvKyY4MNgZz4
 7ZwPp4l1EWpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 13:00:17 -0700
IronPort-SDR: lhbGUOmvotbhMVvY0OCmgMZTQi0sG5VUHFqwvb87jAD3F8K/dEr9Zz6Qqi7g2um/4m6S5r9ckW
 Ni0dXCw+E5ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="242092945"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 13:00:15 -0700
Date:   Tue, 14 Apr 2020 13:00:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200414200015.GF1853609@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
 <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
 <20200414161509.GF6742@magnolia>
 <CAPcyv4hr+NKbpAU4UhKcmHfvDq1+GTM+y+K28XGbkDYBP=Kaag@mail.gmail.com>
 <20200414195754.GH6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414195754.GH6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:57:54PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 14, 2020 at 12:04:57PM -0700, Dan Williams wrote:
> > On Tue, Apr 14, 2020 at 9:15 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:

[snip]

> > > > > +
> > > > > +Enabling DAX on xfs
> > > > > +-------------------
> > > > > +
> > > > > +Summary
> > > > > +-------
> > > > > +
> > > > > + 1. There exists an in-kernel access mode flag S_DAX that is set when
> > > > > +    file accesses go directly to persistent memory, bypassing the page
> > > > > +    cache.
> > > >
> > > > I had reserved some quibbling with this wording, but now that this is
> > > > being proposed as documentation I'll let my quibbling fly. "dax" may
> > > > imply, but does not require persistent memory nor does it necessarily
> > > > "bypass page cache". For example on configurations that support dax,
> > > > but turn off MAP_SYNC (like virtio-pmem), a software flush is
> > > > required. Instead, if we're going to define "dax" here I'd prefer it
> > > > be a #include of the man page definition that is careful (IIRC) to
> > > > only talk about semantics and not backend implementation details. In
> > > > other words, dax is to page-cache as direct-io is to page cache,
> > > > effectively not there, but dig a bit deeper and you may find it.
> > >
> > > Uh, which manpage?  Are you talking about the MAP_SYNC documentation?
> > 
> > No, I was referring to the proposed wording for STATX_ATTR_DAX.
> > There's no reason for this description to say anything divergent from
> > that description.
> 
> Ahh, ok.  Something like this, then:
> 
>  1. There exists an in-kernel access mode flag S_DAX.  When set, the
>     file is in the DAX (cpu direct access) state.  DAX state attempts to
>     minimize software cache effects for both I/O and memory mappings of
>     this file.  The S_DAX state is exposed to userspace via the
>     STATX_ATTR_DAX statx flag.
> 
>     See the STATX_ATTR_DAX in the statx(2) manpage for more information.

We crossed in the ether!!!  I propose even less details here...  Leave all the
details to the man page.

<quote>
1. There exists an in-kernel access mode flag S_DAX that is set when file
    accesses is enabled for 'DAX'.  Applications must call statx to discover
    the current S_DAX state (STATX_ATTR_DAX).  See the man page for statx for
    more details.
</quote>

Ira

