Return-Path: <linux-fsdevel+bounces-35218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45A9D29A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E6C1F232A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA91D0178;
	Tue, 19 Nov 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa09hhh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFF1CBEAD;
	Tue, 19 Nov 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030245; cv=none; b=BaD+pIm5EAuuJdZ3TB9uqGVBOjlYDlvOm+ihU6Li8IOKKhtxKvhC4l/jZEvxiKoAUqOidOyqTEvrg/Lz1qekRh0DQdxzUv+wQ7hbWu6G0GEjmxNS6dphqiRjYuWcJNJypcD8Rjj3419rUQM3AXZSOsrGxH2YvOEkV5HFybbl+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030245; c=relaxed/simple;
	bh=0l68236m+d1U0qZf6vvK/HHF8L8fwKfJF4Q6N2KuAgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJXB/HgibQZ+sVc/YaqUuOuEvOWJskTeyd4Blx4tljNqG/O6SK32yd9Rs2Oau/cBerbnU2hhaBsW/+8zjh4msNY++NhBIMKNxoA3YFxTW1CNnOkzLrB3K1srQHRVQOq5k1P1dEk9LxukjzFro1Bsx0tIpBHq5Rj8V+nd+hcdGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa09hhh4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ec267b879so736392166b.2;
        Tue, 19 Nov 2024 07:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030242; x=1732635042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTh3Pm1HhT7mhO94+Ldu2gIZs1fQFE6vJRGHe3q/UIw=;
        b=Sa09hhh4EITKyChFaxSrKDgiJdWED16EVRHxySzQag5iA8sAMIN4gskdXSYXsNu/mz
         f0sB6pF/LeJG8HaYm442/EbnMl7ZCTISIcSqoc75CkJy4MW/j1TNDgEsSMMG4Zqle2ug
         nl1yebrIe8BtYBQVEKWEKdWW3G/V/n7SKmqDIPr6W/tSNAqhv3fmsY8rsaX2RXdynvsP
         pf6Vx/Uka3agr5coq/WrTL2pDEcViujPgaKe0vse94REl+xGlFBNsyVsNJtWjzIJC4s+
         R1WA4CXRZOmkVpdDFDZDL1BtMg0WJyWfxBKTi8tOYqYXi4MIdkxFnwTDYxcWWMY5vYBR
         eaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030242; x=1732635042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTh3Pm1HhT7mhO94+Ldu2gIZs1fQFE6vJRGHe3q/UIw=;
        b=Siw3G8iePfgqdYQZ+he2RjX+61YfokyvQBYqwtQi6hGHa3dAt0OXRg4+Am42ED0OWv
         2eO51VgJ/9IKjZJTdwY7DPnO/g34JfNJL4l0FZuMxkBEhrtr3We+0PP7WqhhfDAZC55f
         bK7Dq7pBGpAtekDl4+BgUpIt5B5zDkoXbtl7SHHuYn+MZed4pG+1RSK43ydVdoHVHq3+
         GH0sFkvz8hLAuZM6j6sei+d9/qBR8SlXYEGPne5ug8+tYNOf3Qsh8Ca1pioH3/gCuzS9
         ndtkgK4gVOXfiujcukTUWHw5dABmX2LTqMfiCfWck73+NmRjxvJSo8IVnDj+8e//WCs/
         g7/w==
