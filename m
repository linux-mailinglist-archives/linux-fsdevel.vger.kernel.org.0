Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91D817490F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 21:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgB2UCE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 15:02:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39106 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgB2UCE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:02:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so6965911wme.4;
        Sat, 29 Feb 2020 12:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HtXVHt8g2TngqQLkSV4rjhDAGaSXSD43YSdcP2E8DE=;
        b=BGTE4xeWqaSXlX2J+uJwVmYWsT03oEBO4Jd0ECUO1GpmPi9OCLcmTmKD4QibJhbgFo
         YyFF1lzdQBXKUg7Csmt/Zz7ieUDaC9xWAcxpIjUprhcxZDWUu4zvmgfOFzC2Y7nKqF+l
         lCWmqu8kcfy5EpoXBQ6vfQ3XR9GHoVirpAYSz+HPf8Q4XLmtXqWAiMeXUYgiRGUtX622
         peP3KVH825faU69qYaZvEkNHnM1JRHHbpFTjqNCZ8kF2RAIJx3Y4xTHp3oldTIQv7KOQ
         QqLixyBT5/ELrj/0lDQ6QyXp0z6tEug98Eg/AcRkruReSiH0lcfbakIwGiShvtZAEth+
         t0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HtXVHt8g2TngqQLkSV4rjhDAGaSXSD43YSdcP2E8DE=;
        b=my8RMZbB2waV+eiV9e9hO1+x9+bKhN/S3vy0gHgd2iWr9QZoAnFKqzyqUSnfABmnSI
         5+/GNPq18UFt+NGBS0gywOcY/Zjp5EKeTXjatjNBbzZoJZCI0EfabWfJCSoDEiCuNFrh
         EU6QGjx87W3ysEpbOhcBJsReC+mocKBDSOR/X4JXMqRnoL7pvjE1u8Mbq/sd07wm6gzA
         nYGU4W8FaXvOXw1XNSBRTemI2g9dXxv0RHWMX44XxajZMG3tH4CkYcxn2CE1IK9IbPXu
         chPAs8I2md5VZc26O644WaSuO5hbA2ZG5ctEbtpbZ9Mc4ZhdohB/fL+BjDMMZoXN+mYw
         Ab/A==
X-Gm-Message-State: APjAAAWzoM5bmKZWYnSrjwv7EJA5KWkG+/VtyFKI2gAQeB/y9oIr7FUz
        OLWipHe6Tl6/nYkbBVFFYjl5jRBe6D/fuA==
X-Google-Smtp-Source: APXvYqxbFIq7i7LKjT21XwH6j2UsGVWt6/c8aIGMmDQZIOQQCTABOEMv0TFHJvBePC50BRN6G7NuKQ==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr10605147wma.159.1583006523007;
        Sat, 29 Feb 2020 12:02:03 -0800 (PST)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id b18sm18637473wru.50.2020.02.29.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 12:02:02 -0800 (PST)
Date:   Sat, 29 Feb 2020 21:02:00 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, mkleinsoft@gmail.com, hch@lst.de,
        akpm@linux-foundation.org, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz
Subject: Re: [PATCH] hibernate: unlock swap bdev for writing when uswsusp is
 active
Message-ID: <20200229200200.GA10970@dumbo>
References: <20200229170825.GX8045@magnolia>
 <20200229180716.GA31323@dumbo>
 <20200229183820.GA8037@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229183820.GA8037@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 10:38:20AM -0800, Darrick J. Wong wrote:
> On Sat, Feb 29, 2020 at 07:07:16PM +0100, Domenico Andreoli wrote:
> > On Sat, Feb 29, 2020 at 09:08:25AM -0800, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > 
> > > It turns out that there /is/ one use case for programs being able to
> > > write to swap devices, and that is the userspace hibernation code.  The
> > > uswsusp ioctls allow userspace to lease parts of swap devices, so turn
> > > S_SWAPFILE off when invoking suspend.
> > > 
> > > Fixes: 1638045c3677 ("mm: set S_SWAPFILE on blockdev swap devices")
> > > Reported-by: Domenico Andreoli <domenico.andreoli@linux.com>
> > > Reported-by: Marian Klein <mkleinsoft@gmail.com>
> > 
> > I also tested it yesterday but was not satisfied, unfortunately I did
> > not come with my comment in time.
> > 
> > Yes, I confirm that the uswsusp works again but also checked that
> > swap_relockall() is not triggered at all and therefore after the first
> > hibernation cycle the S_SWAPFILE bit remains cleared and the whole
> > swap_relockall() is useless.
> > 
> > I'm not sure this patch should be merged in the current form.
> 
> NNGGHHGGHGH /me is rapidly losing his sanity and will soon just revert
> the whole security feature because I'm getting fed up with people
> yelling at me *while I'm on vacation* trying to *restore* my sanity.  I
> really don't want to be QAing userspace-directed hibernation right now.

Maybe we could proceed with the first patch to amend the regression and
postpone the improved fix to a later patch? Don't loose sanity for this.

> ...right, the patch is broken because we have to relock the swapfiles in
> whatever code executes after we jump back to the restored kernel, not in
> the one that's doing the restoring.  Does this help?

I made a few unsuccessful attempts in kernel/power/hibernate.c and
eventually I'm switching to qemu to speed up the test cycle.

> OTOH, maybe we should just leave the swapfiles unlocked after resume.
> Userspace has clearly demonstrated the one usecase for writing to the
> swapfile, which means anyone could have jumped in while uswsusp was
> running and written whatever crap they wanted to the parts of the swap
> file that weren't leased for the hibernate image.

Essentially, if the hibernation is supported the swapfile is not totally
safe. Maybe user-space hibernation should be a separate option.

> 
> --D

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
