Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84CE42C469
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbhJMPGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 11:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237071AbhJMPGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634137480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d+mcxn9Yq7uI+Viy+K4BQvLPxElVK5331udxqYrTR1s=;
        b=czVfnmG1Fgv3twWElMZJVffzr9QomQc1SaSZ3Emy8QrPVWww0HcaI30uBdMcRW7PN3nxua
        J/ImaGpAsFtfcBnej8gd2ZwTocb6UelhJFKkcdT028u/zII6NOq3l6GkOQzHHxTkDAAfsK
        d8qW8u/G0npUaJmh37M+kTTFA6bbM1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-yR6kJGqXNkKhVj3G7P5dzg-1; Wed, 13 Oct 2021 11:04:34 -0400
X-MC-Unique: yR6kJGqXNkKhVj3G7P5dzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EDE0802CB8;
        Wed, 13 Oct 2021 15:04:31 +0000 (UTC)
Received: from T590 (ovpn-8-39.pek2.redhat.com [10.72.8.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AAC357CB9;
        Wed, 13 Oct 2021 15:04:12 +0000 (UTC)
Date:   Wed, 13 Oct 2021 23:04:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWb1Z7EXruo6gaEp@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
 <YWSr2trabEJflzlj@bombadil.infradead.org>
 <YWTU3kTlJKONyFjZ@T590>
 <YWX7pAn0YMaJeJBA@bombadil.infradead.org>
 <YWYxN875B6rlmAjC@T590>
 <YWbSk6p3bfXUPZ92@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbSk6p3bfXUPZ92@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:35:31AM -0700, Luis Chamberlain wrote:
> On Wed, Oct 13, 2021 at 09:07:03AM +0800, Ming Lei wrote:
> > On Tue, Oct 12, 2021 at 02:18:28PM -0700, Luis Chamberlain wrote:
> > > > Looks test_sysfs isn't in linus tree, where can I find it?
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-sysfs-generic-deadlock-fix
> > > 
> > > To reproduce the deadlock revert the patch in this thread and then run
> > > either of these two tests as root:
> > > 
> > > ./tools/testing/selftests/sysfs/sysfs.sh -w 0027
> > > ./tools/testing/selftests/sysfs/sysfs.sh -w 0028
> > > 
> > > You will need to enable the test_sysfs driver.
> > > > Can you share the code which waits for the sysfs / kernfs files to be
> > > > stop being used?
> > > 
> > > How about a call trace of the two tasks which deadlock, here is one of
> > > running test 0027:
> > > 
> > > kdevops login: [  363.875459] INFO: task sysfs.sh:1271 blocked for more
> > > than 120 seconds.
> 
> <-- snip -->
> 
> > That doesn't show the deadlock is related with module_exit().
> 
> Not directly no.

Then the patch title of 'sysfs: fix deadlock race with module removal'
is wrong.

> 
> > It is clearly one AA deadlock, what I meant was that it isn't related with
> > module exit cause lock & device_del() isn't always done in module exit, so
> > I doubt your fix with grabbing module refcnt is good or generic enough.
> 
> A device_del() *can* happen in other areas other than module exit sure,
> but the issue is if a shared lock is used *before* device_del() and also
> used on a sysfs op. Typically this can happen on module exit, and the
> other common use case in my experience is on sysfs ops, such is the case
> with the zram driver. Both cases are covered then by this fix.

Again, can you share the related zram code about the issue? In
zram_drv.c of linus or next tree, I don't see any lock is held before
calling del_gendisk().

> 
> If there are other areas, that is still driver specific, but of the
> things we *can* generalize, definitely module exit is a common path.
> 
> > Except for your cooked test_sys module, how many real drivers do suffer the
> > problem? What are they?
> 
> I only really seriously considered trying to generalize this after it

IMO your generalization isn't good or correct because this kind of issue
is _not_ related with module exit at all. What matters is just that one lock is
held before calling device_del(), meantime the same lock is required
in the device's attribute show/store function().

There are many cases in which we call device_del() not from module_exit(),
such as scsi scan, scsi sysfs store(), or even handling event from
device side, nvme error handling, usb hotplug, ...

> was hinted to me live patching was also affected, and so clearly
> something generic was desirable.

It might be just the only two drivers(zram and live patch) with this bug, and
it is one simply AA bug in driver. Not mention I don't see such usage in
zram_drv.c.

> 
> There may be other drivers for sure, but a hunt for that with semantics
> would require a bit complex coccinelle patch with iteration support.
> 
> > Why can't we fix the exact driver?
> 
> You can try, the way the lock is used in zram is correct, specially

What is the lock in zram? Again can you share the related functions?

> after my other fix in this series which addresses another unrelated bug
> with cpu hotplug multistate support. So we then can proceed to either
> take the position to say: "Thou shalt not use a shared lock on module
> exit and a sysfs op" and try to fix all places, or we generalize a fix
> for this. A generic fix seems more desirable.

What matters is that the lock is held before calling device_del()
instead of being held in module_exit().



Thanks,
Ming

