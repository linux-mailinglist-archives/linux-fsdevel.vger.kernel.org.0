Return-Path: <linux-fsdevel+bounces-52421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9914AE324E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 23:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D8C16F51D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3991A5B92;
	Sun, 22 Jun 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Ws4p1XgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D82EAC6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750627295; cv=none; b=QcGoNIwCsTEgA48tm6zUVQ9HA6znICt8v95ku1mAkoP1AaiS/0VY0c1etG56vCO34V2oR02nQNyWB7r5KZvv8baFugTBHro/fG9yIAAMXWYR/n9xRaJim7+J2gx8GiTPnwAeVxu+JEjXAKUMubHq/pz2g9zbdvwayuKQbmPAuiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750627295; c=relaxed/simple;
	bh=xpiyn+n4cGUhJbSCTa+Dt6Agc3VjN1Yp7oCWuUATovg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWXCBHBGf4TMRE8/RJxHBnH7t1/uyjx68zw3gUIpM+aZdTuDmesHx6tpNWXYFN+5OSMzkUBpDqSpn2WzFhWWGnt+y6VGREUnBYwKyziDfTMbuMijqMxb1UTu5rTGAB5gP0wnMgVtFQwKP+f1Fsu3DPkyzmh/uzZyuIBm7PVc3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Ws4p1XgE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55351af2fc6so3660435e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1750627292; x=1751232092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U9D9t4WZ0cPFISunUG/ACXcd6paSyRV27bUdVDT18/o=;
        b=Ws4p1XgEAllb4r51y2uzbxz9MPyItxaVLpeW7GSmEDsHAu8U1isCOfTxeyla3wxJSZ
         LwMZGC3YejX82zUqIjCcqPCQMaZOd0e5WdgF6xq46XvZYYk1ymGBskR7Qya/3lEmJUm2
         upnIAVX53qMkT2tGfEjldF+AaHWzNzvgr+zR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750627292; x=1751232092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9D9t4WZ0cPFISunUG/ACXcd6paSyRV27bUdVDT18/o=;
        b=U/reoQx/SctljNH6ch/kYTx2DEzKmmDm4JVP1/Kc4NgomD2gGAMDoVJaCe+KXncKW+
         cyA2VBIoQPxmG+73WUkGfyeQF2+Snt/BDcrwAE/je5QXWiW5X1hT/DCGJhLrzU0Hjn70
         QE6nb7muxprS1GkSn5EL3alHGk57c4ZBtf8J71kwz8YMGjAfO6vtH6d+VVEMv3Pew/KI
         UU3ZXt3xE+tAtimYmih5TwFPci0c9uC+RLXbwnCeHCm4VNI8Y4Wurt1SqqsQS5BzAKh3
         JD+rTDU8uufDgmljyQro/d/yweAFQTWQoIw2eHpHF/iUygKomsan98Q90jIBiG3qMihX
         9swA==
X-Gm-Message-State: AOJu0Yx8rLJ+i0m3BbJB23VrM467MJ1u5kGHbXn8jYoTnZHxb2wYZJHz
	Yp0ZS3VezuWF7+rdGREJ0KX5q0ISCYpt8irIqr19jfx4lGu8wrvg/7pHwaOhqMG0A4KTVbYsXXC
	mukcTcsZ2N20im16tCHfQtpq0YTiltNp/nX7HJBI+JQ==
X-Gm-Gg: ASbGncsZGNSROnXZIzoTSvKg2E9Xngn2NqA0tdnBG+i8Ib/HNL2sIgxgpw36vUDHJ5I
	79UnVuvHYJbicK6XuUNA+a46om0Vbe5OW91AgnJonKexRmGwQe62MIMEQFgC/1/iOsM3G+nQqIZ
	TRJLJwInhuMWNuwistbMvUON1OIdDG3fYGi5Ms8XMXpX7h
X-Google-Smtp-Source: AGHT+IG+uE6JNaiTNBzEjPYbpS2N1EfNvaaSjmTotxGF1D0qrRZKCjwj8k5GaI1P+sfN/A8SL6YXqySV7rcKeEbMJKQ=
X-Received: by 2002:a05:6512:1396:b0:553:659c:53fa with SMTP id
 2adb3069b0e04-553e3b9a33emr2979327e87.5.1750627291951; Sun, 22 Jun 2025
 14:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org> <20250618-work-pidfs-persistent-v2-13-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-13-98f3456fd552@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Sun, 22 Jun 2025 23:21:20 +0200
