Return-Path: <linux-fsdevel+bounces-33828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7749BF883
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149591F235C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED020CCE0;
	Wed,  6 Nov 2024 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFAw528y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD28824A3;
	Wed,  6 Nov 2024 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928734; cv=none; b=LOBw6hTUkHt31j/RWqmOackGrk51trsYOAOxSoKik1NZHe6xMSthXxykrwu4E4RZ17jtncJ8tqEv55Zxgwm8Qau8Fo5+UXEOa4vmf7MoUF9dXSxh6CaTxJjA35oqcSSETXYDTfD142qOR7td0i1Ym9ajGQB1p/RxaW78KPjEflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928734; c=relaxed/simple;
	bh=W57AiVHigZAQzTTXD8aF7kR9EHj4KrSbKU0Glz+NrZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJOgatzZUfunCyGCaADOr5mAaIgVAnzglWFaYKncmFdU/RsRnZy+ZpqISUVFYCV1o8vM1nXwPoV+QyfmZ7R7+75XCtoKfg93kIOGGmmj4SY0Ep1w+0WlohuOfrB5SxrhTc6PTRLVaA330yLFdxvDuUIKZfNEnYmeNFPpgFtXY8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFAw528y; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43155afca99so8192575e9.1;
        Wed, 06 Nov 2024 13:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730928731; x=1731533531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehbZtHG3GMYmEtLXBmVACm/251G8rfEwUgUxWh/1yeA=;
        b=YFAw528y3lB7GZrgLsHJcbzWG5YWDtUreWVsYVIN4rP6C/ARioleDiktp/RDteYp+x
         d20ULjVxCcnyV78MDu6AE1AGkoxqdF0tA+n6+tBwT+vwpvVD46HDYeqoXN/YKgB5vGGU
         fhNiviOKsRHal5Gj3y94DL4STdaTcV//HiIsp6VOWd3iX1XJZjEjMMTIBsk9CLoOQX2g
         lwPACs/5PlQ5u+ixf/4M79TZUrbJ4WiphOiFhp9HT9CMyHK3P/8T/FDU3Vr8AQsKaRjE
         DCOpJ02QrJkeUSrRAv1oVxl3dU8+Iw0/fx8Qz2QxLYDlMxTcfyU3K8F616Y5RZwIH6do
         5kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730928731; x=1731533531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehbZtHG3GMYmEtLXBmVACm/251G8rfEwUgUxWh/1yeA=;
        b=Y9rnqR/SfeU6OvlpM0SRAQiXivBZk0YOBlvhzZx+GRCELb6LNAYhUMUkle9SlHxzE+
         CNGrMT0fbur8EOUZPfZCbw95NQxu3fsrRW8/i2zZluryyS8eOwF/ejZi2e4thbWye67L
         +x3ZaN7hEwtmXvRYOtwZDN4D9YHwLmhrFDF+JkC9jVCqnrSkJTWmfJBgxbNwCDYMEjQJ
         kohqELEUYe2agzREv5V7BdTZJYP4Sxy6oDj+zd72khq18kvlhtYsB9vE1HHWNMMWlJTR
         T4knicShDJ8vmL1K2zHsIHOgM65wYqFVvxjqUn5KYfuPCb+mlvx30iWno3GaFjLv1X6A
         fuFA==
X-Forwarded-Encrypted: i=1; AJvYcCW3GYpO4kRSG9bhDU7Fz7EeOeYi7MB+uw/vk5++8deXLsc/NL2tdIC0ySG/W+CK/ppX/owh5LHPrg6dC3Ko@vger.kernel.org, AJvYcCXZdEvdz8T6c/JkN84EM9xZL9r2eHMbxKl48tQ+PLFh3wUoiU/6anxfGu+F6ZJc6bNeh6/oNBB9+4TB/Lm3TQ==@vger.kernel.org, AJvYcCXjN309QM9QKzcwhhMrMJPXxov0LaMenSa7IMSLpAaLO7FNOLYC9MGpY8oA/67BTyetKg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxua37MO/TQhoLmGICBShykxXo1PMsWSpFiwkYPYaPLw0TY2AZR
	d00klYLsk0l3R8EbS79pBc+a7k5CKmAKuVbEvWa821wCPT1K8BsavSZIPYXZxcaVNH5ukU0oYLb
	IvqB9/qcJ8vPzq+qD+2Qo3ZU0biw=
X-Google-Smtp-Source: AGHT+IGcAy3YCJFQnGWIsjYQTY0ZUTn6gktmpfJNmMw/9TiwVBueiMefDQmdVlzAUBuUbFoR9DQBg233aPpSpjJcJwo=
X-Received: by 2002:a05:6000:418a:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-381ec725267mr426873f8f.2.1730928730907; Wed, 06 Nov 2024
 13:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488FD29EB0D0B89D52AABB99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848C66D53C0204C4EE2655F99532@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Nov 2024 13:31:58 -0800
Message-ID: <CAADnVQKuyqY7J4iJ=FZVNoon2y_v866H9hvjAn-06c8nq577Ng@mail.gmail.com>
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

On Wed, Nov 6, 2024 at 11:39=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This patch adds the open-coded iterator style process file iterator
> kfuncs bpf_iter_task_file_{new,next,destroy} that iterates over all
> files opened by the specified process.

This is ok.

> In addition, this patch adds bpf_iter_task_file_get_fd() getter to get
> the file descriptor corresponding to the file in the current iteration.

Unnecessary. Use CORE to read iter internal fields.

> The reference to struct file acquired by the previous
> bpf_iter_task_file_next() is released in the next
> bpf_iter_task_file_next(), and the last reference is released in the
> last bpf_iter_task_file_next() that returns NULL.
>
> In the bpf_iter_task_file_destroy(), if the iterator does not iterate to
> the end, then the last struct file reference is released at this time.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/helpers.c   |  4 ++
>  kernel/bpf/task_iter.c | 96 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 395221e53832..1f0f7ca1c47a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3096,6 +3096,10 @@ BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_D=
ESTROY)
>  BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF=
_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_new, KF_ITER_NEW | KF_TRUSTED_ARGS=
)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_next, KF_ITER_NEXT | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_get_fd)
> +BTF_ID_FLAGS(func, bpf_iter_task_file_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 5af9e130e500..32e15403a5a6 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -1031,6 +1031,102 @@ __bpf_kfunc void bpf_iter_task_destroy(struct bpf=
_iter_task *it)
>  {
>  }
>
> +struct bpf_iter_task_file {
> +       __u64 __opaque[3];
> +} __aligned(8);
> +
> +struct bpf_iter_task_file_kern {
> +       struct task_struct *task;
> +       struct file *file;
> +       int fd;
> +} __aligned(8);
> +
> +/**
> + * bpf_iter_task_file_new() - Initialize a new task file iterator for a =
task,
> + * used to iterate over all files opened by a specified task
> + *
> + * @it: the new bpf_iter_task_file to be created
> + * @task: a pointer pointing to a task to be iterated over
> + */
> +__bpf_kfunc int bpf_iter_task_file_new(struct bpf_iter_task_file *it,
> +               struct task_struct *task)
> +{
> +       struct bpf_iter_task_file_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_file_kern) > sizeof(stru=
ct bpf_iter_task_file));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_file_kern) !=3D
> +                    __alignof__(struct bpf_iter_task_file));
> +
> +       kit->task =3D task;

This is broken, since task refcnt can drop while iter is running.

Before doing any of that I'd like to see a long term path for crib.
All these small additions are ok if they're generic and useful elsewhere.
I'm afraid there is no path forward for crib itself though.

pw-bot: cr

