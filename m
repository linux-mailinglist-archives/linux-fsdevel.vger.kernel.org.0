Return-Path: <linux-fsdevel+bounces-20095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1998CE04C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62941283D29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB35F84F;
	Fri, 24 May 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAHCnban"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E05BAD7;
	Fri, 24 May 2024 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523868; cv=none; b=FAtFciSgss9pnHe+eRBEqYFnWrDNbHELUOiAnRalhH0WkVv7uvid3ZdzeEZW/a4dARXLlI7OyyRlK5yQnsH9DFBdUXc4OLFjVvG5GlEQpy85mEu/cDvy1VcOer7dR7FFLMfBHkR/In9zAGrP2yhqZBkLYQLN3k4rkNfP1ghstxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523868; c=relaxed/simple;
	bh=NP8+W+bH6pHbXy3KBT/Ddc18s0vHb1N4SFb+qkc6u48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6bYSG9kJBdaj9s+aWUji0D3Evvz9XBxIlpFuZugt1tvRR+LGsDUS7/Mv8YaPj1RZnzNp0JXwjIWLMYg5SHd6Ceh3aSq97qkOL/yD5LoTmZq5eDyVHJWB8ylHMzPi2uZbju/qBWWu0ND96Fogroxz+gg5NnBEa8hMwlo1ZcOI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAHCnban; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A91DC2BBFC;
	Fri, 24 May 2024 04:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716523867;
	bh=NP8+W+bH6pHbXy3KBT/Ddc18s0vHb1N4SFb+qkc6u48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAHCnbanuIpxzidjOzdCoT6YKCXHhtrZ7HtoYGxo+7JPyWuyBQ0E+Y0DZdyNOhgoC
	 cQXVdGlXJlaEs6CqfiIJZwoCFTlYB8Ofb1IjsOHrvwId1+NTVAohkTIKXfIDzAUxcL
	 vPx2jZlkdr4cbUK0TWzjuftXRl7MOA0AbZ8g1M8lrxO7pHGiuMstbVFaIMSjcEjgea
	 N8n4CFi+9FxqGD0r4yT9L/4FDdbyQyij7at5onReGHeWibdF/bBT3eC8kJCd28GTiG
	 dBj1gtWmxBq4rSzTNobi+7nxY0V+r2qtWAQFwSyPBoUmteF+izzUzPlvJW2gtYjOlv
	 KoOj1RI6I1poQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 9/9] selftests/bpf: add simple benchmark tool for /proc/<pid>/maps APIs
Date: Thu, 23 May 2024 21:10:31 -0700
Message-ID: <20240524041032.1048094-10-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a simple tool/benchmark for comparing address "resolution"
logic based on textual /proc/<pid>/maps interface and new binary
ioctl-based PROCMAP_QUERY command.

The tool expects a file with a list of hex addresses, relevant PID, and
then provides control over whether textual or binary ioctl-based ways to
process VMAs should be used.

The overall logic implements as efficient way to do batched processing
of a given set of (unsorted) addresses. We first sort them in increasing
order (remembering their original position to restore original order, if
necessary), and then process all VMAs from /proc/<pid>/maps, matching
addresses to VMAs and calculating file offsets, if matched. For
ioctl-based approach the idea is similar, but is implemented even more
efficiently, requesting only VMAs that cover all given addresses,
skipping all the irrelevant VMAs altogether.

To be able to compare efficiency of both APIs the tool has "benchark" mode.
User provides a number of processing runs to run in a tight loop, only timing
specifically /proc/<pid>/maps parsing and processing parts of the logic.
Address sorting and re-sorting is excluded. This gives a more direct way
to compare ioctl- vs text-based APIs.

