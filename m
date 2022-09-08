Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660455B200E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIHODx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiIHODh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:03:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70130.outbound.protection.outlook.com [40.107.7.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C69C1838B;
        Thu,  8 Sep 2022 07:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXizeeacKzMqRRwVQ9cMLyZeAVGMLp8M6EW7B+UFRWfhU1ojdqfPELtCvr8PNRayxIcn/KBj0mBs2v89/Hfq0QE7ilSlOR4kDhGCMWSAlwOlk7KiPn0wVmVexH0TP5RXb1pfG9ly9V9CtbYveCErA7owW+/i99oNLPVwvj0FS0ELMmGOgk6TQwQrYcXr+O8vAXGHpabDpTZQjoAkbpy4dVNujge3CBVge/tpq7Vz2GjKryI9SP+jhi0rET5yW+ehdnnZ4GhN/u8in2w3LCHb3rRS8sRK92psVM+OWT1GVpdS9Xn/ZJRFz0tp8Iywty09PciwU9njsFKFM6fs3Fb3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ls4sv4Fg00Pa8eAMf9HiGFGSty3qr/uNAdsjO6HViNE=;
 b=LwvZQJODY8L4G8kYYVNkmSAcEqEjmvrssiC8CVNRNW7Z+GHEYvpghvTlQJWyr9dKQHSTI98wW2VC6S251f3pAQUj2Qo185kUoH0x9UcGnvsgu8RDyl0aMcnb3slBBHKK6YfyxVQtUlduepOd9ouFfoIE2UvyEmIACgBDBO/SQLshhjh42no1wA+FilZG7VaIfkfKv1Fon+DhCVdhUq8f72IsF5AY3h4JnocpY2YJ8sap7+DP0KgQorcxafl1gdDB6xYInrx+9WQNJ/T/muAVbw3QjTqXy4xmReYJWJjHUwJPQbYEf3qIQzAe4cOlMuV5Ry9McYUjU85JbK74ABlkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls4sv4Fg00Pa8eAMf9HiGFGSty3qr/uNAdsjO6HViNE=;
 b=RzOnHfu3TZRaCltZq4GLjYUF9zqFpspDJzKbuMa/9WRt2m/ytkpahBu+h1xvRNE6tNvyzHc7aNeTgJEmRC9mIrQse3fEvdAGwTS1DpjX6EpqdWDbshneDX0ziD5JqTKCY4wZGKKkSsUE4P1WRzsenO8+kQa380sLEKovw5GGmufwt8By+aVU/TgZVHSKnbXIneQW18ofuUZbHY0sUdfLmxHlfCjF+EurMXahFl1ryuKkQYzfef1Z95sly1Rt62e455PgEUnmZOmTZIDeQa+sccrUH45UK4JanggpJ5iLQJsCOtUqKfBtaFqQ00oRQ1atk7iFqBqJ4CcElIhBOYl34Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by PAXPR08MB7671.eurprd08.prod.outlook.com (2603:10a6:102:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 14:03:29 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::f536:84f7:c861:ccc1%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 14:03:29 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
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
Subject: [PATCH v3 2/2] tests: Add CABA selftest
Date:   Thu,  8 Sep 2022 17:03:13 +0300
Message-Id: <20220908140313.313020-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908140313.313020-1-ptikhomirov@virtuozzo.com>
References: <20220908140313.313020-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|PAXPR08MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a98ae78-a9a5-4158-dc2e-08da91a2e800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1itmPSF5cVOAK1UHBseyD59MjKSJhQ0Jj21PvjkbznVjiBy9AnmTG9kuHB7sP6OWuI8pGGb3kKjlZOmq6VgOCa35IWmkcZrgoQP1OM79Neh8VekRmVEYjw6KW00jJWj0DaSo1oFK8CJNT7lU8LdbGiIGx+E9yQ7GBLMjDmBD8BiU93UxDT7dHCwy//t/7rJwLCforv4GkNj/mlyeI7Ph2PwsZLDEt5quQ3t7ZY15dIlOIMgJY9BpCCPC5U/tKYiJmXZjWoBUeO3J8KmB77aFxF6JhHjYuVhL2sB1PPu/2WvQrkwktZ90v2PMuzU9NW1IRpB17CeBd/LLfLkZ4TYwNDYKppn9Ms3P3uhMw5opH2Ebrg4buDJP4LWlq8qwDraLERFfp38qCfjWBMT7eL9q9xDMczMFU2c6mlNGVnlJwaR6QuveKWDjr3Vy7jcYMssfau+aiw2Pmbdd+7lID8LIZEjM50e2TyV5RV3rWT6+TL4PBZv+Rh5+X3Cv1a0Ys1kbQh/GgYw+FCZ6nATjc4FqRf57/KnoNaky2YaJY+VdR2KoLmnP31C8DicgtdLEWK2De1zXrP8Zur2uNQYG/u4qa7tHd8OZVT2iHGsU2htOc1YdIEC0lDkti78Q7X6P3YLtNFOtMDHTlPQZ8c0FP+Q1bAIXCZ74/5JVo13rsuqCBXEmhzgT3DrzKUqY6lqEhWRCbgbT3IK8KNxT3tH2YmirUuktCYxiWeOBl8ijh7GLufPU6rnGmuYwRJiYAKw7WOYjYkUyK2jPTnYkKlMXy0wgoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(83380400001)(38100700002)(38350700002)(86362001)(54906003)(66476007)(30864003)(4326008)(66556008)(316002)(8676002)(2906002)(66946007)(52116002)(110136005)(26005)(7416002)(8936002)(5660300002)(478600001)(6512007)(2616005)(186003)(1076003)(6666004)(6486002)(107886003)(41300700001)(6506007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XhkXT5PS3cpAMOstPnee7/2dETFfKunrl++KO86/C0Sel8vhcj7G1erFJcrt?=
 =?us-ascii?Q?Uq7ovgirB9m8BfgQlZGap3PZ9TsP5FVmTPrsLw6i84N63b+2FzvsvTJyi11X?=
 =?us-ascii?Q?o/Kyd8XrJJPavnZNPzyqb3Pskqv+CM+ftdhsDrYLFlmqHMr69NHYvHbz3NxS?=
 =?us-ascii?Q?m6p3dFK4CmRfr1tfnO/4CT1OS85y3QZD+f4dWpYdxKPKgEoLT5SrF29RzagC?=
 =?us-ascii?Q?EIGXrDHwE4QyggyEuNiUnOUwyp2TBZhoJ3GxBffoBMn0Hgoi20dsd/amkvhg?=
 =?us-ascii?Q?Iou4UG9R1I+2MTSCLvivBoX6x2LOl2aPDIQu/4JPY4B0uBn3LPTriHe54VCP?=
 =?us-ascii?Q?t7u5ZoVVRUf9PZLhfmuhYL0Mgj2kE1mWaEoIEqp/FdTImYEuPOeV3HCw4pHb?=
 =?us-ascii?Q?6NDqKp2bY40b3mSVmyHv/DWmgoid9DNHMAP2FwEQEkzU9vccIJDei/uGVg6L?=
 =?us-ascii?Q?WdMwIgWK7e+PnegqRu/Y34DJ1A/4MGB0GMzd83ySiIm6xU1TokmS+LdyEQd2?=
 =?us-ascii?Q?B0jWGpAtttPv8TFv4oZxqXbT5ocIp+P0M2u5XguUHIra6EgUdtZ+Quzr8Mes?=
 =?us-ascii?Q?kiF+QiAQLO4ev3jQpGFKCtvmP0OqRyKUnf4bpqtLdJoh2VgLPgtep5tsECv2?=
 =?us-ascii?Q?mOYNqpprR8542JQskBBFgwQH9RpzwxuBpluyj6O0x2Pe9yeEKfP0CLyxvVe/?=
 =?us-ascii?Q?vvzhpdOo+ll71ItTKkToSsKur/Iiq4T+VEHTnSYj/uY4drwKuXY7g04V9WJh?=
 =?us-ascii?Q?I4x95/xqbnN/0p8uPReprMsV+6ir0W98CxdRKJTvyxAuQSkeYqpfwlQTcdd4?=
 =?us-ascii?Q?w4Xpx1eQprsuKMFsAUHkUsO+VmRouSOyeb1C2La+g9YQOA4CLDJ4g3lL9y1W?=
 =?us-ascii?Q?ZiCOTIQItqnRHrs0sNyPMXh7BlOEEWy35ryeyTfz1XVJFErUPZjwv1a2NZG1?=
 =?us-ascii?Q?W892y5qGOoY8nR5eNod7+2P44LKM4BF7jfHcD6rO8Fd6R/+zbK+hksTggJFN?=
 =?us-ascii?Q?c2qSIzTcQRxRNfht/foDXoWpzugFkPzaPETFEbMdnaz9UsTkClVejIXND1fk?=
 =?us-ascii?Q?NThkfs6BKgcrTmhuf5X70UMr+i4WftnkSBONi3o2eqhpH9ht9HHOWz/ZxUnH?=
 =?us-ascii?Q?EW4ftDXMKj8PDIKdTIvTB0p8GMpOMoxjc56pBDBUeAB5Z5EqeyOwO+bvo9su?=
 =?us-ascii?Q?FTNaDfsT+n5zhDA1AOOnD1tYYpH4mOMhvxmZSLDybhnUJdnC8LiyQzKmp1cM?=
 =?us-ascii?Q?D4pvsgWofFs8S8G9XQeJtOP1QdQaINF8/Ez7xW4XwG8p42uUzxYiJVcWX3K6?=
 =?us-ascii?Q?OGKoXSnynrjqPdYXeAu4Dgs77PMKIW7CC8+kJLa7SIar0vH0EKk81O7RZywY?=
 =?us-ascii?Q?ogUA4bClFG9PXlAGWbYqiEmNzfHuW+uRa3RCE61ieihXoUYUomXQlecCc1Jt?=
 =?us-ascii?Q?A+tjCC2HOTtWPOKh6PzN8+OhkGTx+VbMhgZuwayK3H4HMUqDFxBxKBn+/1DM?=
 =?us-ascii?Q?lypWIzrj4etVcNle/rup2zw+rai4kPsFMiH8qZJi6Cqrk3sfd8RI/jQ/zfUK?=
 =?us-ascii?Q?hnuKf7PBQpm+Th/b6vCJ35xujwezTUf4rsbWCYjoxCAbj6z6ImKT5S09dQjQ?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a98ae78-a9a5-4158-dc2e-08da91a2e800
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:03:29.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swRu2j5eod+T/31fH9D0WJFw5L9yQlpDz6NtRSyqt6P8pEoPQxAn/tlfzXckkr4SXYUqCU5ty1M/XVvWljUdEex8hPL4K2wou7q4THTuqok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7671
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

--
v3: fix codding style
---
 tools/testing/selftests/Makefile         |   1 +
 tools/testing/selftests/caba/.gitignore  |   1 +
 tools/testing/selftests/caba/Makefile    |   7 +
 tools/testing/selftests/caba/caba_test.c | 509 +++++++++++++++++++++++
 tools/testing/selftests/caba/config      |   1 +
 5 files changed, 519 insertions(+)
 create mode 100644 tools/testing/selftests/caba/.gitignore
 create mode 100644 tools/testing/selftests/caba/Makefile
 create mode 100644 tools/testing/selftests/caba/caba_test.c
 create mode 100644 tools/testing/selftests/caba/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c2064a35688b..d545bd9e3637 100644
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
index 000000000000..a89c4b96393b
--- /dev/null
+++ b/tools/testing/selftests/caba/caba_test.c
@@ -0,0 +1,509 @@
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
+struct process {
+	pid_t pid;
+	pid_t real;
+	pid_t caba;
+	int sks[2];
+	int dead;
+};
+
+struct process *processes;
+int nr_processes = 8;
+int current;
+
+static void cleanup(void)
+{
+	kill(processes[0].pid, SIGKILL);
+	/* It's enough to kill pidns init for others to die */
+	kill(processes[1].pid, SIGKILL);
+}
+
+enum commands {
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
+struct command {
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
+static int get_real_pid(void)
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
+	if (mount("proc", proc_mountpoint, "proc",
+		  MS_MGC_VAL | MS_NOSUID | MS_NOEXEC | MS_NODEV, NULL)) {
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
+		if (setsid() == -1) {
+			fprintf(stderr, "setsid :%m\n");
+			status = -1;
+		}
+		break;
+	case TEST_GETSID:
+		printf("%3d: getsid()\n", current);
+		status = getsid(getpid());
+		if (status == -1)
+			fprintf(stderr, "getsid :%m\n");
+		break;
+	case TEST_SETPGID:
+		printf("%3d: setpgid(%d, %d)\n", current, cmd.arg1, cmd.arg2);
+		if (setpgid(processes[cmd.arg1].pid, processes[cmd.arg2].pid) == -1) {
+			fprintf(stderr, "setpgid :%m\n");
+			status = -1;
+		}
+		break;
+	case TEST_GETPGID:
+		printf("%3d: getpgid()\n", current);
+		status = getpgid(0);
+		if (status == -1)
+			fprintf(stderr, "getpgid :%m\n");
+		break;
+	case TEST_GETPPID:
+		printf("%3d: getppid()\n", current);
+		status = getppid();
+		if (status == -1)
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
+static int get_caba(int pid, int *caba)
+{
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
+	processes = mmap(NULL, PAGE_SIZE,
+			 PROT_WRITE | PROT_READ, MAP_SHARED | MAP_ANONYMOUS,
+			 0, 0);
+	ASSERT_NE(processes, MAP_FAILED);
+	for (i = 0; i < nr_processes; i++) {
+		ret = socketpair(PF_UNIX, SOCK_STREAM, 0, processes[i].sks);
+		ASSERT_EQ(ret, 0);
+	}
+
+	/*
+	 * Create init:
+	 * (pid, sid)
+	 * (1, 1)
+	 */
+	pid = make_child(0, 0); ASSERT_GT(pid, 0);
+	ret = send_command(0, TEST_FORK,	  1, CLONE_NEWPID);
+	ASSERT_EQ(ret, 0);
+	ret = send_command(1, TEST_SETSID,	  0, 0);
+	ASSERT_EQ(ret, 0);
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
+	ret = get_caba(processes[2].real, &caba);
+	ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[1].real);
+	ret = get_caba(processes[4].real, &caba);
+	ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[2].real);
+	ret = get_caba(processes[5].real, &caba);
+	ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[4].real);
+	ret = get_caba(processes[7].real, &caba);
+	ASSERT_EQ(ret, 0); ASSERT_EQ(caba, processes[4].real);
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
2.37.1

