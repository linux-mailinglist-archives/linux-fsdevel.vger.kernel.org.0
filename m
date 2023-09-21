Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9927AA4C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 00:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjIUWSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 18:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjIUWSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:18:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C3A3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 15:18:29 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso1751528276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695334708; x=1695939508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EjZHM9RcmiFaqXNqF9PYUmTMuhkK5GIefqNBNTI2Iw=;
        b=WOFddY2IrLJt5kvzOPENgarchLujjysaawQWeicc0MPppSegnXSbJH5at9MMAQieUV
         NwefbKxluG0FbmWEOd8WxvR6PI4/MRDxxnCAuskPMKQSSp9z05OnNfuGbukuXMlVk1y4
         yV5HwIrYDz1fDNd/+C95LJ2dnJ3pUocFZLwApSIofgMRQmd2m7UxoIbzURsZSFH8kkdQ
         50Czwt4rv1Kj70D9e2Z66eKWrZxPTA7UECCd5dNHOftQ3ct6eOUcaF1N9IfSTLDuIS1I
         wIgekZmsXSbdYp+M5yIBequ1tniZeOdXdw3tjvWNUQSTTZSvPPrujcYNy5BU/zsu/RQs
         1jVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695334708; x=1695939508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EjZHM9RcmiFaqXNqF9PYUmTMuhkK5GIefqNBNTI2Iw=;
        b=e6I891RRpEZKXNWPVPbBtBiiZaqHVEDOpEGvg1QniMqqjVa8Om19Ss1qkNnu50fbd0
         iZ/cu9/eqAqyi6L3pnegJSOpeBOQXurmEkK6PPo4o/QYJfeVCcJSp8NlruaqYuPq9Ur+
         KgmW5EG9AYXiIWumW1YIW4Pq0+6wu2/RwWjDYnvQtNbbILEQZcYbAk6GaJremQiKKz1p
         LgSyAOfHBB1+rNeYrSy8R8yutTDNqFvThbXqjYhMDPjBqH2lhdvngb0CKOCbuA5fB1ii
         MC2JNuPT4BJVBLrgagWwIKz/Tzd5bs//R0OgWMQSsxZzAzuKiIbLt5j8BVxMoe20sBcb
         l5Mg==
X-Gm-Message-State: AOJu0YxAxb+8A9EzP1tOl2JX1f7fDbYoAXB0NQgF41JXS8TVC1cByafV
        +gZY9Zp5rip8PAueMYE84m2VYCtiPYb5Xa9o96Rv
X-Google-Smtp-Source: AGHT+IF4pdlX8WhgOn5+tafdV8bBKUupKpeQa3UI3HwcSexSNosk/a81FJowmkafGGM88J16OGfu9MkSAlJBrOm582I=
X-Received: by 2002:a25:8244:0:b0:d7a:d716:233c with SMTP id
 d4-20020a258244000000b00d7ad716233cmr6540225ybn.41.1695334708123; Thu, 21 Sep
 2023 15:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com> <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
In-Reply-To: <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 21 Sep 2023 18:18:17 -0400
Message-ID: <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:59=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Thu, Sep 14, 2023 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Sep 14, 2023 at 1:31=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Wed, Sep 13, 2023 at 2:46=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > >
> > > > On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Add new kind of BPF kernel object, BPF token. BPF token is meant =
to
> > > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > > program or creating a BPF map, from privileged process to a *trus=
ted*
> > > > > unprivileged process, all while have a good amount of control ove=
r which
> > > > > privileged operations could be performed using provided BPF token=
.
> > > > >
> > > > > This is achieved through mounting BPF FS instance with extra dele=
gation
> > > > > mount options, which determine what operations are delegatable, a=
nd also
> > > > > constraining it to the owning user namespace (as mentioned in the
> > > > > previous patch).
> > > > >
> > > > > BPF token itself is just a derivative from BPF FS and can be crea=
ted
> > > > > through a new bpf() syscall command, BPF_TOKEN_CREAT, which accep=
ts
> > > > > a path specification (using the usual fd + string path combo) to =
a BPF
> > > > > FS mount. Currently, BPF token "inherits" delegated command, map =
types,
> > > > > prog type, and attach type bit sets from BPF FS as is. In the fut=
ure,
> > > > > having an BPF token as a separate object with its own FD, we can =
allow
> > > > > to further restrict BPF token's allowable set of things either at=
 the creation
