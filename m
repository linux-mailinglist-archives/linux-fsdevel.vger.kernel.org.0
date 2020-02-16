Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871D81604E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgBPQz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 11:55:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48536 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgBPQz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:55:57 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j3NCh-0001oq-38; Sun, 16 Feb 2020 16:55:35 +0000
Date:   Sun, 16 Feb 2020 17:55:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 04/28] fsuidgid: add fsid mapping helpers
Message-ID: <20200216165533.z2n2fjs3onlna526@wittgenstein>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
 <20200214183554.1133805-5-christian.brauner@ubuntu.com>
 <CAG48ez2o81ZwwL9muYyheN9vY69vJR5sB9LsLh=nk6wB4iuUgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2o81ZwwL9muYyheN9vY69vJR5sB9LsLh=nk6wB4iuUgw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:11:36PM +0100, Jann Horn wrote:
> On Fri, Feb 14, 2020 at 7:37 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > This adds a set of helpers to translate between kfsuid/kfsgid and their
> > userspace fsuid/fsgid counter parts relative to a given user namespace.
> >
> > - kuid_t make_kfsuid(struct user_namespace *from, uid_t fsuid)
> >   Maps a user-namespace fsuid pair into a kfsuid.
> >   If no fsuid mappings have been written it behaves identical to calling
> >   make_kuid(). This ensures backwards compatibility for workloads unaware
> >   or not in need of fsid mappings.
> [...]
> > +#ifdef CONFIG_USER_NS_FSID
> > +/**
> > + *     make_kfsuid - Map a user-namespace fsuid pair into a kuid.
> > + *     @ns:  User namespace that the fsuid is in
> > + *     @fsuid: User identifier
> > + *
> > + *     Maps a user-namespace fsuid pair into a kernel internal kfsuid,
> > + *     and returns that kfsuid.
> > + *
> > + *     When there is no mapping defined for the user-namespace kfsuid
> > + *     pair INVALID_UID is returned.  Callers are expected to test
> > + *     for and handle INVALID_UID being returned.  INVALID_UID
> > + *     may be tested for using uid_valid().
> > + */
> > +kuid_t make_kfsuid(struct user_namespace *ns, uid_t fsuid)
> > +{
> > +       unsigned extents = ns->fsuid_map.nr_extents;
> > +       smp_rmb();
> > +
> > +       /* Map the fsuid to a global kernel fsuid */
> > +       if (extents == 0)
> > +               return KUIDT_INIT(map_id_down(&ns->uid_map, fsuid));
> > +
> > +       return KUIDT_INIT(map_id_down(&ns->fsuid_map, fsuid));
> > +}
> > +EXPORT_SYMBOL(make_kfsuid);
> 
> What effect is this fallback going to have for nested namespaces?
> 
> Let's say we have an outer namespace N1 with this uid_map:
> 
>     0 100000 65535
> 
> and with this fsuid_map:
> 
>     0 300000 65535
> 
> Now from in there, a process that is not aware of the existence of
> fsuid mappings creates a new user namespace N2 with the following
> uid_map:
> 
>     0 1000 1
> 
> At this point, if a process in N2 does chown("foo", 0, 0), is that
> going to make "foo" owned by kuid 101000, which isn't even mapped in
> N1?

So Jann just made a clever suggestion that would solve this problem fsid
maps can only be written if the corresponding id mapping has been
written and fsid mappings will only have an effect once the
corresponding id mapping has been written. That sounds rather sane to
me.

Christian
