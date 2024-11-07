Return-Path: <linux-fsdevel+bounces-33858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E39BFB29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 02:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096BF1F22590
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5608F5E;
	Thu,  7 Nov 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="motJX4ER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA928746E;
	Thu,  7 Nov 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941781; cv=none; b=ksB0PWlUVR3famCRZx4IMhNZuJ468l71c8RvxQv+BizbBv04y75B0cLUH3Z3A0+qs3RzIzjisgtcj/y5X8vdRC8Al0asTaofak2WqvfVktad1fhLjvf1LtdttsQR2CnI9CkbRlDjJpa36dDkPJsyxw6V3m46vizhmIkqXtGcAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941781; c=relaxed/simple;
	bh=pReaUPlwK5OiDeEdMbnij9Cd4msANnQrUGFQxRPOnJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku1sbgq2M6T6Rw9+/6BU0PyTQ2cXvYfPnBbF0K7K38IJrqUF/ZYyIpILP6/cXyQOTg+q2NkLo8RTCeZqwcA6/imYiZOcNG4Gj6rff/1rvVq12ZexMzhf6Y66Z+/EA+iKp7DeXURtawFbEhLAUpR461zXvmOyFjCoAizFjzPsPb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=motJX4ER; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso5118115e9.0;
        Wed, 06 Nov 2024 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730941778; x=1731546578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo4yRoNM1Vx5ijUBk6k0eOjAZcKvZu50tKHaCrVK/sU=;
        b=motJX4ERx4WBRYuSUm/ZBEtCe243AGOQSqdmkO4CTTNjmAH0WcyaCx6iNo9p4pTuSV
         ZYHxa0Gw69gNw4SOD9y81EeGTDsoewUUvWbXbpR4gmNCxFMVE4pEjnJ4tYU67UiiQWCR
         17UWLs2K9lZlvXgSLX1Nfis1u71E6U6Yzyhw2DJdHGKXZT0m12VWHMfyeHYx7aY0Usqo
         82HfFo5BzdZ7hPZHH6JWeOOrpVaZZ1d4DEcyA9ORKry4CwNoVqpk16YrqAP5fXtXCPEJ
         zPOdJ4OabxYfbHeN5ibcgQAeV1F2MRSYP6XrijMqrGmdXQPYcgx0Yy+Dc7vQ/yY2aK0A
         /fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730941778; x=1731546578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo4yRoNM1Vx5ijUBk6k0eOjAZcKvZu50tKHaCrVK/sU=;
        b=H4OFO/EhikVvw2fv/AJq8N3mfqMhBclt2uqZOjiHMyuEbmr5OhmoOvL/hPuINNxYau
         gzPbRFYaIVC09huVCoRblVgIP3dWSLXOM/jSYQ3eE/TZIt9o9Fi0eOiGYde99pxDDBXJ
         FOGdCTpqOo16o+l/4hpvdTce4DsqrzAAJf13GzSU7j1pRTZ4xx7ttgXS0EIGyXl6Ci0A
         h3vuXz15KVkWqzAJmWSNxANK5msv38xg1hKxc03JtEfpV7IgFVP5HFvwhiosR1kMgX/z
         hKjs/c0Avy1NYlyMBmsQQ1q25GzMifSrgJswHSAsUGe4QKvEtZaoF2g3mw0DiYbETiBz
         7ZsA==
X-Forwarded-Encrypted: i=1; AJvYcCUNDbJBih/Kr+kXf2uO4dDPwCWuDBO12s+iUnEV1oyqKrSYTEnjogLz580t2nJjdJRTKtROrU0KjFZKhACTiA==@vger.kernel.org, AJvYcCUtEyIhLs9dLEMrMHV+HApNsDPiqQMWn09Hdsdb/ZwlKUYhYb4FqvyWkKJEiTnBMojbEzE=@vger.kernel.org, AJvYcCW3fMmArNf6wP8kpr6hHSLnOGZMlFZknH7ta0TgE73cqZ3eG53X+DcdzpdBSPa/33i3r5xmz1chqJiDZp7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+UtNCNUI/ZuWHHqSNv9oAkirEuMWOncNJcI9AJPg7kx38Mvn
	PrAov0uORNrDffUKAIvMSGUQUc+sFsM93B8oA0Dn4RxlA/6IyDMO6SRGkcKvf6AFI8rIZMUQr3W
	PUsEqSxJIJiUOgc7vafbdZkDaqBU=
