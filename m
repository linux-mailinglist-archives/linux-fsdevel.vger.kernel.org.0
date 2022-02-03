Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703D74A8C83
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbiBCTen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiBCTek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:34:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014FDC06173D;
        Thu,  3 Feb 2022 11:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YFLdf+yXWDyqnOqAs6w9z7uJ08NBv+2fURUugK0F1GY=; b=QQoe4UndTJBd/gJfKiwRzpeeet
        4JmUN6YpnNX9DYIvdhEW4gGAmzAY4iJcrT9+yl+7RzK9VJRfM6X00mNxkFqcYaMpmB9Au9hsgWlZD
        ngUcGTa0+FogmMxQCXHNIL1F42PEbXs8Dq3IqSgYJKGdCSESKgpRydfKBWHGQQgemhvrjmcYCl0cx
        swBpj2g5oWkXqtlDRS1EyJVf3Cqs+N53XPhC8TLYUZk1qdQbnnwAN8ZRRpI3s8GI9soK4wlp0kc6Z
        eTKXzrjjQbuiQC+xv1PdI0pTr+z6M50XJHX3xneAkraCF4vlAV9pBIkIU8SJGKKLMQF2JJikhHnss
        OQit0XrQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFhsB-002b1R-NQ; Thu, 03 Feb 2022 19:34:27 +0000
Date:   Thu, 3 Feb 2022 11:34:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Message-ID: <YfwuQxS79wl8l/a0@bombadil.infradead.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202060154.GA120951@bgt-140510-bm01>
 <20220203160633.rdwovqoxlbr3nu5u@garbanzo>
 <20220203161534.GA15366@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203161534.GA15366@lst.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 05:15:34PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 03, 2022 at 08:06:33AM -0800, Luis Chamberlain wrote:
> > On Wed, Feb 02, 2022 at 06:01:13AM +0000, Adam Manzanares wrote:
> > > BTW I think having the target code be able to implement simple copy without 
> > > moving data over the fabric would be a great way of showing off the command.
> > 
> > Do you mean this should be implemented instead as a fabrics backend
> > instead because fabrics already instantiates and creates a virtual
> > nvme device? And so this would mean less code?
> 
> It would be a lot less code.  In fact I don't think we need any new code
> at all.  Just using nvme-loop on top of null_blk or brd should be all
> that is needed.

Mikulas,

That begs the question why add this instead of using null_blk with
nvme-loop?

  Luis
