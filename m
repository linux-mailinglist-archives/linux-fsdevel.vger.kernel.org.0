Return-Path: <linux-fsdevel+bounces-57830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB379B25A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 06:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B9F587457
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 04:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71DE21421D;
	Thu, 14 Aug 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1m5WZ0W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0E7494;
	Thu, 14 Aug 2025 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755146533; cv=none; b=pG3f+v5IXFqUyvS5cSC8EXcbeDc00/8ODvR0BLSJXjXrEBATUY2Ub4kn52jqSrCGIXjhzyyVBn632O9bAQbW4UhzWMNLUxQcAv7xmQ1xfvyAGLy8FAtprE5vn42edfnd6qjW7OMjDQAepogKrT3xlcc1zXDEhqrUWCjOQbzq+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755146533; c=relaxed/simple;
	bh=HjP9xEifH2uo24DN1tjCSt75H/8szND8gmPdkHWmUv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW2g0lzFbOwf+xYimEM+3XQoJQaKB+aj5l1YUlht66G2Km/KelcWBXuxZr3rIny0FhDbAzQGrzWYFfEFidvs9xhs1CQV0p9DeUKqHxUmwV0hodqS6/C1J2BA6UniSmEHf5guhHsPyj2ESOOyQN/4dqOBTkTCq9jnd91M8UCamEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1m5WZ0W; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174beb13so319743a12.2;
        Wed, 13 Aug 2025 21:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755146531; x=1755751331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfG6nEZE0dqIku8StsQokdBuTZbWCDy8a5aEtSWTnK0=;
        b=b1m5WZ0WMxH1XMu/JVDzQsVfJu8Yc9BH1TQeNoe0dndaI6jhi7qtKKnk/uz0LeeokO
         q+VkGjofjEPBaJ/oElRI0Fh8pqvjmKjQoz6ECxRjEoc+mloxZY1UGLs6bDJZdByHm3cb
         559wRDaQTbTRlQcpm5VB/gRtPyrqSQjmeWixLuFq05bRGMAHFakrB61Z+gewK8wwFVPL
         CQP2qXZ7ZsDTl1NPUv+xI4YWfyMIrIitW8J7S3C1Ov+WjaqQ/KY+nJHr+ipOqf4K8k9U
         P1wqMhyaxTvn0rzGmjXBKObbFKCI9ry6B7P4EBiuKLtGvptJeQIwKll3BGQjBsjyH3KC
         nQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755146531; x=1755751331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfG6nEZE0dqIku8StsQokdBuTZbWCDy8a5aEtSWTnK0=;
        b=CsIJmFACyS4uKGRGe8KciXEvfki7kpEGwdHnEaZw35NQSpZGuIalXeNmML+Ah8eqkP
         anyeJav7yg4dug4q5rljz0oDI18ws334nQdLjT6mtryngImbEZgz9DHbtUo6K+PwIqpB
         u8O+zVxksH8W8RjcG/7QQACp7BffXTTeaD5A/cRAGT++Q7hSrdbuFh39AHlArwxT26ml
         GkN62PSsWu0hxZh6HAtwh84MOrl9M8EYhind2xCIoBBSRudajSpknk8ddjeirCSaxFM4
         CJmE7x33VRX7glKOqKlD0GaC3cA6COxTS1LA79fPKjcnZVJJlB/QKWDmfhF1y4zlSsX1
         2vqw==
X-Forwarded-Encrypted: i=1; AJvYcCW3W1Lb8rhi9TkqC6RR/A2TWNehpAohuUajOJ0Mr0j6Si5BiWHFVBzXuz3fYyIt1v3eLoGIo44NrqhfL3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR2/K/v8lYCm29aqt8XHFnl4ZvCJ4v9Tn6N5dx+kbeKiTLRtIH
	cwOhUkPLkK4DETp+TfC1yfwL/hz+XnmNC8M7uxEeRF1yTLy+OQEY05Ud2Xns6r7kpHTuqVufrNr
	SBguz5DZ+zW5YFZSPSqQW9xmhOypMxQo=
X-Gm-Gg: ASbGncscAdmehcxdY6+fJGYpDkd4PNroAZ3wz8m4DXkfQPcSrxGgZgyQFKF3yyKfm+X
	/xi0hRsI1Tiz5AF2uBqiBgmcdfnUV6KzDo+ZuvJUIyPCK/rnKWk2rPwaCUGIsjxx8r+mVM0fhHp
	UE7wCTMdwaji5iu7sVJ+naM5/OHrZ9Apl+Hk9Ix3ycCQM2OVXU1/J8OtYDw655FKYeaLH6yp5US
	6bbpQ==
