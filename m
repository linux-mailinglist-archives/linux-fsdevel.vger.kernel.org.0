Return-Path: <linux-fsdevel+bounces-33497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D939B9819
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 20:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2866F1C21753
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CB1CF280;
	Fri,  1 Nov 2024 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mha3ZbcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366511CEAA0;
	Fri,  1 Nov 2024 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488147; cv=none; b=dWw9Qm+nb5FYCVDmLJiQd+4aOG9/IS/q+sr4gpRv4bdLDmgBAWmN2nM1a72vDTJDZbcbt+ZewNUVqFbuYrEkTbnpXNroeMIUKhU1ZQuLrIf4J05RpJ+UU3yXkGN0/RBK7msre8Cw/FcoiOp4GPIA54U22SxW/i5YwEaVQe+9j6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488147; c=relaxed/simple;
	bh=dOhNJ4bqsltqosWvK48KtLLJ8Qr3/+aIrxC5qXMR0c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0lwnWIj4DiABLKKnXzYMSIhrbAP9ly/z2fBb6BIuBfS706B+MNnf2kJ4HnXUzccOwt1DxqmLz2FYqSSMEdddnV1Lwrp5zITk8AhsNQGM0uKci5YVv9eQjJ5p8zcNQeY0XOkC7ynsb5oesXp63YeBCrTW/BG1kq2Kn/IDJzhVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mha3ZbcX; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1728649a12.0;
        Fri, 01 Nov 2024 12:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730488145; x=1731092945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3Qb1j+K9O3bLKE8Y4bg9cUjItGlHhRFoYyNHvp2j38=;
        b=Mha3ZbcX4POVTZ1BLshQByFshhUw3tVTb2ULwVxsHm6rp8mxQHlzjzXMFUlF5+6ENg
         bDj67ZA8v5Sm+rE65E88xPYhKT9AylgRtquWjeVwEecytqdbAA8PptvzUN2gMd+V3ebm
         FESMlRhf4Dt8RBIZzu7TMrjffSxAYDcnk1GRmBWG5PBFZS40n88lEFC03n52QuwXd1UH
         RtEoGzZ1bvboPSaEc+4ISz/xzAZECm/04ELISoggjkJMfAADAniYvXCUbeN7vQY5cQl+
         ZzqlQKQkvCE8NesnY1NKR+daJt0tdBDmKNvemthXJXu8IJjMLc2DSt4CzeIb4H1NUlgX
         IlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488145; x=1731092945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3Qb1j+K9O3bLKE8Y4bg9cUjItGlHhRFoYyNHvp2j38=;
        b=Q9YQlL7GhIb1M8QboPtCD+Um8Gc1vS2A1aRIacxXiXbytVLYAwlIaQeMibv++W9quc
         VF2UMg73/ME3EekHwUFtBx8aQaHUZANC7uoM8QzL3yCdlY0ebN65EmQvdM5l57rk0A8X
         XVWM5cFmhHxDdAiJScuP4k6pTFhXSwxMIX9ysLBeyCV8HWCVw80yMImepTf+WmEagm/5
         vQfe6n+v+voNWBTD1i0OPvqcXJ73XSuyDg+RW0CHFXEH2DR9PKJbw4fImkoO45QbOaZt
         /EWiSh8jwbiVgUdEPpfDvbDeI5KCkhSlnCWX+Ma4/NArnsH9hm1lMLG5Nc6y7HzUDIHf
         fy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuKmevb2P5VTDHJkuq3pq7e659lLwawUhKguA/KeoyXV1Thxpo22tdbZ7HbXs27aXCP0Kx7GsOffOEmK4A@vger.kernel.org, AJvYcCVGxptkNGkg5pMwRd4lE6Jlkg4dLr2k3x93oytBUp9rzXYO6Qx8nCLp0bT8SrEMWSfpQ54=@vger.kernel.org, AJvYcCVR5UtAmIGsKaJVFIl/G18DPll46T3ELN1dDsS7EnlqiJ9jTIYinx/fCu5TqslWvdvQx8oxPck1nGsw8SrAAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSg3SFQPjGGcnlECoR1UQ5VHhhsH9xBFUYLp+WL+YeYJunEH98
	F32rETray089AzCKBTtxzXCTX6EFWWtUtY+dZYTXjU1Nl0CUaksr0NTTSGjM5G9MSiW7D3Tj7JL
	p62pNl018sqiyKfD9m6UJ9Cz1TeY=
