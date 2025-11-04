Return-Path: <linux-fsdevel+bounces-66907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98880C30395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F77189DD25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBAD328600;
	Tue,  4 Nov 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="MVto1bSH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA53126CD
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762247585; cv=none; b=mNb6VLfb/v2TrCaMfE2uqJ8Zv3p8YA+ynE9FCcUV/23dTgj3DSODGOCuFSptnDMqKxhglIZcE6J9IykFs1R6uvRb+2CKbF3Lei5vC9oDWtYbMNLRb1WK/N3Tv7qZt1bzW3AaWm0mNC7X4WVwC/UlG3aq42udYhERHtiCBOqZ3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762247585; c=relaxed/simple;
	bh=yIxs2AioBtNxH+/AGFGZy/aIa3xdZYvSTQEhK4fcqxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqBD+ANZhY9TyMKPfXol+rzSbeIxKyOVHWrUmCNDchAgZDsPQkpq08wgX69Hnt5Q+CRFveuqHvRdC143mNxM+FUUx5QbAqKqjak9lQj/ICJPbYqR7KbCRfT4Rl7/JEJXoqQJDRjbHvEfUzd1MJ+1NqRYq+FZ9bKOe52c18/CIQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=MVto1bSH; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-591ea9ccfc2so6471863e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1762247582; x=1762852382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WaZfHpNXYI/jgIt8nw28ldDnnFYlbSFdmMyrVQxmf64=;
        b=MVto1bSH65r6ts6GC4za3OWJP2TSRIiESVVy6YzAO8YcVoq21dUDM0kporRdY/Eqde
         tM7w53pt17PONMdn1QvGTkqUiPEXBKBKJalXYrYLmFjaO5VBNqguu94fISkCFanlgKp0
         rDpquFNX/jQhqR+WTIeW9IW2+zMtj5lH0Nr64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247582; x=1762852382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaZfHpNXYI/jgIt8nw28ldDnnFYlbSFdmMyrVQxmf64=;
        b=bvRSEmYhLIH5CfbTeS6ryWiZ8sKsHB4vlijyL07Svk0hEPIbwSBedyMf38URoYhQku
         friBLl2Q1KktIrRNu+88NMWZXEbJTRLMbIY5JsNWrzxoT1pEz7Z1h1xwNIMURos2lBaJ
         Ik+PwblLkoswB3mJT+hpoht86lu5TOIKHL5bG/U4y8huwJkAvtPw3LwoWy58oMe0N4ZU
         HUWh/uhcIkvsacWMAHVnP3ZmfbW4M8oDZVNEy2WPjy6pi7cc/Dn49OuUmdbdgQrrPg3C
         wbYd0kRn5FNvd8ZU4/ekwmaZyAA9H/H43tuTwolUYXVQNRUECdOalKcwUqDZfeWge+LQ
         BEMQ==
X-Gm-Message-State: AOJu0YwQJpVPr9wK9MvqP3rT0AhQuKqM/HZF05TfBf8vGev8SAYtQNpp
	yasdyLnN8L2Hxc9bLACWjfgkk4ORJ6kunS2La5SeBNGsUDdS7bjDbzbUd8kO3ILM4Ebf/5mutKH
	109yMfKxVQaalfURFUnZ6kiGGvXmRPIQWmk/IYlbSSg==
X-Gm-Gg: ASbGnctuwRk9DjMlhnv24WaKV1OHfLfZgycdgWIQWj9fXATDatFETSc4XZSsFY0Vs5L
	J8Etz2RiQgzcMxawXMjpYaVyEdm8ZwW0SXo+D+/E8JVUX9JlWwzCst5r3Z4wsBCtfxxTyvL972S
	COhu2L6xIo93XFtLdTBzLeDVCH7f/JyBxsQL080Bk27lxwqluLIw2/UC2TDejaPUfM5BqWQuXoD
	NUXoIrwjXvRPftyhgWN/Gaqie31fim8Uj4BbW+GZ/u/WZ8mg1fa0gpDav2g
X-Google-Smtp-Source: AGHT+IFKspgQB5ZMddkqJx3AsG/RMHPme6ArMDmpctK9LnyCoghREqanHqfgvPIow+YtsAoy7/dA4RxpS77KX7BD1xo=
X-Received: by 2002:a19:6b18:0:b0:594:2f72:2f89 with SMTP id
 2adb3069b0e04-59434885cc7mr521797e87.9.1762247582223; Tue, 04 Nov 2025
 01:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org> <20251028-work-coredump-signal-v1-15-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-15-ca449b7b7aa0@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 4 Nov 2025 10:12:48 +0100
X-Gm-Features: AWmQ_bm8xwSqN1blOPEp9Q9oEQiTaBdFJXlR49tAVrsZRlzfRNxWRmXCJCQdtM4
Message-ID: <CAJqdLrqc54CU+pvt9BMGv6ZmwK-=CjYAV8qGmtVpLEAjS8dcYA@mail.gmail.com>
Subject: Re: [PATCH 15/22] selftests/coredump: fix userspace coredump client detection
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

Am Di., 28. Okt. 2025 um 09:47 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> PIDFD_INFO_COREDUMP is only retrievable until the task has exited. After
> it has exited task->mm is NULL. So if the task didn't actually coredump
> we can't retrieve it's dumpability settings anymore. Only if the task
> did coredump will we have stashed the coredump information in the
> respective struct pid.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/coredump_socket_test.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
> index 658f3966064f..5103d9f13003 100644
> --- a/tools/testing/selftests/coredump/coredump_socket_test.c
> +++ b/tools/testing/selftests/coredump/coredump_socket_test.c
> @@ -271,22 +271,26 @@ TEST_F(coredump, socket_detect_userspace_client)
>                         _exit(EXIT_FAILURE);
>
>                 close(fd_socket);
> +               pause();
>                 _exit(EXIT_SUCCESS);
>         }
>
>         pidfd = sys_pidfd_open(pid, 0);
>         ASSERT_GE(pidfd, 0);
>
> -       waitpid(pid, &status, 0);
> -       ASSERT_TRUE(WIFEXITED(status));
> -       ASSERT_EQ(WEXITSTATUS(status), 0);
> -
>         ASSERT_TRUE(get_pidfd_info(pidfd, &info));
>         ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
>         ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
>
>         wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
>
> +       ASSERT_EQ(sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0), 0);
> +       ASSERT_EQ(close(pidfd), 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_EQ(WTERMSIG(status), SIGKILL);
> +
>         ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
>         ASSERT_EQ(errno, ENOENT);
>  }
>
> --
> 2.47.3
>