We used a medium-sized production application to do representative
benchmark. A bunch of stack traces were captured, resulting in 3244
user space addresses (464 unique ones, but we didn't deduplicate them).
Application itself had 655 VMAs reported in /proc/<pid>/maps.

Averaging time taken to process all addresses 10000 times, showed that:
  - text-based approach took 333 microseconds *per one batch run*;
  - ioctl-based approach took 8 microseconds *per (identical) batch run*.

This gives about ~40x speed up to do exactly the same amount of work
(build IDs were not fetched for ioctl-based benchmark; fetching build
IDs resulted in 2x slowdown compared to no-build-ID case). The ratio
will vary depending on exact set of addresses and how many VMAs they are
mapped to. So 40x isn't something to take for granted, but it does show
possible improvements that are achievable.

I also did an strace run of both cases. In text-based one the tool did
27 read() syscalls, fetching up to 4KB of data in one go (which is
seq_file limitations, bumping the buffer size has no effect, as data is
always capped at 4KB). In comparison, ioctl-based implementation had to
do only 5 ioctl() calls to fetch all relevant VMAs.

It is projected that savings from processing big production applications
would only widen the gap in favor of binary-based querying ioctl API, as
bigger applications will tend to have even more non-executable VMA
mappings relative to executable ones. E.g., one of the larger production
applications in the server fleet has upwards of 20000 VMAs, which would
make benchmark even more unfair to processing /proc/<pid>/maps file.

This tool is implementing one of the patterns of usage, referred to as
"on-demand profiling" use case in the main patch implementing ioctl()
API. perf is an example of the pre-processing pattern in which all (or
all executable) VMAs are loaded and stored for further querying. We
implemented an experimental change to perf to benchmark text-based and
ioctl-based APIs, and in perf benchmarks ioctl-based interface was no
worse than optimized text-based parsing benchmark. Filtering to only
executable VMAs further made ioctl-based benchmarks faster, as perf
would be querying about 1/3 of all VMAs only, compared to the need to
read and parse all of VMAs.

E.g., running `perf bench internals synthesize --mt -M 8`, we are getting.

TEXT-BASED
==========
  # ./perf-parse bench internals synthesize --mt -M 8
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 10238.600 usec (+- 309.656 usec)
      Average num. events: 3744.000 (+- 0.000)
      Average time per event 2.735 usec
    ...
    Number of synthesis threads: 8
      Average synthesis took: 6814.600 usec (+- 149.418 usec)
      Average num. events: 3744.000 (+- 0.000)
      Average time per event 1.820 usec

IOCTL-BASED, FETCHING ALL VMAS
==============================
  # ./perf-ioctl-all bench internals synthesize --mt -M 8
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 9944.800 usec (+- 381.794 usec)
      Average num. events: 3593.000 (+- 0.000)
      Average time per event 2.768 usec
    ...
    Number of synthesis threads: 8
      Average synthesis took: 6598.600 usec (+- 137.503 usec)
      Average num. events: 3595.000 (+- 0.000)
      Average time per event 1.835 usec

IOCTL-BASED, FETCHING EXECUTABLE VMAS
=====================================
  # ./perf-ioctl-exec bench internals synthesize --mt -M 8
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 8539.600 usec (+- 364.875 usec)
      Average num. events: 3569.000 (+- 0.000)
      Average time per event 2.393 usec
    ...
    Number of synthesis threads: 8
      Average synthesis took: 5657.600 usec (+- 107.219 usec)
      Average num. events: 3571.000 (+- 0.000)
      Average time per event 1.584 usec

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/.gitignore     |   1 +
 tools/testing/selftests/bpf/Makefile       |   2 +-
 tools/testing/selftests/bpf/procfs_query.c | 386 +++++++++++++++++++++
 3 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/procfs_query.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 5025401323af..903b14931bfe 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -44,6 +44,7 @@ test_cpp
 /veristat
 /sign-file
 /uprobe_multi
+/procfs_query
 *.ko
 *.tmp
 xskxceiver
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e0b3887b3d2d..0afa667a54e5 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko procfs_query
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
diff --git a/tools/testing/selftests/bpf/procfs_query.c b/tools/testing/selftests/bpf/procfs_query.c
new file mode 100644
index 000000000000..63e06568f1ff
--- /dev/null
+++ b/tools/testing/selftests/bpf/procfs_query.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <argp.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <time.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <time.h>
+
+static bool verbose;
+static bool quiet;
+static bool use_ioctl;
+static bool request_build_id;
+static char *addrs_path;
+static int pid;
+static int bench_runs;
+
+const char *argp_program_version = "procfs_query 0.0";
+const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
+
+static inline uint64_t get_time_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+
+	return (uint64_t)t.tv_sec * 1000000000 + t.tv_nsec;
+}
+
+static const struct argp_option opts[] = {
+	{ "verbose", 'v', NULL, 0, "Verbose mode" },
+	{ "quiet", 'q', NULL, 0, "Quiet mode (no output)" },
+	{ "pid", 'p', "PID", 0, "PID of the process" },
+	{ "addrs-path", 'f', "PATH", 0, "File with addresses to resolve" },
+	{ "benchmark", 'B', "RUNS", 0, "Benchmark mode" },
+	{ "query", 'Q', NULL, 0, "Use ioctl()-based point query API (by default text parsing is done)" },
+	{ "build-id", 'b', NULL, 0, "Fetch build ID, if available (only for ioctl mode)" },
+	{},
+};
+
+static error_t parse_arg(int key, char *arg, struct argp_state *state)
+{
+	switch (key) {
+	case 'v':
+		verbose = true;
+		break;
+	case 'q':
+		quiet = true;
+		break;
+	case 'Q':
+		use_ioctl = true;
+		break;
+	case 'b':
+		request_build_id = true;
+		break;
+	case 'p':
+		pid = strtol(arg, NULL, 10);
+		break;
+	case 'f':
+		addrs_path = strdup(arg);
+		break;
+	case 'B':
+		bench_runs = strtol(arg, NULL, 10);
+		if (bench_runs <= 0) {
+			fprintf(stderr, "Invalid benchmark run count: %s\n", arg);
+			return -EINVAL;
+		}
+		break;
+	case ARGP_KEY_ARG:
+		argp_usage(state);
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+static const struct argp argp = {
+	.options = opts,
+	.parser = parse_arg,
+};
+
+struct addr {
+	unsigned long long addr;
+	int idx;
+};
+
+static struct addr *addrs;
+static size_t addr_cnt, addr_cap;
+
+struct resolved_addr {
+	unsigned long long file_off;
+	const char *vma_name;
+	int build_id_sz;
+	char build_id[20];
+};
+
+static struct resolved_addr *resolved;
+
+static int resolve_addrs_ioctl(void)
+{
+	char buf[32], build_id_buf[20], vma_name[PATH_MAX];
+	struct procmap_query q;
+	int fd, err, i;
+	struct addr *a = &addrs[0];
+	struct resolved_addr *r;
+
+	snprintf(buf, sizeof(buf), "/proc/%d/maps", pid);
+	fd = open(buf, O_RDONLY);
+	if (fd < 0) {
+		err = -errno;
+		fprintf(stderr, "Failed to open process map file (%s): %d\n", buf, err);
+		return err;
+	}
+
+	memset(&q, 0, sizeof(q));
+	q.size = sizeof(q);
+	q.query_flags = PROCMAP_QUERY_COVERING_OR_NEXT_VMA;
+	q.vma_name_addr = (__u64)vma_name;
+	if (request_build_id)
+		q.build_id_addr = (__u64)build_id_buf;
+
+	for (i = 0; i < addr_cnt; ) {
+		char *name = NULL;
+
+		q.query_addr = (__u64)a->addr;
+		q.vma_name_size = sizeof(vma_name);
+		if (request_build_id)
+			q.build_id_size = sizeof(build_id_buf);
+
+		err = ioctl(fd, PROCMAP_QUERY, &q);
+		if (err < 0 && errno == ENOTTY) {
+			close(fd);
+			fprintf(stderr, "PROCMAP_QUERY ioctl() command is not supported on this kernel!\n");
+			return -EOPNOTSUPP; /* ioctl() not implemented yet */
+		}
+		if (err < 0 && errno == ENOENT) {
+			fprintf(stderr, "ENOENT addr %lx\n", (long)q.query_addr);
+			i++;
+			a++;
+			continue; /* unresolved address */
+		}
+		if (err < 0) {
+			err = -errno;
+			close(fd);
+			fprintf(stderr, "PROCMAP_QUERY ioctl() returned error: %d\n", err);
+			return err;
+		}
+
+		if (verbose) {
+			printf("VMA FOUND (addr %08lx): %08lx-%08lx %c%c%c%c %08lx %02x:%02x %ld %s (build ID: %s, %d bytes)\n",
+			       (long)q.query_addr, (long)q.vma_start, (long)q.vma_end,
+			       (q.vma_flags & PROCMAP_QUERY_VMA_READABLE) ? 'r' : '-',
+			       (q.vma_flags & PROCMAP_QUERY_VMA_WRITABLE) ? 'w' : '-',
+			       (q.vma_flags & PROCMAP_QUERY_VMA_EXECUTABLE) ? 'x' : '-',
+			       (q.vma_flags & PROCMAP_QUERY_VMA_SHARED) ? 's' : 'p',
+			       (long)q.vma_offset, q.dev_major, q.dev_minor, (long)q.inode,
+			       q.vma_name_size ? vma_name : "",
+			       q.build_id_size ? "YES" : "NO",
+			       q.build_id_size);
+		}
+
+		/* skip addrs falling before current VMA */
+		for (; i < addr_cnt && a->addr < q.vma_start; i++, a++) {
+		}
+		/* process addrs covered by current VMA */
+		for (; i < addr_cnt && a->addr < q.vma_end; i++, a++) {
+			r = &resolved[a->idx];
+			r->file_off = a->addr - q.vma_start + q.vma_offset;
+
+			/* reuse name, if it was already strdup()'ed */
+			if (q.vma_name_size)
+				name = name ?: strdup(vma_name);
+			r->vma_name = name;
+
+			if (q.build_id_size) {
+				r->build_id_sz = q.build_id_size;
+				memcpy(r->build_id, build_id_buf, q.build_id_size);
+			}
+		}
+	}
+
+	close(fd);
+	return 0;
+}
+
+static int resolve_addrs_parse(void)
+{
+	size_t vma_start, vma_end, vma_offset, ino;
+	uint32_t dev_major, dev_minor;
+	char perms[4], buf[32], vma_name[PATH_MAX], fbuf[4096];
+	FILE *f;
+	int err, idx = 0;
+	struct addr *a = &addrs[idx];
+	struct resolved_addr *r;
+
+	snprintf(buf, sizeof(buf), "/proc/%d/maps", pid);
+	f = fopen(buf, "r");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open process map file (%s): %d\n", buf, err);
+		return err;
+	}
+
+	err = setvbuf(f, fbuf, _IOFBF, sizeof(fbuf));
+	if (err) {
+		err = -errno;
+		fprintf(stderr, "Failed to set custom file buffer size: %d\n", err);
+		return err;
+	}
+
+	while ((err = fscanf(f, "%zx-%zx %c%c%c%c %zx %x:%x %zu %[^\n]\n",
+			     &vma_start, &vma_end,
+			     &perms[0], &perms[1], &perms[2], &perms[3],
+			     &vma_offset, &dev_major, &dev_minor, &ino, vma_name)) >= 10) {
+		const char *name = NULL;
+
+		/* skip addrs before current vma, they stay unresolved */
+		for (; idx < addr_cnt && a->addr < vma_start; idx++, a++) {
+		}
+
+		/* resolve all addrs within current vma now */
+		for (; idx < addr_cnt && a->addr < vma_end; idx++, a++) {
+			r = &resolved[a->idx];
+			r->file_off = a->addr - vma_start + vma_offset;
+
+			/* reuse name, if it was already strdup()'ed */
+			if (err > 10)
+				name = name ?: strdup(vma_name);
+			else
+				name = NULL;
+			r->vma_name = name;
+		}
+
+		/* ran out of addrs to resolve, stop early */
+		if (idx >= addr_cnt)
+			break;
+	}
+
+	fclose(f);
+	return 0;
+}
+
+static int cmp_by_addr(const void *a, const void *b)
+{
+	const struct addr *x = a, *y = b;
+
+	if (x->addr != y->addr)
+		return x->addr < y->addr ? -1 : 1;
+	return x->idx < y->idx ? -1 : 1;
+}
+
+static int cmp_by_idx(const void *a, const void *b)
+{
+	const struct addr *x = a, *y = b;
+
+	return x->idx < y->idx ? -1 : 1;
+}
+
+int main(int argc, char **argv)
+{
+	FILE* f;
+	int err, i;
+	unsigned long long addr;
+	uint64_t start_ns;
+	double total_ns;
+
+	/* Parse command line arguments */
+	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
+	if (err)
+		return err;
+
+	if (pid <= 0 || !addrs_path) {
+		fprintf(stderr, "Please provide PID and file with addresses to process!\n");
+		exit(1);
+	}
+
+	if (verbose) {
+		fprintf(stderr, "PID: %d\n", pid);
+		fprintf(stderr, "PATH: %s\n", addrs_path);
+	}
+
+	f = fopen(addrs_path, "r");
+	if (!f) {
+		err = -errno;
+		fprintf(stderr, "Failed to open '%s': %d\n", addrs_path, err);
+		goto out;
+	}
+
+	while ((err = fscanf(f, "%llx\n", &addr)) == 1) {
+		if (addr_cnt == addr_cap) {
+			addr_cap = addr_cap == 0 ? 16 : (addr_cap * 3 / 2);
+			addrs = realloc(addrs, sizeof(*addrs) * addr_cap);
+			memset(addrs + addr_cnt, 0, (addr_cap - addr_cnt) * sizeof(*addrs));
+		}
+
+		addrs[addr_cnt].addr = addr;
+		addrs[addr_cnt].idx = addr_cnt;
+
+		addr_cnt++;
+	}
+	if (verbose)
+		fprintf(stderr, "READ %zu addrs!\n", addr_cnt);
+	if (!feof(f)) {
+		fprintf(stderr, "Failure parsing full list of addresses at '%s'!\n", addrs_path);
+		err = -EINVAL;
+		fclose(f);
+		goto out;
+	}
+	fclose(f);
+	if (addr_cnt == 0) {
+		fprintf(stderr, "No addresses provided, bailing out!\n");
+		err = -ENOENT;
+		goto out;
+	}
+
+	resolved = calloc(addr_cnt, sizeof(*resolved));
+
+	qsort(addrs, addr_cnt, sizeof(*addrs), cmp_by_addr);
+	if (verbose) {
+		fprintf(stderr, "SORTED ADDRS (%zu):\n", addr_cnt);
+		for (i = 0; i < addr_cnt; i++) {
+			fprintf(stderr, "ADDR #%d: %#llx\n", addrs[i].idx, addrs[i].addr);
+		}
+	}
+
+	start_ns = get_time_ns();
+	for (i = bench_runs ?: 1; i > 0; i--) {
+		if (use_ioctl) {
+			err = resolve_addrs_ioctl();
+		} else {
+			err = resolve_addrs_parse();
+		}
+		if (err) {
+			fprintf(stderr, "Failed to resolve addrs: %d!\n", err);
+			goto out;
+		}
+	}
+	total_ns = get_time_ns() - start_ns;
+
+	if (bench_runs) {
+		fprintf(stderr, "BENCHMARK MODE. RUNS: %d TOTAL TIME (ms): %.3lf TIME/RUN (ms): %.3lf TIME/ADDR (us): %.3lf\n",
+			bench_runs, total_ns / 1000000.0, total_ns / bench_runs / 1000000.0,
+			total_ns / bench_runs / addr_cnt / 1000.0);
+	}
+
+	/* sort them back into the original order */
+	qsort(addrs, addr_cnt, sizeof(*addrs), cmp_by_idx);
+
+	if (!quiet) {
+		printf("RESOLVED ADDRS (%zu):\n", addr_cnt);
+		for (i = 0; i < addr_cnt; i++) {
+			const struct addr *a = &addrs[i];
+			const struct resolved_addr *r = &resolved[a->idx];
+
+			if (r->file_off) {
+				printf("RESOLVED   #%d: %#llx -> OFF %#llx",
+					a->idx, a->addr, r->file_off);
+				if (r->vma_name)
+					printf(" NAME %s", r->vma_name);
+				if (r->build_id_sz) {
+					char build_id_str[41];
+					int j;
+
+					for (j = 0; j < r->build_id_sz; j++)
+						sprintf(&build_id_str[j * 2], "%02hhx", r->build_id[j]);
+					printf(" BUILDID %s", build_id_str);
+				}
+				printf("\n");
+			} else {
+				printf("UNRESOLVED #%d: %#llx\n", a->idx, a->addr);
+			}
+		}
+	}
+out:
+	free(addrs);
+	free(addrs_path);
+	free(resolved);
+
+	return err < 0 ? -err : 0;
+}
-- 
2.43.0


