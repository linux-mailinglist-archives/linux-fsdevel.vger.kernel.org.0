Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB01A477F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 16:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDJOeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 10:34:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36755 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgDJOeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:34:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so726433plo.3;
        Fri, 10 Apr 2020 07:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+yFAafrmf4pwmIiA+Y79JKIZjI1rhBMkVQpyfkMWn4=;
        b=nYd4+A2YbLZWvR2jnq93P23FwGtUekZvgnUrzBEbA29otlYCtvVJHIcpIRknVQq8BW
         l+nY7q3y7sUdaRuxRt4kbswviUJPUBqlj4bEHc2MOSI+MB0M8dr/1h1dSOt6zum9M+o/
         Lext9N4tNUF+r2UPD6wN5DQFWyRWboB5Qh1Qw9HBiF/r9xductfQqE+Da8zCf+7TULdo
         DZo/bU2QiBoUDKh8rWfPi8QT8GWtek5tkPurAc3dvSNJBNqwbzlNbBYBB+BMr/wCil/S
         OMSTbeLT2eMZEUdSSYKBPw1REkIuFzxNmV8l743U/PsP0HCwWjDHBiTIkyZpeVOW7Us6
         abow==
X-Gm-Message-State: AGi0PuZkZYtD4V/uBLf2ZErTPDMjz68hFWiXh1DAAkPZnBfnkvxxXb3Q
        fEC2NVNhpYVhQGUsQOvG73g=
X-Google-Smtp-Source: APiQypKxJktnoKXxj41lDsvADCMSTOOkgTuc9TuhTySLVGXbknFKPRO/LrhuZ3BKq2cjiEPXYn1NKw==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr5009440pls.211.1586529254280;
        Fri, 10 Apr 2020 07:34:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c126sm1953303pfb.83.2020.04.10.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:34:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3D52340630; Fri, 10 Apr 2020 14:34:12 +0000 (UTC)
Date:   Fri, 10 Apr 2020 14:34:12 +0000
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
Subject: Re: [RFC v2 5/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200410143412.GK11244@42.do-not-panic.com>
References: <20200409214530.2413-1-mcgrof@kernel.org>
 <20200409214530.2413-6-mcgrof@kernel.org>
 <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161e938d-929b-1fdb-ba77-56b839c14b5b@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:12:21PM -0700, Bart Van Assche wrote:
> On 2020-04-09 14:45, Luis Chamberlain wrote:
> > blk_put_queue() puts decrements the refcount for the request_queue
>                   ^^^^
>         can this word be left out?

Sure.

> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 8b1cab52cef9..46fee1ef92e3 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -614,6 +614,7 @@ struct request_queue {
> >  #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
> >  #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
> >  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
> > +#define QUEUE_FLAG_DEFER_REMOVAL 28	/* defer queue removal */
> >  
> >  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> >  				 (1 << QUEUE_FLAG_SAME_COMP))
> > @@ -648,6 +649,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> >  #else
> >  #define blk_queue_rq_alloc_time(q)	false
> >  #endif
> > +#define blk_queue_defer_removal(q) \
> > +	test_bit(QUEUE_FLAG_DEFER_REMOVAL, &(q)->queue_flags)
> 
> Since blk_queue_defer_removal() has no callers the code that depends on
> QUEUE_FLAG_DEFER_REMOVAL to be set will be subject to bitrot. It would
> make me happy if the QUEUE_FLAG_DEFER_REMOVAL flag and the code that
> depends on that flag would be removed.

Sure thing.

Feedback on the cover letter thread patch 0/5 about whether or not to
consider userspace impact changes on these changes should be detailed on
the commit log would be useful.

> Please add a might_sleep() call in blk_put_queue() since with this patch
> applied it is no longer allowed to call blk_put_queue() from atomic context.

Sure thing.

  Luis
