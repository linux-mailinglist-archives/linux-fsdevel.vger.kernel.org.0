Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F472EC8DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbhAGDJL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbhAGDJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:09:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F591C0612F3
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 19:08:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r5so6278270eda.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 19:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wszMA77g4rkAzda5NnDRLoVKFBxWJonjIWdOwjgn+kc=;
        b=FMdvxIT9BIQB3ceg24vI0A6nt9XWJUbDt4ADfKbXNXlIc8+rpsppokAQtPldxOXBhL
         TqH7HKRBeqZoxftlvBgBck+/wClLVb61JUjXvJ/BnecoBfjhdr3U+ePYKkiV91wVMNt1
         FAAxEO9zdwGGYtiMCAiqr4FHhk1T2i7/cxovVBEEjzgSVag5zXO2IJSJ/r2T+CQEyWTW
         7HrFaV5n+PBazmh/BRr0byz9nw30qvWCJePz0OG8lx/KoDeoiJic94IN0SegvDQVIkUH
         KrFKgIvuFBxENpTUzGp8t3BlDn6DRLHfZ8Ym2nOF9uFvnbgheqbrIavAOUo69SZp8ASM
         la7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wszMA77g4rkAzda5NnDRLoVKFBxWJonjIWdOwjgn+kc=;
        b=sgNJiOsB2MoyNo1JvBrJCHlGWOHz+CSUGbFRTxczygKcDWdSBYPfUTVhQtOeuT/mvG
         58k39HtiVZiHJyPDAsCeRHq9ppHYpELH4F+NN5byWViph3jI7CgorfY3ZU/DqvihfJNb
         DX5TGawK8xZ6cilBgHQ+t7i90ne6uoXxpDmn0Pl3zH+1cPbJYcV6+cUCq3MTsHqIUffb
         8LqWVzvQfutWrkNvz0oQJcb+KdObOpFtd/icprcVPOCmTC8JhcT6zgov3QaCpIXQa1Uj
         UYJ+E3CFUrzaSscngFB0oK2UzE9leOFLajt2ltbpruZyw2GPnwFfAO30w15RLO9z4Hq3
         cfmA==
X-Gm-Message-State: AOAM533KXYXN+OmfoYId/CB8E9hGebdNmVvzmf5TGZQe8bY7MMCgnlL4
        24xuGOj/HdhFtgaWCf0cjri+RiLdaWZnDBg3OJM0
X-Google-Smtp-Source: ABdhPJwbPcMUXvCDqoq1//tWbym4M7BDR4jwDkslBeDZnJaZiKtcepOwWJPg2O/6NWanRIPEd4xbTQWT+K8aluV5/oA=
X-Received: by 2002:aa7:c0d6:: with SMTP id j22mr80950edp.31.1609988905108;
 Wed, 06 Jan 2021 19:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-3-lokeshgidra@google.com> <CAHC9VhScpFVtxzU_nUDUc4zGT7+EZKFRpYAm+Ps5vd2AjKkaMQ@mail.gmail.com>
 <CA+EESO7nFwaeSA2xC_FH=O6MtCuORcHPrihwRdt9ecWWLgkBsg@mail.gmail.com>
In-Reply-To: <CA+EESO7nFwaeSA2xC_FH=O6MtCuORcHPrihwRdt9ecWWLgkBsg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Jan 2021 22:08:13 -0500
Message-ID: <CAHC9VhRm-JR2Tt2NQdsVMo2oQZR=KtHkSnJj+GmRvkcF9GqK4w@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] fs: add LSM-supporting anon-inode interface
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 9:44 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Wed, Jan 6, 2021 at 6:10 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > From: Daniel Colascione <dancol@google.com>
> > >
> > > This change adds a new function, anon_inode_getfd_secure, that creates
> > > anonymous-node file with individual non-S_PRIVATE inode to which security
> > > modules can apply policy. Existing callers continue using the original
> > > singleton-inode kind of anonymous-inode file. We can transition anonymous
> > > inode users to the new kind of anonymous inode in individual patches for
> > > the sake of bisection and review.
> > >
> > > The new function accepts an optional context_inode parameter that callers
> > > can use to provide additional contextual information to security modules.
> > > For example, in case of userfaultfd, the created inode is a 'logical child'
> > > of the context_inode (userfaultfd inode of the parent process) in the sense
> > > that it provides the security context required during creation of the child
> > > process' userfaultfd inode.
> > >
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > >
> > > [Delete obsolete comments to alloc_anon_inode()]
> > > [Add context_inode description in comments to anon_inode_getfd_secure()]
> > > [Remove definition of anon_inode_getfile_secure() as there are no callers]
> > > [Make __anon_inode_getfile() static]
> > > [Use correct error cast in __anon_inode_getfile()]
> > > [Fix error handling in __anon_inode_getfile()]
> >
> > Lokesh, I'm assuming you made the changes in the brackets above?  If
> > so they should include your initials or some other means of
> > attributing them to you, e.g. "[LG: Fix error ...]".
>
> Thanks for reviewing the patch. Sorry for missing this. If it's
> critical then I can upload another version of the patches to fix this.
> Kindly let me know.

Normally that is something I could fix during a merge with your
approval, but see my comments to patch 3/4; I think this patchset
still needs some work.

> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > Reviewed-by: Eric Biggers <ebiggers@google.com>
> > > ---
> > >  fs/anon_inodes.c            | 150 ++++++++++++++++++++++++++----------
> > >  fs/libfs.c                  |   5 --
> > >  include/linux/anon_inodes.h |   5 ++
> > >  3 files changed, 115 insertions(+), 45 deletions(-)

...

> > > +static struct file *__anon_inode_getfile(const char *name,
> > > +                                        const struct file_operations *fops,
> > > +                                        void *priv, int flags,
> > > +                                        const struct inode *context_inode,
> > > +                                        bool secure)
> >
> > Is it necessary to pass both the context_inode pointer and the secure
> > boolean?  It seems like if context_inode is non-NULL then one could
> > assume that a secure anonymous inode was requested; is there ever
> > going to be a case where this is not true?
>
> Yes, it is necessary as there are scenarios where a secure anon-inode
> is to be created but there is no context_inode available. For
> instance, in patch 4/4 of this series you'll see that when a secure
> anon-inode is created in the userfaultfd syscall, context_inode isn't
> available.

My mistake, I didn't realize this until I got further in the patchset.

-- 
paul moore
www.paul-moore.com
