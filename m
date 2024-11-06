Return-Path: <linux-fsdevel+bounces-33826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6D9BF7AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 20:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999861C21A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E120968F;
	Wed,  6 Nov 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R01XiqLH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F64199247;
	Wed,  6 Nov 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730923006; cv=none; b=se6RB8PS1HRv5JnIhPpcEwgXWaQWG/F46o5C0oIjP3sLA7muqjzCANAhwqfiDx08KzuPjqqVmqlHDjEPzZ3ZqNzpF5Jh7ykEW0XTx49isaljp0FJnXHq5gxFbWsPBpLz3D554hZpSBFsiOP9mrZBKIiPHPOn50d5jNws1YmokDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730923006; c=relaxed/simple;
	bh=3gDf54DnaNfDFqsq8szEsqsPmGsDuHA8DUSYSS5opg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjLrAuT+2fiprME2RC7N+KratkGefjpTg7Qhq6KqLM+WSpS51EwnKjZpX8tJZFvFKladWOzub9dc5akLL86n4NbhZWQ1b7TmSY2KsM/l9JxC5FrtNdXJasSYPBTLHzhZttDWWNg6oEnvUdIo+RdzhAlnIMNw0ys1+HtZoIoLqe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R01XiqLH; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e87153a3so141634a91.3;
        Wed, 06 Nov 2024 11:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730923004; x=1731527804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFrym7huHKnhZnS5680kXo5TCeGO5oAMT94uW6IHvOM=;
        b=R01XiqLHEMmaXauRU8sDL/hDSfZLKrpD/SpZWOJ3XTzk15miJXx1MB/lWflb/nhgYi
         /xwPAbelcNX0AehLldw35MlrGoafCVoEqPCvwJ0bggndtu9d+nKUSPw1SfPh/I7lMTyu
         OffppFrONknqxe4LrOJu3oA0FrjWTYqaGK0YbM+hluwibPafJ2aKh1jZUGVfSRpYmbAE
         m6xlIGmwG6bIM0czNU7iTxnSuaTaCrWJ49t8gjFaSfg3OfJuKFub+BuEkJn3hFrOnDQW
         X53WmoCavLEO5+o898hJgCgM+f/WcTU/VU/YOz0gC3GdI3NMr8F6y5+2Djr/NsnL6JZe
         H6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730923004; x=1731527804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFrym7huHKnhZnS5680kXo5TCeGO5oAMT94uW6IHvOM=;
        b=m5J4r6x+DV+lKzZWMx65gXgtJvtHZbRIblHlEWmACTZOkcS2YE7VHD78E2w6HgY9WQ
         LGPi24imyA99epxng5/tJsJc0TONAqJDDyVPIFWzu57oE40eRaN5ojNVKoyyw2V/O+/n
         T3vugXkg1BaK4wkDkRPwuRdDaCifi681XqxhcxclQ/j2nVT1RSSroVXOMz14tNuMSji9
         ZE0vzkSWLXZRC27oV9NR2tJ/JGs15tdO7ib7VmpsbSIJB2M14/PPXtiLDPRr1ghVYYzk
         sTk+3NhLzNUxOPfVNYG9U3VYQarHmHSSfUEhct79IuFMeJQ74X0ZCI4xomcCh6HWlktG
         V5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSF9oawm62buqmcPMMPzox1vF29SzQoqvKPTv3iOQuQxuR90xEMwge8ciONErS2F5Q+RHRNJoxGZPY7hcenA==@vger.kernel.org, AJvYcCVhZIhSEFGK55cEwPprSj+4CSavftRzFcHRVVsr3WWx6Kc6qqLUBkkPJiXtXO/nBhIapsmtdRYkVKJEKdMw@vger.kernel.org, AJvYcCWVXsLFZ2p9BYMTf4SSGz67H4ZCURy/tqm7Xp6PRLpPJug8xjXyJ2tz1DAQjG8nU71oQHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuuH2JmWPvFWawc4NIlPoAUiIhGV3Z+7OmyY0NHEowWnxfmd9
	tBPEksOa/sMKdlYW4uFVxPOyK8gpqs29iP7JgT5Ms4aftmpaMxSFp6o8LKf0W3ElH9/HyDpxvNx
	kGl2NJ3rBcYesyUN8yspa/L6xDxo=
X-Google-Smtp-Source: AGHT+IEe4hVOfXvlyno+5FcEtlkvLjjMkC5npFwTrVuGYMM1VnoMN0sNcb9Anij0vgzegNqtLU+CdkCvDMH+YhLDhuo=
X-Received: by 2002:a17:90b:1650:b0:2e2:b45f:53b4 with SMTP id
 98e67ed59e1d1-2e94c50d447mr29124283a91.25.1730923004182; Wed, 06 Nov 2024
 11:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584858690D5A02162502A02099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4BzadfF8iSAnhWFDNmXE80ayJXDkucbeg0jv-+=FtoDg5Zg@mail.gmail.com> <AM6PR03MB5848E2CFFC021ED762E347BE99562@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848E2CFFC021ED762E347BE99562@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Nov 2024 11:56:31 -0800
