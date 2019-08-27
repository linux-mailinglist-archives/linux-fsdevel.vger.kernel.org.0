Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5379F06B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfH0Qie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 12:38:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbfH0Qie (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F11E3082E55;
        Tue, 27 Aug 2019 16:38:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 087345D70D;
        Tue, 27 Aug 2019 16:38:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9207122017B; Tue, 27 Aug 2019 12:38:28 -0400 (EDT)
Date:   Tue, 27 Aug 2019 12:38:28 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20190827163828.GA6859@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826115152.GA21051@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 27 Aug 2019 16:38:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 26, 2019 at 04:51:52AM -0700, Christoph Hellwig wrote:
> On Wed, Aug 21, 2019 at 01:57:02PM -0400, Vivek Goyal wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Although struct dax_device itself is not tied to a block device, some
> > DAX code assumes there is a block device.  Make block devices optional
> > by allowing bdev to be NULL in commonly used DAX APIs.
> > 
> > When there is no block device:
> >  * Skip the partition offset calculation in bdev_dax_pgoff()
> >  * Skip the blkdev_issue_zeroout() optimization
> > 
> > Note that more block device assumptions remain but I haven't reach those
> > code paths yet.
> 
> I think this should be split into two patches.

Hi Christoph,

Ok, will split in two patches. In fact, I think will completley drop
the second change right now as I think we might not be hitting that
path yet.

> For bdev_dax_pgoff
> I'd much rather have the partition offset if there is on in the daxdev
> somehow so that we can get rid of the block device entirely.

IIUC, there is one block_device per partition while there is only one
dax_device for the whole disk. So we can't directly move bdev logical
offset into dax_device.

We probably could put this in "iomap" and leave it to filesystems to
report offset into dax_dev in iomap that way dax generic code does not
have to deal with it. But that probably will be a bigger change.

Did I misunderstand your suggestion.

> 
> Similarly for dax_range_is_aligned I'd rather have a pure dax way
> to offload zeroing rather than this bdev hack.

Following commig introduced the change to write zeros through block
device path.

commit 4b0228fa1d753f77fe0e6cf4c41398ec77dfbd2a
Author: Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu Apr 21 15:13:46 2016 -0400

 dax: for truncate/hole-punch, do zeroing through the driver if possible

IIUC, they are doing it so that they can clear gendisk->badblocks list.

So even if there is pure dax way to do it, there will have to some
involvment of block layer to clear gendisk->badblocks list.

I am not sure I fully understand your suggestion. But I am hoping its
not a must for these changes to make a progress. For now, I will drop
change to dax_range_is_aligned().

Thanks
Vivek
