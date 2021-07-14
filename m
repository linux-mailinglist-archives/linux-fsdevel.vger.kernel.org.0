Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225DA3C854D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhGNNbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 09:31:05 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:16355
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231485AbhGNNbE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:31:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4P3C7KoxGrmHF2VNuZ4P0KGi9b1NHTbBefBq2kW0Wslj9RtsFhhW7bydchZ2ruK2UGXQm1kU+gXpT2yOc9HEU5H0raLVap7W4v3VbJ5NhDW1eAH2wZqmDEBK1zY2TedGuRInPGe5HlJUcHvlbUarrf93ipOCAfoRTiPJpigPuiglU5jk95H66TDwS6spXKnyKuzYyAhoa6a8GlDzi6MdYkSkBm0jWRp+1EbOAhusoo2MbRR80buWu54iZqiUWKbO9krqPRwzc3BRj2nkalfuDZoq4UVhBs01w7snEtJR0UFZ490wj4Cco7Vabm0nBup7qTn8fonVVQcyQ5XnsBgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0eUD8HsBrNXryAqFudUDldxaz8KUMXPUmXPeRoRdc=;
 b=IdNg1UnMIDJ7hhKAKfIiAFIy3GMTfXmIupQPQaMmgrkiOJ13Cno29yKEj2tJg9X/15R+DfxD0J4K1zxAFPzvKvWwrtFBjo0eaytoHJd/TvTuHB84ES3/Mw0f8DyUobXHSQGc0GP6M+eKV4j0mOx+UQHF4Jf0vu0FrYjpeG8I6HJtJ+AlgZnLjzSC9j7vVLdZmNSvpUG3480nNc9qZ29HGVs5ccEJJPXfsK6THlPOR4AEATHT95S5cwx83jotSx8BcUXCLUP/q5pmMHyfyZa6zTSMAGY/UDuCLidaViNK94Mh9xk8L3rJv4j2cTSwd04vypjekWxpipILHEfOQaTdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR0eUD8HsBrNXryAqFudUDldxaz8KUMXPUmXPeRoRdc=;
 b=dg0LvEOCPYaYHOk/qgAXSbZBl662oaL57j4X5+z+OsdJIoO3BketE9mWrp6cCKsXpWhlFWQ/BiZzmlYSglgh4BQjAPWF3+zJyZz4+hgE6Tai8fivWfQn3bW+oypzHPu254k94rT4qao27QH6HyzmmItIOZebamIT9OV+Pt2CnQk=
Authentication-Results: ubuntu.com; dkim=none (message not signed)
 header.d=none;ubuntu.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2765.eurprd08.prod.outlook.com (2603:10a6:802:18::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 13:28:09 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 13:28:09 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH v3 2/2] tests: add move_mount(MOVE_MOUNT_SET_GROUP) selftest
