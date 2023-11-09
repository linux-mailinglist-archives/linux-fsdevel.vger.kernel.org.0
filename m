Return-Path: <linux-fsdevel+bounces-2498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95297E658E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC65281304
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA810947;
	Thu,  9 Nov 2023 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC5Z590Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32910782;
	Thu,  9 Nov 2023 08:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6DAC433C7;
	Thu,  9 Nov 2023 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699519685;
	bh=RYAd4qXFWlCfiZBRCTuNCjZIwDzmv9k1JMTrqRiqfs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vC5Z590ZM//lkVgtEYshPj8SctB7cjYwutMx6w3jb8mHCgGg58yHLCnxRu51+QWpu
	 A0rVJvBldGDClD0wHrAzOnrdU5JOyycQlCopJHP81rLz8KRcJm+o5mTcCCmvFdr7y0
	 ZQMss+ICIyxFPfEA2S2B41SFyJWTuDIlGmrAvl0wejbXCNK9sjwqP0Gct7u9sV9VG0
	 sAfEH4PqRab0cP4WPN6GttCs+CyRQfmPD1mGUJD+n7qxW6foDGjgoVveq4w/NcA67j
	 6bfYsksR7R7xN+pyiDWjzmayz6Yt+ZajTs6KVosR9bfdf+kRJFIKdNfG0cqeAnDNUZ
	 uFlwOy6rCx5Pg==
Date: Thu, 9 Nov 2023 09:47:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
Message-ID: <20231109-linden-kursprogramm-15c2cbd860b3@brauner>
References: <20231103190523.6353-1-andrii@kernel.org>
 <20231103190523.6353-3-andrii@kernel.org>
 <20231108-ungeeignet-uhren-698f16b4b36b@brauner>
 <CAEf4BzbanZO_QPhzyFgBEuB0i+uZZO4rZn7mO1qNp3aoPx+32g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbanZO_QPhzyFgBEuB0i+uZZO4rZn7mO1qNp3aoPx+32g@mail.gmail.com>

