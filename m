Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B27A28E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbjIOVBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbjIOVBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:01:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B53A99;
        Fri, 15 Sep 2023 13:59:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so2243289f8f.3;
        Fri, 15 Sep 2023 13:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694811594; x=1695416394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bev0hGbc6h+9hEGMt4GGDqHJk/lldnaCyvvwf8Ze8M=;
        b=m94zQc64ZA0ICAQB545a+5Kji8ClfTwLJqqn3/LycfBtuYMDIGvGyKMn/TtM4yFeQv
         mdgEYc5aHXwX9QxrmUZFLQleoeqFZKuH0pzPpO8lQEAzvW8tzgXskQkDNFtbC8jjk3Co
         hXaMJQAGV6ltio8dCKRYK7Np9kXeQSdcQ7JRgK2jT1ALYHwyi6G8mTNv0Tl/FmyTi37K
         OeKMnTIfZVjyRbK94TtmA5n65D0B3lc3qpeDUNKsqIdY6Phojf3zNhQokolB3of2Sf2V
         6Qbi3D9x7O+EOMfKXCwqpIedDNlK2jtF/bsuC9l+marMzXn+QU+JvCrmKdr5xR3JmBte
         PHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811594; x=1695416394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bev0hGbc6h+9hEGMt4GGDqHJk/lldnaCyvvwf8Ze8M=;
        b=Bg8O5vseQKhbedyskt4zpxbA6gPcy5v3zi5SbPcY025KptpX+kicqj4lUHYGtpo/MV
         Zyf0quk3p4Anuqgx1x+s7q6sJddTG5Mh444FuVso8F2Owj10dYG4HH/Egj8mVwu2yFjm
         xo8SJpIN6Jd+LOzryYmp7YZg/3bZa8hbTTpw2+W71cnzwPahHbescoL15eamNxuDSP7o
         CXHEHVj4ZUEtt/8T93FvTqFWlE3vijvWlYecxw4mETmv8dETYHLZ8sJXpneXmfc4TRkb
         bIokZ41ffkm9rlNdKbMbngL0mNLyYrU5SNDNl32XObIZxXkuciCVLon9+RapOm2NJZku
         uNtw==
X-Gm-Message-State: AOJu0Yw5jtIc8GQ/6cNQ7WiCbwKZIX8s5YLtp9UY3nU/+HJoYbhi6LeS
        POy/0ECoKwZqevP0/tJHyZrajY4kADPYwN2zc+U=
X-Google-Smtp-Source: AGHT+IG/Uoh341/TToi93PcPdlWORtS4RshWh9zwnOzeFqbPzjkCoGM0rinldGrNBvcMCiE6MYUe42ZfZSM9/SpQHPI=
X-Received: by 2002:a05:6000:1047:b0:31f:b804:8e44 with SMTP id
 c7-20020a056000104700b0031fb8048e44mr2291759wrx.61.1694811593999; Fri, 15 Sep
 2023 13:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com> <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Sep 2023 13:59:42 -0700
Message-ID: <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 14, 2023 at 1:31=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Wed, Sep 13, 2023 at 2:46=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > > > allow delegating privileged BPF functionality, like loading a BPF
> > > > program or creating a BPF map, from privileged process to a *truste=
d*
> > > > unprivileged process, all while have a good amount of control over =
which
> > > > privileged operations could be performed using provided BPF token.
> > > >
> > > > This is achieved through mounting BPF FS instance with extra delega=
tion
> > > > mount options, which determine what operations are delegatable, and=
 also
