Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F071AA136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369776AbgDOMeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 08:34:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46280 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S369768AbgDOMeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:34:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id 188so1401864pgj.13;
        Wed, 15 Apr 2020 05:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rcRovzoWQ44rccZ9H/a7flVu7Tih9ve+r3FKd13LlAQ=;
        b=iyKCCZfsqg0xkZHoekMMOYD9rKj9JjHmxgHZmU1o+NpkH1lCzQKZPkQ4mgaAxdj+kq
         IB9lEHqyRGLg4LzgKPwwLKPiYDhqLwsXLiV1TRRkPZhNNXxkIRxdViBJ3yS3K6d7U+5x
         Ew3msygGyukvDjsHv2sIcFXuI5Asfmg7xW7GY3XQgdjkBw18ofn8Y7cFdGWG6K0yhrj9
         mVZXfanMdzT632HdhZoBIYCdRdn6jyrad2huEo1QPmjLR+dSrZR7bLqDS2Cxipd2UI1C
         MFtt37Hr9ZEsVae3uf0naN6jhA041uC+AIuszUo62me9feE1IM2A6wAQnAKY4WQl7ahP
         m6dw==
X-Gm-Message-State: AGi0PuYP6Uc1Y1haWX3woBilWZqsrYb4Ehu9c9UEzVHEz+mKKkMSv0zt
        r0KpinT/mgLr+Z5LLkZPpgI=
X-Google-Smtp-Source: APiQypKeqxCW3QQL5aO52Dw6wP6HdxhoJjvtMA6kum1OCbDCHdbtO6A7AQ4QxcYQpPoWr42KEAvvmg==
X-Received: by 2002:a63:cd08:: with SMTP id i8mr22905838pgg.55.1586954076359;
        Wed, 15 Apr 2020 05:34:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o15sm12562445pgj.60.2020.04.15.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 05:34:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1649340277; Wed, 15 Apr 2020 12:34:34 +0000 (UTC)
Date:   Wed, 15 Apr 2020 12:34:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/5] blktrace: refcount the request_queue during ioctl
Message-ID: <20200415123434.GU11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415071425.GA21099@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:14:25AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 06:16:49AM +0000, Luis Chamberlain wrote:
> > The BLKTRACESETUP above works on request_queue which later
> > LOOP_CTL_DEL races on and sweeps the debugfs dir underneath us.
> > If you use this commit alone though, this doesn't fix the race issue
> > however, and that's because of both still the debugfs_lookup() use
> > and that we're still using asynchronous removal at this point.
> > 
> > refcounting will just ensure we don't take the request_queue underneath
> > our noses.
> > 
> > Should I just add this to the commit log?
> 
> That sounds much more useful than the trace.
> 
> Btw, Isn't blk_get_queue racy as well?  Shouldn't we check
> blk_queue_dying after getting the reference and undo it if the queue is
> indeeed dying?

Yes that race should be possible:

bool blk_get_queue(struct request_queue *q)                                     
{                                                                               
	if (likely(!blk_queue_dying(q))) {
       ----------> we can get the queue to go dying here <---------
		__blk_get_queue(q);
		return true;
	}                                                                       

	return false;
}                                                                               
EXPORT_SYMBOL(blk_get_queue);

I'll pile up a fix. I've also considered doing a full review of callers
outside of the core block layer using it, and maybe just unexporting
this. It was originally exported due to commit d86e0e83b ("block: export
blk_{get,put}_queue()") to fix a scsi bug, but I can't find such
respective fix. I suspec that using bdgrab()/bdput() seems more likely
what drivers should be using. That would allow us to keep this
functionality internal.

Think that's worthy review?

  Luis
