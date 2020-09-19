Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD459270B44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Sep 2020 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgISGvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Sep 2020 02:51:32 -0400
Received: from verein.lst.de ([213.95.11.211]:35048 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgISGvc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Sep 2020 02:51:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2740768BFE; Sat, 19 Sep 2020 08:51:27 +0200 (CEST)
Date:   Sat, 19 Sep 2020 08:51:26 +0200
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
        cgroups@vger.kernel.org
Subject: Re: [PATCH 10/12] bdi: replace BDI_CAP_STABLE_WRITES with a queue
 and a sb flag
Message-ID: <20200919065126.GA8048@lst.de>
References: <20200910144833.742260-1-hch@lst.de> <20200910144833.742260-11-hch@lst.de> <20200917092524.GC7347@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917092524.GC7347@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:25:24AM +0200, Jan Kara wrote:
> On Thu 10-09-20 16:48:30, Christoph Hellwig wrote:
> > The BDI_CAP_STABLE_WRITES is one of the few bits of information in the
> > backing_dev_info shared between the block drivers and the writeback code.
> > To help untangling the dependency replace it with a queue flag and a
> > superblock flag derived from it.  This also helps with the case of e.g.
> > a file system requiring stable writes due to its own checksumming, but
> > not forcing it on other users of the block device like the swap code.
> > 
> > One downside is that we can't support the stable_pages_required bdi
> > attribute in sysfs anymore.  It is replaced with a queue attribute, that
> > can also be made writable for easier testing.
>   ^^^^^^^^^^^^^^^^
>   is also made
> 
> For a while I was confused thinking that the new attribute is not writeable
> but when I checked the code I saw that it is.
> 
> Not supporting stable_pages_required attribute is not nice but probably it
> isn't widely used. Maybe the deprecation message can even mention to use
> the queue attribute? Otherwise the patch looks good to me so feel free to
> add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks.  I've fixed the commit log and changed the warning to:

	dev_warn_once(dev, 
                 "the stable_pages_required attribute has been removed. Use the
		 stable_writes queue attribute instead.\n");
