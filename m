Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77FD1CB53A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 18:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEHQyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 12:54:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726815AbgEHQyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 12:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588956851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7cPGMHYLt8uRkzqsxvlnSsppGjQWalvX1CXcsJ2sNtI=;
        b=Rv4cAFT6vjfVSVeM/d1Q88OrHx9YF1YcBTqGds/SDWa69tqMBiWx3ZADdWxLQN0oNYVSYp
        cFludcg0YtCEKiK9mWE8YyakRzNoLKFLUqO9qcqelH15eb+fbobH2wmmmmSgRHxQd76Xmr
        90NmQjfyC+G4S1sEoUzml29M3KIUWiw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-gQgx_S6pMbGkTcWRzCrHLA-1; Fri, 08 May 2020 12:54:09 -0400
X-MC-Unique: gQgx_S6pMbGkTcWRzCrHLA-1
Received: by mail-wm1-f71.google.com with SMTP id d134so5568284wmd.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 09:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7cPGMHYLt8uRkzqsxvlnSsppGjQWalvX1CXcsJ2sNtI=;
        b=KII/4xIno1e2QUBshG6n5Q+NfaKQwTfiNs+WLLOq+6sbNRATglhR44IY2D17Ryl6d0
         4LaFEvAqr66KNmZd5D+IhrkH579QL3DqvK6mLkWPzjspBB0XBTY3nhjXxvZ5Z9C+NQoA
         fGeOkC+/DwL2ShS7lQ2Xgj2Hyh2W5kjVnAcdiFAJ6iuBQfkUIlq9K6XzembMKB8rxGSC
         orXBNpZx7MmBFZ8410kI+hQwzKx68NirpGT2zDI9iDIyEvofLGsqLc+255TZFm4eXXHY
         4Fbu1BtZ/ftji+Tw3SET4J5zHPcGnctCgHHm5h4xWkRNxLV8U4q8UOui7Kzo+7yDR7ia
         2uZA==
X-Gm-Message-State: AGi0PuZh1EdW0JTA2OZqqxF/ii3mLpdFoJfdqTofMVxMOveUplRsHCzG
        hQGABpPktRe//mjFd2ppdJ8SaiHf2+106P2XcuPqjhJZhFuC9zNlpYoDCCpB/rG+Ic5dj6AvgWu
        Xu8vhO6qH5TS0A5QfnDg4Zqn7rA==
X-Received: by 2002:a05:600c:40d:: with SMTP id q13mr6806849wmb.69.1588956848275;
        Fri, 08 May 2020 09:54:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJd9FRP9YT1M7aB0uzWK+C9xMb9GqqT6RIht/vZ5FbjXT3flOjsmdBTVZwd+LU0m743YVoEkQ==
X-Received: by 2002:a05:600c:40d:: with SMTP id q13mr6806805wmb.69.1588956847989;
        Fri, 08 May 2020 09:54:07 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id r11sm2628353wrv.14.2020.05.08.09.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:54:07 -0700 (PDT)
Date:   Fri, 8 May 2020 12:54:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200508125314-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508125054-mutt-send-email-mst@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 12:52:34PM -0400, Michael S. Tsirkin wrote:
> On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> > This sysctl can be set to either zero or one. When zero (the default)
> > the system lets all users call userfaultfd with or without
> > UFFD_USER_MODE_ONLY, modulo other access controls. When
> > unprivileged_userfaultfd_user_mode_only is set to one, users without
> > CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
> > will fail with EPERM. This facility allows administrators to reduce
> > the likelihood that an attacker with access to userfaultfd can delay
> > faulting kernel code to widen timing windows for other exploits.
> > 
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> 
> The approach taken looks like a hard-coded security policy.
> For example, it won't be possible to set the sysctl knob
> in question on any sytem running kvm. So this is
> no good for any general purpose system.
> 
> What's wrong with using a security policy for this instead?

In fact I see the original thread already mentions selinux,
so it's just a question of making this controllable by
selinux.

> 
> 
> > ---
> >  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
> >  fs/userfaultfd.c                        | 11 ++++++++++-
> >  include/linux/userfaultfd_k.h           |  1 +
> >  kernel/sysctl.c                         |  9 +++++++++
> >  4 files changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> > index 0329a4d3fa9e..4296b508ab74 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -850,6 +850,19 @@ privileged users (with SYS_CAP_PTRACE capability).
> >  
> >  The default value is 1.
> >  
> > +unprivileged_userfaultfd_user_mode_only
> > +========================================
> > +
> > +This flag controls whether unprivileged users can use the userfaultfd
> > +system calls to handle page faults in kernel mode.  If set to zero,
> > +userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
> > +unprivileged_userfaultfd above.  If set to one, users without
> > +SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
> > +to succeed.  Prohibiting use of userfaultfd for handling faults from
> > +kernel mode may make certain vulnerabilities more difficult
> > +to exploit.
> > +
> > +The default value is 0.
> >  
> >  user_reserve_kbytes
> >  ===================
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 21378abe8f7b..85cc1ab74361 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/hugetlb.h>
> >  
> >  int sysctl_unprivileged_userfaultfd __read_mostly = 1;
> > +int sysctl_unprivileged_userfaultfd_user_mode_only __read_mostly = 0;
> >  
> >  static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
> >  
> > @@ -2009,8 +2010,16 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >  	static const int uffd_flags = UFFD_USER_MODE_ONLY;
> >  	struct userfaultfd_ctx *ctx;
> >  	int fd;
> > +	bool need_cap_check = false;
> >  
> > -	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
> > +	if (!sysctl_unprivileged_userfaultfd)
> > +		need_cap_check = true;
> > +
> > +	if (sysctl_unprivileged_userfaultfd_user_mode_only &&
> > +	    (flags & UFFD_USER_MODE_ONLY) == 0)
> > +		need_cap_check = true;
> > +
> > +	if (need_cap_check && !capable(CAP_SYS_PTRACE))
> >  		return -EPERM;
> >  
> >  	BUG_ON(!current->mm);
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index a8e5f3ea9bb2..d81e30074bf5 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -31,6 +31,7 @@
> >  #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
> >  
> >  extern int sysctl_unprivileged_userfaultfd;
> > +extern int sysctl_unprivileged_userfaultfd_user_mode_only;
> >  
> >  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
> >  
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 8a176d8727a3..9cbdf4483961 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1719,6 +1719,15 @@ static struct ctl_table vm_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE,
> >  	},
> > +	{
> > +		.procname	= "unprivileged_userfaultfd_user_mode_only",
> > +		.data		= &sysctl_unprivileged_userfaultfd_user_mode_only,
> > +		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd_user_mode_only),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_ONE,
> > +	},
> >  #endif
> >  	{ }
> >  };
> > -- 
> > 2.26.2.303.gf8c07b1a785-goog
> > 

