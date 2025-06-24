Return-Path: <linux-fsdevel+bounces-52680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A20AAE5C54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0E33A42FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0624A049;
	Tue, 24 Jun 2025 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKj29pUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74F23D2AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744755; cv=none; b=UA8GeJrAVKq+dq7qiGeYM7lsI5p1OVfB9kqDoLlaaOdd7ndf6+Hwi8OD/lVXvfVp2V9aU7ZBAolX4B/Xp0svh7PJ8PqJd6gsM+/IPdvh8rtk5mDyXWcEMoDbWqlsYPrZlFwjH5qpsO0fKXLAXDcdR3ei0NJI1voc7jRf4lYX5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744755; c=relaxed/simple;
	bh=LAp5JZIOSgljZImIc2SJWIB4p3YDj8N4mo3NG0LQkPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8QHxSb5d5zi4QhkrtOM+Mg16cjkZrMwZ9sk6KxodEObVdNL7fovLSFaYqrsNsXMZO+7b7D3RJWNYKtJ7dUuKP2J2eFAWguSayUhWN5Sjc2X0mNjYXtQepobC9e5tkWqluUhawta3XlWp7l7eB0kMWyqw7Os9P3Q4xUmA5RnaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKj29pUA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89ee255easo900686066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 22:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750744752; x=1751349552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVaZw0i4BUmAf1Ie86VkMnmnNGvdE1H+aGxHsXUBB+8=;
        b=kKj29pUA13WDy921vgqBGSTNciDXXmgAZ495Vw9N9AQRHTJmyEwHdePQvs/WySbsS7
         oYTVGWdDYeZSy/8YbcTgFBiCOsiX+IVfb/ONPeCzWcMbe7+bKKbg9Hu6X/PD1p7BADON
         kTEes4FB8eYwLDl4YU0njqSpEKStKk1N7VU8DDUSGb4KD5o+Ru0J/qUzgvEBWbTvbzc8
         WIBYF6smyhHnIz0xlcmjudhKNfpbwohjOAbbBD7HSGJtYGkazcxtPeHo9BmX4ms5UH8p
         UsWWi9X1yZM+DXHriH0BWn6HulDo00Mr2+1AReE11F1rb/fad/kYUY53M8YYIGFkhTuN
         eb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750744752; x=1751349552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVaZw0i4BUmAf1Ie86VkMnmnNGvdE1H+aGxHsXUBB+8=;
        b=ZUHze/G6A/vq7YYGK79WP8zdvfZ92te3NjLV/XK6LgkkIwEtLLWHBMZtovbyHFzEoH
         lqgwb/ymNameJLW/9BJet64g4hCHG12lq0UNwTqKGW47gNYpjHu4lOtutnzPYD8vMP43
         QQp4gBGr2REg7Kuh9Q2K2gU6NfrNUsaFzzOkuXhs5lHFY4YToLj4PTAeUpaldPDNOfwb
         esxJiZgtZQqeGtrwTshLjBB/bCNWkykEUabKUd3LYXjhvf24MUBRLf+wjzqNqHvAAj32
         UAANnZSu8KYe39HGCHCBObvO5s5I3mftnqX/shhH+60GR3zOqkICRVlBfPDK69D3BNSK
         lS6g==
X-Forwarded-Encrypted: i=1; AJvYcCUDh72we1ypyo94uhK40G6UT7ra78ujX4kvtav0WzIBhv4xGn9/2LTpxUwAnYlXB8nXgwdV1Lm1926kU5e4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7JGTUr55nb22nFPzI2OyW9r22UHeUMWTIc4md7sS79rDyqI6
	FrAPS/pxloUBCK1A/j1cc/iBBsw5O9ySwCeXvhj5miFxUFnx1N+BJtfHaeKL+U45Mi07Vs06kBO
	n7DqBwYnowHuNWh3qsyAUXupczVWTrzA=
X-Gm-Gg: ASbGnctR59MBnty342fYlrkaB9iqimZC6YB459kT6nNWm0ek2uRUyvub5mQ4RFjb1bM
	yRWEA32RWoOI693FNFWrB4DDzHg1gL+mPXPyWIbpEnzFFx6wWN4ayuxKNmHla3Hj0r/yEF2VK0Q
	g9+KB3pVxAnY11AG/mtA/n6OpbQBRl+5s+PkWVzUeU13e6R5zaXK+AEg==
X-Google-Smtp-Source: AGHT+IHNhOB6XHG8k2OnM2GK65BVRUGo1eOdCFPmFYBm07VFtL9+qzUYjiGLYaUrnuHzR99p80vbJqPq20LyWSOoel0=
X-Received: by 2002:a17:907:9813:b0:ade:9b52:4d78 with SMTP id
 a640c23a62f3a-ae057f65e1dmr1421037566b.48.1750744751115; Mon, 23 Jun 2025
 22:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623194455.2847844-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250623194455.2847844-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Jun 2025 07:58:59 +0200
