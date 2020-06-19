Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C07201C9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390072AbgFSUqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:46:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45820 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbgFSUqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:46:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id a127so4906098pfa.12;
        Fri, 19 Jun 2020 13:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ig1uMooEc7hJ7T4tJda0UtWOL236yx/7EtI4v6obG4=;
        b=SI2YpQ7h0RMWuvuoFd1z5sbCGXsvbiuGDddv+bvOzcZMLDHxe0rAs6xY8u0lSjGoEy
         KSuIyXT5q0iWZwQ7wWzzdgV1XI018+CSZZrYRhj+nnSx+pw1GoltC/LPceM1J0jOoEoU
         aDTJn03MrW9670CvSu+PxBpxVVGCHQAcbkQaTUCNIOIrOG1bfqvyPh4EfaecupqfSh6+
         kEaZfqnaCM4t0nmbw8V3syVb4lC1vJhql/yZvyrvoJurdiWVM5CcjtyBfKgRFYtoEPhu
         ECf5kC8DkF/yYAlqxekF4CsGeHNvJZpI6dExZZhiUb6FKomHd981O7Y2P0hS7lHYYhco
         NoRg==
X-Gm-Message-State: AOAM532Roo6s/Rw8pXRoxuP6cpGGlI9Zh6ReHv2mvlKxk9dbheyC0D9u
        hdeMfIX9+kHnnWkRt38ZXCs=
X-Google-Smtp-Source: ABdhPJzKNPWlIV0nmO+CTspxV1ueBsq/MLwS42z81TaqEce+i1mqYn5aUJ4K080LEjB7u0IDfz6xvA==
X-Received: by 2002:aa7:8145:: with SMTP id d5mr9453904pfn.196.1592599589431;
        Fri, 19 Jun 2020 13:46:29 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n9sm6138891pjj.23.2020.06.19.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:46:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CAC654063E; Fri, 19 Jun 2020 20:46:26 +0000 (UTC)
Date:   Fri, 19 Jun 2020 20:46:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, roopa@cumulusnetworks.com,
        nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com,
        slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, bridge@lists.linux-foundation.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] kmod/umh: a few fixes
Message-ID: <20200619204626.GK11244@42.do-not-panic.com>
References: <20200610154923.27510-1-mcgrof@kernel.org>
 <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 05:43:48PM -0700, Andrew Morton wrote:
> On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> 
> > Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> > fixes, and one patch which modified kmod to return 254 when a module
> > was not found. This opened up pandora's box about why that was being
> > used for and low and behold its because when UMH_WAIT_PROC is used
> > we call a kernel_wait4() call but have never unwrapped the error code.
> > The commit log for that fix details the rationale for the approach
> > taken. I'd appreciate some review on that, in particular nfs folks
> > as it seems a case was never really hit before.
> > 
> > This goes boot tested, selftested with kmod, and 0-day gives its
> > build blessings.
> 
> Any thoughts on which kernel version(s) need some/all of these fixes?

Well, in so far as fixes, this is the real important part:

* request_module() used to fail with an error code of
  256 when a module was not found. Now it properly
  returns 1.

* fs/nfsd/nfs4recover.c: we never were disabling the
  upcall as the error code of -ENOENT or -EACCES was
  *never* properly checked for error code

Since the request_module() fix is only affecting userspace
for the kmod tests, through the kmod test driver, ie, we don't expose
this to userspace in any other place, I don't see that as critical.
Let me be clear, we have a test_kmod driver which exposes knobs
and one of the knobs lets userspace query the return value of a
request_module() call, and we use this test_kmod driver to stress
test kmod loader. Let us also recall that the fix is *iff* an error
*did* occur. I *cannot* think of a reason why this would be critical
to merge to older stable kernels for this reason for request_module()'s
sake.

Bruce, Chuck:

But... for NFS... I'd like the NFS folks to really look at that
and tell us is some folks really should care about that. I also
find it perplexing there was a comment in place there to *ensure*
the error was checked for, and so it seemed someone cared for that
condition.

> >  drivers/block/drbd/drbd_nl.c         | 20 +++++------
> >  fs/nfsd/nfs4recover.c                |  2 +-
> >  include/linux/sched/task.h           | 13 ++++++++
> >  kernel/kmod.c                        |  5 ++-
> >  kernel/umh.c                         |  4 +--
> >  lib/test_kmod.c                      |  2 +-
> >  net/bridge/br_stp_if.c               | 10 ++----
> >  security/keys/request_key.c          |  2 +-
> >  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----
> 
> I'm not really sure who takes kmod changes - I'll grab these unless
> someone shouts at me.

Greg usually takes it, but as usual, thanks for picking up the slack ;)

  Luis
