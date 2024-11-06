Return-Path: <linux-fsdevel+bounces-33830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA1C9BF8EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20D91C21D7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA920CCF6;
	Wed,  6 Nov 2024 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxPrk8jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1065E1DFE13;
	Wed,  6 Nov 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931022; cv=none; b=eiXiO7NYA4/mtZHNEj0YTYwRWBmui3PPOacDaCTdm0cGtelqag5koHT55mnUD6J76aV/zuexGS7rvEPuAEFWzQnZzclcHX+GWGZiBhEliDPd+amojZT1oeiuxBTP9R/O0pjYvJEwYUSJhzObua+EMZeTV/q/4Q7C/B0PisHRZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931022; c=relaxed/simple;
	bh=MzmDmWYqBogOFhNpsnduBcvuDwaAFS6ndPzfR0Glz2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvmalVS3/5Q0PWKIwRDuxrCQOl0YpPZ7pQEcptkNfPLASkOWSE1erP6TE16CHrseiq/YyDQV1NSPLx6XPlpi1M8mfWYGTR/cqRdTSAV8nXzYd/r9qsOaCuYCjjPyKbLPc6IGpifnzAJf4krOdCgN9JlflwNd9SAasqRF4NY/6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxPrk8jg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cf6eea3c0so3744015ad.0;
        Wed, 06 Nov 2024 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730931020; x=1731535820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbQPTGHZO+Rsg4AP3Nwn34Yw4SOAMi3fH85r8C2FTLM=;
        b=NxPrk8jghRlrWnnPQ9GFe7NMiOheZFHncAAKf9i7/h7+quN+EepgEmONX6A+4c/nsz
         eHcKUH57xvCma4AB+IijBdHABivpD2l+JPgbCZpm/lr91TI3rnjoRcUD0d9YWpawJfTK
         NS10n28957dgErWo/RX+ODK3e8sUrHWXo96uCzoWRCZbwY5Dxg+OSAwpm9Hz1JNEMwW2
         yCnph+yLRdhLtuuvG7/G5k3cjc/h6MqAcrX2n+Vn8/5H+p/l8Yvh5BRHd9wDVtMd1LGD
         j17wvOD1gombrzfLfBxxL4jav9k0I3imXqkXHw3xZh8OxWNvD/nA43wADN4HBRm1N9JZ
         eOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931020; x=1731535820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbQPTGHZO+Rsg4AP3Nwn34Yw4SOAMi3fH85r8C2FTLM=;
        b=Okx3GcyVkQMyzAN6KpAvKUq+L8Bj1fOrivVZFBdKnjE6ILICGavGqCF3nAoFdh01aV
         5Bq0MH6fGTV/fuThVRrM7+lshu+wcB3/m6nNS5jyNxNqCTovIqPG03OT6gvl6SrY3Pza
         yKe0jr3aXiZnU0hB2ELYBjzVBmhlsB4z6JSq2UkfoA+TKenAKKWQNf3g8TG2eFFWN8Yt
         kxxnDpCDVVGMqb/N3OBHXwfB9Fh9Musg+S+IQ1BimhkvXy5pIPR2FKrZ1EeXENnFqs1+
         ngQnvUUJyFF7j7tpp95HkGFF0Y/Cgnfgh38aB5i94fp2+Y7KBypTqOHETXR1N7RVm6OO
         P0eA==
X-Forwarded-Encrypted: i=1; AJvYcCW4C59NATg/ojUPDC7C4OAHDMHb5blzitZRJDyVDnauqpLfLu/Z0wXyAobkg1U5hKWkkJDAtRMfiJ5tqIxQ@vger.kernel.org, AJvYcCW8l9yj1L1lwq927n5RKDYDUfUNZvQ/eKPn+B5ljwntbEKS0RaeydEmNeUHMyTlOH98LxKseQf+3UT0DDzRyg==@vger.kernel.org, AJvYcCWORI9FAHg4N2Rbw6OkIotag8QwBi6/HFNgM4flko6YVYzi9O26gMwCbtQyy7lUfoRiIwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wQvoDbPFiOSLSRGxZQcfMSGwWHyocRPxrCHeFQuW9iYy1bXi
	pAxYoLtDgiauUEdFmfkKO9/6KyZ8YNLIH9O1qFgJvpBKV7zBT5/7Ebze7kERuzfGlL8bB+Z738x
	2hiii71vGroEkAb4MRPxA9zc0bi4=
