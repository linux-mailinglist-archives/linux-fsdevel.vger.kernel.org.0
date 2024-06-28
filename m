Return-Path: <linux-fsdevel+bounces-22777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F691C11D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06001C20E7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29B91C68A3;
	Fri, 28 Jun 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8cxKi3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3E1C2339;
	Fri, 28 Jun 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585351; cv=none; b=QgsRpRNZdnRHDvS2yUqwl+at0wJkWeSUjD3c8E/mvnMbenLFl6VU/CZaWI2Pby3f419rwCamqwrNqVdGnJYI88xQStRd2/yFA3Fl61Z3kSq+B+FWG4KKl6M6ILjVO94TwJDjLT6Gb6FKArQpA9WR+1lx+rfRGfhlAHw+4fdEXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585351; c=relaxed/simple;
	bh=hGdDLjsSChXJ9bePyGsYe4I6qwek+5knQYcKhzZEyXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+VYsbI3rpDk2CrdfBamTCdLDtM8G4WZrkZzp4P+4nwkTz/4xT3Rsr8nlME4Uyy6PI/8elhx58MY//dmKV63+jB7Zow16Ko358EVf/+4+6pZqz24b9zS8wnhNdQ3w84CytqIbfUP3G2PZ8B8f7ZXl9MAf6ribZ+uQ1mfVkXgVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8cxKi3i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42561c16ffeso5785845e9.3;
        Fri, 28 Jun 2024 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585347; x=1720190147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWYOXuCXP6e46p+DWPm2mdKXMIhkuMXGRD48/DvCa1o=;
        b=C8cxKi3ifK29xv9aJAwbDPwUfKZ4L8kVruE58GV0xQsCQzvEhO3xPzUJGWJV7RO7ny
         CYd3i6Y8xMGT5dRlmvRp5uUSvkOkXXvnO+jXQGhDCOJqH3iT27KxdBbFdFVuFmJQgeKM
         BA/u9NJepy0YamhCxSv3BrscmXmPc2Vbs4QigMxZ8bdd7FqqVEdplluhpl7dzwUNTmiT
         h8bRnCTUxR5UPDd7WEePKV5q352cHlhm5vxGv0ecXBHLnmp2tMf+Gwv21zmEWxYFR7WW
         Y/YjY8pEZtpI5+nVDIUVOoXFVM8aRUJX/gQKqOQ/HDxz+xEOSXmQ5Ge7FbFWLXijBGEE
         +j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585347; x=1720190147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWYOXuCXP6e46p+DWPm2mdKXMIhkuMXGRD48/DvCa1o=;
        b=lGLdVEkV73+T3MFLWHwVuQO+a6lhMc7BVNtU0fEDsxXfUndPKX5ktfzkSCzH8dOjsk
         vPVlcQwbpjA3TCT6IOMZEuOGYjflk7duK/l1YTuySnhkTVr3uEZDxRDieiOup+ZUSNtZ
         UK5jnDxLpCMTONV8LzC0JpHXhwojPX1cSNIHG5zihruxHCcuBOKz4Djd0zWp1D9kAtdT
         2z5KOKmwwBMtAYglOGi2a9n1uWB93zWglzdKLP43f3gQwpoFEfvFdKR65e4JbsDngtaJ
         WPIpb+jI6bgKKVZpLoDstN5qGBxoMzpNPbmTG+c8M+pRPTWMHAhh41mJeJFNi4QKypi5
         xS8w==
X-Forwarded-Encrypted: i=1; AJvYcCXpEHAnGokRh1dTVwL4Z3+5Up0gNzTrjLS97pFG0EG14JTZeBzeV7kcora3Q1KJ2uNnRZ/MWudlaHrd/F0Oq/EG0V9ZO/iIeJxQjut+
X-Gm-Message-State: AOJu0YyF54JHnKhUnA9IFyrqzu4zli32+MDMTxzGW+CHs63zCDemiSCo
	AZQ8C8rVGBKBbQO06QB4ZrsmkfpDp+j53u5fGAsxE6EwKVHn38HN
X-Google-Smtp-Source: AGHT+IGSZOJ0dbHVRYSGryimv6aA1rUgySqZQVkdvN/lo/Uk+BdxK1YgYZ6RG0nn2JHkVBFdBxSOAw==
X-Received: by 2002:a05:600c:1c8e:b0:425:680b:a691 with SMTP id 5b1f17b1804b1-425680ba7a5mr25979305e9.31.1719585347172;
        Fri, 28 Jun 2024 07:35:47 -0700 (PDT)
