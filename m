Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1497D54CDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbiFOQIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346118AbiFOQIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:08:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60120.outbound.protection.outlook.com [40.107.6.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16CA34B81;
        Wed, 15 Jun 2022 09:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBVNzEGdoZtkxJeQFAwSCW/eeWN2MygKDpOXvEuWlbYnfSjgGiFGyUtyjcgR9eVNrVZ1iw4GS6wB2+ycvRI3HguoGPFprlwegkGe4lh0zK8du95beOaXHxPhpadtVW/lo2XZ7iXXj/xFosf7aWhFhNtnbi9TmqJOpliDkeQ+fZpX+JkjP2PnFetnkbGW6r3RD/mUh2b333zbPSeIXfertOsp23Fqss/wZIFuFuPwRUrsa194glfk7jVI6TXBBwBhSCx+QcQjOnYL9oFCq1urqZZ/9stmorwydoHnMRZe9etpTeC7fA6JzLtC/fU1RWtq634tHdv8Emovkmr6h9qNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vizK065AkopgIZrXURLmvOp5+ktk47crt20CW7lwvkw=;
 b=N/NNDgXbsMIcK0lg0HgO6Zi6paTkZ630GQH2pwac1ck3IkA8F9yG9qCC7eZx/gFjjKz5jSFITd66ve+cKSX0UCSr5EDkJkU1sy60VeyAdTVy+E0Xg7fR+ST3C6phAI+610V1/j1HYb1U2UsABG3ctYr5afdFf7sZ55aAnAqkP1+PW2I9GTLvwNFq874dsxEHZEbvj5ehvFQUllqz68kwZ6ILLdwK1OwZ9LwLKPrpxrSp0B5JRcySLWAKQyA6zs0pwRW/OrRQOt/tSP1J2E40eqB76Qm88SJ/RXQgq1lIMWbWVT9dEo7RDAff85MRvzpp0zvBDWgFPGuyok5ETPc+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vizK065AkopgIZrXURLmvOp5+ktk47crt20CW7lwvkw=;
 b=TWv/uuoGrmVgLawZb7f2AG0fnE3DJHEG3Jo16HUSnzx1j1Duc+XHEBGjVJkzkfvgXqDV74aB1rAftLhGp5Julol2jfB5W8Ok+DxlfTAnyPNbhwEiCDT+PsLkNburGKWNcligb1eHYEidbJAvMSfYkD0R53y7hXdkiUUDqZKoFGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB4029.eurprd08.prod.outlook.com (2603:10a6:803:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Wed, 15 Jun
 2022 16:08:34 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::5f7:6dd:4715:5169%6]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 16:08:34 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
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
        linux-fsdevel@vger.kernel.org, kernel@openvz.org
Subject: [PATCH v2 2/2] tests: Add CABA selftest
Date:   Wed, 15 Jun 2022 19:08:19 +0300
Message-Id: <20220615160819.242520-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160819.242520-1-ptikhomirov@virtuozzo.com>
References: <20220615160819.242520-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::45) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de90bba9-521c-4850-58d8-08da4ee94c7b
X-MS-TrafficTypeDiagnostic: VI1PR08MB4029:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB4029A412F8406DAFCA693942B7AD9@VI1PR08MB4029.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1BQMb5QMR5CXvwmVMvxW+b+LL3YNrLqycF1iNtQi1m1ULIC++/gZHZ5b73XyORI0ox8atW+9hJbCrywuS1u5+783j2svKybGWNtiL7C8IpJDjMvcjd7Q+oPcwn2O/QucPFMEehTXS7ac9xqWzu5MJcR5cL+jJykwtrKAZXV29aeLSmnX7s4+J5s4NHVyfkzgbUGEFv5g8V6G1ehswY0SVqqurb+G1/BZZcHMotsfiXC2ehBjUQPLPZ0lGZkHyBN3XcHHoXR3nVztIgMm/PFIlSll0cWQuc/KkPN2mk4FXNFPckmh0JJQjvPYJhDUsj7lEUhJZAimkHbrTAKJPMyRB3801SPwShpEELIbf8wPFv67aCiyXdLhLNZ4X681sp6RPUS6jxedu726S5fOqvB9SfeJEJ3SFooV14EMZB6VGr091rm5AY+AZlNS4HxlbdZ1YbuihlgIKtLe5L1ojI2WqbzO7AX4idTPyA+BSdwdU+CtVtylxzx7lZGucvvJuyFbtgv3mNdIlZn7El3tRyww7y388ouTKsyis3qzlLn/M47RUSytna8kOiQjPPzw7N8Fci0d7zrZbgobKjGeAnR8TzslEPuxivY3LjZN6yA53g1GYVAp2nPG13dzrjL+hzXEAmD+zuYzDXUtcSq8vXI/NpizpYSywnFOqOVvEzjVSElnpbhA9Nxb1Plt5UH15ehBEPw4yrlb3OWluim4BpGN0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(508600001)(6506007)(83380400001)(66476007)(52116002)(38350700002)(38100700002)(8936002)(107886003)(6512007)(6486002)(66556008)(6916009)(36756003)(66946007)(54906003)(1076003)(316002)(86362001)(6666004)(5660300002)(2906002)(26005)(8676002)(7416002)(4326008)(2616005)(186003)(30864003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hvVMOBKYUcb8Y6QKZyI7tuzn7yLvuWmmcl4DdbW+mFmNTdSynNOPoTdA14GG?=
 =?us-ascii?Q?Ll2BcKWFxPqDfhZE5+ipEpmEmhwrL4q2BMMwhWvHhOoUJu2wG45AT5TKnKN7?=
 =?us-ascii?Q?vW2OaXYYtGHwheNMFx1mr+3lOPsxEtoa7b364udQLGDV6gIOw5kErvO/9xTw?=
 =?us-ascii?Q?hBSv5f62nB9vKTJ7fADXl9Pf02rZb8sYz/PuXLFn+R6+yAk+VTZozdQ473Ra?=
 =?us-ascii?Q?BYBDBXcKAgyYSUfyOzx78xbCfYjO9+bc/b9z3j1ulBKTvgaFJjwaar5HaH24?=
 =?us-ascii?Q?ahZ5bBIJgoiXm+/ELRz0vtBtabo9BW6UehnI6yP9IbjHAeqIkDy9aOSZtmLG?=
 =?us-ascii?Q?9pJ3DsUBgMOomA5y+OYRghUsj+aL/8VxkwxRyebGsqDnDxdbIUPRotGW5jhB?=
 =?us-ascii?Q?e3z/7mCRd1em9/cV3wwoNjvM+3ha4NTgPP4PU5rh+1TM29krPKIRmNqlGEIn?=
 =?us-ascii?Q?7FY9IR5hNz0XzXWyJnxvKF4RuxvLMY3BlZ87IpjgjklKpqZ6DOZPUYeFcHLF?=
 =?us-ascii?Q?Oks5eJlZxQfv+B035g0jflLMKrEfNmgHYy5ttqUF5Cx09rOzToI2l9MNM341?=
 =?us-ascii?Q?xV1OAAIHh/3Y93cp7PC0QHVj37iTmoS/sei+x+OwQ1FjXMvg1AZg8788azTJ?=
 =?us-ascii?Q?3dnLRDBdiLeJZdpLg5pfpEUOk5j2V+ishhtHQv04yHLiWPOwzt8Av5j1wG1U?=
 =?us-ascii?Q?aWqISerTAznq3jsZCEZsg+4OidtT7T/JyV0fSbbowx4qcHZeQGdOY/9bPJ2O?=
 =?us-ascii?Q?i83BVQ418sU9E/jbJfHb3kvAQICTviv3Qlxkc9S+y5MOp3Ny3yCFSyRX1AP8?=
 =?us-ascii?Q?lWjXshf5HDchFLmgzEP0SHkeOCnuyM3hS7Rcz7AZMXpqF7/br0oeQIU9OBi+?=
 =?us-ascii?Q?NQ7U/T4HDE+pVEOfzynTpz3KRvOkDiTr4mbzdI0Ana6oEGk1Wr8hySyXdu0L?=
 =?us-ascii?Q?3iIi7gUVOkRAfOb2HVrLwKRhO6oejnjPlQXmhwFse6xGX3bdqS8cyfll6tX/?=
 =?us-ascii?Q?BJ1EjA2Fb/+1iM9uFP/vXs6VljyG2o/XbIV5m/rXd8c/M2Ff5bZFYKPIlPEP?=
 =?us-ascii?Q?lhUi881Lr7nwm4yW+wUbCAMloLP3tJraLBsbX4kBHvH3S3aDwQZCelQP7RDR?=
 =?us-ascii?Q?Lo86ssVttv4Iv6esr0S0mjFpbhNWFu3CUjXhMNon6P73HzXLypO9t6ub+fZL?=
 =?us-ascii?Q?bUaSLYgxqLfzVeV/5r7DIViHL3SBJOTp1DWcUhtMPBPynNU2RqRIlEbXxATY?=
 =?us-ascii?Q?npfN7NByhweN2uqLsxgFAY7M1/+ZsaVyRCx+IJhuBB3Z09fttaWz9WNKtgzs?=
 =?us-ascii?Q?kaVVTLhLiBU7NUJw+fib2AB0jjtxtaa7JRW1yP6s46UijeY7KGoD6m0JUNCu?=
 =?us-ascii?Q?uoJDdbekynLq85f8Z/krLEU2uAC2prMIT5uVXXTiu7fYYYxH6Wqw34A3hvA9?=
 =?us-ascii?Q?+XJKxLU3SAFNsHqJD60kOnKCeXhH/IeXWPTpK4WmyycaNRM1cKa5tet170Ve?=
 =?us-ascii?Q?7d8pjB6yos5Dy7R1IhvAbPo8YvtrNitcH4b9DWtFPehvtJUkjwXRJ8naRG2C?=
 =?us-ascii?Q?EySStZFYDR9Y13of5KCGRZnlSgf4A6m1DcoH9DUbgljXPOqqDlrJSbNzNRym?=
 =?us-ascii?Q?6AvFGEfdgWOm24ilk4cL+pE8plaGDyjObDkgCkQSRb3gb1eTmI3KhypmqPuQ?=
 =?us-ascii?Q?BAGk9YFbRyD8SwHelA5+rNUQTiOIV2/1pf/livXPYAmOaqtev+Z+QIeroGwd?=
 =?us-ascii?Q?YZrp2MLXD2iGzz1IhbUatkKhkPM9kLo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de90bba9-521c-4850-58d8-08da4ee94c7b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 16:08:34.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DzXagQgI2AQyNbKGC6kRtVWp6g2lRr/Xsk9ZcBiXDbc7wRxInHUHZJ0Fnin3YBRpHWzOyPyojYG9T4wpmRw2dUj2pXe4K1VDkdZ54zS2zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
CC: kernel@openvz.org

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