X-Google-Smtp-Source: AGHT+IFwjPbVB+CLj//KV9fftScTg+j2+WaJxg0RSMSWSHKw7ZibslsTHYhqhULkFUU5MMjEPk++xamRy4gQIvKp26E=
X-Received: by 2002:a17:903:2285:b0:240:cd3e:d860 with SMTP id
 d9443c01a7336-24458b5546bmr21517585ad.41.1755146530907; Wed, 13 Aug 2025
 21:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813132214.4426-1-adrianhuang0701@gmail.com>
In-Reply-To: <20250813132214.4426-1-adrianhuang0701@gmail.com>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 14 Aug 2025 12:41:59 +0800
X-Gm-Features: Ac12FXzdYa-Epeqx_7e69SUFEljJpOfzKahmKukihFWa-iCJn3_sJhv681ysVh0
Message-ID: <CAHKZfL0Ypbbz2hFiDPhAhvE5F3ZyrBy6V7OpzMyOJfoZ47cLRQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] pidfs: Fix memory leak in pidfd_info()
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ahuang12@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 9:22=E2=80=AFPM Adrian Huang (Lenovo)
<adrianhuang0701@gmail.com> wrote:
>
> After running the program 'ioctl_pidfd03' of Linux Test Project (LTP) or
> the program 'pidfd_info_test' in 'tools/testing/selftests/pidfd' of the
> kernel source, kmemleak reports the following memory leaks:
>
>   # cat /sys/kernel/debug/kmemleak
>   unreferenced object 0xff110020e5988000 (size 8216):
>     comm "ioctl_pidfd03", pid 10853, jiffies 4294800031
>     hex dump (first 32 bytes):
>       02 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
>       00 00 00 00 af 01 00 00 80 00 00 00 00 00 00 00  ................
>     backtrace (crc 69483047):
>       kmem_cache_alloc_node_noprof+0x2fb/0x410
>       copy_process+0x178/0x1740
>       kernel_clone+0x99/0x3b0
>       __do_sys_clone3+0xbe/0x100
>       do_syscall_64+0x7b/0x2c0
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ...
>   unreferenced object 0xff11002097b70000 (size 8216):
>   comm "pidfd_info_test", pid 11840, jiffies 4294889165
>   hex dump (first 32 bytes):
>     06 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
>     00 00 00 00 b5 00 00 00 80 00 00 00 00 00 00 00  ................
>   backtrace (crc a6286bb7):
>     kmem_cache_alloc_node_noprof+0x2fb/0x410
>     copy_process+0x178/0x1740
>     kernel_clone+0x99/0x3b0
>     __do_sys_clone3+0xbe/0x100
>     do_syscall_64+0x7b/0x2c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   ...
>
> The leak occurs because pidfd_info() obtains a task_struct via
> get_pid_task() but never calls put_task_struct() to drop the reference,
> leaving task->usage unbalanced.
>
> Fix the issue by adding __free(put_task) to the local variable 'task',
> ensuring that put_task_struct() is automatically invoked when the
> variable goes out of scope.
>
> Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
>  fs/pidfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index edc35522d75c..857eb27c3d94 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -296,12 +296,12 @@ static __u32 pidfs_coredump_mask(unsigned long mm_f=
lags)
>  static long pidfd_info(struct file *file, unsigned int cmd, unsigned lon=
g arg)
>  {
>         struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)a=
rg;
> +       struct task_struct *task __free(put_task);

Oops, forgot to assign NULL. This causes the regression (general
protection fault) for the error path in pidfd_info() when running the
program 'ioctl_pidfd05' of Linux Test Project (LTP).

Please ignore this patch, and I'll send a v2 shortly.

>         struct pid *pid =3D pidfd_pid(file);
>         size_t usize =3D _IOC_SIZE(cmd);
>         struct pidfd_info kinfo =3D {};
>         struct pidfs_exit_info *exit_info;
>         struct user_namespace *user_ns;
> -       struct task_struct *task;
>         struct pidfs_attr *attr;
>         const struct cred *c;
>         __u64 mask;
> --
> 2.34.1
>

