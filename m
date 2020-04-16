Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6411AB555
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgDPBR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:17:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730752AbgDPBRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:17:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id z6so723382plk.10;
        Wed, 15 Apr 2020 18:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WR6dS8sppVhsHDqaOLN6r5u6vSBUIRk19qqS7mXyQHc=;
        b=TLo7dUqc8BaE8ldndA2REWP2b3LtqVk8fTTZxT0X047322Rb5bK1y2QMU3jYFbrepb
         wWukpetp7UHdwOYwXERzPs+1PKVCWvKjeXTPjvmMw1zHYFPN1AP+/QS4ozrVJh5u8UBL
         Kg9lcH3asjIb0IvK6wW6GjL77LEAwCpe7fWV50AZn0Hdb9F3mNpLXQHYTbOU7XqGDPt8
         VfuRu3SxnoX86qnJ8DIG5BSfcSWvLXSL4CuFa+2k7eUSr7rw2Enp2Asj1DGQ2PkWxe3D
         tmX9GT2dpe5FMuVFAlRVJ1P2Xkf8Bw7teex8Icc3PNafjn80ARYtN56l6zUWWuDJ8obQ
         BNkw==
X-Gm-Message-State: AGi0Puae75KNUcFiI0C2M1EYydHKh6VOU1q+IerRUR1OGB/iqVEyMRJw
        dMWa0dKo4e9cmepG00fPW5o=
X-Google-Smtp-Source: APiQypLfsZVuN4sYX8KfJSMniabfDLJgj3Rsrj4/IDbZiZZSHXaIrSBXDqfPp8TpiuntbH07OtI37g==
X-Received: by 2002:a17:90b:4c8f:: with SMTP id my15mr2146114pjb.63.1586999824688;
        Wed, 15 Apr 2020 18:17:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o11sm8556031pgd.58.2020.04.15.18.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:17:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id AEA6B40277; Thu, 16 Apr 2020 01:17:02 +0000 (UTC)
Date:   Thu, 16 Apr 2020 01:17:02 +0000
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
Message-ID: <20200416011702.GC11244@42.do-not-panic.com>
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-4-mcgrof@kernel.org>
 <20200414154044.GB25765@infradead.org>
 <20200415061649.GS11244@42.do-not-panic.com>
 <49bfcbe0-2630-5c82-f305-fcee489ac9ea@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bfcbe0-2630-5c82-f305-fcee489ac9ea@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 07:45:18AM -0700, Bart Van Assche wrote:
> On 2020-04-14 23:16, Luis Chamberlain wrote:
> > On Tue, Apr 14, 2020 at 08:40:44AM -0700, Christoph Hellwig wrote:
> >> Hmm, where exactly does the race come in so that it can only happen
> >> after where you take the reference, but not before it?  I'm probably
> >> missing something, but that just means it needs to be explained a little
> >> better :)
> > 
> >>From the trace on patch 2/5:
> > 
> >     BLKTRACE_SETUP(loop0) #2
> >     [   13.933961] == blk_trace_ioctl(2, BLKTRACESETUP) start
> >     [   13.936758] === do_blk_trace_setup(2) start
> >     [   13.938944] === do_blk_trace_setup(2) creating directory
> >     [   13.941029] === do_blk_trace_setup(2) using what debugfs_lookup() gave
> >     
> >     ---> From LOOP_CTL_DEL(loop0) #2
> >     [   13.971046] === blk_trace_cleanup(7) end
> >     [   13.973175] == __blk_trace_remove(7) end
> >     [   13.975352] == blk_trace_shutdown(7) end
> >     [   13.977415] = __blk_release_queue(7) calling blk_mq_debugfs_unregister()
> >     [   13.980645] ==== blk_mq_debugfs_unregister(7) begin
> >     [   13.980696] ==== blk_mq_debugfs_unregister(7) debugfs_remove_recursive(q->debugfs_dir)
> >     [   13.983118] ==== blk_mq_debugfs_unregister(7) end q->debugfs_dir is NULL
> >     [   13.986945] = __blk_release_queue(7) blk_mq_debugfs_unregister() end
> >     [   13.993155] = __blk_release_queue(7) end
> >     
> >     ---> From BLKTRACE_SETUP(loop0) #2
> >     [   13.995928] === do_blk_trace_setup(2) end with ret: 0
> >     [   13.997623] == blk_trace_ioctl(2, BLKTRACESETUP) end
> > 
> > The BLKTRACESETUP above works on request_queue which later
> > LOOP_CTL_DEL races on and sweeps the debugfs dir underneath us.
> > If you use this commit alone though, this doesn't fix the race issue
> > however, and that's because of both still the debugfs_lookup() use
> > and that we're still using asynchronous removal at this point.
> > 
> > refcounting will just ensure we don't take the request_queue underneath
> > our noses.
> 
> I think the above trace reveals a bug in the loop driver. The loop
> driver shouldn't allow the associated request queue to disappear while
> the loop device is open.

The bug was *not* in the driver, the bug was in that deferal of removal
was allowed to be asynchronous, therefore the removal from a userspace
perspective *finishes*, but its not actually really done. Back when
the removal was synchronous, the loop driver waited on cleanup, and
didn't return to userspace until it was really removed.

This is why I annotated that the move to asynch removal turns out to
actually be a userspace API regression.

> One may want to have a look at sd_open() in the
> sd driver. The scsi_disk_get() call in that function not only increases
> the reference count of the SCSI disk but also of the underlying SCSI device.

Are you saying to use this as a template for what a driver should do or
do you suspect there is a bug there? Not sure what you mean here.

  Luis
