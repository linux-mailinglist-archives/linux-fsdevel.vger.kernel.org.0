Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7C1B153F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 20:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDTS7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 14:59:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38963 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDTS7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:59:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id o10so2293232pgb.6;
        Mon, 20 Apr 2020 11:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vS2me64bhaGvoztRtUly6DA31qoyPEKTQSmzN2e1rQk=;
        b=ZI5MyxmiG2WZxAePNBijeq4h2FEWvxUx7jI6B2LJT5VLQ9QhrX8+ka77LSBElnbdHu
         /N+PX7id9MmDJHdZ7Dk08AgzVWRPqc/yyFmkgU7wx9MbogDhUnfYbZdZmclaLMDCbAe4
         CtLBqDJNgCoF9Bj6eAsUVPjLConV8HqE5wORjMl0QCoiu4rK1cs58zzRIZe9a+Gmk+18
         Rf3Yp78l3fqMd0VwE8vnBnYVzw5uygNlyDhrSqUjwW6I7G/bgthZE04RMgWtwaMy8IoQ
         MNHg+2f/KmtWJBLeRteI7LJhIPcL1ONaXDGligajmh14ItsQwwlXrQ+f7olWrDuxlY5c
         JlSg==
X-Gm-Message-State: AGi0PuZu5J8CsF70sePZrdvPH/MiK8qjV/eOO588LTC4lxQb1M6OShT6
        rHXeupOsWZx2F7SXh6QIP6U=
X-Google-Smtp-Source: APiQypIQvFYPd6xQOO0w3rk4A7NGs+6svQg3+sz428y5VoLXlRjvqH2v49EKU+VVVY1Y+J5i0+5Bww==
X-Received: by 2002:a63:f252:: with SMTP id d18mr2658296pgk.448.1587409185565;
        Mon, 20 Apr 2020 11:59:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c28sm202924pfp.200.2020.04.20.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:59:44 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 98A6F4028E; Mon, 20 Apr 2020 18:59:43 +0000 (UTC)
Date:   Mon, 20 Apr 2020 18:59:43 +0000
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
Subject: Re: [PATCH v2 04/10] block: revert back to synchronous request_queue
 removal
Message-ID: <20200420185943.GM11244@42.do-not-panic.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-5-mcgrof@kernel.org>
 <749d56bd-1d66-e47b-a356-8d538e9c99b4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <749d56bd-1d66-e47b-a356-8d538e9c99b4@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 03:23:31PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > +/**
> > + * blk_put_queue - decrement the request_queue refcount
> > + *
> > + * @q: the request_queue structure to decrement the refcount for
> > + *
> 
> How about following the example from Documentation/doc-guide/kernel-doc.rst
> and not leaving a blank line above the function argument documentation?

Sure.

> > + * Decrements the refcount to the request_queue kobject, when this reaches
>                               ^^
>                               of?
> > + * 0 we'll have blk_release_queue() called. You should avoid calling
> > + * this function in atomic context but if you really have to ensure you
> > + * first refcount the block device with bdgrab() / bdput() so that the
> > + * last decrement happens in blk_cleanup_queue().
> > + */
> 
> Is calling bdgrab() and bdput() an option from a context in which it is not
> guaranteed that the block device is open?

If the block device is not open, nope. For that blk_get_queue() can
be used, and is used by the block layer. This begs the question:

Do we have *drivers* which requires access to the request_queue from
atomic context when the block device is not open?

> Does every context that calls blk_put_queue() also call blk_cleanup_queue()?

Nope.

> How about avoiding confusion by changing the last sentence of that comment
> into something like the following: "The last reference must not be dropped
> from atomic context. If it is necessary to call blk_put_queue() from atomic
> context, make sure that that call does not decrease the request queue
> refcount to zero."

This would be fine, if not for the fact that it seems worthy to also ask
ourselves if we even need blk_get_queue() / blk_put_queue() exported for
drivers.

I haven't yet finalized my review of this, but planting the above
comment cements the idea further that it is possible. Granted, I think
its fine as -- that is our current use case and best practice. Removing
the export for blk_get_queue() / blk_put_queue() should entail reviewing
each driver caller and ensuring that it is not needed. And that is not
done yet, and should be considered a separate effort.

> >   /**
> >    * blk_cleanup_queue - shutdown a request queue
> > + *
> >    * @q: request queue to shutdown
> >    *
> 
> How about following the example from Documentation/doc-guide/kernel-doc.rst
> and not leaving a blank line above the function argument documentation?

Will do.

> >    * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
> >    * put it.  All future requests will be failed immediately with -ENODEV.
> > + *
> > + * You should not call this function in atomic context. If you need to
> > + * refcount a request_queue in atomic context, instead refcount the
> > + * block device with bdgrab() / bdput().
> 
> Surrounding blk_cleanup_queue() with bdgrab() / bdput() does not help. This
> blk_cleanup_queue() must not be called from atomic context.

I'll just remove that.

> 
> >   /**
> > - * __blk_release_queue - release a request queue
> > - * @work: pointer to the release_work member of the request queue to be released
> > + * blk_release_queue - release a request queue
> > + *
> > + * This function is called as part of the process when a block device is being
> > + * unregistered. Releasing a request queue starts with blk_cleanup_queue(),
> > + * which set the appropriate flags and then calls blk_put_queue() as the last
> > + * step. blk_put_queue() decrements the reference counter of the request queue
> > + * and once the reference counter reaches zero, this function is called to
> > + * release all allocated resources of the request queue.
> >    *
> > - * Description:
> > - *     This function is called when a block device is being unregistered. The
> > - *     process of releasing a request queue starts with blk_cleanup_queue, which
> > - *     set the appropriate flags and then calls blk_put_queue, that decrements
> > - *     the reference counter of the request queue. Once the reference counter
> > - *     of the request queue reaches zero, blk_release_queue is called to release
> > - *     all allocated resources of the request queue.
> > + * This function can sleep, and so we must ensure that the very last
> > + * blk_put_queue() is never called from atomic context.
> > + *
> > + * @kobj: pointer to a kobject, who's container is a request_queue
> >    */
> 
> Please follow the style used elsewhere in the kernel and move function
> argument documentation just below the line with the function name.

Sure, thanks for the review.

  Luis