Received: from lucifer.home ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm38985485e9.9.2024.06.28.07.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:35:45 -0700 (PDT)
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH v2 6/7] tools: separate out shared radix-tree components
Date: Fri, 28 Jun 2024 15:35:27 +0100
Message-ID: <053b1fcaf694ff37b4342dd4b394ebde936de337.1719584707.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1719584707.git.lstoakes@gmail.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core components contained within the radix-tree tests which provide
shims for kernel headers and access to the maple tree are useful for
testing other things, so separate them out and make the radix tree tests
dependent on the shared components.

This lays the groundwork for us to add VMA tests of the newly introduced
vma.c file.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 tools/testing/radix-tree/Makefile             | 68 +++----------------
 tools/testing/radix-tree/maple.c              | 14 +---
 tools/testing/radix-tree/xarray.c             |  9 +--
 tools/testing/shared/autoconf.h               |  2 +
 tools/testing/{radix-tree => shared}/bitmap.c |  0
 tools/testing/{radix-tree => shared}/linux.c  |  0
 .../{radix-tree => shared}/linux/bug.h        |  0
 .../{radix-tree => shared}/linux/cpu.h        |  0
 .../{radix-tree => shared}/linux/idr.h        |  0
 .../{radix-tree => shared}/linux/init.h       |  0
 .../{radix-tree => shared}/linux/kconfig.h    |  0
 .../{radix-tree => shared}/linux/kernel.h     |  0
 .../{radix-tree => shared}/linux/kmemleak.h   |  0
 .../{radix-tree => shared}/linux/local_lock.h |  0
 .../{radix-tree => shared}/linux/lockdep.h    |  0
 .../{radix-tree => shared}/linux/maple_tree.h |  0
 .../{radix-tree => shared}/linux/percpu.h     |  0
 .../{radix-tree => shared}/linux/preempt.h    |  0
 .../{radix-tree => shared}/linux/radix-tree.h |  0
 .../{radix-tree => shared}/linux/rcupdate.h   |  0
 .../{radix-tree => shared}/linux/xarray.h     |  0
 tools/testing/shared/maple-shared.h           |  9 +++
 tools/testing/shared/maple-shim.c             |  7 ++
 tools/testing/shared/shared.h                 | 34 ++++++++++
 tools/testing/shared/shared.mk                | 68 +++++++++++++++++++
 .../testing/shared/trace/events/maple_tree.h  |  5 ++
 tools/testing/shared/xarray-shared.c          |  5 ++
 tools/testing/shared/xarray-shared.h          |  4 ++
 28 files changed, 147 insertions(+), 78 deletions(-)
 create mode 100644 tools/testing/shared/autoconf.h
 rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
 rename tools/testing/{radix-tree => shared}/linux.c (100%)
 rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
 rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
 create mode 100644 tools/testing/shared/maple-shared.h
 create mode 100644 tools/testing/shared/maple-shim.c
 create mode 100644 tools/testing/shared/shared.h
 create mode 100644 tools/testing/shared/shared.mk
 create mode 100644 tools/testing/shared/trace/events/maple_tree.h
 create mode 100644 tools/testing/shared/xarray-shared.c
 create mode 100644 tools/testing/shared/xarray-shared.h

diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 7527f738b4a1..29d607063749 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -1,29 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
-	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
-LDFLAGS += -fsanitize=address -fsanitize=undefined
-LDLIBS+= -lpthread -lurcu
-TARGETS = main idr-test multiorder xarray maple
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
-			 slab.o maple.o
-OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
-	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
-	 iteration_check_2.o benchmark.o
+.PHONY: default
 
-ifndef SHIFT
-	SHIFT=3
-endif
+default: main
 
-ifeq ($(BUILD), 32)
-	CFLAGS += -m32
-	LDFLAGS += -m32
-LONG_BIT := 32
-endif
+include ../shared/shared.mk
 
-ifndef LONG_BIT
-LONG_BIT := $(shell getconf LONG_BIT)
-endif
+TARGETS = main idr-test multiorder xarray maple
+CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
+OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
+	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
+	iteration_check.o iteration_check_2.o benchmark.o
 
 targets: generated/map-shift.h generated/bit-length.h $(TARGETS)
 
