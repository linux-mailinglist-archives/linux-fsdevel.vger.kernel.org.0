Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD64B546A74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349651AbiFJQde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345590AbiFJQdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:33:04 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10118.outbound.protection.outlook.com [40.107.1.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED556B16;
        Fri, 10 Jun 2022 09:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAJsXO+o8D1b/XHZa9PlDCbjYSTutXFJq07my7gAIRCbO0hUQbzab8sRiwctHaY7qgz1oHzAbqBpBFog2D49YVVa7ZBVQ43eGznw7IXV8sm/SJTKVSNaQnouavpXz0/O9TUV1E4NaN/iZp97zfjIdTpGV2K6r77/bZLgyongBFClSdiydQN91VEDhT/P7vx1Xw5oB9EwmD2e/HpKR7DZXit4XK/IW4TO5N+zPK9q+lHHYJoKujr8gt5QT1iuM64pcQqBB4r1Wxc6tEfK3wtqZYpTD7X82ZlImMkODvX1HRapuRwg0yQNVnEUSZPVq9Ro98u1o3ok+GSjYUeEXKV5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNcU9YcoACivCKsoBiPMNrFJgztW1BDIKsFHJh4yFiQ=;
 b=VBUiDgoIePIf09HWqGJDcyc5YeVJLLBOkhgt7NJTVbzuVLecf0pEHJqBkcuuF5Upxu6txQv9tMf9G+8ZbxdJ5Zi7PD7Wq6kOODJQRoMnAObXvkwJpqiqmbSPCTAAzp+M8qNalGgzPwcAXA0o0aYS7cgND/mPrUXNcbtGAYJwY0csPJMG7xAh9nqKzWcKJR2eDrSgekM0x279QBPmla1ROVSraZGg/v1Qj/CLqQyaQVQFUgmvMbMge078TlEXjrkQZbT1Yiirn3dsEPXLCZ9pg53FSic6ExOJ8Qdoi0tFhZBYgwyvXvN7LqA8rcUmJJdAWdm+ngGjc522vGFAxnH6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNcU9YcoACivCKsoBiPMNrFJgztW1BDIKsFHJh4yFiQ=;
 b=MRvEB4Wdt2pZacWv8xYh7rcLQCIQsjFcafW1fez72jofJhijEUCeGRkBbnsZYUy/HUv2kTsZ+7Mz/2wTOhA4jllMoVhi0Fmf0J593IYshNpEg9pBbq+ejGyqTUwAziSZpOCiZYYU1/vM3kl3fl4dfKBH1YIxcFVUngGGi6qeeg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AM9PR08MB6180.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 16:32:57 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 16:32:56 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ia64@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] tests: Add CABA selftest