X-Google-Smtp-Source: AGHT+IEdZxJWJ2m1kuSw2wOu6sPdb35TFmGP/VXfdYQ2WMlEF0Vf+3hK3Ugh4oaF+oLcK1iaeJWL7X3+E83iNOPKqfg=
X-Received: by 2002:a05:600c:358b:b0:431:5533:8f0d with SMTP id
 5b1f17b1804b1-43283294bb6mr236043285e9.30.1730941777774; Wed, 06 Nov 2024
 17:09:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com> <AM6PR03MB58482B34E2470CA2126A490899532@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58482B34E2470CA2126A490899532@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Nov 2024 17:09:26 -0800
Message-ID: <CAADnVQ+Mn0KEJEiL79RXm2-1XCihqd+H61xxTqju9q6iANF4zA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf/crib: Introduce task_file open-coded
 iterator kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:31=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> On 2024/11/6 21:31, Alexei Starovoitov wrote:
> > On Wed, Nov 6, 2024 at 11:39=E2=80=AFAM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> This patch adds the open-coded iterator style process file iterator
> >> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> >> files opened by the specified process.
> >
> > This is ok.
> >
> >> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
> >> the file descriptor corresponding to the file in the current iteration=
.
> >
> > Unnecessary. Use CORE to read iter internal fields.
> >
> >> The reference to struct file acquired by the previous
> >> bpf_iter_task_file_next() is released in the next
> >> bpf_iter_task_file_next(), and the last reference is released in the
> >> last bpf_iter_task_file_next() that returns NULL.
> >>
> >> In the bpf_iter_task_file_destroy(), if the iterator does not iterate =
to
> >> the end, then the last struct file reference is released at this time.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/bpf/helpers.c   |  4 ++
> >>   kernel/bpf/task_iter.c | 96 ++++++++++++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 100 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 395221e53832..1f0f7ca1c47a 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -3096,6 +3096,10 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITE=
R_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS =
| KF_RCU_PROTECTED)
> >>   BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_A=
RGS)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NUL=
L)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> >> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> >> index 5af9e130e500..32e15403a5a6 100644
> >> --- a/kernel/bpf/task_iter.c
> >> +++ b/kernel/bpf/task_iter.c
> >> @@ -1031,6 +1031,102 @@ __bpf_kfunc void bpf_iter_task_destroy(struct =
bpf_iter_task *it)
> >>   {
> >>   }
> >>
> >> +struct bpf_iter_task_file {
> >> +       __u64 __opaque[3];
> >> +} __aligned(8);
> >> +
> >> +struct bpf_iter_task_file_kern {
> >> +       struct task_struct *task;
> >> +       struct file *file;
> >> +       int fd;
> >> +} __aligned(8);
> >> +
> >> +/**
> >> + * bpf_iter_task_file_new() - Initialize a new task file iterator for=
 a task,
> >> + * used to iterate over all files opened by a specified task
> >> + *
> >> + * @it: the new bpf_iter_task_file to be created
> >> + * @task: a pointer pointing to a task to be iterated over
> >> + */
> >> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
> >> +               struct task_struct *task)
> >> +{
> >> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> >> +
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(s=
truct bpf_iter_task_file));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> >> +                    __alignof__(struct bpf_iter_task_file));
> >> +
> >> +       kit->task =3D task;
> >
> > This is broken, since task refcnt can drop while iter is running.
> >
> > Before doing any of that I'd like to see a long term path for crib.
> > All these small additions are ok if they're generic and useful elsewher=
e.
> > I'm afraid there is no path forward for crib itself though.
> >
> > pw-bot: cr
>
> Thanks for your reply.
>
> The long-term path of CRIB is consistent with the initial goal, adding
> kfuncs to help the bpf program obtain process-related information.
>
> I think most of the CRIB kfuncs are generic, such as process file
> iterator, skb iterator, bpf_fget_task() that gets struct file based on
> file descriptor, etc.
>
> This is because obtaining process-related information is not a
> requirement specific to checkpoint/restore scenarios, but is
> required in other scenarios as well.
>
> Here I would like to quote your vision on LPC 2022 [0] [1].

:)

The reading part via iterators and access to kernel internals is fine,
but to complete CRIB idea the restore side is necessary and
for that bit I haven't heard a complete story that would be
acceptable upstream. At LPC the proposal was to add kfuncs
that will write into kernel data structures.
That part won't fly, since I don't see how one can make such
writing kfuncs safe. Restoring a socket, tcp connection, etc
is not a trivial process.
Just building a set of generic abstractions for reading is ok-ish,
since they're generic and reusable, but the end to end story
is necessary before we proceed.

