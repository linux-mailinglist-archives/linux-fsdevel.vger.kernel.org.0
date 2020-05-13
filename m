Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086581D1AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbgEMQHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:07:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47451 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729589AbgEMQHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589386057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//iylwP5dC0vk5Lio2BTXjJhEZdilrXVVxZISleOyPQ=;
        b=H3TA6ZWtTypYbpYGFYGrbXzde0ZSywyYWkyYspQ9Xerjc55FPsShwZx/hW0NSHnAYT6njz
        chSDtdKYWZhzgar0gScQte3IR7i1oD9lIznrlbzLy525JgmxdrQ6kJKa+lhbR0Qg/U50JN
        IEkD6oqx0/pKqd1Ym/hsbeXFssM1mKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-z6VaKZCgPietU82rN9nuZg-1; Wed, 13 May 2020 12:07:32 -0400
X-MC-Unique: z6VaKZCgPietU82rN9nuZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC5A1054F90;
        Wed, 13 May 2020 16:07:29 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B98AF26DE7;
        Wed, 13 May 2020 16:07:17 +0000 (UTC)
Date:   Wed, 13 May 2020 12:07:14 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v4] kernel: add panic_on_taint
Message-ID: <20200513160714.GM367616@optiplex-lnx>
References: <20200513150026.1039987-1-aquini@redhat.com>
 <20200513154722.GR11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513154722.GR11244@42.do-not-panic.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 03:47:22PM +0000, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 11:00:26AM -0400, Rafael Aquini wrote:
