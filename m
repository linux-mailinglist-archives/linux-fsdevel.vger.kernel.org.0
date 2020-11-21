Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300E02BBDB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 08:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKUHBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 02:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgKUHBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 02:01:35 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F6DC061A4B
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 23:01:35 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so16652092lfr.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2020 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3f33ZbSviSsNDuxIsWsq/8c0yuXyzvCPrqPtP0RGi80=;
        b=QTrvEtnWrrcbOEs5U2zsXrELZY0joXKYt35ttFIfE3ljFGqVTsE2HaDPetDIzNV0Z+
         SNm0nIBKP392yJ/12exSP2lHAsN3IW99XL9OvKJShdVvhx6hWk5FMgqMLPmf5TLsXGFG
         +iHnXGnR267ovUqsrTD7TknzGTTVMN0JBhDcMHYa6hy9vumiKnlHEoByxwYUqFCeOJcH
         8ci6aX3IWWZAS35E7ZUq2QiVC5E+16bSvaDHHgcz3hRf5R5Sqdh41qyVdf7c65t3ii9K
         kE9FBm0MLZ2YAKu0t3JfnrIMbZ8lpvjGGU8/1aoQSH1X5Qz/sPTU1Mx00P4k2W69USLS
         xiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3f33ZbSviSsNDuxIsWsq/8c0yuXyzvCPrqPtP0RGi80=;
        b=QR6dtys3MmO5yv3cj1+pPVTV0F0w3LJ+i549JeHMqijhA3aarco6juxCLCbuo53lkX
         jIgKcVrZM+UhZ7DVuvcvcdFbgUouEVmIwHxyh4pJjWvFoD+/bv5xCttEGL+gTtNU/gxe
         uVHpmRwRFNHM19OyhlB6k7l1j1Quou9O6LhV6KOTu4b79C2CPFwdcIZ3BZZciiMAdW2z
         HGsSMwQT/H0q6v74uctFU8JVK/MhfI0bWCvdtERbEjdGXpq7izRTFlYsbHse1zv1Ehnj
         895F66IIoi91ZVn3bNNbqVMj+N91+iziSDTrwuAvtOxgGXT5Sa1akKEIzT6EmY0u7lDK
         S4TA==
X-Gm-Message-State: AOAM530cL7rR2huzoIea2P8T2Cu07IlzY2v+Qj4hDgyyXAXmvmJ5sha4
        ON+9otyK3xzxRi/waohR/Jy94vNZ4+evO9XTRCIK/g==
X-Google-Smtp-Source: ABdhPJyH6REifnL9YUZNnFhyFBr7a5RSsJd6XuGMTDWn4PlB6riGiZRNf+nR+kcYWzMs0Zs7hbAeG+15z4SfiIciuC8=
X-Received: by 2002:a19:4b48:: with SMTP id y69mr9985268lfa.576.1605942093292;
 Fri, 20 Nov 2020 23:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20201112205141.775752-1-mic@digikod.net> <20201112205141.775752-3-mic@digikod.net>
In-Reply-To: <20201112205141.775752-3-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 08:00:00 +0100
Message-ID: <CAG48ez2RE6S7jKQY3iyoNRM5vV67W4S7OwJ0gmNGy+MB8F56vg@mail.gmail.com>
Subject: Re: [PATCH v24 02/12] landlock: Add ruleset and domain management
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 9:51 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> A Landlock ruleset is mainly a red-black tree with Landlock rules as
> nodes.  This enables quick update and lookup to match a requested
> access, e.g. to a file.  A ruleset is usable through a dedicated file
> descriptor (cf. following commit implementing syscalls) which enables a
> process to create and populate a ruleset with new rules.
>
> A domain is a ruleset tied to a set of processes.  This group of rules
> defines the security policy enforced on these processes and their future
> children.  A domain can transition to a new domain which is the
> intersection of all its constraints and those of a ruleset provided by
> the current process.  This modification only impact the current process.
> This means that a process can only gain more constraints (i.e. lose
> accesses) over time.
>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> ---
>
> Changes since v23:
> * Always intersect access rights.  Following the filesystem change
>   logic, make ruleset updates more consistent by always intersecting
>   access rights (boolean AND) instead of combining them (boolean OR) for
>   the same layer.

This seems wrong to me. If some software e.g. builds a policy that
allows it to execute specific libraries and to open input files
specified on the command line, and the user then specifies a library
as an input file, this change will make that fail unless the software
explicitly deduplicates the rules.
Userspace will be forced to add extra complexity to work around this.

>   This defensive approach could also help avoid user
>   space to inadvertently allow multiple access rights for the same
>   object (e.g.  write and execute access on a path hierarchy) instead of
>   dealing with such inconsistency.  This can happen when there is no
>   deduplication of objects (e.g. paths and underlying inodes) whereas
>   they get different access rights with landlock_add_rule(2).

I don't see why that's an issue. If userspace wants to be able to
access the same object in different ways for different purposes, it
should be able to do that, no?

I liked the semantics from the previous version.