X-Forwarded-Encrypted: i=1; AJvYcCW32p0cglqm56awYv309bZZd99WKrsoMNRDGtju9qWYn6ImXr6lGxHkfQx5B4pH2fkS8aU5qpeVhhgLtfMa2A==@vger.kernel.org, AJvYcCW5qN1jBSq+0O2pJrg3b7M3KimkmZIH5/RFcWXFepQU+IKhcee69hsSDF7/8I7dGKNMsOzbKA8pIc1DMHQd@vger.kernel.org, AJvYcCWmXS5MZsJjqdRZrXWMaIxjbSloyw2AUe6aFWTZh7maWjhLzMlt9ZVL3fbMnTiYcHhD+9cbq19rRDQIlNUqQoJPBhbPhGmb@vger.kernel.org, AJvYcCWwshfgRdPMeYxwccxgXe0fWIlXt8yeGjjY6zLStAy5tjjNblJ/ya5uDSDJS0nL6voNu8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKUzEZCaGd6eNgYnjZO3dueILvIIErB/qQY9S/9prL0/Z1KWt
	VOxXuvYP9ik/KoyB7QKJa1YZ9FmT0DJw//T+RWuDg4yULGJJ+sxc34EEGitONU4Qd5luutqV0jv
	9QjdRcGDguMPpTPjkxJdhpQUhuqg=
X-Google-Smtp-Source: AGHT+IHJ/Q6yFJTPMGKhQd7/RsyLpC/uS3vZwNIXI0m6yZaCZ0ouC/Iqk8rWH5+DhL/qsz5x9wt+tTOPOsUrf+QtVFM=
X-Received: by 2002:a17:906:b196:b0:aa4:9848:b4c1 with SMTP id
 a640c23a62f3a-aa49848b870mr996078466b.20.1732030241358; Tue, 19 Nov 2024
 07:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner> <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3> <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org> <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Nov 2024 16:30:30 +0100
Message-ID: <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 4:25=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Nov 19, 2024 at 3:21=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >
> > On Fri, 2024-11-15 at 17:35 +0000, Song Liu wrote:
> > > Hi Jan,
> > >
> > > > On Nov 15, 2024, at 3:19=E2=80=AFAM, Jan Kara <jack@suse.cz> wrote:
> > >
> > > [...]
> > >
> > > > > AFAICT, we need to modify how lsm blob are managed with
> > > > > CONFIG_BPF_SYSCALL=3Dy && CONFIG_BPF_LSM=3Dn case. The solution, =
even
> > > > > if it gets accepted, doesn't really save any memory. Instead of
> > > > > growing struct inode by 8 bytes, the solution will allocate 8
> > > > > more bytes to inode->i_security. So the total memory consumption
> > > > > is the same, but the memory is more fragmented.
> > > >
> > > > I guess you've found a better solution for this based on James' sug=
gestion.
> > > >
> > > > > Therefore, I think we should really step back and consider adding
> > > > > the i_bpf_storage to struct inode. While this does increase the
> > > > > size of struct inode by 8 bytes, it may end up with less overall
> > > > > memory consumption for the system. This is why.
> > > > >
> > > > > When the user cannot use inode local storage, the alternative is
> > > > > to use hash maps (use inode pointer as key). AFAICT, all hash map=
s
> > > > > comes with non-trivial overhead, in memory consumption, in access
> > > > > latency, and in extra code to manage the memory. OTOH, inode loca=
l
> > > > > storage doesn't have these issue, and is usually much more effici=
ent:
> > > > > - memory is only allocated for inodes with actual data,
> > > > > - O(1) latency,
> > > > > - per inode data is freed automatically when the inode is evicted=
.
> > > > > Please refer to [1] where Amir mentioned all the work needed to
> > > > > properly manage a hash map, and I explained why we don't need to
> > > > > worry about these with inode local storage.
> > > >
> > > > Well, but here you are speaking of a situation where bpf inode stor=
age
> > > > space gets actually used for most inodes. Then I agree i_bpf_storag=
e is the
> > > > most economic solution. But I'd also expect that for vast majority =
of
> > > > systems the bpf inode storage isn't used at all and if it does get =
used, it
> > > > is used only for a small fraction of inodes. So we are weighting 8 =
bytes
> > > > per inode for all those users that don't need it against more signi=
ficant
> > > > memory savings for users that actually do need per inode bpf storag=
e. A
> > > > factor in this is that a lot of people are running some distributio=
n kernel
> > > > which generally enables most config options that are at least somew=
hat
> > > > useful. So hiding the cost behind CONFIG_FOO doesn't really help su=
ch
> > > > people.
> > >
> > > Agreed that an extra pointer will be used if there is no actual users
> > > of it. However, in longer term, "most users do not use bpf inode
> > > storage" may not be true. As kernel engineers, we may not always noti=
ce
> > > when user space is using some BPF features. For example, systemd has
> > > a BPF LSM program "restrict_filesystems" [1]. It is enabled if the
> > > user have lsm=3Dbpf in kernel args. I personally noticed it as a
> > > surprise when we enabled lsm=3Dbpf.
> > >
> > > > I'm personally not *so* hung up about a pointer in struct inode but=
 I can
