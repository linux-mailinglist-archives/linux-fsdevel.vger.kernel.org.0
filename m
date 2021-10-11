Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8774298D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhJKV1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 17:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhJKV1z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:27:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89388C061570;
        Mon, 11 Oct 2021 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rvR++cOV6St/IKyuFj/V4jUUpnc9vYLPZ+efnuLPdWc=; b=25WRJtmBryphhp7aLK/UkJ4aWA
        tK73XQukZ8oxuJlQ20xqvbyZ2vAL72VzbO+/iHZ5dWu8l0Tc0dS1+X1oi6wITuyN3WczsfC/2TbAS
        8i+0OvOlvtM+vtQzQDamnzOhvw3FD2fGqvmkfMBXQz9adj5JPXbLeIv0PtKY6JIpjcR0jw/X857w3
        J7B/ZD3uRcS6NnIiRdDYtHdxi8o/MPiyFEWaeoj8iXZonj6X7sJ91q3TlaR1N3d14Se1r+cs/QHve
        soiEUlTGPsgb7VMv7J1IS6q03hcBm3HjPypLaF6BEWefYfZdAQ0+Ey1qR/nUTt1ZlL33O807I0Diy
        iYbx0SOA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma2nq-00Al54-96; Mon, 11 Oct 2021 21:25:46 +0000
Date:   Mon, 11 Oct 2021 14:25:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWSr2trabEJflzlj@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVwZwh7qDKfSM59h@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 05:24:18PM +0800, Ming Lei wrote:
> On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> > When driver sysfs attributes use a lock also used on module removal we
> > can race to deadlock. This happens when for instance a sysfs file on
> > a driver is used, then at the same time we have module removal call
> > trigger. The module removal call code holds a lock, and then the
> > driver's sysfs file entry waits for the same lock. While holding the
> > lock the module removal tries to remove the sysfs entries, but these
> > cannot be removed yet as one is waiting for a lock. This won't complete
> > as the lock is already held. Likewise module removal cannot complete,
> > and so we deadlock.
> > 
> > This can now be easily reproducible with our sysfs selftest as follows:
> > 
> > ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> > 
> > This uses a local driver lock. Test 0028 can also be used, that uses
> > the rtnl_lock():
> > 
> > ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> > 
> > To fix this we extend the struct kernfs_node with a module reference
> > and use the try_module_get() after kernfs_get_active() is called. As
> > documented in the prior patch, we now know that once kernfs_get_active()
> > is called the module is implicitly guarded to exist and cannot be removed.
> > This is because the module is the one in charge of removing the same
> > sysfs file it created, and removal of sysfs files on module exit will wait
> > until they don't have any active references. By using a try_module_get()
> > after kernfs_get_active() we yield to let module removal trump calls to
> > process a sysfs operation, while also preventing module removal if a sysfs
> > operation is in already progress. This prevents the deadlock.
> > 
> > This deadlock was first reported with the zram driver, however the live
> 
> Looks not see the lock pattern you mentioned in zram driver, can you
> share the related zram code?

I recommend to not look at the zram driver, instead look at the
test_sysfs driver as that abstracts the issue more clearly and uses
two different locks as an example. The point is that if on module
removal *any* lock is used which is *also* used on the sysfs file
created by the module, you can deadlock.

> > And this can lead to this condition:
> > 
> > CPU A                              CPU B
> >                                    foo_store()
> > foo_exit()
> >   mutex_lock(&foo)
> >                                    mutex_lock(&foo)
> >    del_gendisk(some_struct->disk);
> >      device_del()
> >        device_remove_groups()
> 
> I guess the deadlock exists if foo_exit() is called anywhere. If yes,
> look the issue may not be related with removing module directly, right?

No, the reason this can deadlock is that the module exit routine will
patiently wait for the sysfs / kernfs files to be stop being used,
but clearly they cannot if the exit routine took the mutex also used
by the sysfs ops. That is, the special condition here is the removal of
the sysfs files, and the sysfs files using a lock also used on module
exit.

 Luis