> > > > constraining it to the owning user namespace (as mentioned in the
> > > > previous patch).
> > > >
> > > > BPF token itself is just a derivative from BPF FS and can be create=
d
> > > > through a new bpf() syscall command, BPF_TOKEN_CREAT, which accepts
> > > > a path specification (using the usual fd + string path combo) to a =
BPF
> > > > FS mount. Currently, BPF token "inherits" delegated command, map ty=
pes,
> > > > prog type, and attach type bit sets from BPF FS as is. In the futur=
e,
> > > > having an BPF token as a separate object with its own FD, we can al=
low
> > > > to further restrict BPF token's allowable set of things either at t=
he creation
> > > > time or after the fact, allowing the process to guard itself furthe=
r
> > > > from, e.g., unintentionally trying to load undesired kind of BPF
> > > > programs. But for now we keep things simple and just copy bit sets =
as is.
> > > >
> > > > When BPF token is created from BPF FS mount, we take reference to t=
he
> > > > BPF super block's owning user namespace, and then use that namespac=
e for
> > > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMI=
N}
> > > > capabilities that are normally only checked against init userns (us=
ing
> > > > capable()), but now we check them using ns_capable() instead (if BP=
F
> > > > token is provided). See bpf_token_capable() for details.
> > > >
> > > > Such setup means that BPF token in itself is not sufficient to gran=
t BPF
> > > > functionality. User namespaced process has to *also* have necessary
> > > > combination of capabilities inside that user namespace. So while
> > > > previously CAP_BPF was useless when granted within user namespace, =
now
> > > > it gains a meaning and allows container managers and sys admins to =
have
> > > > a flexible control over which processes can and need to use BPF
> > > > functionality within the user namespace (i.e., container in practic=
e).
> > > > And BPF FS delegation mount options and derived BPF tokens serve as
> > > > a per-container "flag" to grant overall ability to use bpf() (plus =
further
> > > > restrict on which parts of bpf() syscalls are treated as namespaced=
).
> > > >
> > > > The alternative to creating BPF token object was:
> > > >   a) not having any extra object and just pasing BPF FS path to eac=
h
> > > >      relevant bpf() command. This seems suboptimal as it's racy (mo=
unt
> > > >      under the same path might change in between checking it and us=
ing it
> > > >      for bpf() command). And also less flexible if we'd like to fur=
ther
> > > >      restrict ourselves compared to all the delegated functionality
> > > >      allowed on BPF FS.
> > > >   b) use non-bpf() interface, e.g., ioctl(), but otherwise also cre=
ate
> > > >      a dedicated FD that would represent a token-like functionality=
. This
> > > >      doesn't seem superior to having a proper bpf() command, so
> > > >      BPF_TOKEN_CREATE was chosen.
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h            |  36 +++++++
> > > >  include/uapi/linux/bpf.h       |  39 +++++++
> > > >  kernel/bpf/Makefile            |   2 +-
> > > >  kernel/bpf/inode.c             |   4 +-
> > > >  kernel/bpf/syscall.c           |  17 +++
> > > >  kernel/bpf/token.c             | 189 +++++++++++++++++++++++++++++=
++++
> > > >  tools/include/uapi/linux/bpf.h |  39 +++++++
> > > >  7 files changed, 324 insertions(+), 2 deletions(-)
> > > >  create mode 100644 kernel/bpf/token.c
> > >
> > > ...
> > >
> > > > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > > > new file mode 100644
> > > > index 000000000000..f6ea3eddbee6
> > > > --- /dev/null
> > > > +++ b/kernel/bpf/token.c
> > > > @@ -0,0 +1,189 @@
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/vmalloc.h>
> > > > +#include <linux/anon_inodes.h>
> > > > +#include <linux/fdtable.h>
> > > > +#include <linux/file.h>
> > > > +#include <linux/fs.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/idr.h>
> > > > +#include <linux/namei.h>
> > > > +#include <linux/user_namespace.h>
> > > > +
> > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > +{
> > > > +     /* BPF token allows ns_capable() level of capabilities */
> > > > +     if (token) {
> > > > +             if (ns_capable(token->userns, cap))
> > > > +                     return true;
> > > > +             if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->usern=
s, CAP_SYS_ADMIN))
> > > > +                     return true;
> > > > +     }
> > > > +     /* otherwise fallback to capable() checks */
> > > > +     return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP=
_SYS_ADMIN));
> > > > +}
> > >
> > > While the above looks to be equivalent to the bpf_capable() function =
it
> > > replaces, for callers checking CAP_BPF and CAP_SYS_ADMIN, I'm looking
> > > quickly at patch 3/12 and this is also being used to replace a
> > > capable(CAP_NET_ADMIN) call which results in a change in behavior.
> > > The current code which performs a capable(CAP_NET_ADMIN) check cannot
> > > be satisfied by CAP_SYS_ADMIN, but this patchset using
> > > bpf_token_capable(token, CAP_NET_ADMIN) can be satisfied by either
> > > CAP_NET_ADMIN or CAP_SYS_ADMIN.
> > >
> > > It seems that while bpf_token_capable() can be used as a replacement
> > > for bpf_capable(), it is not currently a suitable replacement for a
> > > generic capable() call.  Perhaps this is intentional, but I didn't se=
e
> > > it mentioned in the commit description, or in the comments, and I
> > > wanted to make sure it wasn't an oversight.
> >
> > You are right. It is an intentional attempt to unify all such checks.
> > If you look at bpf_prog_load(), we have this:
> >
> > if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) &&
> > !capable(CAP_SYS_ADMIN))
> >     return -EPERM;
> >
> > So seeing that, I realized that we did have an intent to always use
> > CAP_SYS_ADMIN as a "fallback" cap, even for CAP_NET_ADMIN when it
> > comes to using network-enabled BPF programs. So I decided that
> > unifying all this makes sense.
> >
> > I'll add a comment mentioning this, I should have been more explicit
> > from the get go.
>
> Thanks for the clarification.  I'm not to worried about checking
> CAP_SYS_ADMIN as a fallback, but I always get a little twitchy when I
> see capability changes in the code without any mention.
>
> A mention in the commit description is good, and you could also draft
> up a standalone patch that adds the CAP_SYS_ADMIN fallback to the
> current in-tree code.  That would be a good way to really highlight
> the capability changes and deal with any issues that might arise
> (review, odd corner cases?, etc.) prior to the BPF capability
> delegation patcheset we are discussing here.

