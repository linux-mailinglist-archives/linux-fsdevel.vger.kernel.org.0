Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18D81C2AD9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 May 2020 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgECJJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 May 2020 05:09:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44519 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgECJJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 May 2020 05:09:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id l20so7035684pgb.11;
        Sun, 03 May 2020 02:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pz+7fmmOLiHvlX4Oa/JOFFvJP8vnA71Hx7aLAhOtAu4=;
        b=SUmNDkSQ0A3u0BOYvFBjYHivpe1MFTFZMMyzm/M6IiSrrWfiP+nRA12eUuO7jAZ770
         F62VBNynJeHA+WG4ABqmsTfPzYjH/1Tff1DL1RLeqdEA3xrRXPk1wzmbPQYMfMSnfb63
         OutwncfcWAuePPSk8XjzmUT7hkILB+FeMRLip+aib2Qz9ENDoSJW4VZUjTAPEJjOt9hS
         ijbqPt+hnOUOHo8+ZSf6rDmJ8LYYZFr3dBX6T27YSp/lzVOKhLXrvCQFs4O0E0tc5hLU
         bwaQpOnAVqNu/d+dM3I1cOYTEDaK2zJ7D7VScaAxXlWrc6mZWQh6i8DxmAozFv7XZ9Dx
         ZQsw==
X-Gm-Message-State: AGi0PuZvph7MqHHPR7jfhfbtnQLuY2lQsGSE9Gqmj/Z+FeeIfYvfpuZ0
        Kqe5nUICBmgq2ug0xSH16P0=
X-Google-Smtp-Source: APiQypIdYUfg+5dhTvIoYTyrqqWdYIDeNhDSPlvSkIws0w55SQ7aMbgV4xFiIfN1Yg3LnHw9AHMQzw==
X-Received: by 2002:a62:7c16:: with SMTP id x22mr12008122pfc.267.1588496965480;
        Sun, 03 May 2020 02:09:25 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o99sm3886559pjo.8.2020.05.03.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:09:24 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AD1C640256; Sun,  3 May 2020 09:09:23 +0000 (UTC)
Date:   Sun, 3 May 2020 09:09:23 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200503090923.GP11244@42.do-not-panic.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-7-mcgrof@kernel.org>
 <20200429095034.GC2081185@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429095034.GC2081185@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:50:34AM +0200, Greg KH wrote:
> On Wed, Apr 29, 2020 at 07:46:27AM +0000, Luis Chamberlain wrote:
> > Be pedantic on removal as well and hold the mutex.
> > This should prevent uses of addition while we exit.
> > 
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/block/loop.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index da693e6a834e..6dccba22c9b5 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
> >  
> >  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
> >  
> > +	mutex_lock(&loop_ctl_mutex);
> > +
> >  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
> >  	idr_destroy(&loop_index_idr);
> >  
> > @@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
> >  	unregister_blkdev(LOOP_MAJOR, "loop");
> >  
> >  	misc_deregister(&loop_misc);
> > +
> > +	mutex_unlock(&loop_ctl_mutex);
> >  }
> >  
> >  module_init(loop_init);
> 
> What type of issue is this helping with?  Can it be triggered today?  if
> so, shouldn't it be backported to stable kernels?

Just code inspection. I can't trigger a userspace test script to crash
the kernel yet, but suspect a race still does exist.

  Luis
