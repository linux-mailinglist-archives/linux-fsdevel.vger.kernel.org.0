Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B0A229A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732515AbgGVOwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 10:52:01 -0400
Received: from verein.lst.de ([213.95.11.211]:56611 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgGVOwB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:52:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1419068B05; Wed, 22 Jul 2020 16:51:57 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:51:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200722145156.GA20266@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-3-johannes.thumshirn@wdc.com> <20200720134549.GB3342@lst.de> <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com> <20200721055410.GA18032@infradead.org> <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 12:43:21PM +0000, Johannes Thumshirn wrote:
> On 21/07/2020 07:54, Christoph Hellwig wrote:
> > On Mon, Jul 20, 2020 at 04:48:50PM +0000, Johannes Thumshirn wrote:
> >> On 20/07/2020 15:45, Christoph Hellwig wrote:
> >>> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:
> >>>> On a successful completion, the position the data is written to is
> >>>> returned via AIO's res2 field to the calling application.
> >>>
> >>> That is a major, and except for this changelog, undocumented ABI
> >>> change.  We had the whole discussion about reporting append results
> >>> in a few threads and the issues with that in io_uring.  So let's
> >>> have that discussion there and don't mix it up with how zonefs
> >>> writes data.  Without that a lot of the boilerplate code should
> >>> also go away.
> >>>
> >>
> >> OK maybe I didn't remember correctly, but wasn't this all around 
> >> io_uring and how we'd report the location back for raw block device
> >> access?
> > 
> > Report the write offset.  The author seems to be hell bent on making
> > it block device specific, but that is a horrible idea as it is just
> > as useful for normal file systems (or zonefs).
> 
> After having looked into io_uring I don't this there is anything that
> prevents io_uring from picking up the write offset from ki_complete's
> res2 argument. As of now io_uring ignores the filed but that can be 
> changed.

Sure.  Except for the fact that the io_uring CQE doesn't have space
for it.  See the currently ongoing discussion on that..

> So the only thing that needs to be done from a zonefs perspective is 
> documenting the use of res2 and CC linux-aio and linux-abi (including
> an update of the io_getevents man page).
> 
> Or am I completely off track now?

Yes.  We should not have a different ABI just for zonefs.  We need to
support this feature in a generic way and not as a weird one off for
one filesystem and only with the legacy AIO interface.

Either way please make sure you properly separate the interface (
using Write vs Zone Append in zonefs) from the interface (returning
the actually written offset from appending writes), as they are quite
separate issues.