Date:   Fri, 10 Jun 2022 19:32:14 +0300
Message-Id: <20220610163214.49974-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
References: <20220610163214.49974-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::24) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3733d56d-fe34-4173-29e2-08da4afee007
X-MS-TrafficTypeDiagnostic: AM9PR08MB6180:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6180106D43D3FF9020039F69B7A69@AM9PR08MB6180.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNvDEPIEuE85cyq/m0Ss5iuVw0ITmINO5QYl/ZCeS21nPikEV6hFfdRbL6DctabRmbKEm14Qrjoj0LHT2vYGhR4Yvu227RQMo3bBySJjfHNA8vtTiwcu+A1OnCF3BHg5+p3TXbZ/9LovjNx5S4dbVioWNYzZ75R7d2pzvh4EilvNhSQiSj/FnbhbF36xX1hti/ygQyYlsBc6oz6244+x0nXWLESEvPMNO6h5yeHFge9uiZnUZajUPM6MbUrOhr1rjW33yV2HchZ/e8shqUYTaM9vtIJT5yNk19DzARw5NWdpJqpUxoMB5zd50bTq40/0Bp5UumRHNTlxCr8cBv2vwQnJ6bEw3D9reo32ISpyvFG5PDnOOjifaf1Y91cXHR37ItRGDw1Lo8OtkyYenlEgFe97PqZVzyPdzvc0KcwYmdV5kr2b7GPy0K1MwWX5owPcZjwAwMGH0XX4INCk+1KuAq7S4yOUAmBU8tqmUIKg9TMaDJc0tWJeO/FHpKpqO5QAnGT3GRwAv949e9uEDheigkpQDXA1iunNLjy1HZzGdFMcCN+cq7FgNwEbEplYgSTvWRiP0+qfdSXrdrfKfl4gQ8/WV/XNM/uIPXfDgxhIAYhYxiR6FLy2R1vG7SE+DZEg/3oXMx987vJ80gHUfEslkyVKtenpatcJfnYox0lG3eJnSZZ9iVcIOai2zcwGOHAxL6Rt4nNgP0IHNump8MQR3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(54906003)(38350700002)(38100700002)(8936002)(4326008)(2906002)(5660300002)(66946007)(7416002)(66556008)(66476007)(8676002)(83380400001)(52116002)(6666004)(30864003)(1076003)(6506007)(186003)(6512007)(26005)(6486002)(508600001)(36756003)(2616005)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pM+BX1yWtBKzXETZAiduHJ6ja4Ha8Ij2L/BQINJegD8KB42O9+WNnZi9nei?=
 =?us-ascii?Q?4CTN3aHn3N8+k5N1vL5FM30Yvh/7k+WkA9Igxd5UiG8aMgQxBDeTe8Dfdrw/?=
 =?us-ascii?Q?LMb2cBkhsm8P9gF01gLmgc08jDIOKRNWfFTSaixdME91KOuqhXb3l4dm4xiB?=
 =?us-ascii?Q?zNLnV2xKhwwrFR8FvfCzTGN1LsiwVJWk6haB1eXg8qM2TxaSNTA7bhc0YnGY?=
 =?us-ascii?Q?Zdj7XrOJLJJQQggWyfm2F0Mxc2SS5917OYPU3W9KqWmL0NDDIm1R4WtZOoax?=
 =?us-ascii?Q?todP46NRCvH7RO6QJPdRWG/jLZFXoNw9eY47nKOacdBe4U9COMyyu533zHsF?=
 =?us-ascii?Q?j/EB5CD0YLeQNqeixJPmJwP1WEEQYceVoFvKBxM7Ty4IIWAqL0QC7wdArsb2?=
 =?us-ascii?Q?L5ypMhFtFTILIsLegw8La+5UhgbTC5oAKf95X4sQyh/bIlqmwVKUuD8An81I?=
 =?us-ascii?Q?jfwxXbjdO8P6itMc7dNjkoXnPCtQzwe+985luyx43QHDNy0ohWL4LePdFv3c?=
 =?us-ascii?Q?Msz+b0LZwjk0NrxR8mz26iH23Sm9k9NnfL6Pp4cWyuTk9FqyhUXkQcdbUI6T?=
 =?us-ascii?Q?tZmqPKgVc2LVVrlzsJJYwfGpJ+sw8maoWnEDzhATdHOsqAWaU8BLmc+aMz+O?=
 =?us-ascii?Q?NDw/59U6KgBXOOy6GVoppBNhHUauC2wvwNKIvPE62ktArwRt4/t4Y8FDMdgg?=
 =?us-ascii?Q?Ee96zyvoanqE0jvJFmYM5z/b9NpxVDIVlPXDxEZMyEtMAPZjpFI+ZK8I2bz6?=
 =?us-ascii?Q?QdZlgwPRcoSb6PyEG+7zTDiwakrtjn1MI+CZfodH0P4NeIBzt9+PjswFD2AE?=
 =?us-ascii?Q?yY0suixNVDKFPWN49U3Vp1tnwfqM3PlfcHGeOWGTww8f4s1cNc6n9YLt9CRr?=
 =?us-ascii?Q?l3iNO/UlSAzYDbcTQcQ73wmS3Rqz8ZC3bXbqTHqqTRyug1M1JckFPcjhknaV?=
 =?us-ascii?Q?5k6i8HbMMD5LItjSr63BOHsqIspOH6OKYfEii9mtrRs8u8KoKkRcpYs2flHC?=
 =?us-ascii?Q?UW8Tsv2Hk4Dqe4wm74zYTTmK7r1lbvvlVw+ODbsmC+T4iF5sYxJDzwnngCmK?=
 =?us-ascii?Q?yghmJ4kKC5IFLv7lwI+YiFS1JEKDNl31wuF5X7lm/NxjZakJ5VomURslIbsB?=
 =?us-ascii?Q?tT9HfFVzdkpCSZyYlnfMd5rKfOB44z387C8mi8IxWUl1euL7ODsB+eeNs4ao?=
 =?us-ascii?Q?JO4XhOJQeNJYa7iI56WMFqJRhV1U66Ihye5tV3rlp5GO7CS3JstQOb8KkZa/?=
 =?us-ascii?Q?NGKXND4mgJ80/2tOb7ww6gSq/+FYjbtPKYEonPcFCdKSpD0kKPl/fTyvXfij?=
 =?us-ascii?Q?PQfdbwAAoyRKUgnuUFgDqLm0fhdGT7PNOrvD8yI/JIC8ycGqRRie9Bifi0QS?=
 =?us-ascii?Q?xe/zUvy9VxGsVkcznUjv0PheSjp2MSJL+V9iqGKkktimDOsXVngWNDsIFNVD?=
 =?us-ascii?Q?tpKGIRRndcXnVSGUJ+pH8sj8/GF9D/thx8FjBGSMAC6zbbGWNBKl9AQIpbzd?=
 =?us-ascii?Q?hAncTGO0jBINoNrLuxSY1Rh5ag7Lm+U9HZsSvtHWT+yzYVNujkyDjxuOeVbX?=
 =?us-ascii?Q?2g37GnuGu/k+nvKTDRjfa8u+TnM/9xLOHIa6JY6M2r7hydiC+K+7RdEwM4PE?=
 =?us-ascii?Q?iosq7hlJBUR0HXovkCTDFFw9ZA0jAtV+toXIrXLNzDt044K8rzSCe4Pwfb6t?=
 =?us-ascii?Q?pXwkAj3J+kI3g74xSIkPiNPvPn7raKT2a9wg+cepGMpPfv77H9nPPww1ONLZ?=
 =?us-ascii?Q?MUuEwHsFV7ajpXpIzRiAVL+b9uLqlOI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3733d56d-fe34-4173-29e2-08da4afee007
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:32:56.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VvXoejtQXDrXKiXSaIsta3LVLH80eDuis+B4Fo5XbKQ3VTeaMKwCwPMutFe+8HgFrUncXYoBB0bhBWIYQ0lmLyTCAvJ1rmp7AEJZW0/Nno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6180
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test creates a "tricky" example process tree where session leaders
of two sessions are children of pid namespace init, also they have their
own children, leader of session A has child with session B and leader
from session B has child with session A.

