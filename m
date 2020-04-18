Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC271AF394
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgDRSoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgDRSoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:44:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2CC061A0C;
        Sat, 18 Apr 2020 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tL7oBItZTGP6Ja0KJzj5epfoD8nvKm3R0ync/alPIPM=; b=XZDspZHLNEdieJauqz1tT3tU6E
        YTnCIpvp5xSBzMeKUYN/ZrY33Xv8ujXKOpRTHETYgjlXYNG9Bevf+VNJTem44EiEuHW7Kf02I1k/X
        SJhnpcUnJ6bRMlTie1XiEGAADIuP2UhPDajunCcwmIaLQ9R7A0f83xZxenWNGKa6FZUj7cMWrxEBg
        PSon0anIZCVaqUvfDbOlu0w9rllj/BKv5pm+pUXO24gnqsHCRmlgucoKgC2iB8Ur4nykcm4RDvIcd
        Z3/5U9tzWaeZCnR4s79Lw+eywQDgY2zp8dPurJQWwcNvxfQ7gTQUf4A+LyA8bN9q1CVLcYHJlvoR/
        44a0PpaA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsRm-0008GS-2P; Sat, 18 Apr 2020 18:44:10 +0000
Date:   Sat, 18 Apr 2020 11:44:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
Message-ID: <20200418184409.GP5820@bombadil.infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-6-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-6-rdunlap@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
> +++ linux-next-20200327/drivers/usb/core/sysfs.c
> @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
>  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
>  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
>  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
> -		;	/* We don't actually care if the function fails. */
> +		do_empty(); /* We don't actually care if the function fails. */
>  	intf->sysfs_files_created = 1;
>  }

Why not just?

+	if (alt->string)
+		device_create_file(&intf->dev, &dev_attr_interface);

