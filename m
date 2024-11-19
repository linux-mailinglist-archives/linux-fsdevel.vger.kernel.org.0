Return-Path: <linux-fsdevel+bounces-35217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029049D298E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B8A28312C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F81D0175;
	Tue, 19 Nov 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqBjHQR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5F81CEAC8;
	Tue, 19 Nov 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029964; cv=none; b=FJaUM/CIZB95EDROquoC48dvmin4CUGxTATS7KwWYmjpxJPyppPYzJpF5Ohz+05M3s8AFq3LYjdCA0GnW0UFhYf0shKRGa9DLtWDStRG8NIswLydk3S9RSkDrsam85OHf3t+INUGmhTPSF1FccEnCSGgUzMoGaGB1Ss3csaQi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029964; c=relaxed/simple;
	bh=XGFJFA0Pb+X8dLV1bgWBosmY1QjO1cLIy7Ti2jNcu14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5B2sMlDJHsVJfzwVJvYwurRX/E21EYACAXk21ASE78aB86UqjUPAooG/1OL1iRkN6HPYfWbycdQFTleB9Hi2ywZE7ZXHhoot5oXyDaK1SuzqiRRBp4ou/mZndEwcbqdCNbyIxXK5JCiVEEE1ruGOP+v6kdr2kuMQa9dr380sD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqBjHQR/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so940333966b.0;
        Tue, 19 Nov 2024 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029961; x=1732634761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK8C27uKyKWzuTgVBXpkuQwVY8traPUvnr1dyQWjbb0=;
        b=kqBjHQR/DdhA7rTRHk2QgQ9N4Dcu0oF2nDznmsw1kGeXbt3SgztSL9KFNajp0nabXX
         Cj60i4QKQokzPJiptYEdXCjTAMT7rD+XOuc5mXjMg8FoDeBgKVvtSwn/hrrizpqjNc88
         KNK3ev1shX/+DYZuYpsxPqF/4BPgcieB0JVx16SGd/Nd8V1NnmA7BiMnZ/7YxOJp2mNL
         RKdp0ISIgc1JWYrq5NkaeProK/cHJZMeO45+jwi81N1JUi9m1VvPMqVz6JImw9d6Ggch
         KsiNNyjRt/8Jw8J6eK+sMjr9OdEKIybhZHS33QhhoqqN5EUwRKjn1ygwAnqkOZxwbNvC
         5Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029961; x=1732634761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK8C27uKyKWzuTgVBXpkuQwVY8traPUvnr1dyQWjbb0=;
        b=dmWqKJsSwPzA2d3EP6EzeH+A4jOim54a/ruo2k/B+P8/pgVPprFYGS8RfwIOyfsKou
         EtMPcMOrhmWVxBkd7uhylvff9dYYFBQ3JR0Yav6nL/IFS9VIH9ylcdqPs6wLod/2chL0
         1osmqhEHHyGFnwEbNvnxmkTyq4xfWhzaYI5d5o93FJD1xRLudD96TN3HMSdHG7+MPHjs
         +Ob9GuY8P98/zuvcumDE2+UENH57CuTb2vVPebVUr6CXTp4oHGXLNgdK8R7keUIGub8W
         KR80ObmbwxlxBHd5FSL3ww9mb1T1ZHRqMmhinZY57nbAQhHa7CtOEA7I7OP1QHMmhjVq
         4xtg==
X-Forwarded-Encrypted: i=1; AJvYcCUaAkmx3wJwTR4pQgOBKsHzRxwxVve81TcWddcbwwTVT54PH2Y7oasyFppnZmI4AYq66mk=@vger.kernel.org, AJvYcCV37oAWJHMxjX9hWwvE3htcLlFGMLkLF9fjXE0VWFRrKXQnEg+CvdtoREowTNTiuwScVpuZh0U0qgMeJrHN@vger.kernel.org, AJvYcCV5Ziu+AUutwnSgKIQbv4/BsGfTtqFaEiH9WrHcH6RYNCmwrQ+mKnfg1VWMa1j4JsroRFyBXiF+ta3SgPpQAE7cEeop06ep@vger.kernel.org, AJvYcCVZIYxL8mynQTjHxy9X2vvVjtHtvcysA7Uaxfhc9/samFfkhWDgMJAYTxq3G8Eap6xP54hB27dFIZW4O0fMpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdraSgZv7t/T8szmj92zJjT/nJMtbGgHaHzeqrO6bf+p0gvgYl
	RYHnyGD+pwViP8oEzfRdvMBDE0muL6siuoqXuOPVKkQ1wgojdPL36nQhNeY8nQR0ozUyuK/LwHr
	uFaY0sHnkSNkUo0iQERPQLaxqdTY=
X-Google-Smtp-Source: AGHT+IE6JJVR1xDspmHSXdwbi6cSAjCbWfc003DUiLj97RF+qYLTBw5EYQNLe8tbgCQCpyE+0Q0rzLCohLfCdc4EUUY=
X-Received: by 2002:a17:907:f79b:b0:aa4:ce42:fa7f with SMTP id
 a640c23a62f3a-aa4ce4304fcmr234765566b.7.1732029960623; Tue, 19 Nov 2024
 07:26:00 -0800 (PST)
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
In-Reply-To: <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Nov 2024 16:25:49 +0100
Message-ID: <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Jeff Layton <jlayton@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, Jan Kara <jack@suse.cz>, 
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

