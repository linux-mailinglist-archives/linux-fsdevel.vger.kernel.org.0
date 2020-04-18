Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35DE1AF42F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgDRTRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:17:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47480 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgDRTRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:17:20 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPswv-00APdE-Hr; Sat, 18 Apr 2020 21:16:21 +0200
Message-ID: <ae170e7c4988399e63a00ad8505e397665563d22.camel@sipsolutions.net>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Matthew Wilcox <willy@infradead.org>, Joe Perches <joe@perches.com>
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
        linux-nfs@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
Date:   Sat, 18 Apr 2020 21:16:19 +0200
In-Reply-To: <20200418191338.GR5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
         <20200418184111.13401-8-rdunlap@infradead.org>
         <20200418185033.GQ5820@bombadil.infradead.org>
         <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
         <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
         <20200418191338.GR5820@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-04-18 at 12:13 -0700, Matthew Wilcox wrote:
> 
> > > > >  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > > >  			      "failing_device"))
> > > > > -		/* nothing - symlink will be missing */;
> > > > > +		do_empty(); /* nothing - symlink will be missing */
> > > > >  
> > > > >  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> > > > >  			      "devcoredump"))
> > > > > -		/* nothing - symlink will be missing */;
> > > > > +		do_empty(); /* nothing - symlink will be missing */
> > > > >  
> > > > >  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> > > > >  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> > > > 
> > > > Could just remove the 'if's?
> > > > 
> > > > +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> > > > +			"failing_device");
> > > > 
> > > 
> > > OK.
> > 
> > sysfs_create_link is __must_check
> 
> Oh, I missed the declaration -- I just saw the definition.  This is a
> situation where __must_check hurts us and it should be removed.
> 
> Or this code is wrong and it should be
> 
> 	WARN(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> 			"failing_device");

Perhaps it should be. I didn't think it really mattered _that_ much if
the symlink suddenly went missing, but OTOH I don't even know how it
could possibly fail.

johannes

