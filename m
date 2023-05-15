Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DE702D70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbjEONFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 09:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242118AbjEONEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 09:04:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B231FC1;
        Mon, 15 May 2023 06:04:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ba6fffc5524so5461476276.3;
        Mon, 15 May 2023 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684155873; x=1686747873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmjgtR3FUUnPHLlHE3NyNv9G/eITqpjvj7rS/dG5ByE=;
        b=iievZifvjljNx3cjrrpmWbU9HzSxb4BFi5Wy2YoKC6dIIE/gG3VJyQE9GfG8Ix4qDH
         3k+33ttyIvhu7uSgwrLOZ5aMU3FNh8WjsllaT8uC5juPJhCAmrecbNBrFU05dyOQtKJW
         ED4npY0DIWnwq75hBoS9c0hLdQHXroAOM0MHnLWDkHC5QyNC543bIprOo/T7xdhzNmrq
         JGstKStUZKW9olEB/jLq4eHoyUQH+nC9pAYpVXmskv4R2ae3E7hKZcPObON2dRSjJNry
         fsRcgZTNk5LAkZHyjb9POzgX7uAIfhBGWOPPcWq4qfLMzIxzWjzyEzhWGNoQZ6ScmC+0
         vSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155873; x=1686747873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmjgtR3FUUnPHLlHE3NyNv9G/eITqpjvj7rS/dG5ByE=;
        b=h1VbWg8oseJcTh7NP06vnkTEaotwWvf0MAkVuUHxLcplJGNwhd/o27QHhXCUoZXfZR
         tuClvsEYwb3E+8C9DNE7Hzc4s50YqXtgmjCIfl0GzyCGMX3BT2ox2jHBpwIUOKO62o9l
         pWExhdPlI/ppsHtAOUDowLZNEEF5wz5wR7fMaN+FPRzQEGkY2YUL2o3S4uYTgoXuJzRg
         9dBq8RUKXqsutcymiJ3k9H5s+ZomhMsIhznTGHXxPmCbh9lTlvMzvM7ubDQjTBOiQ4uG
         25sSdsztBW9d8t1oyrtfocvXLsWOGxJK/aW4W48044rkwAxyC8VfWDqkM4rmyGaCikLK
         0lPw==
X-Gm-Message-State: AC+VfDyv/xXQiUA7JzjrM0chuCJpmX0w73jih2UVrZzjknNJM3DgvdvX
        zfTbsrjP12/ga58ySQpfITZkcgTFEuM3R00YZ/I=
X-Google-Smtp-Source: ACHHUZ4j0rfWlRf3B25cMrTmeLqU/GVDGA6NRJbdgBBYgLuSVLo3VaL7t47oFPK2ZArCu3u5WiUSpY5ldduBctNwBw8=
X-Received: by 2002:a05:7500:5283:b0:105:6766:6d39 with SMTP id
 x3-20020a057500528300b0010567666d39mr1166689gaa.40.1684155872830; Mon, 15 May
 2023 06:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150802.737477-1-cgzones@googlemail.com> <20230515-kopfgeld-umkurven-f27be4b68a26@brauner>
In-Reply-To: <20230515-kopfgeld-umkurven-f27be4b68a26@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 May 2023 16:04:21 +0300
Message-ID: <CAOQ4uxgtxLLfBuVUAT7+N7cox+03wJA3ACGEu76dZd5RqGWXTQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fs/xattr: add *at family syscalls
To:     Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, audit@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Jan Kara <jack@suse.cz>, jlayton@kernel.org, cyphar@cyphar.com,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 1:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 11, 2023 at 05:08:02PM +0200, Christian G=C3=B6ttsche wrote:
> > Add the four syscalls setxattrat(), getxattrat(), listxattrat() and
> > removexattrat().  Those can be used to operate on extended attributes,
> > especially security related ones, either relative to a pinned directory
> > or on a file descriptor without read access, avoiding a
> > /proc/<pid>/fd/<fd> detour, requiring a mounted procfs.
> >
> > One use case will be setfiles(8) setting SELinux file contexts
> > ("security.selinux") without race conditions.
> >
> > Add XATTR flags to the private namespace of AT_* flags.
> >
> > Use the do_{name}at() pattern from fs/open.c.
> >
> > Use a single flag parameter for extended attribute flags (currently
> > XATTR_CREATE and XATTR_REPLACE) and *at() flags to not exceed six
> > syscall arguments in setxattrat().
> >
> > Previous approach ("f*xattr: allow O_PATH descriptors"): https://lore.k=
ernel.org/all/20220607153139.35588-1-cgzones@googlemail.com/
> > v1 discussion: https://lore.kernel.org/all/20220830152858.14866-2-cgzon=
es@googlemail.com/
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > CC: x86@kernel.org
> > CC: linux-alpha@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: linux-ia64@vger.kernel.org
> > CC: linux-m68k@lists.linux-m68k.org
> > CC: linux-mips@vger.kernel.org
> > CC: linux-parisc@vger.kernel.org
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: linux-s390@vger.kernel.org
> > CC: linux-sh@vger.kernel.org
> > CC: sparclinux@vger.kernel.org
> > CC: linux-fsdevel@vger.kernel.org
> > CC: audit@vger.kernel.org
> > CC: linux-arch@vger.kernel.org
> > CC: linux-api@vger.kernel.org
> > CC: linux-security-module@vger.kernel.org
> > CC: selinux@vger.kernel.org
> > ---
>
> Fwiw, your header doesn't let me see who the mail was directly sent to
> so I'm only able to reply to lists which is a bit pointless...
>
> > v2:
> >   - squash syscall introduction and wire up commits
> >   - add AT_XATTR_CREATE and AT_XATTR_REPLACE constants
>
> > +#define AT_XATTR_CREATE              0x1     /* setxattrat(2): set val=
ue, fail if attr already exists */
> > +#define AT_XATTR_REPLACE     0x2     /* setxattrat(2): set value, fail=
 if attr does not exist */
