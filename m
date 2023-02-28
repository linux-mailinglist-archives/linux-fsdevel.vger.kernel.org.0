Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED976A55DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjB1Jdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjB1Jd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:33:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39F1E28F;
        Tue, 28 Feb 2023 01:33:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31E3FB80D3A;
        Tue, 28 Feb 2023 09:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FEC433D2;
        Tue, 28 Feb 2023 09:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576797;
        bh=c9z68q+WdAEZYqVryh8zZBbeNYueFUIM9/Jpow2jaNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ig3GSFl6mH1gtKMNYEwibcAW7JNIHR8jX9SMP4+o1z10djXhgAmdA70qQeTXISQwj
         6kmZOFt/BRo35UGXyT0MyxaJM2gT20Dc/OAvY/sOrQLOkc1UPuDL+3nYvsJ5vey6SW
         78yXIfTc8YS62UD+6vhwCq+Mdh1g8lCRcT44EX9+Sjbv8IAoiTAsjrvxw93aTKTX0i
         jTtDaeU5cvMgDE4B0W/LxBiMBgmc0rCvJv4xKYYwWK/rCxNSmZ6AIcQgPyhCDqQK7X
         GQVQJa8izimvaKUlWPYrb5rvrs0dQg1E9pF77uWyFo0d+kPaNk+ahJXpO+hArWBPYa
         Tvd2HkhnVTk4w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 5/9] selftests/bpf: Add read_buildid function
Date:   Tue, 28 Feb 2023 10:32:02 +0100
Message-Id: <20230228093206.821563-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding read_build_id function that parses out build id from
specified binary.

It will replace extract_build_id and also be used in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/trace_helpers.c | 98 +++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h |  5 ++
 2 files changed, 103 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 09a16a77bae4..c10e16626cd3 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -11,6 +11,9 @@
 #include <linux/perf_event.h>
 #include <sys/mman.h>
 #include "trace_helpers.h"
+#include <linux/limits.h>
+#include <libelf.h>
+#include <gelf.h>
 
 #define DEBUGFS "/sys/kernel/debug/tracing/"
 
@@ -230,3 +233,98 @@ ssize_t get_rel_offset(uintptr_t addr)
 	fclose(f);
 	return -EINVAL;
 }
+
+static int
+parse_build_id_buf(const void *note_start, Elf32_Word note_size,
+		   char *build_id)
+{
+	Elf32_Word note_offs = 0, new_offs;
+
+	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
+		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
+
+		if (nhdr->n_type == 3 &&
+		    nhdr->n_namesz == sizeof("GNU") &&
+		    !strcmp((char *)(nhdr + 1), "GNU") &&
+		    nhdr->n_descsz > 0 &&
+		    nhdr->n_descsz <= BPF_BUILD_ID_SIZE) {
+			memcpy(build_id, note_start + note_offs +
+			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
+			       nhdr->n_descsz);
+			memset(build_id + nhdr->n_descsz, 0,
+			       BPF_BUILD_ID_SIZE - nhdr->n_descsz);
+			return (int) nhdr->n_descsz;
+		}
+
+		new_offs = note_offs + sizeof(Elf32_Nhdr) +
+			   ALIGN(nhdr->n_namesz, 4) + ALIGN(nhdr->n_descsz, 4);
+
+		if (new_offs >= note_size)
+			break;
+		note_offs = new_offs;
+	}
+
+	return -EINVAL;
+}
+
+/* Reads binary from *path* file and returns it in the *build_id*
+ * which is expected to be at least BPF_BUILD_ID_SIZE bytes.
+ * Returns size of build id on success. On error the error value
+ * is returned.
+ */
+int read_build_id(const char *path, char *build_id)
+{
+	int fd, err = -EINVAL;
+	Elf *elf = NULL;
+	GElf_Ehdr ehdr;
+	size_t max, i;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	(void)elf_version(EV_CURRENT);
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (!elf)
+		goto out;
+
+	if (elf_kind(elf) != ELF_K_ELF)
+		goto out;
+
+	if (gelf_getehdr(elf, &ehdr) == NULL)
+		goto out;
+
+	if (ehdr.e_ident[EI_CLASS] != ELFCLASS64)
+		goto out;
+
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		GElf_Phdr mem, *phdr;
+		char *data;
+
+		phdr = gelf_getphdr(elf, i, &mem);
+		if (!phdr)
+			goto out;
+
+		if (phdr->p_type != PT_NOTE)
+			continue;
+
+		data = elf_rawfile(elf, &max);
+		if (!data)
+			goto out;
+
+		if (phdr->p_offset >= max ||
+		   (phdr->p_offset + phdr->p_memsz >= max))
+			goto out;
+
+		err = parse_build_id_buf(data + phdr->p_offset, phdr->p_memsz, build_id);
+		if (err > 0)
+			goto out;
+	}
+
+out:
+	if (elf)
+		elf_end(elf);
+	close(fd);
+	return err;
+}
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 53efde0e2998..50b2cc498ba7 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -4,6 +4,9 @@
 
 #include <bpf/libbpf.h>
 
+#define ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a)-1)
+#define __ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
+
 struct ksym {
 	long addr;
 	char *name;
@@ -23,4 +26,6 @@ void read_trace_pipe(void);
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 
+int read_build_id(const char *path, char *build_id);
+
 #endif
-- 
2.39.2

