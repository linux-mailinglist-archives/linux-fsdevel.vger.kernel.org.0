Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D061A71E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404847AbgDNDiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 23:38:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35946 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404832AbgDNDiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:38:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id n10so5486382pff.3;
        Mon, 13 Apr 2020 20:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h/r5aOsQUftJul1WcNyBZHlZU1sP9juTahr+5gdxxlg=;
        b=eY6Po53FMrgn7zyfImIEoNGBsf3Q/L4BK/JpaOTo3GMlGi+AJIYTAXyruGjEeXrYn6
         koZFvaXlOlw4XTIgYfU3mvCVnmP094gIKjR/aiHyaHmD/8FzxsPJ46eygSbPCiK+hiHb
         AeT4oRa1XFQ+/Oqew27t5EQvNn5lTLYNtdVfbCqQ0qu7aEI+iZ/RDvf1kBkNb6ZmJHp4
         1yv2UrXEaH8TzTPHv/a8YqsMp2RiaDogZf6anz8c3bT4U4Su09ZZT1+Wu6YaqYLlpiAZ
         aZe+1CJijZkYBuyyOdNRj0LzsNQSfw9A+wHOd86ymg+il7R22Q4H2makifKFF5g69b3y
         XV9A==
X-Gm-Message-State: AGi0PuZdgrprLIqVk9DF9dsqjtGyeZd2EgTP1V1yrFX062D485cRXuHd
        MvUeqyw6olu7kjCz0APjrjMo7cmuths=
X-Google-Smtp-Source: APiQypLbMnY7RmOhI54DEIQDHmqf9p5b+ywolxB5Vv3/JhisfnuzWeRXYY9C/ZyBC+MSinBn4WxhUg==
X-Received: by 2002:a63:da47:: with SMTP id l7mr21029707pgj.315.1586835487193;
        Mon, 13 Apr 2020 20:38:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x71sm9855165pfd.129.2020.04.13.20.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:38:05 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EF98140277; Tue, 14 Apr 2020 03:38:04 +0000 (UTC)
Date:   Tue, 14 Apr 2020 03:38:04 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC v2 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200414033804.GO11244@42.do-not-panic.com>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-6-mcgrof@kernel.org>
 <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org>
 <20200410143412.GK11244@42.do-not-panic.com>
 <CAB=NE6VfQH3duMGneJnzEnXzAJ1TDYn26WhQCy8X1Mb_T6esgQ@mail.gmail.com>
 <CAB=NE6XfdgB82ncZUkLpdYvDDdyVvVUd8nUmRCb8LbOQ213QoA@mail.gmail.com>
 <64c9212d-aaa3-d172-0ab9-0fc0e25a019a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c9212d-aaa3-d172-0ab9-0fc0e25a019a@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 04:21:17PM -0700, Bart Van Assche wrote:
> On 2020-04-10 14:27, Luis Chamberlain wrote:
> > On Fri, Apr 10, 2020 at 2:50 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> On Fri, Apr 10, 2020 at 8:34 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>> On Thu, Apr 09, 2020 at 08:12:21PM -0700, Bart Van Assche wrote:
> >>>> Please add a might_sleep() call in blk_put_queue() since with this patch
> >>>> applied it is no longer allowed to call blk_put_queue() from atomic context.
> >>>
> >>> Sure thing.
> >>
> >> On second though, I don't think blk_put_queue() would be the right
> >> place for might_sleep(), given we really only care about the *last*
> >> refcount decrement to 0. So I'll move it to blk_release_queue().
> >> Granted, at that point we are too late, and we'd get a splat about
> >> this issue *iff* we really sleep. So yeah, I do suppose that forcing
> >> this check there still makes sense.
> > 
> > I'll add might_sleep() to both blk_release_queue() *and* blk_cleanup_queue().
> 
> Since there is already an unconditional mutex_lock() call in
> blk_cleanup_queue(), do we really need to add a might_sleep() call in
> blk_cleanup_queue()?

You are right, mutex_lock() already has a might_sleep() sprinkled on it.

  Luis
