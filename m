Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0155319DA83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbgDCPsc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 11:48:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:63004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390961AbgDCPs3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:48:29 -0400
IronPort-SDR: +cm6KxcsVqXcpJym4XiAEOQX1UnV6VdN1TAo8Ebm2WccGQiEYzQHwTi97q4HRn+RK5FSMWpvHN
 UGxn7GCApQ7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 08:48:29 -0700
IronPort-SDR: ZXmfRSMQd94WvJqmsBYTXypFkx/d2A0QL6wEIdSitKSObwXXiefBliL2qHOBmf5p/n0SmgtCTn
 iqQ2h2nMcR5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="285157139"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2020 08:48:29 -0700
Date:   Fri, 3 Apr 2020 08:48:29 -0700
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
Message-ID: <20200403154828.GJ3952565@iweiny-DESK2.sc.intel.com>
References: <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403072731.GA24176@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:27:31AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 02, 2020 at 01:55:19PM -0700, Ira Weiny wrote:
> > > I'd just return an error for that case, don't play silly games like
> > > evicting the inode.
> > 
> > I think I agree with Christoph here.  But I want to clarify.  I was heading in
> > a direction of failing the ioctl completely.  But we could have the flag change
> > with an appropriate error which could let the user know the change has been
> > delayed.
> > 
> > But I don't immediately see what error code is appropriate for such an
> > indication.  Candidates I can envision:
> > 
> > EAGAIN
> > ERESTART
> > EUSERS
> > EINPROGRESS
> > 
> > None are perfect but I'm leaning toward EINPROGRESS.
> 
> I really, really dislike that idea.  The whole point of not forcing
> evictions is to make it clear - no this inode is "busy" you can't
> do that.  A reasonably smart application can try to evict itself.

I don't understand.  What Darrick proposed would never need any evictions.  If
the file has blocks allocated the FS_XFLAG_DAX flag can not be changed.  So I
don't see what good eviction would do at all.

> 
> But returning an error and doing a lazy change anyway is straight from
> the playbook for arcane and confusing API designs.

Jan countered with a proposal that the FS_XFLAG_DAX does change with blocks
allocated.  But that S_DAX would change on eviction.  Adding that some eviction
ioctl could be added.

You then proposed just returning an error for that case.  (This lead me to
believe that you were ok with an eviction based change of S_DAX.)

So I agreed that changing S_DAX could be delayed until an explicit eviction.
But, to aid the 'smart application', a different error code could be used to
indicate that the FS_XFLAG_DAX had been changed but that until that explicit
eviction occurs S_DAX would remain.

So I don't fully follow what you mean by 'lazy change'?

Do you still really, really dislike an explicit eviction method for changing
the S_DAX flag?

If FS_XFLAG_DAX can never be changed on a file with blocks allocated and the
user wants to change the mode of operations on their 'data'; they would have to
create a new file with the proper setting and move the data there.  For example
copy the file into a directory marked FS_XFLAG_DAX==true?

I'm ok with either interface as I think both could be clear if documented.

Jan?

Ira

