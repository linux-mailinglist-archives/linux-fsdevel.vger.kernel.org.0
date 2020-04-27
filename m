Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEC1BA391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgD0M23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 08:28:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0M22 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:28:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C06C1AB89;
        Mon, 27 Apr 2020 12:28:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33DE7DA781; Mon, 27 Apr 2020 14:27:41 +0200 (CEST)
Date:   Mon, 27 Apr 2020 14:27:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/9] btrfs: use set/clear_fs_page_private
Message-ID: <20200427122740.GZ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-4-guoqing.jiang@cloud.ionos.com>
 <20200426222054.GA2005@dread.disaster.area>
 <20200427055428.GB16709@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427055428.GB16709@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 10:54:28PM -0700, Christoph Hellwig wrote:
> On Mon, Apr 27, 2020 at 08:20:54AM +1000, Dave Chinner wrote:
> > >  void set_page_extent_mapped(struct page *page)
> > >  {
> > > -	if (!PagePrivate(page)) {
> > > -		SetPagePrivate(page);
> > > -		get_page(page);
> > > -		set_page_private(page, EXTENT_PAGE_PRIVATE);
> > > -	}
> > > +	if (!PagePrivate(page))
> > > +		set_fs_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> > 
> > Change the definition of EXTENT_PAGE_PRIVATE so the cast is not
> > needed? Nothing ever reads EXTENT_PAGE_PRIVATE; it's only there to
> > set the private flag for other code to check and release the extent
> > mapping reference to the page...
> 
> IIRC there as a patch on the btrfs list to remove EXTENT_PAGE_PRIVATE,
> it might be better to not bother changing it.  Maybe the btrfs
> maintainers remember this better.

The patch removing it is part of patchset adding full iomap support to
btrfs,
(https://lore.kernel.org/linux-btrfs/20190905150650.21089-4-rgoldwyn@suse.de/)
but it'll still take some time so I'm OK with using the
set_fs_page_private helper and adding the cast to EXTENT_PAGE_PRIVATE
definition.
