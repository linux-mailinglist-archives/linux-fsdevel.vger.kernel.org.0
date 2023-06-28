Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5089B740B6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjF1I2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjF1IZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:53 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE436359D;
        Wed, 28 Jun 2023 01:16:12 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-573491c4deeso57459867b3.0;
        Wed, 28 Jun 2023 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940172; x=1690532172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3QQtzsB9V3fuIDL5zl/uTPJ+3Zg2a9avrNhgctO+EQ=;
        b=jr2He6kcJtMvllFqzmbYovQ/OokWzVij8xLJ0AW0rsTBSVsEOl1ZPrksirQS9tdGVN
         EjhAyUk6LghdZlKDAE6rI4cBCjrf4CbR2g/Nx+N2MDFzgLuYtnKL3RifYuD21zBv1Umd
         xQ0OB8We/XShodTkOPYliJoZMN6X9wRxpqSqNLDpsQ7YkRDBKswMeVGknX/7wsDdtwGb
         LtvFY5RiT7EyGtmiubg2sSakABfhdZ0mzWKsu146dsVF8KpDplHqvrJ7EwKEGrPmfREq
         TF9ZBirv6pymumV6k+OahardwPk4z4NYawhYqrZoUQUHts1pkDIF6F3s/K3pKSGll2Qr
         8hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940172; x=1690532172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3QQtzsB9V3fuIDL5zl/uTPJ+3Zg2a9avrNhgctO+EQ=;
        b=RgwGv/z9gUfdqwgs68mK4Mrm8PO6ylt83JLz9esnyQ19JOMnGmDHC/BqwTbfRCXwaT
         idOcY4laPwBAu31CorlAB2qY7XF5pMOnx9vQvBFucNFV+8DJCuL6sRtSWmttnIKgQQhg
         U100JfhA2anE5GJNX9XYw3WI10vg4sT316xTh4Hx4JEX5WemmLNy/ImOVr/vAwwQzjts
         3mMADuq9mHLo2s70kBHnEvnPwc4gxYiSZUA2n07IvbMF4vxOghLKiWkG3JJCed7s/FsX
         XLJPp2iqK6kIxEnI9G4x5e6cSr9fi5kMZYV4+6m2ogV46ldZ1Z2tcjbPkrzqCfT5YQWq
         NpxQ==
X-Gm-Message-State: AC+VfDxZEOtq/d70JreI6Eek3KBUKC3yj9KGEbM5Vm3jksu4/6vhpzA7
        TZcXJ8LgMk3mj3AlDazfYpUFULceCGZ/UrDmATEIQbA2guY=
X-Google-Smtp-Source: ACHHUZ78wiKDyQ5XaSGnVww2T2xFRlTkUjNmOrzbQLihsDnTClogZw6rI7MrYopic1RaAphiQznTyrlvjhF21UQur0g=
X-Received: by 2002:a67:ee48:0:b0:443:6549:3e18 with SMTP id
 g8-20020a67ee48000000b0044365493e18mr3201367vsp.18.1687930226467; Tue, 27 Jun
 2023 22:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <ajkeyn2sy35h6ctfbupom4xg3ozoxxgsojdvu7vebac44zqped@ecnusnv6daxn> <f4mzakro6yp7dlq25h3mbm3ecbkuebwlengdln47y4w5wfqwo2@3hasgbhltgvg>
In-Reply-To: <f4mzakro6yp7dlq25h3mbm3ecbkuebwlengdln47y4w5wfqwo2@3hasgbhltgvg>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jun 2023 08:30:15 +0300
Message-ID: <CAOQ4uxg4mGpqCMCnJcNSK9vQXU1hx8XPQDEcL0+3yM7AF9V9-A@mail.gmail.com>
Subject: Re: [LTP RFC PATCH v3] inotify13: new test for fs/splice.c functions
 vs pipes vs inotify
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it,
        Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:21=E2=80=AFAM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> The only one that passes on 6.1.27-1 is sendfile_file_to_pipe.
