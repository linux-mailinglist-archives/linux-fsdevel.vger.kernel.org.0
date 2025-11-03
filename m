Return-Path: <linux-fsdevel+bounces-66821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C7C2CDB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24ECD4F6E5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162DF30C610;
	Mon,  3 Nov 2025 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="SZZQMC4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89330E832
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184168; cv=none; b=uRtYEE/SwO6XYpw5buQaCM1kammS3ReFueEIBb4D8qG4IOTVV9wRG/mG4s5b6orVWfwTUMxY/l4P7OuYAoeNvLzVo8NNxgqKN1VC85GRet4sZK8OYruXNq3staaWACP6aUx3ILoXrGmpAoEKHpwoTPlpXfjNpf8AMYYHzRqTwMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184168; c=relaxed/simple;
	bh=To6YBtHvG+Ot8iV3UpyscJtjXiqASjcXva85WF1+cwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4WYdHZrB+31ZmOAvF7UPhR76Jdi9A2ZR6fUazApKBwDeqK1bU8x/eD1gXcPKACKL1mgFzJUw/9/ypcj3jd7bWvEUTvrR1vTN2wrZhk/kQqaKFI3qOR/nlc9hJAq/ePEBFR5WwI0uks5F6kkCbdKGXXAmwIZWvr14rNFZ4Xivdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=SZZQMC4G; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-586883eb9fbso5647476e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 07:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762184164; x=1762788964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4q7nanxgAPjG6mFRNLv4lMdBfCDrxBKffr3UhQ6bdwg=;
        b=SZZQMC4GkPK7PJ1LSkgF33aE/2stqdpC17dyoFMnD8a0dCraXOctYBT7pM1Rcp/Fz0
         G2am6GzWmSmUg7RK8WK4kIMYp0UKvcvEQe6l8TwYD2KUXCv6+yFNzQheJ7TaV2TgdOo5
         9jqbGpl4VKuTQY5pFMQzw8lwMIbfmkNqgs2Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184164; x=1762788964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4q7nanxgAPjG6mFRNLv4lMdBfCDrxBKffr3UhQ6bdwg=;
        b=ozyjwM6caEx4o9b17JzOqsSnvl2ftPIN1EKrhQxjJYCcuuq3Oe6sgO+ZsqKgWdLPHE
         ee4hj375d4Q74n5IxrPskb0Eu/uHgz8aJFMp4OTK5Hw6/h6vilfhRGMrckA+7s41BMvt
         yb9gjyXM2NNZseNveXUzKNIxd0eqshOX3enHDtbOCMHs9R0YJS4R0KTBF4q63/d/shEX
         g41SblUE0uY5QdKn8J7q0HXmRYK3HcWb2QWe3zU8PMx7OGoSScxKifFzxcvcp1ScQb2h
         1TAtlfdcaiaoMajl/xk3G7Emg9KajUISJMyqw9/4ltCjxExPC9evLlymnjGv+XJKkcF7
         iajA==
X-Gm-Message-State: AOJu0YxAoXF+P7JO+DZtyVSUFyzcq+LC49R+3UaNW/AYhk6BUBl0ktA3
	ukF3CMDeFVqY0/eCKWQTd0xY768nzhHpr/unTvrd0HTDUIwJCpkvFBH99/xo/REITRyoW56vc14
	S9/52zXBJaQkOGfzHFY2m2UjQGHXfa3xyr8YYrrr98Q==
X-Gm-Gg: ASbGncsOkjmK/wPV5eaSxnwG17gapSbcWk8x7S9J6HHjhfc9pje7SDJ80RaaECiXUz2
	ysD/dP4mRCgHIN8L4uXhz2hTt/jakGPbJQDs4dC4ZOTAgpyRkPkHn2wf1JBHaBnt7CaDwTd0+80
	hPKte3QkitKucHyAU026nIhmqoaP0lkQzJhhKrrPOMRF+Oy4/vM3zR67/CA9y2MUJ1HS83COQ03
	CxRaTv7Bnw1hSD4U1lYOQeHbiZ2lWU2ya7ZFqN/odRNInyn6zXZkHnxYPKu
X-Google-Smtp-Source: AGHT+IH97ZofudZYy2YhVvIIBtVo8/XIjLURW5T472yYzr3yF0R+Ac4Gk3xB+10bebg2IPCGrovhYKZsLeaboE+Z0D4=
X-Received: by 2002:a05:6512:3e05:b0:594:27fb:e7f5 with SMTP id
 2adb3069b0e04-59427fbea48mr1899466e87.42.1762184164130; Mon, 03 Nov 2025
 07:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-2-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-2-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 3 Nov 2025 16:35:50 +0100
X-Gm-Features: AWmQ_bkXv1QBDsVsvIQlpi39qb4kwr3XZZOY4dgbJSwLF1w6jSLZdil2UJ4qNlg
Message-ID: <CAJqdLroQrPkjsDfORf6FimbG2-noX43Kw+Z2M7d3DovpFFyjXw@mail.gmail.com>
Subject: Re: [PATCH 02/22] pidfs: fix PIDFD_INFO_COREDUMP handling
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Yu Watanabe <watanabe.yu+github@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Jann Horn <jannh@google.com>, 
	Luca Boccassi <luca.boccassi@gmail.com>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 28. Okt. 2025 um 09:46 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> When PIDFD_INFO_COREDUMP is requested we raise it unconditionally in the
> returned mask even if no coredump actually did take place. This was
> done because we assumed that the later check whether ->coredump_mask as
> non-zero detects that it is zero and then retrieves the dumpability
> settings from the task's mm. This has issues though becuase there are
> tasks that might not have any mm. Also it's just not very cleanly
> implemented. Fix this.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/pidfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index c2f0b7091cd7..c0f410903c3f 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -335,8 +335,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         }
>
>         if (mask & PIDFD_INFO_COREDUMP) {
> -               kinfo.mask |= PIDFD_INFO_COREDUMP;
>                 kinfo.coredump_mask = READ_ONCE(attr->__pei.coredump_mask);
> +               if (kinfo.coredump_mask)
> +                       kinfo.mask |= PIDFD_INFO_COREDUMP;
>         }
>
>         task = get_pid_task(pid, PIDTYPE_PID);
> @@ -355,12 +356,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
>         if (!c)
>                 return -ESRCH;
>
> -       if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
> +       if ((mask & PIDFD_INFO_COREDUMP) && !kinfo.coredump_mask) {
>                 guard(task_lock)(task);
>                 if (task->mm) {
>                         unsigned long flags = __mm_flags_get_dumpable(task->mm);
>
>                         kinfo.coredump_mask = pidfs_coredump_mask(flags);
> +                       kinfo.mask |= PIDFD_INFO_COREDUMP;
>                 }
>         }
>
>
> --
> 2.47.3
>

