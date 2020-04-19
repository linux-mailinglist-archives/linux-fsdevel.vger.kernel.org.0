Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF71AF8A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDSIPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgDSIPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 04:15:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4604DC061A0C;
        Sun, 19 Apr 2020 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ESkbM+8vdIgFeaQKLQyxVIJU96HxbIdvJ6LQfSPcow=; b=pvwx1GcXIeC3t5uPawsWBkdVHQ
        iiXxl+0atw1Ow7dCeTaEPlV5pGZmU5NeEHgiD6GauX1slXAECXQsFNE9NMWu2519ywz/b+wff/WOX
        TMC/+MPMdjO3TT0Rftrna/Ci0Cahq1lB09MN0hgPjg6UlZQSvFQvI8Hl6eF9ZnaIwxOSfJg5ri8Io
        KIuagSQHqNGIuLyx0OKk7Kr7BqpWFvOxOSCJWQS71I0fmCgMrFQjcaFVpza7oTJ7VbiVVU4LRpdAF
        8xATbPDeZWMvxCY4UHfmtjy1TJqqQqEx8Dbn+J6I61UlAQZJU8HDszvtYFjQWk5yWngyPZTufulmD
        TFNoMHog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQ57G-0008EZ-Na; Sun, 19 Apr 2020 08:15:50 +0000
Date:   Sun, 19 Apr 2020 01:15:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
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
Subject: Re: [PATCH 8/9] dax: fix empty-body warnings in bus.c
Message-ID: <20200419081550.GA22341@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-9-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-9-rdunlap@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41:10AM -0700, Randy Dunlap wrote:
>  				rc = -ENOMEM;
>  		} else
> -			/* nothing to remove */;
> +			do_empty(); /* nothing to remove */
>  	} else if (action == ID_REMOVE) {
>  		list_del(&dax_id->list);
>  		kfree(dax_id);
>  	} else
> -		/* dax_id already added */;
> +		do_empty(); /* dax_id already added */

This is just nasty.  Please just always turn this bogus warning off
as the existing code is a perfectly readable idiom while the new code
is just nasty crap for no good reason at all.
