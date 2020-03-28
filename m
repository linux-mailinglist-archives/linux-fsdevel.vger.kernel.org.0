Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8CE1964CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 10:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgC1JVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 05:21:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1JVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 05:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Inx7aRdUFjHlYSfchtyETJIY8zMQ9tiWJ/ieP3K5zKk=; b=ZsSjQArAMCfvzvTwzVt3iuwy13
        U3XTQ8o1V1giP3YsRPSgwniAwR/WqLMavMdONJ1P32oVnD50JnCi5Pelp+E2RbkMphc1JmQesb0D/
        egoTcZS390q85Ujc8tuy9F+KeZaxGM3WjbBC4uBeUryloiVxOLs2RhJIid/OC7C70jzMTYorpPPuC
        JY4lmpbPTe9LDfPfQQIBY4hzasnU5UixjFZgX7il+W/kdhU0tDA3pBkcIpVxWmvFJKY5BlNBCskUP
        LARf92Fk+e1UU78MFVXEKggjezNz6g8CX3qCPg3Uqmr2Ylm36Wdf4ckAS/l0lfVGUG3msp3xpi8U8
        45eiRTSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jI7f3-0006un-I9; Sat, 28 Mar 2020 09:21:49 +0000
Date:   Sat, 28 Mar 2020 02:21:49 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200328092149.GA20911@infradead.org>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-7-johannes.thumshirn@wdc.com>
 <20200328085106.GA22315@infradead.org>
 <CO2PR04MB23439D41B94F7D76D72CE3BCE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <20200328090715.GA26719@infradead.org>
 <CO2PR04MB23430A87641EDD359E5101FEE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO2PR04MB23430A87641EDD359E5101FEE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:18:20AM +0000, Damien Le Moal wrote:
> OK. We can try again to see if we can keep all this WP caching in sd. The only
> pain point is the revalidation as I explained before. Everything else would stay
> pretty much the same and all be scsi specific. I will dig again to see what can
> be done.

Maybe just start with a dumb version that calls into sd where the block
layer currently updates?  Once you've got that working I can play a bit
with it and figure out if changes to disk revalidation can clean that up?
I've been wantint to turn revalidate_disk and fiends upside down for
a while as that area is rather grotty.