On Tue, Nov 19, 2024 at 3:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-11-15 at 17:35 +0000, Song Liu wrote:
> > Hi Jan,
> >
> > > On Nov 15, 2024, at 3:19=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
> >
> > [...]
> >
> > > > AFAICT, we need to modify how lsm blob are managed with
> > > > CONFIG_BPF_SYSCALL=3Dy && CONFIG_BPF_LSM=3Dn case. The solution, ev=
en
> > > > if it gets accepted, doesn't really save any memory. Instead of
> > > > growing struct inode by 8 bytes, the solution will allocate 8
> > > > more bytes to inode->i_security. So the total memory consumption
> > > > is the same, but the memory is more fragmented.
> > >
> > > I guess you've found a better solution for this based on James' sugge=
stion.
> > >
> > > > Therefore, I think we should really step back and consider adding
> > > > the i_bpf_storage to struct inode. While this does increase the
> > > > size of struct inode by 8 bytes, it may end up with less overall
> > > > memory consumption for the system. This is why.
> > > >
> > > > When the user cannot use inode local storage, the alternative is
> > > > to use hash maps (use inode pointer as key). AFAICT, all hash maps
> > > > comes with non-trivial overhead, in memory consumption, in access
> > > > latency, and in extra code to manage the memory. OTOH, inode local
> > > > storage doesn't have these issue, and is usually much more efficien=
t:
> > > > - memory is only allocated for inodes with actual data,
> > > > - O(1) latency,
> > > > - per inode data is freed automatically when the inode is evicted.
> > > > Please refer to [1] where Amir mentioned all the work needed to
> > > > properly manage a hash map, and I explained why we don't need to
> > > > worry about these with inode local storage.
> > >
> > > Well, but here you are speaking of a situation where bpf inode storag=
e
> > > space gets actually used for most inodes. Then I agree i_bpf_storage =
is the
> > > most economic solution. But I'd also expect that for vast majority of
> > > systems the bpf inode storage isn't used at all and if it does get us=
ed, it
> > > is used only for a small fraction of inodes. So we are weighting 8 by=
tes
> > > per inode for all those users that don't need it against more signifi=
cant
> > > memory savings for users that actually do need per inode bpf storage.=
 A
> > > factor in this is that a lot of people are running some distribution =
kernel
> > > which generally enables most config options that are at least somewha=
t
> > > useful. So hiding the cost behind CONFIG_FOO doesn't really help such
> > > people.
> >
> > Agreed that an extra pointer will be used if there is no actual users
> > of it. However, in longer term, "most users do not use bpf inode
> > storage" may not be true. As kernel engineers, we may not always notice
> > when user space is using some BPF features. For example, systemd has
> > a BPF LSM program "restrict_filesystems" [1]. It is enabled if the
> > user have lsm=3Dbpf in kernel args. I personally noticed it as a
> > surprise when we enabled lsm=3Dbpf.
> >
> > > I'm personally not *so* hung up about a pointer in struct inode but I=
 can
> > > see why Christian is and I agree adding a pointer there isn't a win f=
or
> > > everybody.
> >
> > I can also understand Christian's motivation. However, I am a bit
> > frustrated because similar approach (adding a pointer to the struct)
> > worked fine for other popular data structures: task_struct, sock,
> > cgroup.
> >
>
> There are (usually) a lot more inodes on a host than all of those other
> structs combined. Worse, struct inode is often embedded in other
> structs, and adding fields can cause alignment problems there.
>
>
> > > Longer term, I think it may be beneficial to come up with a way to at=
tach
> > > private info to the inode in a way that doesn't cost us one pointer p=
er
> > > funcionality that may possibly attach info to the inode. We already h=
ave
> > > i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always a =
tough
> > > call where the space overhead for everybody is worth the runtime &
> > > complexity overhead for users using the functionality...
> >
> > It does seem to be the right long term solution, and I am willing to
> > work on it. However, I would really appreciate some positive feedback
> > on the idea, so that I have better confidence my weeks of work has a
> > better chance to worth it.
> >
> > Thanks,
> > Song
> >
> > [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_=
fs/restrict-fs.bpf.c
>
> fsnotify is somewhat similar to file locking in that few inodes on the
> machine actually utilize these fields.
>
> For file locking, we allocate and populate the inode->i_flctx field on
> an as-needed basis. The kernel then hangs on to that struct until the
> inode is freed. We could do something similar here. We have this now:
>
> #ifdef CONFIG_FSNOTIFY
>         __u32                   i_fsnotify_mask; /* all events this inode=
 cares about */
>         /* 32-bit hole reserved for expanding i_fsnotify_mask */
>         struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> #endif
>
> What if you were to turn these fields into a pointer to a new struct:
>
>         struct fsnotify_inode_context {
>                 struct fsnotify_mark_connector __rcu    *i_fsnotify_marks=
;
>                 struct bpf_local_storage __rcu          *i_bpf_storage;
>                 __u32                                   i_fsnotify_mask; =
/* all events this inode cares about */
>         };
>

The extra indirection is going to hurt for i_fsnotify_mask
it is being accessed frequently in fsnotify hooks, so I wouldn't move it
into a container, but it could be moved to the hole after i_state.

> Then whenever you have to populate any of these fields, you just
> allocate one of these structs and set the inode up to point to it.
> They're tiny too, so don't bother freeing it until the inode is
> deallocated.
>
> It'd mean rejiggering a fair bit of fsnotify code, but it would give
> the fsnotify code an easier way to expand per-inode info in the future.
> It would also slightly shrink struct inode too.

This was already done for s_fsnotify_marks, so you can follow the recipe
of 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
and create an fsnotify_inode_info container.

Thanks,
Amir.

