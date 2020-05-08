Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FDD1CAA7A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 14:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEHMX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 08:23:28 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34578 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727100AbgEHMX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:27 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id ED8512E151F;
        Fri,  8 May 2020 15:23:18 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 7NK2742NLq-NHb8lZG3;
        Fri, 08 May 2020 15:23:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940598; bh=KU2g+Q0yPMTYZlBSSwWKdYtFznVsnPkB2sauyejITt4=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=Ph/BhQVD66wYtc1XAoeAQ8rPXfDRFEjS5ND7g8MKREO1d+1S3FOOlB09mrxBbycic
         ilB0e9MG7CuVf+MUwol8NI2wO8wjpSzQwLsV75E8K39ZyTg+gAnxFL0e2MCEm06cOD
         b0CaYwDrDTyPOgd42IzPNlN4Du43O30PJAgj/Vps=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ZuTxA7ymDv-NHWCQXMj;
        Fri, 08 May 2020 15:23:17 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 2/8] selftests: add stress testing tool for dcache
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:17 +0300
Message-ID: <158894059714.200862.11121403612367981747.stgit@buzz>
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This tool fills dcache with negative dentries. Between iterations it prints
statistics and measures time of inotify operation which might degrade.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/testing/selftests/filesystems/Makefile       |    1 
 .../testing/selftests/filesystems/dcache_stress.c  |  210 ++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/dcache_stress.c

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 129880fb42d3..6b5e08617d11 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -3,5 +3,6 @@
 CFLAGS += -I../../../../usr/include/
 TEST_GEN_PROGS := devpts_pts
 TEST_GEN_PROGS_EXTENDED := dnotify_test
