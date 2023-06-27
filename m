Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D87406B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjF0W5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0W5b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:57:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24982940;
        Tue, 27 Jun 2023 15:57:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 444411F8AC;
        Tue, 27 Jun 2023 22:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687906647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEEbuR4SgcAhYDAVQkiILdHCrgZrt4xZaGwjOJMSplk=;
        b=xGmRXkmLQ0kS1su/BnuAIkYfaI4bQlEcyyTbyDCTzdeTrDzCqQPTm6eb7A2/9oT/CjRcO8
        p8pInZdIC1CN1xCzT0QJsiXYcFh708KhYXWCUL9Lmh7Vx+0Bm8AFt6ybwUj15jqQzbXNxQ
        /rrkjDdeOF9drV+lz0ctnSUSWfZs0vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687906647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEEbuR4SgcAhYDAVQkiILdHCrgZrt4xZaGwjOJMSplk=;
        b=WEkM3GvIqzX9ewMvatHIFrQSWIPJmlBqRjZlykntPMJs61kKJazdQSzh9L2miHVxGdCQ1d
        V8Pa9sWkdwJSACDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E569B13276;
        Tue, 27 Jun 2023 22:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k2C6NlZpm2RnbgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 22:57:26 +0000
Date:   Wed, 28 Jun 2023 00:57:25 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ahelenia =?iso-8859-2?Q?Ziemia=F1ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: Re: [LTP PATCH] inotify13: new test for fs/splice.c functions vs
 pipes vs inotify
Message-ID: <20230627225725.GB93981@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
 <44neh3sog5jaskc4zy6lwnld7hussp5sslx4fun47fr45mxe3a@q2jgkjwlq74f>
 <CAOQ4uxifYoKdup6gzyW0iV=KFBzTWu5T8=zq8s8pFw2X3+5xRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxifYoKdup6gzyW0iV=KFBzTWu5T8=zq8s8pFw2X3+5xRg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Tue, Jun 27, 2023 at 7:57 PM Ahelenia Ziemiańska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:

> > The only one that passes on 6.1.27-1 is sendfile_file_to_pipe.

> > Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
> > Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> > ---
> > Formatted to clang-format defaults. Put the original Fixes:ed SHA in the
> > metadata, that's probably fine, right?

> No. The git commit is for the commits that fix the problem.
> This can only be added after your fixes are merged.

> I will let the LPT developers comment about style,
> but I think LTP project wants tab indents.
> I am personally unable to read this patch with so little indentation
> and so much macroing.

Yes, it's hard to read. Style formatting it would improve it little bit
(make check-inotify13 is your friend, it complains a lot, also some spaces above
if () would make it more readable), but there are other things, e.g. macros
F2P(splice) and P2P(splice) should be functions (readability). Please have look
at other inotify tests, they are fairly simple and easy to read.

