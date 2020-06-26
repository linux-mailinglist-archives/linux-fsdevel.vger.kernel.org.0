Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C98C20ABE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 07:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgFZFln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZFlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:41:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6233AC08C5C1;
        Thu, 25 Jun 2020 22:41:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so3860374plo.7;
        Thu, 25 Jun 2020 22:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lTU5RxZlw9EIdbm5Ab2jgsTpj+Wc9/GQtGH0O0TVDuU=;
        b=c+Fiu5kLiBtFFvq4WH0MbfxaDLLi0MjB39efcKDE7nwMBvF9QGfJ4QpEVz03Uk5iSS
         vvHR2OCt9VLWPR9feXAkDJb9QDotRSJO7akrcRdgdq95qymWPEmI7PQQp82Q7h9GcchM
         aRskRGSOfgwHTwmuvLFrlyiOLI5LnFZ54DGiwoKBdEpQZMa5xWVX8FxxMH6k9vc2Z/d/
         dbnsPNQRchnOCcr4QbsmOmasABOSdazhOi+Me3Qj46Ap90kcNlR1MtZLDYVv+6yzxO4a
         tUCbC8q5sDrroQDojHYPStRPfdQ41eboE7AvzZ+ZgpTBsTiBstePdN2kfqhhDJlZwx0m
         D55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lTU5RxZlw9EIdbm5Ab2jgsTpj+Wc9/GQtGH0O0TVDuU=;
        b=RbTV46IVGAkXf17U/3gy0ujpOtxg6IczWuRnmWjf1ocOFR9Cg8LxJiwhVtcpO2p4QE
         aRvfJqD77J88oT9Se75rcEIz0C4Es1jXrxwvmocnZ0/iB4eovSX17/ZKBeqg1hJWlE8z
         k6OZ46rlPHuS4nOb45koKXObiSTjXOf6eRc3q5hHGw+xkkdpA8hoTopplkk87DbBmpwV
         2GU8RLCohA4GnN10CV1+o34FHQnw+TgWdHvM+IzfwvDOUProgUfkawj7U5HIrar8yqYa
         OpZY4mqcfbhdSRVniMwL1gL0H4U/OHmqF/U52bxTHTF68b6mIEoNJffv6AzzCOpSZpRG
         LNFg==
X-Gm-Message-State: AOAM531foa6Zni7jEWZRhmUZqLf4kI0ijsMXXJhgKN4Spo9eTBOTD4J5
        S17JnAfzuBndDGWdJAyiWBU=
X-Google-Smtp-Source: ABdhPJxRhtaYOkNCmfev9wJGmuPQcApvTJFDA4Igpsl6AQsBbNWdkwIRAPOD8X2ousk7ndZjg5uWeA==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr1185866pln.153.1593150101589;
        Thu, 25 Jun 2020 22:41:41 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:986f])
        by smtp.gmail.com with ESMTPSA id lt14sm9727117pjb.52.2020.06.25.22.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 22:41:40 -0700 (PDT)
Date:   Thu, 25 Jun 2020 22:41:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200626054137.m44jpsvlapuyslzw@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <20200626015121.qpxkdaqtsywe3zqx@ast-mbp.dhcp.thefacebook.com>
 <eb3bec08-9de4-c708-fb8e-b6a47145eb5e@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb3bec08-9de4-c708-fb8e-b6a47145eb5e@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:58:35PM +0900, Tetsuo Handa wrote:
> On 2020/06/26 10:51, Alexei Starovoitov wrote:
> > On Thu, Jun 25, 2020 at 06:36:34PM -0700, Linus Torvalds wrote:
> >> On Thu, Jun 25, 2020 at 12:34 PM David Miller <davem@davemloft.net> wrote:
> >>>
> >>> It's kernel code executing in userspace.  If you don't trust the
> >>> signed code you don't trust the signed code.
> >>>
> >>> Nothing is magic about a piece of code executing in userspace.
> >>
> >> Well, there's one real issue: the most likely thing that code is going
> >> to do is execute llvm to generate more code.
> 
> Wow! Are we going to allow execution of such complicated programs?

No. llvm was _never_ intended to be run from the blob.
bpfilter was envisioned as self contained binary. If it needed to do
optimizations on generated bpf code it would have to do them internally.

> I was hoping that fork_usermode_blob() accepts only simple program
> like the content of "hello64" generated by

