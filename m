Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFA19CC1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbgDBUzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 16:55:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:46980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgDBUzV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:55:21 -0400
IronPort-SDR: HvX8PTnsRwsdV7NgJbUfU0c8d8qEGuDIWYKkfp6qg1t4NgkZEVSEZhF+lJsaHGmNws25xH9pv2
 zG5CuBBU+CEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 13:55:20 -0700
IronPort-SDR: n7VuT2YXbKLcmeUbGxcVNFXBqmmw/fPac17FJw0a0KoOKT0y+uax/DxdhYqSxrNozLBsG2D32X
 Ll5cGSDLDUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="253141592"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2020 13:55:19 -0700
Date:   Thu, 2 Apr 2020 13:55:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
References: <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402085327.GA19109@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:53:27AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 01, 2020 at 12:25:11PM +0200, Jan Kara wrote:
> > >  - Applications must call statx to discover the current S_DAX state.
> > > 
> > >  - There exists an advisory file inode flag FS_XFLAG_DAX that can be
> > >    changed on files that have no blocks allocated to them.  Changing
> > >    this flag does not necessarily change the S_DAX state immediately
> > >    but programs can query the S_DAX state via statx.
> > 
> > I generally like the proposal but I think the fact that toggling
> > FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite some
> > confusion and ultimately bug reports. I'm thinking whether we could somehow
> > improve this... For example an ioctl that would try to make set inode flags
> > effective by evicting the inode (and returning EBUSY if the eviction is
> > impossible for some reason)?
> 
> I'd just return an error for that case, don't play silly games like
> evicting the inode.

I think I agree with Christoph here.  But I want to clarify.  I was heading in
a direction of failing the ioctl completely.  But we could have the flag change
with an appropriate error which could let the user know the change has been
delayed.

But I don't immediately see what error code is appropriate for such an
indication.  Candidates I can envision:

EAGAIN
ERESTART
EUSERS
EINPROGRESS

None are perfect but I'm leaning toward EINPROGRESS.

Ira

