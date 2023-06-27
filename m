Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41B7401C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 18:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjF0Q5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Q5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:57:23 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55B2B10CF;
        Tue, 27 Jun 2023 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1687885040;
        bh=Az1W0LBoRrz7YW1u9PmFCtcve2J0qXsV3SeB7GMF0ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bto/E5jTK1/420ZGrPZSSsY7qNHL2Z4JofFpTcdv8BdbJ+gJiiCCEUR5qmewifHGR
         EXfbSHI4Sim9KaLIvMpOjl4sYnvq60jlPUBMwHFJMVipYt+9Jl8UddMJP/76rptfsG
         yKNsWalfXH9ybZdnEUjHKUaCB/kYmzuxCT8GrMbOJbrX8O32o6UeA0qNjeh7ERVIE3
         KHP6YQTUxQ4dQ2orb8/ui+zqpwhuRqNxCku+ubFMzgUy1krQC7mcuOhClDz5olyt1f
         6qdKCJc8RA+NHF0zdsqWDJ/lBJYlZtnfhs7o+mplYOXuo7nUCtlL4zhD+ZZbpHllfN
         2/G4JOL0ApGnA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9AE391A92;
        Tue, 27 Jun 2023 18:57:20 +0200 (CEST)
Date:   Tue, 27 Jun 2023 18:57:19 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@vger.kernel.org
Subject: [LTP PATCH] inotify13: new test for fs/splice.c functions vs pipes
 vs inotify
Message-ID: <44neh3sog5jaskc4zy6lwnld7hussp5sslx4fun47fr45mxe3a@q2jgkjwlq74f>
References: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4v3npduv4blgoq7d"
Content-Disposition: inline
In-Reply-To: <cover.1687884029.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4v3npduv4blgoq7d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The only one that passes on 6.1.27-1 is sendfile_file_to_pipe.

Link: https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs=
3dodpofafnkkunxq7bu@jngkdxx65pux/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Formatted to clang-format defaults. Put the original Fixes:ed SHA in the
metadata, that's probably fine, right?

 testcases/kernel/syscalls/inotify/.gitignore  |   1 +
 testcases/kernel/syscalls/inotify/inotify13.c | 246 ++++++++++++++++++
 2 files changed, 247 insertions(+)
 create mode 100644 testcases/kernel/syscalls/inotify/inotify13.c

diff --git a/testcases/kernel/syscalls/inotify/.gitignore b/testcases/kerne=
l/syscalls/inotify/.gitignore
index f6e5c546a..b597ea63f 100644
--- a/testcases/kernel/syscalls/inotify/.gitignore
+++ b/testcases/kernel/syscalls/inotify/.gitignore
@@ -10,3 +10,4 @@
 /inotify10
 /inotify11
 /inotify12
