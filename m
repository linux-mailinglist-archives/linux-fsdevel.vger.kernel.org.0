Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090B81A796E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439129AbgDNL3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728727AbgDNL3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:29:00 -0400
X-Greylist: delayed 16018 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Apr 2020 04:29:00 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF05C061A0C;
        Tue, 14 Apr 2020 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g+uHAojjwCXmnQW4UA7OoiAqNsaYVwbUMAUDCWwhZfE=; b=D9KqRuIFBcdYRqj+g3vP81jx+X
        ajMFFmNOh6PdkXADO2KMLFDMIGcqmoEmNKypuio1LMICd+vkrHDHfSLFQ45A9RQTI/LCV5dAL+GgZ
        QFrm7mBW/Ia30u6m1rX0N1Hw8ZzGvHYd/QRLATkJCKkw/TJ+zW4XnNNTED/MVOc6dIp0DMm16PJeS
        gJRW8lz3WWB1JUcCoIgK9tTa7hLlUHHHNqkvzveKqg3mwImJShVb1mnDruhSRS81/o7o7787EClaK
        GiAgLROU4n6VefPu0J84xEoDYHn6AN957lNiMpaR0W/1RGWpDxwu4B5y/NJ8Y5tuej4ReEPb5OsUx
        Hwi7imPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJkQ-000719-Hh; Tue, 14 Apr 2020 11:28:58 +0000
Date:   Tue, 14 Apr 2020 04:28:58 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200414112858.GA26599@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-3-johannes.thumshirn@wdc.com>
 <20200410071045.GA13404@infradead.org>
 <SN4PR0401MB3598F69EFD255EAA28374D979BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598F69EFD255EAA28374D979BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:43:24AM +0000, Johannes Thumshirn wrote:
> > -static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
> > +static int bio_add_hw_page(struct request_queue *q, struct bio *bio,
> >   		struct page *page, unsigned int len, unsigned int offset,
> > -		bool *same_page)
> > +		unsigned int max_sectors, bool *same_page)
> 
> Should I split that rename into a prep patch and if yes add you as the 
> author?

It is not just a rename but also passing max_sectors explicitly.  I'm
kinda torn if it is worth a prep patch or not, but then why not..
