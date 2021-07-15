Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96B3C9C68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241190AbhGOKKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 06:10:45 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:48611
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232585AbhGOKKl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqMwPia+9RLSYqZ8f+ntYOzm7AD7d5izsWOq61KYx0i7jztMSU0ToWsCdMgVcdyAgTbZkQ8Ou6pfDIRoDh7YAhuBfgX2IXRbFsw4mXD09oyj1mECpHDm6+AGb+beYuikWCERL8OcNOk+xo0HHHO3Ac9FXaPYX2WfgcgFHWKv0Dl072rBR+Oh4r8DqQ8Rux2+iOIy4ViG/lPtdIM9bf5857QfBhBV1iiNJRiH13ZSB83FWUTCpmWYb3YBbA2w7UKMfnSGTS6CxNe0tmBHhsFn1TRihGilM+cwoRKRFipJDRp6OsKiKV5D8j29DasZyArmLgMrdA8ZCYdVcHq6PzOCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw1rZ1+mOGZ5ITIQWt/Gk7SotaDrPFh8wNQph4GGjAY=;
 b=FauR1JO1tJwmyCYbG1LY3H65xHH25oPXl+9pyKzwUkMYR30RYVttGI6pJtoKxxj1y/lVx8evXuXz2TQ5mMerZKA/3UfyLlNGkuoAxPpBKIHdUzw2QjYB0fQQ9isn7XuVg4LMqF9GeBNW2q2hqFxCIIIa+95VrcJbgbz0dVb1BbmtWFOWtc9uwMS3grKDUqqckgoQ52khDjaegcsuv8nGw/tW5OUmr+Ps/O5Anfp5YPYOS4q8ciIk6vGbknP7bUjh8Kz7a+zwclAhFHAs12ohHaUQBqRW7nE9pCnuhUGfQs/S/vKo4v+INscJac8Hkce9NkQX0PFZqLkedFp7DPdpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw1rZ1+mOGZ5ITIQWt/Gk7SotaDrPFh8wNQph4GGjAY=;
 b=Y9yokrLUVb1B1OH0msihXNhvHY5qnVdOUA37hYFLat2CwRplXdm6CfAj+ow8A3jAV0AC3jK1GafTrbwNu797ffGLvV1EyepR3GQQT8xp6hStdSmke2oVZWwIgq2+9aICOaxWlFBKqxf2FCdTlEHZIiFVgZm2d0ZvokH7T3juoPY=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2975.eurprd08.prod.outlook.com (2603:10a6:803:44::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 10:07:44 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 10:07:44 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/2] tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest
