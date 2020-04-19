Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7BC1AF9BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSMDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 08:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgDSMDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 08:03:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB2F21841;
        Sun, 19 Apr 2020 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587297788;
        bh=x2vOiaCnxxSwfQdLjmqVJM8lbr3nu9ilx4uLADcHgbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQIo366fubUyRRR8gy2ghwhRQu0Kwnh4p0dbM2JbxKVFUDW8yZ1SDgiYSl5JqwVeR
         wZ5SL8Ku8jXAHvkI6SEOWx2BKIwYfUnNkbRnpiO/xRR81S6FYbEAx2Q4OceLmb8Ctn
         LwJSFTVsq/8XLc3RC94BktgRcZXJ/hdv3QPM50lA=
Date:   Sun, 19 Apr 2020 14:03:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, Rafael Wysocki <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200419120304.GA3668771@kroah.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org>
 <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
 <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 12:15:57PM -0700, Linus Torvalds wrote:
> On Sat, Apr 18, 2020 at 11:57 AM Joe Perches <joe@perches.com> wrote:
> >
> > sysfs_create_link is __must_check
> 
> The way to handle __must_check if you really really don't want to test
> and have good reasons is
> 
>  (a) add a big comment about why this case ostensibly doesn't need the check
> 
>  (b) cast a test of it to '(void)' or something (I guess we could add
> a helper for this). So something like
> 
>         /* We will always clean up, we don't care whether this fails
> or succeeds */
>         (void)!!sysfs_create_link(...)
> 
> There are other alternatives (like using WARN_ON_ONCE() instead, for
> example). So it depends on the code. Which is why that comment is
> important to show why the code chose that option.
> 
> However, I wonder if in this case we should just remove the
> __must_check. Greg? It goes back a long long time.

Yeah, maybe it is time to remove it, the gyrations people go through to
remove the warning when they "know" they are doing it right feels pretty
bad compared to forcing people to check things for "normal" calls to the
function.

thanks,

greg k-h