> > Analogously to the introduction of panic_on_warn, this patch
> > introduces a kernel option named panic_on_taint in order to
> > provide a simple and generic way to stop execution and catch
> > a coredump when the kernel gets tainted by any given taint flag.
> > 
> > This is useful for debugging sessions as it avoids rebuilding
> > the kernel to explicitly add calls to panic() or BUG() into
> > code sites that introduce the taint flags of interest.
> > For instance, if one is interested in following up with
> > a post mortem analysis at the point a code path is hitting
> > a bad page (i.e. unaccount_page_cache_page(), or slab_bug()),
> > a crashdump could be collected by rebooting the kernel with
> > 'panic_on_taint=0x20' amended to the command line string.
> > 
> > Another, perhaps less frequent, use for this option would be
> > as a mean for assuring a security policy case where only a
> > subset of taints, or no single taint (in paranoid mode),
> > is allowed for the running system.
> > The optional switch 'nousertaint' is handy in this particular
> > scenario as it will avoid userspace induced crashes by writes
> > to /proc/sys/kernel/tainted causing false positive hits for
> > such policies.
> > 
> > Suggested-by: Qian Cai <cai@lca.pw>
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> > Changelog:
> > * v2: get rid of unnecessary/misguided compiler hints		(Luis)
> >       enhance documentation text for the new kernel parameter	(Randy)
> > * v3: drop sysctl interface, keep it only as a kernel parameter (Luis)
> > * v4: change panic_on_taint input from alphabetical taint flags
> >       to hexadecimal bitmasks, for clarity and extendability	(Luis)
> > 
> >  Documentation/admin-guide/kdump/kdump.rst     |  7 ++++
> >  .../admin-guide/kernel-parameters.txt         | 13 +++++++
> >  include/linux/kernel.h                        |  4 +++
> >  kernel/panic.c                                | 34 +++++++++++++++++++
> >  kernel/sysctl.c                               | 11 +++++-
> >  5 files changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> > index ac7e131d2935..2707de840fd3 100644
> > --- a/Documentation/admin-guide/kdump/kdump.rst
> > +++ b/Documentation/admin-guide/kdump/kdump.rst
> > @@ -521,6 +521,13 @@ will cause a kdump to occur at the panic() call.  In cases where a user wants
> >  to specify this during runtime, /proc/sys/kernel/panic_on_warn can be set to 1
> >  to achieve the same behaviour.
> >  
> > +Trigger Kdump on add_taint()
> > +============================
> > +
> > +The kernel parameter panic_on_taint facilitates calling panic() from within
> > +add_taint() whenever the value set in this bitmask matches with the bit flag
> > +being set by add_taint(). This will cause a kdump to occur at the panic() call.
> > +
> >  Contact
> >  =======
> >  
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7bc83f3d9bdf..ce17fdbec7d1 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3401,6 +3401,19 @@
> >  			bit 4: print ftrace buffer
> >  			bit 5: print all printk messages in buffer
> >  
> > +	panic_on_taint=	Bitmask for conditionally call panic() in add_taint()
> > +			Format: <hex>[,nousertaint]
> > +			Hexadecimal bitmask representing the set of TAINT flags
> > +			that will cause the kernel to panic when add_taint() is
> > +			called with any of the flags in this set.
> > +			The optional switch "nousertaint" can be utilized to
> > +			prevent userland forced crashes by writing to sysctl
> > +			/proc/sys/kernel/tainted any flagset matching with the
> > +			bitmask set on panic_on_taint.
> > +			See Documentation/admin-guide/tainted-kernels.rst for
> > +			extra details on the taint flags that users can pick
> > +			to compose the bitmask to assign to panic_on_taint.
> > +
> >  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> >  			on a WARN().
> >  
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 9b7a8d74a9d6..70712944dffc 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -528,6 +528,8 @@ extern int panic_on_oops;
> >  extern int panic_on_unrecovered_nmi;
> >  extern int panic_on_io_nmi;
> >  extern int panic_on_warn;
> > +extern unsigned long panic_on_taint;
> > +extern bool panic_on_taint_nousertaint;
> >  extern int sysctl_panic_on_rcu_stall;
> >  extern int sysctl_panic_on_stackoverflow;
> >  
> > @@ -597,6 +599,8 @@ extern enum system_states {
> >  #define TAINT_RANDSTRUCT		17
> >  #define TAINT_FLAGS_COUNT		18
> >  
> > +#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> > +
> >  struct taint_flag {
> >  	char c_true;	/* character printed when tainted */
> >  	char c_false;	/* character printed when not tainted */
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index b69ee9e76cb2..94b5c973770c 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -44,6 +44,8 @@ static int pause_on_oops_flag;
> >  static DEFINE_SPINLOCK(pause_on_oops_lock);
> >  bool crash_kexec_post_notifiers;
> >  int panic_on_warn __read_mostly;
> > +unsigned long panic_on_taint;
> > +bool panic_on_taint_nousertaint = false;
> >  
> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
> >  EXPORT_SYMBOL_GPL(panic_timeout);
> > @@ -434,6 +436,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
> >  		pr_warn("Disabling lock debugging due to kernel taint\n");
> >  
> >  	set_bit(flag, &tainted_mask);
> > +
> > +	if (tainted_mask & panic_on_taint) {
> > +		panic_on_taint = 0;
> > +		panic("panic_on_taint set ...");
> > +	}
> >  }
> >  EXPORT_SYMBOL(add_taint);
> >  
> > @@ -686,3 +693,30 @@ static int __init oops_setup(char *s)
> >  	return 0;
> >  }
> >  early_param("oops", oops_setup);
> > +
> > +static int __init panic_on_taint_setup(char *s)
> > +{
> > +	char *taint_str;
> > +
> > +	if (!s)
> > +		return -EINVAL;
> > +
> > +	taint_str = strsep(&s, ",");
> > +	if (kstrtoul(taint_str, 16, &panic_on_taint))
> > +		return -EINVAL;
> > +
> > +	/* make sure panic_on_taint doesn't hold out-of-range TAINT flags */
> > +	panic_on_taint &= TAINT_FLAGS_MAX;
> 
> While it may have made sennse for simplicity to not pr_warn_once on the
> proc_taint() case I think in this case we do want to pr_warn_once() as
> the user is wishing to DEFINITELY PANIC if such a taint flag is present.
>

In case the bitmask is invalidated (because user has set it deliberately
to 0, or because it was set to a specific flagset totally out of the valid 
range, which will cause the bitwise-and to render panic_on_taint=0) the non-zero
return in the checkpoint below will take care of informing that the option
was malformed and it's not set. For all other cases where out-of-range 
flags get ignored, but a flagset is committed to panic_on_taint, the user 
can verify the results that will be printed out at the pr_info() call.

There is no need for an extra custom printout for this case, IMO.

> > +
> > +	if (!panic_on_taint)
> > +		return -EINVAL;
> > +
> > +	if (s && !strcmp(s, "nousertaint"))
> > +		panic_on_taint_nousertaint = true;
> > +
> > +	pr_info("panic_on_taint: bitmask=0x%lx nousertaint_mode=%sabled\n",
> > +		panic_on_taint, panic_on_taint_nousertaint ? "en" : "dis");
> > +
> > +	return 0;
> > +}
> > +early_param("panic_on_taint", panic_on_taint_setup);
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..e257c965683a 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2623,11 +2623,20 @@ static int proc_taint(struct ctl_table *table, int write,
> >  		return err;
> >  
> >  	if (write) {
> > +		int i;
> > +
> > +		/*
> > +		 * If we are relying on panic_on_taint not producing
> > +		 * false positives due to userland input, bail out
> > +		 * before setting the requested taint flags.
> > +		 */
> > +		if (panic_on_taint_nousertaint && (tmptaint & panic_on_taint))
> > +			return -EINVAL;
> > +
> 
> I like the compromise, but I think you also have to update this sysctl's
> documentation to reflect this is disabled if this new boot param is used.
> 

Indeed, sorry I missed that part. I'll update it and repost.

-- Rafael

