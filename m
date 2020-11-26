Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2BC2C5B16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403877AbgKZRwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:52:12 -0500
Received: from verein.lst.de ([213.95.11.211]:35281 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391740AbgKZRwM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:52:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7355A68B05; Thu, 26 Nov 2020 18:52:08 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:52:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 29/44] block: remove the nr_sects field in struct
 hd_struct
Message-ID: <20201126175208.GA24843@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-30-hch@lst.de> <20201126165036.GO422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126165036.GO422@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:50:36PM +0100, Jan Kara wrote:
> > +	if (size == capacity ||
> > +	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> > +		return false;
> > +	pr_info("%s: detected capacity change from %lld to %lld\n",
> > +		disk->disk_name, size, capacity);
> > +	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> 
> I think we don't want to generate resize event for changes from / to 0...

Didn't you ask for that in the last round?

> Also the return value of this function is now different.

It returns true if it did send an uevent, which is what the callers rely
on.

> > diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
> > index 4e37fa9b409d52..a70c33c49f0960 100644
> > --- a/drivers/target/target_core_pscsi.c
> > +++ b/drivers/target/target_core_pscsi.c
> > @@ -1027,12 +1027,7 @@ static u32 pscsi_get_device_type(struct se_device *dev)
> >  
> >  static sector_t pscsi_get_blocks(struct se_device *dev)
> >  {
> > -	struct pscsi_dev_virt *pdv = PSCSI_DEV(dev);
> > -
> > -	if (pdv->pdv_bd && pdv->pdv_bd->bd_part)
> > -		return pdv->pdv_bd->bd_part->nr_sects;
> > -
> > -	return 0;
> > +	return bdev_nr_sectors(PSCSI_DEV(dev)->pdv_bd);
> 
> I pdv_bd guaranteed to be non-NULL in pscsi_dev_virt?

Looking at the code - only for disk devices.  And while ->get_blocks
should only be called for those I'd rather err on the safe side and will
add the check back.
