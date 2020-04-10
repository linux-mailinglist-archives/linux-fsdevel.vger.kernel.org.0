Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732161A4784
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJOe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 10:34:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgDJOe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:34:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id l1so1103957pff.10;
        Fri, 10 Apr 2020 07:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiasH6wCnDGCTdH9mzlfIlSZUoRnw4cIEE89UnT/Y/c=;
        b=Z4hQ9i7tKJP6LjsuwIuk4uSGY4EaPDBrV4fedQMhodSG0z05BiHWDMWhoOc0MSvqa7
         1DvePot9jlpfTbNcL+1kRo+o3wQldtLR1jNkc8UtBrUcKQruT3usveT074qWvRFaXJaL
         VUE1jWE0R+0cjTf4SOBIFRMELmot5Xi59n7jKFrGE1zIXMjThHxk1Q9P+X13CLJXFT4H
         6qdvdB4MBNPOHInvNDXR6sewCxXqh2H5c0V7xbVh3xwKrARl4rXHV+MwKpu2Z3tLowl7
         zH6sbQxU47u66iU5Qi88hOtF/t+9B/Eu6TWzj42rib2C9hnaFzE+cg2SJkbRoh8KmXA0
         zHRQ==
X-Gm-Message-State: AGi0PuY1Prtdc63X6K65/xE5i3FmKBYNMaBQFXhYvikk3h+cs9Ak+lGn
        dM2isuipGg5W/391NoQJH0A=
X-Google-Smtp-Source: APiQypLWmTwZhj96obnuL8BMloW/igvcDJXIQg366hd4jfScUoh9JrDWnnjg3g++vQtKj/IO2ajdvA==
X-Received: by 2002:a63:741a:: with SMTP id p26mr5078048pgc.40.1586529296982;
        Fri, 10 Apr 2020 07:34:56 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j24sm1918955pji.20.2020.04.10.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:34:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3C5940630; Fri, 10 Apr 2020 14:34:54 +0000 (UTC)
Date:   Fri, 10 Apr 2020 14:34:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC v2 4/5] mm/swapfile: refcount block and queue before using
 blkcg_schedule_throttle()
Message-ID: <20200410143454.GL11244@42.do-not-panic.com>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-5-mcgrof@kernel.org>
 <5001fb4f-28b8-26b1-fc66-11b3105b15b9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5001fb4f-28b8-26b1-fc66-11b3105b15b9@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:02:59PM -0700, Bart Van Assche wrote:
> On 2020-04-09 14:45, Luis Chamberlain wrote:
> >  		if (si->bdev) {
> > +			bdev = bdgrab(si->bdev);
> > +			if (!bdev)
> > +				continue;
> > +			/*
> > +			 * By adding our own bdgrab() we ensure the queue
> > +			 * sticks around until disk_release(), and so we ensure
> > +			 * our release of the request_queue does not happen in
> > +			 * atomic context.
> > +			 */
> >  			blkcg_schedule_throttle(bdev_get_queue(si->bdev),
> >  						true);
> 
> How about changing the si->bdev argument of blkcg_schedule_throttle()
> into bdev?

Sure, thanks!

  Luis
