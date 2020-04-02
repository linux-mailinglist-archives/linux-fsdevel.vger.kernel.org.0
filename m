Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A2419BE28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgDBIxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 04:53:30 -0400
Received: from verein.lst.de ([213.95.11.211]:47447 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387875AbgDBIxa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:53:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EFB8368C4E; Thu,  2 Apr 2020 10:53:27 +0200 (CEST)
Date:   Thu, 2 Apr 2020 10:53:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200402085327.GA19109@lst.de>
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de> <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia> <20200311062952.GA11519@lst.de> <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com> <20200316095224.GF12783@quack2.suse.cz> <20200316095509.GA13788@lst.de> <20200401040021.GC56958@magnolia> <20200401102511.GC19466@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401102511.GC19466@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:25:11PM +0200, Jan Kara wrote:
> >  - Applications must call statx to discover the current S_DAX state.
> > 
> >  - There exists an advisory file inode flag FS_XFLAG_DAX that can be
> >    changed on files that have no blocks allocated to them.  Changing
> >    this flag does not necessarily change the S_DAX state immediately
> >    but programs can query the S_DAX state via statx.
> 
> I generally like the proposal but I think the fact that toggling
> FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite some
> confusion and ultimately bug reports. I'm thinking whether we could somehow
> improve this... For example an ioctl that would try to make set inode flags
> effective by evicting the inode (and returning EBUSY if the eviction is
> impossible for some reason)?

I'd just return an error for that case, don't play silly games like
evicting the inode.
