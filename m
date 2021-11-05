Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D574445E73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhKEDMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 23:12:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34350 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229647AbhKEDMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:12:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A539JCp001043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Nov 2021 23:09:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 215AA15C00B9; Thu,  4 Nov 2021 23:09:19 -0400 (EDT)
Date:   Thu, 4 Nov 2021 23:09:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Sandeen <sandeen@sandeen.net>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: futher decouple DAX from block devices
Message-ID: <YYSgX9FI0kaGLeR0@mit.edu>
References: <20211018044054.1779424-1-hch@lst.de>
 <21ff4333-e567-2819-3ae0-6a2e83ec7ce6@sandeen.net>
 <20211104081740.GA23111@lst.de>
 <20211104173417.GJ2237511@magnolia>
 <20211104173559.GB31740@lst.de>
 <CAPcyv4jbjc+XtX5RX5OL3vPadsYZwoK1NG1qC5AcpySBu5tL4g@mail.gmail.com>
 <20211104190443.GK24333@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104190443.GK24333@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 12:04:43PM -0700, Darrick J. Wong wrote:
> > Note that I've avoided implementing read/write fops for dax devices
> > partly out of concern for not wanting to figure out shared-mmap vs
> > write coherence issues, but also because of a bet with Dave Hansen
> > that device-dax not grow features like what happened to hugetlbfs. So
> > it would seem mkfs would need to switch to mmap I/O, or bite the
> > bullet and implement read/write fops in the driver.
> 
> That ... would require a fair amount of userspace changes, though at
> least e2fsprogs has pluggable io drivers, which would make mmapping a
> character device not too awful.
> 
> xfsprogs would be another story -- porting the buffer cache mignt not be
> too bad, but mkfs and repair seem to issue pread/pwrite calls directly.
> Note that xfsprogs explicitly screens out chardevs.

It's not just e2fsprogs and xfsprogs.  There's also udev, blkid,
potententially systemd unit generators to kick off fsck runs, etc.
There are probably any number of user scripts which assume that file
systems are mounted on block devices --- for example, by looking at
the output of lsblk, etc.

Also note that block devices have O_EXCL support to provide locking
against attempts to run mkfs on a mounted file system.  If you move
dax file systems to be mounted on a character mode device, that would
have to be replicated as well, etc.  So I suspect that a large number
of subtle things would break, and I'd strongly recommend against going
down that path.

						- Ted
