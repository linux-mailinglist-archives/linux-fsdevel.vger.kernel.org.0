Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62E11F496B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 00:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFIWc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 18:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgFIWcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:32:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A5EC05BD1E;
        Tue,  9 Jun 2020 15:32:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so137012plb.11;
        Tue, 09 Jun 2020 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQ0uUtbshOJy7CrvfJNOaxfAHwLaSDEjhO9A2MXahqI=;
        b=R0NlH4qTbraRZ5ux0JFfNwXbCeeJf4QNfKGPsdwZclgwygwBpRRgoJ3JMSu9wq4IRr
         xeDAc3COcAUPgR6CwA+OVVRtJfgoumMUSzJDmHXE59OBK+pFdya0YBk5am49vez/hX34
         QF0LMqmxttdB/HOrsbIJpkaNW5WCL/WWW2M5OXOlck7fsS13PtD9QAuVJ8O5rNCc/e2d
         NBugLp+Q0Hd6NTjXQRORAnO8ySS1ghA6slWyKTnmf5PxyXFU6bY3zWdGOnTo/rU3546E
         SHOpuCq8EQXr48+YmfOSfWZ2lbLF9p9c3VUAbMacm76XlqNzRxdDkt7/Q676GJr/yqzU
         AgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQ0uUtbshOJy7CrvfJNOaxfAHwLaSDEjhO9A2MXahqI=;
        b=Er7GHBBUwF8MCCyjAQprWyKe+94h4mFhCIh/Nwv82JXWcHtEoKJYO3a+JXS6Oakhks
         gePizCMX052euYrHtQWZgBO9qnY1/ClyvtB3Dag3zQz0nQx9MkUAneuJNQIgR5lqHgro
         U3ylIU91DWzuR+iwXj9QJLR/t2FWssWnMpqUuI4Pu75hfwFX3jkVcD26Tyv8S6+2yIdi
         +ZOfVK7D4ruE9r0QBokOgirdSrJSMFSd+RSkO+3iSgqGBFpADZtzoTpNCrwYB/gCGpGo
         xbYXmbwmh65JQ5kTcLH3XeKcY6IfbBjZb3nsjJSQEGhKPfL5TYzyIOsVbVtWD8hjdILM
         wG/w==
X-Gm-Message-State: AOAM532XmF/yIQFClwYi+iYP3kwgHgzul3wp290Ue4hshRrdW7ZpdpPe
        kgEgBof61VR1O218Sh5OJVQ=
X-Google-Smtp-Source: ABdhPJxaagPHL6AcUm5W/5bvBwRBZ2ulXu+kFYEllIJJ9U7qfFQ3dOrjWucyHF4CShEvHFJjp/PvtQ==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr467779plb.63.1591741937791;
        Tue, 09 Jun 2020 15:32:17 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id n19sm10867855pfa.216.2020.06.09.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:32:16 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:32:14 -0700
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
Message-ID: <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
References: <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:29:09PM +0900, Tetsuo Handa wrote:
> On 2020/06/09 10:28, Alexei Starovoitov wrote:
> >> TOMOYO LSM module uses call_usermodehelper() from tomoyo_load_policy() in order to
> >> load and apply security policy. What is so nice with fork_usermode_blob() compared
> >> to existing call_usermodehelper(), at the cost of confusing LSM modules by allowing
> >> file-less execve() request from fork_usermode_blob() ?
> > 
> > For the same reason you did commit 0e4ae0e0dec6 ("TOMOYO: Make several options configurable.")
> > Quoting your words from that commit:
> > "To be able to start using enforcing mode from the early stage of boot sequence,
> >  this patch adds support for activating access control without calling external
> >  policy loader program."
> > 
> 
> I can't catch what you mean. That commit is to allow not to call usermode helper.
> 
> You can't start a usermode helper which requires access to filesystems (e.g. ELF loaders,
> shared libraries) before call_usermodehelper() can start a usermode helper which requires
> access to filesystems. Under such a restricted condition, what is nice with starting a
> usermode helper? Programs which can be started under such condition will be quite limited.
> My question is: why you can't use existing call_usermodehelper() (if you need to call
> a usermode helper) ?

I think the confusion comes from assumption that usermode blob is a dynamic file that
needs ld.so, shared libs and rootfs. This mode is supported by the blob loading
logic, but it's not a primary use case. It's nice to be able to compile
that blob with -g and be able to 'gdb -p' into it. That works and very
convenient when it comes to debugging. Compare that to debugging a kernel module!
It's pretty cool to have vmlinux with kernel module-like feature
that folks can breakpoint and single step while the kernel is running.
That's how we've been developing bpfilter. Sadly the other two patches
(by Davem and Daniel) didn't land:
https://lore.kernel.org/patchwork/patch/902785/
https://lore.kernel.org/patchwork/patch/902783/
and without them bpfilter looks completely useless.

The main mode of bpfilter operation was envisioned as rootfs-less.
It must work with any init= including busybox. For production the bpfilter
user mode blob was compiled as static binary with no dependencies.
So there is no path to point to. It should be ready before pid 1
will do its first iptables sys_setsockopt. If user reboots the kernel
with different init= cmdline the bpfilter should still be doing its job.
Like builtin kernel module.
Anyway bpfilter is only one of the use cases for 'elf in vmlinux'.
I think better name would have been 'user space kernel modules'.
