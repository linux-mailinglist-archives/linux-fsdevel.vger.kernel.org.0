Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95C1D91CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgESILz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 04:11:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38102 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESILz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 04:11:55 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jaxLb-0000Ea-Hq; Tue, 19 May 2020 08:11:35 +0000
Date:   Tue, 19 May 2020 10:11:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Message-ID: <20200519081134.voejjt77b3qjf22h@wittgenstein>
References: <20200518055457.12302-1-keescook@chromium.org>
 <20200518055457.12302-2-keescook@chromium.org>
 <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
 <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
 <20200518144627.sv5nesysvtgxwkp7@wittgenstein>
 <87blmk3ig4.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blmk3ig4.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 06:57:15PM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, May 18, 2020 at 04:43:20PM +0200, Jann Horn wrote:
> >> On Mon, May 18, 2020 at 3:03 PM Christian Brauner
> >> <christian.brauner@ubuntu.com> wrote:
> >> > Also - gulp (puts on flame proof suit) - may I suggest we check if there
> >> > are any distros out there that still set CONFIG_USELIB=y
> >> 
> >> Debian seems to have it enabled on x86...
> >> 
> >> https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/config/kernelarch-x86/config#L1896
> >> 
> >> A random Ubuntu 19.10 VM I have here has it enabled, too.
> >
> > I wonder if there's any program - apart from _ancient_ glibc out there
> > that actually use it...
> > I looked at uselib in codsearch but the results were quite unspecific
> > but I didn't look too close.
> 
> So the thing to do is to have a polite word with people who build Ubuntu
> and Debian kernels and get them to disable the kernel .config.

Yeah, I think that's a sane thing to do.
I filed a bug for Ubuntu to start a discussion. I can't see an obvious
reason why not.

> 
> A quick look suggets it is already disabled in RHEL8.  It cannot be
> disabled in RHEL7.
> 
> Then in a few years we can come back and discuss removing the uselib
> system call, base on no distributions having it enabled.
> 
> If it was only libc4 and libc5 that used the uselib system call then it
> can probably be removed after enough time.
> 
> We can probably reorganize the code before the point it is clearly safe
> to drop support for USELIB to keep it off to the side so USELIB does not
> have any ongoing mainteance costs.
> 
> For this patchset I think we need to assume uselib will need to be
> maintained for a bit longer.

Yeah, agreed. It doesn't matter as long as we have a plan for the future
to remove it. I don't think keeping this cruft around forever should be
the only outlook.

Christian
