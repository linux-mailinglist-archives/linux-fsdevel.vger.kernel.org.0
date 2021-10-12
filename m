Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36949429A5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 02:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhJLAXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 20:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233508AbhJLAXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 20:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633998072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpsLnH9NGEB0jCvrlBpGabDndtUY8/3VwXWgLo0MtD0=;
        b=Wnty/c4j6ru04ZU7uZapG2s5KXuOI5UpNixETCHbp2PmViHoffTOpTi8lDp6A43MuVQqlW
        NMJSItm8jRdhjn4if1wBPxLVGUFr8fj0Kei5CrLhTHzp1CG8L4AGT0eB/apDDvdAm0YW/v
        ibgMWxmpuNnBGpTj8nBu6WJ9ADoAqW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-00PJPiFrMTyzNCMr5bA9IA-1; Mon, 11 Oct 2021 20:21:08 -0400
X-MC-Unique: 00PJPiFrMTyzNCMr5bA9IA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2DF657;
        Tue, 12 Oct 2021 00:21:04 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 496F757CA1;
        Tue, 12 Oct 2021 00:20:51 +0000 (UTC)
Date:   Tue, 12 Oct 2021 08:20:46 +0800
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
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWTU3kTlJKONyFjZ@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
 <YWSr2trabEJflzlj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWSr2trabEJflzlj@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 02:25:46PM -0700, Luis Chamberlain wrote:
> On Tue, Oct 05, 2021 at 05:24:18PM +0800, Ming Lei wrote:
> > On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> > > When driver sysfs attributes use a lock also used on module removal we
> > > can race to deadlock. This happens when for instance a sysfs file on
> > > a driver is used, then at the same time we have module removal call
> > > trigger. The module removal call code holds a lock, and then the
> > > driver's sysfs file entry waits for the same lock. While holding the
> > > lock the module removal tries to remove the sysfs entries, but these
> > > cannot be removed yet as one is waiting for a lock. This won't complete
> > > as the lock is already held. Likewise module removal cannot complete,
> > > and so we deadlock.
> > > 
> > > This can now be easily reproducible with our sysfs selftest as follows:
> > > 
> > > ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> > > 
> > > This uses a local driver lock. Test 0028 can also be used, that uses
> > > the rtnl_lock():
> > > 
> > > ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> > > 
> > > To fix this we extend the struct kernfs_node with a module reference
> > > and use the try_module_get() after kernfs_get_active() is called. As
> > > documented in the prior patch, we now know that once kernfs_get_active()
> > > is called the module is implicitly guarded to exist and cannot be removed.
> > > This is because the module is the one in charge of removing the same
> > > sysfs file it created, and removal of sysfs files on module exit will wait
> > > until they don't have any active references. By using a try_module_get()
> > > after kernfs_get_active() we yield to let module removal trump calls to
> > > process a sysfs operation, while also preventing module removal if a sysfs
> > > operation is in already progress. This prevents the deadlock.
> > > 
> > > This deadlock was first reported with the zram driver, however the live
> > 
> > Looks not see the lock pattern you mentioned in zram driver, can you
> > share the related zram code?
> 
> I recommend to not look at the zram driver, instead look at the
> test_sysfs driver as that abstracts the issue more clearly and uses

Looks test_sysfs isn't in linus tree, where can I find it? Also please
update your commit log about this wrong info if it can't be applied on
zram.

> two different locks as an example. The point is that if on module
> removal *any* lock is used which is *also* used on the sysfs file
> created by the module, you can deadlock.
> 
> > > And this can lead to this condition:
> > > 
> > > CPU A                              CPU B
> > >                                    foo_store()
> > > foo_exit()
> > >   mutex_lock(&foo)
> > >                                    mutex_lock(&foo)
> > >    del_gendisk(some_struct->disk);
> > >      device_del()
> > >        device_remove_groups()
> > 
> > I guess the deadlock exists if foo_exit() is called anywhere. If yes,
> > look the issue may not be related with removing module directly, right?
> 
> No, the reason this can deadlock is that the module exit routine will
> patiently wait for the sysfs / kernfs files to be stop being used,

Can you share the code which waits for the sysfs / kernfs files to be
stop being used? And why does it make a difference in case of being
called from module_exit()?



Thanks,
Ming

