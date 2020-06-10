Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD71F4A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 02:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgFJAFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 20:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJAFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:05:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278BC05BD1E;
        Tue,  9 Jun 2020 17:05:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so238190plr.0;
        Tue, 09 Jun 2020 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Hi9Wcu2NJ+4OccEGjDN4hj9Xvjx6C52VRSXVCJ5FSE=;
        b=dZBYow124cxJdYgi42xRAB6qiSXnAQe03ILbQCCET80BKXf3v9SXyWa1EVJvXLsOi2
         pw5l4U8N0kff1JoZKF0kNJ+w5ZDtJQZwo9AQmd+GDpf/jNERdVmUkYm4CvP07LdKmxGf
         8KBjOfNuJxZcNqznHqT+ksCr1SicEZnY5FOiFekCjbtjiFcwdbbfzDUEWl2uOBOwfKaA
         0INZXHXUI6bkfj9igel7sj6ZZW2qPLWkABxpbqoFUCQxoPogoMYVUAqxerYV5a0DMu1a
         R+TAgpGzk7pPYVlhc5z1ijBDDIwDJHBZK3g3lPE6J/ie/Sq1O7TOLitiyUSgkZg0TN22
         Pc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Hi9Wcu2NJ+4OccEGjDN4hj9Xvjx6C52VRSXVCJ5FSE=;
        b=ZPE4FRHrWIoaCljLVaKxxbJvbxk/BjxPPmiasVw4woyHIhjxQXm/6YNQe1aXLS9gnA
         FzQ0MRk2c6asfjQtKiWZ96BylknM9GQbhHMu7kkUI8Sdci3wjnO5R+a8NOK4NQZd9yEK
         OFdRFqeMUpztWHTmYvFvBE5CPsfgu2yD6mYFld1C/bYTf4QuVrwHSGyh0U3klvk/+RQ+
         5IjQHS9xrTbCuFN+yxmUZw73gl0x6rR6WGEp0LVslHg1qo+bnQIg5lNAYG45w9DoM20N
         PDDweHI+X2VYkLkDtzxENZuhGOkMSDzpTDQGsIuLgwCSIWtmCEYtLQO7QhZ/DBXOIJtw
         Q1vA==
X-Gm-Message-State: AOAM530R/U8SteMdDrOmew436yY/WlXQT91WrJOOM5pXyjjkfObn5MkS
        m3DmhtyHfp5Ef6h7DBxVEns=
X-Google-Smtp-Source: ABdhPJx3xHxVubm5bBV8Q7VP7Ddn1Ln4sHfJONWiuqn/kRZTkS8cmWmtaX2C7oD+Ro7M7rhQBL8P1A==
X-Received: by 2002:a17:90a:3608:: with SMTP id s8mr278870pjb.167.1591747549980;
        Tue, 09 Jun 2020 17:05:49 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id q193sm11160747pfq.158.2020.06.09.17.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 17:05:49 -0700 (PDT)
Date:   Tue, 9 Jun 2020 17:05:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
References: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
 <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:30:31AM +0900, Tetsuo Handa wrote:
> On 2020/06/10 7:32, Alexei Starovoitov wrote:
> >> You can't start a usermode helper which requires access to filesystems (e.g. ELF loaders,
> >> shared libraries) before call_usermodehelper() can start a usermode helper which requires
> >> access to filesystems. Under such a restricted condition, what is nice with starting a
> >> usermode helper? Programs which can be started under such condition will be quite limited.
> >> My question is: why you can't use existing call_usermodehelper() (if you need to call
> >> a usermode helper) ?
> > 
> > I think the confusion comes from assumption that usermode blob is a dynamic file that
> > needs ld.so, shared libs and rootfs.
> 
> Yes, I assume that usermode blob needs to be able to access the rootfs.
> 
> >                                      This mode is supported by the blob loading
> > logic, but it's not a primary use case. It's nice to be able to compile
> > that blob with -g and be able to 'gdb -p' into it.
> 
> Where can the gdb come from when the rootfs is not accessible?
> 
> >                                                    That works and very
> > convenient when it comes to debugging. Compare that to debugging a kernel module!
> 
> Userspace is convenient for debugging, at the cost of robustness (e.g. being killed
> by SIGKILL).
> 
> > 
> > The main mode of bpfilter operation was envisioned as rootfs-less.
> > It must work with any init= including busybox. For production the bpfilter
> > user mode blob was compiled as static binary with no dependencies.
> 
> I still can't imagine. Compiling a user mode blob as a static binary is possible.
> But what does 'It must work with any init=' mean? The use of init= depends on
> the rootfs being ready.
> 
> > So there is no path to point to. It should be ready before pid 1
> > will do its first iptables sys_setsockopt.
> 
> There has to be at least the root directory in order to use init= parameter.

I think you're still missing that usermode_blob is completely fs-less.
It doesn't need any fs to work.

> 
> What does the "pid 1" mean? Why you can't specify your "user mode blob" using init=
> parameter and then transfer the control of "pid 1" from your "user mode blob" to
> "some program which will do its first iptables sys_setsockopt()" ?

because init= is user cmdline and usermode_blob() is used by the kernel feature.
they are independent.

> >                                            If user reboots the kernel
> > with different init= cmdline the bpfilter should still be doing its job.
> > Like builtin kernel module.
> 
> Even when rebooting the kernel with different init= cmdline, you have a space for
> running your "user mode blob" (e.g.
> 
>   init=/path/to/your/user/mode/blob init_after_blob=/path/to/some/program/which/will/do/something/else
> 
> ), don't you?
> 
> There is no need to use call_usermodehelper(), let alone fork_usermode_blob()...

Using the same argument there is no need for kernel modules and certainly
no need for builtin kernel modules. That back and forth is not going anywhere.
Let's table it.
