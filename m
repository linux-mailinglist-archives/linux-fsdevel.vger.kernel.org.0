Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D20B186837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgCPJwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 05:52:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:42708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgCPJwa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:52:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8A7E7B117;
        Mon, 16 Mar 2020 09:52:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 555B51E10DA; Mon, 16 Mar 2020 10:52:24 +0100 (CET)
Date:   Mon, 16 Mar 2020 10:52:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200316095224.GF12783@quack2.suse.cz>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-03-20 10:07:18, Dan Williams wrote:
> On Tue, Mar 10, 2020 at 11:30 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Mar 10, 2020 at 08:36:14PM -0700, Darrick J. Wong wrote:
> > > 1) Leave the inode flag (FS_XFLAG_DAX) as it is, and export the S_DAX
> > > status via statx.  Document that changes to FS_XFLAG_DAX do not take
> > > effect immediately and that one must check statx to find out the real
> > > mode.  If we choose this, I would also deprecate the dax mount option;
> > > send in my mkfs.xfs patch to make it so that you can set FS_XFLAG_DAX on
> > > all files at mkfs time; and we can finally lay this whole thing to rest.
> > > This is the closest to what we have today.
> > >
> > > 2) Withdraw FS_XFLAG_DAX entirely, and let the kernel choose based on
> > > usage patterns, hardware heuristics, or spiteful arbitrariness.
> >
> > 3) Only allow changing FS_XFLAG_DAX on directories or files that do
> > not have blocks allocated to them yet, and side step all the hard
> > problems.
> 
> This sounds reasonable to me.
> 
> As for deprecating the mount option, I think at a minimum it needs to
> continue be accepted as an option even if it is ignored to not break
> existing setups.

Agreed. But that's how we usually deprecate mount options. Also I'd say
that statx() support for reporting DAX state and some education of
programmers using DAX is required before we deprecate the mount option
since currently applications check 'dax' mount option to determine how much
memory they need to set aside for page cache before they consume everything
else on the machine...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
