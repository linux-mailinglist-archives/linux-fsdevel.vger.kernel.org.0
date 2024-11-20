Return-Path: <linux-fsdevel+bounces-35289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E69D36FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9645BB29685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F271A2653;
	Wed, 20 Nov 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVXecClD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14B19DF61;
	Wed, 20 Nov 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094362; cv=none; b=P4wVze39n8l08w+M9U+l4vNRSRZMdpY7FKCu+EKyN3uJr80iMpje7U/sd0o8VtSw4WGXBeJnQ14FuVxVtcOToDY9+snjVhBXv+zNAXzSWz5s94ylIry87mp4WkC3IXC3CoU2WLrTW1/MJ259RQWt5EfZA/XSMIojyn8ivxN4jb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094362; c=relaxed/simple;
	bh=+vZX0PvjuSCczbJZYBYGnOxF/QVKYjXZWqVkLIzoRmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUhQjSBBvejA6+PMuLcANG7sjdhm3mkQr5lXb71rpJETM1LI3Ub2iYtrhIM6cUb/5zzwt2sjwktDTd2TrxhpQINTEeTY4x3KXFa26mLbyIRR4nO4mML5PNVV7rbjclsSPAosj98dUQi07JgUB4qclh1+DCfHtWhWfmw8pD8phG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVXecClD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99eb8b607aso251792666b.2;
        Wed, 20 Nov 2024 01:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732094358; x=1732699158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8n3vf4RNM4qlys+41E8i3NtCt2v32WFM9+NF4CAyKw=;
        b=eVXecClDmB7OiwZnR/Vn98ypXAbFBYnqc2hgToTMYeU9h1eniELan/INSJznzSxh//
         n/9EUviIEW4oewFAuEJzENXsobXaDxK1SOIfxYaNnyS3tcSLE/EeCE8ji33LJ3BhGCDE
         DM/+xruhiqjJBgAVyMqcQxF2R9vOWCZtt/dzwczumpKSsrFDCkdoBaKG4Hgq6jAdYSpo
         o0prZXFINPH1WzPKXwvRzDYIrfBnyPjerHEMfq37iRwp3NbUmdxwBQAU7slFtQDTZZcz
         0/3Qcz8r7g2C6P0I3qJxN8+0fChwMz9+9l+jOI/SpzwyfWkBLp86xjJNv3+dRJgTAJvl
         7Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094358; x=1732699158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8n3vf4RNM4qlys+41E8i3NtCt2v32WFM9+NF4CAyKw=;
        b=U+CwUBaS+cFn62U0TDgmI99PRgnQkkvjkVEr9eRYOBTScOCbh5jLoDeCQEXP6Yi/+Z
         hYqeZKAgzr7gCJXSQES6Yq/7lYwyM5Q+TIGAZuldffWkGvjfrs9SwgG4nSBvLIfXbhB1
         moRJ5GrqdPp32CKkyjtJYRL/Z5hxh51v5xD/rQ/H7iW3KczExbwj7NotzjLNsqzjXCUZ
         BS2ajYYBqFmZMA76XG6a4AGzcDrU5cZmJcG3p9Yrz6nHoblxMwXRoRW1gmGNAULwxLe0
         i3xitbMGPmZYW8A0xyimu0AnZaUlQTMq4W7KT7uoDZaQuSZNQuO1CbLzNvfCrzZXVZK9
         ILew==
X-Forwarded-Encrypted: i=1; AJvYcCUtidJAZGvqHFPLhzJ9Rky5QPbphMYf3D8NIP6l/C2RvdpCjUZ4tZSfBikjQbtEW+yZcWjp43+bR24lLyvFtZkgIBpa85XB@vger.kernel.org, AJvYcCV9HFwit4nd2EddSsGYC1u8Uiru9+H2MdOP7JftQtjaQ6e0sEZyYX0yQxudUbrSJCoCZxKeHsypesZA88mp@vger.kernel.org, AJvYcCXail5LcarvI4nTlVHXQHTrbJnDhMS92AWid8aZbCqMXX3e+De7DQlvDMR5Ahqmmwf4gp4=@vger.kernel.org, AJvYcCXu32baFeiQoiJBxXD8zID86bqtkXiUMFYYxcxQlnLPu4tt6I3dZi3HH0nbN8SPEqmQ9+qsk6o+XIWhtrR2uA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjhb73BDI/493rolzmLTQkQu8uURXwhnPS6Y0anvuRHj1Fx0aK
	paocQK6QllkY86R2G4zbMEDK+tESpaUGwqvP+jbtc9TKo0ipzY8d8mRCGb59LhwwrvElm3js1E7
	iDQOrt3pgX9FOWr3t9o46blYLL18=
X-Gm-Gg: ASbGnctIXB9NrcgT3mWrX0hzitAm3CeNt+IrH36Izp9hhARgRDXFS/MaqhD4pd5eswz
	rRzkNS42fOxAYBSmTV5DOl43ArkBC1y4=