Date:   Wed, 14 Jul 2021 16:27:54 +0300
Message-Id: <20210714132754.94633-2-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714132754.94633-1-ptikhomirov@virtuozzo.com>
References: <20210714132754.94633-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::7) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.sw.ru (91.207.170.60) by PR1P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 13:28:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 167c1dc0-9d69-492b-c01b-08d946cb38e6
X-MS-TrafficTypeDiagnostic: VI1PR08MB2765:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB2765B1E09B1F37436404D114B7139@VI1PR08MB2765.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crlxtYI6T8p/E/rnZNXfbiugAY0zEp+b7J9rNeM6Ok7h/lSLa/QG5JLVIh29DfnD0AgCc7btqKFQmN2rhKi4aMq/QuGncVcTDHDKJuVDN3Rbzm//vexdZuZQA4Av7gfQ8b0NcecOcllwLHsMD6jZMWbYEbMADzd5Hx0GlIJe7BoWuxWG6YSU6gEezjZ8JFWjed5+o1oQYNxtDvrWtVt36qXhFuFKNEQtV/t6C+oZ8Yg9/DKuGw0DZKSpBUL+74hdJc1pjqufnV+B1T2Gs05KvyJnxuJjvcGWuAyzHHi79mVks1tDIWgQH+LdfxIptrLB5/nNPiIJ56IZCYz6ojvMlhyVssjcXadksJhqiV05WFX1IrnzpfjzwdyFIkWhKU7POxuPs2IWHED/HunTivHuqKbr/mCwwnIQrGxIf5yo/K0aGULEblmlfNKB4YSKyJDTWL7zp13v9vMD3QbxhknCUdSGdD3xe8VN76wTyVWQ7CZ5rFpnQBUmY5klETsRfKPOW/F9BR1BxOCmMLFhiWclTZLm35sumruV7IaFj6Wh4yf+WZzkd3zBaG5fz6q8kgc37ya44scP784K+YrkupiI0qDyqz3l9o/tf4SEElqRG5TxBiA/A6xC/aFQIknWU3oLZ+HTciw6bSgNiF9eJkXL/fWhoFTKsgnF9dyYPWRgYWMlb5hoUZpG/4WFL0uVvi956jnfqnSRhZ75cK90BzFY2Ewxm1NsUFKnkW7sNmn7TYIivdTkklOcHG5bor2NCEoSQD+kLSw1bJW3SUYRvE83OnKD8H6L5ubQXVAWCW3HEcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(396003)(136003)(346002)(6486002)(52116002)(186003)(36756003)(30864003)(6666004)(5660300002)(66946007)(38350700002)(316002)(8936002)(1076003)(6506007)(956004)(86362001)(66556008)(4326008)(6512007)(2906002)(8676002)(107886003)(83380400001)(2616005)(966005)(478600001)(38100700002)(26005)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7RbQX+Euai4pp+O6HlAkpBD2KQiPJtfULECtmpZasMceRYLpx5imtm8/g9Dc?=
 =?us-ascii?Q?0K11fsH2mwHug6GxYOZDweu4wmmqffVDx4ztJkdF2WTwleUHt22WQ0X5Lgo+?=
 =?us-ascii?Q?Xuqkb7roaXhW0QN3jozHOak156ogtPbJs32X+XjQLSsib1lK8Qf+nYWj5tl4?=
 =?us-ascii?Q?seQnCRHQM2H4Jlzehu4z4lHj9OJc3Op/HcdziQOkkJeBk2cC03wFPTF12gGZ?=
 =?us-ascii?Q?pluCBMSLqiV56suidOQaFdHhJtxG1GKqAPnBdigaX+JWexrEaj8PoZUOM1Qt?=
 =?us-ascii?Q?rgQbwr1CVhSnORHFR0mh99ig1iINIoRheyGuLjCozph5848RnCjURdp/v7Ph?=
 =?us-ascii?Q?mOfBuvqBmPk9PxujG39ZcvF54ULTuGzkl5mP9Gj16zpfWkkXqnLSYXPCQfSd?=
 =?us-ascii?Q?BXEuugzy0bfa7bx1AG0u8W3HwRDG13st/xBXo3fyn2FlKN+XYTiJBCWwfMx0?=
 =?us-ascii?Q?t3XS6sEiilM3/jCJmeXR9DCuU/H/gh95DILZIMf9Bt+QAAS6jm6zRSmkkl3o?=
 =?us-ascii?Q?zZqiB4fYB8oW9XNqOy6ZGHWpxdjRLHgj5HALOCb24cK08K5juwUf8PxUZgKm?=
 =?us-ascii?Q?2iuUB1H3xpbljmdfo1CvnURIjRCBUnLD1JWRS4Ub2kFqR95h6zXD8UrDUjE4?=
 =?us-ascii?Q?6TkEhc6iR1vx57u1ZxFfzb+90MVHWpW87R/Pw1hBQ9owfIlHVLloXX80MSWV?=
 =?us-ascii?Q?V+/3cmgyJ+jGrbSxBMAsZHgdtvsfzL8FHfMI0KFKFnYMa1AfWKh71Z21wmYU?=
 =?us-ascii?Q?XUaWvADvWo4aDjyVBiHlSgG6POAZ3lFLF1uTJI6eDYUd1laqZxwp608ux0Y/?=
 =?us-ascii?Q?1vlqhnk6wsxDO61waQKW0YyxyN5BYH36RL517UcedkkBTJE1/Fov+/rko5Bu?=
 =?us-ascii?Q?ryMNO+JkAt3fgxeNtA1LLz4AF0kVCaLPuMMHSbwGG7qKNaAsJMJvdpDzyJwd?=
 =?us-ascii?Q?H12Ztr1ZdJvW4sxvQp+0I1T9KS3TIkK7CQNoWXXARkihabGlksvJb5bBshrP?=
 =?us-ascii?Q?2oFCm/5xclaxuytaLh/Rzv1u1K6TnpGBLVhHBW5RhzuyX6O0S0M3Y4ZVGfHo?=
 =?us-ascii?Q?83EHpAbs6cSLQBdLo6FVWrY0a+8vq5/Ut815CB9cmwaf1HeLDcPZVFh/a+K9?=
 =?us-ascii?Q?fi9ZrZdlorccnHXY39HjqyZd6/tFLLFHnzdNiFd/28VT188G8ktioPaAk5fw?=
 =?us-ascii?Q?ka3vgEdk6VWPmDuS9BhQ9/BPY5VIBXsBNqYkxVI29f/d18T+HJYNUCzQ6x7L?=
 =?us-ascii?Q?QNfEE3EKWNWu87ou3RZfr8kHATQuosRLrmd73T9iAoFGN9rWAtjlT7+nDUtp?=
 =?us-ascii?Q?d9+s2YgWwsz74J7gwBjdvFHI?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167c1dc0-9d69-492b-c01b-08d946cb38e6
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 13:28:09.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wxY7T0rTN2HWpPLtzvMmguwXjwHwLTppmiYnDMQt5yCinjYaFyZeZEEFT3vYmtYWaK/lgFAJQ2wHKaOFZ2DR+rtYCwHP2OsxVZY9HIDpjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2765
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