@@ -32,46 +19,13 @@ main:	$(OFILES)
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-xarray: $(CORE_OFILES)
+xarray: $(CORE_OFILES) xarray.o
 
-maple: $(CORE_OFILES)
+maple: $(CORE_OFILES) maple.o
 
 multiorder: multiorder.o $(CORE_OFILES)
 
 clean:
 	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
 
-vpath %.c ../../lib
-
-$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
-	../../include/linux/*.h \
-	../../include/asm/*.h \
-	../../../include/linux/xarray.h \
-	../../../include/linux/maple_tree.h \
-	../../../include/linux/radix-tree.h \
-	../../../lib/radix-tree.h \
-	../../../include/linux/idr.h
-
-radix-tree.c: ../../../lib/radix-tree.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-idr.c: ../../../lib/idr.c
-	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
-
-xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
-
-maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
-
-generated/map-shift.h:
-	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
-		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
-				generated/map-shift.h;			\
-	fi
-
-generated/bit-length.h: FORCE
-	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
-		echo "Generating $@";                                        \
-		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
-	fi
-
-FORCE: ;
+$(OFILES): $(SHARED_DEPS) *.h */*.h
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index f1caf4bcf937..5b53ecf22fc4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,20 +8,8 @@
  * difficult to handle in kernel tests.
  */
 
-#define CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_MAPLE_SEARCH
-#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "maple-shared.h"
 #include "test.h"
-#include <stdlib.h>
-#include <time.h>
-#include "linux/init.h"
-
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"
 
diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
index f20e12cbbfd4..253208a8541b 100644
--- a/tools/testing/radix-tree/xarray.c
+++ b/tools/testing/radix-tree/xarray.c
@@ -4,16 +4,9 @@
  * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
  */
 
-#define XA_DEBUG
+#include "xarray-shared.h"
 #include "test.h"
 
-#define module_init(x)
-#define module_exit(x)
-#define MODULE_AUTHOR(x)
-#define MODULE_LICENSE(x)
-#define dump_stack()	assert(0)
-
-#include "../../../lib/xarray.c"
 #undef XA_DEBUG
 #include "../../../lib/test_xarray.c"
 