+TEST_GEN_FILES += dcache_stress
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/dcache_stress.c b/tools/testing/selftests/filesystems/dcache_stress.c
new file mode 100644
index 000000000000..770e8876629e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/dcache_stress.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/inotify.h>
+#include <sys/stat.h>
+#include <time.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <string.h>
+#include <err.h>
+
+double now(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec + ts.tv_nsec * 1e-9;
+}
+
+struct dentry_stat {
+	long nr_dentry;
+	long nr_unused;
+	long age_limit;		/* age in seconds */
+	long want_pages;	/* pages requested by system */
+	long nr_negative;	/* # of unused negative dentries */
+	long nr_buckets;	/* count of dcache hash buckets */
+};
+
+void show_dentry_state(void)
+{
+	struct dentry_stat stat;
+	ssize_t len;
+	FILE *f;
+
+	f = fopen("/proc/sys/fs/dentry-state", "r");
+	if (!f)
+		err(2, "open fs.dentry-state");
+
+	if (fscanf(f, "%ld %ld %ld %ld %ld %ld",
+		   &stat.nr_dentry,
+		   &stat.nr_unused,
+		   &stat.age_limit,
+		   &stat.want_pages,
+		   &stat.nr_negative,
+		   &stat.nr_buckets) != 6)
+		err(2, "read fs.dentry-state");
+	fclose(f);
+
+	if (!stat.nr_buckets)
+		stat.nr_buckets = 1 << 20;	// for 8Gb ram
+
+	printf("nr_dentry = %ld\t%.1fM\n", stat.nr_dentry, stat.nr_dentry / 1e6);
+	printf("nr_buckets = %ld\t%.1f avg\n", stat.nr_buckets, (double)stat.nr_dentry / stat.nr_buckets);
+	printf("nr_unused = %ld\t%.1f%%\n", stat.nr_unused, stat.nr_unused * 100. / stat.nr_dentry);
+	printf("nr_negative = %ld\t%.1f%%\n\n", stat.nr_negative, stat.nr_negative * 100. / stat.nr_dentry);
+}
+
+void test_inotify(const char *path)
+{
+	double tm;
+	int fd;
+
+	fd = inotify_init1(0);
+
+	tm = now();
+	inotify_add_watch(fd, path, IN_OPEN);
+	tm = now() - tm;
+
+	printf("inotify time: %f seconds\n\n", tm);
+
+	close(fd);
+}
+
+int main(int argc, char **argv)
+{
+	char dir_name[] = "dcache_stress.XXXXXX";
+	char name[4096];
+	char *suffix = name;
+	int nr_iterations = 10;
+	int nr_names = 1 << 20;
+	int iteration, index;
+	int other_dir = -1;
+	int mknod_unlink = 0;
+	int mkdir_chdir = 0;
+	int second_access = 0;
+	long long total_names = 0;
+	double tm;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "i:n:p:o:usdh")) != -1) {
+		switch (opt) {
+		case 'i':
+			nr_iterations = atoi(optarg);
+			break;
+		case 'n':
+			nr_names = atoi(optarg);
+			break;
+		case 'p':
+			strcpy(suffix, optarg);
+			suffix += strlen(suffix);
+			break;
+		case 'o':
+			other_dir = open(optarg, O_RDONLY | O_DIRECTORY);
+			if (other_dir < 0)
+				err(2, "open %s", optarg);
+			break;
+		case 'u':
+			mknod_unlink = 1;
+			break;
+		case 'd':
+			mkdir_chdir = 1;
+			break;
+		case 's':
+			second_access = 1;
+			break;
+		case '?':
+		case 'h':
+			printf("usage: %s [-i <iterations>] [-n <names>] [-p <prefix>] [-o <dir>] [-u] [-s]\n"
+			       "  -i  test iterations, default %d\n"
+			       "  -n  names at each iterations, default %d\n"
+			       "  -p  prefix for names\n"
+			       "  -o  interlave with other dir\n"
+			       "  -s  touch twice\n"
+			       "  -u  mknod-unlink sequence\n"
+			       "  -d  mkdir-chdir sequence (leaves garbage)\n",
+			       argv[0], nr_iterations, nr_names);
+			return 1;
+		}
+	}
+
+
+	if (!mkdtemp(dir_name))
+		err(2, "mkdtemp");
+
+	if (chdir(dir_name))
+		err(2, "chdir");
+
+	show_dentry_state();
+
+	if (!mkdir_chdir)
+		test_inotify(".");
+
+	printf("working in temporary directory %s\n\n", dir_name);
+
+	for (iteration = 1; iteration <= nr_iterations; iteration++) {
+
+		printf("start iteration %d, %d names\n", iteration, nr_names);
+
+		tm = now();
+
+		sprintf(suffix, "%08x", iteration);
+
+		for (index = 0; index < nr_names; index++) {
+			sprintf(suffix + 8, "%08x", index);
+
+			if (mknod_unlink) {
+				if (mknod(name, S_IFREG, 0))
+					err(2, "mknod %s", name);
+				if (unlink(name))
+					err(2, "unlink %s", name);
+			} else if (mkdir_chdir) {
+				if (mkdir(name, 0775))
+					err(2, "mkdir %s", name);
+				if (chdir(name))
+					err(2, "chdir %s", name);
+			} else
+				access(name, 0);
+
+			if (second_access)
+				access(name, 0);
+
+			if (other_dir >= 0) {
+				faccessat(other_dir, name, 0, 0);
+				if (second_access)
+					faccessat(other_dir, name, 0, 0);
+			}
+		}
+
+		total_names += nr_names;
+
+		tm = now() - tm;
+		printf("iteration %d complete in %f seconds, total names %lld\n\n", iteration, tm, total_names);
+
+		show_dentry_state();
+
+		if (!mkdir_chdir)
+			test_inotify(".");
+	}
+
+	if (chdir(".."))
+		err(2, "chdir");
+
+	if (mkdir_chdir) {
+		printf("leave temporary directory %s\n", dir_name);
+		return 0;
+	}
+
+	printf("removing temporary directory %s\n", dir_name);
+	tm = now();
+	if (rmdir(dir_name))
+		err(2, "rmdir");
+	tm = now() - tm;
+	printf("remove complete in %f seconds\n\n", tm);
+
+	show_dentry_state();
+
+	return 0;
+}

