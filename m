Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F01F70E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 01:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFKXbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 19:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFKXbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:31:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D03C08C5C1;
        Thu, 11 Jun 2020 16:31:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so2941586plb.8;
        Thu, 11 Jun 2020 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=53niQxqahks3EKNdNU3JdcwDT5/fPF/bXLdvCKXBBLU=;
        b=cQBSeLaO39fs84L+DCF7EpMGoLq4AUFWvJrTHTKXio6daEkqS+rp1K6pEOm7t3tIx8
         i/g2el5SbhHHeGVCBEKrQ+1nymJjnvpcE81waFAIThUZ5oOOQ/uPVzreplkuIHSp8bxZ
         y5uKxabngYjUdfDvvC66FY+bRyfcx6AyjUQAr1vEGWqKO4bQSfQ6V5PJLiT3EgePVnAy
         Fqe2xTdjb8sdMpT1DvfJDthxyq3jv21fccco0e0FsY1fouFHUFRwAfk1RB4/LiXZ43JW
         RrlU6/PV4VOPkHKmkUReX2yTO0lqMF+ltJVHEE+JMZujbibg/Hu50ilDT0etsMEmMSJU
         p1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53niQxqahks3EKNdNU3JdcwDT5/fPF/bXLdvCKXBBLU=;
        b=oWC6Y9IrbRFvc++8nZdfKmGBkgWxlSWcy4iDGNoCjWo3XT+aCRJ01W/YmznMULFijt
         /Vqg33cbUq4UTyXIx8QDdW8uV0THL7/02X/baJY9b3RgreSxAnZOzNY9CXfWWF+krAlw
         VjKaohnuGjn4sPdNBwN1etq16J3IL6h4JL8751sbObJq5KyoQtZ3zyz1pP6n60b79wWK
         3BKf60i8CbMaO2Ro8TalQe2uGySSYbzkFB/Gx0KIk6ZR5jMUWJBqK+N2oldr1/aHR4Uv
         SxXn8t3NkvNM3uKsWAvYgmbOgBFHAVsJbl0tZSgtsToYf5M87C+PkUvgrqeYZDuJiU6x
         R2uA==
X-Gm-Message-State: AOAM533ZjQ0VV6N7u39+i0lIfsmxLURMlPBIaW0Dm8lNbkTRzgHkiSsU
        kEJ9kImKYhlt5beZ/xQzzwk=
X-Google-Smtp-Source: ABdhPJxmHS9QruoYsSu8Vwr0dt8xezQlGs8fL/ApDuOch0vBMhIPalUbjDCVFD6D25ayMBdlYjWJHA==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr8690412ply.139.1591918298382;
        Thu, 11 Jun 2020 16:31:38 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id u128sm4078947pfu.148.2020.06.11.16.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 16:31:37 -0700 (PDT)
Date:   Thu, 11 Jun 2020 16:31:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
References: <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <87r1uo2ejt.fsf@x220.int.ebiederm.org>
 <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
 <87d066vd4y.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d066vd4y.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:12:29PM -0500, Eric W. Biederman wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Tue, Jun 09, 2020 at 03:02:30PM -0500, Eric W. Biederman wrote:
> >> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >> 
> >> > bpf_lsm is that thing that needs to load and start acting early.
> >> > It's somewhat chicken and egg. fork_usermode_blob() will start a process
> >> > that will load and apply security policy to all further forks and
> >> > execs.
> >> 
> >> What is the timeframe for bpf_lsm patches wanting to use
> >> fork_usermode_blob()?
> >> 
> >> Are we possibly looking at something that will be ready for the next
> >> merge window?
> >
> > In bpf space there are these that want to use usermode_blobs:
> > 1. bpfilter itself.
> > First of all I think we made a mistake delaying landing the main patches:
> > https://lore.kernel.org/patchwork/patch/902785/
> > https://lore.kernel.org/patchwork/patch/902783/
> > without them bpfilter is indeed dead. That probably was the reason
> > no one was brave enough to continue working on it.
> > So I think the landed skeleton of bpfilter can be removed.
> > I think no user space code will notice that include/uapi/linux/bpfilter.h
> > is gone. So it won't be considered as user space breakage.
> > Similarly CONFIG_BPFILTER can be nuked too.
> > bpftool is checking for it (see tools/bpf/bpftool/feature.c)
> > but it's fine to remove it.
> > I still think that the approach taken was a correct one, but
> > lifting that project off the ground was too much for three of us.
> > So when it's staffed appropriately we can re-add that code.
> >
> > 2. bpf_lsm.
> > It's very active at the moment. I'm working on it as well
> > (sleepable progs is targeting that), but I'm not sure when folks
> > would have to have it during the boot. So far it sounds that
> > they're addressing more critical needs first. "bpf_lsm ready at boot"
> > came up several times during "bpf office hours" conference calls,
> > so it's certainly on the radar. If I to guess I don't think
> > bpf_lsm will use usermode_blobs in the next 6 weeks.
> > More likely 2-4 month.
> >
> > 3. bpf iterator.
> > It's already capable extension of several things in /proc.
> > See https://lore.kernel.org/bpf/20200509175921.2477493-1-yhs@fb.com/
> > Cat-ing bpf program as "cat /sys/fs/bpf/my_ipv6_route"
> > will produce the same human output as "cat /proc/net/ipv6_route".
> > The key difference is that bpf is all tracing based and it's unstable.
> > struct fib6_info can change and prog will stop loading.
> > There are few FIXME in there. That is being addressed right now.
> > After that the next step is to make cat-able progs available
> > right after boot via usermode_blobs.
> > Unlike cases 1 and 2 here we don't care that they appear before pid 1.
> > They can certainly be chef installed and started as services.
> > But they are kernel dependent, so deploying them to production
> > is much more complicated when they're done as separate rpm.
> > Testing is harder and so on. Operational issues pile up when something
> > that almost like kernel module is done as a separate package.
> > Hence usermode_blob fits the best.
> > Of course we were not planning to add a bunch of them to kernel tree.
> > The idea was to add only _one_ such cat-able bpf prog and have it as
> > a selftest for usermode_blob + bpf_iter. What we want our users to
> > see in 'cat my_ipv6_route' is probably different from other companies.
> > These patches will likely be using usermode_blob() in the next month.
> >
> > But we don't need to wait. We can make the progress right now.
> > How about we remove bpfilter uapi and rename net/bpfilter/bpfilter_kern.c
> > into net/umb/umb_test.c only to exercise Makefile to build elf file
> > from simple main.c including .S with incbin trick
> > and kernel side that does fork_usermode_blob().
> > And that's it.
> > net/ipv4/bpfilter/sockopt.c and kconfig can be removed.
> > That would be enough base to do use cases 2 and 3 above.
> > Having such selftest will be enough to adjust the layering
> > for fork_usermode_blob(), right?
> 
> If I understand correctly you are asking people to support out of tree
> code.  I see some justification for this functionality for in-tree code.
> For out of tree code there really is no way to understand support or
> maintain the code.

