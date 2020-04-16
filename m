Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC51AB566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbgDPBUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:20:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37743 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgDPBUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:20:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id m16so737183pls.4;
        Wed, 15 Apr 2020 18:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/UVxcfsOZlATHrxT1BtEcSV7XCXKURmZ3LY2D7NJu8=;
        b=GRK6vtwHQr7J5X5gTqGepEtXDoAkqfJ2WjCUR9SUFTH5op5ZTalSNcQ7tna/6/ZJQs
         afGzNMNaL09l6yF0o+ltAy2ExfbmqrE/UbemKRDgzpbUBpT2ve+P3InAK4bvuTRuO00T
         fN4gYNCxxrpvfrfJFb6g7u8ySOiYKGRKCzOkByz3pGFvkHoToadeuGhThyoiEVDELVJq
         p3+vTb6OnwhjFHbWZU5Q9BeiuQvKg3bIasZfL5sOByY2YB3tluGAl+yQYVzZ7pXClMnk
         gdPU1S60ao+2f8HHoX58QuE0LwreD/sPpzE03NBCylLm4dyZ+gj4uWGtSxiam4MUrXkj
         1wbA==
X-Gm-Message-State: AGi0Puaip4bddKRY3O/5wr2HMO6rWfxKhYP4+pyv8xzCcCxbsqHOWgLN
        GsSf06JvUSHGe85MtKVy7DE=
X-Google-Smtp-Source: APiQypKsoy5OswG4beg+t+DZPY2ToYWmF3rusQi++8/xjuNFf2sr4eDmbcDmFPW16CTt2byhESFlqA==
X-Received: by 2002:a17:902:9b89:: with SMTP id y9mr6854674plp.75.1587000044633;
        Wed, 15 Apr 2020 18:20:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c3sm14942152pfa.160.2020.04.15.18.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:20:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C7B7C40277; Thu, 16 Apr 2020 01:20:42 +0000 (UTC)
Date:   Thu, 16 Apr 2020 01:20:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
Message-ID: <20200416012042.GD11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
 <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
 <20200416005636.GA11244@42.do-not-panic.com>
 <924950e6-e016-25b2-4ee1-b5ea9f752c12@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924950e6-e016-25b2-4ee1-b5ea9f752c12@sandeen.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:02:04PM -0500, Eric Sandeen wrote:
> 
> 
> On 4/15/20 7:56 PM, Luis Chamberlain wrote:
> > On Wed, Apr 15, 2020 at 12:38:26PM -0500, Eric Sandeen wrote:
> >> On 4/13/20 11:18 PM, Luis Chamberlain wrote:
> >>> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> >>> merged on v4.12 Omar fixed the original blktrace code for request-based
> >>> drivers (multiqueue). This however left in place a possible crash, if you
> >>> happen to abuse blktrace in a way it was not intended.
> >>>
> >>> Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
> >>> forget to BLKTRACETEARDOWN, and then just remove the device you end up
> >>> with a panic:
> >>
> >> I think this patch makes this all cleaner anyway, but - without the apparent
> >> loop bug mentioned by Bart which allows removal of the loop device while blktrace
> >> is active (if I read that right), can this still happen?
> > 
> > I have not tested that, but some modifications of the break-blktrace
> > program could enable us to test that
> 
> FWIW, I modified it to modprobe & rmmod scsi_debug instead of the loop ioctls,
> and the module can't be unloaded after the blktrace is started since it's busy.
> 
> Not sure that's equivalent tho.

Given what Bart mentioned about sd_open, that might be the saving grace
for blocking async behaviour on scsi. If it only refcounted the
request_queue as the loop driver it would have been exposed to the
same bug.

> > however I don't think the race
> > would be possible after patch 3/5 "blktrace: refcount the request_queue
> > during ioctl" is merged, as removal then a pending blktrace would
> > refcount the request_queue and the removal would have to wait until
> > the refcount is decremeneted, until after the blktrace ioctl.
> 
> I'm out of my depth in the block layer, not sure who's supposed to take
> refs on what. ;)

I'm new to all this code, only been a few weeks looking into it, but am
trying to do my best ot make sense of it. So the above is what I can
tell would be needed.

  Luis