Sure, sounds good, I'll add this as a pre-patch for next revision.

>
> > > > +#define BPF_TOKEN_INODE_NAME "bpf-token"
> > > > +
> > > > +/* Alloc anon_inode and FD for prepared token.
> > > > + * Returns fd >=3D 0 on success; negative error, otherwise.
> > > > + */
> > > > +int bpf_token_new_fd(struct bpf_token *token)
> > > > +{
> > > > +     return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops=
, token, O_CLOEXEC);
> > > > +}
> > > > +
> > > > +struct bpf_token *bpf_token_get_from_fd(u32 ufd)
> > > > +{
> > > > +     struct fd f =3D fdget(ufd);
> > > > +     struct bpf_token *token;
> > > > +
> > > > +     if (!f.file)
> > > > +             return ERR_PTR(-EBADF);
> > > > +     if (f.file->f_op !=3D &bpf_token_fops) {
> > > > +             fdput(f);
> > > > +             return ERR_PTR(-EINVAL);
> > > > +     }
> > > > +
> > > > +     token =3D f.file->private_data;
> > > > +     bpf_token_inc(token);
> > > > +     fdput(f);
> > > > +
> > > > +     return token;
> > > > +}
> > > > +
> > > > +bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_c=
md cmd)
> > > > +{
> > > > +     if (!token)
> > > > +             return false;
> > > > +
> > > > +     return token->allowed_cmds & (1ULL << cmd);
> > > > +}
> > >
> > > I mentioned this a while back, likely in the other threads where this
> > > token-based approach was only being discussed in general terms, but I
> > > think we want to have a LSM hook at the point of initial token
> > > delegation for this and a hook when the token is used.  My initial
> > > thinking is that we should be able to address the former with a hook
> > > in bpf_fill_super() and the latter either in bpf_token_get_from_fd()
> > > or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be simpler,
> > > but it doesn't allow for much in the way of granularity.  Inserting t=
he
> > > LSM hooks in bpf_token_allow_XXX() would also allow the BPF code to f=
all
> > > gracefully fallback to the system-wide checks if the LSM denied the
> > > requested access whereas an access denial in bpf_token_get_from_fd()
> > > denial would cause the operation to error out.
> >
> > I think the bpf_fill_super() LSM hook makes sense, but I thought
> > someone mentioned that we already have some generic LSM hook for
> > validating mounts? If we don't, I can certainly add one for BPF FS
> > specifically.
>
> We do have security_sb_mount(), but that is a generic mount operation
> access control and not well suited for controlling the mount-based
> capability delegation that you are proposing here.  However, if you or
> someone else has a clever way to make security_sb_mount() work for
> this purpose I would be very happy to review that code.

