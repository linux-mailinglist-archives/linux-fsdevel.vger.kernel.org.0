Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7283C270B52
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 09:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgISHBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 03:01:22 -0400
Received: from verein.lst.de ([213.95.11.211]:35075 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISHBW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 03:01:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D18468BEB; Sat, 19 Sep 2020 09:01:17 +0200 (CEST)
Date:   Sat, 19 Sep 2020 09:01:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 04/12] bdi: initialize ->ra_pages and ->io_pages in
 bdi_init
Message-ID: <20200919070117.GB8237@lst.de>
References: <20200910144833.742260-1-hch@lst.de> <20200910144833.742260-5-hch@lst.de> <20200917100459.GK7347@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917100459.GK7347@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:04:59PM +0200, Jan Kara wrote:
> On Thu 10-09-20 16:48:24, Christoph Hellwig wrote:
> > Set up a readahead size by default, as very few users have a good
> > reason to change it.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: David Sterba <dsterba@suse.com> [btrfs]
> > Acked-by: Richard Weinberger <richard@nod.at> [ubifs, mtd]
> 
> Looks good but what about coda, ecryptfs, and orangefs? Currenly they have
> readahead disabled and this patch would seem to enable it?

When going through this I pinged all maintainers and asked if anyone
had a reason to actually disable the readahead, and only vbox and
the mtd/ubifs maintainers came up with a reason.

> 
> > diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> > index 8e8b00627bb2d8..2dac3be6127127 100644
> > --- a/mm/backing-dev.c
> > +++ b/mm/backing-dev.c
> > @@ -746,6 +746,8 @@ struct backing_dev_info *bdi_alloc(int node_id)
> >  		kfree(bdi);
> >  		return NULL;
> >  	}
> > +	bdi->ra_pages = VM_READAHEAD_PAGES;
> > +	bdi->io_pages = VM_READAHEAD_PAGES;
> 
> Won't this be more logical in bdi_init() than in bdi_alloc()?

bdi_init is also used for noop_backing_dev_info, which should not
have readahead enabled.  In fact the only caller except for
bdi_alloc is the initialization of noop_backing_dev_info.
