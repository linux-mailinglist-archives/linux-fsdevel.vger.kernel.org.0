Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F83F42984E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 22:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbhJKUq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 16:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhJKUq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:46:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0795C061570;
        Mon, 11 Oct 2021 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ktQ3PVVcg2TTN+o+OAXoDDmRIIVVJexPj9+ndnqpzu8=; b=D2ghYpL2Ow+Sn1V1Fe+THQzT1h
        vkRE1iM8Meq1G8vSFDmf8zU2Zido3E10mAUlTkcrP7jYr8oeUjCit5bTEYa+0PD8snuo2ATINasgy
        mrCxmPuAwySK4hhqL5ow8U/55frzluZDop3NxiyN72+Q8icTVBD5yYvHOQs4pBzLZ4NBAgLxKl/ln
        ywN/ktVvJiJ8SDLCRVUjP/cuyVppHbzsxFdmBnMk2eNc0EQrm+ATv9sCLqYT0Yca8IYz2rwoCbXa3
        OEAUBunYRoyH6+DWLgSm+gLbU3Dh3LSVau2o8GnVc5c6Ttyy3kt2K3ZSDiks3zyteAxeHoIZTAK9J
        WWhfYQJg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ma29j-00AdGr-82; Mon, 11 Oct 2021 20:44:19 +0000
Date:   Mon, 11 Oct 2021 13:44:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 04/12] kernfs: add initial failure injection support
Message-ID: <YWSiIwr/8/JQE9qW@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-5-mcgrof@kernel.org>
 <202110051225.419CD64@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110051225.419CD64@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:47:22PM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 09:37:57AM -0700, Luis Chamberlain wrote:
> > This adds initial failure injection support to kernfs. We start
> > off with debug knobs which when enabled allow test drivers, such as
> > test_sysfs, to then make use of these to try to force certain
> > difficult races to take place with a high degree of certainty.
> > 
> > This only adds runtime code *iff* the new bool CONFIG_FAIL_KERNFS_KNOBS is
> > enabled in your kernel. If you don't have this enabled this provides
> > no new functional. When CONFIG_FAIL_KERNFS_KNOBS is disabled the new
> > routine kernfs_debug_should_wait() ends up being transformed to if
> > (false), and so the compiler should optimize these out as dead code
> > producing no new effective binary changes.
> > 
> > We start off with enabling failure injections in kernfs by allowing us to
> > alter the way kernfs_fop_write_iter() behaves. We allow for the routine
> > kernfs_fop_write_iter() to wait for a certain condition in the kernel to
> > occur, after which it will sleep a predefined amount of time. This lets
> > kernfs users to time exactly when it want kernfs_fop_write_iter() to
> > complete, allowing for developing race conditions and test for correctness
> > in kernfs.
> > 
> > You'd boot with this enabled on your kernel command line:
> > 
> > fail_kernfs_fop_write_iter=1,100,0,1
> > 
> > The values are <interval,probability,size,times>, we don't care for
> > size, so for now we ignore it. The above ensures a failure will trigger
> > only once.
> > 
> > *How* we allow for this routine to change behaviour is left to knobs we
> > expose under debugfs:
> > 
> >  # ls -1 /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/
> 
> I'd expect this to live under /sys/kernel/debug/fail_kernfs, like the
> other fault injectors.

Yes I see, thanks will fix up!

> > diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
> > index 4a25c5eb6f07..d4d34b082f47 100644
> > --- a/Documentation/fault-injection/fault-injection.rst
> > +++ b/Documentation/fault-injection/fault-injection.rst
> > @@ -28,6 +28,28 @@ Available fault injection capabilities
> >  
> >    injects kernel RPC client and server failures.
> >  
> > +- fail_kernfs_fop_write_iter
> > +
> > +  Allows for failures to be enabled inside kernfs_fop_write_iter(). Enabling
> > +  this does not immediately enable any errors to occur. You must configure
> > +  how you want this routine to fail or change behaviour by using the debugfs
> > +  knobs for it:
> > +
> > +  # ls -1 /sys/kernel/debug/kernfs/config_fail_kernfs_fop_write_iter/
> > +  wait_after_active
> > +  wait_after_mutex
> > +  wait_at_start
> > +  wait_before_mutex
> 
> This should be split up and detailed in the "debugfs entries" section
> below here.

