Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EE2430263
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Oct 2021 13:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbhJPLbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Oct 2021 07:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhJPLbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Oct 2021 07:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634383742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FpnA9lYWxkJjvg75Ewu7vyuMBg8oJ+36xZYExlcfae0=;
        b=CS+o08AQeAcY9csjeNTtJTSz/HCY6py97u2n6QJQcHZL/2Vx0mbZZJ1ttBwqJQ+SO7mhVD
        w2l+/Wpb7D6wcYUKTp3upUttkvrTOPK1rpnvb0oAP4nOfCr82HZTrrZo6lbRu0FDZHGv/1
        N+DBDsdkg92sTnb3XtWLMlRKbjFXJBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-AX-aE8PPOTGtJ1ZuG3mfog-1; Sat, 16 Oct 2021 07:29:00 -0400
X-MC-Unique: AX-aE8PPOTGtJ1ZuG3mfog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91F0010A8E00;
        Sat, 16 Oct 2021 11:28:57 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C8695DA61;
        Sat, 16 Oct 2021 11:28:44 +0000 (UTC)
Date:   Sat, 16 Oct 2021 19:28:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWq3Z++uoJ/kcp+3@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWm68xUnAofop3PZ@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:31:31AM -0700, Luis Chamberlain wrote:
> On Fri, Oct 15, 2021 at 04:36:11PM +0800, Ming Lei wrote:
> > On Thu, Oct 14, 2021 at 05:22:40PM -0700, Luis Chamberlain wrote:
> > > On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> > ...
> > > > 
> > > > We need to understand the exact reason why there is still cpuhp node
> > > > left, can you share us the exact steps for reproducing the issue?
> > > > Otherwise we may have to trace and narrow down the reason.
> > > 
> > > See my commit log for my own fix for this issue.
> > 
> > OK, thanks!
> > 
> > I can reproduce the issue, and the reason is that reset_store fails
> > zram_remove() when unloading module, then the warning is caused.
> > 
> > The top 3 patches in the following tree can fix the issue:
> > 
> > https://github.com/ming1/linux/commits/my_v5.15-blk-dev
> 
> Thanks for trying an alternative fix! A crash stops yes, however this

I doubt it is alternative since your patchset doesn't mention the exact
reason of 'Error: Removing state 63 which has instances left.', that is
simply caused by failing to remove zram because ->claim is set during
unloading module.

Yeah, you mentioned the race between disksize_store() vs. zram_remove(),
however I don't think it is reproduced easily in the test because the race
window is pretty small, also it can be fixed easily in my 3rd path
without any complicated tricks.

Not dig into details of your patchset via grabbing module reference
count during show/store attribute of kernfs which is done in your patch
9, but IMO this way isn't necessary:

1) any driver module has to cleanup anything which may refer to symbols
or data defined in module_exit of this driver

2) device_del() is often done in module_exit(), once device_del()
returns, no any new show/store on the device's kobject attribute
is possible.

3) it is _not_ a must or pattern for fixing bugs to hold one lock before
calling device_del(), meantime the lock is required in the device's
attribute show()/store(), which causes AA deadlock easily. Your approach
just avoids the issue by not releasing module until all show/store are
done.

Also the model of using module refcount is usually that if anyone will
use the module, grab one extra ref, and once the use is done, release
it. For example of block device, the driver's module refcnt is grabbed
when the disk/part is opened, and released when the disk/part is closed.


> also ends up leaving the driver in an unrecoverable state after a few
> tries. Ie, you CTRL-C the scripts and try again over and over again and
> the driver ends up in a situation where it just says:
> 
> zram: Can't change algorithm for initialized device

It means the algorithm can't be changed for one initialized device
at the exact time. That is understandable because two zram02.sh are
running concurrently.

Your test script just runs two ./zram02.sh tasks concurrently forever,
so what is your expected result for the test? Of course, it can't be
over.

I can't reproduce the 'unrecoverable' state in my test, can you share the
stack trace log after that happens?

Is the zram02.sh still running or slept somewhere in the 'unrecoverable'
state? If it is still running, it means the current sleep point isn't
interruptable when running 'CTRL-C'. In my test, after several 'CTRL-C',
both the two zram02.sh started from two terminals can be terminated. If
it is slept somewhere forever, it can be one problem.

> 
> And the zram module can't be removed at that point.

It is just that systemd opens the zram or the disk is opened as swap
disk, and once systemd closes it or after you run swapoff, it can be
unloaded.


Thanks,
Ming