X-Google-Smtp-Source: AGHT+IEn2Do/6jRnMA3++ufyOBL20xnaTCPgPAZSoe26DmRbJ5T5EPARCBca+GckzX2dVOaQf3148vho6PwQQBOGO0c=
X-Received: by 2002:a17:90b:3b89:b0:2e0:a926:19b1 with SMTP id
 98e67ed59e1d1-2e8f11dce3amr26813641a91.38.1730488145468; Fri, 01 Nov 2024
 12:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848098C1DF99C6C417B405D99542@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB584858690D5A02162502A02099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584858690D5A02162502A02099542@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 12:08:53 -0700
Message-ID: <CAEf4BzadfF8iSAnhWFDNmXE80ayJXDkucbeg0jv-+=FtoDg5Zg@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 5:17=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds struct file related CRIB kfuncs.
>
> bpf_fget_task() is used to get a pointer to the struct file
> corresponding to the task file descriptor. Note that this function
> acquires a reference to struct file.
>
> bpf_get_file_ops_type() is used to determine what exactly this file
> is based on the file operations, such as socket, eventfd, timerfd,
> pipe, etc, in order to perform different checkpoint/restore processing
> for different file types. This function currently has only one return
> value, FILE_OPS_UNKNOWN, but will increase with the file types that
> CRIB supports for checkpoint/restore.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/crib/crib.c  |  4 ++++
>  kernel/bpf/crib/files.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>

Please CC Christian Brauner and fs mailing list
(linux-fsdevel@vger.kernel.org, both cc'ed) on changes like this (this
entire patch set)

> diff --git a/kernel/bpf/crib/crib.c b/kernel/bpf/crib/crib.c
> index e6536ee9a845..78ddd19d5693 100644
> --- a/kernel/bpf/crib/crib.c
> +++ b/kernel/bpf/crib/crib.c
> @@ -14,6 +14,10 @@ BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NE=
XT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
>  BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>
> +BTF_ID_FLAGS(func, bpf_fget_task, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_=
NULL)
> +BTF_ID_FLAGS(func, bpf_get_file_ops_type, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
> +
>  BTF_KFUNCS_END(bpf_crib_kfuncs)
>
>  static const struct btf_kfunc_id_set bpf_crib_kfunc_set =3D {
> diff --git a/kernel/bpf/crib/files.c b/kernel/bpf/crib/files.c
> index ececf150303f..8e0e29877359 100644
> --- a/kernel/bpf/crib/files.c
> +++ b/kernel/bpf/crib/files.c
> @@ -5,6 +5,14 @@
>  #include <linux/fdtable.h>
>  #include <linux/net.h>
>
> +/**
> + * This enum will grow with the file types that CRIB supports for
> + * checkpoint/restore.
> + */
> +enum {
> +       FILE_OPS_UNKNOWN =3D 0
> +};
> +
>  struct bpf_iter_task_file {
>         __u64 __opaque[3];
>  } __aligned(8);
> @@ -102,4 +110,40 @@ __bpf_kfunc void bpf_iter_task_file_destroy(struct b=
pf_iter_task_file *it)
>                 fput(kit->file);
>  }
>
> +/**
> + * bpf_fget_task() - Get a pointer to the struct file corresponding to
> + * the task file descriptor
> + *
> + * Note that this function acquires a reference to struct file.
> + *
> + * @task: the specified struct task_struct
> + * @fd: the file descriptor
> + *
> + * @returns the corresponding struct file pointer if found,
> + * otherwise returns NULL
> + */
> +__bpf_kfunc struct file *bpf_fget_task(struct task_struct *task, unsigne=
d int fd)
> +{
> +       struct file *file;
> +
> +       file =3D fget_task(task, fd);
> +       return file;
> +}
> +
> +/**
> + * bpf_get_file_ops_type() - Determine what exactly this file is based o=
n
> + * the file operations, such as socket, eventfd, timerfd, pipe, etc
> + *
> + * This function will grow with the file types that CRIB supports for
> + * checkpoint/restore.
> + *
> + * @file: a pointer to the struct file
> + *
> + * @returns the file operations type
> + */
> +__bpf_kfunc unsigned int bpf_get_file_ops_type(struct file *file)
> +{
> +       return FILE_OPS_UNKNOWN;
> +}
> +

this is not very supportable, users can do the same by accessing
file->f_op and comparing it to a set of known struct file_operations
references.

>  __bpf_kfunc_end_defs();
> --
> 2.39.5
>