To be honest, I'm a bit out of my depth here, as I don't know the
mounting parts well. Perhaps someone from VFS side can advise. But
regardless, I have no problem adding a new LSM hook as well, ideally
not very BPF-specific. If you have a specific form of it in mind, I'd
be curious to see it and implement it.

>
> > As for the bpf_token_allow_xxx(). This feels a bit too specific and
> > narrow-focused. What if we later add yet another dimension for BPF FS
> > and token? Do we need to introduce yet another LSM for each such case?
>
> [I'm assuming you meant new LSM *hook*]

yep, of course, sorry about using terminology sloppily

>
> Possibly.  There are also some other issues which I've been thinking
> about along these lines, specifically the fact that the
> capability/command delegation happens after the existing
> security_bpf() hook is called which makes things rather awkward from a
> LSM perspective: the LSM would first need to allow the process access
> to the desired BPF op using it's current LSM specific security
> attributes (e.g. SELinux security domain, etc.) and then later
> consider the op in the context of the delegated access control rights
> (if the LSM decides to support those hooks).
>
> I suspect that if we want to make this practical we would need to
> either move some of the token code up into __sys_bpf() so we could
> have a better interaction with security_bpf(), or we need to consider
> moving the security_bpf() call into the op specific functions.  I'm
> still thinking on this (lots of reviews to get through this week), but
> I'm hoping there is a better way because I'm not sure I like either
> option very much.

Yes, security_bpf() is happening extremely early and is lacking a lot
of context. I'm not sure if moving it around is a good idea as it
basically changes its semantics. But adding a new set of coherent LSM
hooks per each appropriate BPF operation with good context to make
decisions sounds like a good improvement. E.g., for BPF_PROG_LOAD, we
can have LSM hook after struct bpf_prog is allocated, bpf_token is
available, attributes are sanity checked. All that together is a very
useful and powerful context that can be used both by more fixed LSM
policies (like SELinux), and very dynamic user-defined BPF LSM
programs.

But I'd like to keep all that outside of the BPF token feature itself,
as it's already pretty hard to get a consensus just on those bits, so
complicating this with simultaneously designing a new set of LSM hooks
is something that we should avoid. Let's keep discussing this, but not
block that on BPF token.

>
> > But also see bpf_prog_load(). There are two checks, allow_prog_type
> > and allow_attach_type, which are really only meaningful in
> > combination. And yet you'd have to have two separate LSM hooks for
> > that.
> >
> > So I feel like the better approach is less mechanistically
> > concentrating on BPF token operations themselves, but rather on more
> > semantically meaningful operations that are token-enabled. E.g.,
> > protect BPF program loading, BPF map creation, BTF loading, etc. And
> > we do have such LSM hooks right now, though they might not be the most
> > convenient. So perhaps the right move is to add new ones that would
> > provide a bit more context (e.g., we can pass in the BPF token that
> > was used for the operation, attributes with which map/prog was
> > created, etc). Low-level token LSMs seem hard to use cohesively in
> > practice, though.
>
> Can you elaborate a bit more?  It's hard to judge the comments above
> without some more specifics about hook location, parameters, etc.

So something like my above proposal for a new LSM hook in
BPF_PROG_LOAD command. Just right before passing bpf_prog to BPF
verifier, we can have

err =3D security_bpf_prog_load(prog, attr, token)
if (err)
    return -EPERM;

Program, attributes, and token give a lot of inputs for security
policy logic to make a decision about allowing that specific BPF
program to be verified and loaded or not. I know how this could be
used from BPF LSM side, but I assume that SELinux and others can take
advantage of that provided additional context as well.

Similarly we can have a BPF_MAP_CREATE-specific LSM hook with context
relevant to creating a BPF map. And so on.


>
> --
> paul-moore.com
