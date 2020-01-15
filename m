Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90EC13C2D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgAONbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:31:07 -0500
Received: from verein.lst.de ([213.95.11.211]:50875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgAONbG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:31:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D61968BE1; Wed, 15 Jan 2020 14:31:02 +0100 (CET)
Date:   Wed, 15 Jan 2020 14:31:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200115133101.GA28583@lst.de>
References: <4467.1579020509@warthog.procyon.org.uk> <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <27181AE2-C63F-4932-A022-8B0563C72539@dilger.ca> <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa71c13-4f99-747a-54ec-579f11f066a0@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 09:10:44PM +0800, Qu Wenruo wrote:
> > That allows userspace to distinguish fe_physical addresses that may be
> > on different devices.  This isn't in the kernel yet, since it is mostly
> > useful only for Btrfs and nobody has implemented it there.  I can give
> > you details if working on this for Btrfs is of interest to you.
> 
> IMHO it's not good enough.
> 
> The concern is, one extent can exist on multiple devices (mirrors for
> RAID1/RAID10/RAID1C2/RAID1C3, or stripes for RAID5/6).
> I didn't see how it can be easily implemented even with extra fields.
> 
> And even we implement it, it can be too complex or bug prune to fill
> per-device info.

It's also completely bogus for the use cases to start with.  fiemap
is a debug tool reporting the file system layout.  Using it for anything
related to actual data storage and data integrity is a receipe for
disaster.  As said the right thing for the use case would be something
like the NFS READ_PLUS operation.  If we can't get that easily it can
be emulated using lseek SEEK_DATA / SEEK_HOLE assuming no other thread
could be writing to the file, or the raciness doesn't matter.
