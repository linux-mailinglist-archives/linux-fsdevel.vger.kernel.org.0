Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821C922E718
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgG0H60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 03:58:26 -0400
Received: from verein.lst.de ([213.95.11.211]:42430 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0H60 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:58:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 630C468B05; Mon, 27 Jul 2020 09:58:22 +0200 (CEST)
Date:   Mon, 27 Jul 2020 09:58:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 10/14] bdi: remove BDI_CAP_SYNCHRONOUS_IO
Message-ID: <20200727075822.GA5355@lst.de>
References: <20200726150333.305527-1-hch@lst.de> <20200726150333.305527-11-hch@lst.de> <20200726190639.GA560221@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726190639.GA560221@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 12:06:39PM -0700, Minchan Kim wrote:
> > @@ -528,8 +530,7 @@ static ssize_t backing_dev_store(struct device *dev,
> >  	 * freely but in fact, IO is going on so finally could cause
> >  	 * use-after-free when the IO is really done.
> >  	 */
> > -	zram->disk->queue->backing_dev_info->capabilities &=
> > -			~BDI_CAP_SYNCHRONOUS_IO;
> > +	zram->disk->fops = &zram_wb_devops;
> >  	up_write(&zram->init_lock);
> 
> For zram, regardless of BDI_CAP_SYNCHRONOUS_IO, it have used rw_page
> every time on read/write path. This one with next patch will make zram
> use bio instead of rw_page when it's declared !BDI_CAP_SYNCHRONOUS_IO,
> which introduce regression for performance.

It really should not matter, as the overhead of setting up a bio
is minimal.  It also is only used in the legacy mpage buffered I/O
code outside of the swap code, which has so many performance issues on
its own that even if this made a difference it wouldn't matter.

If you want magic treatment for your zram swap code you really need
to integrate it with the swap code instead of burding the block layer
with all this mess.
