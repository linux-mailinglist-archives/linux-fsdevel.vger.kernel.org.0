Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B15A1A399E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDISLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:11:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40473 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDISLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:11:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so4099495plk.7;
        Thu, 09 Apr 2020 11:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+u9wu3D+1SAT+AyByv6VWCl1y8XJyfZjKsIoztZ2sLk=;
        b=uBbHcBc4eqQ3MoO6nRN5kfqc1RT/wk6gAngm1is9dhITwi3l1GkR0PoM17F4Exs3jO
         L1SQGxdjVuCZbpRyZRiaC1fwRTbtCEh56inWC/rq8q7AWygbVnwUQJGvoR6KJ9An541p
         lb21VxlEB6YoJGZgFCpawLgVDXCJII47ixBTERoFFeGCbsGKULhtV/5PpVc1ALgrEHPA
         myqVWOZUx811xHROrzxefSv9v4PPUrkxNIVO50Q5uFtpogkW6cVy0OCx3QCL6l8x68jK
         KC/pNU4tJ8M7vKmaoJGwpogVvH0nEICz2sGzgb2u2NeqQBuL72NQTZRNf8v/fOIJRkDX
         QC/A==
X-Gm-Message-State: AGi0PubUeKDLSxT5+2DAS/09bU2IvO9pTiDKlc3HGcCqfBEKrq4d2oj9
        vcF3diZpKkT6y9daUzs0nos=
X-Google-Smtp-Source: APiQypIEjb7k0vg1mEoUtBe15H1kcK7BSjonLF/QsYErQW99NzcpWLX1DshA4rkPF6yQ2OehZFCT2Q==
X-Received: by 2002:a17:90b:4d04:: with SMTP id mw4mr791725pjb.180.1586455873370;
        Thu, 09 Apr 2020 11:11:13 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r4sm6458344pgi.6.2020.04.09.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 11:11:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8790440246; Thu,  9 Apr 2020 18:11:11 +0000 (UTC)
Date:   Thu, 9 Apr 2020 18:11:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, mhocko@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC 3/3] block: avoid deferral of blk_release_queue() work
Message-ID: <20200409181111.GJ11244@42.do-not-panic.com>
References: <20200402000002.7442-1-mcgrof@kernel.org>
 <20200402000002.7442-4-mcgrof@kernel.org>
 <774a33e8-43ba-143f-f6fd-9cb0ae0862ac@acm.org>
 <87o8saj62m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8saj62m.fsf@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:49:37PM +0200, Nicolai Stange wrote:
> Bart Van Assche <bvanassche@acm.org> writes:
> 
> > On 2020-04-01 17:00, Luis Chamberlain wrote:
> > The description of this patch mentions a single blk_release_queue() call
> > that happened in the past from a context from which sleeping is not
> > allowed and from which sleeping is allowed today. Have all other
> > blk_release_queue() / blk_put_queue() calls been verified to see whether
> > none of these happens from a context from which sleeping is not allowed?
> 
> I've just done this today and found the following potentially
> problematic call paths to blk_put_queue().
> 
> 1.) mem_cgroup_throttle_swaprate() takes a spinlock and
>     calls blkcg_schedule_throttle()->blk_put_queue().
> 
>     Also note that AFAICS mem_cgroup_try_charge_delay() can be called
>     with GFP_ATOMIC.

I have a solution to this which would avoid having to deal with the
concern completely. I'll post in my follow up.

> 2.) scsi_unblock_requests() gets called from a lot of drivers and
>     invoke blk_put_queue() through
>     scsi_unblock_requests() -> scsi_run_host_queues() ->
>     scsi_starved_list_run() -> blk_put_queue().

sd_probe() calls device_add_disk(), and the scsi lib also has its
own refcounting for scsi, but unless you call sd_remove() you'll be
protecting the underlying block disk and request_queue, as sd_remove()
calls the del_gendisk() which would in call call blk_unregister_queue()
which calls the last blk_put_queue(). If sd_remove() can be called from
atomic context we can also fix this, and this should be evident how in
my next follow up series of patches.

  Luis
