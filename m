Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A601D5506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgEOPrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgEOPrB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:47:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905AC05BD0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:47:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c75so119633pga.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Tp1yJFYJhgIbfd5lJGD8jRi3pZ2NypuWNlZpcocDHT8=;
        b=EmpMZVAX1wx85vkyBc5/P+fYj2mwnLAsTm/P4yiv2KtxbvHfmZAwhR+zjtV1EBhN2X
         BReu4CY5qEYsHFiewS4+kAzWLVXb73otKnet+n4x7VjkZgTqLwE+vnM+jnEi+nk1c7ty
         vSY1B2yu2bdPwD71vBpulqYgYRqhkd1jMHSj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Tp1yJFYJhgIbfd5lJGD8jRi3pZ2NypuWNlZpcocDHT8=;
        b=jFEGc4O6owt5x8jVsGlWNXPJrJPRsipZjVnlU2rM5tovmwYrkbnRxhEeczRu0wgejU
         7jz4CnI0t2AmY+ml2SINTWgfrmYlh2lhqkw5nfzz1DbqBbvSkRUP9a1ZHrdNVLYXVOwI
         aPnyC3UPCsGtvN43JINzJAud1AJtCCubEYPOQRRqCJenZeOFRD9J9sJFjlMRf5hsUap0
         vgJhtdua2jxwNSdmpr2ac7+tXh+g5nViXKb86zcN5kqbGQRRnF3ta5zWYRtAWW31rKcA
         j8gGerHn3fNYtuIL3hTTygB5CaZy31njaXdYFgNsc+JaSi5/Le3TNMewAklSekYt2VH9
         QvdA==
X-Gm-Message-State: AOAM530bOB5t9TXsN+RTKM/QWPwx1oqDDTDA/CfJ9NuvfQX5otwHJkmm
        J5gPKbYUUOIxhtHeZdhUCU5V2g==
X-Google-Smtp-Source: ABdhPJxCxRIctKkG0jiZ7deyGgcCZJ1ccBYUj9+mcaG6GziW+a6F3XU/NV7eHM88WzhDbWN5XVC/mA==
X-Received: by 2002:aa7:8603:: with SMTP id p3mr3963913pfn.116.1589557620660;
        Fri, 15 May 2020 08:47:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm2261604pfk.199.2020.05.15.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:46:59 -0700 (PDT)
Date:   Fri, 15 May 2020 08:46:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Rich Felker <dalias@aerifal.cx>
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
Message-ID: <202005150740.F0154DEC@keescook>
References: <20200505153156.925111-4-mic@digikod.net>
 <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
 <202005131525.D08BFB3@keescook>
 <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook>
 <1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e2f6913-42f2-3578-28ed-567f6a4bdda1@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 01:04:08PM +0200, Mickaël Salaün wrote:
> 
> On 15/05/2020 10:01, Kees Cook wrote:
> > On Thu, May 14, 2020 at 09:16:13PM +0200, Mickaël Salaün wrote:
> >> On 14/05/2020 18:10, Stephen Smalley wrote:
> >>> On Thu, May 14, 2020 at 11:45 AM Kees Cook <keescook@chromium.org> wrote:
> >>>> So, it looks like adding FMODE_EXEC into f_flags in do_open() is needed in
> >>>> addition to injecting MAY_EXEC into acc_mode in do_open()? Hmmm
> >>>
> >>> Just do both in build_open_flags() and be done with it? Looks like he
> >>> was already setting FMODE_EXEC in patch 1 so we just need to teach
> >>> AppArmor/TOMOYO to check for it and perform file execute checking in
> >>> that case if !current->in_execve?
> >>
> >> I can postpone the file permission check for another series to make this
> >> one simpler (i.e. mount noexec only). Because it depends on the sysctl
> >> setting, it is OK to add this check later, if needed. In the meantime,
> >> AppArmor and Tomoyo could be getting ready for this.
> > 
> > So, after playing around with this series, investigating Stephen's
> > comments, digging through the existing FMODE_EXEC uses, and spending a
> > bit more time thinking about Lev and Aleksa's dislike of the sysctls, I've
> > got a much more radically simplified solution that I think could work.
> 
> Not having a sysctl would mean that distros will probably have to patch
> script interpreters to remove the use of O_MAYEXEC. Or distros would
> have to exclude newer version of script interpreters because they
> implement O_MAYEXEC. Or distros would have to patch their kernel to
> implement themselves the sysctl knob I'm already providing. Sysadmins
> may not control the kernel build nor the user space build, they control
> the system configuration (some mount point options and some file
> execution permissions) but I guess that a distro update breaking a
> running system is not acceptable. Either way, unfortunately, I think it
> doesn't help anyone to not have a controlling sysctl. The same apply for
> access-control LSMs relying on a security policy which can be defined by
> sysadmins.
> 
> Your commits enforce file exec checks, which is a good thing from a
> security point of view, but unfortunately that would requires distros to
> update all the packages providing shared objects once the dynamic linker
> uses O_MAYEXEC.