> > > > > time or after the fact, allowing the process to guard itself furt=
her
> > > > > from, e.g., unintentionally trying to load undesired kind of BPF
> > > > > programs. But for now we keep things simple and just copy bit set=
s as is.
> > > > >
> > > > > When BPF token is created from BPF FS mount, we take reference to=
 the
> > > > > BPF super block's owning user namespace, and then use that namesp=
ace for
> > > > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_AD=
MIN}
> > > > > capabilities that are normally only checked against init userns (=
using
> > > > > capable()), but now we check them using ns_capable() instead (if =
BPF
> > > > > token is provided). See bpf_token_capable() for details.
> > > > >
> > > > > Such setup means that BPF token in itself is not sufficient to gr=
ant BPF
> > > > > functionality. User namespaced process has to *also* have necessa=
ry
> > > > > combination of capabilities inside that user namespace. So while
> > > > > previously CAP_BPF was useless when granted within user namespace=
, now
> > > > > it gains a meaning and allows container managers and sys admins t=
o have
> > > > > a flexible control over which processes can and need to use BPF
> > > > > functionality within the user namespace (i.e., container in pract=
ice).
> > > > > And BPF FS delegation mount options and derived BPF tokens serve =
as
> > > > > a per-container "flag" to grant overall ability to use bpf() (plu=
s further
> > > > > restrict on which parts of bpf() syscalls are treated as namespac=
ed).
> > > > >
> > > > > The alternative to creating BPF token object was:
> > > > >   a) not having any extra object and just pasing BPF FS path to e=
ach
> > > > >      relevant bpf() command. This seems suboptimal as it's racy (=
mount
> > > > >      under the same path might change in between checking it and =
using it
> > > > >      for bpf() command). And also less flexible if we'd like to f=
urther
> > > > >      restrict ourselves compared to all the delegated functionali=
ty
> > > > >      allowed on BPF FS.
> > > > >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also c=
reate
> > > > >      a dedicated FD that would represent a token-like functionali=
ty. This
> > > > >      doesn't seem superior to having a proper bpf() command, so
> > > > >      BPF_TOKEN_CREATE was chosen.
> > > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  include/linux/bpf.h            |  36 +++++++
> > > > >  include/uapi/linux/bpf.h       |  39 +++++++
> > > > >  kernel/bpf/Makefile            |   2 +-
> > > > >  kernel/bpf/inode.c             |   4 +-
> > > > >  kernel/bpf/syscall.c           |  17 +++
> > > > >  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++=
++++++
> > > > >  tools/include/uapi/linux/bpf.h |  39 +++++++
> > > > >  7 files changed, 324 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 kernel/bpf/token.c
> > > >
> > > > ...
> > > >
> > > > > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > > > > new file mode 100644
> > > > > index 000000000000..f6ea3eddbee6
> > > > > --- /dev/null
> > > > > +++ b/kernel/bpf/token.c
> > > > > @@ -0,0 +1,189 @@
> > > > > +#include <linux/bpf.h>
> > > > > +#include <linux/vmalloc.h>
> > > > > +#include <linux/anon_inodes.h>
> > > > > +#include <linux/fdtable.h>
> > > > > +#include <linux/file.h>
> > > > > +#include <linux/fs.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/idr.h>
> > > > > +#include <linux/namei.h>
> > > > > +#include <linux/user_namespace.h>
> > > > > +
> > > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > +{
> > > > > +     /* BPF token allows ns_capable() level of capabilities */
> > > > > +     if (token) {
> > > > > +             if (ns_capable(token->userns, cap))
> > > > > +                     return true;
> > > > > +             if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->use=
rns, CAP_SYS_ADMIN))
> > > > > +                     return true;
> > > > > +     }
> > > > > +     /* otherwise fallback to capable() checks */
> > > > > +     return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(C=
AP_SYS_ADMIN));
> > > > > +}
> > > >
> > > > While the above looks to be equivalent to the bpf_capable() functio=
n it
> > > > replaces, for callers checking CAP_BPF and CAP_SYS_ADMIN, I'm looki=
ng
> > > > quickly at patch 3/12 and this is also being used to replace a
> > > > capable(CAP_NET_ADMIN) call which results in a change in behavior.
> > > > The current code which performs a capable(CAP_NET_ADMIN) check cann=
ot
> > > > be satisfied by CAP_SYS_ADMIN, but this patchset using
> > > > bpf_token_capable(token, CAP_NET_ADMIN) can be satisfied by either
> > > > CAP_NET_ADMIN or CAP_SYS_ADMIN.
> > > >
> > > > It seems that while bpf_token_capable() can be used as a replacemen=
t
> > > > for bpf_capable(), it is not currently a suitable replacement for a
> > > > generic capable() call.  Perhaps this is intentional, but I didn't =
see
> > > > it mentioned in the commit description, or in the comments, and I
> > > > wanted to make sure it wasn't an oversight.
> > >
> > > You are right. It is an intentional attempt to unify all such checks.
> > > If you look at bpf_prog_load(), we have this:
> > >
> > > if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) &&
> > > !capable(CAP_SYS_ADMIN))
> > >     return -EPERM;
> > >
> > > So seeing that, I realized that we did have an intent to always use
> > > CAP_SYS_ADMIN as a "fallback" cap, even for CAP_NET_ADMIN when it
> > > comes to using network-enabled BPF programs. So I decided that
> > > unifying all this makes sense.
> > >
> > > I'll add a comment mentioning this, I should have been more explicit
> > > from the get go.
> >
> > Thanks for the clarification.  I'm not to worried about checking
> > CAP_SYS_ADMIN as a fallback, but I always get a little twitchy when I
> > see capability changes in the code without any mention.
> >
> > A mention in the commit description is good, and you could also draft
> > up a standalone patch that adds the CAP_SYS_ADMIN fallback to the
> > current in-tree code.  That would be a good way to really highlight
> > the capability changes and deal with any issues that might arise
> > (review, odd corner cases?, etc.) prior to the BPF capability
> > delegation patcheset we are discussing here.
>
> Sure, sounds good, I'll add this as a pre-patch for next revision.