X-Google-Smtp-Source: AGHT+IHH9yZO/DKtwvEzGpoug1M5WPDBbJLKXmeBIcv6m8OlpYBpP7Vk2ZpKe1VWlKtji/4Vwy7foR5eixKmCL9+z1g=
X-Received: by 2002:a17:903:244d:b0:20c:bb35:dae2 with SMTP id
 d9443c01a7336-210c69e1c8emr539563395ad.28.1730931020245; Wed, 06 Nov 2024
 14:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
In-Reply-To: <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 14:10:08 -0800
Message-ID: <CAEf4BzYib5jyu90tJYSTEmhpZ-4aF135719V+A7J7pzMj7RpNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 1:32=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 6, 2024 at 11:39=E2=80=AFAM Juntong Deng <juntong.deng@outloo=
k.com> wrote:
> >
> > This patch adds the open-coded iterator style process file iterator
> > kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> > files opened by the specified process.
>
> This is ok.
>
> > In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
> > the file descriptor corresponding to the file in the current iteration.
>
> Unnecessary. Use CORE to read iter internal fields.

+1, I suggested to use __ksym approach and compare to f_op

>
> > The reference to struct file acquired by the previous
> > bpf_iter_task_file_next() is released in the next
> > bpf_iter_task_file_next(), and the last reference is released in the
> > last bpf_iter_task_file_next() that returns NULL.
> >
> > In the bpf_iter_task_file_destroy(), if the iterator does not iterate t=
o
> > the end, then the last struct file reference is released at this time.
> >
> > Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> > ---
> >  kernel/bpf/helpers.c   |  4 ++
> >  kernel/bpf/task_iter.c | 96 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 395221e53832..1f0f7ca1c47a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -3096,6 +3096,10 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER=
_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | =
KF_RCU_PROTECTED)
> >  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> > +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_AR=
GS)
> > +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL=
)
> > +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> > +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
> >  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> > diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> > index 5af9e130e500..32e15403a5a6 100644
> > --- a/kernel/bpf/task_iter.c
> > +++ b/kernel/bpf/task_iter.c
> > @@ -1031,6 +1031,102 @@ __bpf_kfunc void bpf_iter_task_destroy(struct b=
pf_iter_task *it)
> >  {
> >  }
> >
> > +struct bpf_iter_task_file {
> > +       __u64 __opaque[3];
> > +} __aligned(8);
> > +
> > +struct bpf_iter_task_file_kern {
> > +       struct task_struct *task;
> > +       struct file *file;
> > +       int fd;
> > +} __aligned(8);
> > +
> > +/**
> > + * bpf_iter_task_file_new() - Initialize a new task file iterator for =
a task,
> > + * used to iterate over all files opened by a specified task
> > + *
> > + * @it: the new bpf_iter_task_file to be created
> > + * @task: a pointer pointing to a task to be iterated over
> > + */
> > +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
> > +               struct task_struct *task)
> > +{
> > +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(st=
ruct bpf_iter_task_file));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> > +                    __alignof__(struct bpf_iter_task_file));
> > +
> > +       kit->task =3D task;
>
> This is broken, since task refcnt can drop while iter is running.

I noticed this as well, but I thought that given KF_TRUSTED_ARGS we
should have a guarantee that the task survives the iteration? Am I
mistaken?

>
> Before doing any of that I'd like to see a long term path for crib.
> All these small additions are ok if they're generic and useful elsewhere.
> I'm afraid there is no path forward for crib itself though.
>
> pw-bot: cr

