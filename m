Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8E919D131
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgDCH1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 03:27:34 -0400
Received: from verein.lst.de ([213.95.11.211]:51430 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730889AbgDCH1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:27:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7785668BFE; Fri,  3 Apr 2020 09:27:31 +0200 (CEST)
Date:   Fri, 3 Apr 2020 09:27:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
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
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200403072731.GA24176@lst.de>
References: <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia> <20200311062952.GA11519@lst.de> <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com> <20200316095224.GF12783@quack2.suse.cz> <20200316095509.GA13788@lst.de> <20200401040021.GC56958@magnolia> <20200401102511.GC19466@quack2.suse.cz> <20200402085327.GA19109@lst.de> <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:55:19PM -0700, Ira Weiny wrote:
> > I'd just return an error for that case, don't play silly games like
> > evicting the inode.
> 
> I think I agree with Christoph here.  But I want to clarify.  I was heading in
> a direction of failing the ioctl completely.  But we could have the flag change
> with an appropriate error which could let the user know the change has been
> delayed.
> 
> But I don't immediately see what error code is appropriate for such an
> indication.  Candidates I can envision:
> 
> EAGAIN
> ERESTART
> EUSERS
> EINPROGRESS
> 
> None are perfect but I'm leaning toward EINPROGRESS.

I really, really dislike that idea.  The whole point of not forcing
evictions is to make it clear - no this inode is "busy" you can't
do that.  A reasonably smart application can try to evict itself.

But returning an error and doing a lazy change anyway is straight from
the playbook for arcane and confusing API designs.
