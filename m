Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A51AF41F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgDRTNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbgDRTNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:13:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8AC061A0C;
        Sat, 18 Apr 2020 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Xuy0hbaik5jnBw+JX74GiEbxwfdlzrwJ6CXAcCNKJ0=; b=Pbh2gwHBC+0n9j0XheYbIXwFQj
        DLH/6PgobmCWmxlogha43zhUGSOtU89tXwjVH0o1Rho/S2T2EjJTPG70nmSsvSMvvLuonOlXdkiEF
        yGJpGvfRz2PkLCG7L7Uy3m9lgzRa8kBf6U42WpkqqxMc3bt3hK4TRhmhD0zC1q2wsbCa9130nX/Tr
        BTyG4Wi0/MtCFbctxHGNP3IoIr9AwF92URUTCaCCqCq81Wkivc6Os9SxUDznfhAgxmUgbP9sTqTjg
        OQaGKDbNC89jhx9AoLbm18DH/xji73LaoYjLqiNC454x2nCt2c/0XKhdkme0M37SQxFbl37OzjXm7
        wpboRveg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsuI-0002hx-99; Sat, 18 Apr 2020 19:13:38 +0000
Date:   Sat, 18 Apr 2020 12:13:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200418191338.GR5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org>
 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:55:05AM -0700, Joe Perches wrote:
> On Sat, 2020-04-18 at 11:53 -0700, Randy Dunlap wrote:
> > On 4/18/20 11:50 AM, Matthew Wilcox wrote:
> > > On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
> > > > @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
> > > >  
> > > >  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > >  			      "failing_device"))
> > > > -		/* nothing - symlink will be missing */;
> > > > +		do_empty(); /* nothing - symlink will be missing */
> > > >  
> > > >  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > >  			      "devcoredump"))
> > > > -		/* nothing - symlink will be missing */;
> > > > +		do_empty(); /* nothing - symlink will be missing */
> > > >  
> > > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > > >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > > 
> > > Could just remove the 'if's?
> > > 
> > > +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > +			"failing_device");
> > > 
> > 
> > OK.
> 
> sysfs_create_link is __must_check

Oh, I missed the declaration -- I just saw the definition.  This is a
situation where __must_check hurts us and it should be removed.

Or this code is wrong and it should be

	WARN(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
			"failing_device");

like drivers/pci/controller/vmd.c and drivers/i2c/i2c-mux.c

Either way, the do_empty() construct feels like the wrong way of covering
up the warning.
