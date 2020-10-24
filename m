Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E45297AA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Oct 2020 06:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759399AbgJXEIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 00:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgJXEIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 00:08:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7AC0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 21:08:15 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p10so3348450ile.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2020 21:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRtLwMVw9c4TiosDDsBOINIbNomLxGOZi2G9fpejdro=;
        b=LcW1DnreOANwAWcycXCj7JMSwdmvQnMjHZjq+r5vMqne5c5pqkAwSg8nlJO7kVT8In
         1yypDtDKS+KkVAgj83KgqDQ6/3A40wVCl+wkfL8aWxDgeqrpL373XrgcNf/S0I0HblaZ
         hf4p1vBLtvLfA3JVE/b2AJAD/cEJY4TlKHK9p+81entvc5/GX4GL1vChHbVPG1CxNfSE
         JEpNkgIRHW3ITfES5Ynrhlu+km4qbDbn+dMe7oytNQIEtyfvd7aSyx5UV7NSxoqNv7Qg
         NEbTcgr1ozs8zn9gvWnJUl1Ji+xcFxvNTlDZ+nGxPPgrTAQ514Ldkzjoz8nNZ1X4md2S
         PKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRtLwMVw9c4TiosDDsBOINIbNomLxGOZi2G9fpejdro=;
        b=LvAucdvxPP6Joleb3/2PlyUOO53pcuv5QPblVc9ba+CYpn8ynrjt7flaKhHwPDfGO0
         CsJ00Ck5TmAv4jK7hPPJWQ+LgyblPU3ASja8HGgjTXihYkaYLvW6Rq0ryCTMgdP6Al03
         hfW31FOv9zswxcI7Uc9iofDx53HofWc9OTfYL9sO3N11fMmveLgjq2INXoQmCXLnK5T7
         S8gznIC5VyUxb6kilzPb4LLg9VlrXnb8T98tvWkSgdcv6/yvIJAOzBKiWRdHriM0jDaT
         5II2l6ecKJFvaUUUr0Gfn+be7ea+87y7WWYt2wn45V6xJ5TiNRjceDYPoA1F/ORmK1K0
         koZw==
X-Gm-Message-State: AOAM532e25mFcygDyCMsqygJ2xGXpOwZdIqwWqVpOuxVI4tLR1+EbIs2
        UYgexMhLRfjCf3WpenIxwTvFm6fw4UKd6EIE9yhmzQ==
X-Google-Smtp-Source: ABdhPJwYJ4cjiyenZUUzWqjwd6gBGW90EGk9W0ItKjzOqVrTj+T5PIcn1mVzrMSn5pP+aJPfFqW53AlUxNSMhJvF5YY=
X-Received: by 2002:a92:494c:: with SMTP id w73mr4286150ila.104.1603512494532;
 Fri, 23 Oct 2020 21:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201011062456.4065576-1-lokeshgidra@google.com>
 <20201011062456.4065576-3-lokeshgidra@google.com> <20201024024835.GC19707@redhat.com>
In-Reply-To: <20201024024835.GC19707@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 23 Oct 2020 21:08:03 -0700
Message-ID: <CA+EESO6GrkKOkcXguiBTaBdU0b=R=nb6sZ95Ccjaip5RWeL4Nw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Add user-mode only option to unprivileged_userfaultfd
 sysctl knob
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 23, 2020 at 7:48 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Hello everyone,
>
> On Sat, Oct 10, 2020 at 11:24:56PM -0700, Lokesh Gidra wrote:
> > With this change, when the knob is set to 0, it allows unprivileged
> > users to call userfaultfd, like when it is set to 1, but with the
> > restriction that page faults from only user-mode can be handled.
> > In this mode, an unprivileged user (without SYS_CAP_PTRACE capability)
> > must pass UFFD_USER_MODE_ONLY to userfaultd or the API will fail with
> > EPERM.
> >
> > This enables administrators to reduce the likelihood that
> > an attacker with access to userfaultfd can delay faulting kernel
> > code to widen timing windows for other exploits.
> >
> > The default value of this knob is changed to 0. This is required for
> > correct functioning of pipe mutex. However, this will fail postcopy
> > live migration, which will be unnoticeable to the VM guests. To avoid
> > this, set 'vm.userfault = 1' in /sys/sysctl.conf. For more details,
> > refer to Andrea's reply [1].
> >
> > [1] https://lore.kernel.org/lkml/20200904033438.GI9411@redhat.com/
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
>
> Nobody commented so it seems everyone is on board with this change to
> synchronize the kernel default with the post-boot Android default.
>
> The email in the link above was pretty long, so the below would be a
> summary that could be added to the commit header:
>
> ==
>
> The main reason this change is desirable as in the short term is that
> the Android userland will behave as with the sysctl set to zero. So
> without this commit, any Linux binary using userfaultfd to manage its
> memory would behave differently if run within the Android userland.
>
> ==

Sure. I'll add it in the next revision.
>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
>
Thanks so much for the review. I hope it's ok to add your
'reviewed-by' in the next revision?
>
> BTW, this is still a minor nitpick, but a printk_once of the 1/2 could
> be added before the return -EPERM too, that's actually what I meant
> when I suggested to add a printk_once :), however the printk_once you
> added can turn out to be useful too for devs converting code to use
> bounce buffers, so it's fine too, just it could go under DEBUG_VM and
> to be ratelimited (similarly to the "FAULT_FLAG_ALLOW_RETRY missing
> %x\n" printk).

I'll move the printk_once from 1/2 to this patch, as you suggested.
>
> Thanks,
> Andrea
>