My apologies on the delay, I've been traveling this week and haven't
had the time to dig back into this.

I do see that you've posted another revision of this patchset with the
capability pre-patch, thanks for doing that.

> > > > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > > > +
> > > > > +/* Alloc anon_inode and FD for prepared token.
> > > > > + * Returns fd >=3D 0 on success; negative error, otherwise.
> > > > > + */
> > > > > +int bpf_token_new_fd(struct bpf_token *token)
> > > > > +{
> > > > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fo=
ps, token, O_CLOEXEC);
> > > > > +}
> > > > > +
> > > > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > > > +{
> > > > > +     struct fd f =3D fdget(ufd);
> > > > > +     struct bpf_token *token;
> > > > > +
> > > > > +     if (!f.file)
> > > > > +             return ERR_PTR(-EBADF);
> > > > > +     if (f.file->f_op !=3D &bpf_token_fops) {
> > > > > +             fdput(f);
> > > > > +             return ERR_PTR(-EINVAL);
> > > > > +     }
> > > > > +
> > > > > +     token =3D f.file->private_data;
> > > > > +     bpf_token_inc(token);
> > > > > +     fdput(f);
> > > > > +
> > > > > +     return token;
> > > > > +}
> > > > > +
> > > > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf=
_cmd cmd)
> > > > > +{
> > > > > +     if (!token)
> > > > > +             return false;
> > > > > +
> > > > > +     return token->allowed_cmds & (1ULL << cmd);
> > > > > +}
> > > >
> > > > I mentioned this a while back, likely in the other threads where th=
is
> > > > token-based approach was only being discussed in general terms, but=
 I
> > > > think we want to have a LSM hook at the point of initial token
> > > > delegation for this and a hook when the token is used.  My initial
> > > > thinking is that we should be able to address the former with a hoo=
k
> > > > in bpf_fill_super() and the latter either in bpf_token_get_from_fd(=
)
> > > > or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be simpler,
> > > > but it doesn't allow for much in the way of granularity.  Inserting=
 the
> > > > LSM hooks in bpf_token_allow_XXX() would also allow the BPF code to=
 fall
> > > > gracefully fallback to the system-wide checks if the LSM denied the
> > > > requested access whereas an access denial in bpf_token_get_from_fd(=
)
> > > > denial would cause the operation to error out.
> > >
> > > I think the bpf_fill_super() LSM hook makes sense, but I thought
> > > someone mentioned that we already have some generic LSM hook for
> > > validating mounts? If we don't, I can certainly add one for BPF FS
> > > specifically.
> >
> > We do have security_sb_mount(), but that is a generic mount operation
> > access control and not well suited for controlling the mount-based
> > capability delegation that you are proposing here.  However, if you or
> > someone else has a clever way to make security_sb_mount() work for
> > this purpose I would be very happy to review that code.
>
> To be honest, I'm a bit out of my depth here, as I don't know the
> mounting parts well. Perhaps someone from VFS side can advise. But
> regardless, I have no problem adding a new LSM hook as well, ideally
> not very BPF-specific. If you have a specific form of it in mind, I'd
> be curious to see it and implement it.