> > > > see why Christian is and I agree adding a pointer there isn't a win=
 for
> > > > everybody.
> > >
> > > I can also understand Christian's motivation. However, I am a bit
> > > frustrated because similar approach (adding a pointer to the struct)
> > > worked fine for other popular data structures: task_struct, sock,
> > > cgroup.
> > >
> >
> > There are (usually) a lot more inodes on a host than all of those other
> > structs combined. Worse, struct inode is often embedded in other
> > structs, and adding fields can cause alignment problems there.
> >
> >
> > > > Longer term, I think it may be beneficial to come up with a way to =
attach
> > > > private info to the inode in a way that doesn't cost us one pointer=
 per
> > > > funcionality that may possibly attach info to the inode. We already=
 have
> > > > i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always =
a tough
> > > > call where the space overhead for everybody is worth the runtime &
> > > > complexity overhead for users using the functionality...
> > >
> > > It does seem to be the right long term solution, and I am willing to
> > > work on it. However, I would really appreciate some positive feedback
> > > on the idea, so that I have better confidence my weeks of work has a
> > > better chance to worth it.
> > >
> > > Thanks,
> > > Song
> > >
> > > [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/restric=
t_fs/restrict-fs.bpf.c
> >
> > fsnotify is somewhat similar to file locking in that few inodes on the
> > machine actually utilize these fields.
> >
> > For file locking, we allocate and populate the inode->i_flctx field on
> > an as-needed basis. The kernel then hangs on to that struct until the
> > inode is freed. We could do something similar here. We have this now:
> >
> > #ifdef CONFIG_FSNOTIFY
> >         __u32                   i_fsnotify_mask; /* all events this ino=
de cares about */
> >         /* 32-bit hole reserved for expanding i_fsnotify_mask */
> >         struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > #endif
> >
> > What if you were to turn these fields into a pointer to a new struct:
> >
> >         struct fsnotify_inode_context {
> >                 struct fsnotify_mark_connector __rcu    *i_fsnotify_mar=
ks;
> >                 struct bpf_local_storage __rcu          *i_bpf_storage;
> >                 __u32                                   i_fsnotify_mask=
; /* all events this inode cares about */
> >         };
> >
>
> The extra indirection is going to hurt for i_fsnotify_mask
> it is being accessed frequently in fsnotify hooks, so I wouldn't move it
> into a container, but it could be moved to the hole after i_state.
>
> > Then whenever you have to populate any of these fields, you just
> > allocate one of these structs and set the inode up to point to it.
> > They're tiny too, so don't bother freeing it until the inode is
> > deallocated.
> >
> > It'd mean rejiggering a fair bit of fsnotify code, but it would give
> > the fsnotify code an easier way to expand per-inode info in the future.
> > It would also slightly shrink struct inode too.
>
> This was already done for s_fsnotify_marks, so you can follow the recipe
> of 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
> and create an fsnotify_inode_info container.
>

On second thought, fsnotify_sb_info container is allocated and attached
in the context of userspace adding a mark.

If you will need allocate and attach fsnotify_inode_info in the content of
fast path fanotify hook in order to add the inode to the map, I don't
think that is going to fly??

Thanks,
Amir.