X-Gm-Features: AX0GCFv1vn4E1s2bcV4YQsF5YlBtoCIDZ7y7DfmpBNTKxqC769mxq5wyU_e-qI0
Message-ID: <CAOQ4uxgABrw4kTVPWBAbxDYnmbXmeMREv++ibtp4q1STdiWyag@mail.gmail.com>
Subject: Re: [PATCH] fanotify: selftests for fanotify permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 9:45=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This adds selftests which exercise generating / responding to
> permission events. They requre root privileges since

                                         ^^^^ require
> FAN_CLASS_PRE_CONTENT requires it.
>
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/filesystems/fanotify/.gitignore |   2 +
>  .../selftests/filesystems/fanotify/Makefile   |   8 +
>  .../filesystems/fanotify/fanotify_perm_test.c | 386 ++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/fanotify/.gitigno=
re
>  create mode 100644 tools/testing/selftests/filesystems/fanotify/Makefile
>  create mode 100644 tools/testing/selftests/filesystems/fanotify/fanotify=
_perm_test.c
>

Hi Ibrahim,

As a general comment, I do not mind having diverse testing
methods, but just wanted to make sure that you know that we
usually write fanotify tests to new features in LTP.

LTP vs. selftests have their pros and cons, but both bring value
and add test coverage.
selftests would not have been my first choice for this particular test,
because it is so similar to tests already existing in LTP, e.g.:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sysc=
alls/fanotify/fanotify24.c

but I suppose that testing the full functionality of event listener fd hand=
over
might be easier to implement with the selftest infrastructure.
Anyway, I will not require you to use one test suite or the other if you ha=
ve
a preference.

One of the perks of using selftests is that you can post the test patch in
the same series of the feature patches, but you haven't made use of this pe=
rk,
so you may want to do that for v2.

Other than that, the test looks good, so you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.


> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 339b31e6a6b5..9cae71edca9f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -32,6 +32,7 @@ TARGETS +=3D fchmodat2
>  TARGETS +=3D filesystems
>  TARGETS +=3D filesystems/binderfs
>  TARGETS +=3D filesystems/epoll
> +TARGETS +=3D filesystems/fanotify
>  TARGETS +=3D filesystems/fat
>  TARGETS +=3D filesystems/overlayfs
>  TARGETS +=3D filesystems/statmount
> diff --git a/tools/testing/selftests/filesystems/fanotify/.gitignore b/to=
ols/testing/selftests/filesystems/fanotify/.gitignore
> new file mode 100644
> index 000000000000..a9f51c9aca9f
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fanotify/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +fanotify_perm_test
> diff --git a/tools/testing/selftests/filesystems/fanotify/Makefile b/tool=
s/testing/selftests/filesystems/fanotify/Makefile
> new file mode 100644
> index 000000000000..931bedd989b9
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fanotify/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
> +LDLIBS +=3D -lcap
> +
> +TEST_GEN_PROGS :=3D fanotify_perm_test
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/fanotify/fanotify_perm_t=
est.c b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
> new file mode 100644
> index 000000000000..87d718323b1a
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <limits.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +// Needed for linux/fanotify.h
> +#ifndef __kernel_fsid_t
> +typedef struct {
> +       int val[2];
> +} __kernel_fsid_t;
> +#endif
> +#include <sys/fanotify.h>
> +
> +static const char test_dir_templ[] =3D "/tmp/fanotify_perm_test.XXXXXX";
> +
> +FIXTURE(fanotify)
> +{
> +       char test_dir[sizeof(test_dir_templ)];
> +       char test_dir2[sizeof(test_dir_templ)];
> +       int fan_fd;
> +       int fan_fd2;
> +       char test_file_path[PATH_MAX];
> +       char test_file_path2[PATH_MAX];
> +       char test_exec_path[PATH_MAX];
> +};
> +
> +FIXTURE_SETUP(fanotify)
> +{
> +       int ret;
> +
> +       /* Setup test directories and files */
> +       strcpy(self->test_dir, test_dir_templ);
> +       ASSERT_NE(mkdtemp(self->test_dir), NULL);
> +       strcpy(self->test_dir2, test_dir_templ);
> +       ASSERT_NE(mkdtemp(self->test_dir2), NULL);
> +
> +       snprintf(self->test_file_path, PATH_MAX, "%s/test_file",
> +                self->test_dir);
> +       snprintf(self->test_file_path2, PATH_MAX, "%s/test_file2",
> +                self->test_dir2);
> +       snprintf(self->test_exec_path, PATH_MAX, "%s/test_exec",
> +                self->test_dir);
> +
> +       ret =3D open(self->test_file_path, O_CREAT | O_RDWR, 0644);
> +       ASSERT_GE(ret, 0);
> +       ASSERT_EQ(write(ret, "test data", 9), 9);
> +       close(ret);
> +
> +       ret =3D open(self->test_file_path2, O_CREAT | O_RDWR, 0644);
> +       ASSERT_GE(ret, 0);
> +       ASSERT_EQ(write(ret, "test data2", 9), 9);
> +       close(ret);
> +
> +       ret =3D open(self->test_exec_path, O_CREAT | O_RDWR, 0755);
> +       ASSERT_GE(ret, 0);
> +       ASSERT_EQ(write(ret, "#!/bin/bash\necho test\n", 22), 22);
> +       close(ret);
> +
> +       self->fan_fd =3D fanotify_init(
> +               FAN_CLASS_PRE_CONTENT | FAN_NONBLOCK | FAN_CLOEXEC, O_RDO=
NLY);
> +       ASSERT_GE(self->fan_fd, 0);
> +
> +       self->fan_fd2 =3D fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_NONBL=
OCK |
> +                                             FAN_CLOEXEC | FAN_ENABLE_EV=
ENT_ID,
> +                                     O_RDONLY);
> +       ASSERT_GE(self->fan_fd2, 0);
> +
> +       /* Mark the directories for permission events */
> +       ret =3D fanotify_mark(self->fan_fd, FAN_MARK_ADD,
> +                           FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
> +                                   FAN_EVENT_ON_CHILD,
> +                           AT_FDCWD, self->test_dir);
> +       ASSERT_EQ(ret, 0);
> +
> +       ret =3D fanotify_mark(self->fan_fd2, FAN_MARK_ADD,
> +                           FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
> +                                   FAN_EVENT_ON_CHILD,
> +                           AT_FDCWD, self->test_dir2);
> +       ASSERT_EQ(ret, 0);
> +}
> +
> +FIXTURE_TEARDOWN(fanotify)
> +{
> +       /* Clean up test directory and files */
> +       if (self->fan_fd > 0)
> +               close(self->fan_fd);
> +       if (self->fan_fd2 > 0)
> +               close(self->fan_fd2);
> +
> +       EXPECT_EQ(unlink(self->test_file_path), 0);
> +       EXPECT_EQ(unlink(self->test_file_path2), 0);
> +       EXPECT_EQ(unlink(self->test_exec_path), 0);
> +       EXPECT_EQ(rmdir(self->test_dir), 0);
> +       EXPECT_EQ(rmdir(self->test_dir2), 0);
> +}
> +
> +static struct fanotify_event_metadata *get_event(int fd)
> +{
> +       struct fanotify_event_metadata *metadata;
> +       ssize_t len;
> +       char buf[256];
> +
> +       len =3D read(fd, buf, sizeof(buf));
> +       if (len <=3D 0)
> +               return NULL;
> +
> +       metadata =3D (void *)buf;
> +       if (!FAN_EVENT_OK(metadata, len))
> +               return NULL;
> +
> +       return metadata;
> +}
> +
> +static int respond_to_event(int fd, struct fanotify_event_metadata *meta=
data,
> +                           uint32_t response, bool useEventId)
> +{
> +       struct fanotify_response resp;
> +
> +       if (useEventId) {
> +               resp.event_id =3D metadata->event_id;
> +       } else {
> +               resp.fd =3D metadata->fd;
> +       }
> +       resp.response =3D response;
> +
> +       return write(fd, &resp, sizeof(resp));
> +}
> +
> +static void verify_event(struct __test_metadata *const _metadata,
> +                        struct fanotify_event_metadata *event,
> +                        uint64_t expect_mask, int expect_pid)
> +{
> +       ASSERT_NE(event, NULL);
> +       ASSERT_EQ(event->mask, expect_mask);
> +
> +       if (expect_pid > 0)
> +               ASSERT_EQ(event->pid, expect_pid);
> +}
> +
> +TEST_F(fanotify, open_perm_allow)
> +{
> +       struct fanotify_event_metadata *event;
> +       int fd, ret;
> +       pid_t child;
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               /* Try to open the file - this should trigger FAN_OPEN_PE=
RM */
> +               fd =3D open(self->test_file_path, O_RDONLY);
> +               if (fd < 0)
> +                       exit(EXIT_FAILURE);
> +               close(fd);
> +               exit(EXIT_SUCCESS);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd);
> +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> +
> +       /* Allow the open operation */
> +       close(event->fd);
> +       ret =3D respond_to_event(self->fan_fd, event, FAN_ALLOW,
> +                              false /* useEventId */);
> +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> +}
> +
> +TEST_F(fanotify, open_perm_deny)
> +{
> +       struct fanotify_event_metadata *event;
> +       int ret;
> +       pid_t child;
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               /* Try to open the file - this should trigger FAN_OPEN_PE=
RM */
> +               int fd =3D open(self->test_file_path, O_RDONLY);
> +
> +               /* If open succeeded, this is an error as we expect it to=
 be denied */
> +               if (fd >=3D 0) {
> +                       close(fd);
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               /* Verify the expected error */
> +               if (errno =3D=3D EPERM)
> +                       exit(EXIT_SUCCESS);
> +
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd);
> +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> +
> +       /* Deny the open operation */
> +       close(event->fd);
> +       ret =3D respond_to_event(self->fan_fd, event, FAN_DENY,
> +                              false /* useEventId */);
> +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> +}
> +
> +TEST_F(fanotify, exec_perm_allow)
> +{
> +       struct fanotify_event_metadata *event;
> +       int ret;
> +       pid_t child;
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               /* Try to execute the file - this should trigger FAN_OPEN=
_EXEC_PERM */
> +               execl(self->test_exec_path, "test_exec", NULL);
> +
> +               /* If we get here, execl failed */
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd);
> +       verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
> +
> +       /* Allow the exec operation + ignore subsequent events */
> +       ASSERT_GE(fanotify_mark(self->fan_fd,
> +                               FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> +                                       FAN_MARK_IGNORED_SURV_MODIFY,
> +                               FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM, event=
->fd,
> +                               NULL),
> +                 0);
> +       close(event->fd);
> +       ret =3D respond_to_event(self->fan_fd, event, FAN_ALLOW,
> +                              false /* useEventId */);
> +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WIFEXITED(status), 1);
> +}
> +
> +TEST_F(fanotify, exec_perm_deny)
> +{
> +       struct fanotify_event_metadata *event;
> +       int ret;
> +       pid_t child;
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               /* Try to execute the file - this should trigger FAN_OPEN=
_EXEC_PERM */
> +               execl(self->test_exec_path, "test_exec", NULL);
> +
> +               /* If execl failed with EPERM, that's what we expect */
> +               if (errno =3D=3D EPERM)
> +                       exit(EXIT_SUCCESS);
> +
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd);
> +       verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
> +
> +       /* Deny the exec operation */
> +       close(event->fd);
> +       ret =3D respond_to_event(self->fan_fd, event, FAN_DENY,
> +                              false /* useEventId */);
> +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> +}
> +
> +TEST_F(fanotify, default_response)
> +{
> +       struct fanotify_event_metadata *event;
> +       int ret;
> +       pid_t child;
> +       struct fanotify_response resp;
> +
> +       /* Set default response to deny */
> +       resp.fd =3D FAN_NOFD;
> +       resp.response =3D FAN_DENY | FAN_DEFAULT;
> +       ret =3D write(self->fan_fd, &resp, sizeof(resp));
> +       ASSERT_EQ(ret, sizeof(resp));
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               close(self->fan_fd);
> +               /* Try to open the file - this should trigger FAN_OPEN_PE=
RM */
> +               int fd =3D open(self->test_file_path, O_RDONLY);
> +
> +               /* If open succeeded, this is an error as we expect it to=
 be denied */
> +               if (fd >=3D 0) {
> +                       close(fd);
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               /* Verify the expected error */
> +               if (errno =3D=3D EPERM)
> +                       exit(EXIT_SUCCESS);
> +
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd);
> +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> +
> +       /* Close fanotify group to return default response (DENY) */
> +       close(self->fan_fd);
> +       self->fan_fd =3D -1;
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> +}
> +
> +TEST_F(fanotify, respond_via_event_id)
> +{
> +       struct fanotify_event_metadata *event;
> +       int fd, ret;
> +       pid_t child;
> +
> +       child =3D fork();
> +       ASSERT_GE(child, 0);
> +
> +       if (child =3D=3D 0) {
> +               /* Try to open the file - this should trigger FAN_OPEN_PE=
RM */
> +               fd =3D open(self->test_file_path2, O_RDONLY);
> +               if (fd < 0)
> +                       exit(EXIT_FAILURE);
> +               close(fd);
> +               exit(EXIT_SUCCESS);
> +       }
> +
> +       usleep(100000);
> +       event =3D get_event(self->fan_fd2);
> +       verify_event(_metadata, event, FAN_OPEN_PERM, child);
> +       ASSERT_EQ(event->event_id, 1);
> +
> +       /* Allow the open operation */
> +       close(event->fd);
> +       ret =3D respond_to_event(self->fan_fd2, event, FAN_ALLOW,
> +                              true /* useEventId */);
> +       ASSERT_EQ(ret, sizeof(struct fanotify_response));
> +
> +       int status;
> +
> +       ASSERT_EQ(waitpid(child, &status, 0), child);
> +       ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
> +}
> +
> +TEST_HARNESS_MAIN
> --
> 2.47.1
>

