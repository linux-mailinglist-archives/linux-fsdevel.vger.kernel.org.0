Return-Path: <linux-fsdevel+bounces-52423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65307AE3250
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54BD3A5D8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223511E1E16;
	Sun, 22 Jun 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="E8l8Tlnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2171EAC6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627359; cv=none; b=KyrureHtA9dMm+ROj+rpQVAC/rT8t2jp62NnsDJDj5RaAC+LVN4qPsvfViunf6eit+6f705l5iMFqzmwCnm/Kto42qm/q2sUWQEc/CdkvOvHou2PYROawrWEKUz5sjGxWsAND2jEUDcdrsOOnJosJD9YibnJXfdfRDJlVmT/wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627359; c=relaxed/simple;
	bh=l7dKY4O8eTSkankMlGf7KqseHjiVsaPvWTN9sHwGhfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw9xcPq8CT9yKPE/yh3dQM1pvqCN3fD68dQ7Li/L9FsjMLGhj+dG4B6nl8S/xBDjs6iycUXCdSmwG/HUjnC1WgcdfztnWUpp+CTFMEBtTUaJw5FBU9tgaA2SnlDCm+x9Xywvjcz77pkxq73JQyVMICOXYLQkPm56Z9blss/dlr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=E8l8Tlnc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ae3e94e57so24198791fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750627356; x=1751232156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KWj6FsF465BuroFGk2V5hCVMGrEgUBAh2J4MZpMr0ug=;
        b=E8l8Tlnc+PT6YIcWpiJZ3QyPgtcRbhaxrwxmSm0FNLEs3RrNSMtti0Vhu6yZe+Jd6T
         qDNOxtPpATtHCXmeIyFwgVVF9ryROR7rlPMi3lTlpTx05vq6jYj1/0Jnv26ab5KRYp2G
         xsUICCUI5ll2VrE8XUCyZ0QZRNX2eD2UUeSKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627356; x=1751232156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWj6FsF465BuroFGk2V5hCVMGrEgUBAh2J4MZpMr0ug=;
        b=P2+oaF17IMhLOp9rWIvF9GwE4nOOmRsf34QeFlpyCl2GU+7ObnyoXAhiyfHkZ/D1uF
         65JE+uqZ8krVqNx28iR0Zoq46EVQva2en6SX7INnRhzXpZfksMUseFr65ITpdzC6H8+f
         x03faRWhg81zKAF5/1GRz0xk9rdi0f6I0bfgjm8QWB3dJn09TSg5XcqRyFnyaIEnUkaC
         tzwWLeuwL1g4uzbOY6RiU1BGO8KYvHg3eEdW2pJI18CYikogGPvor8jalPT2AzJeeeTq
         PhrDrFIDzfPkVozXVZ4baapsAnRMsgEa9bbvWFcM50vPeiU3gvZbG8omBVnbl08Kg+G0
         k3JQ==
X-Gm-Message-State: AOJu0Yy3vVWtZ+pD9mK32j2oZwgeT2uym+UTOoEDZrmYYuOM+e/aXHU5
	wQwEwDCO2uVmv0mNJCHezXC58/WH7UEh9QjLnbTxYEVJ9SLRgtAklLByq9seVJEV5ShkHjHU0L3
	awiKy/TjYKRrLpM30GOwRD4C7o1Ivh1+xueYNMo8qEg==
X-Gm-Gg: ASbGnctiLyXarrsNFj0tRfwn3oM4bIrYlC97vA/iLkgq3CiTp++HmGEDxQ78jLIn/8j
	0aldC6pmwfhyQyJBYcDdS7Du1Bl4SCHB83m5PvW31nB/L8j+tb3wGBbI4DXjwXgnYmbUAHtnato
	LVbblbyoe1RHuQSaP22hiVWpT+sb9Q69oqxuRTGStV5fqy
X-Google-Smtp-Source: AGHT+IF7cQ6dqhJp9AEy2K6MLiaikJPDrogFlCLHu8CWWxStwaN7OT1ZrOKCUyTrweinvdNe9vhVUGGXq+BYizUwAho=
X-Received: by 2002:a05:651c:b8c:b0:32b:522e:e073 with SMTP id
 38308e7fff4ca-32b98f3798cmr26612111fa.25.1750627355801; Sun, 22 Jun 2025
 14:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-15-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-15-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:22:24 +0200
X-Gm-Features: Ac12FXynSMCfrGT1xEawtdMrk9G8QBrB8AwIJ5sduLKrln6nxPqc5EE8U8TM7WI
Message-ID: <CAJqdLrrR6KtSANzjw-x-1RmhsKeqbPPrLE7sJPCaducGvjm7gw@mail.gmail.com>
Subject: Re: [PATCH v2 15/16] selftests/pidfd: test setattr support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Verify that ->setattr() on a pidfd doens't work.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/.gitignore           |  1 +
>  tools/testing/selftests/pidfd/Makefile             |  2 +-
>  tools/testing/selftests/pidfd/pidfd_setattr_test.c | 69 ++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index bc4130506eda..144e7ff65d6a 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -11,3 +11,4 @@ pidfd_bind_mount
>  pidfd_info_test
>  pidfd_exec_helper
>  pidfd_xattr_test
> +pidfd_setattr_test
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index c9fd5023ef15..03a6eede9c9e 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -4,7 +4,7 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
>  TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
>         pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
>         pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
> -       pidfd_xattr_test
> +       pidfd_xattr_test pidfd_setattr_test
>
>  TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_setattr_test.c b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
> new file mode 100644
> index 000000000000..d7de05edc4b3
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_setattr_test.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <linux/types.h>
> +#include <poll.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <linux/kcmp.h>
> +#include <sys/stat.h>
> +#include <sys/xattr.h>
> +
> +#include "pidfd.h"
> +#include "../kselftest_harness.h"
> +
> +FIXTURE(pidfs_setattr)
> +{
> +       pid_t child_pid;
> +       int child_pidfd;
> +};
> +
> +FIXTURE_SETUP(pidfs_setattr)
> +{
> +       self->child_pid = create_child(&self->child_pidfd, CLONE_NEWUSER | CLONE_NEWPID);
> +       EXPECT_GE(self->child_pid, 0);
> +
> +       if (self->child_pid == 0)
> +               _exit(EXIT_SUCCESS);
> +}
> +
> +FIXTURE_TEARDOWN(pidfs_setattr)
> +{
> +       sys_waitid(P_PID, self->child_pid, NULL, WEXITED);
> +       EXPECT_EQ(close(self->child_pidfd), 0);
> +}
> +
> +TEST_F(pidfs_setattr, no_chown)
> +{
> +       ASSERT_LT(fchown(self->child_pidfd, 1234, 5678), 0);
> +       ASSERT_EQ(errno, EOPNOTSUPP);
> +}
> +
> +TEST_F(pidfs_setattr, no_chmod)
> +{
> +       ASSERT_LT(fchmod(self->child_pidfd, 0777), 0);
> +       ASSERT_EQ(errno, EOPNOTSUPP);
> +}
> +
> +TEST_F(pidfs_setattr, no_exec)
> +{
> +       char *const argv[] = { NULL };
> +       char *const envp[] = { NULL };
> +
> +       ASSERT_LT(execveat(self->child_pidfd, "", argv, envp, AT_EMPTY_PATH), 0);
> +       ASSERT_EQ(errno, EACCES);
> +}
> +
> +TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

