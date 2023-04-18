Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF456E56FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjDRBou (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDRBnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:43:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA384201
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fd5d0ad7cso104349067b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782132; x=1684374132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk7KbeOo8rhdSgTgXnHyow+gqIED12sjelCBSds/WYg=;
        b=N5opq6WcCzz8RaETiMvJHlpqhJ0gaPR36LASZdNjZdjznRLjsv7TOeO2HlNcQyFJ57
         tjT0EfFA9PwM25junTv4yMCuAz+UK6Fe0yyC8OEn8mUlb3o5wcNe4pTD23fyCvyTnaeY
         fxHyoPj4F2NgwqIM3OkzDFAwYGKeB2ZDzh/xmLiFqnG6ZNlfniopKfucgCx7zkZdvcUg
         id9wnl9fjuSs+ArZZzIMczPlNM8kMd1YBRJMExFtaAE+FCOYE5eZm65uRomYLebS63PF
         0OIbviFZzbeMldjlHj0vf5B0aZhn2ym2vbEm4q6DcLjlnzUuvqaaNvYNveMRWHovpvpl
         HCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782132; x=1684374132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk7KbeOo8rhdSgTgXnHyow+gqIED12sjelCBSds/WYg=;
        b=bETvMJYUO09VMeRdqqFWPYR/DRi/3TSeXV3blm8H7gI2+hkm+7zQYrPOYjhB775cTT
         VspjUhQvM4CAUbq0TPwGc2uue4C1MDPwR8KF9tHFrzvznmkd3ikdyzIFvCC0hVRhsZIR
         Oy9HN5yWWl/ql6fpcumO4TXTFdWjNt4EAR78VmucvfQpJSsb7oxKZOin704GPv1eO5PO
         6L3P7JgWg+nQAXbqY44S6e2s79HNwjL6460B9CvDfvjiqLnfdjf5DPuS3l+6w3TKit7S
         xBigAIQ/I7BZJVyB1T95MoaT7GGjGA54yyGF6kFCiSKXNUuusiPZuUH2FIzhvgml/b74
         icsA==
X-Gm-Message-State: AAQBX9c3yWngBpkMf6U5cWn3q6xoqmGEIlu90Yc+4tteeLJFgRTY6Pq7
        xj83hw8RiXOwMqA5ahVlyOEE6gCu/OQ=
X-Google-Smtp-Source: AKy350ZgL/jsllSontpbaAxiQgyNNKAA4k0sDxqfSe/h20gFKUGZlWmnWMvj8iaNFQgkF086PipsFDr1g4Y=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:ac1a:0:b0:544:bce8:980f with SMTP id
 k26-20020a81ac1a000000b00544bce8980fmr10886637ywh.6.1681782132472; Mon, 17
 Apr 2023 18:42:12 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:36 -0700
In-Reply-To: <20230418014037.2412394-1-drosen@google.com>
Mime-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-37-drosen@google.com>
Subject: [RFC PATCH v3 36/37] fuse-bpf: Add selftests
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adds basic selftests for fuse. These check that you can add fuse_op
programs, and perform basic operations

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
Signed-off-by: Alessio Balsini <balsini@google.com>

---
 .../selftests/filesystems/fuse/.gitignore     |    2 +
 .../selftests/filesystems/fuse/Makefile       |  188 ++
 .../testing/selftests/filesystems/fuse/OWNERS |    2 +
 .../selftests/filesystems/fuse/bpf_common.h   |   51 +
 .../selftests/filesystems/fuse/bpf_loader.c   |  597 ++++
 .../testing/selftests/filesystems/fuse/fd.txt |   21 +
 .../selftests/filesystems/fuse/fd_bpf.bpf.c   |  397 +++
 .../selftests/filesystems/fuse/fuse_daemon.c  |  300 ++
 .../selftests/filesystems/fuse/fuse_test.c    | 2412 +++++++++++++++++
 .../selftests/filesystems/fuse/test.bpf.c     |  996 +++++++
 .../filesystems/fuse/test_framework.h         |  172 ++
 .../selftests/filesystems/fuse/test_fuse.h    |  494 ++++
 12 files changed, 5632 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_common.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_framework.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h

diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
new file mode 100644
index 000000000000..3ee9a27fe66a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -0,0 +1,2 @@
+fuse_test
+*.raw
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
new file mode 100644
index 000000000000..b2df4dec0651
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
@@ -0,0 +1,188 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../../../../build/Build.include
+include ../../../../scripts/Makefile.arch
+include ../../../../scripts/Makefile.include
+
+#if 0
+ifneq ($(LLVM),)
+ifneq ($(filter %/,$(LLVM)),)
+LLVM_PREFIX := $(LLVM)
+else ifneq ($(filter -%,$(LLVM)),)
+LLVM_SUFFIX := $(LLVM)
+endif
+
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+#endif
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+else
+CC := $(CROSS_COMPILE)gcc
+endif # LLVM
+
+CURDIR := $(abspath .)
+TOOLSDIR := $(abspath ../../../..)
+LIBDIR := $(TOOLSDIR)/lib
+BPFDIR := $(LIBDIR)/bpf
+TOOLSINCDIR := $(TOOLSDIR)/include
+BPFTOOLDIR := $(TOOLSDIR)/bpf/bpftool
+APIDIR := $(TOOLSINCDIR)/uapi
+GENDIR := $(abspath ../../../../../include/generated)
+GENHDR := $(GENDIR)/autoconf.h
+SELFTESTS:=$(TOOLSDIR)/testing/selftests/
+
+LDLIBS := -lpthread -lelf -lz
+TEST_GEN_PROGS := fuse_test fuse_daemon
+TEST_GEN_FILES := \
+	test.skel.h \
+	fd.sh \
+
+include ../../lib.mk
+
+# Put after include ../../lib.mk since that changes $(TEST_GEN_PROGS)
+# Otherwise you get multiple targets, this becomes the default, and it's a mess
+EXTRA_SOURCES := bpf_loader.c $(OUTPUT)/test.skel.h
+$(TEST_GEN_PROGS) : $(EXTRA_SOURCES) $(BPFOBJ)
+
+SCRATCH_DIR := $(OUTPUT)/tools
+BUILD_DIR := $(SCRATCH_DIR)/build
+INCLUDE_DIR := $(SCRATCH_DIR)/include
+BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
+SKEL_DIR := $(OUTPUT)
+ifneq ($(CROSS_COMPILE),)
+HOST_BUILD_DIR		:= $(BUILD_DIR)/host
+HOST_SCRATCH_DIR	:= host-tools
+HOST_INCLUDE_DIR	:= $(HOST_SCRATCH_DIR)/include
+else
+HOST_BUILD_DIR		:= $(BUILD_DIR)
+HOST_SCRATCH_DIR	:= $(SCRATCH_DIR)
+HOST_INCLUDE_DIR	:= $(INCLUDE_DIR)
+endif
+HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
+RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
+DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
+
+VMLINUX_BTF_PATHS ?= $(if $(OUTPUT),$(OUTPUT)/../../../../../vmlinux)		\
+		     $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)		\
+		     ../../../../../vmlinux					\
+		     /sys/kernel/btf/vmlinux					\
+		     /boot/vmlinux-$(shell uname -r)
+VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(VMLINUX_BTF),)
+$(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
+endif
+
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+
+ifneq ($(wildcard $(GENHDR)),)
+  GENFLAGS := -DHAVE_GENHDR
+endif
+
+CFLAGS += -g -O2 -rdynamic -pthread -Wall -Werror $(GENFLAGS)			\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)				\
+	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(SELFTESTS)				\
+	  -I$(SKEL_DIR)
+
+# Silence some warnings when compiled with clang
+ifneq ($(LLVM),)
+CFLAGS += -Wno-unused-command-line-argument
+endif
+
+#LDFLAGS = -lelf -lz
+
+IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null |				\
+			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
+
+# Get Clang's default includes on this system, as opposed to those seen by
+# '-target bpf'. This fixes "missing" files on some architectures/distros,
+# such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
+#
+# Use '-idirafter': Don't interfere with include mechanics except where the
+# build would have failed anyways.
+define get_sys_includes
+$(shell $(1) -v -E - </dev/null 2>&1 \
+	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
+$(shell $(1) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}')
+endef
+
+BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
+	     $(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)		\
+	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)				\
+	     -I../../../../../include						\
+	     $(call get_sys_includes,$(CLANG))					\
+	     -Wno-compare-distinct-pointer-types				\
+	     -O2 -mcpu=v3
+
+# sort removes libbpf duplicates when not cross-building
+MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
+	       $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids	\
+	       $(INCLUDE_DIR))
+
+$(MAKE_DIRS):
+	$(call msg,MKDIR,,$@)
+	$(Q)mkdir -p $@
+
+$(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)			\
+	   $(APIDIR)/linux/bpf.h						\
+	   | $(BUILD_DIR)/libbpf
+	$(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/	\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
+
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
+		    $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
+	$(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)				\
+		    ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD)		\
+		    EXTRA_CFLAGS='-g -O0'					\
+		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/				\
+		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/			\
+		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/				\
+		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
+
+$(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
+ifeq ($(VMLINUX_H),)
+	$(call msg,GEN,,$@)
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+else
+	$(call msg,CP,,$@)
+	$(Q)cp "$(VMLINUX_H)" $@
+endif
+
+$(OUTPUT)/fuse_daemon: LDLIBS := $(HOST_BPFOBJ) $(LDLIBS)
+$(OUTPUT)/fuse_test: LDLIBS := $(HOST_BPFOBJ) $(LDLIBS)
+
+$(OUTPUT)/%.bpf.o: %.bpf.c $(INCLUDE_DIR)/vmlinux.h	\
+	| $(BPFOBJ)
+	$(call msg,CLNG-BPF,,$@)
+	$(Q)$(CLANG) $(BPF_CFLAGS) -target bpf -c $< -o $@
+
+$(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o $(BPFTOOL)
+	$(call msg,GEN-SKEL,,$@)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked1.o) $<
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked2.o) $(<:.o=.linked1.o)
+	$(Q)$(BPFTOOL) gen object $(<:.o=.linked3.o) $(<:.o=.linked2.o)
+	$(Q)diff $(<:.o=.linked2.o) $(<:.o=.linked3.o)
+	$(Q)$(BPFTOOL) gen skeleton $(<:.o=.linked3.o) name $(notdir $(<:.bpf.o=))_bpf > $@
+	$(Q)$(BPFTOOL) gen subskeleton $(<:.o=.linked3.o) name $(notdir $(<:.bpf.o=))_bpf > $(@:.skel.h=.subskel.h)
+
+$(OUTPUT)/fd.sh: fd.txt
+	cp $< $@
+	chmod 755 $@
diff --git a/tools/testing/selftests/filesystems/fuse/OWNERS b/tools/testing/selftests/filesystems/fuse/OWNERS
new file mode 100644
index 000000000000..5eb371e1a5a3
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/OWNERS
@@ -0,0 +1,2 @@
+# include OWNERS from the authoritative android-mainline branch
+include kernel/common:android-mainline:/tools/testing/selftests/filesystems/incfs/OWNERS
diff --git a/tools/testing/selftests/filesystems/fuse/bpf_common.h b/tools/testing/selftests/filesystems/fuse/bpf_common.h
new file mode 100644
index 000000000000..dcf9efaef0f4
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/bpf_common.h
@@ -0,0 +1,51 @@
+// TODO: Insert description here. (generated by drosen)
+
+#ifndef _BPF_COMMON_H_
+#define _BPF_COMMON_H_
+
+/* Return Codes for Fuse BPF programs */
+#define BPF_FUSE_CONTINUE		0
+#define BPF_FUSE_USER			1
+#define BPF_FUSE_USER_PREFILTER		2
+#define BPF_FUSE_POSTFILTER		3
+#define BPF_FUSE_USER_POSTFILTER	4
+
+enum fuse_bpf_type {
+	FUSE_ENTRY_BACKING		= 1,
+	FUSE_ENTRY_BPF			= 2,
+	FUSE_ENTRY_REMOVE_BACKING	= 3,
+	FUSE_ENTRY_REMOVE_BPF		= 4,
+};
+
+#define BPF_FUSE_NAME_MAX 15
+struct fuse_bpf_entry_out {
+	uint32_t	entry_type;
+	uint32_t	unused;
+	union {
+		struct {
+			uint64_t unused2;
+			uint64_t fd;
+		};
+		char name[BPF_FUSE_NAME_MAX + 1];
+	};
+};
+
+/* Op Code Filter values for BPF Programs */
+#define FUSE_OPCODE_FILTER	0x0ffff
+#define FUSE_PREFILTER		0x10000
+#define FUSE_POSTFILTER		0x20000
+
+#define BPF_FUSE_NAME_MAX 15
+
+#define BPF_STRUCT_OPS(type, name, args...)					\
+SEC("struct_ops/"#name)								\
+type BPF_PROG(name, ##args)
+
+/* available kfuncs for fuse_bpf */
+extern uint32_t bpf_fuse_return_len(struct fuse_buffer *ptr) __ksym;
+extern void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dynptr *dynptr, u64 size, bool copy) __ksym;
+extern void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct bpf_dynptr *dynptr) __ksym;
+extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, u32 offset, void *buffer, u32 buffer__szk) __ksym;
+extern void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *ptr, u32 offset, void *buffer, u32 buffer__szk) __ksym;
+
+#endif /* _BPF_COMMON_H_ */
diff --git a/tools/testing/selftests/filesystems/fuse/bpf_loader.c b/tools/testing/selftests/filesystems/fuse/bpf_loader.c
new file mode 100644
index 000000000000..ebcced7f9430
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/bpf_loader.c
@@ -0,0 +1,597 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+
+#include "test_fuse.h"
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <gelf.h>
+#include <libelf.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/xattr.h>
+
+#include <linux/unistd.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+struct _test_options test_options;
+
+struct s s(const char *s1)
+{
+	struct s s = {0};
+
+	if (!s1)
+		return s;
+
+	s.s = malloc(strlen(s1) + 1);
+	if (!s.s)
+		return s;
+
+	strcpy(s.s, s1);
+	return s;
+}
+
+struct s sn(const char *s1, const char *s2)
+{
+	struct s s = {0};
+
+	if (!s1)
+		return s;
+
+	s.s = malloc(s2 - s1 + 1);
+	if (!s.s)
+		return s;
+
+	strncpy(s.s, s1, s2 - s1);
+	s.s[s2 - s1] = 0;
+	return s;
+}
+
+int s_cmp(struct s s1, struct s s2)
+{
+	int result = -1;
+
+	if (!s1.s || !s2.s)
+		goto out;
+	result = strcmp(s1.s, s2.s);
+out:
+	free(s1.s);
+	free(s2.s);
+	return result;
+}
+
+struct s s_cat(struct s s1, struct s s2)
+{
+	struct s s = {0};
+
+	if (!s1.s || !s2.s)
+		goto out;
+
+	s.s = malloc(strlen(s1.s) + strlen(s2.s) + 1);
+	if (!s.s)
+		goto out;
+
+	strcpy(s.s, s1.s);
+	strcat(s.s, s2.s);
+out:
+	free(s1.s);
+	free(s2.s);
+	return s;
+}
+
+struct s s_splitleft(struct s s1, char c)
+{
+	struct s s = {0};
+	char *split;
+
+	if (!s1.s)
+		return s;
+
+	split = strchr(s1.s, c);
+	if (split)
+		s = sn(s1.s, split);
+
+	free(s1.s);
+	return s;
+}
+
+struct s s_splitright(struct s s1, char c)
+{
+	struct s s2 = {0};
+	char *split;
+
+	if (!s1.s)
+		return s2;
+
+	split = strchr(s1.s, c);
+	if (split)
+		s2 = s(split + 1);
+
+	free(s1.s);
+	return s2;
+}
+
+struct s s_word(struct s s1, char c, size_t n)
+{
+	while (n--)
+		s1 = s_splitright(s1, c);
+	return s_splitleft(s1, c);
+}
+
+struct s s_path(struct s s1, struct s s2)
+{
+	return s_cat(s_cat(s1, s("/")), s2);
+}
+
+struct s s_pathn(size_t n, struct s s1, ...)
+{
+	va_list argp;
+
+	va_start(argp, s1);
+	while (--n)
+		s1 = s_path(s1, va_arg(argp, struct s));
+	va_end(argp);
+	return s1;
+}
+
+int s_link(struct s src_pathname, struct s dst_pathname)
+{
+	int res;
+
+	if (src_pathname.s && dst_pathname.s) {
+		res = link(src_pathname.s, dst_pathname.s);
+	} else {
+		res = -1;
+		errno = ENOMEM;
+	}
+
+	free(src_pathname.s);
+	free(dst_pathname.s);
+	return res;
+}
+
+int s_symlink(struct s src_pathname, struct s dst_pathname)
+{
+	int res;
+
+	if (src_pathname.s && dst_pathname.s) {
+		res = symlink(src_pathname.s, dst_pathname.s);
+	} else {
+		res = -1;
+		errno = ENOMEM;
+	}
+
+	free(src_pathname.s);
+	free(dst_pathname.s);
+	return res;
+}
+
+
+int s_mkdir(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = mkdir(pathname.s, mode);
+	free(pathname.s);
+	return res;
+}
+
+int s_rmdir(struct s pathname)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = rmdir(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_unlink(struct s pathname)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = unlink(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_open(struct s pathname, int flags, ...)
+{
+	va_list ap;
+	int res;
+
+	va_start(ap, flags);
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	if (flags & (O_CREAT | O_TMPFILE))
+		res = open(pathname.s, flags, va_arg(ap, mode_t));
+	else
+		res = open(pathname.s, flags);
+
+	free(pathname.s);
+	va_end(ap);
+	return res;
+}
+
+int s_openat(int dirfd, struct s pathname, int flags, ...)
+{
+	va_list ap;
+	int res;
+
+	va_start(ap, flags);
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	if (flags & (O_CREAT | O_TMPFILE))
+		res = openat(dirfd, pathname.s, flags, va_arg(ap, mode_t));
+	else
+		res = openat(dirfd, pathname.s, flags);
+
+	free(pathname.s);
+	va_end(ap);
+	return res;
+}
+
+int s_creat(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = open(pathname.s, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode);
+	free(pathname.s);
+	return res;
+}
+
+int s_mkfifo(struct s pathname, mode_t mode)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = mknod(pathname.s, S_IFIFO | mode, 0);
+	free(pathname.s);
+	return res;
+}
+
+int s_stat(struct s pathname, struct stat *st)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = stat(pathname.s, st);
+	free(pathname.s);
+	return res;
+}
+
+int s_statfs(struct s pathname, struct statfs *st)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = statfs(pathname.s, st);
+	free(pathname.s);
+	return res;
+}
+
+DIR *s_opendir(struct s pathname)
+{
+	DIR *res;
+
+	res = opendir(pathname.s);
+	free(pathname.s);
+	return res;
+}
+
+int s_getxattr(struct s pathname, const char name[], void *value, size_t size,
+	       ssize_t *ret_size)
+{
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	*ret_size = getxattr(pathname.s, name, value, size);
+	free(pathname.s);
+	return *ret_size >= 0 ? 0 : -1;
+}
+
+int s_listxattr(struct s pathname, void *list, size_t size, ssize_t *ret_size)
+{
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	*ret_size = listxattr(pathname.s, list, size);
+	free(pathname.s);
+	return *ret_size >= 0 ? 0 : -1;
+}
+
+int s_setxattr(struct s pathname, const char name[], const void *value, size_t size, int flags)
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = setxattr(pathname.s, name, value, size, flags);
+	free(pathname.s);
+	return res;
+}
+
+int s_removexattr(struct s pathname, const char name[])
+{
+	int res;
+
+	if (!pathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = removexattr(pathname.s, name);
+	free(pathname.s);
+	return res;
+}
+
+int s_rename(struct s oldpathname, struct s newpathname)
+{
+	int res;
+
+	if (!oldpathname.s || !newpathname.s) {
+		errno = ENOMEM;
+		return -1;
+	}
+
+	res = rename(oldpathname.s, newpathname.s);
+	free(oldpathname.s);
+	free(newpathname.s);
+	return res;
+}
+
+int s_fuse_attr(struct s pathname, struct fuse_attr *fuse_attr_out)
+{
+
+	struct stat st;
+	int result = TEST_FAILURE;
+
+	TESTSYSCALL(s_stat(pathname, &st));
+
+	fuse_attr_out->ino = st.st_ino;
+	fuse_attr_out->mode = st.st_mode;
+	fuse_attr_out->nlink = st.st_nlink;
+	fuse_attr_out->uid = st.st_uid;
+	fuse_attr_out->gid = st.st_gid;
+	fuse_attr_out->rdev = st.st_rdev;
+	fuse_attr_out->size = st.st_size;
+	fuse_attr_out->blksize = st.st_blksize;
+	fuse_attr_out->blocks = st.st_blocks;
+	fuse_attr_out->atime = st.st_atime;
+	fuse_attr_out->mtime = st.st_mtime;
+	fuse_attr_out->ctime = st.st_ctime;
+	fuse_attr_out->atimensec = UINT32_MAX;
+	fuse_attr_out->mtimensec = UINT32_MAX;
+	fuse_attr_out->ctimensec = UINT32_MAX;
+
+	result = TEST_SUCCESS;
+out:
+	return result;
+}
+
+struct s tracing_folder(void)
+{
+	struct s trace = {0};
+	FILE *mounts = NULL;
+	char *line = NULL;
+	size_t size = 0;
+
+	TEST(mounts = fopen("/proc/mounts", "re"), mounts);
+	while (getline(&line, &size, mounts) != -1) {
+		if (!s_cmp(s_word(sn(line, line + size), ' ', 2),
+			   s("tracefs"))) {
+			trace = s_word(sn(line, line + size), ' ', 1);
+			break;
+		}
+
+		if (!s_cmp(s_word(sn(line, line + size), ' ', 2), s("debugfs")))
+			trace = s_path(s_word(sn(line, line + size), ' ', 1),
+				       s("tracing"));
+	}
+
+out:
+	free(line);
+	fclose(mounts);
+	return trace;
+}
+
+int tracing_on(void)
+{
+	int result = TEST_FAILURE;
+	int tracing_on = -1;
+
+	TEST(tracing_on = s_open(s_path(tracing_folder(), s("tracing_on")),
+				 O_WRONLY | O_CLOEXEC),
+	     tracing_on != -1);
+	TESTEQUAL(write(tracing_on, "1", 1), 1);
+	result = TEST_SUCCESS;
+out:
+	close(tracing_on);
+	return result;
+}
+
+char *concat_file_name(const char *dir, const char *file)
+{
+	char full_name[FILENAME_MAX] = "";
+
+	if (snprintf(full_name, ARRAY_SIZE(full_name), "%s/%s", dir, file) < 0)
+		return NULL;
+	return strdup(full_name);
+}
+
+char *setup_mount_dir(const char *name)
+{
+	struct stat st;
+	char *current_dir = getcwd(NULL, 0);
+	char *mount_dir = concat_file_name(current_dir, name);
+
+	free(current_dir);
+	if (stat(mount_dir, &st) == 0) {
+		if (S_ISDIR(st.st_mode))
+			return mount_dir;
+
+		ksft_print_msg("%s is a file, not a dir.\n", mount_dir);
+		return NULL;
+	}
+
+	if (mkdir(mount_dir, 0777)) {
+		ksft_print_msg("Can't create mount dir.");
+		return NULL;
+	}
+
+	return mount_dir;
+}
+
+int delete_dir_tree(const char *dir_path, bool remove_root)
+{
+	DIR *dir = NULL;
+	struct dirent *dp;
+	int result = 0;
+
+	dir = opendir(dir_path);
+	if (!dir) {
+		result = -errno;
+		goto out;
+	}
+
+	while ((dp = readdir(dir))) {
+		char *full_path;
+
+		if (!strcmp(dp->d_name, ".") || !strcmp(dp->d_name, ".."))
+			continue;
+
+		full_path = concat_file_name(dir_path, dp->d_name);
+		if (dp->d_type == DT_DIR)
+			result = delete_dir_tree(full_path, true);
+		else
+			result = unlink(full_path);
+		free(full_path);
+		if (result)
+			goto out;
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	if (!result && remove_root)
+		rmdir(dir_path);
+	return result;
+}
+
+static int mount_fuse_maybe_init(const char *mount_dir, const char *bpf_name, int dir_fd,
+			     int *fuse_dev_ptr, bool init)
+{
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	char options[FILENAME_MAX];
+	uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+	uint8_t bytes_out[FUSE_MIN_READ_BUFFER];
+
+	DECL_FUSE_IN(init);
+
+	TEST(fuse_dev = open("/dev/fuse", O_RDWR | O_CLOEXEC), fuse_dev != -1);
+	snprintf(options, FILENAME_MAX, "fd=%d,user_id=0,group_id=0,rootmode=0040000",
+		 fuse_dev);
+	if (bpf_name != NULL)
+		snprintf(options + strlen(options),
+			 sizeof(options) - strlen(options),
+			 ",root_bpf=%s", bpf_name);
+	if (dir_fd != -1)
+		snprintf(options + strlen(options),
+			 sizeof(options) - strlen(options),
+			 ",root_dir=%d", dir_fd);
+	TESTSYSCALL(mount("ABC", mount_dir, "fuse", 0, options));
+
+	if (init) {
+		TESTFUSEIN(FUSE_INIT, init_in);
+		TESTEQUAL(init_in->major, FUSE_KERNEL_VERSION);
+		TESTEQUAL(init_in->minor, FUSE_KERNEL_MINOR_VERSION);
+		TESTFUSEOUT1(fuse_init_out, ((struct fuse_init_out) {
+			.major = FUSE_KERNEL_VERSION,
+			.minor = FUSE_KERNEL_MINOR_VERSION,
+			.max_readahead = 4096,
+			.flags = 0,
+			.max_background = 0,
+			.congestion_threshold = 0,
+			.max_write = 4096,
+			.time_gran = 1000,
+			.max_pages = 12,
+			.map_alignment = 4096,
+		}));
+	}
+
+	*fuse_dev_ptr = fuse_dev;
+	fuse_dev = -1;
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	return result;
+}
+
+int mount_fuse(const char *mount_dir, const char * bpf_name, int dir_fd, int *fuse_dev_ptr)
+{
+	return mount_fuse_maybe_init(mount_dir, bpf_name, dir_fd, fuse_dev_ptr,
+				     true);
+}
+
+int mount_fuse_no_init(const char *mount_dir, const char * bpf_name, int dir_fd,
+		       int *fuse_dev_ptr)
+{
+	return mount_fuse_maybe_init(mount_dir, bpf_name, dir_fd, fuse_dev_ptr,
+				     false);
+}
+
diff --git a/tools/testing/selftests/filesystems/fuse/fd.txt b/tools/testing/selftests/filesystems/fuse/fd.txt
new file mode 100644
index 000000000000..15ce77180d55
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fd.txt
@@ -0,0 +1,21 @@
+fuse_daemon $*
+cd fd-dst
+ls
+cd show
+ls
+fsstress -s 123 -d . -p 4 -n 100 -l5
+echo test > wibble
+ls
+cat wibble
+fallocate -l 1000 wobble
+mkdir testdir
+mkdir tmpdir
+rmdir tmpdir
+touch tmp
+mv tmp tmp2
+rm tmp2
+
+# FUSE_LINK
+echo "ln_src contents" > ln_src
+ln ln_src ln_link
+cat ln_link
diff --git a/tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c b/tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
new file mode 100644
index 000000000000..9b6377b96a6e
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2021 Google LLC
+
+//#define __EXPORTED_HEADERS__
+//#define __KERNEL__
+
+//#include <uapi/linux/bpf.h>
+//#include <linux/fuse.h>
+
+#include "vmlinux.h"
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include "bpf_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#if 0
+struct fuse_bpf_map {
+	int map_type;
+	int key_size;
+	int value_size;
+	int max_entries;
+};
+SEC("dummy")
+
+inline int strcmp(const char *a, const char *b)
+{
+	int i;
+
+	for (i = 0; i < __builtin_strlen(b) + 1; ++i)
+		if (a[i] != b[i])
+			return -1;
+
+	return 0;
+}
+
+SEC("maps") struct fuse_bpf_map test_map = {
+	BPF_MAP_TYPE_ARRAY,
+	sizeof(uint32_t),
+	sizeof(uint32_t),
+	1000,
+};
+
+SEC("maps") struct fuse_bpf_map test_map2 = {
+	BPF_MAP_TYPE_HASH,
+	sizeof(uint32_t),
+	sizeof(uint64_t),
+	76,
+};
+
+SEC("test_daemon")
+
+int trace_daemon(struct __bpf_fuse_args *fa)
+{
+	uint64_t uid_gid = bpf_get_current_uid_gid();
+	uint32_t uid = uid_gid & 0xffffffff;
+	uint64_t pid_tgid = bpf_get_current_pid_tgid();
+	uint32_t pid = pid_tgid & 0xffffffff;
+	uint32_t key = 23;
+	uint32_t *pvalue;
+
+
+	pvalue = bpf_map_lookup_elem(&test_map, &key);
+	if (pvalue) {
+		uint32_t value = *pvalue;
+
+		bpf_printk("pid %u uid %u value %u", pid, uid, value);
+		value++;
+		bpf_map_update_elem(&test_map, &key,  &value, BPF_ANY);
+	}
+
+	switch (fa->opcode) {
+#endif
+BPF_STRUCT_OPS(uint32_t, trace_access_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in)
+{
+	bpf_printk("Access: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_getattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in)
+{
+	bpf_printk("Get Attr %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_setattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in)
+{
+	bpf_printk("Set Attr %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_opendir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("Open Dir: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_readdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("Read Dir: fh: %lu", in->fh, in->offset);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("Lookup: %lx %s", meta->nodeid, name_buf);
+	if (meta->nodeid == 1)
+		return BPF_FUSE_USER_PREFILTER;
+	else
+		return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_mknod_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("mknod %s %x %x", name_buf,  in->rdev | in->mode, in->umask);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_mkdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("mkdir: %s %x %x", name_buf, in->mode, in->umask);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rmdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("rmdir: %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rename_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	struct bpf_dynptr old_name_ptr;
+	struct bpf_dynptr new_name_ptr;
+	char old_name_buf[255];
+	//char new_name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(old_name, &old_name_ptr);
+	//bpf_fuse_get_ro_dynptr(new_name, &new_name_ptr);
+	bpf_dynptr_read(old_name_buf, 255, &old_name_ptr, 0, 0);
+	//bpf_dynptr_read(new_name_buf, 255, &new_name_ptr, 0, 0);
+	bpf_printk("rename from %s", old_name_buf);
+	//bpf_printk("rename to %s", new_name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rename2_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	struct bpf_dynptr old_name_ptr;
+	//struct bpf_dynptr new_name_ptr;
+	char old_name_buf[255];
+	//char new_name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(old_name, &old_name_ptr);
+	//bpf_fuse_get_ro_dynptr(new_name, &new_name_ptr);
+	bpf_dynptr_read(old_name_buf, 255, &old_name_ptr, 0, 0);
+	//bpf_dynptr_read(new_name_buf, 255, &new_name_ptr, 0, 0);
+	bpf_printk("rename(%x) from %s", in->flags, old_name_buf);
+	//bpf_printk("rename to %s", new_name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_unlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("unlink: %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_link_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char dst_name[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(dst_name, 255, &name_ptr, 0, 0);
+	bpf_printk("Link: %d %s", in->oldnodeid, dst_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_symlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name, struct fuse_buffer *path)
+{
+	struct bpf_dynptr name_ptr;
+	//struct bpf_dynptr path_ptr;
+	char link_name[255];
+	//char link_path[4096];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	//bpf_fuse_get_ro_dynptr(path, &path_ptr);
+	bpf_dynptr_read(link_name, 255, &name_ptr, 0, 0);
+	//bpf_dynptr_read(link_path, 4096, &path_ptr, 0, 0);
+
+	bpf_printk("symlink from %s", link_name);
+	//bpf_printk("symlink to %s", link_path);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_get_link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char link_name[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(link_name, 255, &name_ptr, 0, 0);
+	bpf_printk("readlink from %s", link_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_release_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("Release: %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_releasedir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("Release Dir: %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_create_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_create_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("Create %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("Open: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_read_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("Read: fh: %lu, offset %lu, size %lu",
+			   in->fh, in->offset, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_write_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_write_in *in)
+{
+	bpf_printk("Write: fh: %lu, offset %lu, size %lu",
+			   in->fh, in->offset, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_flush_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *in)
+{
+	bpf_printk("Flush %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_file_fallocate_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in)
+{
+	bpf_printk("Fallocate %d %lu", in->fh, in->length);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_getxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("Getxattr %d %s", meta->nodeid, name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_listxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in)
+{
+	bpf_printk("Listxattr %d %d", meta->nodeid, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_setxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_in *in, struct fuse_buffer *name,
+					struct fuse_buffer *value)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("Setxattr %d %s", meta->nodeid, name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_statfs_prefilter, const struct bpf_fuse_meta_info *meta)
+{
+	bpf_printk("statfs %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_lseek_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_in *in)
+{
+	bpf_printk("lseek type:%d, offset:%lld", in->whence, in->offset);
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC(".struct_ops")
+struct fuse_ops trace_ops = {
+	.open_prefilter = (void *)trace_open_prefilter,
+	.opendir_prefilter = (void *)trace_opendir_prefilter,
+	.create_open_prefilter = (void *)trace_create_open_prefilter,
+	.release_prefilter = (void *)trace_release_prefilter,
+	.releasedir_prefilter = (void *)trace_releasedir_prefilter,
+	.flush_prefilter = (void *)trace_flush_prefilter,
+	.lseek_prefilter = (void *)trace_lseek_prefilter,
+	//.copy_file_range_prefilter = (void *)trace_copy_file_range_prefilter,
+	//.fsync_prefilter = (void *)trace_fsync_prefilter,
+	//.dir_fsync_prefilter = (void *)trace_dir_fsync_prefilter,
+	.getxattr_prefilter = (void *)trace_getxattr_prefilter,
+	.listxattr_prefilter = (void *)trace_listxattr_prefilter,
+	.setxattr_prefilter = (void *)trace_setxattr_prefilter,
+	//.removexattr_prefilter = (void *)trace_removexattr_prefilter,
+	.read_iter_prefilter = (void *)trace_read_iter_prefilter,
+	.write_iter_prefilter = (void *)trace_write_iter_prefilter,
+	.file_fallocate_prefilter = (void *)trace_file_fallocate_prefilter,
+	.lookup_prefilter = (void *)trace_lookup_prefilter,
+	.mknod_prefilter = (void *)trace_mknod_prefilter,
+	.mkdir_prefilter = (void *)trace_mkdir_prefilter,
+	.rmdir_prefilter = (void *)trace_rmdir_prefilter,
+	.rename2_prefilter = (void *)trace_rename2_prefilter,
+	.rename_prefilter = (void *)trace_rename_prefilter,
+	.unlink_prefilter = (void *)trace_unlink_prefilter,
+	.link_prefilter = (void *)trace_link_prefilter,
+	.getattr_prefilter = (void *)trace_getattr_prefilter,
+	.setattr_prefilter = (void *)trace_setattr_prefilter,
+	.statfs_prefilter = (void *)trace_statfs_prefilter,
+	.get_link_prefilter = (void *)trace_get_link_prefilter,
+	.symlink_prefilter = (void *)trace_symlink_prefilter,
+	.readdir_prefilter = (void *)trace_readdir_prefilter,
+	.access_prefilter = (void *)trace_access_prefilter,
+	.name = "trace_ops",
+};
+
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_daemon.c b/tools/testing/selftests/filesystems/fuse/fuse_daemon.c
new file mode 100644
index 000000000000..42f9f770988b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_daemon.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+
+#include "test_fuse.h"
+#include "test.skel.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include <linux/unistd.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+bool user_messages;
+bool kernel_messages;
+
+static int display_trace(void)
+{
+	int pid = -1;
+	int tp = -1;
+	char c;
+	ssize_t bytes_read;
+	static char line[256] = {0};
+
+	if (!kernel_messages)
+		return TEST_SUCCESS;
+
+	TEST(pid = fork(), pid != -1);
+	if (pid != 0)
+		return pid;
+
+	TESTEQUAL(tracing_on(), 0);
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace_pipe")),
+			 O_RDONLY | O_CLOEXEC), tp != -1);
+	for (;;) {
+		TEST(bytes_read = read(tp, &c, sizeof(c)),
+		     bytes_read == 1);
+		if (c == '\n') {
+			printf("%s\n", line);
+			line[0] = 0;
+		} else
+			sprintf(line + strlen(line), "%c", c);
+	}
+out:
+	if (pid == 0) {
+		close(tp);
+		exit(TEST_FAILURE);
+	}
+	return pid;
+}
+
+static const char *fuse_opcode_to_string(int opcode)
+{
+	switch (opcode & FUSE_OPCODE_FILTER) {
+	case FUSE_LOOKUP:
+		return "FUSE_LOOKUP";
+	case FUSE_FORGET:
+		return "FUSE_FORGET";
+	case FUSE_GETATTR:
+		return "FUSE_GETATTR";
+	case FUSE_SETATTR:
+		return "FUSE_SETATTR";
+	case FUSE_READLINK:
+		return "FUSE_READLINK";
+	case FUSE_SYMLINK:
+		return "FUSE_SYMLINK";
+	case FUSE_MKNOD:
+		return "FUSE_MKNOD";
+	case FUSE_MKDIR:
+		return "FUSE_MKDIR";
+	case FUSE_UNLINK:
+		return "FUSE_UNLINK";
+	case FUSE_RMDIR:
+		return "FUSE_RMDIR";
+	case FUSE_RENAME:
+		return "FUSE_RENAME";
+	case FUSE_LINK:
+		return "FUSE_LINK";
+	case FUSE_OPEN:
+		return "FUSE_OPEN";
+	case FUSE_READ:
+		return "FUSE_READ";
+	case FUSE_WRITE:
+		return "FUSE_WRITE";
+	case FUSE_STATFS:
+		return "FUSE_STATFS";
+	case FUSE_RELEASE:
+		return "FUSE_RELEASE";
+	case FUSE_FSYNC:
+		return "FUSE_FSYNC";
+	case FUSE_SETXATTR:
+		return "FUSE_SETXATTR";
+	case FUSE_GETXATTR:
+		return "FUSE_GETXATTR";
+	case FUSE_LISTXATTR:
+		return "FUSE_LISTXATTR";
+	case FUSE_REMOVEXATTR:
+		return "FUSE_REMOVEXATTR";
+	case FUSE_FLUSH:
+		return "FUSE_FLUSH";
+	case FUSE_INIT:
+		return "FUSE_INIT";
+	case FUSE_OPENDIR:
+		return "FUSE_OPENDIR";
+	case FUSE_READDIR:
+		return "FUSE_READDIR";
+	case FUSE_RELEASEDIR:
+		return "FUSE_RELEASEDIR";
+	case FUSE_FSYNCDIR:
+		return "FUSE_FSYNCDIR";
+	case FUSE_GETLK:
+		return "FUSE_GETLK";
+	case FUSE_SETLK:
+		return "FUSE_SETLK";
+	case FUSE_SETLKW:
+		return "FUSE_SETLKW";
+	case FUSE_ACCESS:
+		return "FUSE_ACCESS";
+	case FUSE_CREATE:
+		return "FUSE_CREATE";
+	case FUSE_INTERRUPT:
+		return "FUSE_INTERRUPT";
+	case FUSE_BMAP:
+		return "FUSE_BMAP";
+	case FUSE_DESTROY:
+		return "FUSE_DESTROY";
+	case FUSE_IOCTL:
+		return "FUSE_IOCTL";
+	case FUSE_POLL:
+		return "FUSE_POLL";
+	case FUSE_NOTIFY_REPLY:
+		return "FUSE_NOTIFY_REPLY";
+	case FUSE_BATCH_FORGET:
+		return "FUSE_BATCH_FORGET";
+	case FUSE_FALLOCATE:
+		return "FUSE_FALLOCATE";
+	case FUSE_READDIRPLUS:
+		return "FUSE_READDIRPLUS";
+	case FUSE_RENAME2:
+		return "FUSE_RENAME2";
+	case FUSE_LSEEK:
+		return "FUSE_LSEEK";
+	case FUSE_COPY_FILE_RANGE:
+		return "FUSE_COPY_FILE_RANGE";
+	case FUSE_SETUPMAPPING:
+		return "FUSE_SETUPMAPPING";
+	case FUSE_REMOVEMAPPING:
+		return "FUSE_REMOVEMAPPING";
+	//case FUSE_SYNCFS:
+	//	return "FUSE_SYNCFS";
+	case CUSE_INIT:
+		return "CUSE_INIT";
+	case CUSE_INIT_BSWAP_RESERVED:
+		return "CUSE_INIT_BSWAP_RESERVED";
+	case FUSE_INIT_BSWAP_RESERVED:
+		return "FUSE_INIT_BSWAP_RESERVED";
+	}
+	return "?";
+}
+
+static int parse_options(int argc, char *const *argv)
+{
+	signed char c;
+
+	while ((c = getopt(argc, argv, "kuv")) != -1)
+		switch (c) {
+		case 'v':
+			test_options.verbose = true;
+			break;
+
+		case 'u':
+			user_messages = true;
+			break;
+
+		case 'k':
+			kernel_messages = true;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	int result = TEST_FAILURE;
+	int trace_pid = -1;
+	char *mount_dir = NULL;
+	char *src_dir = NULL;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	//struct map_relocation *map_relocations = NULL;
+	//size_t map_count = 0;
+	//int i;
+
+	if (geteuid() != 0)
+		ksft_print_msg("Not a root, might fail to mount.\n");
+	TESTEQUAL(parse_options(argc, argv), 0);
+
+	TEST(trace_pid = display_trace(), trace_pid != -1);
+
+	delete_dir_tree("fd-src", true);
+	TEST(src_dir = setup_mount_dir("fd-src"), src_dir);
+	delete_dir_tree("fd-dst", true);
+	TEST(mount_dir = setup_mount_dir("fd-dst"), mount_dir);
+
+	test_skel = test_bpf__open_and_load();
+	test_link = bpf_map__attach_struct_ops(test_skel->maps.trace_ops);
+
+	TEST(src_fd = open("fd-src", O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTSYSCALL(mkdirat(src_fd, "show", 0777));
+	TESTSYSCALL(mkdirat(src_fd, "hide", 0777));
+
+	/*for (i = 0; i < map_count; ++i)
+		if (!strcmp(map_relocations[i].name, "test_map")) {
+			uint32_t key = 23;
+			uint32_t value = 1234;
+			union bpf_attr attr = {
+				.map_fd = map_relocations[i].fd,
+				.key    = ptr_to_u64(&key),
+				.value  = ptr_to_u64(&value),
+				.flags  = BPF_ANY,
+			};
+			TESTSYSCALL(syscall(__NR_bpf, BPF_MAP_UPDATE_ELEM,
+					    &attr, sizeof(attr)));
+		}
+*/
+	TESTEQUAL(mount_fuse(mount_dir, "trace_ops", src_fd, &fuse_dev), 0);
+
+	if (fork())
+		return 0;
+
+	for (;;) {
+		uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+		uint8_t bytes_out[FUSE_MIN_READ_BUFFER] __attribute__((unused));
+		struct fuse_in_header *in_header =
+			(struct fuse_in_header *)bytes_in;
+		ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+
+		if (res == -1)
+			break;
+
+		switch (in_header->opcode) {
+		case FUSE_LOOKUP | FUSE_PREFILTER: {
+			char *name = (char *)(bytes_in + sizeof(*in_header));
+
+			if (user_messages)
+				printf("Lookup %s\n", name);
+			if (!strcmp(name, "hide"))
+				TESTFUSEOUTERROR(-ENOENT);
+			else {
+				printf("Lookup Prefilter response: %s\n", name);
+				TESTFUSEOUTREAD(name, strlen(name) + 1);
+			}
+			break;
+		}
+		default:
+			if (user_messages) {
+				printf("opcode is %d (%s)\n", in_header->opcode,
+				       fuse_opcode_to_string(
+					       in_header->opcode));
+			}
+			break;
+		}
+	}
+
+	result = TEST_SUCCESS;
+
+out:
+	/*for (i = 0; i < map_count; ++i) {
+		free(map_relocations[i].name);
+		close(map_relocations[i].fd);
+	}
+	free(map_relocations);*/
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	umount2(mount_dir, MNT_FORCE);
+	delete_dir_tree(mount_dir, true);
+	free(mount_dir);
+	delete_dir_tree(src_dir, true);
+	free(src_dir);
+	if (trace_pid != -1)
+		kill(trace_pid, SIGKILL);
+	return result;
+}
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_test.c b/tools/testing/selftests/filesystems/fuse/fuse_test.c
new file mode 100644
index 000000000000..cc14b79615c1
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_test.c
@@ -0,0 +1,2412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC
+ */
+#define _GNU_SOURCE
+
+#include "test_fuse.h"
+#include "test.skel.h"
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/inotify.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+
+#include <linux/capability.h>
+#include <linux/random.h>
+
+#include <uapi/linux/fuse.h>
+#include <uapi/linux/bpf.h>
+
+static const char *ft_src = "ft-src";
+static const char *ft_dst = "ft-dst";
+
+static void fill_buffer(uint8_t *data, size_t len, int file, int block)
+{
+	int i;
+	int seed = 7919 * file + block;
+
+	for (i = 0; i < len; i++) {
+		seed = 1103515245 * seed + 12345;
+		data[i] = (uint8_t)(seed >> (i % 13));
+	}
+}
+
+static bool test_buffer(uint8_t *data, size_t len, int file, int block)
+{
+	int i;
+	int seed = 7919 * file + block;
+
+	for (i = 0; i < len; i++) {
+		seed = 1103515245 * seed + 12345;
+		if (data[i] != (uint8_t)(seed >> (i % 13)))
+			return false;
+	}
+
+	return true;
+}
+
+static int create_file(int dir, struct s name, int index, size_t blocks)
+{
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int i;
+	uint8_t data[PAGE_SIZE];
+
+	TEST(fd = s_openat(dir, name, O_CREAT | O_WRONLY, 0777), fd != -1);
+	for (i = 0; i < blocks; ++i) {
+		fill_buffer(data, PAGE_SIZE, index, i);
+		TESTEQUAL(write(fd, data, sizeof(data)), PAGE_SIZE);
+	}
+	TESTSYSCALL(close(fd));
+	result = TEST_SUCCESS;
+
+out:
+	close(fd);
+	return result;
+}
+
+static int bpf_clear_trace(void)
+{
+	int result = TEST_FAILURE;
+	int tp = -1;
+
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace")),
+			 O_WRONLY | O_TRUNC | O_CLOEXEC), tp != -1);
+
+	result = TEST_SUCCESS;
+out:
+	close(tp);
+	return result;
+}
+
+static int bpf_test_trace_maybe(const char *substr, bool present)
+{
+	int result = TEST_FAILURE;
+	int tp = -1;
+	char trace_buffer[4096] = {};
+	ssize_t bytes_read;
+
+	TEST(tp = s_open(s_path(tracing_folder(), s("trace_pipe")),
+			 O_RDONLY | O_CLOEXEC),
+	     tp != -1);
+	fcntl(tp, F_SETFL, O_NONBLOCK);
+
+	for (;;) {
+		bytes_read = read(tp, trace_buffer, sizeof(trace_buffer));
+		if (present)
+			TESTCOND(bytes_read > 0);
+		else if (bytes_read <= 0) {
+			result = TEST_SUCCESS;
+			break;
+		}
+
+		if (test_options.verbose)
+			ksft_print_msg("%s\n", trace_buffer);
+
+		if (strstr(trace_buffer, substr)) {
+			if (present)
+				result = TEST_SUCCESS;
+			break;
+		}
+	}
+out:
+	close(tp);
+	return result;
+}
+
+static int bpf_test_trace(const char *substr)
+{
+	return bpf_test_trace_maybe(substr, true);
+}
+
+static int bpf_test_no_trace(const char *substr)
+{
+	return bpf_test_trace_maybe(substr, false);
+}
+
+static int basic_test(const char *mount_dir)
+{
+	const char *test_name = "test";
+	const char *test_data = "data";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTEQUAL(mount_fuse(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		char data[256];
+
+		filename = concat_file_name(mount_dir, test_name);
+		TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, strlen(test_data)), strlen(test_data));
+		TESTCOND(!strcmp(data, test_data));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	FUSE_DAEMON
+		DECL_FUSE_IN(open);
+		DECL_FUSE_IN(read);
+		DECL_FUSE_IN(flush);
+		DECL_FUSE_IN(release);
+
+		TESTFUSELOOKUP(test_name, 0);
+		TESTFUSEOUT1(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 2,
+			.generation	= 1,
+			.attr.ino = 100,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFREG | 0777,
+			}));
+
+		TESTFUSEIN(FUSE_OPEN, open_in);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = open_in->flags,
+		}));
+
+		TESTFUSEIN(FUSE_READ, read_in);
+		TESTFUSEOUTREAD(test_data, strlen(test_data));
+
+		TESTFUSEIN(FUSE_FLUSH, flush_in);
+		TESTFUSEOUTEMPTY();
+
+		TESTFUSEIN(FUSE_RELEASE, release_in);
+		TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_real(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *test_name = "real";
+	const char *test_data = "Weebles wobble but they don't fall down";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	char read_buffer[256] = {};
+	ssize_t bytes_read;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, test_name, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	filename = concat_file_name(mount_dir, test_name);
+	TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+	bytes_read = read(fd, read_buffer, strlen(test_data));
+
+	TESTEQUAL(bytes_read, strlen(test_data));
+	TESTEQUAL(strcmp(test_data, read_buffer), 0);
+	TESTEQUAL(bpf_test_trace("read"), 0);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+
+static int bpf_test_partial(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *test_name = "partial";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(test_name), 1, 2), 0);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		uint8_t data[PAGE_SIZE];
+
+		TEST(filename = concat_file_name(mount_dir, test_name),
+		     filename);
+		TESTERR(fd = open(filename, O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, PAGE_SIZE), PAGE_SIZE);
+		//TESTEQUAL(bpf_test_trace("read"), 0);
+		TESTCOND(test_buffer(data, PAGE_SIZE, 2, 0));
+		TESTCOND(!test_buffer(data, PAGE_SIZE, 1, 0));
+		TESTEQUAL(read(fd, data, PAGE_SIZE), PAGE_SIZE);
+		TESTCOND(test_buffer(data, PAGE_SIZE, 1, 1));
+		TESTCOND(!test_buffer(data, PAGE_SIZE, 2, 1));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	FUSE_DAEMON
+		uint32_t *err_in;
+		DECL_FUSE(open);
+		DECL_FUSE(read);
+		DECL_FUSE(release);
+		uint8_t data[PAGE_SIZE];
+
+		TESTFUSEIN2_ERR_IN(FUSE_OPEN | FUSE_POSTFILTER, open_in, open_out, err_in);
+		TESTEQUAL(*err_in, 0);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = open_in->flags,
+		}));
+
+		TESTFUSEIN(FUSE_READ, read_in);
+		fill_buffer(data, PAGE_SIZE, 2, 0);
+		TESTFUSEOUTREAD(data, PAGE_SIZE);
+
+		//TESTFUSEIN(FUSE_RELEASE, release_in);
+		//TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_attrs(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *test_name = "partial";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	char *filename = NULL;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(test_name), 1, 2), 0);
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TEST(filename = concat_file_name(mount_dir, test_name), filename);
+	TESTSYSCALL(stat(filename, &st));
+	TESTSYSCALL(chmod(filename, 0111));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_mode & 0777, 0111);
+	TESTSYSCALL(chmod(filename, 0777));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_mode & 0777, 0777);
+	TESTSYSCALL(chown(filename, 5, 6));
+	TESTSYSCALL(stat(filename, &st));
+	TESTEQUAL(st.st_uid, 5);
+	TESTEQUAL(st.st_gid, 6);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	free(filename);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_readdir(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *names[] = {"real", "partial", "fake", ".", ".."};
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	DIR *dir = NULL;
+	struct dirent *dirent;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(create_file(src_fd, s(names[0]), 1, 2), 0);
+	TESTEQUAL(create_file(src_fd, s(names[1]), 1, 2), 0);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int i, j;
+
+		TEST(dir = s_opendir(s(mount_dir)), dir);
+		TESTEQUAL(bpf_test_trace("opendir"), 0);
+
+		for (i = 0; i < ARRAY_SIZE(names); ++i) {
+			TEST(dirent = readdir(dir), dirent);
+
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+		}
+		TEST(dirent = readdir(dir), dirent == NULL);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+		TESTEQUAL(bpf_test_trace("readdir"), 0);
+	FUSE_DAEMON
+		struct fuse_in_header *in_header =
+			(struct fuse_in_header *)bytes_in;
+		ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		// ignore the error in extension
+		res -= ERR_IN_EXT_LEN;
+		struct fuse_read_out *read_out =
+			(struct fuse_read_out *) (bytes_in +
+					sizeof(*in_header) +
+					sizeof(struct fuse_read_in));
+		struct fuse_dirent *fuse_dirent =
+			(struct fuse_dirent *) (bytes_in + res);
+
+		TESTGE(res, sizeof(*in_header) + sizeof(struct fuse_read_in));
+		TESTEQUAL(in_header->opcode, FUSE_READDIR | FUSE_POSTFILTER);
+		*fuse_dirent = (struct fuse_dirent) {
+			.ino = 100,
+			.off = 5,
+			.namelen = strlen("fake"),
+			.type = DT_REG,
+		};
+		strcpy((char *)(bytes_in + res + sizeof(*fuse_dirent)), "fake");
+		res += FUSE_DIRENT_ALIGN(sizeof(*fuse_dirent) + strlen("fake") +
+					 1);
+		TESTFUSEDIROUTREAD(read_out,
+				bytes_in +
+				   sizeof(struct fuse_in_header) +
+				   sizeof(struct fuse_read_in) +
+				   sizeof(struct fuse_read_out),
+				res - sizeof(struct fuse_in_header) -
+				    sizeof(struct fuse_read_in) -
+				    sizeof(struct fuse_read_out));
+		res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		TESTEQUAL(res, sizeof(*in_header) +
+			  sizeof(struct fuse_read_in) +
+			  sizeof(struct fuse_read_out) + ERR_IN_EXT_LEN);
+		TESTEQUAL(in_header->opcode, FUSE_READDIR | FUSE_POSTFILTER);
+		TESTFUSEDIROUTREAD(read_out, bytes_in, 0);
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	closedir(dir);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_redact_readdir(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *names[] = {"f1", "f2", "f3", "f4", "f5", "f6", ".", ".."};
+	int num_shown = (ARRAY_SIZE(names) - 2) / 2 + 2;
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	DIR *dir = NULL;
+	struct dirent *dirent;
+	int i;
+	int count = 0;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	for (i = 0; i < ARRAY_SIZE(names) - 2; i++)
+		TESTEQUAL(create_file(src_fd, s(names[i]), 1, 2), 0);
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.readdir_redact_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "readdir_redact", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int j;
+
+		TEST(dir = s_opendir(s(mount_dir)), dir);
+		while ((dirent = readdir(dir))) {
+			errno = 0;
+			TESTEQUAL(errno, 0);
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					count++;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+			TESTGE(num_shown, count);
+		}
+		TESTEQUAL(count, num_shown);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+	FUSE_DAEMON
+		bool skip = true;
+		for (int i = 0; i < ARRAY_SIZE(names) + 1; i++) {
+			uint8_t bytes_in[FUSE_MIN_READ_BUFFER];
+			uint8_t bytes_out[FUSE_MIN_READ_BUFFER];
+			struct fuse_in_header *in_header =
+				(struct fuse_in_header *)bytes_in;
+			ssize_t res = read(fuse_dev, bytes_in, sizeof(bytes_in));
+			int length_out = 0;
+			uint8_t *pos;
+			uint8_t *dirs_in;
+			uint8_t *dirs_out;
+			struct fuse_read_in *fuse_read_in;
+			struct fuse_read_out *fuse_read_out_in;
+			struct fuse_read_out *fuse_read_out_out;
+			struct fuse_dirent *fuse_dirent_in = NULL;
+			struct fuse_dirent *next = NULL;
+			bool again = false;
+			int dir_ent_len = 0;
+
+			// We're ignoring the error_in extension
+			res -= ERR_IN_EXT_LEN;
+			TESTGE(res, sizeof(struct fuse_in_header) +
+					sizeof(struct fuse_read_in) +
+					sizeof(struct fuse_read_out));
+
+			pos = bytes_in + sizeof(struct fuse_in_header);
+			fuse_read_in = (struct fuse_read_in *) pos;
+			pos += sizeof(*fuse_read_in);
+			fuse_read_out_in = (struct fuse_read_out *) pos;
+			pos += sizeof(*fuse_read_out_in);
+			dirs_in = pos;
+
+			pos = bytes_out + sizeof(struct fuse_out_header);
+			fuse_read_out_out = (struct fuse_read_out *) pos;
+			pos += sizeof(*fuse_read_out_out);
+			dirs_out = pos;
+
+			if (dirs_in < bytes_in + res) {
+				bool is_dot;
+
+				fuse_dirent_in = (struct fuse_dirent *) dirs_in;
+				is_dot = (fuse_dirent_in->namelen == 1 &&
+						!strncmp(fuse_dirent_in->name, ".", 1)) ||
+					 (fuse_dirent_in->namelen == 2 &&
+						!strncmp(fuse_dirent_in->name, "..", 2));
+
+				dir_ent_len = FUSE_DIRENT_ALIGN(
+					sizeof(*fuse_dirent_in) +
+					fuse_dirent_in->namelen);
+
+				if (dirs_in + dir_ent_len < bytes_in + res)
+					next = (struct fuse_dirent *)
+							(dirs_in + dir_ent_len);
+
+				if (!skip || is_dot) {
+					memcpy(dirs_out, fuse_dirent_in,
+					       sizeof(struct fuse_dirent) +
+					       fuse_dirent_in->namelen);
+					length_out += dir_ent_len;
+				}
+				again = ((skip && !is_dot) && next);
+
+				if (!is_dot)
+					skip = !skip;
+			}
+
+			fuse_read_out_out->offset = next ? next->off :
+					fuse_read_out_in->offset;
+			fuse_read_out_out->again = again;
+
+			{
+			struct fuse_out_header *out_header =
+				(struct fuse_out_header *)bytes_out;
+
+			*out_header = (struct fuse_out_header) {
+				.len = sizeof(*out_header) +
+				       sizeof(*fuse_read_out_out) + length_out,
+				.unique = in_header->unique,
+			};
+			TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),
+				  out_header->len);
+			}
+		}
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	closedir(dir);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+/*
+ * This test is more to show what classic fuse does with a creat in a subdir
+ * than a test of any new functionality
+ */
+static int bpf_test_creat(const char *mount_dir)
+{
+	const char *dir_name = "show";
+	const char *file_name = "file";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+	int fd = -1;
+
+	TESTEQUAL(mount_fuse(mount_dir, NULL, -1, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(dir_name)),
+					 s(file_name)),
+				  0777),
+		     fd != -1);
+		TESTSYSCALL(close(fd));
+	FUSE_DAEMON
+		DECL_FUSE_IN(create);
+		DECL_FUSE_IN(release);
+		DECL_FUSE_IN(flush);
+
+		TESTFUSELOOKUP(dir_name, 0);
+		TESTFUSEOUT1(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 3,
+			.generation	= 1,
+			.attr.ino = 100,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFDIR | 0777,
+			}));
+
+		TESTFUSELOOKUP(file_name, 0);
+		TESTFUSEOUTERROR(-ENOENT);
+
+		TESTFUSEINEXT(FUSE_CREATE, create_in, strlen(file_name) + 1);
+		TESTFUSEOUT2(fuse_entry_out, ((struct fuse_entry_out) {
+			.nodeid		= 2,
+			.generation	= 1,
+			.attr.ino = 200,
+			.attr.size = 4,
+			.attr.blksize = 512,
+			.attr.mode = S_IFREG,
+			}),
+			fuse_open_out, ((struct fuse_open_out) {
+			.fh = 1,
+			.open_flags = create_in->flags,
+			}));
+
+		TESTFUSEIN(FUSE_FLUSH, flush_in);
+		TESTFUSEOUTEMPTY();
+
+		TESTFUSEIN(FUSE_RELEASE, release_in);
+		TESTFUSEOUTEMPTY();
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_hidden_entries(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	static const char * const dir_names[] = {
+		"show",
+		"hide",
+	};
+	const char *file_name = "file";
+	const char *data = "The quick brown fox jumps over the lazy dog\n";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTSYSCALL(mkdirat(src_fd, dir_names[0], 0777));
+	TESTSYSCALL(mkdirat(src_fd, dir_names[1], 0777));
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_hidden_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_hidden", src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(dir_names[0])),
+				 s(file_name)),
+			  0777),
+	     fd != -1);
+	TESTSYSCALL(fallocate(fd, 0, 0, 4096));
+	TEST(write(fd, data, strlen(data)), strlen(data));
+	TESTSYSCALL(close(fd));
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_dir(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *dir_name = "dir";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTSYSCALL(s_rmdir(s_path(s(mount_dir), s(dir_name))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_file(const char *mount_dir, bool close_first)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *file_name = "real";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)),
+			  0777),
+	     fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	if (close_first) {
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	}
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	if (!close_first) {
+		TESTSYSCALL(close(fd));
+		fd = -1;
+	}
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_file_early_close(const char *mount_dir)
+{
+	return bpf_test_file(mount_dir, true);
+}
+
+static int bpf_test_file_late_close(const char *mount_dir)
+{
+	return bpf_test_file(mount_dir, false);
+}
+
+static int bpf_test_alter_errcode_bpf(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *dir_name = "dir";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_error_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_error", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	//TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTEQUAL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777), -EPERM);
+	TESTSYSCALL(s_rmdir(s_path(s(mount_dir), s(dir_name))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_alter_errcode_userspace(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *dir_name = "doesnotexist";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_error_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_error", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TESTEQUAL(s_unlink(s_path(s(mount_dir), s(dir_name))),
+		     -1);
+		TESTEQUAL(errno, ENOMEM);
+	FUSE_DAEMON
+		TESTFUSELOOKUP("doesnotexist", FUSE_POSTFILTER);
+		TESTFUSEOUTERROR(-ENOMEM);
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+//TODO: Make equivalent struct_op tests
+#if 0
+static int bpf_test_verifier(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+	int bpf_fd3 = -1;
+
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf.o", "test_verify",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail",
+				  &bpf_fd2, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail2",
+				  &bpf_fd3, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	close(bpf_fd3);
+	return result;
+}
+
+static int bpf_test_verifier_out_args(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail3",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail4",
+				  &bpf_fd2, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	return result;
+}
+
+static int bpf_test_verifier_packet_invalidation(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+	int bpf_fd2 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail5",
+				  &bpf_fd1, NULL, NULL), 0);
+	TESTEQUAL(install_elf_bpf("test_bpf.bpf.o", "test_verify5",
+				  &bpf_fd2, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	close(bpf_fd2);
+	return result;
+}
+
+static int bpf_test_verifier_nonsense_read(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	int bpf_fd1 = -1;
+
+	TESTEQUAL(install_elf_bpf_invalid("test_bpf.bpf.o", "test_verify_fail6",
+				  &bpf_fd1, NULL, NULL), 0);
+	result = TEST_SUCCESS;
+out:
+	close(bpf_fd1);
+	return result;
+}
+#endif
+
+static int bpf_test_mknod(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *file_name = "real";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkfifo(s_path(s(mount_dir), s(file_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mknod"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_largedir(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *show = "show";
+	const int files = 1000;
+
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	int pid = -1;
+	int status;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "trace_ops", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		int i;
+		int fd;
+		DIR *dir = NULL;
+		struct dirent *dirent;
+
+		TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(show)), 0777));
+		for (i = 0; i < files; ++i) {
+			char filename[NAME_MAX];
+
+			sprintf(filename, "%d", i);
+			TEST(fd = s_creat(s_path(s_path(s(mount_dir), s(show)),
+						 s(filename)), 0777), fd != -1);
+			TESTSYSCALL(close(fd));
+		}
+
+		TEST(dir = s_opendir(s_path(s(mount_dir), s(show))), dir);
+		for (dirent = readdir(dir); dirent; dirent = readdir(dir))
+			;
+		closedir(dir);
+	FUSE_DAEMON
+		int i;
+
+		for (i = 0; i < files + 2; ++i) {
+			TESTFUSELOOKUP(show, FUSE_PREFILTER);
+			TESTFUSEOUTREAD(show, 5);
+		}
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_link(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *file_name = "real";
+	const char *link_name = "partial";
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)), 0777), fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+
+	TESTSYSCALL(s_link(s_path(s(mount_dir), s(file_name)),
+			   s_path(s(mount_dir), s(link_name))));
+
+	TESTEQUAL(bpf_test_trace("link"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(link_name)), &st));
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(link_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(link_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_symlink(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *test_name = "real";
+	const char *symlink_name = "partial";
+	const char *test_data = "Weebles wobble but they don't fall down";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	char read_buffer[256] = {};
+	ssize_t bytes_read;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, test_name, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_symlink(s_path(s(mount_dir), s(test_name)),
+				   s_path(s(mount_dir), s(symlink_name))));
+	TESTEQUAL(bpf_test_trace("symlink"), 0);
+
+	TESTERR(fd = s_open(s_path(s(mount_dir), s(symlink_name)), O_RDONLY | O_CLOEXEC), fd != -1);
+	bytes_read = read(fd, read_buffer, strlen(test_data));
+	TESTEQUAL(bpf_test_trace("readlink"), 0);
+	TESTEQUAL(bytes_read, strlen(test_data));
+	TESTEQUAL(strcmp(test_data, read_buffer), 0);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_xattr(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	static const char file_name[] = "real";
+	static const char xattr_name[] = "user.xattr_test_name";
+	static const char xattr_value[] = "this_is_a_test";
+	const size_t xattr_size = sizeof(xattr_value);
+	char xattr_value_ret[256];
+	ssize_t xattr_size_ret;
+	int result = TEST_FAILURE;
+	int fd = -1;
+	int src_fd = -1;
+	int bpf_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	memset(xattr_value_ret, '\0', sizeof(xattr_value_ret));
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+
+	TEST(fd = s_creat(s_path(s(mount_dir), s(file_name)), 0777), fd != -1);
+	TESTEQUAL(bpf_test_trace("Create"), 0);
+	TESTSYSCALL(close(fd));
+
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(file_name)), &st));
+	TEST(result = s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+				 xattr_value_ret, sizeof(xattr_value_ret),
+				 &xattr_size_ret),
+	     result == -1);
+	TESTEQUAL(errno, ENODATA);
+	TESTEQUAL(bpf_test_trace("getxattr"), 0);
+
+	TESTSYSCALL(s_listxattr(s_path(s(mount_dir), s(file_name)),
+				xattr_value_ret, sizeof(xattr_value_ret),
+				&xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("listxattr"), 0);
+	TESTEQUAL(xattr_size_ret, 0);
+
+	TESTSYSCALL(s_setxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value, xattr_size, 0));
+	TESTEQUAL(bpf_test_trace("setxattr"), 0);
+
+	TESTSYSCALL(s_listxattr(s_path(s(mount_dir), s(file_name)),
+				xattr_value_ret, sizeof(xattr_value_ret),
+				&xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("listxattr"), 0);
+	TESTEQUAL(xattr_size_ret, sizeof(xattr_name));
+	TESTEQUAL(strcmp(xattr_name, xattr_value_ret), 0);
+
+	TESTSYSCALL(s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value_ret, sizeof(xattr_value_ret),
+			       &xattr_size_ret));
+	TESTEQUAL(bpf_test_trace("getxattr"), 0);
+	TESTEQUAL(xattr_size, xattr_size_ret);
+	TESTEQUAL(strcmp(xattr_value, xattr_value_ret), 0);
+
+	TESTSYSCALL(s_removexattr(s_path(s(mount_dir), s(file_name)), xattr_name));
+	TESTEQUAL(bpf_test_trace("removexattr"), 0);
+
+	TESTEQUAL(s_getxattr(s_path(s(mount_dir), s(file_name)), xattr_name,
+			       xattr_value_ret, sizeof(xattr_value_ret),
+			       &xattr_size_ret), -1);
+	TESTEQUAL(errno, ENODATA);
+
+	TESTSYSCALL(s_unlink(s_path(s(mount_dir), s(file_name))));
+	TESTEQUAL(bpf_test_trace("unlink"), 0);
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(file_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(bpf_fd);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_set_backing(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *backing_name = "backing";
+	const char *test_data = "data";
+	const char *test_name = "test";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		char data[256] = {0};
+
+		TESTERR(fd = s_open(s_path(s(mount_dir), s(test_name)),
+				    O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, strlen(test_data)), strlen(test_data));
+		TESTCOND(!strcmp(data, test_data));
+		TESTSYSCALL(close(fd));
+		fd = -1;
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		//int bpf_fd  = -1;
+		int backing_fd = -1;
+		struct fuse_bpf_entry_out bpf_entry[2];
+
+		TESTERR(backing_fd = s_creat(s_path(s(ft_src), s(backing_name)), 0777),
+			backing_fd != -1);
+		TESTEQUAL(write(backing_fd, test_data, strlen(test_data)),
+			  strlen(test_data));
+
+		TESTFUSEINIT();
+		TESTFUSELOOKUP(test_name, 0);
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "trace_ops",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {0}),
+				fuse_bpf_entry_out, bpf_entry[0],
+				fuse_bpf_entry_out, bpf_entry[1]);
+		read(fuse_dev, bytes_in, sizeof(bytes_in));
+		//TESTSYSCALL(close(bpf_fd));
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_set_backing_no_ioctl(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *backing_name = "backing";
+	const char *test_name = "test";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+
+		TESTERR(fd = s_open(s_path(s(mount_dir), s(test_name)),
+				    O_RDONLY | O_CLOEXEC), fd == -1);
+	FUSE_DAEMON
+		int backing_fd = -1;
+		struct fuse_bpf_entry_out bpf_entry[2];
+
+		TESTERR(backing_fd = s_creat(s_path(s(ft_src), s(backing_name)), 0777),
+			backing_fd != -1);
+
+		TESTFUSEINIT();
+		TESTFUSELOOKUP(test_name, 0);
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "trace_ops",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_FAIL(fuse_entry_out, ((struct fuse_entry_out) {0}),
+			     fuse_bpf_entry_out, bpf_entry[0],
+			     fuse_bpf_entry_out, bpf_entry[1]);
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_set_backing_folder(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *backing_name = "backingdir";
+	const char *test_name = "testdir";
+	const char *names[] = {"file", ".", ".."};
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int pid = -1;
+	int status;
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		DIR *dir = NULL;
+		struct dirent *dirent;
+		int i, j;
+
+		TEST(dir = s_opendir(s_path(s(mount_dir), s(test_name))), dir);
+
+		for (i = 0; i < ARRAY_SIZE(names); ++i) {
+			TEST(dirent = readdir(dir), dirent);
+
+			for (j = 0; j < ARRAY_SIZE(names); ++j)
+				if (names[j] &&
+				    strcmp(names[j], dirent->d_name) == 0) {
+					names[j] = NULL;
+					break;
+				}
+			TESTNE(j, ARRAY_SIZE(names));
+		}
+		TEST(dirent = readdir(dir), dirent == NULL);
+		TESTSYSCALL(closedir(dir));
+		dir = NULL;
+		TESTEQUAL(bpf_test_trace("Read Dir"), 0);
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		int backing_fd = -1;
+		struct fuse_bpf_entry_out bpf_entry[2];
+
+		TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(backing_name)), 0777));
+		TESTERR(backing_fd = s_open(s_path(s(ft_src), s(backing_name)), O_RDONLY | O_CLOEXEC),
+					backing_fd != -1);
+		TESTSYSCALL(s_mkdir(s_pathn(3, s(ft_src), s(backing_name), s(names[0])), 0777));
+
+		TESTFUSEINIT();
+		TESTFUSELOOKUP(test_name, 0);
+
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "passthrough",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "trace_ops",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {0}),
+				fuse_bpf_entry_out, bpf_entry[0],
+				fuse_bpf_entry_out, bpf_entry[1]);
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	if (!pid)
+		exit(TEST_FAILURE);
+	close(fuse_dev);
+	close(fd);
+	umount(mount_dir);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_remove_backing(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *folder1 = "folder1";
+	const char *folder2 = "folder2";
+	const char *file = "file1";
+	const char *contents1 = "contents1";
+	const char *contents2 = "contents2";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int fd = -1;
+	int src_fd = -1;
+	int pid = -1;
+	int status;
+	char data[256] = {0};
+
+	/*
+	 * Create folder1/file
+	 *        folder2/file
+	 *
+	 * test will install bpf into mount
+	 * bpf will postfilter root lookup to daemon
+	 * daemon will remove bpf and redirect opens on folder1 to folder2
+	 * test will open folder1/file which will be redirected to folder2
+	 * test will check no traces for file, and contents are folder2/file
+	 */
+	TESTEQUAL(bpf_clear_trace(), 0);
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(file)), 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, contents1, strlen(contents1)), strlen(contents1));
+	TESTSYSCALL(close(fd));
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder2)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(ft_src), s(folder2), s(file)), 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, contents2, strlen(contents2)), strlen(contents2));
+	TESTSYSCALL(close(fd));
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.passthrough_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse_no_init(mount_dir, "passthrough", src_fd, &fuse_dev), 0);
+
+	FUSE_ACTION
+		TESTERR(fd = s_open(s_pathn(3, s(mount_dir), s(folder1),
+					    s(file)),
+				    O_RDONLY | O_CLOEXEC), fd != -1);
+		TESTEQUAL(read(fd, data, sizeof(data)), strlen(contents2));
+		TESTCOND(!strcmp(data, contents2));
+		TESTEQUAL(bpf_test_no_trace("file"), 0);
+		TESTSYSCALL(close(fd));
+		fd = -1;
+		TESTSYSCALL(umount(mount_dir));
+	FUSE_DAEMON
+		// The bpf postfilter only sets one fuse_bpf_entry_out
+		struct in_str {
+			char name[8];
+			struct fuse_entry_out feo;
+			struct fuse_bpf_entry_out febo[1];
+		} __attribute__((packed));
+		uint32_t *err_in;
+		struct in_str *in;
+		int backing_fd = -1;
+		struct fuse_bpf_entry_out bpf_entry[2];
+
+		TESTFUSEINIT();
+		TESTFUSEIN_ERR_IN(FUSE_LOOKUP | FUSE_POSTFILTER, in, err_in);
+		TESTEQUAL(*err_in, 0);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder2)),
+				 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_REMOVE_BPF,
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {0}),
+				fuse_bpf_entry_out, bpf_entry[0],
+				fuse_bpf_entry_out, bpf_entry[1]);
+
+		while (read(fuse_dev, bytes_in, sizeof(bytes_in)) != -1)
+			;
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(fd);
+	close(src_fd);
+	umount(mount_dir);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_dir_rename(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *dir_name = "dir";
+	const char *dir_name2 = "dir2";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	struct stat st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir_name)), 0777));
+	TESTEQUAL(bpf_test_trace("mkdir"), 0);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name)), &st));
+	TESTSYSCALL(s_rename(s_path(s(mount_dir), s(dir_name)),
+			     s_path(s(mount_dir), s(dir_name2))));
+	TESTEQUAL(s_stat(s_path(s(ft_src), s(dir_name)), &st), -1);
+	TESTEQUAL(errno, ENOENT);
+	TESTSYSCALL(s_stat(s_path(s(ft_src), s(dir_name2)), &st));
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_file_rename(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *dir = "dir";
+	const char *file1 = "file1";
+	const char *file2 = "file2";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s(dir)), 0777));
+	TEST(fd = s_creat(s_pathn(3, s(mount_dir), s(dir), s(file1)), 0777),
+	     fd != -1);
+	TESTSYSCALL(s_rename(s_pathn(3, s(mount_dir), s(dir), s(file1)),
+			     s_pathn(3, s(mount_dir), s(dir), s(file2))));
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int mmap_test(const char *mount_dir)
+{
+	const char *file = "file";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	char *addr = NULL;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(mount_fuse(mount_dir, NULL, src_fd, &fuse_dev), 0);
+	TEST(fd = s_open(s_path(s(mount_dir), s(file)),
+			 O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTSYSCALL(fallocate(fd, 0, 4096, SEEK_CUR));
+	TEST(addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0),
+	     addr != (void *) -1);
+	memset(addr, 'a', 4096);
+
+	result = TEST_SUCCESS;
+out:
+	munmap(addr, 4096);
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	return result;
+}
+
+static int readdir_perms_test(const char *mount_dir)
+{
+	int result = TEST_FAILURE;
+	struct __user_cap_header_struct uchs = { _LINUX_CAPABILITY_VERSION_3 };
+	struct __user_cap_data_struct ucds[2];
+	int src_fd = -1;
+	int fuse_dev = -1;
+	DIR *dir = NULL;
+
+	/* Must remove capabilities for this test. */
+	TESTSYSCALL(syscall(SYS_capget, &uchs, ucds));
+	ucds[0].effective &= ~(1 << CAP_DAC_OVERRIDE | 1 << CAP_DAC_READ_SEARCH);
+	TESTSYSCALL(syscall(SYS_capset, &uchs, ucds));
+
+	/* This is what we are testing in fuseland. First test without fuse, */
+	TESTSYSCALL(mkdir("test", 0111));
+	TEST(dir = opendir("test"), dir == NULL);
+	if (dir)
+		closedir(dir);
+	dir = NULL;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TESTEQUAL(mount_fuse(mount_dir, NULL, src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_mkdir(s_path(s(mount_dir), s("test")), 0111));
+	TEST(dir = s_opendir(s_path(s(mount_dir), s("test"))), dir == NULL);
+
+	result = TEST_SUCCESS;
+out:
+	ucds[0].effective |= 1 << CAP_DAC_OVERRIDE | 1 << CAP_DAC_READ_SEARCH;
+	syscall(SYS_capset, &uchs, ucds);
+
+	closedir(dir);
+	s_rmdir(s_path(s(mount_dir), s("test")));
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	rmdir("test");
+	return result;
+}
+
+static int bpf_test_statfs(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+	struct statfs st;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TESTSYSCALL(s_statfs(s(mount_dir), &st));
+	TESTEQUAL(bpf_test_trace("statfs"), 0);
+	TESTEQUAL(st.f_type, 0x65735546);
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static int bpf_test_lseek(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *file = "real";
+	const char *test_data = "data";
+	int result = TEST_FAILURE;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int fd = -1;
+
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(fd = openat(src_fd, file, O_CREAT | O_RDWR | O_CLOEXEC, 0777),
+	     fd != -1);
+	TESTEQUAL(write(fd, test_data, strlen(test_data)), strlen(test_data));
+	TESTSYSCALL(close(fd));
+	fd = -1;
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.test_trace_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "test_trace_ops", src_fd, &fuse_dev), 0);
+
+	TEST(fd = s_open(s_path(s(mount_dir), s(file)), O_RDONLY | O_CLOEXEC),
+	     fd != -1);
+	TESTEQUAL(lseek(fd, 3, SEEK_SET), 3);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 5, SEEK_END), 9);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 1, SEEK_CUR), 10);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	TESTEQUAL(lseek(fd, 1, SEEK_DATA), 1);
+	TESTEQUAL(bpf_test_trace("lseek"), 0);
+	result = TEST_SUCCESS;
+out:
+	close(fd);
+	umount(mount_dir);
+	close(fuse_dev);
+	close(src_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+/*
+ * State:
+ * Original: dst/folder1/content.txt
+ *                  ^
+ *                  |
+ *                  |
+ * Backing:  src/folder1/content.txt
+ *
+ * Step 1:  open(folder1) - set backing to src/folder1
+ * Check 1: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ * Step 2:  readdirplus(dst)
+ * Check 2: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ */
+static int bpf_test_readdirplus_not_overriding_backing(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *content_file = "content.txt";
+	const char *content = "hello world";
+
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int pid = -1;
+	int status;
+
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(content_fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(content_file)), 0777),
+		content_fd != -1);
+	TESTEQUAL(write(content_fd, content, strlen(content)), strlen(content));
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+
+	FUSE_ACTION
+		DIR *open_mount_dir = NULL;
+		struct dirent *mount_dirent;
+		int dst_folder1_fd = -1;
+		int dst_content_fd = -1;
+		int dst_content_read_size = -1;
+		char content_buffer[12];
+
+		// Step 1: Lookup folder1
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+
+		// Check 1: Read content file (backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		memset(content_buffer, 0, strlen(content));
+
+		// Step 2: readdir folder 1
+		TEST(open_mount_dir = s_opendir(s(mount_dir)),
+			open_mount_dir != NULL);
+		TEST(mount_dirent = readdir(open_mount_dir), mount_dirent != NULL);
+		TESTSYSCALL(closedir(open_mount_dir));
+		open_mount_dir = NULL;
+
+		// Check 2: Read content file again (must be backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+	FUSE_DAEMON
+		size_t read_size = 0;
+		struct fuse_in_header *in_header = (struct fuse_in_header *)bytes_in;
+		struct fuse_read_out *read_out = NULL;
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+		DECL_FUSE_IN(open);
+		DECL_FUSE_IN(getattr);
+
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+
+		// Step 1: Lookup folder 1 with backing
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, ((struct fuse_bpf_entry_out) {
+				.entry_type = FUSE_ENTRY_BACKING,
+				.fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+
+		// Step 2: Open root dir
+		TESTFUSEIN(FUSE_OPENDIR, open_in);
+		TESTFUSEOUT1(fuse_open_out, ((struct fuse_open_out) {
+			.fh = 100,
+			.open_flags = open_in->flags
+		}));
+
+		// Step 2: Handle getattr
+		TESTFUSEIN(FUSE_GETATTR, getattr_in);
+		TESTSYSCALL(s_fuse_attr(s(ft_src), &attr));
+		TESTFUSEOUT1(fuse_attr_out, ((struct fuse_attr_out) {
+			.attr_valid = UINT64_MAX,
+			.attr_valid_nsec = UINT32_MAX,
+			.attr = attr
+		}));
+
+		// Step 2: Handle readdirplus
+		read_size = read(fuse_dev, bytes_in, sizeof(bytes_in));
+		TESTEQUAL(in_header->opcode, FUSE_READDIRPLUS);
+
+		struct fuse_direntplus *dirent_plus =
+			(struct fuse_direntplus *) (bytes_in + read_size);
+		struct fuse_dirent dirent;
+		struct fuse_entry_out entry_out;
+
+		read_out = (struct fuse_read_out *) (bytes_in +
+					sizeof(*in_header) +
+					sizeof(struct fuse_read_in));
+
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+
+		dirent = (struct fuse_dirent) {
+			.ino = attr.ino,
+			.off = 1,
+			.namelen = strlen(folder1),
+			.type = DT_REG
+		};
+		entry_out = (struct fuse_entry_out) {
+			.nodeid = attr.ino,
+			.generation = 0,
+			.entry_valid = UINT64_MAX,
+			.attr_valid = UINT64_MAX,
+			.entry_valid_nsec = UINT32_MAX,
+			.attr_valid_nsec = UINT32_MAX,
+			.attr = attr
+		};
+		*dirent_plus = (struct fuse_direntplus) {
+			.dirent = dirent,
+			.entry_out = entry_out
+		};
+
+		strcpy((char *)(bytes_in + read_size + sizeof(*dirent_plus)), folder1);
+		read_size += FUSE_DIRENT_ALIGN(sizeof(*dirent_plus) + strlen(folder1) +
+					1);
+		TESTFUSEDIROUTREAD(read_out,
+				bytes_in +
+				sizeof(struct fuse_in_header) +
+				sizeof(struct fuse_read_in) +
+				sizeof(struct fuse_read_out),
+				read_size - sizeof(struct fuse_in_header) -
+					sizeof(struct fuse_read_in) -
+					sizeof(struct fuse_read_out));
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_no_readdirplus_without_nodeid(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *folder1 = "folder1";
+	const char *folder2 = "folder2";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.readdir_plus_ops), test_link != NULL);
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder2)), 0777));
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		DIR *open_dir = NULL;
+		struct dirent *dirent;
+
+		// Folder 1: Readdir with no nodeid
+		TEST(open_dir = s_opendir(s_path(s(ft_dst), s(folder1))),
+				open_dir != NULL);
+		TEST(dirent = readdir(open_dir), dirent == NULL);
+		TESTCOND(errno == EINVAL);
+		TESTSYSCALL(closedir(open_dir));
+		open_dir = NULL;
+
+		// Folder 2: Readdir with a nodeid
+		TEST(open_dir = s_opendir(s_path(s(ft_dst), s(folder2))),
+				open_dir != NULL);
+		TEST(dirent = readdir(open_dir), dirent == NULL);
+		TESTCOND(errno == EINVAL);
+		TESTSYSCALL(closedir(open_dir));
+		open_dir = NULL;
+	FUSE_DAEMON
+		size_t read_size;
+		struct fuse_in_header *in_header = (struct fuse_in_header *)bytes_in;
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+		struct fuse_bpf_entry_out bpf_entry[2];
+
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+
+		// folder 1: Set 0 as nodeid, Expect READDIR
+		TESTFUSELOOKUP(folder1, 0);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "readdir_plus",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = 0,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, bpf_entry[0],
+				fuse_bpf_entry_out, bpf_entry[1]);
+		TESTSYSCALL(close(backing_fd));
+		TEST(read_size = read(fuse_dev, bytes_in, sizeof(bytes_in)), read_size > 0);
+		TESTEQUAL(in_header->opcode, FUSE_READDIR);
+		TESTFUSEOUTERROR(-EINVAL);
+
+		// folder 2: Set 10 as nodeid, Expect READDIRPLUS
+		TESTFUSELOOKUP(folder2, 0);
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder2)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		bpf_entry[0] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BPF,
+			.name = "readdir_plus",
+		};
+		bpf_entry[1] = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_BACKING,
+			.fd = backing_fd,
+		};
+		TESTFUSEOUT3_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = 10,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, bpf_entry[0],
+				fuse_bpf_entry_out, bpf_entry[1]);
+		TESTSYSCALL(close(backing_fd));
+		TEST(read_size = read(fuse_dev, bytes_in, sizeof(bytes_in)), read_size > 0);
+		TESTEQUAL(in_header->opcode, FUSE_READDIRPLUS);
+		TESTFUSEOUTERROR(-EINVAL);
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	umount(mount_dir);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+/*
+ * State:
+ * Original: dst/folder1/content.txt
+ *                  ^
+ *                  |
+ *                  |
+ * Backing:  src/folder1/content.txt
+ *
+ * Step 1:  open(folder1) - lookup folder1 with entry_timeout set to 0
+ * Step 2:  open(folder1) - lookup folder1 again to trigger revalidate wich will
+ *                          set backing fd
+ *
+ * Check 1: cat(content.txt) - check not receiving call on the fuse daemon
+ *                             and content is the same
+ */
+static int bpf_test_revalidate_handle_backing_fd(const char *mount_dir)
+{
+	const char *folder1 = "folder1";
+	const char *content_file = "content.txt";
+	const char *content = "hello world";
+	int result = TEST_FAILURE;
+	int fuse_dev = -1;
+	int src_fd = -1;
+	int content_fd = -1;
+	int pid = -1;
+	int status;
+	TESTSYSCALL(s_mkdir(s_path(s(ft_src), s(folder1)), 0777));
+	TEST(content_fd = s_creat(s_pathn(3, s(ft_src), s(folder1), s(content_file)), 0777),
+		content_fd != -1);
+	TESTEQUAL(write(content_fd, content, strlen(content)), strlen(content));
+	TESTSYSCALL(close(content_fd));
+	content_fd = -1;
+	TESTEQUAL(mount_fuse_no_init(mount_dir, NULL, -1, &fuse_dev), 0);
+	FUSE_ACTION
+		int dst_folder1_fd = -1;
+		int dst_content_fd = -1;
+		int dst_content_read_size = -1;
+		char content_buffer[11] = {0};
+		// Step 1: Lookup folder1
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		// Step 2: Lookup folder1 again
+		TESTERR(dst_folder1_fd = s_open(s_path(s(mount_dir), s(folder1)),
+			O_RDONLY | O_CLOEXEC), dst_folder1_fd != -1);
+		TESTSYSCALL(close(dst_folder1_fd));
+		dst_folder1_fd = -1;
+		// Check 1: Read content file (must be backed)
+		TESTERR(dst_content_fd =
+			s_open(s_pathn(3, s(mount_dir), s(folder1), s(content_file)),
+			O_RDONLY | O_CLOEXEC), dst_content_fd != -1);
+		TEST(dst_content_read_size =
+			read(dst_content_fd, content_buffer, strlen(content)),
+			dst_content_read_size == strlen(content) &&
+			strcmp(content, content_buffer) == 0);
+		TESTSYSCALL(close(dst_content_fd));
+		dst_content_fd = -1;
+	FUSE_DAEMON
+		struct fuse_attr attr = {};
+		int backing_fd = -1;
+		TESTFUSEINITFLAGS(FUSE_DO_READDIRPLUS | FUSE_READDIRPLUS_AUTO);
+		// Step 1: Lookup folder1 set entry_timeout to 0 to trigger
+		// revalidate later
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = 0,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = 0,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, ((struct fuse_bpf_entry_out) {
+				.entry_type = FUSE_ENTRY_BACKING,
+				.fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+		// Step 1: Lookup folder1 as a reaction to revalidate call
+		// This attempts to change the backing node, which is not allowed on revalidate
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, ((struct fuse_bpf_entry_out) {
+				.entry_type = FUSE_ENTRY_BACKING,
+				.fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+
+		// Lookup folder1 as a reaction to failed revalidate
+		TESTFUSELOOKUP(folder1, 0);
+		TESTSYSCALL(s_fuse_attr(s_path(s(ft_src), s(folder1)), &attr));
+		TEST(backing_fd = s_open(s_path(s(ft_src), s(folder1)),
+					 O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+		     backing_fd != -1);
+		TESTFUSEOUT2_IOCTL(fuse_entry_out, ((struct fuse_entry_out) {
+				.nodeid = attr.ino,
+				.generation = 0,
+				.entry_valid = UINT64_MAX,
+				.attr_valid = UINT64_MAX,
+				.entry_valid_nsec = UINT32_MAX,
+				.attr_valid_nsec = UINT32_MAX,
+				.attr = attr,
+			     }), fuse_bpf_entry_out, ((struct fuse_bpf_entry_out) {
+				.entry_type = FUSE_ENTRY_BACKING,
+				.fd = backing_fd,
+			     }));
+		TESTSYSCALL(close(backing_fd));
+	FUSE_DONE
+	result = TEST_SUCCESS;
+out:
+	close(fuse_dev);
+	close(content_fd);
+	close(src_fd);
+	umount(mount_dir);
+	return result;
+}
+
+static int bpf_test_lookup_postfilter(const char *mount_dir)
+{
+	struct test_bpf *test_skel = NULL;
+	struct bpf_link *test_link = NULL;
+	const char *file1_name = "file1";
+	const char *file2_name = "file2";
+	const char *file3_name = "file3";
+	int result = TEST_FAILURE;
+	int bpf_fd = -1;
+	int src_fd = -1;
+	int fuse_dev = -1;
+	int file_fd = -1;
+	int pid = -1;
+	int status;
+
+	TEST(file_fd = s_creat(s_path(s(ft_src), s(file1_name)), 0777),
+	     file_fd != -1);
+	TESTSYSCALL(close(file_fd));
+	TEST(file_fd = s_creat(s_path(s(ft_src), s(file2_name)), 0777),
+	     file_fd != -1);
+	TESTSYSCALL(close(file_fd));
+	file_fd = -1;
+	TEST(src_fd = open(ft_src, O_DIRECTORY | O_RDONLY | O_CLOEXEC),
+	     src_fd != -1);
+	TEST(test_skel = test_bpf__open_and_load(), test_skel != NULL);
+	TEST(test_link = bpf_map__attach_struct_ops(test_skel->maps.lookup_postfilter_ops), test_link != NULL);
+	TESTEQUAL(mount_fuse(mount_dir, "lookup_post", src_fd, &fuse_dev), 0);
+	FUSE_ACTION
+		int fd = -1;
+
+		TESTEQUAL(s_open(s_path(s(mount_dir), s(file1_name)), O_RDONLY),
+			  -1);
+		TESTEQUAL(errno, ENOENT);
+		TEST(fd = s_open(s_path(s(mount_dir), s(file2_name)), O_RDONLY),
+		     fd != -1);
+		TESTSYSCALL(close(fd));
+		TESTEQUAL(s_open(s_path(s(mount_dir), s(file3_name)), O_RDONLY),
+			  -1);
+	FUSE_DAEMON
+		struct fuse_entry_out *feo;
+		uint32_t *err_in;
+
+		TESTFUSELOOKUP(file1_name, FUSE_POSTFILTER);
+		TESTFUSEOUTERROR(-ENOENT);
+
+		TESTFUSELOOKUP(file2_name, FUSE_POSTFILTER);
+		feo = (struct fuse_entry_out *) (bytes_in +
+			sizeof(struct fuse_in_header) +	strlen(file2_name) + 1);
+		TESTFUSEOUT1(fuse_entry_out, *feo);
+
+		TESTFUSELOOKUP_POST_ERRIN(file3_name, err_in);
+		TESTEQUAL(*err_in, -ENOENT);
+		TESTFUSEOUTERROR(-ENOENT);
+	FUSE_DONE
+
+	result = TEST_SUCCESS;
+out:
+	close(file_fd);
+	close(fuse_dev);
+	umount(mount_dir);
+	close(src_fd);
+	close(bpf_fd);
+	bpf_link__destroy(test_link);
+	test_bpf__destroy(test_skel);
+	return result;
+}
+
+static void parse_range(const char *ranges, bool *run_test, size_t tests)
+{
+	size_t i;
+	char *range;
+
+	for (i = 0; i < tests; ++i)
+		run_test[i] = false;
+
+	range = strtok(optarg, ",");
+	while (range) {
+		char *dash = strchr(range, '-');
+
+		if (dash) {
+			size_t start = 1, end = tests;
+			char *end_ptr;
+
+			if (dash > range) {
+				start = strtol(range, &end_ptr, 10);
+				if (*end_ptr != '-' || start <= 0 || start > tests)
+					ksft_exit_fail_msg("Bad range\n");
+			}
+
+			if (dash[1]) {
+				end = strtol(dash + 1, &end_ptr, 10);
+				if (*end_ptr || end <= start || end > tests)
+					ksft_exit_fail_msg("Bad range\n");
+			}
+
+			for (i = start; i <= end; ++i)
+				run_test[i - 1] = true;
+		} else {
+			char *end;
+			long value = strtol(range, &end, 10);
+
+			if (*end || value <= 0 || value > tests)
+				ksft_exit_fail_msg("Bad range\n");
+			run_test[value - 1] = true;
+		}
+		range = strtok(NULL, ",");
+	}
+}
+
+static int parse_options(int argc, char *const *argv, bool *run_test,
+			 size_t tests)
+{
+	signed char c;
+
+	while ((c = getopt(argc, argv, "f:t:v")) != -1)
+		switch (c) {
+		case 'f':
+			test_options.file = strtol(optarg, NULL, 10);
+			break;
+
+		case 't':
+			parse_range(optarg, run_test, tests);
+			break;
+
+		case 'v':
+			test_options.verbose = true;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+	return 0;
+}
+
+struct test_case {
+	int (*pfunc)(const char *dir);
+	const char *name;
+};
+
+static void run_one_test(const char *mount_dir,
+			 const struct test_case *test_case)
+{
+	ksft_print_msg("Running %s\n", test_case->name);
+	bpf_clear_trace();
+	if (test_case->pfunc(mount_dir) == TEST_SUCCESS)
+		ksft_test_result_pass("%s\n", test_case->name);
+	else
+		ksft_test_result_fail("%s\n", test_case->name);
+}
+
+int main(int argc, char *argv[])
+{
+	char *mount_dir = NULL;
+	char *src_dir = NULL;
+	int i;
+	int fd, count;
+
+#define MAKE_TEST(test)                                                        \
+	{                                                                      \
+		test, #test                                                    \
+	}
+	const struct test_case cases[] = {
+		MAKE_TEST(basic_test),
+		MAKE_TEST(bpf_test_real),
+		MAKE_TEST(bpf_test_partial),
+		MAKE_TEST(bpf_test_attrs),
+		MAKE_TEST(bpf_test_readdir),
+		MAKE_TEST(bpf_test_creat),
+		MAKE_TEST(bpf_test_hidden_entries),
+		MAKE_TEST(bpf_test_dir),
+		MAKE_TEST(bpf_test_file_early_close),
+		MAKE_TEST(bpf_test_file_late_close),
+		MAKE_TEST(bpf_test_mknod),
+		MAKE_TEST(bpf_test_largedir),
+		MAKE_TEST(bpf_test_link),
+		MAKE_TEST(bpf_test_symlink),
+		MAKE_TEST(bpf_test_xattr),
+		MAKE_TEST(bpf_test_redact_readdir),
+		MAKE_TEST(bpf_test_set_backing),
+		MAKE_TEST(bpf_test_set_backing_no_ioctl),
+		MAKE_TEST(bpf_test_set_backing_folder),
+		MAKE_TEST(bpf_test_remove_backing),
+		MAKE_TEST(bpf_test_dir_rename),
+		MAKE_TEST(bpf_test_file_rename),
+		MAKE_TEST(bpf_test_alter_errcode_bpf),
+		MAKE_TEST(bpf_test_alter_errcode_userspace),
+		MAKE_TEST(mmap_test),
+		MAKE_TEST(readdir_perms_test),
+		MAKE_TEST(bpf_test_statfs),
+		MAKE_TEST(bpf_test_lseek),
+		MAKE_TEST(bpf_test_readdirplus_not_overriding_backing),
+		MAKE_TEST(bpf_test_no_readdirplus_without_nodeid),
+		MAKE_TEST(bpf_test_revalidate_handle_backing_fd),
+		MAKE_TEST(bpf_test_lookup_postfilter),
+		//MAKE_TEST(bpf_test_verifier),
+		//MAKE_TEST(bpf_test_verifier_out_args),
+		//MAKE_TEST(bpf_test_verifier_packet_invalidation),
+		//MAKE_TEST(bpf_test_verifier_nonsense_read)
+	};
+#undef MAKE_TEST
+
+	bool run_test[ARRAY_SIZE(cases)];
+
+	for (int i = 0; i < ARRAY_SIZE(cases); ++i)
+		run_test[i] = true;
+
+	if (parse_options(argc, argv, run_test, ARRAY_SIZE(cases)))
+		ksft_exit_fail_msg("Bad options\n");
+
+	// Seed randomness pool for testing on QEMU
+	// NOTE - this abuses the concept of randomness - do *not* ever do this
+	// on a machine for production use - the device will think it has good
+	// randomness when it does not.
+	fd = open("/dev/urandom", O_WRONLY | O_CLOEXEC);
+	count = 4096;
+	for (int i = 0; i < 128; ++i)
+		ioctl(fd, RNDADDTOENTCNT, &count);
+	close(fd);
+
+	ksft_print_header();
+
+	if (geteuid() != 0)
+		ksft_print_msg("Not a root, might fail to mount.\n");
+
+	if (tracing_on() != TEST_SUCCESS)
+		ksft_exit_fail_msg("Can't turn on tracing\n");
+
+	src_dir = setup_mount_dir(ft_src);
+	mount_dir = setup_mount_dir(ft_dst);
+	if (src_dir == NULL || mount_dir == NULL)
+		ksft_exit_fail_msg("Can't create a mount dir\n");
+
+	ksft_set_plan(ARRAY_SIZE(run_test));
+
+	for (i = 0; i < ARRAY_SIZE(run_test); ++i)
+		if (run_test[i]) {
+			delete_dir_tree(mount_dir, false);
+			delete_dir_tree(src_dir, false);
+			run_one_test(mount_dir, &cases[i]);
+		} else
+			ksft_cnt.ksft_xskip++;
+
+	umount2(mount_dir, MNT_FORCE);
+	delete_dir_tree(mount_dir, true);
+	delete_dir_tree(src_dir, true);
+	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
+}
diff --git a/tools/testing/selftests/filesystems/fuse/test.bpf.c b/tools/testing/selftests/filesystems/fuse/test.bpf.c
new file mode 100644
index 000000000000..3128bf50016f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test.bpf.c
@@ -0,0 +1,996 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2021 Google LLC
+
+#include "vmlinux.h"
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+#include <stdbool.h>
+
+#include "bpf_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+#if 0
+inline __always_inline int local_strcmp(const char *a, const char *b)
+{
+	int i;
+
+	for (i = 0; i < __builtin_strlen(b) + 1; ++i)
+		if (a[i] != b[i])
+			return -1;
+	return 0;
+}
+
+
+/* This is a macro to enforce inlining. Without it, the compiler will do the wrong thing for bpf */
+#define strcmp_check(a, b, end_b) \
+		(((b) + __builtin_strlen(a) + 1 > (end_b)) ? -1 : local_strcmp((b), (a)))
+#endif
+
+//trace ops
+
+BPF_STRUCT_OPS(uint32_t, trace_access_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_access_in *in)
+{
+	bpf_printk("Access: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_getattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in)
+{
+	bpf_printk("Get Attr %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_setattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in)
+{
+	bpf_printk("Set Attr %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_opendir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("Open Dir: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_readdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("Read Dir: fh: %lu", in->fh, in->offset);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 1);
+	bpf_printk("Lookup: %lx %s", meta->nodeid, name_buf);
+	if (meta->nodeid == 1)
+		return BPF_FUSE_USER_PREFILTER;
+	else
+		return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_mknod_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mknod_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("mknod %s %x %x", name_buf,  in->rdev | in->mode, in->umask);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_mkdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("mkdir: %s %x %x", name_buf, in->mode, in->umask);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rmdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("rmdir: %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rename_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	struct bpf_dynptr old_name_ptr;
+	struct bpf_dynptr new_name_ptr;
+	char old_name_buf[255];
+	//char new_name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(old_name, &old_name_ptr);
+	//bpf_fuse_get_ro_dynptr(new_name, &new_name_ptr);
+	bpf_dynptr_read(old_name_buf, 255, &old_name_ptr, 0, 0);
+	//bpf_dynptr_read(new_name_buf, 255, &new_name_ptr, 0, 0);
+	bpf_printk("rename from %s", old_name_buf);
+	//bpf_printk("rename to %s", new_name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_rename2_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_rename2_in *in, struct fuse_buffer *old_name,
+				struct fuse_buffer *new_name)
+{
+	struct bpf_dynptr old_name_ptr;
+	//struct bpf_dynptr new_name_ptr;
+	char old_name_buf[255];
+	//char new_name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(old_name, &old_name_ptr);
+	//bpf_fuse_get_ro_dynptr(new_name, &new_name_ptr);
+	bpf_dynptr_read(old_name_buf, 255, &old_name_ptr, 0, 0);
+	//bpf_dynptr_read(new_name_buf, 255, &new_name_ptr, 0, 0);
+	bpf_printk("rename(%x) from %s", in->flags, old_name_buf);
+	//bpf_printk("rename to %s", new_name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_unlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("unlink: %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_link_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char dst_name[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(dst_name, 255, &name_ptr, 0, 0);
+	bpf_printk("link: %d %s", in->oldnodeid, dst_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_symlink_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name, struct fuse_buffer *path)
+{
+	struct bpf_dynptr name_ptr;
+	//struct bpf_dynptr path_ptr;
+	char link_name[255];
+	//char link_path[4096];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	//bpf_fuse_get_ro_dynptr(path, &path_ptr);
+	bpf_dynptr_read(link_name, 255, &name_ptr, 0, 0);
+	//bpf_dynptr_read(link_path, 4096, &path_ptr, 0, 0);
+
+	bpf_printk("symlink from %s", link_name);
+	//bpf_printk("symlink to %s", link_path);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_get_link_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char link_name[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(link_name, 255, &name_ptr, 0, 0);
+	bpf_printk("readlink from %s", link_name);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_release_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("Release: %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_releasedir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_release_in *in)
+{
+	bpf_printk("Release Dir: %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_create_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_create_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("Create %s", name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	bpf_printk("Open: %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_read_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("Read: fh: %lu, offset %lu, size %lu",
+			   in->fh, in->offset, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_write_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_write_in *in)
+{
+	bpf_printk("Write: fh: %lu, offset %lu, size %lu",
+			   in->fh, in->offset, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_flush_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_flush_in *in)
+{
+	bpf_printk("flush %d", in->fh);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_file_fallocate_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_fallocate_in *in)
+{
+	bpf_printk("fallocate %d %lu", in->fh, in->length);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_getxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in, struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("getxattr %d %s", meta->nodeid, name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_listxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getxattr_in *in)
+{
+	bpf_printk("listxattr %d %d", meta->nodeid, in->size);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_setxattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setxattr_in *in, struct fuse_buffer *name,
+					struct fuse_buffer *value)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("setxattr %d %s", meta->nodeid, name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_removexattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char name_buf[255];
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	bpf_dynptr_read(name_buf, 255, &name_ptr, 0, 0);
+	bpf_printk("removexattr %d %s", meta->nodeid, name_buf);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_statfs_prefilter, const struct bpf_fuse_meta_info *meta)
+{
+	bpf_printk("statfs %d", meta->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, trace_lseek_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_lseek_in *in)
+{
+	bpf_printk("lseek type:%d, offset:%lld", in->whence, in->offset);
+	return BPF_FUSE_CONTINUE;
+}
+
+// readdir_test_ops
+BPF_STRUCT_OPS(uint32_t, readdir_redact_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("readdir %d", in->fh);
+	return BPF_FUSE_POSTFILTER;
+}
+
+BPF_STRUCT_OPS(uint32_t, readdir_redact_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_out *out, struct fuse_buffer *buffer)
+{
+	bpf_printk("readdir postfilter %x", in->fh);
+	return BPF_FUSE_USER_POSTFILTER;
+}
+
+// test operations
+
+BPF_STRUCT_OPS(uint32_t, test_lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+	bool backing = false;
+	int ret;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+
+	/* bpf_dynptr_slice will only return a pointer if the dynptr is long enough */
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 8);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 8, "partial") == 0)
+			backing = true;
+		goto print;
+	}
+	
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 6);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 6, "file1") == 0)
+			backing = true;
+		if (bpf_strncmp(name_buf, 6, "file2") == 0)
+			backing = true;
+		goto print;
+	}
+
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 5);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 5, "dir2") == 0)
+			backing = true;
+		if (bpf_strncmp(name_buf, 5, "real") == 0)
+			backing = true;
+		goto print;
+	}
+
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 4);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 4, "dir") == 0)
+			backing = true;
+		goto print;
+	}
+print:
+	if (name_buf)
+		bpf_printk("lookup %s %d", name_buf, backing);
+	else
+		bpf_printk("lookup [name length under 3] %d", backing);
+	return backing ? BPF_FUSE_POSTFILTER : BPF_FUSE_USER;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_lookup_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 8);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 8, "partial") == 0)
+			out->nodeid = 6;
+		goto print;
+	}
+	
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 5);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 5, "real") == 0)
+			out->nodeid = 5;
+		goto print;
+	}
+print:
+	if (name_buf)
+		bpf_printk("post-lookup %s %d", name_buf, out->nodeid);
+	else
+		bpf_printk("post-lookup [name length under 4] %d", out->nodeid);
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_open_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	int backing = BPF_FUSE_USER;
+
+	switch (meta->nodeid) {
+	case 5:
+		backing = BPF_FUSE_CONTINUE;
+		bpf_printk("Setting BPF_FUSE_CONTINUE:%d", BPF_FUSE_CONTINUE);
+		break;
+
+	case 6:
+		backing = BPF_FUSE_POSTFILTER;
+		bpf_printk("Setting BPF_FUSE_CONTINUE:%d", BPF_FUSE_POSTFILTER);
+		break;
+
+	default:
+		bpf_printk("Setting NOTHING %d", BPF_FUSE_USER);
+		break;
+	}
+
+	bpf_printk("open: %d %d", meta->nodeid, backing);
+	return backing;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_open_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	bpf_printk("open postfilter");
+	return BPF_FUSE_USER_POSTFILTER;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_read_iter_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	bpf_printk("read %llu %llu", in->fh, in->offset);
+	if (in->fh == 1 && in->offset == 0)
+		return BPF_FUSE_USER;
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_getattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_getattr_in *in)
+{
+	/* real and partial use backing file */
+	int backing = BPF_FUSE_USER;
+
+	switch (meta->nodeid) {
+	case 1:
+	case 5:
+	case 6:
+	/*
+	 * TODO: Find better solution
+	 * Add 100 to stop clang compiling to jump table which bpf hates
+	 */
+	case 100:
+		backing = BPF_FUSE_CONTINUE;
+		break;
+	}
+
+	bpf_printk("getattr %d %d", meta->nodeid, backing);
+	return backing;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_setattr_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_setattr_in *in)
+{
+	/* real and partial use backing file */
+	int backing = BPF_FUSE_USER;
+
+	switch (meta->nodeid) {
+	case 1:
+	case 5:
+	case 6:
+	/* TODO See above */
+	case 100:
+		backing = BPF_FUSE_CONTINUE;
+		break;
+	}
+
+	bpf_printk("setattr %d %d", meta->nodeid, backing);
+	return backing;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_opendir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_open_in *in)
+{
+	int backing = BPF_FUSE_USER;
+
+	switch (meta->nodeid) {
+	case 1:
+		backing = BPF_FUSE_POSTFILTER;
+		break;
+	}
+	bpf_printk("opendir %d %d", meta->nodeid, backing);
+	return backing;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_opendir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_open_in *in,
+				struct fuse_open_out *out)
+{
+	out->fh = 2;
+	bpf_printk("opendir postfilter");
+	return BPF_FUSE_CONTINUE;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_readdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	int backing = BPF_FUSE_USER;
+
+	if (in->fh == 2)
+		backing = BPF_FUSE_POSTFILTER;
+
+	bpf_printk("readdir %d %d", in->fh, backing);
+	return backing;
+}
+
+BPF_STRUCT_OPS(uint32_t, test_readdir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_read_in *in,
+				struct fuse_read_out *out, struct fuse_buffer *buffer)
+{
+	int backing = BPF_FUSE_CONTINUE;
+
+	if (in->fh == 2)
+		backing = BPF_FUSE_USER_POSTFILTER;
+
+	bpf_printk("readdir postfilter %d %d", in->fh, backing);
+	return backing;
+}
+
+// test_hidden
+
+BPF_STRUCT_OPS(uint32_t, hidden_lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+	bool backing = false;
+	int ret;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+
+	/* bpf_dynptr_slice will only return a pointer if the dynptr is long enough */
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 5);
+	if (name_buf)
+		bpf_printk("Lookup: %s", name_buf);
+	else
+		bpf_printk("lookup [name length under 4]");
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 5, "show") == 0)
+			return BPF_FUSE_CONTINUE;
+		if (bpf_strncmp(name_buf, 5, "hide") == 0)
+			return -ENOENT;
+	}
+
+	return BPF_FUSE_CONTINUE;
+}
+
+// test_error
+
+BPF_STRUCT_OPS(uint32_t, error_mkdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_mkdir_in *in, struct fuse_buffer *name)
+{
+	bpf_printk("mkdir");
+
+	return BPF_FUSE_POSTFILTER;
+}
+
+BPF_STRUCT_OPS(uint32_t, error_mkdir_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_mkdir_in *in, const struct fuse_buffer *name)
+{
+	bpf_printk("mkdir postfilter");
+
+	if (meta->error_in == -EEXIST)
+		return -EPERM;
+	return 0;
+}
+
+BPF_STRUCT_OPS(uint32_t, error_lookup_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_buffer *name)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+	bool backing = false;
+	int ret;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+
+	/* bpf_dynptr_slice will only return a pointer if the dynptr is long enough */
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 1);
+	bpf_printk("lookup prefilter %s", name);
+	return BPF_FUSE_POSTFILTER;
+}
+
+BPF_STRUCT_OPS(uint32_t, error_lookup_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	struct bpf_dynptr name_ptr;
+	char *name_buf;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 13);
+	if (name_buf)
+		bpf_printk("post-lookup %s %d", name_buf, out->nodeid);
+	else
+		bpf_printk("post-lookup [name length under 13] %d", out->nodeid);
+	if (name_buf) {
+		if (bpf_strncmp(name_buf, 13, "doesnotexist") == 0) {
+			bpf_printk("lookup postfilter doesnotexist");
+			return BPF_FUSE_USER_POSTFILTER;
+		}
+	}
+	
+	return 0;
+}
+
+// test readdirplus
+
+BPF_STRUCT_OPS(uint32_t, readdirplus_readdir_prefilter, const struct bpf_fuse_meta_info *meta,
+				struct fuse_read_in *in)
+{
+	return BPF_FUSE_USER;
+}
+
+// Test passthrough
+
+// Reuse error_lookup_prefilter
+
+BPF_STRUCT_OPS(uint32_t, passthrough_lookup_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	struct bpf_dynptr name_ptr;
+	struct bpf_dynptr entries_ptr;
+	char *name_buf;
+	struct fuse_bpf_entry_out entry;
+
+	bpf_fuse_get_ro_dynptr(name, &name_ptr);
+	name_buf = bpf_dynptr_slice(&name_ptr, 0, NULL, 1);
+	if (name_buf)
+		bpf_printk("post-lookup %s %d", name_buf, out->nodeid);
+	else
+		bpf_printk("post-lookup [name length under 1???] %d", out->nodeid);
+	bpf_fuse_get_rw_dynptr(entries, &entries_ptr, sizeof(entry), false);
+	entry = (struct fuse_bpf_entry_out) {
+			.entry_type = FUSE_ENTRY_REMOVE_BPF,
+		};
+	bpf_dynptr_write(&entries_ptr, 0, &entry, sizeof(entry), 0);
+	
+	return BPF_FUSE_USER_POSTFILTER;
+}
+
+// lookup_postfilter_ops
+
+//reuse error_lookup_prefilter
+
+BPF_STRUCT_OPS(uint32_t, test_bpf_lookup_postfilter, const struct bpf_fuse_meta_info *meta,
+				const struct fuse_buffer *name,
+				struct fuse_entry_out *out, struct fuse_buffer *entries)
+{
+	return BPF_FUSE_USER_POSTFILTER;
+}
+
+SEC(".struct_ops")
+struct fuse_ops trace_ops = {
+	.open_prefilter = (void *)trace_open_prefilter,
+	.opendir_prefilter = (void *)trace_opendir_prefilter,
+	.create_open_prefilter = (void *)trace_create_open_prefilter,
+	.release_prefilter = (void *)trace_release_prefilter,
+	.releasedir_prefilter = (void *)trace_releasedir_prefilter,
+	.flush_prefilter = (void *)trace_flush_prefilter,
+	.lseek_prefilter = (void *)trace_lseek_prefilter,
+	//.copy_file_range_prefilter = (void *)trace_copy_file_range_prefilter,
+	//.fsync_prefilter = (void *)trace_fsync_prefilter,
+	//.dir_fsync_prefilter = (void *)trace_dir_fsync_prefilter,
+	.getxattr_prefilter = (void *)trace_getxattr_prefilter,
+	.listxattr_prefilter = (void *)trace_listxattr_prefilter,
+	.setxattr_prefilter = (void *)trace_setxattr_prefilter,
+	.removexattr_prefilter = (void *)trace_removexattr_prefilter,
+	.read_iter_prefilter = (void *)trace_read_iter_prefilter,
+	.write_iter_prefilter = (void *)trace_write_iter_prefilter,
+	.file_fallocate_prefilter = (void *)trace_file_fallocate_prefilter,
+	.lookup_prefilter = (void *)trace_lookup_prefilter,
+	.mknod_prefilter = (void *)trace_mknod_prefilter,
+	.mkdir_prefilter = (void *)trace_mkdir_prefilter,
+	.rmdir_prefilter = (void *)trace_rmdir_prefilter,
+	.rename2_prefilter = (void *)trace_rename2_prefilter,
+	.rename_prefilter = (void *)trace_rename_prefilter,
+	.unlink_prefilter = (void *)trace_unlink_prefilter,
+	.link_prefilter = (void *)trace_link_prefilter,
+	.getattr_prefilter = (void *)trace_getattr_prefilter,
+	.setattr_prefilter = (void *)trace_setattr_prefilter,
+	.statfs_prefilter = (void *)trace_statfs_prefilter,
+	.get_link_prefilter = (void *)trace_get_link_prefilter,
+	.symlink_prefilter = (void *)trace_symlink_prefilter,
+	.readdir_prefilter = (void *)trace_readdir_prefilter,
+	.access_prefilter = (void *)trace_access_prefilter,
+	.name = "trace_ops",
+};
+
+SEC(".struct_ops")
+struct fuse_ops test_trace_ops = {
+	.open_prefilter = (void *)test_open_prefilter,
+	.open_postfilter = (void *)test_open_postfilter,
+	.opendir_prefilter = (void *)test_opendir_prefilter,
+	.opendir_postfilter = (void *)test_opendir_postfilter,
+	.create_open_prefilter = (void *)trace_create_open_prefilter,
+	.release_prefilter = (void *)trace_release_prefilter,
+	.releasedir_prefilter = (void *)trace_releasedir_prefilter,
+	.flush_prefilter = (void *)trace_flush_prefilter,
+	.lseek_prefilter = (void *)trace_lseek_prefilter,
+	//.copy_file_range_prefilter = (void *)trace_copy_file_range_prefilter,
+	//.fsync_prefilter = (void *)trace_fsync_prefilter,
+	//.dir_fsync_prefilter = (void *)trace_dir_fsync_prefilter,
+	.getxattr_prefilter = (void *)trace_getxattr_prefilter,
+	.listxattr_prefilter = (void *)trace_listxattr_prefilter,
+	.setxattr_prefilter = (void *)trace_setxattr_prefilter,
+	.removexattr_prefilter = (void *)trace_removexattr_prefilter,
+	.read_iter_prefilter = (void *)test_read_iter_prefilter,
+	.write_iter_prefilter = (void *)trace_write_iter_prefilter,
+	.file_fallocate_prefilter = (void *)trace_file_fallocate_prefilter,
+	.lookup_prefilter = (void *)test_lookup_prefilter,
+	.lookup_postfilter = (void *)test_lookup_postfilter,
+	.mknod_prefilter = (void *)trace_mknod_prefilter,
+	.mkdir_prefilter = (void *)trace_mkdir_prefilter,
+	.rmdir_prefilter = (void *)trace_rmdir_prefilter,
+	.rename2_prefilter = (void *)trace_rename2_prefilter,
+	.rename_prefilter = (void *)trace_rename_prefilter,
+	.unlink_prefilter = (void *)trace_unlink_prefilter,
+	.link_prefilter = (void *)trace_link_prefilter,
+	.getattr_prefilter = (void *)test_getattr_prefilter,
+	.setattr_prefilter = (void *)test_setattr_prefilter,
+	.statfs_prefilter = (void *)trace_statfs_prefilter,
+	.get_link_prefilter = (void *)trace_get_link_prefilter,
+	.symlink_prefilter = (void *)trace_symlink_prefilter,
+	.readdir_prefilter = (void *)test_readdir_prefilter,
+	.readdir_postfilter = (void *)test_readdir_postfilter,
+	.access_prefilter = (void *)trace_access_prefilter,
+	.name = "test_trace_ops",
+};
+
+SEC(".struct_ops")
+struct fuse_ops readdir_redact_ops = {
+	.readdir_prefilter = (void *)readdir_redact_prefilter,
+	.readdir_postfilter = (void *)readdir_redact_postfilter,
+	.name = "readdir_redact",
+};
+
+SEC(".struct_ops")
+struct fuse_ops test_hidden_ops = {
+	.lookup_prefilter = (void *)hidden_lookup_prefilter,
+	.access_prefilter = (void *)trace_access_prefilter,
+	.create_open_prefilter = (void *)trace_create_open_prefilter,
+	.name = "test_hidden",
+};
+
+SEC(".struct_ops")
+struct fuse_ops test_error_ops = {
+	.lookup_prefilter = (void *)error_lookup_prefilter,
+	.lookup_postfilter = (void *)error_lookup_postfilter,
+	.mkdir_prefilter = (void *)error_mkdir_prefilter,
+	.mkdir_postfilter = (void *)error_mkdir_postfilter,
+	.name = "test_error",
+};
+
+SEC(".struct_ops")
+struct fuse_ops readdir_plus_ops = {
+	.readdir_prefilter = (void *)readdirplus_readdir_prefilter,
+	.name = "readdir_plus",
+};
+
+SEC(".struct_ops")
+struct fuse_ops passthrough_ops = {
+	.lookup_prefilter = (void *)error_lookup_prefilter,
+	.lookup_postfilter = (void *)passthrough_lookup_postfilter,
+	.name = "passthrough",
+};
+
+SEC(".struct_ops")
+struct fuse_ops lookup_postfilter_ops = {
+	.lookup_prefilter = (void *)error_lookup_prefilter,
+	.lookup_postfilter = (void *)test_bpf_lookup_postfilter,
+	.name = "lookup_post",
+};
+
+#if 0
+//TODO: Figure out what to do with these
+SEC("test_verify")
+
+int verify_test(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		const struct fuse_mkdir_in *in;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[0].end_offset;
+		if (start + sizeof(*in) <= end) {
+			in = (struct fuse_mkdir_in *)(start);
+			bpf_printk("test1: %d %d", in->mode, in->umask);
+		}
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail")
+
+int verify_fail_test(struct __bpf_fuse_args *fa)
+{
+	struct t {
+		uint32_t a;
+		uint32_t b;
+		char d[];
+	};
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		const struct t *c;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[0].end_offset;
+		if (start + sizeof(struct t) <= end) {
+			c = (struct t *)start;
+			bpf_printk("test1: %d %d %d", c->a, c->b, c->d[0]);
+		}
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail2")
+
+int verify_fail_test2(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_MKDIR | FUSE_PREFILTER)) {
+		const char *start;
+		const char *end;
+		struct fuse_mkdir_in *c;
+
+		start = (void *)(long) fa->in_args[0].value;
+		end = (void *)(long) fa->in_args[1].end_offset;
+		if (start + sizeof(*c) <= end) {
+			c = (struct fuse_mkdir_in *)start;
+			bpf_printk("test1: %d %d", c->mode, c->umask);
+		}
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail3")
+/* Cannot write directly to fa */
+int verify_fail_test3(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		struct fuse_entry_out *feo = fa_verify_out(fa, 0, sizeof(*feo));
+
+		if (!feo)
+			return -1;
+
+		if (strcmp_check("real", name, end) == 0)
+			feo->nodeid = 5;
+		else if (strcmp_check("partial", name, end) == 0)
+			feo->nodeid = 6;
+
+		bpf_printk("post-lookup %s %d", name, feo->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail4")
+/* Cannot write outside of requested area */
+int verify_fail_test4(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		const char *name = (void *)(long)fa->in_args[0].value;
+		const char *end = (void *)(long)fa->in_args[0].end_offset;
+		struct fuse_entry_out *feo = bpf_make_writable_out(fa, 0, fa->out_args[0].value,
+								   1, true);
+
+		if (!feo)
+			return -1;
+
+		if (strcmp_check("real", name, end) == 0)
+			feo->nodeid = 5;
+		else if (strcmp_check("partial", name, end) == 0)
+			feo->nodeid = 6;
+
+		bpf_printk("post-lookup %s %d", name, feo->nodeid);
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail5")
+/* Cannot use old verification after requesting writable */
+int verify_fail_test5(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		struct fuse_entry_out *feo;
+		struct fuse_entry_out *feo_w;
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (!feo)
+			return -1;
+
+		feo_w = bpf_make_writable_out(fa, 0, fa->out_args[0].value, sizeof(*feo_w), true);
+		bpf_printk("post-lookup %d", feo->nodeid);
+		if (!feo_w)
+			return -1;
+
+		feo_w->nodeid = 5;
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify5")
+/* Can use new verification after requesting writable */
+int verify_pass_test5(struct __bpf_fuse_args *fa)
+{
+	if (fa->opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) {
+		struct fuse_entry_out *feo;
+		struct fuse_entry_out *feo_w;
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (!feo)
+			return -1;
+
+		bpf_printk("post-lookup %d", feo->nodeid);
+
+		feo_w = bpf_make_writable_out(fa, 0, fa->out_args[0].value, sizeof(*feo_w), true);
+
+		feo = fa_verify_out(fa, 0, sizeof(*feo));
+		if (feo)
+			bpf_printk("post-lookup %d", feo->nodeid);
+		if (!feo_w)
+			return -1;
+
+		feo_w->nodeid = 5;
+
+		return BPF_FUSE_CONTINUE;
+	}
+	return BPF_FUSE_CONTINUE;
+}
+
+SEC("test_verify_fail6")
+/* Reading context from a nonsense offset is not allowed */
+int verify_pass_test6(struct __bpf_fuse_args *fa)
+{
+	char *nonsense = (char *)fa;
+
+	bpf_printk("post-lookup %d", nonsense[1]);
+
+	return BPF_FUSE_CONTINUE;
+}
+#endif
diff --git a/tools/testing/selftests/filesystems/fuse/test_framework.h b/tools/testing/selftests/filesystems/fuse/test_framework.h
new file mode 100644
index 000000000000..24896b5e172f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_framework.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Google LLC
+ */
+
+#ifndef _TEST_FRAMEWORK_H
+#define _TEST_FRAMEWORK_H
+
+#include <stdbool.h>
+#include <stdio.h>
+
+#ifdef __ANDROID__
+static int test_case_pass;
+static int test_case_fail;
+#define ksft_print_msg			printf
+#define ksft_test_result_pass(...)	({test_case_pass++; printf(__VA_ARGS__); })
+#define ksft_test_result_fail(...)	({test_case_fail++; printf(__VA_ARGS__); })
+#define ksft_exit_fail_msg(...)		printf(__VA_ARGS__)
+#define ksft_print_header()
+#define ksft_set_plan(cnt)
+#define ksft_get_fail_cnt()		test_case_fail
+#define ksft_exit_pass()		0
+#define ksft_exit_fail()		1
+#else
+#include <kselftest.h>
+#endif
+
+#define TEST_FAILURE 1
+#define TEST_SUCCESS 0
+
+#define ptr_to_u64(p) ((__u64)p)
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define le16_to_cpu(x)          (x)
+#define le32_to_cpu(x)          (x)
+#define le64_to_cpu(x)          (x)
+#else
+#error Big endian not supported!
+#endif
+
+struct _test_options {
+	int file;
+	bool verbose;
+};
+
+extern struct _test_options test_options;
+
+#define TESTCOND(condition)						\
+	do {								\
+		if (!(condition)) {					\
+			ksft_print_msg("%s failed %d\n",		\
+				       __func__, __LINE__);		\
+			goto out;					\
+		} else if (test_options.verbose)			\
+			ksft_print_msg("%s succeeded %d\n",		\
+				       __func__, __LINE__);		\
+	} while (false)
+
+#define TESTCONDERR(condition)						\
+	do {								\
+		if (!(condition)) {					\
+			ksft_print_msg("%s failed %d\n",		\
+				       __func__, __LINE__);		\
+			ksft_print_msg("Error %d (\"%s\")\n",		\
+				       errno, strerror(errno));		\
+			goto out;					\
+		} else if (test_options.verbose)			\
+			ksft_print_msg("%s succeeded %d\n",		\
+				       __func__, __LINE__);		\
+	} while (false)
+
+#define TEST(statement, condition)					\
+	do {								\
+		statement;						\
+		TESTCOND(condition);					\
+	} while (false)
+
+#define TESTERR(statement, condition)					\
+	do {								\
+		statement;						\
+		TESTCONDERR(condition);					\
+	} while (false)
+
+enum _operator {
+	_eq,
+	_ne,
+	_ge,
+};
+
+static const char * const _operator_name[] = {
+	"==",
+	"!=",
+	">=",
+};
+
+#define _TEST_OPERATOR(name, _type, format_specifier)			\
+static inline int _test_operator_##name(const char *func, int line,	\
+				_type a, _type b, enum _operator o)	\
+{									\
+	bool pass;							\
+	switch (o) {							\
+	case _eq: pass = a == b; break;					\
+	case _ne: pass = a != b; break;					\
+	case _ge: pass = a >= b; break;					\
+	}								\
+									\
+	if (!pass)							\
+		ksft_print_msg("Failed: %s at line %d, "		\
+			       format_specifier " %s "			\
+			       format_specifier	"\n",			\
+			       func, line, a, _operator_name[o], b);	\
+	else if (test_options.verbose)					\
+		ksft_print_msg("Passed: %s at line %d, "		\
+			       format_specifier " %s "			\
+			       format_specifier "\n",			\
+			       func, line, a, _operator_name[o], b);	\
+									\
+	return pass ? TEST_SUCCESS : TEST_FAILURE;			\
+}
+
+_TEST_OPERATOR(i, int, "%d")
+_TEST_OPERATOR(ui, unsigned int, "%u")
+_TEST_OPERATOR(lui, unsigned long, "%lu")
+_TEST_OPERATOR(ss, ssize_t, "%zd")
+_TEST_OPERATOR(vp, void *, "%px")
+_TEST_OPERATOR(cp, char *, "%px")
+
+#define _CALL_TO(_type, name, a, b, o)					\
+	_type:_test_operator_##name(__func__, __LINE__,			\
+				  (_type) (long long) (a),		\
+				  (_type) (long long) (b), o)
+
+#define TESTOPERATOR(a, b, o)						\
+	do {								\
+		if (_Generic((a),					\
+			     _CALL_TO(int, i, a, b, o),			\
+			     _CALL_TO(unsigned int, ui, a, b, o),	\
+			     _CALL_TO(unsigned long, lui, a, b, o),	\
+			     _CALL_TO(ssize_t, ss, a, b, o),		\
+			     _CALL_TO(void *, vp, a, b, o),		\
+			     _CALL_TO(char *, cp, a, b, o)		\
+		))							\
+			goto out;					\
+	} while (false)
+
+#define TESTEQUAL(a, b) TESTOPERATOR(a, b, _eq)
+#define TESTNE(a, b) TESTOPERATOR(a, b, _ne)
+#define TESTGE(a, b) TESTOPERATOR(a, b, _ge)
+
+/* For testing a syscall that returns 0 on success and sets errno otherwise */
+#define TESTSYSCALL(statement) TESTCONDERR((statement) == 0)
+
+static inline void print_bytes(const void *data, size_t size)
+{
+	const char *bytes = data;
+	int i;
+
+	for (i = 0; i < size; ++i) {
+		if (i % 0x10 == 0)
+			printf("%08x:", i);
+		printf("%02x ", (unsigned int) (unsigned char) bytes[i]);
+		if (i % 0x10 == 0x0f)
+			printf("\n");
+	}
+
+	if (i % 0x10 != 0)
+		printf("\n");
+}
+
+
+
+#endif
diff --git a/tools/testing/selftests/filesystems/fuse/test_fuse.h b/tools/testing/selftests/filesystems/fuse/test_fuse.h
new file mode 100644
index 000000000000..ca22b26775a0
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/test_fuse.h
@@ -0,0 +1,494 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Google LLC
+ */
+
+#ifndef TEST_FUSE__H
+#define TEST_FUSE__H
+
+#define _GNU_SOURCE
+
+#include "test_framework.h"
+
+#include <dirent.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
+
+#include <uapi/linux/fuse.h>
+
+#define PAGE_SIZE 4096
+#define FUSE_POSTFILTER 0x20000
+
+extern struct _test_options test_options;
+
+/* Slow but semantically easy string functions */
+
+/*
+ * struct s just wraps a char pointer
+ * It is a pointer to a malloc'd string, or null
+ * All consumers handle null input correctly
+ * All consumers free the string
+ */
+struct s {
+	char *s;
+};
+
+struct s s(const char *s1);
+struct s sn(const char *s1, const char *s2);
+int s_cmp(struct s s1, struct s s2);
+struct s s_cat(struct s s1, struct s s2);
+struct s s_splitleft(struct s s1, char c);
+struct s s_splitright(struct s s1, char c);
+struct s s_word(struct s s1, char c, size_t n);
+struct s s_path(struct s s1, struct s s2);
+struct s s_pathn(size_t n, struct s s1, ...);
+int s_link(struct s src_pathname, struct s dst_pathname);
+int s_symlink(struct s src_pathname, struct s dst_pathname);
+int s_mkdir(struct s pathname, mode_t mode);
+int s_rmdir(struct s pathname);
+int s_unlink(struct s pathname);
+int s_open(struct s pathname, int flags, ...);
+int s_openat(int dirfd, struct s pathname, int flags, ...);
+int s_creat(struct s pathname, mode_t mode);
+int s_mkfifo(struct s pathname, mode_t mode);
+int s_stat(struct s pathname, struct stat *st);
+int s_statfs(struct s pathname, struct statfs *st);
+int s_fuse_attr(struct s pathname, struct fuse_attr *fuse_attr_out);
+DIR *s_opendir(struct s pathname);
+int s_getxattr(struct s pathname, const char name[], void *value, size_t size,
+	       ssize_t *ret_size);
+int s_listxattr(struct s pathname, void *list, size_t size, ssize_t *ret_size);
+int s_setxattr(struct s pathname, const char name[], const void *value,
+	       size_t size, int flags);
+int s_removexattr(struct s pathname, const char name[]);
+int s_rename(struct s oldpathname, struct s newpathname);
+
+struct s tracing_folder(void);
+int tracing_on(void);
+
+char *concat_file_name(const char *dir, const char *file);
+char *setup_mount_dir(const char *name);
+int delete_dir_tree(const char *dir_path, bool remove_root);
+
+#define TESTFUSEINNULL(_opcode)						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res, sizeof(*in_header));			\
+	} while (false)
+
+static inline void print_header(struct fuse_in_header *header)
+{
+	printf("~~HEADER~~");
+	printf("len:\t%d\n", header->len);
+	printf("opcode:\t%d\n", header->opcode);
+	printf("unique:\t%ld\n", header->unique);
+	printf("nodeid:\t%ld\n", header->nodeid);
+	printf("uid:\t%d\n", header->uid);
+	printf("gid:\t%d\n", header->gid);
+	printf("pid:\t%d\n", header->pid);
+	printf("total_extlen:\t%d\n", header->total_extlen);
+	printf("padding:\t%d\n", header->padding);
+}
+
+static inline int test_fuse_in(int fuse_dev, uint8_t *bytes_in, int opcode, int size)
+{
+	struct fuse_in_header *in_header =
+					(struct fuse_in_header *)bytes_in;
+	ssize_t res = read(fuse_dev, &bytes_in,
+				sizeof(bytes_in));
+
+	TESTEQUAL(res, sizeof(*in_header) + size);
+	TESTEQUAL(in_header->opcode, opcode);
+	return 0;
+out:
+	return -1;
+}
+
+#define ERR_IN_EXT_LEN (FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + sizeof(uint32_t)))
+
+#define TESTFUSEIN(_opcode, in_struct)					\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct));\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		in_struct = (void *)(bytes_in + sizeof(*in_header));	\
+	} while (false)
+
+#define TESTFUSEIN_ERR_IN(_opcode, in_struct, err_in)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_ext_header *ext_h;				\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct)	\
+				+ ERR_IN_EXT_LEN);			\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		in_struct = (void *)(bytes_in + sizeof(*in_header));	\
+		ext_h = (void *)&bytes_in[in_header->len		\
+				- in_header->total_extlen * 8];		\
+		err_in = (void *)&ext_h[1];				\
+	} while (false)
+
+#define TESTFUSEIN2(_opcode, in_struct1, in_struct2)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct1) \
+						+ sizeof(*in_struct2)); \
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		in_struct1 = (void *)(bytes_in + sizeof(*in_header));	\
+		in_struct2 = (void *)(bytes_in + sizeof(*in_header)	\
+				      + sizeof(*in_struct1));		\
+	} while (false)
+
+#define TESTFUSEIN2_ERR_IN(_opcode, in_struct1, in_struct2, err_in)	\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_ext_header *ext_h;				\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(res, sizeof(*in_header) + sizeof(*in_struct1) \
+						+ sizeof(*in_struct2)	\
+						+ ERR_IN_EXT_LEN);	\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		in_struct1 = (void *)(bytes_in + sizeof(*in_header));	\
+		in_struct2 = (void *)(bytes_in + sizeof(*in_header)	\
+				      + sizeof(*in_struct1));		\
+		ext_h = (void *)&bytes_in[in_header->len		\
+				- in_header->total_extlen * 8];		\
+		err_in = (void *)&ext_h[1];				\
+	} while (false)
+
+#define TESTFUSEINEXT(_opcode, in_struct, extra)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTEQUAL(in_header->opcode, _opcode);			\
+		TESTEQUAL(res,						\
+		       sizeof(*in_header) + sizeof(*in_struct) + extra);\
+		in_struct = (void *)(bytes_in + sizeof(*in_header));	\
+	} while (false)
+
+#define TESTFUSEINUNKNOWN()						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		ssize_t res = read(fuse_dev, &bytes_in,			\
+			sizeof(bytes_in));				\
+									\
+		TESTGE(res, sizeof(*in_header));			\
+		TESTEQUAL(in_header->opcode, -1);			\
+	} while (false)
+
+/* Special case lookup since it is asymmetric */
+#define TESTFUSELOOKUP(expected, filter)				\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		char *name = (char *) (bytes_in + sizeof(*in_header));	\
+		ssize_t res;						\
+									\
+		TEST(res = read(fuse_dev, &bytes_in, sizeof(bytes_in)),	\
+			  res != -1);					\
+		/* TODO once we handle forgets properly, remove */	\
+		if (in_header->opcode == FUSE_FORGET)			\
+			continue;					\
+		if (in_header->opcode == FUSE_BATCH_FORGET)		\
+			continue;					\
+		TESTGE(res, sizeof(*in_header));			\
+		TESTEQUAL(in_header->opcode,				\
+			FUSE_LOOKUP | filter);				\
+		/* Post filter only recieves fuse_bpf_entry_out if it's	\
+		 * filled in. TODO: Should we populate this for user	\
+		 * postfilter, and if so, how to handle backing? */	\
+		TESTEQUAL(res,						\
+			  sizeof(*in_header) + strlen(expected) + 1 +	\
+				(filter == FUSE_POSTFILTER ?		\
+				sizeof(struct fuse_entry_out) +		\
+				sizeof(struct fuse_bpf_entry_out) * 0 +	\
+				ERR_IN_EXT_LEN: 0));			\
+		TESTCOND(!strcmp(name, expected));			\
+		break;							\
+	} while (true)
+
+/* Special case lookup since it is asymmetric */
+#define TESTFUSELOOKUP_POST_ERRIN(expected, err_in)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_ext_header *ext_h;				\
+		char *name = (char *) (bytes_in + sizeof(*in_header));	\
+		ssize_t res;						\
+									\
+		TEST(res = read(fuse_dev, &bytes_in, sizeof(bytes_in)),	\
+			  res != -1);					\
+		/* TODO once we handle forgets properly, remove */	\
+		if (in_header->opcode == FUSE_FORGET)			\
+			continue;					\
+		if (in_header->opcode == FUSE_BATCH_FORGET)		\
+			continue;					\
+		TESTGE(res, sizeof(*in_header));			\
+		TESTEQUAL(in_header->opcode,				\
+			FUSE_LOOKUP | FUSE_POSTFILTER);			\
+		/* Post filter only recieves fuse_bpf_entry_out if it's	\
+		 * filled in. TODO: Should we populate this for user	\
+		 * postfilter, and if so, how to handle backing? */	\
+		TESTEQUAL(res,						\
+			  sizeof(*in_header) + strlen(expected) + 1 +	\
+				sizeof(struct fuse_entry_out) +		\
+				sizeof(struct fuse_bpf_entry_out) * 0 +	\
+				ERR_IN_EXT_LEN);			\
+		TESTCOND(!strcmp(name, expected));			\
+									\
+		ext_h = (void *)&bytes_in[in_header->len		\
+				- in_header->total_extlen * 8];		\
+		err_in = (void *)&ext_h[1];				\
+		break;							\
+	} while (true)
+
+#define TESTFUSEOUTEMPTY()						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header),			\
+			.unique = in_header->unique,			\
+		};							\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUTERROR(errno)						\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header),			\
+			.error = errno,					\
+			.unique = in_header->unique,			\
+		};							\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUTREAD(data, length)					\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header) + length,		\
+			.unique = in_header->unique,			\
+		};							\
+		memcpy(bytes_out + sizeof(*out_header), data, length);	\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEDIROUTREAD(read_out, data, length)			\
+	do {								\
+		struct fuse_in_header *in_header =			\
+				(struct fuse_in_header *)bytes_in;	\
+		struct fuse_out_header *out_header =			\
+			(struct fuse_out_header *)bytes_out;		\
+									\
+		*out_header = (struct fuse_out_header) {		\
+			.len = sizeof(*out_header) +			\
+			       sizeof(*read_out) + length,		\
+			.unique = in_header->unique,			\
+		};							\
+		memcpy(bytes_out + sizeof(*out_header) +		\
+				sizeof(*read_out), data, length);	\
+		memcpy(bytes_out + sizeof(*out_header),			\
+				read_out, sizeof(*read_out));		\
+		TESTEQUAL(write(fuse_dev, bytes_out, out_header->len),	\
+			  out_header->len);				\
+	} while (false)
+
+#define TESTFUSEOUT1(type1, obj1)					\
+	do {								\
+		*(struct fuse_out_header *) bytes_out			\
+			= (struct fuse_out_header) {			\
+			.len = sizeof(struct fuse_out_header)		\
+				+ sizeof(struct type1),			\
+			.unique = ((struct fuse_in_header *)		\
+				   bytes_in)->unique,			\
+		};							\
+		*(struct type1 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header))		\
+			= obj1;						\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define SETFUSEOUT2(type1, obj1, type2, obj2)				\
+	do {								\
+		*(struct fuse_out_header *) bytes_out			\
+			= (struct fuse_out_header) {			\
+			.len = sizeof(struct fuse_out_header)		\
+				+ sizeof(struct type1)			\
+				+ sizeof(struct type2),			\
+			.unique = ((struct fuse_in_header *)		\
+				   bytes_in)->unique,			\
+		};							\
+		*(struct type1 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header))		\
+			= obj1;						\
+		*(struct type2 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header)		\
+			+ sizeof(struct type1))				\
+			= obj2;						\
+	} while (false)
+
+#define TESTFUSEOUT2(type1, obj1, type2, obj2)		\
+	do {								\
+		SETFUSEOUT2(type1, obj1, type2, obj2);	\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define TESTFUSEOUT2_IOCTL(type1, obj1, type2, obj2)			\
+	do {								\
+		SETFUSEOUT2(type1, obj1, type2, obj2);			\
+		TESTEQUAL(ioctl(fuse_dev,				\
+			FUSE_DEV_IOC_BPF_RESPONSE(			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			bytes_out),					\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define SETFUSEOUT3(type1, obj1, type2, obj2, type3, obj3)		\
+	do {								\
+		*(struct fuse_out_header *) bytes_out			\
+			= (struct fuse_out_header) {			\
+			.len = sizeof(struct fuse_out_header)		\
+				+ sizeof(struct type1)			\
+				+ sizeof(struct type2)			\
+				+ sizeof(struct type3),			\
+			.unique = ((struct fuse_in_header *)		\
+				   bytes_in)->unique,			\
+		};							\
+		*(struct type1 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header))		\
+			= obj1;						\
+		*(struct type2 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header)		\
+			+ sizeof(struct type1))				\
+			= obj2;						\
+		*(struct type3 *) (bytes_out				\
+			+ sizeof(struct fuse_out_header)		\
+			+ sizeof(struct type1)				\
+			+ sizeof(struct type2))				\
+			= obj3;						\
+	} while (false)
+
+#define TESTFUSEOUT3(type1, obj1, type2, obj2, type3, obj3)		\
+	do {								\
+		SETFUSEOUT3(type1, obj1, type2, obj2, type3, obj3);	\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define TESTFUSEOUT3_FAIL(type1, obj1, type2, obj2, type3, obj3)	\
+	do {								\
+		SETFUSEOUT3(type1, obj1, type2, obj2, type3, obj3);	\
+		TESTEQUAL(write(fuse_dev, bytes_out,			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			-1);						\
+	} while (false)
+
+#define FUSE_DEV_IOC_BPF_RESPONSE(N) _IOW(FUSE_DEV_IOC_MAGIC, 125, char[N])
+
+#define TESTFUSEOUT3_IOCTL(type1, obj1, type2, obj2, type3, obj3)	\
+	do {								\
+		SETFUSEOUT3(type1, obj1, type2, obj2, type3, obj3);	\
+		TESTEQUAL(ioctl(fuse_dev,				\
+			FUSE_DEV_IOC_BPF_RESPONSE(			\
+			((struct fuse_out_header *)bytes_out)->len),	\
+			bytes_out),					\
+			((struct fuse_out_header *)bytes_out)->len);	\
+	} while (false)
+
+#define TESTFUSEINITFLAGS(fuse_connection_flags)			\
+	do {								\
+		DECL_FUSE_IN(init);					\
+									\
+		TESTFUSEIN(FUSE_INIT, init_in);				\
+		TESTEQUAL(init_in->major, FUSE_KERNEL_VERSION);		\
+		TESTEQUAL(init_in->minor, FUSE_KERNEL_MINOR_VERSION);	\
+		TESTFUSEOUT1(fuse_init_out, ((struct fuse_init_out) {	\
+			.major = FUSE_KERNEL_VERSION,			\
+			.minor = FUSE_KERNEL_MINOR_VERSION,		\
+			.max_readahead = 4096,				\
+			.flags = fuse_connection_flags,			\
+			.max_background = 0,				\
+			.congestion_threshold = 0,			\
+			.max_write = 4096,				\
+			.time_gran = 1000,				\
+			.max_pages = 12,				\
+			.map_alignment = 4096,				\
+		}));							\
+	} while (false)
+
+#define TESTFUSEINIT()							\
+	TESTFUSEINITFLAGS(0)
+
+#define DECL_FUSE_IN(name)						\
+	struct fuse_##name##_in *name##_in =				\
+		(struct fuse_##name##_in *)				\
+		(bytes_in + sizeof(struct fuse_in_header))
+
+#define DECL_FUSE(name)							\
+	struct fuse_##name##_in *name##_in __attribute__((unused));	\
+	struct fuse_##name##_out *name##_out __attribute__((unused))
+
+#define FUSE_ACTION	TEST(pid = fork(), pid != -1);			\
+			if (pid) {
+
+#define FUSE_DAEMON	} else {					\
+				uint8_t bytes_in[FUSE_MIN_READ_BUFFER]	\
+					__attribute__((unused));	\
+				uint8_t bytes_out[FUSE_MIN_READ_BUFFER]	\
+					__attribute__((unused));
+
+#define FUSE_DONE		exit(TEST_SUCCESS);			\
+			}						\
+			TESTEQUAL(waitpid(pid, &status, 0), pid);	\
+			TESTEQUAL(status, TEST_SUCCESS);
+
+int mount_fuse(const char *mount_dir, const char *bpf_name, int dir_fd,
+	       int *fuse_dev_ptr);
+int mount_fuse_no_init(const char *mount_dir, const char *bpf_name, int dir_fd,
+	       int *fuse_dev_ptr);
+#endif
-- 
2.40.0.634.g4ca3ef3211-goog

