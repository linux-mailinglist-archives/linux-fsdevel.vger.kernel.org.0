Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE771AB54A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgDPBMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:12:54 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34873 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgDPBMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:12:52 -0400
Received: by mail-pj1-f65.google.com with SMTP id mn19so649189pjb.0;
        Wed, 15 Apr 2020 18:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6RGJvUJSeZs+AqGP/+hRpTOyIR7EwKBAzBmmAfw6j+g=;
        b=gXLMJpIZwDODnbJgOTKnUnAcjCXuUZK4aGT9KwAAaB72qUw6FOQubr6ObxCXHeHHpv
         NbFBTzbr6fnYB1CfaBuPjRJv3nt3aJPzyW55c8+SrC4rmzdRGZYzh7oY2TmyCOFdlUG5
         HERlLL9m03bDpJGl51mWefnfG7cJtV/AFk1nhRUedaWKy97OLIigCD4EuRwLZRpGJ9uB
         XlEAJ3gtWZJ7b4R4s7q4JdyViCeKmlc8lI0MVt5aUfHN3h2lSGWFLCuNw+maPZB52dsK
         fHwfVUTs2I3zPDISG0YRds9fK7rGdsQma/F8LvXQmcACXIXy8+uWR2S460fi9AIxBCyU
         JF2A==
X-Gm-Message-State: AGi0PuYHuQWw3/2lVRcrjHhkMO8cEKbNuh/ERcPZFho2NK/vKPlgPQ6R
        1ipcI65i3w4Vy1cIQr0T2v0=
X-Google-Smtp-Source: APiQypKlxk/W+Q2C4OhNaifz/k6mqtcY/FE1S4DOTOwoBaf22/rB+RYPOVbi0ndi61BGIVJkBF/W3Q==
X-Received: by 2002:a17:902:7c12:: with SMTP id x18mr7131442pll.250.1586999569702;
        Wed, 15 Apr 2020 18:12:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s74sm150560pgc.50.2020.04.15.18.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:12:48 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E7A8440277; Thu, 16 Apr 2020 01:12:47 +0000 (UTC)
Date:   Thu, 16 Apr 2020 01:12:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200416011247.GB11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
 <73332d32-b095-507f-fb2a-68460533eeb7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73332d32-b095-507f-fb2a-68460533eeb7@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 07:18:22AM -0700, Bart Van Assche wrote:
> On 2020-04-15 05:34, Luis Chamberlain wrote:
> > On Wed, Apr 15, 2020 at 12:14:25AM -0700, Christoph Hellwig wrote:
> >> Btw, Isn't blk_get_queue racy as well?  Shouldn't we check
> >> blk_queue_dying after getting the reference and undo it if the queue is
> >> indeeed dying?
> > 
> > Yes that race should be possible:
> > 
> > bool blk_get_queue(struct request_queue *q)                                     
> > {                                                                               
> > 	if (likely(!blk_queue_dying(q))) {
> >        ----------> we can get the queue to go dying here <---------
> > 		__blk_get_queue(q);
> > 		return true;
> > 	}                                                                       
> > 
> > 	return false;
> > }                                                                               
> > EXPORT_SYMBOL(blk_get_queue);
> > 
> > I'll pile up a fix. I've also considered doing a full review of callers
> > outside of the core block layer using it, and maybe just unexporting
> > this. It was originally exported due to commit d86e0e83b ("block: export
> > blk_{get,put}_queue()") to fix a scsi bug, but I can't find such
> > respective fix. I suspec that using bdgrab()/bdput() seems more likely
> > what drivers should be using. That would allow us to keep this
> > functionality internal.
> 
> blk_get_queue() prevents concurrent freeing of struct request_queue but
> does not prevent concurrent blk_cleanup_queue() calls.

Wouldn't concurrent blk_cleanup_queue() calls be a bug? If so should
I make it clear that it would be or simply prevent it?

> Callers of
> blk_get_queue() may encounter a change of the queue state from normal
> into dying any time during the blk_get_queue() call or after
> blk_get_queue() has finished. Maybe I'm overlooking something but I
> doubt that modifying blk_get_queue() will help.

Good point, to fix that race described by Christoph we'd have to take
into consideration refcounts of the request_queue to prevent queues from
changing state to dying if the refcount is > 1, however that'd also
would  mean not allowing the request_queue from ever dying.

One way we could resolve this could be to to keep track of a
quiesce/dying request, then at that point prevent blk_get_queue() from
allowing increments, and once the refcount is down to 1, flip the switch
to dying.

  Luis
