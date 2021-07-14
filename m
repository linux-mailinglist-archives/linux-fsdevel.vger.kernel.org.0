Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED303C8869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGNQOT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:14:19 -0400
Received: from mail-eopbgr40109.outbound.protection.outlook.com ([40.107.4.109]:31543
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232242AbhGNQOQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:14:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qehelg2wL8ECinNjg1eLjQw6rrOEbqZSu2K15KpnDI+ZLN6jnkxKiMy5AUXsj7wD0xbVTdGtnR5PcQa//F7h0z3aKcf5O3fpEcvctp522NR1FDfm8BBYJtV7PfCjUmRhZuFVibrfl5+hgIbC8WII/RZ5Ujxw3L1xOCX+wWZKXnqF7YvcPG9+SjsiI1w56Q54M6soJwf07xpo4fBAE8lYn/rUPXko6gDA3iFQwqoHZ5NX6NFdQ0rsWF1TnVN++7B7p/A/cCvAYhIWC0lRiCHn5JCTDFfosj8uMk7VjB4k1tsvUWsJ/jeJeCu4hW1Iphx8Os9hBucnGEKs1uUWwmvA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0eUD8HsBrNXryAqFudUDldxaz8KUMXPUmXPeRoRdc=;
 b=G0JqUF9BnLxNBLiMfL62a8Pwg9j426M9CY4ROrMe/QVpQcca4VLREgaX8R4NET278R9ptcnJOCTw4jjVZT0fcVJrt97wD61xbnp2Un7IUYX5U0mouMZqHgqkYjk/NSLKx4w2VB1DyDDKCWiFHMV4mxnN2YHn8XWx231fZEJIfVkpFr3xYcgoiVSnXhpDfxoWUvI+i1eZiOGIGOsmE6UlBD/hsnWq4uQtY3cyylfqzhg0iIg1o5f61qlsvu8suB8qaQUymNySrfpRf/Agn3hFnXv2niSXD9mx7ds4B/Jb4u836VQyikkWHuvXqCI9u2dZ906ible9sIDPacQbrxGluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0eUD8HsBrNXryAqFudUDldxaz8KUMXPUmXPeRoRdc=;
 b=qgwlQ6x4lbjl9mbVGUBp3XmSh/Nb1TD5323uUYzPvEB7stQvnPqwb9qWdSN2mkquysDocXDXRjKu3Osq9bf1pt2SkFBqD0uhlJ8I6ZVX6za69dhlD5fzLQQLSWzuJ90EyPqLQDjksbBWFxHa5UZX5OgALXjSG+W08WXtagGl/ZM=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VE1PR08MB4879.eurprd08.prod.outlook.com (2603:10a6:802:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 16:11:21 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 16:11:21 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH v4 2/2] tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest
Date:   Wed, 14 Jul 2021 19:10:56 +0300
Message-Id: <20210714161056.105591-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714161056.105591-1-ptikhomirov@virtuozzo.com>
References: <20210714161056.105591-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (91.207.170.60) by AM8P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 16:11:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f0ffc2f-d631-483f-1a88-08d946e2054a
X-MS-TrafficTypeDiagnostic: VE1PR08MB4879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4879B83441C6E2EAB862A0A4B7139@VE1PR08MB4879.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlRBBu3a8T32VFwpN9A9nfv0kc41QgzTqaM+dbUoHH3+wMY+xL4euuMXMEWWTKO17dU9cYmG8wnt0coAYdFHJeScU6j29lHpmnOH7W+a1n4i38aAxmn0+e1HICU2V7h9Qt+yEZ7KO+NLJXzUM+XvjZEj2zX+w172xBfykf9XGFZxwfau2y2C6V7REryCUn2bVCdIlH6oZhpBMeJsHnWh0xmNAEvvf28tWzQ4kz2nrqjqtzem40TYrtB9azJXQiIhyiVUY6Biy0IrNvYqrIBL7lGyKB1YBRteEeyFytvqUQDeBOiLU5ym8VTexdcbiy+JkDi1FFQfSztabKQ50E+fI2zrcjNu4GiSXjUdjhsjwlPtCDlChQtKgmD+HKxZ+k5PPY+u8xcZfvoMsvA7nljE7/2Hrwz7t4pch1wlvs2rtVsCIgYf/2edJOoH9MrUMW0ntIqPREmqhEvosdrV36sRayXkCrfPySftpXuehTqxAiJ3hbGwJMjdk3FUsUjHtmAF0zQXCxfF0ZHzCxJdiR4j8NZd77lvlh1SztgkxYrFQq+X0c9/YW9wRPrY0xmIKx1cAPw9yCW2hIzj+qoNzSuF2xHS8c0x5HgIEe9uBM4BZT9MOCPwp5AIBsmwBaGpGfX305ERmQ28xe1jajgrkVNGOtDEQtYka43HgK77emKdUgTeGZeFXE2llBiM9bBUxYANhevzKDBZEKb2D3wNhFMmTUla62aIj/9nrfEatmBzHVNQIqMTValnOUnLdVQM10BPe5ei/IdVW54JLvcwI5WYbldPHricCH4Fl5hWaVAJ7UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(366004)(136003)(376002)(396003)(346002)(966005)(30864003)(4326008)(6666004)(5660300002)(2906002)(8936002)(316002)(38100700002)(38350700002)(2616005)(83380400001)(956004)(107886003)(8676002)(6506007)(6486002)(26005)(6512007)(66556008)(86362001)(1076003)(66476007)(478600001)(66946007)(36756003)(186003)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I99Xi2/CBfiwXpJPm0YrL5E2TC1B4kq2j+KwvX7DWK4TQHkP59IUbLHGNsqm?=
 =?us-ascii?Q?q5M0ucTSxIg4hy0PMq4vagCxa7dcW04DA6p1e0UiapwdV8+c+mj5ptZVapQS?=
 =?us-ascii?Q?hYXoz521led+lw9N+pLGBShoS/1pbkvXinQ/PQ7OianVYginwmoPGmJfxlsn?=
 =?us-ascii?Q?gtvJXV/etv/zJo0S/4lNMboC+ssio5Vh4xVfnhGE2Yk1bth2P2ekkdaIuCEO?=
 =?us-ascii?Q?OFvdIBmXlwuIUZS4rGRIstuEB/w17qNKrxxAG34UCjOMru48GWgVh6R0jW5I?=
 =?us-ascii?Q?S4Bv4zwbuNb01buPmaCrploLPUmMYg84bGgJ40t57EdMT1D/+IeYg3huz1tW?=
 =?us-ascii?Q?oMVg2tu09RdcmPMh4+FjYTw5rQdmMgcvNWFVwp6rtrw30OlAhyKcdUxwj46n?=
 =?us-ascii?Q?OOnpLCFT8uQcxFieGRgZQXlX22RFApRyvfaRlKjaw3b23R59HjY5IZfbQimc?=
 =?us-ascii?Q?HfJfPjLv+M1HJPjMMLnsqRwdGbiiAkPy/BibDu7LmdSJKQq0l7xm0Tug1mfS?=
 =?us-ascii?Q?mK+r8HkJf8WURKsqczWNzupjAJPPiBQ9+wpWMv7YZRjFkHZ8sui17ZaHOjt6?=
 =?us-ascii?Q?Lw3rUNw720N5o60vyWKvtTYHvcYD3u1WBBNKTf+W6tCGTPW5p5D4QMqR3PeH?=
 =?us-ascii?Q?qBd7ayT1TKm9gP6UwGIatvDA/ODasncwJ5OjxPvL+0n8jCxNTrezjvOhY2yC?=
 =?us-ascii?Q?MXayMGSvBr9sfJY9hUJ2vzaNDMalGwd0/8h4o3TE2AJqlAIZota3pvQTxLjt?=
 =?us-ascii?Q?bkMzkYHkl1SP8QACmFNZ5lefh4/4qBfMreaWLXAmtbzfpm5llq+le2CMOexa?=
 =?us-ascii?Q?+Mjp3CHG58WtB6ER2tHiKvpo7sVKuXB6Po+sBdKOAIRHT+9p9ES79bJWurlW?=
 =?us-ascii?Q?Z+GUT+/g7UPBb6mQpwOEUCMGM6q1Z0EoH50jFMcCRsIP+N7/srUu/wEsm25/?=
 =?us-ascii?Q?whKovvDm5EqpiR3vhwBiWRD3XazDjqLMhQRo17Chm4syQPw5MsT/qSXGdaAv?=
 =?us-ascii?Q?rnMw9JE+FKMFXkKdsOw44+z20veJVo/+rdBJVeBCHbLByn0aN3teZfe4uwna?=
 =?us-ascii?Q?k9+of4uwk8rQV7OCwSmtY/V0ILi11nJAOaoWhmIdjhmU7Qn2yC8tDKxo8rk+?=
 =?us-ascii?Q?73hGAPe8llxKgKCp6//kTPvpA+FmYWNq74SUPSKmXO38RDimNhOlS/G721uh?=
 =?us-ascii?Q?zigml7vt/b9lua3dI7k0YO420WbutA9t/K8RGUv19uRWMCjF6L/neOWBhghY?=
 =?us-ascii?Q?/E5+kNRumS5B+5IxSPy5uXa32Q8fFfy31WvyNoCJMNm7IN3zlbrXAZ6XZpiV?=
 =?us-ascii?Q?nAy5yv8a5LSfghedto7GyOir?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0ffc2f-d631-483f-1a88-08d946e2054a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 16:11:21.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg/Ds6XkLya2TFeytM/dkvKtl+JkkPUtpb/MaJGa1y62OanlQmdqFuB5UmazgOi6S+LDJizEfGPSQkSaGTF/taK2BdARMnhk99cOYbqI2pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4879
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple selftest for a move_mount(MOVE_MOUNT_SET_GROUP). This tests
that one can copy sharing from one mount from nested mntns with nested
userns owner to another mount from other nested mntns with other nested
userns owner while in their parent userns.

  TAP version 13
  1..1
  # Starting 1 tests from 2 test cases.
  #  RUN           move_mount_set_group.complex_sharing_copying ...
  #            OK  move_mount_set_group.complex_sharing_copying
  ok 1 move_mount_set_group.complex_sharing_copying
  # PASSED: 1 / 1 tests passed.
  # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

---
I took mount_setattr test as an example, I'm not to experienced in
selftests so hope I'm not doing something wrong here.

I implemented a testcase having in mind the way how I plan to use this
interface in criu, so it's not simply copying sharing between two nearby
mounts but it also adds some userns+mntns-es to test cross-namespace
copying.

Note: One can also test MOVE_MOUNT_SET_GROUP via zdtm tests on criu
mount-v2 POC: https://github.com/Snorch/criu/commits/mount-v2-poc

v3: add some test

---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/move_mount_set_group/.gitignore |   1 +
 .../selftests/move_mount_set_group/Makefile   |   7 +
 .../selftests/move_mount_set_group/config     |   1 +
 .../move_mount_set_group_test.c               | 375 ++++++++++++++++++
 5 files changed, 385 insertions(+)
 create mode 100644 tools/testing/selftests/move_mount_set_group/.gitignore
 create mode 100644 tools/testing/selftests/move_mount_set_group/Makefile
 create mode 100644 tools/testing/selftests/move_mount_set_group/config
 create mode 100644 tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index fb010a35d61a..dd0388eab94d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -35,6 +35,7 @@ TARGETS += memory-hotplug
 TARGETS += mincore
 TARGETS += mount
 TARGETS += mount_setattr
+TARGETS += move_mount_set_group
 TARGETS += mqueue
 TARGETS += nci
 TARGETS += net
diff --git a/tools/testing/selftests/move_mount_set_group/.gitignore b/tools/testing/selftests/move_mount_set_group/.gitignore
new file mode 100644
index 000000000000..f5e339268720
--- /dev/null
+++ b/tools/testing/selftests/move_mount_set_group/.gitignore
@@ -0,0 +1 @@
+move_mount_set_group_test
diff --git a/tools/testing/selftests/move_mount_set_group/Makefile b/tools/testing/selftests/move_mount_set_group/Makefile
new file mode 100644
index 000000000000..80c2d86812b0
--- /dev/null
+++ b/tools/testing/selftests/move_mount_set_group/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for mount selftests.
+CFLAGS = -g -I../../../../usr/include/ -Wall -O2
+
+TEST_GEN_FILES += move_mount_set_group_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/move_mount_set_group/config b/tools/testing/selftests/move_mount_set_group/config
new file mode 100644
index 000000000000..416bd53ce982
--- /dev/null
+++ b/tools/testing/selftests/move_mount_set_group/config
@@ -0,0 +1 @@
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
new file mode 100644
index 000000000000..ca0c0c2db991
--- /dev/null
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <sys/syscall.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef CLONE_NEWNS
+#define CLONE_NEWNS 0x00020000
+#endif
+
+#ifndef CLONE_NEWUSER
+#define CLONE_NEWUSER 0x10000000
+#endif
+
+#ifndef MS_SHARED
+#define MS_SHARED (1 << 20)
+#endif
+
+#ifndef MS_PRIVATE
+#define MS_PRIVATE (1<<18)
+#endif
+
+#ifndef MOVE_MOUNT_SET_GROUP
+#define MOVE_MOUNT_SET_GROUP 0x00000100
+#endif
+
+#ifndef MOVE_MOUNT_F_EMPTY_PATH
+#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
+#endif
+
+#ifndef MOVE_MOUNT_T_EMPTY_PATH
+#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040
+#endif
+
+static ssize_t write_nointr(int fd, const void *buf, size_t count)
+{
+	ssize_t ret;
+
+	do {
+		ret = write(fd, buf, count);
+	} while (ret < 0 && errno == EINTR);
+
+	return ret;
+}
+
+static int write_file(const char *path, const void *buf, size_t count)
+{
+	int fd;
+	ssize_t ret;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
+	if (fd < 0)
+		return -1;
+
+	ret = write_nointr(fd, buf, count);
+	close(fd);
+	if (ret < 0 || (size_t)ret != count)
+		return -1;
+
+	return 0;
+}
+
+static int create_and_enter_userns(void)
+{
+	uid_t uid;
+	gid_t gid;
+	char map[100];
+
+	uid = getuid();
+	gid = getgid();
+
+	if (unshare(CLONE_NEWUSER))
+		return -1;
+
+	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
+	    errno != ENOENT)
+		return -1;
+
+	snprintf(map, sizeof(map), "0 %d 1", uid);
+	if (write_file("/proc/self/uid_map", map, strlen(map)))
+		return -1;
+
+
+	snprintf(map, sizeof(map), "0 %d 1", gid);
+	if (write_file("/proc/self/gid_map", map, strlen(map)))
+		return -1;
+
+	if (setgid(0))
+		return -1;
+
+	if (setuid(0))
+		return -1;
+
+	return 0;
+}
+
+static int prepare_unpriv_mountns(void)
+{
+	if (create_and_enter_userns())
+		return -1;
+
+	if (unshare(CLONE_NEWNS))
+		return -1;
+
+	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
+		return -1;
+
+	return 0;
+}
+
+static char *get_field(char *src, int nfields)
+{
+	int i;
+	char *p = src;
+
+	for (i = 0; i < nfields; i++) {
+		while (*p && *p != ' ' && *p != '\t')
+			p++;
+
+		if (!*p)
+			break;
+
+		p++;
+	}
+
+	return p;
+}
+
+static void null_endofword(char *word)
+{
+	while (*word && *word != ' ' && *word != '\t')
+		word++;
+	*word = '\0';
+}
+
+static bool is_shared_mount(const char *path)
+{
+	size_t len = 0;
+	char *line = NULL;
+	FILE *f = NULL;
+
+	f = fopen("/proc/self/mountinfo", "re");
+	if (!f)
+		return false;
+
+	while (getline(&line, &len, f) != -1) {
+		char *opts, *target;
+
+		target = get_field(line, 4);
+		if (!target)
+			continue;
+
+		opts = get_field(target, 2);
+		if (!opts)
+			continue;
+
+		null_endofword(target);
+
+		if (strcmp(target, path) != 0)
+			continue;
+
+		null_endofword(opts);
+		if (strstr(opts, "shared:"))
+			return true;
+	}
+
+	free(line);
+	fclose(f);
+
+	return false;
+}
+
+/* Attempt to de-conflict with the selftests tree. */
+#ifndef SKIP
+#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
+#endif
+
+#define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
+#define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
+
+static int move_mount_set_group_supported(void)
+{
+	int ret;
+
+	if (mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
+		  "size=100000,mode=700"))
+		return -1;
+
+	if (mount(NULL, "/tmp", NULL, MS_PRIVATE, 0))
+		return -1;
+
+	if (mkdir(SET_GROUP_FROM, 0777))
+		return -1;
+
+	if (mkdir(SET_GROUP_TO, 0777))
+		return -1;
+
+	if (mount("testing", SET_GROUP_FROM, "tmpfs", MS_NOATIME | MS_NODEV,
+		  "size=100000,mode=700"))
+		return -1;
+
+	if (mount(SET_GROUP_FROM, SET_GROUP_TO, NULL, MS_BIND, NULL))
+		return -1;
+
+	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
+		return -1;
+
+	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
+		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
+	umount2("/tmp", MNT_DETACH);
+
+	return ret < 0 ? false : true;
+}
+
+FIXTURE(move_mount_set_group) {
+};
+
+#define SET_GROUP_A "/tmp/A"
+
+FIXTURE_SETUP(move_mount_set_group)
+{
+	int ret;
+
+	ASSERT_EQ(prepare_unpriv_mountns(), 0);
+
+	ret = move_mount_set_group_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
+
+	umount2("/tmp", MNT_DETACH);
+
+	ASSERT_EQ(mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+
+	ASSERT_EQ(mkdir(SET_GROUP_A, 0777), 0);
+
+	ASSERT_EQ(mount("testing", SET_GROUP_A, "tmpfs", MS_NOATIME | MS_NODEV,
+			"size=100000,mode=700"), 0);
+}
+
+FIXTURE_TEARDOWN(move_mount_set_group)
+{
+	int ret;
+
+	ret = move_mount_set_group_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
+
+	umount2("/tmp", MNT_DETACH);
+}
+
+#define __STACK_SIZE (8 * 1024 * 1024)
+static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
+{
+	void *stack;
+
+	stack = malloc(__STACK_SIZE);
+	if (!stack)
+		return -ENOMEM;
+
+#ifdef __ia64__
+	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#else
+	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
+#endif
+}
+
+static int wait_for_pid(pid_t pid)
+{
+        int status, ret;
+
+again:
+        ret = waitpid(pid, &status, 0);
+        if (ret == -1) {
+                if (errno == EINTR)
+                        goto again;
+
+                return -1;
+        }
+
+        if (!WIFEXITED(status))
+                return -1;
+
+        return WEXITSTATUS(status);
+}
+
+struct child_args {
+	int unsfd;
+	int mntnsfd;
+	bool shared;
+	int mntfd;
+};
+
+static int get_nestedns_mount_cb(void *data)
+{
+	struct child_args *ca = (struct child_args *)data;
+	int ret;
+
+	ret = prepare_unpriv_mountns();
+	if (ret)
+		return 1;
+
+	if (ca->shared) {
+		ret = mount(NULL, SET_GROUP_A, NULL, MS_SHARED, 0);
+		if (ret)
+			return 1;
+	}
+
+	ret = open("/proc/self/ns/user", O_RDONLY);
+	if (ret < 0)
+		return 1;
+	ca->unsfd = ret;
+
+	ret = open("/proc/self/ns/mnt", O_RDONLY);
+	if (ret < 0)
+		return 1;
+	ca->mntnsfd = ret;
+
+	ret = open(SET_GROUP_A, O_RDONLY);
+	if (ret < 0)
+		return 1;
+	ca->mntfd = ret;
+
+	return 0;
+}
+
+TEST_F(move_mount_set_group, complex_sharing_copying)
+{
+	struct child_args ca_from = {
+		.shared = true,
+	};
+	struct child_args ca_to = {
+		.shared = false,
+	};
+	pid_t pid;
+	int ret;
+
+	ret = move_mount_set_group_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
+
+	pid = do_clone(get_nestedns_mount_cb, (void *)&ca_from, CLONE_VFORK |
+		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	pid = do_clone(get_nestedns_mount_cb, (void *)&ca_to, CLONE_VFORK |
+		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
+	ASSERT_EQ(wait_for_pid(pid), 0);
+
+	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
+			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
+			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
+		  0);
+
+	ASSERT_EQ(setns(ca_to.mntnsfd, CLONE_NEWNS), 0);
+	ASSERT_EQ(is_shared_mount(SET_GROUP_A), 1);
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.1