Message-ID: <CAEf4BzYujC7b7hbpXM9BoBzHrkX8JBpLT8XA-VL+uPk_NZfKrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf/crib: Add struct file related CRIB kfuncs
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:28=E2=80=AFPM Juntong Deng <juntong.deng@outlook.c=
om> wrote:
>
> On 2024/11/1 19:08, Andrii Nakryiko wrote:
> > On Tue, Oct 29, 2024 at 5:17=E2=80=AFPM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> This patch adds struct file related CRIB kfuncs.
> >>
> >> bpf_fget_task() is used to get a pointer to the struct file
> >> corresponding to the task file descriptor. Note that this function
> >> acquires a reference to struct file.
> >>
> >> bpf_get_file_ops_type() is used to determine what exactly this file
> >> is based on the file operations, such as socket, eventfd, timerfd,
> >> pipe, etc, in order to perform different checkpoint/restore processing
> >> for different file types. This function currently has only one return
> >> value, FILE_OPS_UNKNOWN, but will increase with the file types that
> >> CRIB supports for checkpoint/restore.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/bpf/crib/crib.c  |  4 ++++
> >>   kernel/bpf/crib/files.c | 44 +++++++++++++++++++++++++++++++++++++++=
++
> >>   2 files changed, 48 insertions(+)
> >>
> >
> > Please CC Christian Brauner and fs mailing list
> > (linux-fsdevel@vger.kernel.org, both cc'ed) on changes like this (this
> > entire patch set)
> >
>
> Thanks for your reply!
>
> I will CC Christian Brauner and fs mailing list in the next
> patch series.
>
> >> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
> >> index e6536ee9a845..78ddd19d5693 100644
> >> --- a/kernel/bpf/crib/crib.c
> >> +++ b/kernel/bpf/crib/crib.c
> >> @@ -14,6 +14,10 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER=
_NEXT | KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> >>   BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
> >>
> >> +BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_R=
ET_NULL)
> >> +BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
> >> +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
> >> +
> >>   BTF_KFUNCS_END(bpf_crib_kfuncs)
> >>
> >>   static const struct btf_kfunc_id_set bpf_crib_kfunc_set =3D {
> >> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
> >> index ececf150303f..8e0e29877359 100644
> >> --- a/kernel/bpf/crib/files.c
> >> +++ b/kernel/bpf/crib/files.c
> >> @@ -5,6 +5,14 @@
> >>   #include <linux/fdtable.h>
> >>   #include <linux/net.h>
> >>
> >> +/**
> >> + * This enum will grow with the file types that CRIB supports for
> >> + * checkpoint/restore.
> >> + */
> >> +enum {
> >> +       FILE_OPS_UNKNOWN =3D 0
> >> +};
> >> +
> >>   struct bpf_iter_task_file {
> >>          __u64 __opaque[3];
> >>   } __aligned(8);
> >> @@ -102,4 +110,40 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struc=
t bpf_iter_task_file *it)
> >>                  fput(kit->file);
> >>   }
> >>
> >> +/**
> >> + * bpf_fget_task() - Get a pointer to the struct file corresponding t=
o
> >> + * the task file descriptor
> >> + *
> >> + * Note that this function acquires a reference to struct file.
> >> + *
> >> + * @task: the specified struct task_struct
> >> + * @fd: the file descriptor
> >> + *
> >> + * @returns the corresponding struct file pointer if found,
> >> + * otherwise returns NULL
> >> + */
> >> +__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsi=
gned int fd)
> >> +{
> >> +       struct file *file;
> >> +
> >> +       file =3D fget_task(task, fd);
> >> +       return file;
> >> +}
> >> +
> >> +/**
> >> + * bpf_get_file_ops_type() - Determine what exactly this file is base=
d on
> >> + * the file operations, such as socket, eventfd, timerfd, pipe, etc
> >> + *
> >> + * This function will grow with the file types that CRIB supports for
> >> + * checkpoint/restore.
> >> + *
> >> + * @file: a pointer to the struct file
> >> + *
> >> + * @returns the file operations type
> >> + */
> >> +__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
> >> +{
> >> +       return FILE_OPS_UNKNOWN;
> >> +}
> >> +
> >
> > this is not very supportable, users can do the same by accessing
> > file->f_op and comparing it to a set of known struct file_operations
> > references.
> >
>
> Yes, users can access file->f_op, but there seems to be no way for
> users to get references to struct file_operations for the various file
> types? For example, how does a user get a reference to socket_file_ops?

See [0]. Libbpf will find it for the BPF program from kallsyms.

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/bpf/progs/test_ksyms.c#L13-L18

>
> Also, currently the struct file_operations for most of the file types
> are static, and I cannot even get a reference to them in
> crib/files.c directly.
>
> My future plan is to add functions like is_socket_file_ops to the
> corresponding files (e.g. net/socket.c).
>
> >>   __bpf_kfunc_end_defs();
> >> --
> >> 2.39.5
> >>
>

