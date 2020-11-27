Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C172C61F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 10:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgK0JlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 04:41:14 -0500
Received: from verein.lst.de ([213.95.11.211]:37031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgK0JlO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:41:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D046C68B05; Fri, 27 Nov 2020 10:41:09 +0100 (CET)
Date:   Fri, 27 Nov 2020 10:41:09 +0100
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
Message-ID: <20201127094109.GB14976@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-30-hch@lst.de> <20201126165036.GO422@quack2.suse.cz> <20201126175208.GA24843@lst.de> <20201126180408.GB422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126180408.GB422@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 07:04:08PM +0100, Jan Kara wrote:
> On Thu 26-11-20 18:52:08, Christoph Hellwig wrote:
> > On Thu, Nov 26, 2020 at 05:50:36PM +0100, Jan Kara wrote:
> > > > +	if (size == capacity ||
> > > > +	    (disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
> > > > +		return false;
> > > > +	pr_info("%s: detected capacity change from %lld to %lld\n",
> > > > +		disk->disk_name, size, capacity);
> > > > +	kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
> > > 
> > > I think we don't want to generate resize event for changes from / to 0...
> > 
> > Didn't you ask for that in the last round?
> 
> I've asked for the message - which you've added :). But the udev event was
> correct in the previous version IMHO...

Note that this version only prints if the gendisk is up.  So any initial
setup does not see a message.  I think that is a better indicator than
checking for 0.  Especially as say a remotely triggered change to 0
is an even worth printing, and except for DRBD all drivers did print
the message.

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
---end quoted text---
