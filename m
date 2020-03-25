Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BE19210F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 07:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCYGZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 02:25:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYGZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 02:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FRmSjeMLSWSTRYKWYZzCKuHL+R1jHOVgBVASwqCudQ0=; b=oMZmPDS83lP70QCyMHIjR4+gju
        vilzU8xBJPREmv8lDqaOEsANBSnoivWvqxBIdQYs81DwcwdnPVOSwrjTyJ535WActZj0nlbJ/TYZM
        xnHdxoOD5xZUfDFB48HC60u8cqu+KYg+fbzFVvK92TQdNyRt/S7j+58UP470m476KQgF7gm1QCBGy
        BIx17f3eXb+3UTfN0d5yZFzxCpwha28JVjTvTFx+oYqhBWW+h/d5LZ/Mu02E56eQxSm3sFEdxteFC
        c9RZnKxkdEOlBkuH7B5TvDuKGTWyPrzJidDYY4itD/br1CRR2wDj+YMvM1TR0qPd9GtP2RDtgW4k3
        gqdneoTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGzU6-0007zq-4P; Wed, 25 Mar 2020 06:25:50 +0000
Date:   Tue, 24 Mar 2020 23:25:50 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 10/11] iomap: Add support for zone append writes
Message-ID: <20200325062550.GA19666@infradead.org>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
 <CO2PR04MB2343309246F0D413F5C1691CE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB2343309246F0D413F5C1691CE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:27:38AM +0000, Damien Le Moal wrote:
> > At least for a normal file system that is absolutely not true.  If
> > zonefs is so special it might be better of just using a slightly tweaked
> > copy of blkdev_direct_IO rather than using iomap.
> 
> It would be very nice to not have to add this direct BIO use case in zonefs
> since that would be only for writes to sequential zones while all other
> operations use iomap. So instead of this, what about using a flag as Dave
> suggested (see below comment too) ?

Given how special the use case is I'm not sure overloading iomap
is a good idea.  Think of how a "normal" zone aware file system would
use iomap and not of this will apply.  OTOH the "simple" single bio
code in __blkdev_direct_IO_simple is less than 100 lines of code.  I
think having a specialized code base for a specialized use case
might be better than overloading generic code with tons of flags.

> > I don't think the iocb is the right interface for passing this
> > kind of information.  We currently pass a bool wait to iomap_dio_rw
> > which really should be flags.  I have a pending patch for that.
> 
> Is that patch queued in iomap or xfs tree ? Could you point us to it please ?

It isn't queued up anywhere yet.
