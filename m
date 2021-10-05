Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6715542223D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhJEJ0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 05:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233513AbhJEJ0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633425879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyGWEhpdvwHRCn/lr1t/kNe6MHkOq9fXmq3K7gAa+cc=;
        b=RD2GftGyfyrVrqjB0yAUet2wrjKOU9CTSPZ76kmGPW9dyAfqEDyS/5d4nqAQ2WAcWIHeA/
        QyMwUo3a1/GhMPHkJAjz4WMyE9g0zkcLUPRXUXxI/22cZThD2i4+/dgrqmq/PgM8SkcYzO
        GenOJcQ32mVQoL0GnyJ+ABuvOFBT84s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-YETLEAj_PmuF1NvZWR3dfQ-1; Tue, 05 Oct 2021 05:24:35 -0400
X-MC-Unique: YETLEAj_PmuF1NvZWR3dfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A2C610151E1;
        Tue,  5 Oct 2021 09:24:33 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0F385F4EA;
        Tue,  5 Oct 2021 09:24:23 +0000 (UTC)
Date:   Tue, 5 Oct 2021 17:24:18 +0800
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
Message-ID: <YVwZwh7qDKfSM59h@T590>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-10-mcgrof@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:38:02AM -0700, Luis Chamberlain wrote:
> When driver sysfs attributes use a lock also used on module removal we
> can race to deadlock. This happens when for instance a sysfs file on
> a driver is used, then at the same time we have module removal call
> trigger. The module removal call code holds a lock, and then the
> driver's sysfs file entry waits for the same lock. While holding the
> lock the module removal tries to remove the sysfs entries, but these
> cannot be removed yet as one is waiting for a lock. This won't complete
> as the lock is already held. Likewise module removal cannot complete,
> and so we deadlock.
> 
> This can now be easily reproducible with our sysfs selftest as follows:
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
> 
> This uses a local driver lock. Test 0028 can also be used, that uses
> the rtnl_lock():
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0028
> 
> To fix this we extend the struct kernfs_node with a module reference
> and use the try_module_get() after kernfs_get_active() is called. As
> documented in the prior patch, we now know that once kernfs_get_active()
> is called the module is implicitly guarded to exist and cannot be removed.
> This is because the module is the one in charge of removing the same
> sysfs file it created, and removal of sysfs files on module exit will wait
> until they don't have any active references. By using a try_module_get()
> after kernfs_get_active() we yield to let module removal trump calls to
> process a sysfs operation, while also preventing module removal if a sysfs
> operation is in already progress. This prevents the deadlock.
> 
> This deadlock was first reported with the zram driver, however the live

Looks not see the lock pattern you mentioned in zram driver, can you
share the related zram code?

> patching folks have acknowledged they have observed this as well with
> live patching, when a live patch is removed. I was then able to
> reproduce easily by creating a dedicated selftest for it.
> 
> A sketch of how this can happen follows, consider foo a local mutex
> part of a driver, and used on the driver's module exit routine and
> on one of its sysfs ops:
> 
> foo.c:
> static DEFINE_MUTEX(foo);
> static ssize_t foo_store(struct device *dev,
> 			 struct device_attribute *attr,
> 			 const char *buf, size_t count)
> {
> 	...
> 	mutex_lock(&foo);
> 	...
> 	mutex_lock(&foo);
> 	...
> }
> static DEVICE_ATTR_RW(foo);
> ...
> void foo_exit(void)
> {
> 	mutex_lock(&foo);
> 	...
> 	mutex_unlock(&foo);
> }
> module_exit(foo_exit);
> 
> And this can lead to this condition:
> 
> CPU A                              CPU B
>                                    foo_store()
> foo_exit()
>   mutex_lock(&foo)
>                                    mutex_lock(&foo)
>    del_gendisk(some_struct->disk);
>      device_del()
>        device_remove_groups()

I guess the deadlock exists if foo_exit() is called anywhere. If yes,
look the issue may not be related with removing module directly, right?



Thanks,
Ming