diff --git a/tools/testing/shared/autoconf.h b/tools/testing/shared/autoconf.h
new file mode 100644
index 000000000000..92dc474c349b
--- /dev/null
+++ b/tools/testing/shared/autoconf.h
@@ -0,0 +1,2 @@
+#include "bit-length.h"
+#define CONFIG_XARRAY_MULTI 1
diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/shared/bitmap.c
similarity index 100%
rename from tools/testing/radix-tree/bitmap.c
rename to tools/testing/shared/bitmap.c
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
similarity index 100%
rename from tools/testing/radix-tree/linux.c
rename to tools/testing/shared/linux.c
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
similarity index 100%
rename from tools/testing/radix-tree/linux/bug.h
rename to tools/testing/shared/linux/bug.h
diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/cpu.h
rename to tools/testing/shared/linux/cpu.h
diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
similarity index 100%
rename from tools/testing/radix-tree/linux/idr.h
rename to tools/testing/shared/linux/idr.h
diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
similarity index 100%
rename from tools/testing/radix-tree/linux/init.h
rename to tools/testing/shared/linux/init.h
diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kconfig.h
rename to tools/testing/shared/linux/kconfig.h
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kernel.h
rename to tools/testing/shared/linux/kernel.h
diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
similarity index 100%
rename from tools/testing/radix-tree/linux/kmemleak.h
rename to tools/testing/shared/linux/kmemleak.h
diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
similarity index 100%
rename from tools/testing/radix-tree/linux/local_lock.h
rename to tools/testing/shared/linux/local_lock.h
diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
similarity index 100%
rename from tools/testing/radix-tree/linux/lockdep.h
rename to tools/testing/shared/linux/lockdep.h
diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/maple_tree.h
rename to tools/testing/shared/linux/maple_tree.h
diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
similarity index 100%
rename from tools/testing/radix-tree/linux/percpu.h
rename to tools/testing/shared/linux/percpu.h
diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
similarity index 100%
rename from tools/testing/radix-tree/linux/preempt.h
rename to tools/testing/shared/linux/preempt.h
diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
similarity index 100%
rename from tools/testing/radix-tree/linux/radix-tree.h
rename to tools/testing/shared/linux/radix-tree.h
diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
similarity index 100%
rename from tools/testing/radix-tree/linux/rcupdate.h
rename to tools/testing/shared/linux/rcupdate.h
diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
similarity index 100%
rename from tools/testing/radix-tree/linux/xarray.h
rename to tools/testing/shared/linux/xarray.h
diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
new file mode 100644
index 000000000000..3d847edd149d
--- /dev/null
+++ b/tools/testing/shared/maple-shared.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define CONFIG_DEBUG_MAPLE_TREE
+#define CONFIG_MAPLE_SEARCH
+#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
+#include "shared.h"
+#include <stdlib.h>
+#include <time.h>
+#include "linux/init.h"
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
new file mode 100644
index 000000000000..640df76f483e
--- /dev/null
+++ b/tools/testing/shared/maple-shim.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/* Very simple shim around the maple tree. */
+
+#include "maple-shared.h"
+
+#include "../../../lib/maple_tree.c"
diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
new file mode 100644
index 000000000000..495602e60b65
--- /dev/null
+++ b/tools/testing/shared/shared.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+
+#include <linux/gfp.h>
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+
+#ifndef module_init
+#define module_init(x)
+#endif
+
+#ifndef module_exit
+#define module_exit(x)
+#endif
+
+#ifndef MODULE_AUTHOR
+#define MODULE_AUTHOR(x)
+#endif
+
+#ifndef MODULE_LICENSE
+#define MODULE_LICENSE(x)
+#endif
+
+#ifndef MODULE_DESCRIPTION
+#define MODULE_DESCRIPTION(x)
+#endif
+
+#ifndef dump_stack
+#define dump_stack()	assert(0)
+#endif
diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
new file mode 100644
index 000000000000..69a6a528eaed
--- /dev/null
+++ b/tools/testing/shared/shared.mk
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
+	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
+LDFLAGS += -fsanitize=address -fsanitize=undefined
+LDLIBS += -lpthread -lurcu
+SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o find_bit.o bitmap.o \
+	slab.o
+SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
+	generated/bit-length.h generated/autoconf.h \
+	../../include/linux/*.h \
+	../../include/asm/*.h \
+	../../../include/linux/xarray.h \
+	../../../include/linux/maple_tree.h \
+	../../../include/linux/radix-tree.h \
+	../../../lib/radix-tree.h \
+	../../../include/linux/idr.h
+
+ifndef SHIFT
+	SHIFT=3
+endif
+
+ifeq ($(BUILD), 32)
+	CFLAGS += -m32
+	LDFLAGS += -m32
+LONG_BIT := 32
+endif
+
+ifndef LONG_BIT
+LONG_BIT := $(shell getconf LONG_BIT)
+endif
+
+%.o: ../shared/%.c
+	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
+
+vpath %.c ../../lib
+
+$(SHARED_OFILES): $(SHARED_DEPS)
+
+radix-tree.c: ../../../lib/radix-tree.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+idr.c: ../../../lib/idr.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
+xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
+	../../../lib/test_xarray.c
+
+maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
+	../../../lib/test_maple_tree.c
+
+generated/autoconf.h:
+	cp ../shared/autoconf.h generated/autoconf.h
+
+generated/map-shift.h:
+	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
+		echo "Generating $@";                                   \
+		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
+				generated/map-shift.h;                  \
+	fi
+
+generated/bit-length.h: FORCE
+	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
+		echo "Generating $@";                                        \
+		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
+	fi
+
+FORCE: ;
diff --git a/tools/testing/shared/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
new file mode 100644
index 000000000000..97d0e1ddcf08
--- /dev/null
+++ b/tools/testing/shared/trace/events/maple_tree.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define trace_ma_op(a, b) do {} while (0)
+#define trace_ma_read(a, b) do {} while (0)
+#define trace_ma_write(a, b, c, d) do {} while (0)
diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
new file mode 100644
index 000000000000..e90901958dcd
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "xarray-shared.h"
+
+#include "../../../lib/xarray.c"
diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
new file mode 100644
index 000000000000..ac2d16ff53ae
--- /dev/null
+++ b/tools/testing/shared/xarray-shared.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define XA_DEBUG
+#include "shared.h"
-- 
2.45.1


