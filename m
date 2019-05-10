Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 657561A46F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 23:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEJVUk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 17:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:32844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEJVUj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 17:20:39 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E28FA21841
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557523238;
        bh=eVSDLxFRJtNqvSdy6nzYE0dpoYEOh2L4bbdtCHYcgX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0fS3cTmHczG1ssOc5teJdrM/TgWQ6nVTFhgCqAq8ASGKhIkMVg92wafAOLYiI3MWl
         INOHmViBS9cNEKaDJzcRJl2lEH3LwAKUHnacjQ8LBm+I8aoDSG2JbRqJtx70KX/w7K
         pTHZRqYnAaT5e2/zJ0Nn7aMXre7H8IOi3HsAkp+Y=
Received: by mail-wm1-f46.google.com with SMTP id n25so8670396wmk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 14:20:37 -0700 (PDT)
X-Gm-Message-State: APjAAAW9zCwJ3948rs7nkxtA6ZrIHri3EWvrJ48uI0N3NrnwO/Wr17rC
        tSC3aMAJRzINgTP0u8N2gal7yLhI6kvpExnm6BxIPA==
X-Google-Smtp-Source: APXvYqxmLWOSJzfnM1hN1P+7VEpgHvDb4cHKF5KSb97t7Bb1E5U/runa9boZbrE+HP301qSI8wrEMedzUhCobT/8uJY=
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr8095092wmj.107.1557523234745;
 Fri, 10 May 2019 14:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
In-Reply-To: <20190510204141.GB253532@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 10 May 2019 14:20:23 -0700
X-Gmail-Original-Message-ID: <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
Message-ID: <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Jann Horn <jannh@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 1:41 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, May 07, 2019 at 05:17:35AM +1000, Aleksa Sarai wrote:
> > On 2019-05-06, Jann Horn <jannh@google.com> wrote:
> > > In my opinion, CVE-2019-5736 points out two different problems:
> > >
> > > The big problem: The __ptrace_may_access() logic has a special-case
> > > short-circuit for "introspection" that you can't opt out of; this
> > > makes it possible to open things in procfs that are related to the
> > > current process even if the credentials of the process wouldn't permit
> > > accessing another process like it. I think the proper fix to deal with
> > > this would be to add a prctl() flag for "set whether introspection is
> > > allowed for this process", and if userspace has manually un-set that
> > > flag, any introspection special-case logic would be skipped.
> >
> > We could do PR_SET_DUMPABLE=3 for this, I guess?
>
> Hmm... I'd make it a new prctl() command, since introspection is
> somewhat orthogonal to dumpability. Also, dumpability is per-mm, and I
> think the introspection flag should be per-thread.

I've lost track of the context here, but it seems to me that
mitigating attacks involving accidental following of /proc links
shouldn't depend on dumpability.  What's the actual problem this is
trying to solve again?