X-Gm-Features: Ac12FXwaZEFcmgA-EYPqAWkuMJyDeY_NK_ENd6y1nb8cK0ukjr-rrX_rFer3XvA
Message-ID: <CAJqdLrp6-RT5jtrpW6b06Hc--Ht8Ti+KH-tR=TAgbsK3Yci91g@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] selftests/pidfd: test extended attribute support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Mi., 18. Juni 2025 um 22:54 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add tests for extended attribute support on pidfds.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/pidfd/.gitignore         |  1 +
>  tools/testing/selftests/pidfd/Makefile           |  3 +-
>  tools/testing/selftests/pidfd/pidfd_xattr_test.c | 97 ++++++++++++++++++++++++
>  3 files changed, 100 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index 0406a065deb4..bc4130506eda 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -10,3 +10,4 @@ pidfd_file_handle_test
>  pidfd_bind_mount
>  pidfd_info_test
>  pidfd_exec_helper
> +pidfd_xattr_test
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index fcbefc0d77f6..c9fd5023ef15 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -3,7 +3,8 @@ CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
>
>  TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
>         pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
> -       pidfd_file_handle_test pidfd_bind_mount pidfd_info_test
> +       pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
> +       pidfd_xattr_test
>
>  TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
>
> diff --git a/tools/testing/selftests/pidfd/pidfd_xattr_test.c b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
> new file mode 100644
> index 000000000000..00d400ac515b
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_xattr_test.c
> @@ -0,0 +1,97 @@
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
> +FIXTURE(pidfs_xattr)
> +{
> +       pid_t child_pid;
> +       int child_pidfd;
> +};
> +
> +FIXTURE_SETUP(pidfs_xattr)
> +{
> +       self->child_pid = create_child(&self->child_pidfd, CLONE_NEWUSER | CLONE_NEWPID);
> +       EXPECT_GE(self->child_pid, 0);
> +
> +       if (self->child_pid == 0)
> +               _exit(EXIT_SUCCESS);
> +}
> +
> +FIXTURE_TEARDOWN(pidfs_xattr)
> +{
> +       sys_waitid(P_PID, self->child_pid, NULL, WEXITED);
> +}
> +
> +TEST_F(pidfs_xattr, set_get_list_xattr_multiple)
> +{
> +       int ret, i;
> +       char xattr_name[32];
> +       char xattr_value[32];
> +       char buf[32];
> +       const int num_xattrs = 10;
> +       char list[PATH_MAX] = {};
> +
> +       for (i = 0; i < num_xattrs; i++) {
> +               snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
> +               snprintf(xattr_value, sizeof(xattr_value), "testvalue%d", i);
> +               ret = fsetxattr(self->child_pidfd, xattr_name, xattr_value, strlen(xattr_value), 0);
> +               ASSERT_EQ(ret, 0);
> +       }
> +
> +       for (i = 0; i < num_xattrs; i++) {
> +               snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
> +               snprintf(xattr_value, sizeof(xattr_value), "testvalue%d", i);
> +               memset(buf, 0, sizeof(buf));
> +               ret = fgetxattr(self->child_pidfd, xattr_name, buf, sizeof(buf));
> +               ASSERT_EQ(ret, strlen(xattr_value));
> +               ASSERT_EQ(strcmp(buf, xattr_value), 0);
> +       }
> +
> +       ret = flistxattr(self->child_pidfd, list, sizeof(list));
> +       ASSERT_GT(ret, 0);
> +       for (i = 0; i < num_xattrs; i++) {
> +               snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
> +               bool found = false;
> +               for (char *it = list; it < list + ret; it += strlen(it) + 1) {
> +                       if (strcmp(it, xattr_name))
> +                               continue;
> +                       found = true;
> +                       break;
> +               }
> +               ASSERT_TRUE(found);
> +       }
> +
> +       for (i = 0; i < num_xattrs; i++) {
> +               snprintf(xattr_name, sizeof(xattr_name), "trusted.testattr%d", i);
> +               ret = fremovexattr(self->child_pidfd, xattr_name);
> +               ASSERT_EQ(ret, 0);
> +
> +               ret = fgetxattr(self->child_pidfd, xattr_name, buf, sizeof(buf));
> +               ASSERT_EQ(ret, -1);
> +               ASSERT_EQ(errno, ENODATA);
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