+/inotify13
diff --git a/testcases/kernel/syscalls/inotify/inotify13.c b/testcases/kern=
el/syscalls/inotify/inotify13.c
new file mode 100644
index 000000000..c34f1dc9f
--- /dev/null
+++ b/testcases/kernel/syscalls/inotify/inotify13.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*\
+ * Verify splice-family functions (and sendfile) generate IN_ACCESS
+ * for what they read and IN_MODIFY for what they write.
+ *
+ * Regression test for 983652c69199 and
+ * https://lore.kernel.org/linux-fsdevel/jbyihkyk5dtaohdwjyivambb2gffyjs3d=
odpofafnkkunxq7bu@jngkdxx65pux/t/#u
+ */
+
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/sendfile.h>
+
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "inotify.h"
+
+#if defined(HAVE_SYS_INOTIFY_H)
+#include <sys/inotify.h>
+
+
+static int pipes[2] =3D {-1, -1};
+static int inotify =3D -1;
+static int memfd =3D -1;
+static int data_pipes[2] =3D {-1, -1};
+
+static void watch_rw(int fd) {
+  char buf[64];
+  sprintf(buf, "/proc/self/fd/%d", fd);
+  SAFE_MYINOTIFY_ADD_WATCH(inotify, buf, IN_ACCESS | IN_MODIFY);
+}
+
+static int compar(const void *l, const void *r) {
+  const struct inotify_event *lie =3D l;
+  const struct inotify_event *rie =3D r;
+  return lie->wd - rie->wd;
+}
+
+static void get_events(size_t evcnt, struct inotify_event evs[static evcnt=
]) {
+  struct inotify_event tail, *itr =3D evs;
+  for (size_t left =3D evcnt; left; --left)
+    SAFE_READ(true, inotify, itr++, sizeof(struct inotify_event));
+
+  TEST(read(inotify, &tail, sizeof(struct inotify_event)));
+  if (TST_RET !=3D -1)
+    tst_brk(TFAIL, "expect %zu events", evcnt);
+  if (TST_ERR !=3D EAGAIN)
+    tst_brk(TFAIL | TTERRNO, "expected EAGAIN");
+
+  qsort(evs, evcnt, sizeof(struct inotify_event), compar);
+}
+
+static void expect_event(struct inotify_event *ev, int wd, uint32_t mask) {
+  if (ev->wd !=3D wd)
+    tst_brk(TFAIL, "expect event for wd %d got %d", wd, ev->wd);
+  if (ev->mask !=3D mask)
+    tst_brk(TFAIL, "expect event with mask %" PRIu32 " got %" PRIu32 "", m=
ask,
+            ev->mask);
+}
+
+#define F2P(splice)                                                       =
     \
+  SAFE_WRITE(SAFE_WRITE_RETRY, memfd, __func__, sizeof(__func__));        =
     \
+  SAFE_LSEEK(memfd, 0, SEEK_SET);                                         =
     \
+  watch_rw(memfd);                                                        =
     \
+  watch_rw(pipes[0]);                                                     =
     \
+  TEST(splice);                                                           =
     \
+  if (TST_RET =3D=3D -1)                                                  =
         \
+    tst_brk(TBROK | TERRNO, #splice);                                     =
     \
+  if (TST_RET !=3D sizeof(__func__))                                      =
       \
+    tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);                     =
     \
+                                                                          =
     \
+  /*expecting: IN_ACCESS memfd, IN_MODIFY pipes[0]*/                      =
     \
+  struct inotify_event events[2];                                         =
     \
+  get_events(ARRAY_SIZE(events), events);                                 =
     \
+  expect_event(events + 0, 1, IN_ACCESS);                                 =
     \
+  expect_event(events + 1, 2, IN_MODIFY);                                 =
     \
+                                                                          =
     \
+  char buf[sizeof(__func__)];                                             =
     \
+  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                       =
     \
+  if (memcmp(buf, __func__, sizeof(__func__)))                            =
     \
+    tst_brk(TFAIL, "buf contents bad");
+static void splice_file_to_pipe(void) {
+  F2P(splice(memfd, NULL, pipes[1], NULL, 128 * 1024 * 1024, 0));
+}
+static void sendfile_file_to_pipe(void) {
+  F2P(sendfile(pipes[1], memfd, NULL, 128 * 1024 * 1024));
+}
+
+static void splice_pipe_to_file(void) {
+  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
+  watch_rw(pipes[0]);
+  watch_rw(memfd);
+  TEST(splice(pipes[0], NULL, memfd, NULL, 128 * 1024 * 1024, 0));
+  if(TST_RET =3D=3D -1)
+		tst_brk(TBROK | TERRNO, "splice");
+	if(TST_RET !=3D sizeof(__func__))
+		tst_brk(TBROK, "splice: %" PRId64 "", TST_RET);
+
+	// expecting: IN_ACCESS pipes[0], IN_MODIFY memfd
+	struct inotify_event events[2];
+	get_events(ARRAY_SIZE(events), events);
+	expect_event(events + 0, 1, IN_ACCESS);
+	expect_event(events + 1, 2, IN_MODIFY);
+
+  char buf[sizeof(__func__)];
+  SAFE_LSEEK(memfd, 0, SEEK_SET);
+  SAFE_READ(true, memfd, buf, sizeof(__func__));
+  if (memcmp(buf, __func__, sizeof(__func__)))
+                tst_brk(TFAIL, "buf contents bad");
+}
+
+#define P2P(splice)                                                       =
     \