Date:   Thu, 15 Jul 2021 13:07:14 +0300
Message-Id: <20210715100714.120228-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
References: <20210715100714.120228-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::27) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (46.39.230.13) by PR2P264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 10:07:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02abb28-6424-4b48-8692-08d94778635f
X-MS-TrafficTypeDiagnostic: VI1PR08MB2975:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB29752C5815FE087202BDBD8FB7129@VI1PR08MB2975.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ncmHBFkDMasj6mAKAei28yR0RAbZocRyNFKt35bAmuKN0E34IJgOZS8JOzxbwOlx3eb2juXrdr1I6rasGdTi695wWCsCcjmWsISY7i4apLy/rPjg8qvaL/BTQfKxi2RrEm0/o3BcySmmSTINaqY7RTDoIEw10hCd6Rjb3BnmDjU02jadGZKzJsEqP2PLINuLVZLzgCa042uZmHi1rX0zTkNn81iUokrZbVlTJHmPasulsJBPuzrL8r5vC3UItaf1xhCzvptpC/bgGp5QjHyXwXyoE90ShZ2av+EZL0fVKyvF97CblCop72A59N9ljsN8BtfnE0OCEVY4ZbD18jlLKYrQAXFuePY3HpO2fmazVVPT8lB9lds5Qb0+ARNf+LVnLJ8GcG83kSNig6uuOZVX7eOdNZn4eD7jLmxJo4Trg+34nwq6l4QQx8Q2MDlF4NFlAiu5KfBKaq9yCiQTFWoNvVrnIjrY8GZIrbrXmtbxvqLDSivuntd2hazKIywN0CN8MnioxtzNOjJOSLqvZ5OifZRc+dBkiI9BRs6krtTbJ/vAYxHHvDJ+kEQIXlGuDtQRT8/7L342Td1F6rAGVR1tO2ImPPbiPF1jxZRDmdH410lBRqoIqQj6MH0a1YRdDItwUkXoIIlsT5XyU0OfcMFxIj4s7gbXJLYUE90agqvlwB1zDo0wq96xJQIdogo3Nnt9O10Xv53pqQyHdzDQweSdBcQ5kTV/O+WKmYANEtWPxkaVJuWJSlsYvb5NJlqCEIpWJBEFuqdIqppl7sfEg8hlLmbUSF1PQ7O1DNVk6SYaSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6506007)(30864003)(4326008)(6486002)(6512007)(86362001)(2906002)(54906003)(36756003)(52116002)(956004)(7416002)(2616005)(26005)(5660300002)(66946007)(83380400001)(66476007)(1076003)(8936002)(38350700002)(38100700002)(6666004)(66556008)(8676002)(316002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/moxW/bKjVFXTzNWT03ETwJuYjCVKFlut11JGKEGwO4EausF3xqe5VK3RtUr?=
 =?us-ascii?Q?4Ps3/X6eiPZ/S3w/qrsDolk8m7RZ3/UyTaMUsEpI7uwsmRWtC3KE/o1NfTXh?=
 =?us-ascii?Q?BdccTSCKFcaNDt3Ca/QuLG6mUzVyCKnyFZI40CzVd8GO26DqZAS/R1VbljJM?=
 =?us-ascii?Q?6CLpts0kr5iBfF6QnJLzzewEhX/+NNPLTG63prcoKBTLAjQq4VnD89Fswfgr?=
 =?us-ascii?Q?z0NZZjF4JdvZcTORp+vZCpIOlgt2qXNzn3WD6+ynkASb9ixfHoQOKkToMkQU?=
 =?us-ascii?Q?xZCPNvVJDucbgOclFXQ4+vq46fM6xe16rkk2H7oJOaD08zRzjY5pPD6xLXdA?=
 =?us-ascii?Q?kTicuJb2Bn4ui4MgOqdBXZewbUtAl7UgWM0ssmxT71Hn+yUaYqWSmd693jRl?=
 =?us-ascii?Q?BOdgBSBvQ96fKUHCY2A04AhsTpc5Q3XsREMvuPeXOHbkjXJ2aqPkFuM7eO1a?=
 =?us-ascii?Q?eaICCaI4CixWWTGep9LvLrseddK2DC7CMvAGWC6WKrB8PAfBYdZHzlyngPUa?=
 =?us-ascii?Q?Xvp2kZbaZVUb7VRnx9M7ZUv3T2sshboJDY+qDnci4KZd3AFRszhBWb6yDg1Y?=
 =?us-ascii?Q?q2fXLhM1ReYVjdIQFaBsPBdeyW/zMcVPAIixHyPFbZyv4GbdSxImQPjrq8nt?=
 =?us-ascii?Q?A5Wwn9Md4RWXYwFsqC0syJeMjcZWSQzEWdlbZK+io1fdZdmUmCkPiFoaagoq?=
 =?us-ascii?Q?Z3SqY1TQUPNLud3osFZwo+lxyENBL4PFjOxkVnkHZFSxU5WfYQNFHY+0YTmY?=
 =?us-ascii?Q?DWhTMSGqL1llnA/GlsKB+HpNrgFJgxGkDBvf8mRWBZrCnn5xYE9mtG4NmcUY?=
 =?us-ascii?Q?vjeD7zis7qME3FoE+/f32uEWMkkfnFWZlpSxYrVw+bNG5On9CX64uZEwx2YO?=
 =?us-ascii?Q?MNbGwiOPtCCj+QB28IViZSaaNKQrGMByPyYyDHJjbv7joBta6i5q45FGCXIv?=
 =?us-ascii?Q?Z3NyZg/S+rtPkFARLAKSdbgGkZ6o4VfSEHUMdD5Kmh5rXjzun0ERAWyxCnW8?=
 =?us-ascii?Q?gqv5OanAZ65iiDgwsMY41kChINidPU46HXCq6AUBer9D79YHxhJIYy79bbH3?=
 =?us-ascii?Q?dLn38tflBTojqAOSNTDNXhflztZwBVMVgx4UQAL70gwfXXkzsGEFIt8qhrzP?=
 =?us-ascii?Q?cbO71aHU5fG3gWvlCmCg4Ak/HLDmNmrchJkOBUIuAfJ3aq9IkEYwqKfgqY7H?=
 =?us-ascii?Q?yrWcMX3DMl8TQHhclO/Nna3zEhfh8N8epOZ1U/0+LIgFrxVzztzgbp6YfVTi?=
 =?us-ascii?Q?iHAogkv/37hvWlRVC9oSp18YiK3bMDwu3uPL5u/Hd2Vy5A5XyHbwVlWnDTUV?=
 =?us-ascii?Q?p4y2RMT92u9zUfDa/x2q61ur?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02abb28-6424-4b48-8692-08d94778635f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 10:07:43.9997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8aBlVqALee00KayREQ9kZ/ZrXt9ie2XZkkSc9Tahmk1qz7/9uOvsNHDHmKUfvemYlNGrVM8I6DvDhWHNaarDx7Ad2hZP0ln4hHF7i5IkjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2975
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

Cc: Shuah Khan <shuah@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Mattias Nissler <mnissler@chromium.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

---
Note: One can also test it via criu mount-v2 POC:
https://github.com/Snorch/criu/commits/mount-v2-poc

v3: add some test
v5: fix test codding style + fix cc

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
index 000000000000..860198f83a53
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
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
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

