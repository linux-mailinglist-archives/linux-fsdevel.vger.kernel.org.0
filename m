Return-Path: <linux-fsdevel+bounces-34694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68F9C7BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FCC1F21D75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE117205AC3;
	Wed, 13 Nov 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/khNZcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EED1FDF92;
	Wed, 13 Nov 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524440; cv=none; b=X4EsNWpFIV0AkcfzAnV6Ln/ifx3JlOpF2NHYg2B1jXdq0uKe+4IgyHdkRdF/MOUdprEcc2fM5Y4HaFxoPd8wHNjfEc8zfJ7ixxW5v+RqW7q3WjmUbOESNzTbBcA9FIzNSiyVzpGzTeG/x00t1kyEvxYJEzJuUW7XZ//rWTZij40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524440; c=relaxed/simple;
	bh=b1+puPHkT0AChTOt3uIcKmaN6uEKmh5MR8MaKY6CHS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YogB0Di9QWn/m7jHxHiOMkvgv9ULeFQX9C+hg+f6FHlyPBxd1VXA4g1amq+xXzFET2Sq4LM0MatL70g6Q4aAovmijXlwrQHewpRmDgyQoW6LaPvUeFa0GqU7t2G8OscPtcdNNAv9+Pt2vC6qEN2skLNDGq4rKrsA07flsY2Gb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/khNZcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F5C4CED8;
	Wed, 13 Nov 2024 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731524440;
	bh=b1+puPHkT0AChTOt3uIcKmaN6uEKmh5MR8MaKY6CHS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/khNZcr3MVhPJiokpkNO7CDyueC9rlLJz0h56TzEmpBXyeKnyr7PDhxZw1Vle/PX
	 WzTOlqBBqb4bdf6J1s8l8PHyxElvppox9lXvIFs+eZ8OIGuWtp/CoHvUnyuX0vw+2O
	 ji7gXW8j61MvZ1513c4BRvxzlBG7YT5nNMg8T0l49msSmfEWBJLyGK2vyJPU3tssU3
	 vDKWBntGkeGusY2x4yHXm+EtKxOCEbx1Cd9qGvtMPDb8xtEpOvrLiSzIG/+OQFl0YV
	 pG63Ar+mrNVxLmOk8hcHeXFU1ajis/0TswmKAsXGCVx3ZR/dF2Xakyjpmvddxk6xq1
	 j8tjLxOywSoCw==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso30137805ab.3;
        Wed, 13 Nov 2024 11:00:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUO8fqCfBxpkode80aDkVZArfdr+zxKFWHzGpgBMZH1V/tLpdLOcYpUrwmWpMSGzTrYh0RpL2bYM5Zi1DsnZy3DCUb0c/ds@vger.kernel.org, AJvYcCVUtAv9ZJ5iUAwrBZ9Zi+aDnLGh4KPfvqy8uNYgsdbdM4wf8WyROc3HLabYQLVzo0nTZznFr7Pxyl/WGXZg@vger.kernel.org, AJvYcCWE1xs1uBNURKoxyQEE5R1EtIKvoquubdZayh/hwI1zi2bwm/KWw7Uzy4Mft93oOZpZzu9sRv5v8W4yZWuFig==@vger.kernel.org, AJvYcCXnXLG+4Y6KG77fvLUUwlwZklEaRVBrjnKJQzWPl70k9Bik8kkL02WmdN2PdI64HLCGUHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QtE03SkUlHswVanNFmbgerBZwgljUpmHf6WqjhnJiKIjXA30
	KROzW3e98CYMvSt7INm+fYuiNxQ3lZJcveSAt1uvHThl5xaSplmb5r1tG9yCQ3UK0ArHFcu2xv8
	abmcTItBnSkkYjyBYbk9CCw9kGHs=
X-Google-Smtp-Source: AGHT+IEyD1JNQ2N50AJWPofbvsRndiOlwf81eJD4grNn0AHa4+5VXXwYIQS3OOwAKbwT3MgMY5uMnZFAEfkl4lyIFfo=
X-Received: by 2002:a05:6e02:17cb:b0:3a6:c493:7396 with SMTP id
 e9e14a558f8ab-3a6f19a00bbmr232369695ab.3.1731524439437; Wed, 13 Nov 2024
 11:00:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner> <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>
 <1cd17944-8c1f-4b13-9ac5-912086fbead6@schaufler-ca.com>
In-Reply-To: <1cd17944-8c1f-4b13-9ac5-912086fbead6@schaufler-ca.com>
From: Song Liu <song@kernel.org>
Date: Wed, 13 Nov 2024 11:00:28 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4xt3fMtE_uQ8mzDt1yatZwhkj4LVu0zCoOqoyD2cxs9g@mail.gmail.com>
Message-ID: <CAPhsuW4xt3fMtE_uQ8mzDt1yatZwhkj4LVu0zCoOqoyD2cxs9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <songliubraving@meta.com>, Christian Brauner <brauner@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "jack@suse.cz" <jack@suse.cz>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "mattbobrowski@google.com" <mattbobrowski@google.com>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "repnop@google.com" <repnop@google.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"mic@digikod.net" <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 10:30=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 11/13/2024 6:15 AM, Song Liu wrote:
> > Hi Christian,
> >
> > Thanks for your review.
> >
> >> On Nov 13, 2024, at 2:19=E2=80=AFAM, Christian Brauner <brauner@kernel=
.org> wrote:
> > [...]
> >
> >>> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >>> index 3559446279c1..479097e4dd5b 100644
> >>> --- a/include/linux/fs.h
> >>> +++ b/include/linux/fs.h
> >>> @@ -79,6 +79,7 @@ struct fs_context;
> >>> struct fs_parameter_spec;
> >>> struct fileattr;
> >>> struct iomap_ops;
> >>> +struct bpf_local_storage;
> >>>
> >>> extern void __init inode_init(void);
> >>> extern void __init inode_init_early(void);
> >>> @@ -648,6 +649,9 @@ struct inode {
> >>> #ifdef CONFIG_SECURITY
> >>> void *i_security;
> >>> #endif
> >>> +#ifdef CONFIG_BPF_SYSCALL
> >>> + struct bpf_local_storage __rcu *i_bpf_storage;
> >>> +#endif
> >> Sorry, we're not growing struct inode for this. It just keeps getting
> >> bigger. Last cycle we freed up 8 bytes to shrink it and we're not goin=
g
> >> to waste them on special-purpose stuff. We already NAKed someone else'=
s
> >> pet field here.
> > Would it be acceptable if we union i_bpf_storage with i_security?
>
> No!
>
> > IOW, if CONFIG_SECURITY is enabled, we will use existing logic.
> > If CONFIG_SECURITY is not enabled, we will use i_bpf_storage.
> > Given majority of default configs have CONFIG_SECURITY=3Dy, this
> > will not grow inode for most users. OTOH, users with
> > CONFIG_SECURITY=3Dn && CONFIG_BPF_SYSCALL=3Dy combination can still
> > use inode local storage in the tracing BPF programs.
> >
> > Does this make sense?
>
> All it would take is one BPF programmer assuming that CONFIG_SECURITY=3Dn
> is the norm for this to blow up spectacularly.

I seriously don't understand what would blow up and how. Can you be
more specific?

Thanks,
Song

