Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAE1964AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 10:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgC1JHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 05:07:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CpBQLNx1zBEhs/801U9Lo8CDW55FkBUq9IOHNLG+47A=; b=YqrF0mWd8i8ZK0COK0Z9XA/1Rl
        Gb7qWp+RywrbKWEX7xbJCQecovsN1gNb5YVGWdqTZGmwQ0GaR34JvNn9ClWg7IyrKkdRf4o7Kj126
        UZpkceBxrcik1qMoY9mRbi3w7DqTXzVsnrqbEFCtiuT7tCQpqvEzRAUL8KYfpFGEfN5P9YIqGjIEw
        D8bMU4I8YHXkOUy3bhUjjFoPvh9zdR3k2ZgIH4WLz9wzr7cbvejw2Fd0jBqgtBo4UCU/i8zgKRfXU
        QSiBi1O4mDh7theIBQoMeP2Q/PDJQLJqkTnHFVFL1lHrad2VN5dcyd04PJYFRi692XcaRdlc9GaOv
        UPUezt7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI7Qx-0001bT-Iv; Sat, 28 Mar 2020 09:07:15 +0000
Date:   Sat, 28 Mar 2020 02:07:15 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200328090715.GA26719@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-7-johannes.thumshirn@wdc.com>
 <20200328085106.GA22315@infradead.org>
 <CO2PR04MB23439D41B94F7D76D72CE3BCE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB23439D41B94F7D76D72CE3BCE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:02:43AM +0000, Damien Le Moal wrote:
> On 2020/03/28 17:51, Christoph Hellwig wrote:
> >> Since zone reset and finish operations can be issued concurrently with
> >> writes and zone append requests, ensure a coherent update of the zone
> >> write pointer offsets by also write locking the target zones for these
> >> zone management requests.
> > 
> > While they can be issued concurrently you can't expect sane behavior
> > in that case.  So I'm not sure why we need the zone write lock in this
> > case.
> 
> The behavior will certainly not be sane for the buggy application doing writes
> and resets to the same zone concurrently (I have debugged that several time in
> the field). So I am not worried about that at all. The zone write lock here is
> still used to make sure the wp cache stays in sync with the drive. Without it,
> we could have races on completion update of the wp and get out of sync.

How do the applications expect to get sane results from that in general?

But if you think protecting against that is worth the effort I think
there should be a separate patch to take the zone write lock for
reset/finish.

> >> +#define SD_ZBC_INVALID_WP_OFST	~(0u)
> >> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)
> > 
> > Given that this goes into the seq_zones_wp_ofst shouldn't the block
> > layer define these values?
> 
> We could, at least the first one. The second one is really something that could
> be considered completely driver dependent since other drivers doing this
> emulation may handle the updating state differently.
> 
> Since this is the only driver where this is needed, may be we can keep this here
> for now ?

Well, I'd rather keep magic values for a field defined in common code
in the common code.  Having behavior details spread over different
modules makes code rather hard to follow.

> >> +struct sd_zbc_zone_work {
> >> +	struct work_struct work;
> >> +	struct scsi_disk *sdkp;
> >> +	unsigned int zno;
> >> +	char buf[SD_BUF_SIZE];
> >> +};
> > 
> > Wouldn't it make sense to have one work_struct per scsi device and batch
> > updates?  That is also query a decenent sized buffer with a bunch of
> > zones and update them all at once?  Also given that the other write
> > pointer caching code is in the block layer, why is this in SCSI?
> 
> Again, because we thought this is driver dependent in the sense that other
> drivers may want to handle invalid WP entries differently.

What sensible other strategy exists?  Nevermind that I hope we never
see another driver.  And as above - I really want to keep behavior
togetether instead of wiredly split over different code bases.  My
preference would still be to have it just in sd, but you gave some good
arguments for keeping it in the block layer.  Maybe we need to take a
deeper look and figure out a way to keep it isolated in SCSI.

> Also, I think that
> one work struct per device may be an overkill. This is for error recovery and on
> a normal healthy systems, write errors are rare.

I think it is less overkill than the dynamic allocation scheme with
the mempool and slab cache, that is why I suggested it.
