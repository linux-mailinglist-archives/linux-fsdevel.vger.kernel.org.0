Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2D3264AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJRQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:16:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgIJRP7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599758152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V5RVkZoHNNgO8iRkts2uQucFzF0PqLciDsVyoi9bgfc=;
        b=Vqh1YREuDnGDHlUQI8FhTpJBgjFTUerDdqwuKT1SuiG0skGf/NIcWSsNHz/GGineP6h9JZ
        cYFtj4W+OkQUSJwbk9gUdpHz7YPzikC8puh+hmMlxBa+69LnSIIHOKu5teGf/hc3lZG568
        18Gu9RDSAG38TVjI0UuMb1HP7sV4uqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-HnAUMfNAM0OMvyN4RsRhjA-1; Thu, 10 Sep 2020 13:15:48 -0400
X-MC-Unique: HnAUMfNAM0OMvyN4RsRhjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7CFB802B72;
        Thu, 10 Sep 2020 17:15:45 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 061BB60BFA;
        Thu, 10 Sep 2020 17:15:42 +0000 (UTC)
Date:   Thu, 10 Sep 2020 13:15:41 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, Hans de Goede <hdegoede@redhat.com>,
        Song Liu <song@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, drbd-dev@tron.linbit.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Message-ID: <20200910171541.GB21919@redhat.com>
References: <20200726150333.305527-1-hch@lst.de>
 <20200726150333.305527-7-hch@lst.de>
 <20200826220737.GA25613@redhat.com>
 <20200902151144.GA1738@lst.de>
 <20200902162007.GB5513@redhat.com>
 <20200910092813.GA27229@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910092813.GA27229@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10 2020 at  5:28am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Sep 02, 2020 at 12:20:07PM -0400, Mike Snitzer wrote:
> > On Wed, Sep 02 2020 at 11:11am -0400,
> > Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > On Wed, Aug 26, 2020 at 06:07:38PM -0400, Mike Snitzer wrote:
> > > > On Sun, Jul 26 2020 at 11:03am -0400,
> > > > Christoph Hellwig <hch@lst.de> wrote:
> > > > 
> > > > > Drivers shouldn't really mess with the readahead size, as that is a VM
> > > > > concept.  Instead set it based on the optimal I/O size by lifting the
> > > > > algorithm from the md driver when registering the disk.  Also set
> > > > > bdi->io_pages there as well by applying the same scheme based on
> > > > > max_sectors.
> > > > > 
> > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > ---
> > > > >  block/blk-settings.c         |  5 ++---
> > > > >  block/blk-sysfs.c            |  1 -
> > > > >  block/genhd.c                | 13 +++++++++++--
> > > > >  drivers/block/aoe/aoeblk.c   |  2 --
> > > > >  drivers/block/drbd/drbd_nl.c | 12 +-----------
> > > > >  drivers/md/bcache/super.c    |  4 ----
> > > > >  drivers/md/dm-table.c        |  3 ---
> > > > >  drivers/md/raid0.c           | 16 ----------------
> > > > >  drivers/md/raid10.c          | 24 +-----------------------
> > > > >  drivers/md/raid5.c           | 13 +------------
> > > > >  10 files changed, 16 insertions(+), 77 deletions(-)
> > > > 
> > > > 
> > > > In general these changes need a solid audit relative to stacking
> > > > drivers.  That is, the limits stacking methods (blk_stack_limits)
> > > > vs lower level allocation methods (__device_add_disk).
> > > > 
> > > > You optimized for lowlevel __device_add_disk establishing the bdi's
> > > > ra_pages and io_pages.  That is at the beginning of disk allocation,
> > > > well before any build up of stacking driver's queue_io_opt() -- which
> > > > was previously done in disk_stack_limits or driver specific methods
> > > > (e.g. dm_table_set_restrictions) that are called _after_ all the limits
> > > > stacking occurs.
> > > > 
> > > > By inverting the setting of the bdi's ra_pages and io_pages to be done
> > > > so early in __device_add_disk it'll break properly setting these values
> > > > for at least DM afaict.
> > > 
> > > ra_pages never got inherited by stacking drivers, check it by modifying
> > > it on an underlying device and then creating a trivial dm or md one.
> > 
> > Sure, not saying that it did.  But if the goal is to set ra_pages based
> > on io_opt then to do that correctly on stacking drivers it must be done
> > in terms of limits stacking right?  Or at least done at a location that
> > is after the limits stacking has occurred?  So should DM just open-code
> > setting ra_pages like it did for io_pages?
> > 
> > Because setting ra_pages in __device_add_disk() is way too early for DM
> > -- given it uses device_add_disk_no_queue_reg via add_disk_no_queue_reg
> > at DM device creation (before stacking all underlying devices' limits).
> 
> I'll move it to blk_register_queue, which should work just fine.

That'll work for initial DM table load as part of DM device creation
(dm_setup_md_queue).  But it won't account for DM table reloads that
might change underlying devices on a live DM device (done using
__bind).

Both dm_setup_md_queue() and __bind() call dm_table_set_restrictions()
to set/update queue_limits.  It feels like __bind() will need to call a
new block helper to set/update parts of queue_limits (e.g. ra_pages and
io_pages).

Any chance you're open to factoring out that block function as an
exported symbol for use by blk_register_queue() and code like DM's
__bind()?

Thanks,
Mike