+  SAFE_WRITE(SAFE_WRITE_RETRY, data_pipes[1], __func__, sizeof(__func__));=
     \
+  watch_rw(data_pipes[0]);                                                =
     \
+  watch_rw(pipes[1]);                                                     =
     \
+  TEST(splice);                                                           =
     \
+  if (TST_RET =3D=3D -1)                                                  =
         \
+                tst_brk(TBROK | TERRNO, #splice);                         =
     \
+  if (TST_RET !=3D sizeof(__func__))                                      =
       \
+                tst_brk(TBROK, #splice ": %" PRId64 "", TST_RET);         =
     \
+                                                                          =
     \
+  /* expecting: IN_ACCESS data_pipes[0], IN_MODIFY pipes[1] */            =
     \
+  struct inotify_event events[2];                                         =
     \
+  get_events(ARRAY_SIZE(events), events);                                 =
     \
+  expect_event(events + 0, 1, IN_ACCESS);                                 =
     \
+  expect_event(events + 1, 2, IN_MODIFY);                                 =
     \
+                                                                          =
     \
+  char buf[sizeof(__func__)];                                             =
     \
+  SAFE_READ(true, pipes[0], buf, sizeof(__func__));                       =
     \
+  if (memcmp(buf, __func__, sizeof(__func__)))                            =
     \
+                tst_brk(TFAIL, "buf contents bad");
+static void splice_pipe_to_pipe(void) {
+  P2P(splice(data_pipes[0], NULL, pipes[1], NULL, 128 * 1024 * 1024, 0));
+}
+static void tee_pipe_to_pipe(void) {
+  P2P(tee(data_pipes[0], pipes[1], 128 * 1024 * 1024, 0));
+}
+
+static char vmsplice_pipe_to_mem_dt[32 * 1024];
+static void vmsplice_pipe_to_mem(void) {
+  memcpy(vmsplice_pipe_to_mem_dt, __func__, sizeof(__func__));
+  watch_rw(pipes[0]);
+  TEST(vmsplice(pipes[1],
+                &(struct iovec){.iov_base =3D vmsplice_pipe_to_mem_dt,
+                                .iov_len =3D sizeof(vmsplice_pipe_to_mem_d=
t)},
+                1, SPLICE_F_GIFT));
+  if (TST_RET =3D=3D -1)
+    tst_brk(TBROK | TERRNO, "vmsplice");
+  if (TST_RET !=3D sizeof(vmsplice_pipe_to_mem_dt))
+    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
+
+  // expecting: IN_MODIFY pipes[0]
+  struct inotify_event event;
+  get_events(1, &event);
+  expect_event(&event, 1, IN_MODIFY);
+
+  char buf[sizeof(__func__)];
+  SAFE_READ(true, pipes[0], buf, sizeof(__func__));
+  if (memcmp(buf, __func__, sizeof(__func__)))
+    tst_brk(TFAIL, "buf contents bad");
+}
+
+static void vmsplice_mem_to_pipe(void) {
+  char buf[sizeof(__func__)];
+  SAFE_WRITE(SAFE_WRITE_RETRY, pipes[1], __func__, sizeof(__func__));
+  watch_rw(pipes[1]);
+  TEST(vmsplice(pipes[0],
+                &(struct iovec){.iov_base =3D buf, .iov_len =3D sizeof(buf=
)}, 1,
+                0));
+  if (TST_RET =3D=3D -1)
+    tst_brk(TBROK | TERRNO, "vmsplice");
+  if (TST_RET !=3D sizeof(buf))
+    tst_brk(TBROK, "vmsplice: %" PRId64 "", TST_RET);
+
+  // expecting: IN_ACCESS pipes[1]
+  struct inotify_event event;
+  get_events(1, &event);
+  expect_event(&event, 1, IN_ACCESS);
+  if (memcmp(buf, __func__, sizeof(__func__)))
+    tst_brk(TFAIL, "buf contents bad");
+}
+
+typedef void (*tests_f)(void);
+#define TEST_F(f) { f, #f }
+static const struct {
+        tests_f f;
+        const char *n;
+} tests[] =3D {
+    TEST_F(splice_file_to_pipe),  TEST_F(sendfile_file_to_pipe),
+    TEST_F(splice_pipe_to_file),  TEST_F(splice_pipe_to_pipe),
+    TEST_F(tee_pipe_to_pipe),     TEST_F(vmsplice_pipe_to_mem),
+    TEST_F(vmsplice_mem_to_pipe),
+};
+
+static void run_test(unsigned int n)
+{
+	tst_res(TINFO, "%s", tests[n].n);
+
+	SAFE_PIPE2(pipes, O_CLOEXEC);
+	SAFE_PIPE2(data_pipes, O_CLOEXEC);
+	inotify =3D SAFE_MYINOTIFY_INIT1(IN_NONBLOCK | IN_CLOEXEC);
+	if((memfd =3D memfd_create(__func__, MFD_CLOEXEC)) =3D=3D -1)
+		tst_brk(TCONF | TERRNO, "memfd");
+	tests[n].f();
+	tst_res(TPASS, "=D0=BE=D0=BA");
+}
+
+static void cleanup(void)
+{
+	if (memfd !=3D -1)
+		SAFE_CLOSE(memfd);
+	if (inotify !=3D -1)
+		SAFE_CLOSE(inotify);
+	if (pipes[0] !=3D -1)
+		SAFE_CLOSE(pipes[0]);
+	if (pipes[1] !=3D -1)
+		SAFE_CLOSE(pipes[1]);
+	if (data_pipes[0] !=3D -1)
+		SAFE_CLOSE(data_pipes[0]);
+	if (data_pipes[1] !=3D -1)
+		SAFE_CLOSE(data_pipes[1]);
+}
+
+static struct tst_test test =3D {
+	.max_runtime =3D 10,
+	.cleanup =3D cleanup,
+	.test =3D run_test,
+	.tcnt =3D ARRAY_SIZE(tests),
+	.tags =3D (const struct tst_tag[]) {
+		{"linux-git", "983652c69199"},
+		{}
+	},
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required inotify support");
+#endif
--=20
2.39.2

--4v3npduv4blgoq7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSbFO8ACgkQvP0LAY0m
WPELXQ/7BGRYTRNstpUy6RLExHSe9+7+yMo0QQECDoSiHTULBobosVJFZiNoQJEN
EByPIojnmd6m5NAFWKPVblLe1fnSmSbnT5IR0XRO8wMHxgl9VLc2wPa7NA9500tv
9wXOHs7X5hpw0lw/FAXHcDWrc4Etqjn4hMfdgaewY+JhwIDyBTlG98+fcg5p+GBs
MRYPqq3w5TAmJ5+mQKU+vEWQkLVXkEoeK23Kd6kIVVjigYktssCFUvH5Y5wp5M52
f/5B00KobjpBbi4PvWPVJFWBnZNj1YVPd2h0Z7EAsxE/ExOUyUjDBSjwf3YzAzTf
Y4WbzOY/z+/I9TL6aBN6coJS/P5Y4mKKmSrIoU4g7XmBOTLAth/kJ6QMDrnWZp1Q
WzUu7iC9beSVby3xsr4SUbTd6rWgNSMVEgYRrE+MzQu14GzT6VW5LFSQX+JsrjpX
92pCkNpQyo9mLm/9UwJRiCIdPmCSfyBihDSbW8gWVQ8z6rdpKJNGuc1RF/pwnpN4
iuW6EgL2wOiKmVh6HaZebGM2sV5XuLr+aGrlUp3fJWIkkFL8b/U7yY9m5Fab62E7
GTuytPMyPPWT3YkKZLnacUbE4Pf+bFVtj3XpAdoA+b+v+Q2lcm46bIMllLEgNojJ
CgCnqzjbAQ629zLBHYyOTywM32+HZEAgvnFfhRdzkmNIurY0Po8=
=uPgK
-----END PGP SIGNATURE-----

--4v3npduv4blgoq7d--
