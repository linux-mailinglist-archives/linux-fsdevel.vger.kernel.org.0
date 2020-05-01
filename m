Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31B1C1A11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEAPu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 11:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgEAPu1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 11:50:27 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F7220857;
        Fri,  1 May 2020 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588348226;
        bh=YTlbyd22lW351FilA/KSFmzAlvvZiIEuJWjP9lpav3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uGDkmD3aUzWp5s3Bk9kOjsnSUiEvL3+WOHuQ0kaySIuRgbaXzbSo0K2N2nXVJqwhV
         o68DMxq943WhesG+RmBL0x3sZFBKxUoTIkcnBII+iwzKAZlJ5CKAx0VW1is3bzPb/I
         xpTQmlNBttn7LbF1Ofa0uIBzmXYvtzUQoa+gWICU=
Received: by mail-vs1-f49.google.com with SMTP id y185so6519697vsy.8;
        Fri, 01 May 2020 08:50:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuYYjIdKvGTDTCqdaKIDFlJaA0QQ6kZWtDL3ibea7YcJnMcv1uXA
        mHDBy82Pvu6dRqAdFyLKAUH9WG2/qUzN209FW1o=
X-Google-Smtp-Source: APiQypJbOU1tzkElYzCMzOtBkc0xemlNQUEM7LIN7khWr9hk9tce6YOeVMK5Jv8FjbWgEihKivk+2XAj9/JVC79QwZA=
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr3850833vsp.198.1588348225200;
 Fri, 01 May 2020 08:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200429074627.5955-1-mcgrof@kernel.org> <20200429074627.5955-6-mcgrof@kernel.org>
 <20200429094937.GB2081185@kroah.com> <20200501150626.GM11244@42.do-not-panic.com>
 <20200501153423.GA12469@infradead.org> <20200501154050.GO11244@42.do-not-panic.com>
In-Reply-To: <20200501154050.GO11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 1 May 2020 09:50:17 -0600
X-Gmail-Original-Message-ID: <CAB=NE6WQuxFnvjiHKBY8iKYHHyyvjK-kgOh2Cm255x1vCgZ_Lg@mail.gmail.com>
Message-ID: <CAB=NE6WQuxFnvjiHKBY8iKYHHyyvjK-kgOh2Cm255x1vCgZ_Lg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
To:     Christoph Hellwig <hch@infradead.org>,
        Christof Schmitt <christof.schmitt@de.ibm.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bart Van Assche <bvanassche@acm.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, yu kuai <yukuai3@huawei.com>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 1, 2020 at 9:40 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, May 01, 2020 at 08:34:23AM -0700, Christoph Hellwig wrote:
> > On Fri, May 01, 2020 at 03:06:26PM +0000, Luis Chamberlain wrote:
> > > > You have access to a block device here, please use dev_warn() instead
> > > > here for that, that makes it obvious as to what device a "concurrent
> > > > blktrace" was attempted for.
> > >
> > > The block device may be empty, one example is for scsi-generic, but I'll
> > > use buts->name.
> >
> > Is blktrace on /dev/sg something we intentionally support, or just by
> > some accident of history?  Given all the pains it causes I'd be tempted
> > to just remove the support and see if anyone screams.
>
> From what I can tell I think it was a historic and brutal mistake. I am
> more than happy to remove it.

I take that back:

commit 6da127ad0918f93ea93678dad62ce15ffed18797
Author: Christof Schmitt <christof.schmitt@de.ibm.com>
Date:   Fri Jan 11 10:09:43 2008 +0100

    blktrace: Add blktrace ioctls to SCSI generic devices

    Since the SCSI layer uses the request queues from the block layer,
blktrace can
    also be used to trace the requests to all SCSI devices (like SCSI
tape drives),
    not only disks. The only missing part is the ioctl interface to
start and stop
    tracing.

    This patch adds the SETUP, START, STOP and TEARDOWN ioctls from
blktrace to the
    sg device files. With this change, blktrace can be used for SCSI
devices like
    for disks, e.g.: blktrace -d /dev/sg1 -o - | blkparse -i -

    Signed-off-by: Christof Schmitt <christof.schmitt@de.ibm.com>
    Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Christof, any thoughts on removing this support?

 Luis