I used to agree with this, but I'm now convinced now that the sysctls are
redundant and will ultimately impede adoption. In looking at what levels
the existing (CLIP OS, Chrome OS) and future (PEP 578) implementations
have needed to do to meaningfully provide the protection, it seems
like software will not be using this flag out of the blue. It'll need
careful addition way beyond the scope of just a sysctl. (As in, I don't
think using O_MAYEXEC is going to just get added without thought to all
interpreters. And developers that DO add it will want to know that the
system will behave in the specified way: having it be off by default
will defeat the purpose of adding the flag for the end users.)

I think it boils down to deciding how to control enforcement: should it
be up to the individual piece of software, or should it be system-wide?
Looking at the patches Chrome OS has made to the shell (and the
accompanying system changes), and Python's overall plans, it seems to
me that the requirements for meaningfully using this flag is going to
be very software-specific.

Now, if the goal is to try to get O_MAYEXEC into every interpreter as
widely as possible without needing to wait for the software-specific
design changes, then I can see the reason to want a default-off global
sysctl. (Though in that case, I suspect it needs to be tied to userns or
something to support containers with different enforcement levels.)

> > Maybe I've missed some earlier discussion that ruled this out, but I
> > couldn't find it: let's just add O_EXEC and be done with it. It actually
> > makes the execve() path more like openat2() and is much cleaner after
> > a little refactoring. Here are the results, though I haven't emailed it
> > yet since I still want to do some more testing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
> > 
> > I look forward to flames! ;)
> > 
> 
> Like Florian said, O_EXEC is for execute-only (which obviously doesn't
> work for scripts):
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/open.html
> On the other hand, the semantic of O_MAYEXEC is complementary to other
> O_* flags. It is inspired by the VM_MAYEXEC flag.

Ah! I see now -- it's intended to be like the O_*ONLY flags. I
misunderstood what Florian meant. Okay, sure that's a good enough reason
for me to retain the O_MAYEXEC name. (And then I think this distinction
from O_EXEC needs to be well documented.)

> The O_EXEC flag is specified for open(2). openat2(2) is Linux-specific
> and it is highly unlikely that new flags will be added to open(2) or
> openat(2) because of compatibility issues.

Agreed. (Which in my mind is further rationale that a sysctl isn't
wanted here: adding O_MAYEXEC will need to be very intentional.)

> FYI, musl implements O_EXEC on Linux with O_PATH:
> https://www.openwall.com/lists/musl/2013/02/22/1
> https://git.musl-libc.org/cgit/musl/commit/?id=6d05d862975188039e648273ceab350d9ab5b69e
> 
> However, the O_EXEC flag/semantic could be useful for the dynamic
> linkers, i.e. to only be able to map files in an executable (and
> read-only) way. If this is OK, then we may want to rename O_MAYEXEC to
> something like O_INTERPRET. This way we could have two new flags for
> sightly (but important) different use cases. The sysctl bitfield could
> be extended to manage both of these flags.

If it's not O_EXEC, then I do like keeping "EXEC" in the flag name,
since it has direct relation to noexec and exec-bit. I'm fine with
O_MAYEXEC -- I just couldn't find the rationale for why it _shouldn't_
be O_EXEC. (Which is now well understood -- thanks to you you and
Florian!)

> Other than that, the other commits are interesting. I'm a bit worried
> about the implication of the f_flags/f_mode change though.

That's an area I also didn't see why FMODE_EXEC wasn't retained in
f_mode. Especially given the nature of the filtering out FMODE_NONOTIFY
in build_open_flags(). Why would FMODE_NONOTIFY move to f_mode, but not
FMODE_EXEC?

> From a practical point of view, I'm also wondering how you intent to
> submit this series on LKML without conflicting with the current
> O_MAYEXEC series (versions, changes…). I would like you to keep the
> warnings from my patches about other ways to execute/interpret code and
> the threat model (patch 1/6 and 5/6).

I don't intend it to conflict -- I wanted to have actual code written
out to share as a basis for discussion. I didn't want to talk about
"maybe we can try $foo", but rather "here's $foo; what do y'all think?"
:)

-- 
Kees Cook