On Wed, Nov 08, 2023 at 01:09:27PM -0800, Andrii Nakryiko wrote:
> On Wed, Nov 8, 2023 at 5:51 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Nov 03, 2023 at 12:05:08PM -0700, Andrii Nakryiko wrote:
> > > Add few new mount options to BPF FS that allow to specify that a given
> > > BPF FS instance allows creation of BPF token (added in the next patch),
> > > and what sort of operations are allowed under BPF token. As such, we get
> > > 4 new mount options, each is a bit mask
> > >   - `delegate_cmds` allow to specify which bpf() syscall commands are
> > >     allowed with BPF token derived from this BPF FS instance;
> > >   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
> > >     a set of allowable BPF map types that could be created with BPF token;
> > >   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
> > >     a set of allowable BPF program types that could be loaded with BPF token;
> > >   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
> > >     a set of allowable BPF program attach types that could be loaded with
> > >     BPF token; delegate_progs and delegate_attachs are meant to be used
> > >     together, as full BPF program type is, in general, determined
> > >     through both program type and program attach type.
> > >
> > > Currently, these mount options accept the following forms of values:
> > >   - a special value "any", that enables all possible values of a given
> > >   bit set;
> > >   - numeric value (decimal or hexadecimal, determined by kernel
> > >   automatically) that specifies a bit mask value directly;
> > >   - all the values for a given mount option are combined, if specified
> > >   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
> > >   delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
> > >   mask.
> > >
> > > Ideally, more convenient (for humans) symbolic form derived from
> > > corresponding UAPI enums would be accepted (e.g., `-o
> > > delegate_progs=kprobe|tracepoint`) and I intend to implement this, but
> > > it requires a bunch of UAPI header churn, so I postponed it until this
> > > feature lands upstream or at least there is a definite consensus that
> > > this feature is acceptable and is going to make it, just to minimize
> > > amount of wasted effort and not increase amount of non-essential code to
> > > be reviewed.
> > >
> > > Attentive reader will notice that BPF FS is now marked as
> > > FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
> > > user namespace as long as the process has sufficient *namespaced*
> > > capabilities within that user namespace. But in reality we still
> > > restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *in
> > > init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is added
> > > to allow creating BPF FS context object (i.e., fsopen("bpf")) from
> > > inside unprivileged process inside non-init userns, to capture that
> > > userns as the owning userns. It will still be required to pass this
> > > context object back to privileged process to instantiate and mount it.
> > >
> > > This manipulation is important, because capturing non-init userns as the
> > > owning userns of BPF FS instance (super block) allows to use that userns
> > > to constraint BPF token to that userns later on (see next patch). So
> > > creating BPF FS with delegation inside unprivileged userns will restrict
> > > derived BPF token objects to only "work" inside that intended userns,
> > > making it scoped to a intended "container".
> > >
> > > There is a set of selftests at the end of the patch set that simulates
> > > this sequence of steps and validates that everything works as intended.
> > > But careful review is requested to make sure there are no missed gaps in
> > > the implementation and testing.
> > >
> > > All this is based on suggestions and discussions with Christian Brauner
> > > ([0]), to the best of my ability to follow all the implications.
> >
> > "who will not be held responsible for any CVE future or present as he's
> >  not sure whether bpf token is a good idea in general"
> >
> > I'm not opposing it because it's really not my subsystem. But it'd be
> > nice if you also added a disclaimer that I'm not endorsing this. :)
> >
> 
> Sure, I'll clarify. I still appreciate your reviewing everything and
> pointing out all the gotchas (like the reconfiguration and other
> stuff), thanks!
> 
> > A comment below.
> >
> > >
> > >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  include/linux/bpf.h | 10 ++++++
> > >  kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
> > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > >
> 
> [...]
> 
> > >       opt = fs_parse(fc, bpf_fs_parameters, param, &result);
> > >       if (opt < 0) {
> > > @@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > >       case OPT_MODE:
> > >               opts->mode = result.uint_32 & S_IALLUGO;
> > >               break;
> > > +     case OPT_DELEGATE_CMDS:
> > > +     case OPT_DELEGATE_MAPS:
> > > +     case OPT_DELEGATE_PROGS:
> > > +     case OPT_DELEGATE_ATTACHS:
> > > +             if (strcmp(param->string, "any") == 0) {
> > > +                     msk = ~0ULL;
> > > +             } else {
> > > +                     err = kstrtou64(param->string, 0, &msk);
> > > +                     if (err)
> > > +                             return err;
> > > +             }
> > > +             switch (opt) {
> > > +             case OPT_DELEGATE_CMDS: opts->delegate_cmds |= msk; break;
> > > +             case OPT_DELEGATE_MAPS: opts->delegate_maps |= msk; break;
> > > +             case OPT_DELEGATE_PROGS: opts->delegate_progs |= msk; break;
> > > +             case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |= msk; break;
> > > +             default: return -EINVAL;
> > > +             }
> > > +             break;
> > >       }
> >
> > So just to repeat that this will allow a container to set it's own
> > delegation options:
> >
> >         # unprivileged container
> >
> >         fd_fs = fsopen();
> >         fsconfig(fd_fs, FSCONFIG_BLA_BLA, "give-me-all-the-delegation");
> >
> >         # Now hand of that fd_fs to a privileged process
> >
> >         fsconfig(fd_fs, FSCONFIG_CREATE_CMD, ...)
> >
> > This means the container manager can't be part of your threat model
> > because you need to trust it to set delegation options.
> >
> > But if the container manager is part of your threat model then you can
> > never trust an fd_fs handed to you because the container manager might
> > have enabled arbitrary delegation privileges.
> >
> > There's ways around this:
> >
> > (1) kernel: Account for this in the kernel and require privileges when
> >     setting delegation options.
> 
> What sort of privilege would that be? We are in an unprivileged user
> namespace, so that would have to be some ns_capable() checks or
> something? I can add ns_capable(CAP_BPF), but what else did you have
> in mind?

You would require privileges in the initial namespace aka capable()
checks similar to what you require for superblock creation.

> 
> I think even if we say that privileged parent does FSCONFIG_SET_STRING
> and unprivileged child just does sys_fsopen("bpf", 0) and nothing
> more, we still can't be sure that child won't race with parent and set
> FSCONFIG_SET_STRING at the same time. Because they both have access to
> the same fs_fd.

Unless you require privileges as outlined above to set delegation
options in which case an unprivileged container cannot change delegation
options at all.

> 
> > (2) userspace: A trusted helper that allocates an fs_context fd in
> >     the target user namespace, then sets delegation options and creates
> >     superblock.
> >
> > (1) Is more restrictive but also more secure. (2) is less restrictive
> > but requires more care from userspace.
> >
> > Either way I would probably consider writing a document detailing
> > various delegation scenarios and possible pitfalls and implications
> > before advertising it.
> >
> > If you choose (2) then you also need to be aware that the security of
> > this also hinges on bpffs not allowing to reconfigure parameters once it
> > has been mounted. Otherwise an unprivileged container can change
> > delegation options.
> >
> > I would recommend that you either add a dummy bpf_reconfigure() method
> > with a comment in it or you add a comment on top of bpf_context_ops.
> > Something like:
> >
> > /*
> >  * Unprivileged mounts of bpffs are owned by the user namespace they are
> >  * mounted in. That means unprivileged users can change vfs mount
> >  * options (ro<->rw, nosuid, etc.).
> >  *
> >  * They currently cannot change bpffs specific mount options such as
> >  * delegation settings. If that is ever implemented it is necessary to
> >  * require rivileges in the initial namespace. Otherwise unprivileged
> >  * users can change delegation options to whatever they want.
> >  */
> 
> Yep, I will add a custom callback. I think we can allow reconfiguring
> towards less permissive delegation subset, but I'll need to look at
> the specifics to see if we can support that easily.

