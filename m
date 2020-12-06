Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839DC2D0787
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 23:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgLFWGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLFWGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:06:23 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2581C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 14:05:42 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so12917755ljo.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYOh6UMvSpP9mpiuIeBGwJObn/ShTIBfx66r2r2mm1Q=;
        b=TAWEe2AJ21/ymnfEhRmgmu7yS9XHy518Q0Mm5DQLt3/4L7ngyEHQB42xDYoOvsFn4E
         2MSnx6QdhRf7wJVUsTk/bWruWfa9rYv16INpIYLjxSfPSmXd5ruwjlT5RArGqoUIIa+q
         nNUnf+1/NTNa3lit9cpVAAQfP1CZsocHbYWCdws/zUzNr3+1jjAcmwNes9M5HF/qO9K8
         Y/PeHJEEFG8cWzsP4a2lxjNWPCDA58LflNFsS9LYRdm5IGqS9y3I/PygPG3CCIasyZhH
         IJ0uCHVuvVGVzLcBLLNU4fxbq9xMqo1VQee4uVS2Ip+zbbY54Tl0nl8V1MEkvCdCRHMc
         I8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYOh6UMvSpP9mpiuIeBGwJObn/ShTIBfx66r2r2mm1Q=;
        b=b2OPnhE6Sc/JuZkYuL8NfqufJ35fEjijuraE/OAkqeEem29TxGTNDyCvWkFTiov4wt
         olShRG9KdikawaFy1qA8yf/jGuDJYGSeHatwVi9gKF1GdvN9KPd7FJtm8SiFJ8JwjjvB
         OpTYqcX5E4LAOVsSd9w2JRTbnnwzQZk740rru6eKBGNqgOMrmHcKmIyB5P3BYtNKnxVI
         jjOe2h3h0XnfCdc+liaMsnpXumdxVCPiTi2fq/9Dfw/c8D9oN9rhs1EVo7LmvpApP7Vd
         FFaaJ1YN3W4eUAkgi3OCSIUoaTnaDa4HsqfzAbZrPhGsNP0Yrj6yu8aL+9He151nf5B+
         ZglQ==
X-Gm-Message-State: AOAM530z2en/300qxqzsUP7Zc4dsxSUjjwN07M9/FHLu1jPCv2WnurOK
        zAxzQMXMmnb1xVs+XFjzcLmeFaHwhTJ3sVntHuwVqQ==
X-Google-Smtp-Source: ABdhPJzMyGRuC+Bc1bPrBXnAz61CoiHtimGEqIGvA/y8Fk53fi5E7rQbPAV55C71yQzmhgVm+doW7FJaRfoD34AL6J0=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr7564877ljg.138.1607292340737;
 Sun, 06 Dec 2020 14:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20201206131036.3780898-1-vladimir.kondratiev@intel.com> <16d6fdae-74ac-774c-9193-130dcfc5bc6c@intel.com>
In-Reply-To: <16d6fdae-74ac-774c-9193-130dcfc5bc6c@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 6 Dec 2020 23:05:14 +0100
Message-ID: <CAG48ez0a+=i5ue+p+snwF6YZaCQkzvYVOACcjHz7E9=uUibbcA@mail.gmail.com>
Subject: Re: [NEEDS-REVIEW] [PATCH] do_exit(): panic() when double fault detected
To:     Dave Hansen <dave.hansen@intel.com>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        chenqiwu <chenqiwu@xiaomi.com>, Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 6, 2020 at 4:37 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 12/6/20 5:10 AM, Vladimir Kondratiev wrote:
> > Double fault detected in do_exit() is symptom of integrity
> > compromised. For safety critical systems, it may be better to
> > panic() in this case to minimize risk.
>
> Does this fix a real problem that you have observed in practice?
>
> Or, is this a general "hardening" which you think is a good practice?
>
> What does this have to do specifically with safety critical systems?
>
> The kernel generally tries to fix things up and keep running whenever
> possible, if for no other reason than it helps debug problems.  If that
> is an undesirable property for your systems, then I think you have a
> much bigger problem than faults during exit().
>
> This option, "panic_on_double_fault", doesn't actually panic on all
> double-faults, which means to me that it's dangerously named.

I wonder whether part of the idea here is that normally, when the
kernel fixes up a kernel crash by killing the offending task, a
service management process in userspace (e.g. the init daemon) can
potentially detect this case because it looks as if the task died with
SIGBUS or something. (I don't think that actually always works in
practice though, since AFAICS kernel crashes only lead to the *task*
being killed, not the entire process, and I think killing a single
worker thread of a multithreaded process might just cause the rest of
the userspace process to lock up. Not sure whether that's intentional
or something that should ideally be changed.)

But if the kernel gives up on going through with do_exit() (because it
crashed in do_exit() before being able to mark the task as waitable),
the process may, to userspace, appear to still be alive even though
it's not actually doing anything anymore; and if the kernel doesn't
tell userspace that the process is no longer functional, userspace
can't restore the system to a working state.

But as Dave said, this best-effort fixup is probably not the kind of
behavior you'd want in a "safety critical" system anyway; for example,
often the offending thread will have held some critical spinlock or
mutex or something, and then the rest of the system piles on into a
gigantic deadlock involving the lock in question and possibly multiple
locks that nest around it. You might be better off enabling
panic_on_oops, ideally with something like pstore-based logging of the
crash, and then quickly bringing everything back to a clean state
instead of continuing from an unstable state and then possibly
blocking somewhere.