>
> We really shouldn't waste any AT_* flags for this. Otherwise we'll run
> out of them rather quickly. Two weeks ago we added another AT_* flag
> which is up for merging for v6.5 iirc and I've glimpsed another AT_*
> flag proposal in one of the talks at last weeks Vancouver conference
> extravaganza.
>
> Even if we reuse 0x200 for AT_XATTR_CREATE (like we did for AT_EACCESS
> and AT_REMOVEDIR) we still need another bit for AT_XATTR_REPLACE.
>
> Plus, this is really ugly since AT_XATTR_{CREATE,REPLACE} really isn't
> in any way related to lookup and we're mixing it in with lookup
> modifying flags.
>
> So my proposal for {g,s}etxattrat() would be:
>
> struct xattr_args {
>         __aligned_u64 value;
>         __u32 size;
>         __u32 cmd;
> };
>
> So everything's nicely 64bit aligned in the struct. Use the @cmd member
> to set either XATTR_REPLACE or XATTR_CREATE and treat it as a proper
> enum and not as a flag argument like the old calls did.
>
> So then we'd have:
>
> setxattrat(int dfd, const char *path, const char __user *name,
>            struct xattr_args __user *args, size_t size, unsigned int flag=
s)
> getxattrat(int dfd, const char *path, const char __user *name,
>            struct xattr_args __user *args, size_t size, unsigned int flag=
s)
>
> The current in-kernel struct xattr_ctx would be renamed to struct
> kernel_xattr_args and then we do the usual copy_struct_from_user()
> dance:
>
> struct xattr_args args;
> err =3D copy_struct_from_user(&args, sizeof(args), uargs, usize);
>
> and then go on to handle value/size for setxattrat()/getxattrat()
> accordingly.
>
> getxattr()/setxattr() aren't meaningfully filterable by seccomp already
> so there's not point in not using a struct.
>
> If that isn't very appealing then another option is to add a new flag
> namespace just for setxattrat() similar to fspick() and move_mount()
> duplicating the needed lookup modifying flags.
> Thoughts?

Here is a thought: I am not sure if I am sorry we did not discuss this API
issue in LSFMM or happy that we did not waste our time on this... :-/

I must say that I dislike redefined flag namespace like FSPICK_*
just as much as I dislike overloading the AT_* namespace and TBH,
I am not crazy about avoiding this problem with xattr_args either.

A more sane solution IMO could have been:
- Use lower word of flags for generic AT_ flags
- Use the upper word of flags for syscall specific flags

So if it were up to me, I would vote starting this practice:

+ /* Start of syscall specific range */
+ #define AT_XATTR_CREATE       0x10000     /* setxattrat(2): set
value, fail if attr already exists */
+ #define AT_XATTR_REPLACE     0x20000     /* setxattrat(2): set
value, fail if attr does not exist */

Which coincidentally happens to be inline with my AT_HANDLE_FID patch...

Sure, we will have some special cases like MOVE_MOUNT_* and
legacy pollution to the lower AT_ flags word, but as a generic solution
for syscalls that need the common AT_ lookup flags and just a few
private flags, that seems like the lesser evil to me.

Thanks,
Amir.
