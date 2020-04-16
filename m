Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76461AB76B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 07:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406746AbgDPFg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 01:36:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39758 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406579AbgDPFgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:36:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id k15so1166656pfh.6;
        Wed, 15 Apr 2020 22:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GGMjsf7bes7SO0tixSZYBmOOrlUUrx9KPMpJ3HujiA=;
        b=PsugiwtkDvY+ipIWYG68EFplwPnqwl+ZNBLDliiWfrjmYfpNCrbWVQlLPCeZFJo1+4
         cBVu3Y6yasjt919eOIywMIxdlOHVW0ot8RC6U2LwWjCiLshnWGZLE6kJd93fwJkATcfs
         Npj7eg33OWhAsukQ7k1541FD4OwBuGjhZj83zvRo8eaN0AIKDUAeJNojysalrTjkNmnW
         Mw2waBTEdmnX4BDqw7G51WAshAtxIQUQkR682g2BADZ09OJC1hKzE76B29Yc38rmf9lp
         RIxIFu6AK4Y5OxuqE0gReZnlXmqPWhc06G4KFSozUSy+bQ45G5V2DKqHBEDxzh8A+S1a
         OOEA==
X-Gm-Message-State: AGi0PuYGZvY3/MkfWuYMaB5d1auMpae+T1dwxRq1aDCcKDHAgHjBh3kZ
        6YadQLidjV2/CiSyxNYMRhIdCqP7pEQ=
X-Google-Smtp-Source: APiQypKbKv0BkBHKUzEiqUuVeGbX7gfEsR18Wnsdwe3iyXHjlLh95ibBMf8/BWrc5gEIAQNARJvn0Q==
X-Received: by 2002:a65:68c7:: with SMTP id k7mr30843871pgt.248.1587015384681;
        Wed, 15 Apr 2020 22:36:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w5sm15602046pfw.154.2020.04.15.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:36:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C714B40277; Thu, 16 Apr 2020 05:36:22 +0000 (UTC)
Date:   Thu, 16 Apr 2020 05:36:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200416053622.GJ11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200416023122.GB2717677@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416023122.GB2717677@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:31:22AM +0800, Ming Lei wrote:
> On Tue, Apr 14, 2020 at 04:19:00AM +0000, Luis Chamberlain wrote:
> > Ensure that the request_queue is refcounted during its full
> > ioctl cycle. This avoids possible races against removal, given
> > blk_get_queue() also checks to ensure the queue is not dying.
> > 
> > This small race is possible if you defer removal of the request_queue
> > and userspace fires off an ioctl for the device in the meantime.
> > 
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Omar Sandoval <osandov@fb.com>
> > Cc: Hannes Reinecke <hare@suse.com>
> > Cc: Nicolai Stange <nstange@suse.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: yu kuai <yukuai3@huawei.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  kernel/trace/blktrace.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 15086227592f..17e144d15779 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -701,6 +701,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
> >  	if (!q)
> >  		return -ENXIO;
> >  
> > +	if (!blk_get_queue(q))
> > +		return -ENXIO;
> > +
> >  	mutex_lock(&q->blk_trace_mutex);
> >  
> >  	switch (cmd) {
> > @@ -729,6 +732,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
> >  	}
> >  
> >  	mutex_unlock(&q->blk_trace_mutex);
> > +
> > +	blk_put_queue(q);
> > +
> >  	return ret;
> >  }
> 
> Actually when bdev is opened, one extra refcount is held on gendisk, so
> gendisk won't go away. And __device_add_disk() does grab one extra
> refcount on request queue, so request queue shouldn't go away when ioctl
> is running.

Alright, then yes, this should not be needed.

  Luis
