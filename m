Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D11AB74A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406457AbgDPF3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 01:29:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45821 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406188AbgDPF3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:29:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id t4so936772plq.12;
        Wed, 15 Apr 2020 22:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ij4rGJFKYYZMX5F8riwLVS0GXQyfAT1zFiaKZy0C85M=;
        b=AXqoMDO4c7CwVybHhi3bDUiC9dkPYsif7yaj0wo0CYlxeb9N5gWz87RzVzcXHKrJLS
         zjoY+8hKbZx0P+eSEz2RADWhJTjyluTfIWccuK9hHW0vUy9OkrOjUoyR4x3lSGij/6He
         Puv2VpYCfbs3ONMEsxSMc08FpyqqteoFgCgsOwHz0NW9HxonulPy5Tllb4geL/wYhMom
         zCDRc26VCf4wjtH6amIcABBMySfZY87VaOKMwijXxmXETdk+z9ouza42t0hdLX50NAd5
         L9xCyPWPXVutBpX77ZYCkqmd6gVtiu4UR5Lfqqg4r2dziJnaCsuC6ooF0ccAdimoj1GT
         g2rw==
X-Gm-Message-State: AGi0PuaAaikMEhpoPjnJ5HMZvfyoN/xB/7R3UmyI9CFC4SwRmi9K1fDO
        LiCqiCSUUgT5AktNz7FtqG4=
X-Google-Smtp-Source: APiQypJtVA7tYtC5+yKFDxY4H+Ux5Opdy5jE7rOi5sFzYU8r893dt7Op6/U6W4QfePu/vQgcNikFYg==
X-Received: by 2002:a17:902:b10d:: with SMTP id q13mr8105119plr.265.1587014951372;
        Wed, 15 Apr 2020 22:29:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f3sm1303896pjo.24.2020.04.15.22.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:29:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 914EF40277; Thu, 16 Apr 2020 05:29:09 +0000 (UTC)
Date:   Thu, 16 Apr 2020 05:29:09 +0000
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
Message-ID: <20200416052909.GI11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <20200415071425.GA21099@infradead.org>
 <20200415123434.GU11244@42.do-not-panic.com>
 <73332d32-b095-507f-fb2a-68460533eeb7@acm.org>
 <20200416011247.GB11244@42.do-not-panic.com>
 <a71d9c9b-72c8-8905-aeba-08e5382f5a81@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71d9c9b-72c8-8905-aeba-08e5382f5a81@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 08:43:32PM -0700, Bart Van Assche wrote:
> On 2020-04-15 18:12, Luis Chamberlain wrote:
> > On Wed, Apr 15, 2020 at 07:18:22AM -0700, Bart Van Assche wrote:
> >> blk_get_queue() prevents concurrent freeing of struct request_queue but
> >> does not prevent concurrent blk_cleanup_queue() calls.
> > 
> > Wouldn't concurrent blk_cleanup_queue() calls be a bug? If so should
> > I make it clear that it would be or simply prevent it?
> 
> I think calling blk_cleanup_queue() while the queue refcount > 0 is well
> established behavior. At least the SCSI core triggers that behavior
> since a very long time. I prefer not to change that behavior.

I see. An alternative is to simply check if we already are cleaning up
and if so abort early on the blk_cleanup_queue(). That would allow
re-entrant calls, and just be a no-op to the additional calls. Or is
the re-entrant, two attemps to really do all the work
blk_cleanup_queue() expected functionality already?

> Regarding patch 3/5: how about dropping that patch? If the queue
> refcount can drop to zero while blk_trace_ioctl() is in progress I think
> that should be fixed in the block_device_operations.open callback
> instead of in blk_trace_ioctl().

I'll take a look, thanks!

  Luis
