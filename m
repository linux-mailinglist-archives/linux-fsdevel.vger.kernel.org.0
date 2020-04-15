Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451DA1A930C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393516AbgDOGQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 02:16:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36962 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbgDOGQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:16:53 -0400
Received: by mail-pj1-f67.google.com with SMTP id z9so6252767pjd.2;
        Tue, 14 Apr 2020 23:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKwt+k2pDUu9qpX8GZzWlBWNHQkyl61044lYkr3xgoo=;
        b=VK3NqCX5GJWZR0IOMzFqowungM2D3Z17M9Tml2MsGpuucVJHN5yvKWFkEuDJIvqgMg
         5llyEJCK7ew5cRHTwkCO5X+plfbmI+sQUJmjH9vJa78UL9JIetbzZSGDnGsIhXqu34Zb
         jsm0FLvYnEwwuATKf9otvBS4UmVh0Jl6JIyw7+sGk0o6Hdd2vA7qgc1HHrWye8EhwzS/
         s3gN2vwI9kq3MJ6AFxDISXTvvDPKmW67KStV0BA9+Tmec5KO0tc+C0JUDr7ijfCXKm4h
         4bSoCWLfFR5BO/bb5Hk8VDHtZehaXI3safCQElFyXMKsftiyK2C/Jys8sPpPGYIdRhdA
         pGfQ==
X-Gm-Message-State: AGi0Pua0RB9AQdtE12qPRkRPDBXXeS4vTIahdbmTXgGcFshudAs8Geeh
        92U8g6vIguFkwLvjPALHbtI=
X-Google-Smtp-Source: APiQypLUnBYTt2JPAvzaO1zJS12kV1LMzAoWxzi3yM07dJiAaH0luQJiHmQw3RCIjIBzSRfPCV0Vfw==
X-Received: by 2002:a17:902:7616:: with SMTP id k22mr2578548pll.39.1586931411005;
        Tue, 14 Apr 2020 23:16:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z16sm3078792pfa.3.2020.04.14.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:16:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2980940277; Wed, 15 Apr 2020 06:16:49 +0000 (UTC)
Date:   Wed, 15 Apr 2020 06:16:49 +0000
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
Message-ID: <20200415061649.GS11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414154044.GB25765@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:40:44AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 14, 2020 at 04:19:00AM +0000, Luis Chamberlain wrote:
> > Ensure that the request_queue is refcounted during its full
> > ioctl cycle. This avoids possible races against removal, given
> > blk_get_queue() also checks to ensure the queue is not dying.
> > 
> > This small race is possible if you defer removal of the request_queue
> > and userspace fires off an ioctl for the device in the meantime.
> 
> Hmm, where exactly does the race come in so that it can only happen
> after where you take the reference, but not before it?  I'm probably
> missing something, but that just means it needs to be explained a little
> better :)

From the trace on patch 2/5:

    BLKTRACE_SETUP(loop0) #2
    [   13.933961] == blk_trace_ioctl(2, BLKTRACESETUP) start
    [   13.936758] === do_blk_trace_setup(2) start
    [   13.938944] === do_blk_trace_setup(2) creating directory
    [   13.941029] === do_blk_trace_setup(2) using what debugfs_lookup() gave
    
    ---> From LOOP_CTL_DEL(loop0) #2
    [   13.971046] === blk_trace_cleanup(7) end
    [   13.973175] == __blk_trace_remove(7) end
    [   13.975352] == blk_trace_shutdown(7) end
    [   13.977415] = __blk_release_queue(7) calling blk_mq_debugfs_unregister()
    [   13.980645] ==== blk_mq_debugfs_unregister(7) begin
    [   13.980696] ==== blk_mq_debugfs_unregister(7) debugfs_remove_recursive(q->debugfs_dir)
    [   13.983118] ==== blk_mq_debugfs_unregister(7) end q->debugfs_dir is NULL
    [   13.986945] = __blk_release_queue(7) blk_mq_debugfs_unregister() end
    [   13.993155] = __blk_release_queue(7) end
    
    ---> From BLKTRACE_SETUP(loop0) #2
    [   13.995928] === do_blk_trace_setup(2) end with ret: 0
    [   13.997623] == blk_trace_ioctl(2, BLKTRACESETUP) end

The BLKTRACESETUP above works on request_queue which later
LOOP_CTL_DEL races on and sweeps the debugfs dir underneath us.
If you use this commit alone though, this doesn't fix the race issue
however, and that's because of both still the debugfs_lookup() use
and that we're still using asynchronous removal at this point.

refcounting will just ensure we don't take the request_queue underneath
our noses.

Should I just add this to the commit log?

  Luis
