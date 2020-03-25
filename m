Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88A1924E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 11:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCYKBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 06:01:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgCYKBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Br3B3z5WBUvkRBJyK58HlpN84XlUPasp9afiKhGW9rg=; b=Ff8bDc7afHqj0fGI7EsuRElRUr
        HR84GZ3GMnoBzn3+VrRu2iZvulcJ4WdKkbc9g/wYMnTsL5hKkM+1efKSXPW3dYgqfqh30o8vHtfH7
        f/pbHeb7/6SPuT+2BhZmljGMM/3p/bP8WgWIzSrrDN5CYYCR91ohtccihDNiZQzG9/0A7SIBCVp0O
        OLMPE+MqA+jUC+jFxJD82hGo1lbD7Ua/Uk3VAzWGcYeBcxvSzbUyn3SZzmFlPj/gyEvqT8BjNvUgW
        bZjUCOH5hfozBPVWtkOOhhy5v7MhMRy6u99EcGBe88vDEnoSi3JamF4jl+jUQ0ia3clKQ8HeqejxM
        2yiw7R1w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH2r3-00028G-4z; Wed, 25 Mar 2020 10:01:45 +0000
Date:   Wed, 25 Mar 2020 03:01:45 -0700
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
Message-ID: <20200325100145.GB20415@infradead.org>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-11-johannes.thumshirn@wdc.com>
 <20200324154131.GA32087@infradead.org>
 <SN4PR0401MB35980056EFCD6D0003463F939BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200325094828.GA20415@infradead.org>
 <CO2PR04MB2343F14FFF07D76BF7CE9D10E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB2343F14FFF07D76BF7CE9D10E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 09:59:19AM +0000, Damien Le Moal wrote:
> On 2020/03/25 18:48, hch@infradead.org wrote:
> > On Wed, Mar 25, 2020 at 09:45:39AM +0000, Johannes Thumshirn wrote:
> >>
> >> Can you please elaborate on that? Why doesn't this hold true for a 
> >> normal file system? If we split the DIO write into multiple BIOs with 
> >> zone-append, there is nothing which guarantees the order of the written 
> >> data (at least as far as I can see).
> > 
> > Of course nothing gurantees the order.  But the whole point is that the
> > order does not matter.  
> > 
> 
> The order does not matter at the DIO level since iomap dio end callback will
> allow the FS to add an extent mapping the written data using the drive indicated
> write location. But that callback is for the entire DIO, not per BIO fragment of
> the DIO. So if the BIO fragments of a large DIO get reordered, as Johannes said,
> we will get data corruption in the FS extent. No ?

I thought of recording the location in ->iomap_end (and in fact
had a prototype for that), but that is not going to work for AIO of
course.  So yes, we'll need some way to have per-extent completion
callbacks.
