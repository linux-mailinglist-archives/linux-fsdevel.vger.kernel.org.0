Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787B01CDB80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgEKNmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 09:42:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34683 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgEKNmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 09:42:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so4583268pgm.1;
        Mon, 11 May 2020 06:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIDelSWrVMd4wzslSXY+S/8EPWOMtPyA+78GmbBUxQs=;
        b=eVzjHAMcNCzzovnEkM9oLssKIHrKfQB9g8fPqRc/y/H76V5BYVQg35CDjulPLNuVgd
         gVMDftssU/Bsu81woOVa2tdH6CzHLPNPPeBZ9LVpokwKZv8yT7ToSduCNP0PmtE2wGcA
         hvMKQ4VudXr0KdDUPT7zLmhUGGp3JMlA8jQWJdJ/va+3HpyLL+w33bSlLESY6OJxmAHr
         VCw4YmK15FddqU9Ut61oMjhOfGr2ZHbOvwiKmfTDJRhkcE22LXnjI0LpaFfq0nt8EqBP
         5e+u9LvfUBjIq+wXTEGJ8CQACk36SNed+ddPXRLyCc/WHoKLJsapxH2ckFEIJDBgi2/0
         3W2g==
X-Gm-Message-State: AGi0PubcibCv8413Yj+28GpMJlUhzu/9TKZgyJVXNgqjq2LGeQCN/RYE
        tgGzZyhErDCP73otnp5rRdw=
X-Google-Smtp-Source: APiQypIZPBaiUhTo+Rf4nWN5ZuL6XAd113JqiuXFvjEua9tZjOZI8u/9GM/EHMsS8Y4Ci3SNd/frlg==
X-Received: by 2002:a63:c109:: with SMTP id w9mr14561069pgf.114.1589204520151;
        Mon, 11 May 2020 06:42:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y13sm9305612pfc.78.2020.05.11.06.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:41:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7423C40605; Mon, 11 May 2020 13:41:58 +0000 (UTC)
Date:   Mon, 11 May 2020 13:41:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 1/5] block: revert back to synchronous request_queue
 removal
Message-ID: <20200511134158.GM11244@42.do-not-panic.com>
References: <20200509031058.8239-1-mcgrof@kernel.org>
 <20200509031058.8239-2-mcgrof@kernel.org>
 <20200510062058.GA3394360@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510062058.GA3394360@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 08:20:58AM +0200, Greg KH wrote:
> On Sat, May 09, 2020 at 03:10:54AM +0000, Luis Chamberlain wrote:
> > Commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") merged on
> > v4.12 moved the work behind blk_release_queue() into a workqueue after a
> > splat floated around which indicated some work on blk_release_queue()
> > could sleep in blk_exit_rl(). This splat would be possible when a driver
> > called blk_put_queue() or blk_cleanup_queue() (which calls blk_put_queue()
> > as its final call) from an atomic context.
> > 
> > blk_put_queue() decrements the refcount for the request_queue kobject,
> > and upon reaching 0 blk_release_queue() is called. Although blk_exit_rl()
> > is now removed through commit db6d9952356 ("block: remove request_list code")
> > on v5.0, we reserve the right to be able to sleep within blk_release_queue()
> > context.
> > 
> > The last reference for the request_queue must not be called from atomic
> > context. *When* the last reference to the request_queue reaches 0 varies,
> > and so let's take the opportunity to document when that is expected to
> > happen and also document the context of the related calls as best as possible
> > so we can avoid future issues, and with the hopes that the synchronous
> > request_queue removal sticks.
> > 
> > We revert back to synchronous request_queue removal because asynchronous
> > removal creates a regression with expected userspace interaction with
> > several drivers. An example is when removing the loopback driver, one
> > uses ioctls from userspace to do so, but upon return and if successful,
> > one expects the device to be removed. Likewise if one races to add another
> > device the new one may not be added as it is still being removed. This was
> > expected behavior before and it now fails as the device is still present
> > and busy still. Moving to asynchronous request_queue removal could have
> > broken many scripts which relied on the removal to have been completed if
> > there was no error. Document this expectation as well so that this
> > doesn't regress userspace again.
> > 
> > Using asynchronous request_queue removal however has helped us find
> > other bugs. In the future we can test what could break with this
> > arrangement by enabling CONFIG_DEBUG_KOBJECT_RELEASE.
> 
> You are adding documenation and might_sleep() calls all over the place
> in here, making the "real" change in the patch hard to pick out.
> 
> How about you split this up into 3 patches, one for documentation, one
> for might_sleep() and one for the real change?  Or maybe just 2 patches,
> but what you have here seems excessive.

Sure.

  Luis