Done!

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1b4cefcb064c..fadfd961ad80 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10384,7 +10384,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >  M:	Tejun Heo <tj@kernel.org>
> >  S:	Supported
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> > -F:	fs/kernfs/
> > +F:	fs/kernfs/*
> >  F:	include/linux/kernfs.h
> >  
> >  KEXEC
> > diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
> > index 4ca54ff54c98..bc5b32ca39f9 100644
> > --- a/fs/kernfs/Makefile
> > +++ b/fs/kernfs/Makefile
> > @@ -4,3 +4,4 @@
> >  #
> >  
> >  obj-y		:= mount.o inode.o dir.o file.o symlink.o
> > +obj-$(CONFIG_FAIL_KERNFS_KNOBS)    += failure-injection.o
> > diff --git a/fs/kernfs/failure-injection.c b/fs/kernfs/failure-injection.c
> > new file mode 100644
> > index 000000000000..4130d202c13b
> > --- /dev/null
> > +++ b/fs/kernfs/failure-injection.c
> 
> I'd name this fault_inject.c, which matches the more common case:
> 
> $ find . -type f -name '*fault*inject*.c'
> ./fs/nfsd/fault_inject.c
> ./drivers/nvme/host/fault_inject.c
> ./drivers/scsi/ufs/ufs-fault-injection.c
> ./lib/fault-inject.c
> ./lib/fault-inject-usercopy.c

Sure, done.

> > +int __kernfs_debug_should_wait_kernfs_fop_write_iter(bool evaluate)
> > +{
> > +	if (!evaluate)
> > +		return 0;
> > +
> > +	return should_fail(&fail_kernfs_fop_write_iter, 0);
> > +}
> 
> Every caller ends up doing the wait, so how about just including that
> here instead? It should make things much less intrusive and more readable.
> 
> And for the naming, other fault injectors use "should_fail_$topic", so
> maybe better here would be something like may_wait_kernfs(...).

In case anyone is reading Hail Mary by Andy Weir: "Yes yes yes!"

Indeed, that's a great idea. Changed!

> > +
> > +DECLARE_COMPLETION(kernfs_debug_wait_completion);
> > +EXPORT_SYMBOL_NS_GPL(kernfs_debug_wait_completion, KERNFS_DEBUG_PRIVATE);
> > +
> > +void kernfs_debug_wait(void)
> > +{
> > +	unsigned long timeout;
> > +
> > +	timeout = wait_for_completion_timeout(&kernfs_debug_wait_completion,
> > +					      msecs_to_jiffies(3000));
> > +	if (!timeout)
> > +		pr_info("%s waiting for kernfs_debug_wait_completion timed out\n",
> > +			__func__);
> > +	else
> > +		pr_info("%s received completion with time left on timeout %u ms\n",
> > +			__func__, jiffies_to_msecs(timeout));
> > +
> > +	/**
> > +	 * The goal is wait for an event, and *then* once we have
> > +	 * reached it, the other side will try to do something which
> > +	 * it thinks will break. So we must give it some time to do
> > +	 * that. The amount of time is configurable.
> > +	 */
> > +	msleep(kernfs_config_fail.sleep_after_wait_ms);
> > +	pr_info("%s ended\n", __func__);
> > +}
> 
> All the uses of "__func__" here seems redundant; I would drop them.

Alright, and I also added the pr_fmt define which I forgot.

> > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > index 60e2a86c535e..4479c6580333 100644
> > --- a/fs/kernfs/file.c
> > +++ b/fs/kernfs/file.c
> > @@ -259,6 +259,9 @@ static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> >  	const struct kernfs_ops *ops;
> >  	char *buf;
> >  
> > +	if (kernfs_debug_should_wait(kernfs_fop_write_iter, at_start))
> > +		kernfs_debug_wait();
> 
> So this could just be:
> 
> 	may_wait_kernfs(kernfs_fop_write_iter, at_start);

Yup! Thanks!

> > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> > index f9cc912c31e1..9e3abf597e2d 100644
> > --- a/fs/kernfs/kernfs-internal.h
> > +++ b/fs/kernfs/kernfs-internal.h
> > +#define __kernfs_config_wait_var(func, when) \
> > +	(kernfs_config_fail.  func  ## _fail.wait_  ## when)
>                             ^^     ^               ^
> nit: needless spaces

Trimmed.

  Luis
