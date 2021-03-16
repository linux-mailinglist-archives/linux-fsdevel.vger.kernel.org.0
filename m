Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB533DD61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbhCPTY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbhCPTYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:24:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD508C06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a8so10914513plp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=a1ue4t11OJbVivGpc6C3VCzhlUkhH8Mj6uX3JQk/WHc=;
        b=Nj8yYDluxqiAG+ej6jhoWTmPa96bXO9MvDia/puQbLS7/lpPxALfueZIRNjkZiCYCy
         Ljgk8A2MGIt5sqxHhcmGFj9bwRx66ATTPVkIOCfXJarh9XeLaTErjE/lVX2YPbMfkUTR
         weLoWOS0x3zLp07rZcrp0BhN98BIhcxt1Cq+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a1ue4t11OJbVivGpc6C3VCzhlUkhH8Mj6uX3JQk/WHc=;
        b=E8TUy6aYCu7Z/rkSuwRwShogUUGp5+Mz+GhWllC5a/HljmoGyLoba3hZu+RRMuQaDg
         fWhJDPXQFx5cAjq1KjNwLDZu2cFaS83DIwHq/x9u+IFgQlGFEI7qAdi0A7bhRRZAuVIa
         U6eZhbOa+PgcSqES5lDeq2/EPPF5U7DrqABJrfPzvapIWvQG1I0LDCC79cAYMQMrRqlr
         /0ONGUY+x7dolzhlrgfepJRogTKjRUHWsDbPKOg1qSE0Gj+g1JeHwlx+DgmSk8knY4XW
         CNtWvnX51Jt3oU21AQ71527fKbaS9uGxfSnVbQm/7NHKftywHYrSgKgyq+1PxQIwhxeK
         LxfA==
X-Gm-Message-State: AOAM532J+wIkL0Ru8J4pJSCeh391EOfAW6jBBkNHnJxzqSFUISIv4KRF
        OOb4NzGyEkUGXQ8x8VfDUSOZ5A==
X-Google-Smtp-Source: ABdhPJxdA7UfbYsvEPf38xgnGsO41RyHj+iYp3b8oYOJD+h6SmdhD+HE5h/MgGyUxrpMOZysl7Shew==
X-Received: by 2002:a17:90a:b115:: with SMTP id z21mr594754pjq.162.1615922649291;
        Tue, 16 Mar 2021 12:24:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm191065pjt.10.2021.03.16.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:24:08 -0700 (PDT)
Date:   Tue, 16 Mar 2021 12:24:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v4 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Message-ID: <202103161221.8291CC3E6@keescook>
References: <20210316170135.226381-1-mic@digikod.net>
 <20210316170135.226381-2-mic@digikod.net>
 <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3=M-5WT73HqmFJr6UHwO0+2FJXxcAgRzp6wcd0P3TN=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:04:09PM +0100, Jann Horn wrote:
> On Tue, Mar 16, 2021 at 6:02 PM Mickaël Salaün <mic@digikod.net> wrote:
> > One could argue that chroot(2) is useless without a properly populated
> > root hierarchy (i.e. without /dev and /proc).  However, there are
> > multiple use cases that don't require the chrooting process to create
> > file hierarchies with special files nor mount points, e.g.:
> > * A process sandboxing itself, once all its libraries are loaded, may
> >   not need files other than regular files, or even no file at all.
> > * Some pre-populated root hierarchies could be used to chroot into,
> >   provided for instance by development environments or tailored
> >   distributions.
> > * Processes executed in a chroot may not require access to these special
> >   files (e.g. with minimal runtimes, or by emulating some special files
> >   with a LD_PRELOADed library or seccomp).
> >
> > Unprivileged chroot is especially interesting for userspace developers
> > wishing to harden their applications.  For instance, chroot(2) and Yama
> > enable to build a capability-based security (i.e. remove filesystem
> > ambient accesses) by calling chroot/chdir with an empty directory and
> > accessing data through dedicated file descriptors obtained with
> > openat2(2) and RESOLVE_BENEATH/RESOLVE_IN_ROOT/RESOLVE_NO_MAGICLINKS.
> 
> I don't entirely understand. Are you writing this with the assumption
> that a future change will make it possible to set these RESOLVE flags
> process-wide, or something like that?

I thought it meant "open all out-of-chroot dirs as fds using RESOLVE_...
flags then chroot". As in, there's no way to then escape "up" for the
old opens, and the new opens stay in the chroot.

> [...]
> > diff --git a/fs/open.c b/fs/open.c
> [...]
> > +static inline int current_chroot_allowed(void)
> > +{
> > +       /*
> > +        * Changing the root directory for the calling task (and its future
> > +        * children) requires that this task has CAP_SYS_CHROOT in its
> > +        * namespace, or be running with no_new_privs and not sharing its
> > +        * fs_struct and not escaping its current root (cf. create_user_ns()).
> > +        * As for seccomp, checking no_new_privs avoids scenarios where
> > +        * unprivileged tasks can affect the behavior of privileged children.
> > +        */
> > +       if (task_no_new_privs(current) && current->fs->users == 1 &&
> 
> this read of current->fs->users should be using READ_ONCE()

Ah yeah, good call. I should remember this when I think "can this race?"
:P

-- 
Kees Cook