I agree that there can be benefits to generalized LSM hooks, but in
this hook I think it may need to be BPF specific simply because the
hook would be dealing with the specific concept of delegating BPF
permissions.

I haven't taken the time to write up any hook patches yet as I wanted
to discuss it with you and the others on the To/CC line, but it seems
like we are roughly on the same page, at least with the initial
delegation hook, so I can put something together if you aren't
comfortable working on this (more on this below) ...

> > > As for the bpf_token_allow_xxx(). This feels a bit too specific and
> > > narrow-focused. What if we later add yet another dimension for BPF FS
> > > and token? Do we need to introduce yet another LSM for each such case=
?
> >
> > [I'm assuming you meant new LSM *hook*]
>
> yep, of course, sorry about using terminology sloppily
>
> >
> > Possibly.  There are also some other issues which I've been thinking
> > about along these lines, specifically the fact that the
> > capability/command delegation happens after the existing
> > security_bpf() hook is called which makes things rather awkward from a
> > LSM perspective: the LSM would first need to allow the process access
> > to the desired BPF op using it's current LSM specific security
> > attributes (e.g. SELinux security domain, etc.) and then later
> > consider the op in the context of the delegated access control rights
> > (if the LSM decides to support those hooks).
> >
> > I suspect that if we want to make this practical we would need to
> > either move some of the token code up into __sys_bpf() so we could
> > have a better interaction with security_bpf(), or we need to consider
> > moving the security_bpf() call into the op specific functions.  I'm
> > still thinking on this (lots of reviews to get through this week), but
> > I'm hoping there is a better way because I'm not sure I like either
> > option very much.
>
> Yes, security_bpf() is happening extremely early and is lacking a lot
> of context. I'm not sure if moving it around is a good idea as it
> basically changes its semantics.

There are a couple of things that make this not quite as scary as it
may seem.  The first is that currently only SELinux implements a
security_bpf() hook and the implementation is rather simplistic in
terms of what information it requires to perform the existing access
controls; decomposing the single security_bpf() call site into
multiple op specific calls, perhaps with some op specific hooks,
should be doable without causing major semantic changes.  The second
thing is that we could augment the existing security_bpf() hook and
call site with a new LSM hook(s) that are called from the op specific
call sites; this would allow those LSMs that desire the current
semantics to use the existing security_bpf() hook and those that wish
to use the new semantics could implement the new hook(s).  This is
very similar to the pathname-based and inode-based hooks in the VFS
layer, some LSMs choose to implement pathname-based security and use
one set of hooks, while others implement a label-based security
mechanism and use a different set of hooks.

> But adding a new set of coherent LSM
> hooks per each appropriate BPF operation with good context to make
> decisions sounds like a good improvement. E.g., for BPF_PROG_LOAD, we
> can have LSM hook after struct bpf_prog is allocated, bpf_token is
> available, attributes are sanity checked. All that together is a very
> useful and powerful context that can be used both by more fixed LSM
> policies (like SELinux), and very dynamic user-defined BPF LSM
> programs.

This is where it is my turn to mention that I'm getting a bit out of
my depth, but I'm hopeful that the two of us can keep each other from
drowning :)

