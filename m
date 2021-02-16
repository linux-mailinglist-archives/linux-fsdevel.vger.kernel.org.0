Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1C31CA22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 12:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPLtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 06:49:42 -0500
Received: from verein.lst.de ([213.95.11.211]:40978 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBPLrY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 06:47:24 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5738667373; Tue, 16 Feb 2021 12:46:24 +0100 (CET)
Date:   Tue, 16 Feb 2021 12:46:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 12/78] dm: use set_capacity_and_notify
Message-ID: <20210216114624.GA1221@lst.de>
References: <20201116145809.410558-1-hch@lst.de> <20201116145809.410558-13-hch@lst.de> <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 10:45:32AM -0500, Mike Snitzer wrote:
> On Mon, Nov 16, 2020 at 10:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Use set_capacity_and_notify to set the size of both the disk and block
> > device.  This also gets the uevent notifications for the resize for free.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/md/dm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index c18fc25485186d..62ad44925e73ec 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1971,8 +1971,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
> >         if (size != dm_get_size(md))
> >                 memset(&md->geometry, 0, sizeof(md->geometry));
> >
> > -       set_capacity(md->disk, size);
> > -       bd_set_nr_sectors(md->bdev, size);
> > +       set_capacity_and_notify(md->disk, size);
> >
> >         dm_table_event_callback(t, event_callback, md);
> >
> 
> Not yet pinned down _why_ DM is calling set_capacity_and_notify() with
> a size of 0 but, when running various DM regression tests, I'm seeing
> a lot of noise like:
> 
> [  689.240037] dm-2: detected capacity change from 2097152 to 0
> 
> Is this pr_info really useful?  Should it be moved to below: if
> (!capacity || !size) so that it only prints if a uevent is sent?

In general I suspect such a size change might be interesting to users
if it e.g. comes from a remote event.  So I'd be curious why this happens
with DM, and if we can detect some higher level gendisk state to supress
it if it is indeed spurious.
