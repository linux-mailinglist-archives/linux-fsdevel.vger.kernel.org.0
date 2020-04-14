Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05181A797F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439169AbgDNLac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439160AbgDNLaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:30:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D4C061A0C;
        Tue, 14 Apr 2020 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CIUrbcmj1xhW3MOaPe81Ur6/xKrEzd9msEFn9mkphaA=; b=Wd48rBg/0x0CXzD+KRzC20Aj12
        3q2vCAAoyKJtZiWfj5RrnksBszf30fdP56w1lVxUfY9YPrnTeS/YjMCJugR973FvGBfuiVREliaIL
        57LVWXx9aZe5HuOQXnM5IZDfSHk0hzE+FdIeGN8pdWuPS91xnQelXWvJBSg4FeIK9v7dEhcqcGedC
        2zkwbFgR3ncFRlY1SKieVy8LZ6B/vl2XoN8uY3LuMC5pE4V6zm0YgBfzhP9DrMCnDjr8bv09aXaFY
        4Q5SJh8O3X8Tf3TvMkKyDHDpiz5bYmBGjv3VyJ2nQrluSqUEae2vjDHDRz6GIV5Njcups4z/408PZ
        t3uzYQng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJlY-0001Eu-J2; Tue, 14 Apr 2020 11:30:08 +0000
Date:   Tue, 14 Apr 2020 04:30:08 -0700
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
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Message-ID: <20200414113008.GB26599@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410061822.GB4791@infradead.org>
 <20200410063855.GC4791@infradead.org>
 <SN4PR0401MB3598DD3A892162A3FADB06CD9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598DD3A892162A3FADB06CD9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:09:41AM +0000, Johannes Thumshirn wrote:
> On 10/04/2020 08:39, Christoph Hellwig wrote:
> > Looking more the situation seems even worse.  If scsi_mq_prep_fn
> > isn't successfull we never seem to free the sgtables, even for fatal
> > errors.  So I think we need a real bug fix here in front of the series
> 
> If I'm not missing something all that needs to be done to fix it is:

Looks sensible.