It's just like saying that sys_finit_module() is there to support out
of tree code. There are in- and out- tree modules and there will be
in- and out- of tree bpf programs, but the focus is on those that
are relevant for the long term future of the kernel.
The 1 case above is in-tree only. There is nothing in bpfilter
that makes sense out of tree.
The 2 case (bpf_lsm) is primarily in-tree. Security is something
everyone wants its own way, but majority of bpf_lsm functionality
should live in-tree.
The 3 case is mostly out-of-tree. If there was obvious way to
extend /proc it could have been in-tree, but no one will agree.

> We probably also need to have a conversation about why this
> functionality is a better choice that using a compiled in initramfs,
> such as can be had by setting CONFIG_INITRAMFS_SOURCE.

I explained it several times already. I don't see how initramfs solves 1 and 2.

> Even with this write up and the conversations so far I don't understand
> what problem fork_usermode_blob is supposed to be solving.  Is there
> anything kernel version dependent about bpf_lsm?  For me the primary
> justification of something like fork_usermode_blob is something that is
> for all practical purposes a kernel module but it just happens to run in
> usermode.

that's what it is. It's a kernel module that runs in user space.

> From what little I know about bpf_lsm that isn't the case.  So far all

It is.

> you have mentioned is that bpf_lsm needs to load early.  That seems like
> something that could be solved by a couple of lines init/main.c that
> forks and exec's a program before init if it is present.  Maybe that
> also needs a bit of protection so the bootloader can't override the
> binary.
> 
> The entire concept of a loadable lsm has me scratching my head.  Last
> time that concept was seriously looked at the races for initializing per
> object data were difficult enough to deal with modular support was
> removed from all of the existing lsms.

I'm not sure what races you're talking about.
usermode_blob will interact with kernel via syscalls and other standard
communication mechanism.

> Not to mention there are places where the lsm hooks are a pretty lousy
> API and will be refactored to make things better with no thought of any
> out of tree code.

I don't see how refactoring LSM hooks is relevant in this discussion.

> 
> > If I understood you correctly you want to replace pid_t
> > in 'struct umh_info' with proper 'struct pid' pointer that
> > is refcounted, so user process's exit is clean? What else?
> 
> No "if (filename)" or "if (file)" on the exec code paths.  No extra case
> for the LSM's to have to deal with.  Nothing fork_usermode_blob does is
> something that can't be done from userspace as far as execve is
> concerned so there is no justification for any special cases in the core
> of the exec code.

Adding getname_kernel() instead of filename==NULL is trivial enough
and makes sense as a cleanup.
But where do you see 'if (file)' ?
The correct 'file' pointer is passed from shmem_kernel_file_setup() all
the way to exec.

> Getting the deny_write_count and the reference count correct on the file
> argument as well as getting BPRM_FLAGS_PATH_INACCESSIBLE set.

There is no fd because there is no task, but there is a file. I think 
do_execve should assume BINPRM_FLAGS_PATH_INACCESSIBLE in this case.

> Using the proper type for argv and envp.

I guess that's going to be a part of other cleanup.

> Those are the things I know of that need to be addressed.
> 
> 
> Getting the code refactored so that the do_open_execat can be called
> in do_execveat_common instead of __do_execve_file is enough of a
> challenge of code motion I really would rather not do that.   Unfortunately that is
> the only way I can see right now to have both do_execveat_common and
> do_execve_file pass in a struct file.

The 'struct file' is there. Please take another look at the code.

> Calling deny_write_access and get_file in do_execve_file and probably
> a bit more is the only way I can see to cleanly isoloate the special
> cases fork_usermode_blob brings to the table.
> 
> 
> Strictly speaking I am also aware of the issue that the kernel has to
> use set_fs(KERNEL_DS) to allow argv and envp to exist in kernel space
> instead of userspace.  That needs to be fixed as well, but for all
> kernel uses of exec.  So any work fixing fork_usermode_blob can ignore
> that issue.

well, this is the problem of usermodehelper_exec.
usermode_blob doesn't use argv/envp.
They could be NULL for all practical purpose.
