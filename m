Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC52226148
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGTNrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 09:47:20 -0400
Received: from verein.lst.de ([213.95.11.211]:47041 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgGTNrT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:47:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9AD6768BFE; Mon, 20 Jul 2020 15:47:17 +0200 (CEST)
Date:   Mon, 20 Jul 2020 15:47:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] fs: fix kiocb ki_complete interface
Message-ID: <20200720134717.GA3908@lst.de>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com> <20200720132118.10934-2-johannes.thumshirn@wdc.com> <20200720133849.GA3342@lst.de> <CY4PR04MB375119332AF668A4A0368DF9E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375119332AF668A4A0368DF9E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:43:43PM +0000, Damien Le Moal wrote:
> On 2020/07/20 22:38, Christoph Hellwig wrote:
> > On Mon, Jul 20, 2020 at 10:21:17PM +0900, Johannes Thumshirn wrote:
> >> From: Damien Le Moal <damien.lemoal@wdc.com>
> >>
> >> The res and res2 fields of struct io_event are signed 64 bits values
> >> (__s64 type). Allow the ki_complete method of struct kiocb to set 64
> >> bits values in these fields by changin its interface from the long type
> >> to long long.
> > 
> > Which doesn't help if the consumers can't deal with these values.
> > But that shouldn't even be required for using zone append anyway..
> > 
> 
> Not sure what you mean...
> 
> res2 is used to pass back to the user the written file offset, 64bits Bytes
> value, for aio case (io_submit()/io_getevent()). The change does not break user
> interface at all, no changes needed to any system call. The patch  just enables
> passing that 64bit byte offset. The consumer of it would be the user
> application, and yes, it does need to know what it is doing. But if it is using
> zonefs, likely, the application knows.

Please start a discussion on this ABI on the linux-aio and linux-api
lists.  If we support that for zonefs we should also support it for
other direct I/O writes.  And I'm not sure an API that only works
with aio and not io_uring is going to win a lot of friends these days.