Typically the LSM hook call sites end up being in the same general
area as the capability checks, usually just after (we want the normal
Linux discretionary access controls to always come first for the sake
of consistency).  Sticking with that approach it looks like we would
end up with a LSM call in bpf_prog_load() right after bpf_capable()
call, the only gotcha with that is the bpf_prog struct isn't populated
yet, but how important is that when we have the bpf_attr info (honest
question, I don't know the answer to this)?

Ignoring the bpf_prog struct, do you think something like this would
work for a hook call site (please forgive the pseudo code)?

  int bpf_prog_load(...)
  {
         ...
     bpf_cap =3D bpf_token_capable(token, CAP_BPF);
     err =3D security_bpf_token(BPF_PROG_LOAD, attr, uattr_size, token);
     if (err)
       return err;
    ...
  }

Assuming this type of hook configuration, and an empty/passthrough
security_bpf() hook, a LSM would first see the various
capable()/ns_capable() checks present in bpf_token_capable() followed
by a BPF op check, complete with token, in the security_bpf_token()
hook.  Further assuming that we convert the bpf_token_new_fd() to use
anon_inode_getfd_secure() instead of anon_inode_getfd() and the
security_bpf_token() could still access the token fd via the bpf_attr
struct I think we could do something like this for the SELinux case
(more rough pseudo code):

  int selinux_bpf_token(...)
  {
    ssid =3D current_sid();
    if (token) {
      /* this could be simplified with better integration
       * in bpf_token_get_from_fd() */
      fd =3D fdget(attr->prog_token_fd);
      inode =3D file_inode(fd.file);
      isec =3D selinux_inode(inode);
      tsid =3D isec->sid;
      fdput(fd);
    } else
      tsid =3D ssid;
    switch(cmd) {
    ...
    case BPF_PROG_LOAD:
      rc =3D avc_has_perm(ssid, tsid, SECCLAS_BPF, BPF__PROG_LOAD);
      break;
    default:
      rc =3D 0;
    }
    return rc;
  }

This would preserve the current behaviour when a token was not present:

 allow @current @current : bpf { prog_load }

... but this would change to the following if a token was present:

 allow @current @DELEGATED_ANON_INODE : bpf { prog_load }

That seems reasonable to me, but I've CC'd the SELinux list on this so
others can sanity check the above :)

> But I'd like to keep all that outside of the BPF token feature itself,
> as it's already pretty hard to get a consensus just on those bits, so
> complicating this with simultaneously designing a new set of LSM hooks
> is something that we should avoid. Let's keep discussing this, but not
> block that on BPF token.

The unfortunate aspect of disconnecting new functionality from the
associated access controls is that it introduces a gap where the new
functionality is not secured in a manner that users expect.  There are
billions of systems/users that rely on LSM-based access controls for a
large part of their security story, and I think we are doing them a
disservice by not including the LSM controls with new security
significant features.

We (the LSM folks) are happy to work with you to get this sorted out,
and I would hope my comments in this thread (as well as prior
iterations) and the rough design above is a good faith indicator of
that.

> > > But also see bpf_prog_load(). There are two checks, allow_prog_type
> > > and allow_attach_type, which are really only meaningful in
> > > combination. And yet you'd have to have two separate LSM hooks for
> > > that.
> > >
> > > So I feel like the better approach is less mechanistically
> > > concentrating on BPF token operations themselves, but rather on more
> > > semantically meaningful operations that are token-enabled. E.g.,
> > > protect BPF program loading, BPF map creation, BTF loading, etc. And
> > > we do have such LSM hooks right now, though they might not be the mos=
t
> > > convenient. So perhaps the right move is to add new ones that would
> > > provide a bit more context (e.g., we can pass in the BPF token that
> > > was used for the operation, attributes with which map/prog was
> > > created, etc). Low-level token LSMs seem hard to use cohesively in
> > > practice, though.
> >
> > Can you elaborate a bit more?  It's hard to judge the comments above
> > without some more specifics about hook location, parameters, etc.
>
> So something like my above proposal for a new LSM hook in
> BPF_PROG_LOAD command. Just right before passing bpf_prog to BPF
> verifier, we can have
>
> err =3D security_bpf_prog_load(prog, attr, token)
> if (err)
>     return -EPERM;
>
> Program, attributes, and token give a lot of inputs for security
> policy logic to make a decision about allowing that specific BPF
> program to be verified and loaded or not. I know how this could be
> used from BPF LSM side, but I assume that SELinux and others can take
> advantage of that provided additional context as well.

If you think a populated bpf_prog struct is important for BPF LSM
programs then I have no problem with that hook placement.  It's a lot
later in the process than we might normally want to place the hook,
but we can still safely error out here so that should be okay.

From a LSM perspective I think we can make either work, I think the
big question is which would you rather have in the BPF code: the
security_bpf_prog_load() hook you've suggested here or the
security_bpf_token() hook I suggested above?

> Similarly we can have a BPF_MAP_CREATE-specific LSM hook with context
> relevant to creating a BPF map. And so on.

Of course.  I've been operating under the assumption that whatever we
do for one op we should be able to apply the same idea to the others
that need it.

--=20
paul-moore.com