pretty much. statically compiled elf that is self contained.

> For example, a usermode process started by fork_usermode_blob() which was initially
> containing
> 
> ----------
> while (read(0, &uid, sizeof(uid)) == sizeof(uid)) {
>     if (uid == 0)
>         write(1, "OK\n", 3);
>     else
>         write(1, "NG\n", 3);
> }
> ----------
> 
> can be somehow tampered like
> 
> ----------
> while (read(0, &uid, sizeof(uid)) == sizeof(uid)) {
>     if (uid != 0)
>         write(1, "OK\n", 3);
>     else
>         write(1, "NG\n", 3);
> }
> ----------
> 
> due to interference from the rest of the system, how can we say "we trust kernel
> code executing in userspace" ?

I answered this already in the previous email.
Use security_ptrace_access_check() LSM hook to make sure that no other process
can tamper with blob's memory when it's running as user process.
In the future it would be trivial to add a new ptrace flag to
make sure that blob's memory is not ptraceable from the start.

> My question is: how is the byte array (which was copied from kernel space) kept secure/intact
> under "root can poke into kernel or any process memory." environment? It is obvious that
> we can't say "we trust kernel code executing in userspace" without some mechanism.

Already answered.

> Currently fork_usermode_blob() is not providing security context for the byte array to be
> executed. We could modify fork_usermode_blob() to provide security context for LSMs, but
> I'll be more happy if we can implement that mechanism without counting on in-tree LSMs, for
> SELinux is too complicated to support.

I'm pretty sure it was answered in the upthread by selinux folks.
Quick recap: we can add security labels, sha, strings, you_name_it to the blob that
lsm hooks can track.
We can also add another LSM hook to fork_usermode_blob(), so if tomoyo is so worried
about blobs it would be able to reject all of them without too much work.

> 
> > I think that's Tetsuo's point about lack of LSM hooks is kernel_sock_shutdown().
> > Obviously, kernel_sock_shutdown() can be called by kernel only.
> 
> I can't catch what you mean. The kernel code executing in userspace uses syscall
> interface (e.g. SYSCALL_DEFINE2(shutdown, int, fd, int, how) path), doesn't it?

yes.

> > I suspect he's imaging a hypothetical situation where kernel bits of kernel module
> > interact with userblob bits of kernel module.
> > Then another root process tampers with memory of userblob.
> 
> Yes, how to protect the memory of userblob is a concern. The memory of userblob can
> interfere (or can be interfered by) the rest of the system is a problem.

answered.

> > I think this is trivially enforceable without creating new features.
> > Existing security_ptrace_access_check() LSM hook can prevent tampering with
> > memory of userblob.
> 
> There is security_ptrace_access_check() LSM hook, but no zero-configuration
> method is available.

huh?
tomoyo is not using that hook, but selinux and many other LSMs do.
please learn from others.

> > security label can carry that execution context.
> 
> If files get a chance to be associated with appropriate pathname and
> security label.

I can easily add a fake pathname to the blob, but it won't help tomoyo.
That's what I was saying all along.
pathname based security provides false sense of security.

I'm pretty sure this old blog has been read by many folks who
are following this thread, but it's worth reminding again:
https://securityblog.org/2006/04/19/security-anti-pattern-path-based-access-control/
I cannot agree more with Joshua.
Here is a quote:
"The most obvious problem with this is that not all objects are files and thus do not have paths."

> >> My personally strongest argument for remoiving this kernel code is
> >> that it's been there for a couple of years now, and it has never
> >> actually done anything useful, and there's no actual sign that it ever
> >> will, or that there is a solid plan in place for it.
> > 
> > you probably missed the detailed plan:
> > https://lore.kernel.org/bpf/20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com/
> > 
> > The project #3 is the above is the one we're working on right now.
> > It should be ready to post in a week.
> 
> I got a question on project #3. Given that "cat /sys/fs/bpf/my_ipv6_route"
> produces the same human output as "cat /proc/net/ipv6_route", how security
> checks which are done for "cat /proc/net/ipv6_route" can be enforced for
> "cat /sys/fs/bpf/my_ipv6_route" ? Unless same security checks (e.g. permission
> to read /proc/net/ipv6_route ) is enforced, such bpf usage sounds like a method
> for bypassing existing security mechanisms.

Standard file permissions. Nothing to do with bpf.
