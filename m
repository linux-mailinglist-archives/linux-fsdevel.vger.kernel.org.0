Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEFE3B2744
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 08:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFXGQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhFXGQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:16:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26ACC061574;
        Wed, 23 Jun 2021 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sSFHXo3Gj4dSjFJuKq0lyHYwfOL1EKEDwVgBxUfbffw=; b=t4/xd1iRSTshzW9JK+ypF4gUvU
        DiOLXv1n179uEuNdX25CkPiklMEzjEZvgwAVqPPFECZ7cw7Xirlw9BxwbTT3+G+VFQRWgj//+tcl5
        fBZcyFlGX0MOBtXe+2zlZBhDGeCUvKMfW7LUvpq4wYEiz3WHQH0mEuROU84c9reuI9kUN/+UAq7FI
        IJts0WQWke3KSLvKBUeP9HswUP6IfxrKG9EtQLd70TEJluWLme7q5vD6VkXaNsA486/ZCtQXlcPhc
        4ACaHId9qdfCOYhJCpJmucL4SGSEs2rvkE4WSwaTNDiwkyDIXQEbv3olSWfx2lh5rhY42ZRizrzIz
        OtKHbZ2Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwIbX-00GFEb-EP; Thu, 24 Jun 2021 06:12:55 +0000
Date:   Thu, 24 Jun 2021 07:12:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 3/6] block: refactor sysfs code
Message-ID: <YNQiX08k6SGz5PvD@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-4-mcroce@linux.microsoft.com>
 <YNMgmK2vqQPL7PWb@infradead.org>
 <CAFnufp3=2Jhr9NqVhE2nCLcr48UvxVww=RpWHp2wpm7DWwGuEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp3=2Jhr9NqVhE2nCLcr48UvxVww=RpWHp2wpm7DWwGuEA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 09:03:40PM +0200, Matteo Croce wrote:
> On Wed, Jun 23, 2021 at 1:53 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > -static void disk_add_events(struct gendisk *disk)
> > > +static void disk_add_sysfs(struct gendisk *disk)
> > >  {
> > >       /* FIXME: error handling */
> > > -     if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
> > > +     if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs) < 0)
> > >               pr_warn("%s: failed to create sysfs files for events\n",
> > >                       disk->disk_name);
> > > +}
> >
> > Actually, what we need here is a way how we can setup the ->groups
> > field of the device to include all attribute groups instead of having
> > to call sysfs_create_files at all.
> 
> I don't get this one. You mean in general or in this series?

In general before we make more use of the block device provided attrs.
