Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47211229AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgGVOxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 10:53:03 -0400
Received: from verein.lst.de ([213.95.11.211]:56617 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731539AbgGVOxD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:53:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5C8F68B05; Wed, 22 Jul 2020 16:53:01 +0200 (CEST)
Date:   Wed, 22 Jul 2020 16:53:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Message-ID: <20200722145301.GB20266@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-3-johannes.thumshirn@wdc.com> <20200720134549.GB3342@lst.de> <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com> <20200721055410.GA18032@infradead.org> <SN4PR0401MB3598536959BFAE08AA8DA8AD9B790@SN4PR0401MB3598.namprd04.prod.outlook.com> <CY4PR04MB375139CC436B04DDE02B8560E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375139CC436B04DDE02B8560E7790@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:02:14PM +0000, Damien Le Moal wrote:
> That is the general idea. But Christoph point was that reporting the effective
> write offset back to user space can be done not only for zone append, but also
> for regular FS/files that are open with O_APPEND and being written with AIOs,
> legacy or io_uring. Since for this case, the aio->aio_offset field is ignored
> and the kiocb pos is initialized with the file size, then incremented with size
> for the next AIO, the user never actually sees the actual write offset of its
> AIOs. Reporting that back for regular files too can be useful, even though
> current application can do without this (or do not use O_APPEND because it is
> lacking).
> 
> Christoph, please loudly shout at me if I misunderstood you :)

I'd never shout at you :)  But yes, this is correct.
