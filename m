Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4463052936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfFYKPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 06:15:21 -0400
Received: from verein.lst.de ([213.95.11.211]:33465 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbfFYKPU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:15:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7E6E968C7B; Tue, 25 Jun 2019 12:14:46 +0200 (CEST)
Date:   Tue, 25 Jun 2019 12:14:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] xfs: refactor the ioend merging code
Message-ID: <20190625101445.GK1462@lst.de>
References: <20190624055253.31183-1-hch@lst.de> <20190624055253.31183-10-hch@lst.de> <e42c54c4-4c64-8185-8ac3-cca38ad8e8a4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42c54c4-4c64-8185-8ac3-cca38ad8e8a4@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:06:22PM +0300, Nikolay Borisov wrote:
> > +{
> > +	struct list_head	tmp;
> > +
> > +	list_replace_init(&ioend->io_list, &tmp);
> > +	xfs_destroy_ioend(ioend, error);
> > +	while ((ioend = list_pop(&tmp, struct xfs_ioend, io_list)))
> > +		xfs_destroy_ioend(ioend, error);
> 
> nit: I'd prefer if the list_pop patch is right before this one since
> this is the first user of it.

I try to keep generic infrastructure first instead of interveawing
it with subystem-specific patches.

> Additionally, I don't think list_pop is
> really a net-negative win 

What is a "net-negative win" ?

> in comparison to list_for_each_entry_safe
> here. In fact this "delete the list" would seems more idiomatic if
> implemented via list_for_each_entry_safe

I disagree.  The for_each loops require an additional next iterator,
and also don't clearly express what is going on, but require additional
spotting of the list_del.