X-Google-Smtp-Source: AGHT+IEZ8vlYmTDzRsuHIJ6oEJmBcXkw3VAVL+TC3bIQQ/G8+Q9u5ldjdijQXXPfgt/R5p9AkLO2NIcZQJa0nX2aUwY=
X-Received: by 2002:a17:907:2da2:b0:a9e:c4d2:fff0 with SMTP id
 a640c23a62f3a-aa4dd70a3e0mr173159366b.45.1732094357449; Wed, 20 Nov 2024
 01:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner> <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3> <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com> <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
In-Reply-To: <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 10:19:05 +0100
Message-ID: <CAOQ4uxgSD=WCFYyBWm0kpD4pv+hwCWw7BQxTge8kK4A397t_9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Song Liu <songliubraving@meta.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "repnop@google.com" <repnop@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:53=E2=80=AFPM Song Liu <songliubraving@meta.com>=
 wrote:
>
> Hi Jeff and Amir,
>
> Thanks for your inputs!
>
> > On Nov 19, 2024, at 7:30=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Tue, Nov 19, 2024 at 4:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >>
> >> On Tue, Nov 19, 2024 at 3:21=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> >>>
>
> [...]
>
> >>> Longer term, I think it may be beneficial to come up with a way to at=
tach
> >>>>> private info to the inode in a way that doesn't cost us one pointer=
 per
> >>>>> funcionality that may possibly attach info to the inode. We already=
 have
> >>>>> i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always =
a tough
> >>>>> call where the space overhead for everybody is worth the runtime &
> >>>>> complexity overhead for users using the functionality...
> >>>>
> >>>> It does seem to be the right long term solution, and I am willing to
> >>>> work on it. However, I would really appreciate some positive feedbac=
k
> >>>> on the idea, so that I have better confidence my weeks of work has a
> >>>> better chance to worth it.
> >>>>
> >>>> Thanks,
> >>>> Song
> >>>>
> >>>> [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restri=
ct_fs/restrict-fs.bpf.c
> >>>
> >>> fsnotify is somewhat similar to file locking in that few inodes on th=
e
> >>> machine actually utilize these fields.
> >>>
> >>> For file locking, we allocate and populate the inode->i_flctx field o=
n
> >>> an as-needed basis. The kernel then hangs on to that struct until the
> >>> inode is freed.
>
> If we have some universal on-demand per-inode memory allocator,
> I guess we can move i_flctx to it?
>
> >>> We could do something similar here. We have this now:
> >>>
> >>> #ifdef CONFIG_FSNOTIFY
> >>>        __u32                   i_fsnotify_mask; /* all events this in=
ode cares about */
> >>>        /* 32-bit hole reserved for expanding i_fsnotify_mask */
> >>>        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> >>> #endif
>
> And maybe some fsnotify fields too?
>
> With a couple users, I think it justifies to have some universal
> on-demond allocator.
>
> >>> What if you were to turn these fields into a pointer to a new struct:
> >>>
> >>>        struct fsnotify_inode_context {
> >>>                struct fsnotify_mark_connector __rcu    *i_fsnotify_ma=
rks;
> >>>                struct bpf_local_storage __rcu          *i_bpf_storage=
;
> >>>                __u32                                   i_fsnotify_mas=
k; /* all events this inode cares about */
> >>>        };
> >>>
> >>
> >> The extra indirection is going to hurt for i_fsnotify_mask
> >> it is being accessed frequently in fsnotify hooks, so I wouldn't move =
it
> >> into a container, but it could be moved to the hole after i_state.
>
> >>> Then whenever you have to populate any of these fields, you just
> >>> allocate one of these structs and set the inode up to point to it.
> >>> They're tiny too, so don't bother freeing it until the inode is
> >>> deallocated.
> >>>
> >>> It'd mean rejiggering a fair bit of fsnotify code, but it would give
> >>> the fsnotify code an easier way to expand per-inode info in the futur=
e.
> >>> It would also slightly shrink struct inode too.
>
> I am hoping to make i_bpf_storage available to tracing programs.
> Therefore, I would rather not limit it to fsnotify context. We can
> still use the universal on-demand allocator.
>
> >>
> >> This was already done for s_fsnotify_marks, so you can follow the reci=
pe
> >> of 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
> >> and create an fsnotify_inode_info container.
> >>
> >
> > On second thought, fsnotify_sb_info container is allocated and attached
> > in the context of userspace adding a mark.
> >
> > If you will need allocate and attach fsnotify_inode_info in the content=
 of
> > fast path fanotify hook in order to add the inode to the map, I don't
> > think that is going to fly??
>
> Do you mean we may not be able to allocate memory in the fast path
> hook? AFAICT, the fast path is still in the process context, so I
> think this is not a problem?

Right. that should be ok.

Thanks,
Amir.