Also, this is a patch for LTP, you're supposed to post it also to LTP mailing
list (ltp@lists.linux.it, you need to register to
https://lists.linux.it/listinfo/ltp first).

> >  testcases/kernel/syscalls/inotify/.gitignore  |   1 +
> >  testcases/kernel/syscalls/inotify/inotify13.c | 246 ++++++++++++++++++
> >  2 files changed, 247 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

> > diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kernel/syscalls/inotify/.gitignore
> > index f6e5c546a..b597ea63f 100644
> > --- a/testcases/kernel/syscalls/inotify/.gitignore
> > +++ b/testcases/kernel/syscalls/inotify/.gitignore
> > @@ -10,3 +10,4 @@
> >  /inotify10
> >  /inotify11
> >  /inotify12
> > +/inotify13
> > diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kernel/syscalls/inotify/inotify13.c
> > new file mode 100644
> > index 000000000..c34f1dc9f
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/inotify/inotify13.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*\

You need to add here:
* [Description]

> > + * Verify splice-family functions (and sendfile) generate IN_ACCESS
> > + * for what they read and IN_MODIFY for what they write.
> > + *
> > + * Regression test for 983652c69199 and
I guess there would be only 983652c69199 ("splice: report related fsnotify
events").
> > + * https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
This is some discussion, not a real patch. Not sure how much useful it is, until
it results to fix accepted in the mainline kernel.

> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include "config.h"
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <fcntl.h>
> > +#include <stdbool.h>
> > +#include <inttypes.h>
> > +#include <signal.h>
> > +#include <sys/mman.h>
> > +#include <sys/sendfile.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_safe_macros.h"
> > +#include "inotify.h"
> > +
> > +#if defined(HAVE_SYS_INOTIFY_H)
> > +#include <sys/inotify.h>
> > +
> > +
> > +static int pipes[2] = {-1, -1};
> > +static int inotify = -1;
> > +static int memfd = -1;
> > +static int data_pipes[2] = {-1, -1};
> > +
> > +static void watch_rw(int fd) {
> > +  char buf[64];
> > +  sprintf(buf, "/proc/self/fd/%d", fd);
> > +  SAFE_MYINOTIFY_ADD_WATCH(inotify, buf, IN_ACCESS | IN_MODIFY);
> > +}
> > +
> > +static int compar(const void *l, const void *r) {
> > +  const struct inotify_event *lie = l;
> > +  const struct inotify_event *rie = r;
> > +  return lie->wd - rie->wd;
> > +}
> > +
> > +static void get_events(size_t evcnt, struct inotify_event evs[static evcnt]) {
> > +  struct inotify_event tail, *itr = evs;
> > +  for (size_t left = evcnt; left; --left)
> > +    SAFE_READ(true, inotify, itr++, sizeof(struct inotify_event));
> > +
> > +  TEST(read(inotify, &tail, sizeof(struct inotify_event)));
> > +  if (TST_RET != -1)
> > +    tst_brk(TFAIL, "expect %zu events", evcnt);
> > +  if (TST_ERR != EAGAIN)
> > +    tst_brk(TFAIL | TTERRNO, "expected EAGAIN");
> > +
> > +  qsort(evs, evcnt, sizeof(struct inotify_event), compar);
> > +}
> > +
> > +static void expect_event(struct inotify_event *ev, int wd, uint32_t mask) {
> > +  if (ev->wd != wd)
> > +    tst_brk(TFAIL, "expect event for wd %d got %d", wd, ev->wd);
> > +  if (ev->mask != mask)
> > +    tst_brk(TFAIL, "expect event with mask %" PRIu32 " got %" PRIu32 "", mask,
> > +            ev->mask);
> > +}
> > +
> > +#define F2P(splice)                                                            \
> > +  SAFE_WRITE(SAFE_WRITE_RETRY, memfd, __func__, sizeof(__func__));             \
> > +  SAFE_LSEEK(memfd, 0, SEEK_SET);                                              \
> > +  watch_rw(memfd);                                                             \
> > +  watch_rw(pipes[0]);                                                          \
> > +  TEST(splice);                                                                \
> > +  if (TST_RET == -1)                                                           \
> > +    tst_brk(TBROK | TERRNO, #splice);                                          \
> > +  if (TST_RET != sizeof(__func__))                                             \
> > +    tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);                          \
> > +                                                                               \
> > +  /*expecting: IN_ACCESS memfd, IN_MODIFY pipes[0]*/                           \
> > +  struct inotify_event events[2];                                              \
> > +  get_events(ARRAY_SIZE(events), events);                                      \
> > +  expect_event(events + 0, 1, IN_ACCESS);                                      \
> > +  expect_event(events + 1, 2, IN_MODIFY);                                      \
> > +                                                                               \
> > +  char buf[sizeof(__func__)];                                                  \
> > +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                            \
> > +  if (memcmp(buf, __func__, sizeof(__func__)))                                 \
> > +    tst_brk(TFAIL, "buf contents bad");
> > +static void splice_file_to_pipe(void) {
> > +  F2P(splice(memfd, NULL, pipes[1], NULL, 128 * 1024 * 1024, 0));
> > +}
> > +static void sendfile_file_to_pipe(void) {
> > +  F2P(sendfile(pipes[1], memfd, NULL, 128 * 1024 * 1024));
> > +}
> > +
> > +static void splice_pipe_to_file(void) {
> > +  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
> > +  watch_rw(pipes[0]);
> > +  watch_rw(memfd);
> > +  TEST(splice(pipes[0], NULL, memfd, NULL, 128 * 1024 * 1024, 0));
> > +  if(TST_RET == -1)
> > +               tst_brk(TBROK | TERRNO, "splice");
> > +       if(TST_RET != sizeof(__func__))
> > +               tst_brk(TBROK, "splice: %" PRId64 "", TST_RET);
> > +
> > +       // expecting: IN_ACCESS pipes[0], IN_MODIFY memfd
> > +       struct inotify_event events[2];
> > +       get_events(ARRAY_SIZE(events), events);
> > +       expect_event(events + 0, 1, IN_ACCESS);
> > +       expect_event(events + 1, 2, IN_MODIFY);
> > +
> > +  char buf[sizeof(__func__)];
> > +  SAFE_LSEEK(memfd, 0, SEEK_SET);
> > +  SAFE_READ(true, memfd, buf, sizeof(__func__));
> > +  if (memcmp(buf, __func__, sizeof(__func__)))
> > +                tst_brk(TFAIL, "buf contents bad");
> > +}
> > +
> > +#define P2P(splice)                                                            \
> > +  SAFE_WRITE(SAFE_WRITE_RETRY, data_pipes[1], __func__, sizeof(__func__));     \
> > +  watch_rw(data_pipes[0]);                                                     \
> > +  watch_rw(pipes[1]);                                                          \
> > +  TEST(splice);                                                                \
> > +  if (TST_RET == -1)                                                           \
> > +                tst_brk(TBROK | TERRNO, #splice);                              \
> > +  if (TST_RET != sizeof(__func__))                                             \
> > +                tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);              \
> > +                                                                               \
> > +  /* expecting: IN_ACCESS data_pipes[0], IN_MODIFY pipes[1] */                 \
> > +  struct inotify_event events[2];                                              \
> > +  get_events(ARRAY_SIZE(events), events);                                      \
> > +  expect_event(events + 0, 1, IN_ACCESS);                                      \
> > +  expect_event(events + 1, 2, IN_MODIFY);                                      \
> > +                                                                               \
> > +  char buf[sizeof(__func__)];                                                  \
> > +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                            \
> > +  if (memcmp(buf, __func__, sizeof(__func__)))                                 \
> > +                tst_brk(TFAIL, "buf contents bad");
> > +static void splice_pipe_to_pipe(void) {
> > +  P2P(splice(data_pipes[0], NULL, pipes[1], NULL, 128 * 1024 * 1024, 0));
> > +}
> > +static void tee_pipe_to_pipe(void) {
> > +  P2P(tee(data_pipes[0], pipes[1], 128 * 1024 * 1024, 0));
> > +}
> > +
> > +static char vmsplice_pipe_to_mem_dt[32 * 1024];
> > +static void vmsplice_pipe_to_mem(void) {
> > +  memcpy(vmsplice_pipe_to_mem_dt, __func__, sizeof(__func__));
> > +  watch_rw(pipes[0]);
> > +  TEST(vmsplice(pipes[1],
> > +                &(struct iovec){.iov_base = vmsplice_pipe_to_mem_dt,
> > +                                .iov_len = sizeof(vmsplice_pipe_to_mem_dt)},
> > +                1, SPLICE_F_GIFT));
> > +  if (TST_RET == -1)
> > +    tst_brk(TBROK | TERRNO, "vmsplice");
> > +  if (TST_RET != sizeof(vmsplice_pipe_to_mem_dt))
> > +    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
> > +
> > +  // expecting: IN_MODIFY pipes[0]
> > +  struct inotify_event event;
> > +  get_events(1, &event);
> > +  expect_event(&event, 1, IN_MODIFY);
> > +
> > +  char buf[sizeof(__func__)];
> > +  SAFE_READ(true, pipes[0], buf, sizeof(__func__));
> > +  if (memcmp(buf, __func__, sizeof(__func__)))
> > +    tst_brk(TFAIL, "buf contents bad");
> > +}
> > +
> > +static void vmsplice_mem_to_pipe(void) {
> > +  char buf[sizeof(__func__)];
> > +  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
> > +  watch_rw(pipes[1]);
> > +  TEST(vmsplice(pipes[0],
> > +                &(struct iovec){.iov_base = buf, .iov_len = sizeof(buf)}, 1,
> > +                0));
> > +  if (TST_RET == -1)
> > +    tst_brk(TBROK | TERRNO, "vmsplice");
> > +  if (TST_RET != sizeof(buf))
> > +    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
> > +
> > +  // expecting: IN_ACCESS pipes[1]
> > +  struct inotify_event event;
> > +  get_events(1, &event);
> > +  expect_event(&event, 1, IN_ACCESS);
> > +  if (memcmp(buf, __func__, sizeof(__func__)))
> > +    tst_brk(TFAIL, "buf contents bad");
> > +}
> > +
> > +typedef void (*tests_f)(void);
> > +#define TEST_F(f) { f, #f }
> > +static const struct {
> > +        tests_f f;
> > +        const char *n;
> > +} tests[] = {
> > +    TEST_F(splice_file_to_pipe),  TEST_F(sendfile_file_to_pipe),
> > +    TEST_F(splice_pipe_to_file),  TEST_F(splice_pipe_to_pipe),
> > +    TEST_F(tee_pipe_to_pipe),     TEST_F(vmsplice_pipe_to_mem),
> > +    TEST_F(vmsplice_mem_to_pipe),
> > +};
> > +
> > +static void run_test(unsigned int n)
> > +{
> > +       tst_res(TINFO, "%s", tests[n].n);
> > +
> > +       SAFE_PIPE2(pipes, O_CLOEXEC);
> > +       SAFE_PIPE2(data_pipes, O_CLOEXEC);
> > +       inotify = SAFE_MYINOTIFY_INIT1(IN_NONBLOCK | IN_CLOEXEC);
> > +       if((memfd = memfd_create(__func__, MFD_CLOEXEC)) == -1)
> > +               tst_brk(TCONF | TERRNO, "memfd");
> > +       tests[n].f();

> Normally, a test cases table would encode things like
> the number of expected events and type of events.
> The idea is that the test template has parametrized code
> and not just a loop for test cases subroutines, but there
> are many ways to write tests, so as long as it gets the job
> done and is readable to humans, I don't mind.

> Right now this test may do the job, but it is not readable
> for this human ;-)
> mostly because of the huge macros -
> LTP is known for pretty large macros, but those are
> for generic utilities and you have complete test cases
> written as macros (templates).

+100. We strive for simple readable code, which is not this one.

Kind regards,
Petr

> > +       tst_res(TPASS, "ок");
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +       if (memfd != -1)
> > +               SAFE_CLOSE(memfd);
> > +       if (inotify != -1)
> > +               SAFE_CLOSE(inotify);
> > +       if (pipes[0] != -1)
> > +               SAFE_CLOSE(pipes[0]);
> > +       if (pipes[1] != -1)
> > +               SAFE_CLOSE(pipes[1]);
> > +       if (data_pipes[0] != -1)
> > +               SAFE_CLOSE(data_pipes[0]);
> > +       if (data_pipes[1] != -1)
> > +               SAFE_CLOSE(data_pipes[1]);
> > +}
> > +

> This cleanup does not happen for every test case -
> it happens only at the end of all the tests IIRC.

> > +static struct tst_test test = {
> > +       .max_runtime = 10,
> > +       .cleanup = cleanup,
> > +       .test = run_test,
> > +       .tcnt = ARRAY_SIZE(tests),
> > +       .tags = (const struct tst_tag[]) {
> > +               {"linux-git", "983652c69199"},

> Leave this out for now.

> Thanks,
> Amir.
