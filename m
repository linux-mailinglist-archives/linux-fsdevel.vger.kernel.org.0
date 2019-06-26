Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF156F95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFZReh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 13:34:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34158 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZReh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:34:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHYK8a060304;
        Wed, 26 Jun 2019 17:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ZmczIJ8ZvCsuRmej6aNezFGFTkOxfkS37PS+rm8DgLI=;
 b=pKCcYBgFU7Sa/6JuLt5X7DoXHdtlnnEapfwyBeexuV7VsnwURPaRnQ0/taeS2abF197N
 jGV1LfG86dR67TjkJjhoiPl7IgbtcA3WXctHuf9GOf4GdHZBt5SSP5Uq6jUeZVAOZMcv
 n1lBEC3O1hn+QUs3r41mG8cLTkRs1ZeO1WOcddNBVSsO15l9cicGFVAEpweaZmZcte2H
 zNCr4lQwSfB7Y7rH8St3qqEZUWpFs4pOdIaZNykO4aaJp5sk5wZnqgIxIEBZEf1n5nRJ
 wHiHZZtumu8zZIBYRgF9nrqWdv7aUVT13A1jzcozf74qcPM6omjHR+4xxnRTTF1I7Gma RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtbsxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 17:34:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QHWnPm160244;
        Wed, 26 Jun 2019 17:34:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6uwcsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 17:34:28 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QHYRGB032455;
        Wed, 26 Jun 2019 17:34:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 10:34:26 -0700
Date:   Wed, 26 Jun 2019 10:34:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190626173425.GA5164@magnolia>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
 <20190624070734.GB3675@lst.de>
 <20190625191442.m27cwx5o6jtu2qch@fiona>
 <20190626063957.GA24201@lst.de>
 <20190626161017.rzkktei2ngznhbat@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626161017.rzkktei2ngznhbat@fiona>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260207
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:10:17AM -0500, Goldwyn Rodrigues wrote:
> On  8:39 26/06, Christoph Hellwig wrote:
> > On Tue, Jun 25, 2019 at 02:14:42PM -0500, Goldwyn Rodrigues wrote:
> > > > I can't say I'm a huge fan of this two iomaps in one method call
> > > > approach.  I always though two separate iomap iterations would be nicer,
> > > > but compared to that even the older hack with just the additional
> > > > src_addr seems a little better.
> > > 
> > > I am just expanding on your idea of using multiple iterations for the Cow case
> > > in the hope we can come out of a good design:
> > > 
> > > 1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
> > >    which calls iomap_begin() for the respective filesystem.
> > > 2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
> > >    struct with read addr information.
> > > 3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
> > >    and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).
> > > 4. btrfs_iomap_begin() fills up iomap structure with write information.
> > > 
> > > Step 3 seems out of place because iomap_apply should be iomap.type agnostic.
> > > Right?
> > > Should we be adding another flag IOMAP_COW_DONE, just to figure out that
> > > this is the "real" write for iomap_begin to fill iomap?
> > > 
> > > If this is not how you imagined, could you elaborate on the dual iteration
> > > sequence?
> > 
> > Here are my thoughts from dealing with this from a while ago, all
> > XFS based of course.
> > 
> > If iomap_file_buffered_write is called on a page that is inside a COW
> > extent we have the following options:
> > 
> >  a) the page is updatodate or entirely overwritten.  We cn just allocate
> >     new COW blocks and return them, and we are done
> >  b) the page is not/partially uptodate and not entirely overwritten.
> > 
> > The latter case is the interesting one.  My thought was that iff the
> > IOMAP_F_SHARED flag is set __iomap_write_begin / iomap_read_page_sync
> > will then have to retreive the source information in some form.
> > 
> > My original plan was to just do a nested iomap_apply call, which would
> > need a special nested flag to not duplicate any locking the file
> > system might be holding between ->iomap_begin and ->iomap_end.
> > 
> > The upside here is that there is no additional overhead for the non-COW
> > path and the architecture looks relatively clean.  The downside is that
> > at least for XFS we usually have to look up the source information
> > anyway before allocating the COW destination extent, so we'd have to
> > cache that information somewhere or redo it, which would be rather
> > pointless.  At that point the idea of a srcaddr in the iomap becomes
> > interesting again - while it looks a little ugly from the architectural
> > POV it actually ends up having very practical benefits.

I think it's less complicated to pass both mappings out in a single
->iomap_begin call rather than have this dance where the fs tells iomap
to call back for the read mapping and then iomap calls back for the read
mapping with a special "don't take locks" flag.

For XFS specifically this means we can serve both mappings with a single
ILOCK cycle.

> So, do we move back to the design of adding an extra field of srcaddr?

TLDR: Please no.

> Honestly, I find the design of using an extra field srcaddr in iomap better
> and simpler versus passing additional iomap srcmap or multiple iterations.

Putting my long-range planning hat on, the usage story (from the fs'
perspective) here is:

"iomap wants to know how a file write should map to a disk write.  If
we're doing a straight overwrite of disk blocks then I should send back
the relevant mapping.  Sometimes I might need the write to go to a
totally different location than where the data is currently stored, so I
need to send back a second mapping."

Because iomap is now a general-purpose API, we need to think about the
read mapping for a moment:

 - For all disk-based filesystems we'll want the source address for the
   read mapping.

 - For filesystems that support "inline data" (which really just means
   the fs maintains its own buffers to file data) we'll also need the
   inline_data pointer.

 - For filesystems that support multiple devices (like btrfs) we'll also
   need a pointer to a block_device because we could be writing to a
   different device than the one that stores the data.  The prime
   example I can think of is reading data from disk A in some RAID
   stripe and writing to disk B in a different RAID stripe to solve the
   RAID5 hole... but you could just be lazy-migrating file data to less
   full or newer drives or whatever.

 - If we ever encounter a filesystem that supports multiple dax devices
   then we'll need a pointer to the dax_device too.  (That would be
   btrfs, since I thought your larger goal was to enable dax there...)

 - We're probably going to need the ability to pass flags for the read
   mapping at some point or another, so we need that too.

From this, you can see that we need half the fields in the existing
struct iomap, and that's how I arrived at the idea of passing to
iomap_begin pointers to two iomaps instead of bolting these five fields
into struct iomap.

In XFS parlance (where the data fork stores mappings for on-disk data
and the cow fork stores mappings for), this means that our iomap_begin
data paths remain fairly straightforward:

	xfs_bmapi_read(ip, offset, XFS_DATA_FORK, &imap...);
	xfs_bmapi_read(ip, offset, XFS_COW_FORK, &cmap...);

	xfs_bmbt_to_iomap(ip, iomap, &imap...);
	iomap->type = IOMAP_COW;
	xfs_bmbt_to_iomap(ip, srcmap, &cmap...);

(It's more complicated than that, but that's approximately what we do
now.)

> Also, should we add another iomap type IOMAP_COW, or (re)use the flag
> IOMAP_F_SHARED during writes? IOW iomap type vs iomap flag.

I think they need to remain distinct types because the IOMAP_F_SHARED
flag means that the storage is shared amongst multiple owners (which
iomap_fiemap reports to userspace), whereas the IOMAP_COW type means
that RMW is required for unaligned writes.

btrfs has a strong tendency to require copy writes, but that doesn't
mean the extent is necessarily shared.

> Dave/Darrick, what are your thoughts?

I liked where the first 3 patches of this series were heading. :)

--D

> 
> -- 
> Goldwyn