We check that Closest Alive Born Ancestor tree is right for this case.
This case illustrates how CABA tree helps to understand order of
creation between sessions.

CC: Eric Biederman <ebiederm@xmission.com>
CC: Kees Cook <keescook@chromium.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Daniel Bristot de Oliveira <bristot@redhat.com>
CC: Valentin Schneider <vschneid@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org
CC: linux-fsdevel@vger.kernel.org

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/caba/.gitignore  |   1 +
 tools/testing/selftests/caba/Makefile    |   7 +
 tools/testing/selftests/caba/caba_test.c | 501 +++++++++++++++++++++++
 tools/testing/selftests/caba/config      |   1 +
 5 files changed, 511 insertions(+)
 create mode 100644 tools/testing/selftests/caba/.gitignore
 create mode 100644 tools/testing/selftests/caba/Makefile
 create mode 100644 tools/testing/selftests/caba/caba_test.c
 create mode 100644 tools/testing/selftests/caba/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index de11992dc577..e231bd93b4c4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -3,6 +3,7 @@ TARGETS += alsa
 TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
+TARGETS += caba
 TARGETS += capabilities
 TARGETS += cgroup
 TARGETS += clone3
diff --git a/tools/testing/selftests/caba/.gitignore b/tools/testing/selftests/caba/.gitignore
new file mode 100644
index 000000000000..aa2c55b774e2
--- /dev/null
+++ b/tools/testing/selftests/caba/.gitignore
@@ -0,0 +1 @@
+caba_test
diff --git a/tools/testing/selftests/caba/Makefile b/tools/testing/selftests/caba/Makefile
new file mode 100644
index 000000000000..4260145c3747
--- /dev/null
+++ b/tools/testing/selftests/caba/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for caba selftests.
+CFLAGS = -g -I../../../../usr/include/ -Wall -O2
+
+TEST_GEN_FILES += caba_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/caba/caba_test.c b/tools/testing/selftests/caba/caba_test.c
new file mode 100644
index 000000000000..7a2e3f0f39db
--- /dev/null
+++ b/tools/testing/selftests/caba/caba_test.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/mount.h>
+#include <sys/user.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef CLONE_NEWPID
+#define CLONE_NEWPID 0x20000000	/* New pid namespace */
+#endif
+
+/* Attempt to de-conflict with the selftests tree. */
+#ifndef SKIP
+#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
+#endif
+
+struct process
+{
+	pid_t pid;
+	pid_t real;
+	pid_t caba;
+	int sks[2];
+	int dead;
+};
+
+struct process *processes;
+int nr_processes = 8;
+int current = 0;
+
+static void cleanup(void)
+{
+	kill(processes[0].pid, SIGKILL);
+	/* It's enought to kill pidns init for others to die */
+	kill(processes[1].pid, SIGKILL);
+}
+
+enum commands
+{
+	TEST_FORK,
+	TEST_WAIT,
+	TEST_SUBREAPER,
+	TEST_SETSID,
+	TEST_DIE,
+	/* unused */
+	TEST_GETSID,
+	TEST_SETNS,
+	TEST_SETPGID,
+	TEST_GETPGID,
+	TEST_GETPPID,
+};
+
+struct command
+{
+	enum commands	cmd;
+	int		arg1;
+	int		arg2;
+};
+
+static void handle_command(void);
+
+static void mainloop(void)
+{
+	while (1)
+		handle_command();
+}
+
+#define CLONE_STACK_SIZE 4096
+#define __stack_aligned__ __attribute__((aligned(16)))
+/* All arguments should be above stack, because it grows down */
+struct clone_args {
+	char stack[CLONE_STACK_SIZE] __stack_aligned__;
+	char stack_ptr[0];
+	int id;
+};
+
+static int get_real_pid()
+{
+	char buf[11];
+	int ret;
+
+	ret = readlink("/proc/self", buf, sizeof(buf)-1);
+	if (ret <= 0) {
+		fprintf(stderr, "%d: readlink /proc/self :%m", current);
+		return -1;
+	}
+	buf[ret] = '\0';
+
+	processes[current].real = atoi(buf);
+	return 0;
+}
+
+static int clone_func(void *_arg)
+{
+	struct clone_args *args = (struct clone_args *) _arg;
+
+	current = args->id;
+
+	if (get_real_pid())
+		exit(1);
+
+	printf("%3d: Hello. My pid is %d\n", args->id, getpid());
+	mainloop();
+	exit(0);
+}
+
+static int make_child(int id, int flags)
+{
+	struct clone_args args;
+	pid_t cid;
+
+	args.id = id;
+
+	cid = clone(clone_func, args.stack_ptr,
+			flags | SIGCHLD, &args);
+
+	if (cid < 0)
+		fprintf(stderr, "clone(%d, %d) :%m", id, flags);
+
+	processes[id].pid = cid;
+
+	return cid;
+}
+
+static int open_proc(void)
+{
+	int fd;
+	char proc_mountpoint[] = "/tmp/.caba_test.proc.XXXXXX";
+
+	if (mkdtemp(proc_mountpoint) == NULL) {
+		fprintf(stderr, "mkdtemp failed %s :%m\n", proc_mountpoint);
+		return -1;
+	}
+
+	if (mount("proc", proc_mountpoint, "proc", MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_NODEV, NULL)) {
+		fprintf(stderr, "mount proc failed :%m\n");
+		rmdir(proc_mountpoint);
+		return -1;
+	}
+
+	fd = open(proc_mountpoint, O_RDONLY | O_DIRECTORY, 0);
+	if (fd < 0)
+		fprintf(stderr, "can't open proc :%m\n");
+
+	if (umount2(proc_mountpoint, MNT_DETACH)) {
+		fprintf(stderr, "can't umount proc :%m\n");
+		goto err_close;
+	}
+
+	if (rmdir(proc_mountpoint)) {
+		fprintf(stderr, "can't remove tmp dir :%m\n");
+		goto err_close;
+	}
+
+	return fd;
+err_close:
+	if (fd >= 0)
+		close(fd);
+	return -1;
+}
+
+static int open_pidns(int pid)
+{
+	int proc, fd;
+	char pidns_path[PATH_MAX];
+
+	proc = open_proc();
+	if (proc < 0) {
+		fprintf(stderr, "open proc\n");
+		return -1;
+	}
+
+	sprintf(pidns_path, "%d/ns/pid", pid);
+	fd = openat(proc, pidns_path, O_RDONLY);
+	if (fd == -1)
+		fprintf(stderr, "open pidns fd\n");
+
+	close(proc);
+	return fd;
+}
+
+static int setns_pid(int pid, int nstype)
+{
+	int pidns, ret;
+
+	pidns = open_pidns(pid);
+	if (pidns < 0)
+		return -1;
+
+	ret = setns(pidns, nstype);
+	if (ret == -1)
+		fprintf(stderr, "setns :%m\n");
+
+	close(pidns);
+	return ret;
+}
+
+static void handle_command(void)
+{
+	int sk = processes[current].sks[0], ret, status = 0;
+	struct command cmd;
+
+	ret = read(sk, &cmd, sizeof(cmd));
+	if (ret != sizeof(cmd)) {
+		fprintf(stderr, "Unable to get command :%m\n");
+		goto err;
+	}
+
+	switch (cmd.cmd) {
+	case TEST_FORK:
+		{
+			pid_t pid;
+
+			pid = make_child(cmd.arg1, cmd.arg2);
+			if (pid == -1) {
+				status = -1;
+				goto err;
+			}
+
+			printf("%3d: fork(%d, %x) = %d\n",
+					current, cmd.arg1, cmd.arg2, pid);
+			processes[cmd.arg1].pid = pid;
+		}
+		break;
+	case TEST_WAIT:
+		printf("%3d: wait(%d) = %d\n", current,
+				cmd.arg1, processes[cmd.arg1].pid);
+
+		if (waitpid(processes[cmd.arg1].pid, NULL, 0) == -1) {
+			fprintf(stderr, "waitpid(%d) :%m\n", processes[cmd.arg1].pid);
+			status = -1;
+		}
+		break;
+	case TEST_SUBREAPER:
+		printf("%3d: subreaper(%d)\n", current, cmd.arg1);
+		if (prctl(PR_SET_CHILD_SUBREAPER, cmd.arg1, 0, 0, 0) == -1) {
+			fprintf(stderr, "PR_SET_CHILD_SUBREAPER :%m\n");
+			status = -1;
+		}
+		break;
+	case TEST_SETSID:
+		printf("%3d: setsid()\n", current);
+		if(setsid() == -1) {
+			fprintf(stderr, "setsid :%m\n");
+			status = -1;
+		}
+		break;
+	case TEST_GETSID:
+		printf("%3d: getsid()\n", current);
+		status = getsid(getpid());
+		if(status == -1)
+			fprintf(stderr, "getsid :%m\n");
+		break;
+	case TEST_SETPGID:
+		printf("%3d: setpgid(%d, %d)\n", current, cmd.arg1, cmd.arg2);
+		if(setpgid(processes[cmd.arg1].pid, processes[cmd.arg2].pid) == -1) {
+			fprintf(stderr, "setpgid :%m\n");
+			status = -1;
+		}
+		break;
+	case TEST_GETPGID:
+		printf("%3d: getpgid()\n", current);
+		status = getpgid(0);
+		if(status == -1)
+			fprintf(stderr, "getpgid :%m\n");
+		break;
+	case TEST_GETPPID:
+		printf("%3d: getppid()\n", current);
+		status = getppid();
+		if(status == -1)
+			fprintf(stderr, "getppid :%m\n");
+		break;
+	case TEST_SETNS:
+		printf("%3d: setns(%d, %d) = %d\n", current,
+				cmd.arg1, cmd.arg2, processes[cmd.arg1].pid);
+		setns_pid(processes[cmd.arg1].pid, cmd.arg2);
+
+		break;
+	case TEST_DIE:
+		printf("%3d: die()\n", current);
+		processes[current].dead = 1;
+		shutdown(sk, SHUT_RDWR);
+		exit(0);
+	}
+
+	ret = write(sk, &status, sizeof(status));
+	if (ret != sizeof(status)) {
+		fprintf(stderr, "Unable to answer :%m\n");
+		goto err;
+	}
+
+	if (status < 0)
+		goto err;
+
+	return;
+err:
+	shutdown(sk, SHUT_RDWR);
+	exit(1);
+}
+
+static int send_command(int id, enum commands op, int arg1, int arg2)
+{
+	int sk = processes[id].sks[1], ret, status;
+	struct command cmd = {op, arg1, arg2};
+
+	if (op == TEST_FORK) {
+		if (processes[arg1].pid) {
+			fprintf(stderr, "%d is busy :%m\n", arg1);
+			return -1;
+		}
+	}
+
+	ret = write(sk, &cmd, sizeof(cmd));
+	if (ret != sizeof(cmd)) {
+		fprintf(stderr, "Unable to send command :%m\n");
+		goto err;
+	}
+
+	status = 0;
+	ret = read(sk, &status, sizeof(status));
+	if (ret != sizeof(status) && !(status == 0 && op == TEST_DIE)) {
+		fprintf(stderr, "Unable to get answer :%m\n");
+		goto err;
+	}
+
+	if (status != -1 && (op == TEST_GETSID || op == TEST_GETPGID || op == TEST_GETPPID))
+		return status;
+
+	if (status) {
+		fprintf(stderr, "The command(%d, %d, %d) failed :%m\n", op, arg1, arg2);
+		goto err;
+	}
+
+	return 0;
+err:
+	cleanup();
+	exit(1);
+}
+
+static int get_caba(int pid, int *caba) {
+	char buf[64], *str;
+	FILE *fp;
+	size_t n;
+
+	if (!pid)
+		snprintf(buf, sizeof(buf), "/proc/self/status");
+	else
+		snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
+
+	fp = fopen(buf, "r");
+	if (!fp) {
+		perror("fopen");
+		return -1;
+	}
+
+	str = NULL;
+	while (getline(&str, &n, fp) != -1) {
+		if (strncmp(str, "NScaba:", 7) == 0) {
+			if (str[7] == '\0') {
+				*caba = 0;
+			} else {
+				if (sscanf(str+7, "%d", caba) != 1) {
+					perror("sscanf");
+					goto err;
+				}
+			}
+
+			fclose(fp);
+			free(str);
+			return 0;
+		}
+	}
+err:
+	free(str);
+	fclose(fp);
+	return -1;
+}
+
+static bool caba_supported(void)
+{
+	int caba;
+
+	return !get_caba(0, &caba);
+}
+
+FIXTURE(caba) {
+};
+
+FIXTURE_SETUP(caba)
+{
+	bool ret;
+
+	ret = caba_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "CABA is not supported");
+}
+
+FIXTURE_TEARDOWN(caba)
+{
+	bool ret;
+
+	ret = caba_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "CABA is not supported");
+
+	cleanup();
+}
+
+TEST_F(caba, complex_sessions)
+{
+	int ret, i, pid, caba;
+
+	ret = caba_supported();
+	ASSERT_GE(ret, 0);
+	if (!ret)
+		SKIP(return, "CABA is not supported");
+
+	processes = mmap(NULL, PAGE_SIZE, PROT_WRITE | PROT_READ, MAP_SHARED | MAP_ANONYMOUS, 0, 0); ASSERT_NE(processes, MAP_FAILED);
+	for (i = 0; i < nr_processes; i++) {
+		ret = socketpair(PF_UNIX, SOCK_STREAM, 0, processes[i].sks); ASSERT_EQ(ret, 0);
+
+	}
+
+	/*
+	 * Create init:
+	 * (pid, sid)
+	 * (1, 1)
+	 */
+	pid = make_child(0, 0); ASSERT_GT(pid, 0);
+	ret = send_command(0, TEST_FORK,	  1, CLONE_NEWPID); ASSERT_EQ(ret, 0);
+	ret = send_command(1, TEST_SETSID,	  0, 0); ASSERT_EQ(ret, 0);
+
+	/*
+	 * Create sequence of processes from one session:
+	 * (pid, sid)
+	 * (1, 1)---(2, 2)---(3, 2)---(4, 2)---(5, 2)
+	 */
+	ret = send_command(1, TEST_FORK,	  2, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(2, TEST_SETSID,	  0, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(2, TEST_FORK,	  3, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(3, TEST_FORK,	  4, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(4, TEST_FORK,	  5, 0); ASSERT_EQ(ret, 0);
+	/*
+	 * Create another session in the middle of first one:
+	 * (pid, sid)
+	 * (1, 1)---(2, 2)---(3, 2)---(4, 4)-+-(5, 2)
+	 *                                   `-(6, 4)---(7, 4)
+	 */
+	ret = send_command(4, TEST_SETSID,	  0, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(4, TEST_FORK,	  6, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(6, TEST_FORK,	  7, 0); ASSERT_EQ(ret, 0);
+
+	/*
+	 * Kill 6 while having 2 as child-sub-reaper:
+	 * (pid, sid)
+	 * (1, 1)---(2, 2)---(3, 2)---(4, 4)-+-(5, 2)
+	 *                 `-(7, 4)
+	 */
+	ret = send_command(2, TEST_SUBREAPER, 1, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(6, TEST_DIE,	  0, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(4, TEST_WAIT,	  6, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(2, TEST_SUBREAPER, 0, 0); ASSERT_EQ(ret, 0);
+
+	/*
+	 * Kill 3:
+	 * (pid, sid)
+	 * (1, 1)-+-(2, 2)---(7, 4)
+	 *        `-(4, 4)---(5, 2)
+	 * note: This is a "tricky" session tree example where it's not obvious
+	 * whether sid 2 was created first or sid 4 when creating the tree.
+	 */
+	ret = send_command(3, TEST_DIE,	  0, 0); ASSERT_EQ(ret, 0);
+	ret = send_command(2, TEST_WAIT,	  3, 0); ASSERT_EQ(ret, 0);
+
+	/*
+	 * CABA tree for this would be:
+	 * (pid, sid)
+	 * (1, 1)---(2, 2)---(4, 4)-+-(5, 2)
+	 *                          `-(7, 4)
+	 * note: CABA allows us to understand that session 2 was created first.
+	 */
+	ret = get_caba(processes[2].real, &caba); ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[1].real);
+	ret = get_caba(processes[4].real, &caba); ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[2].real);
+	ret = get_caba(processes[5].real, &caba); ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[4].real);
+	ret = get_caba(processes[7].real, &caba); ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[4].real);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/caba/config b/tools/testing/selftests/caba/config
new file mode 100644
index 000000000000..eae7bdaa3790
--- /dev/null
+++ b/tools/testing/selftests/caba/config
@@ -0,0 +1 @@
+CONFIG_PID_NS=y
-- 
2.35.3