>
> Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffy=
js3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
> Sorry, I missed second part of Amir's comments somehow.
> cleanup is only run at the end by default:
> run it manually to not leak fds between tests.
>
> I've parameterised the tests from the driver, instead of with macros,
> and removed the tst_tag data.
>
> Added the * [Description] tag and full commit subject to the header
> comment; leaving the lore.k.o link for now, to be turned into a SHA
> when the kernel behaviour this tests starts having a SHA.
>
> Error checking has been lifted out as well.
> Formatted in kernel style accd'g to clang-format and check-inotify13.
>
> I used the wrong address for ltp@ the first time; I've since bounced the
> patchset, and am sending this, to the correct address. They were all
> held for moderation for now.
>
>  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
>  testcases/kernel/syscalls/inotify/inotify13.c | 282 ++++++++++++++++++
>  2 files changed, 283 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c
>
> diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/ker=
nel/syscalls/inotify/.gitignore
> index f6e5c546a..b597ea63f 100644
> --- a/testcases/kernel/syscalls/inotify/.gitignore
> +++ b/testcases/kernel/syscalls/inotify/.gitignore
> @@ -10,3 +10,4 @@
>  /inotify10
>  /inotify11
>  /inotify12
> +/inotify13
> diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/ke=
rnel/syscalls/inotify/inotify13.c
> new file mode 100644
> index 000000000..97f88053e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*\
> + * [Description]
> + * Verify splice-family functions (and sendfile) generate IN_ACCESS
> + * for what they read and IN_MODIFY for what they write.
> + *
> + * Regression test for 983652c69199 ("splice: report related fsnotify ev=
ents") and
> + * https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u

The process of posting a test for the fix that was not yet merged
is indeed a chicken and egg situation.

What I usually do is post a draft test (like this) and link
to the post of the LTP test (and maybe a branch on github)
when posting the fix, to say how I tested the fix.

I would then put it in my TODO to re-post the LTP
test once the kernel fix has been merged.

> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <inttypes.h>
> +#include <signal.h>
> +#include <sys/mman.h>
> +#include <sys/sendfile.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
> +#include "inotify.h"
> +
> +#if defined(HAVE_SYS_INOTIFY_H)
> +#include <sys/inotify.h>
> +
> +static int pipes[2] =3D { -1, -1 };
> +static int inotify =3D -1;
> +static int memfd =3D -1;
> +static int data_pipes[2] =3D { -1, -1 };
> +
> +static void watch_rw(int fd)
> +{
> +       char buf[64];
> +
> +       sprintf(buf, "/proc/self/fd/%d", fd);
> +       SAFE_MYINOTIFY_ADD_WATCH(inotify, buf, IN_ACCESS | IN_MODIFY);
> +}
> +
> +static int compar(const void *l, const void *r)
> +{
> +       const struct inotify_event *lie =3D l;
> +       const struct inotify_event *rie =3D r;
> +
> +       return lie->wd - rie->wd;
> +}
> +
> +static void get_events(size_t evcnt, struct inotify_event evs[static evc=
nt])
> +{
> +       struct inotify_event tail, *itr =3D evs;
> +
> +       for (size_t left =3D evcnt; left; --left)
> +               SAFE_READ(true, inotify, itr++, sizeof(struct inotify_eve=
nt));
> +
> +       TEST(read(inotify, &tail, sizeof(struct inotify_event)));
> +       if (TST_RET !=3D -1)
> +               tst_brk(TFAIL, ">%zu events", evcnt);
> +       if (TST_ERR !=3D EAGAIN)
> +               tst_brk(TFAIL | TTERRNO, "expected EAGAIN");
> +
> +       qsort(evs, evcnt, sizeof(struct inotify_event), compar);
> +}
> +
> +static void expect_transfer(const char *name, size_t size)
> +{
> +       if (TST_RET =3D=3D -1)
> +               tst_brk(TBROK | TERRNO, "%s", name);
> +       if ((size_t)TST_RET !=3D size)
> +               tst_brk(TBROK, "%s: %ld !=3D %zu", name, TST_RET, size);
> +}
> +
> +static void expect_event(struct inotify_event *ev, int wd, uint32_t mask=
)
> +{
> +       if (ev->wd !=3D wd)
> +               tst_brk(TFAIL, "expect event for wd %d got %d", wd, ev->w=
d);
> +       if (ev->mask !=3D mask)
> +               tst_brk(TFAIL,
> +                       "expect event with mask %" PRIu32 " got %" PRIu32=
 "",
> +                       mask, ev->mask);
> +}
> +
> +// write to file, rewind, transfer accd'g to f2p, read from pipe
> +// expecting: IN_ACCESS memfd, IN_MODIFY pipes[0]
> +static void file_to_pipe(const char *name, ssize_t (*f2p)(void))
> +{
> +       struct inotify_event events[2];
> +       char buf[strlen(name)];
> +
> +       SAFE_WRITE(SAFE_WRITE_RETRY, memfd, name, strlen(name));
> +       SAFE_LSEEK(memfd, 0, SEEK_SET);
> +       watch_rw(memfd);
> +       watch_rw(pipes[0]);
> +       TEST(f2p());
> +       expect_transfer(name, strlen(name));
> +
> +       get_events(ARRAY_SIZE(events), events);
> +       expect_event(events + 0, 1, IN_ACCESS);
> +       expect_event(events + 1, 2, IN_MODIFY);

So what I meant to say is that if there are double events that
usually get merged (unless reader was fast enough to read the
first event), this is something that I could live with, but encoding
an expectation for a double event, that's not at all what I meant.

But anyway, I see that you've found a way to work around
this problem, so at least the test can expect and get a single event.

I think you are missing expect_no_more_events() here to
verify that you won't get double events.

See test inotify12 as an example for a test that encodes
expect_events per test case and also verifies there are no
unexpected extra events.

That's also an example of a more generic test template,
but your test cases are all a bit different from each other is
subtle ways, so I trust you will find the best balance between
putting generic parameterized code in the run_test() template
and putting code in the test case subroutine.

> +
> +       SAFE_READ(true, pipes[0], buf, strlen(name));
> +       if (memcmp(buf, name, strlen(name)))
> +               tst_brk(TFAIL, "buf contents bad");
> +}
> +static ssize_t splice_file_to_pipe(void)
> +{
> +       return splice(memfd, NULL, pipes[1], NULL, 128 * 1024 * 1024, 0);
> +}
> +static ssize_t sendfile_file_to_pipe(void)
> +{
> +       return sendfile(pipes[1], memfd, NULL, 128 * 1024 * 1024);
> +}
> +
> +// write to pipe, transfer with splice, rewind file, read from file
> +// expecting: IN_ACCESS pipes[0], IN_MODIFY memfd
> +static void splice_pipe_to_file(const char *name, ssize_t (*param)(void)=
)
> +{
> +       (void)name;
> +       (void)param;
> +       struct inotify_event events[2];
> +       char buf[sizeof(__func__)];
> +
> +       SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__)=
);
> +       watch_rw(pipes[0]);
> +       watch_rw(memfd);
> +       TEST(splice(pipes[0], NULL, memfd, NULL, 128 * 1024 * 1024, 0));
> +       expect_transfer(__func__, sizeof(__func__));
> +
> +       get_events(ARRAY_SIZE(events), events);
> +       expect_event(events + 0, 1, IN_ACCESS);
> +       expect_event(events + 1, 2, IN_MODIFY);
> +
> +       SAFE_LSEEK(memfd, 0, SEEK_SET);
> +       SAFE_READ(true, memfd, buf, sizeof(__func__));
> +       if (memcmp(buf, __func__, sizeof(__func__)))
> +               tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +// write to data_pipe, transfer accd'g to p2p, read from pipe
> +// expecting: IN_ACCESS data_pipes[0], IN_MODIFY pipes[1]
> +static void pipe_to_pipe(const char *name, ssize_t (*p2p)(void))
> +{
> +       struct inotify_event events[2];
> +       char buf[strlen(name)];
> +
> +       SAFE_WRITE(SAFE_WRITE_RETRY, data_pipes[1], name, strlen(name));
> +       watch_rw(data_pipes[0]);
> +       watch_rw(pipes[1]);
> +       TEST(p2p());
> +       expect_transfer(name, strlen(name));
> +
> +       get_events(ARRAY_SIZE(events), events);
> +       expect_event(events + 0, 1, IN_ACCESS);
> +       expect_event(events + 1, 2, IN_MODIFY);
> +
> +       SAFE_READ(true, pipes[0], buf, strlen(name));
> +       if (memcmp(buf, name, strlen(name)))
> +               tst_brk(TFAIL, "buf contents bad");
> +}
> +static ssize_t splice_pipe_to_pipe(void)
> +{
> +       return splice(data_pipes[0], NULL, pipes[1], NULL, 128 * 1024 * 1=
024,
> +                     0);
> +}
> +static ssize_t tee_pipe_to_pipe(void)
> +{
> +       return tee(data_pipes[0], pipes[1], 128 * 1024 * 1024, 0);
> +}
> +
> +// vmsplice to pipe, read from pipe
> +// expecting: IN_MODIFY pipes[0]
> +static char vmsplice_pipe_to_mem_dt[32 * 1024];
> +static void vmsplice_pipe_to_mem(const char *name, ssize_t (*param)(void=
))
> +{
> +       (void)name;
> +       (void)param;
> +       struct inotify_event event;
> +       char buf[sizeof(__func__)];
> +
> +       memcpy(vmsplice_pipe_to_mem_dt, __func__, sizeof(__func__));
> +       watch_rw(pipes[0]);
> +       TEST(vmsplice(
> +               pipes[1],
> +               &(struct iovec){ .iov_base =3D vmsplice_pipe_to_mem_dt,
> +                                .iov_len =3D sizeof(vmsplice_pipe_to_mem=
_dt) },
> +               1, SPLICE_F_GIFT));
> +       expect_transfer(__func__, sizeof(vmsplice_pipe_to_mem_dt));
> +
> +       get_events(1, &event);
> +       expect_event(&event, 1, IN_MODIFY);
> +
> +       SAFE_READ(true, pipes[0], buf, sizeof(__func__));
> +       if (memcmp(buf, __func__, sizeof(__func__)))
> +               tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +// write to pipe, vmsplice from pipe
> +// expecting: IN_ACCESS pipes[1]
> +static void vmsplice_mem_to_pipe(const char *name, ssize_t (*param)(void=
))
> +{
> +       (void)name;
> +       (void)param;
> +       char buf[sizeof(__func__)];
> +       struct inotify_event event;
> +
> +       SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__)=
);
> +       watch_rw(pipes[1]);
> +       TEST(vmsplice(pipes[0],
> +                     &(struct iovec){ .iov_base =3D buf,
> +                                      .iov_len =3D sizeof(buf) },
> +                     1, 0));
> +       expect_transfer(__func__, sizeof(buf));
> +
> +       get_events(1, &event);
> +       expect_event(&event, 1, IN_ACCESS);
> +
> +       if (memcmp(buf, __func__, sizeof(__func__)))
> +               tst_brk(TFAIL, "buf contents bad");
> +}
> +
> +#define TEST_F(f, param)      \
> +       {                     \
> +               #f, f, param, \
> +       }
> +static const struct {
> +       const char *n;
> +       void (*f)(const char *name, ssize_t (*param)(void));
> +       ssize_t (*param)(void);
> +} tests[] =3D {
> +       TEST_F(file_to_pipe, splice_file_to_pipe),
> +       TEST_F(file_to_pipe, sendfile_file_to_pipe),
> +       TEST_F(splice_pipe_to_file, NULL),
> +       TEST_F(pipe_to_pipe, splice_pipe_to_pipe),
> +       TEST_F(pipe_to_pipe, tee_pipe_to_pipe),
> +       TEST_F(vmsplice_pipe_to_mem, NULL),
> +       TEST_F(vmsplice_mem_to_pipe, NULL),
> +};
> +
> +static void cleanup(void)
> +{
> +       if (memfd !=3D -1)
> +               SAFE_CLOSE(memfd);
> +       if (inotify !=3D -1)
> +               SAFE_CLOSE(inotify);
> +       if (pipes[0] !=3D -1)
> +               SAFE_CLOSE(pipes[0]);
> +       if (pipes[1] !=3D -1)
> +               SAFE_CLOSE(pipes[1]);
> +       if (data_pipes[0] !=3D -1)
> +               SAFE_CLOSE(data_pipes[0]);
> +       if (data_pipes[1] !=3D -1)
> +               SAFE_CLOSE(data_pipes[1]);
> +}
> +
> +static void run_test(unsigned int n)
> +{
> +       tst_res(TINFO, "%s", tests[n].n);
> +
> +       SAFE_PIPE2(pipes, O_CLOEXEC);
> +       SAFE_PIPE2(data_pipes, O_CLOEXEC);
> +       inotify =3D SAFE_MYINOTIFY_INIT1(IN_NONBLOCK | IN_CLOEXEC);
> +       memfd =3D memfd_create(__func__, MFD_CLOEXEC);
> +       if (memfd =3D=3D -1)
> +               tst_brk(TCONF | TERRNO, "memfd");
> +       tests[n].f(tests[n].n, tests[n].param);
> +       tst_res(TPASS, "=D0=BE=D0=BA");
> +       cleanup();
> +}
> +
> +static struct tst_test test =3D {
> +       .cleanup =3D cleanup,
> +       .test =3D run_test,
> +       .tcnt =3D ARRAY_SIZE(tests),
> +       .tags =3D (const struct tst_tag[]){ {} },

I don't think this is needed for the draft...

Thanks,
Amir.
