Return-Path: <linux-fsdevel+bounces-55871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E3B0F653
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B97E1CC33E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8B1306DDF;
	Wed, 23 Jul 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JS1n7GEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B0302CCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282085; cv=none; b=PaVFDsCAvDk8xKZZ/ohMa0lrvXdB5pdhVUhD6j/i8l52VIiJABdnbDNDDN9uyZE+y07CXkJlYxW0HYZ7PqZLgEuq582bGks+0uKZdIdMhOauWjdl++Z+e8mEbha+WCAO1naJhS/wTIg4Dj9/du0L5YSvsgbp5cmtM+kKzcR8Pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282085; c=relaxed/simple;
	bh=vepJPtSM4UDtXKviQeBbm1OdHGnp/I7tMn8jrp4ro84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYa9yBmMvztD+txokONQbItGKXNoZIvdZNTxDqr24mkZ8iD/JKeU5lF8SW0fwL0DDnWmdlzSAkiHog/xkT/Q4uwelV/MirG0TSDZuAYjKIEzy4SeTF3sxIDorA+xS53EqtUmpulMGB7rBA9NxCJ2B9Ly7/N0YtD21hYLvLleM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JS1n7GEP; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e77831d68so62313787b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282076; x=1753886876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddb9O3W6dbBtTQBECl2xf4CCJbIM6CMV4Ov5izVmo8E=;
        b=JS1n7GEPOoSzPkZMFIhYl9lcA1D4fDfEEPK2XKKg5GaVlGZ+HnqrOolqFqvhPpIbLT
         QPH7Hd4HZFSyKunNkJ1FBNqPQbvvHQK9DNYzfvv+w+BSEuoZeuToev6mqAsxtyuRZpsz
         r65Qu3Zq3Bs5d2jcKlDhCb8AGrxSRRniEA0RyafxmBixEZH4H8jP0/N41HbpbB+xT99J
         OvoWRUTGXvDt8kr6AuuFEEZz1aQc8CtPmSwpdhTSwpbsc25stQyMgmxtgQN8jZo6MdCO
         PVRc01G6WLXlORJInG0ipH5gA+HfGKy0hbWXIC4q8CQXLOKVvBq8JBCXKAXlBbKICTwl
         0FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282076; x=1753886876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddb9O3W6dbBtTQBECl2xf4CCJbIM6CMV4Ov5izVmo8E=;
        b=NgId+2I3e06jYGKVg9eZLE016PqCjxpe6wEIRdnWhePTaPJcMOm5fzK73YmiS0tuU4
         kNKH84D4yJb6u+n7P1WG5LbRtjwz+iTLfcawSjsfAkiaUEfT3bFp2xAzt3P68ZnxmUeY
         L35Gbc++iZKJ5rWZL1CDkWrXe/qH48kYiqLgnDM67/gUenvxJb8PQHeKPJtUE8HoVBsv
         CUX2GRTLRpOdByroh4JYXE6HPaJeKkax/Tdj861vNaLKjjsFDpvRUe4B38lIp680779n
         xub/RckCEd7A1wLsw6L7dWs0rWCzZYX/mHrPx8Rx2mE07X3etQPUh+iT8v1hfS85D9DA
         82Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXHRbM+wF8a6ugTv7Pr9ubIu2CQbmovST2iLa6f0jB3w/TcXfy4VzzN9ZFBumHHJJn7widnwfPfIKP+2yvY@vger.kernel.org
X-Gm-Message-State: AOJu0YxloUBWPVfN5LNjUnNYTjOi+M4XtRoDvnnEhSggnqIY8nR0Tx5j
	2oKiWhk+R5ImOQZi11caFZbIKXgdcofbwnYFMyV0hSaInfihpGqZ7+b72sNhroR9Vkg=
X-Gm-Gg: ASbGncsdV9kWiIcx+Aujw1kse/tEVgILOQMYNcpoIsTKRd64I7w4/yChiumKQnZPFhe
	HxjartCCJvmrul0u8UBjyhylgwPln/wbZV5SEH+FdwKfXFPBxi4550O7Ipmlnw1kB/k7B2U8fZz
	/gU8WtsG3J4tKh2RYTJp7nvPU7KY1MXijuZJOkgRvNHaeccAmSYnGshx/RHSEQQzF+ewiDjyll0
	ZxYG7qOnV48z7xvuZhoX8Qg15AVOAjdIcTsSpOqg6Kv2I/SyZvxNtoCubC0qC8vU6Y3ES3+M+/5
	XYHP4sjMg20Su+4kz1sJ9sAK2gOIZBgQ0Z4GeJbJ4LlWj6l48b5940/0abBX7fY8OFLA4DPKsD+
	OKVWBI8CZA7lL4ZT46c1Ojq6nvEHPd3i6YAyUzG9g+WWAidpyd6T9zkeN2I63X+Z0IqHwuRCly9
	BkaEySacxR4NgmKQ==
X-Google-Smtp-Source: AGHT+IGlOv83r7AFmSXicXojx61jzE5jt0kd4sJetNYOXC3TepTaetdKwNBRcnR6w4mKhuPo017eUg==
X-Received: by 2002:a05:690c:45c1:b0:70e:2d1a:82b8 with SMTP id 00721157ae682-719b42f4b40mr40484857b3.34.1753282075975;
        Wed, 23 Jul 2025 07:47:55 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 30/32] tools: introduce libluo
Date: Wed, 23 Jul 2025 14:46:43 +0000
Message-ID: <20250723144649.1696299-31-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

LibLUO is a C library for interacting with the Live Update
Orchestrator (LUO) subsystem. It provides a set of APIs for applications
to interact with LUO, avoiding the need to directly calling the LUO
ioctls. It provides APIs for controlling the LUO state and preserve and
restore file descriptors across live updates.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS                        |   1 +
 tools/lib/luo/LICENSE              | 165 ++++++++++++++++++
 tools/lib/luo/Makefile             |  37 ++++
 tools/lib/luo/README.md            | 166 ++++++++++++++++++
 tools/lib/luo/include/libluo.h     | 128 ++++++++++++++
 tools/lib/luo/include/liveupdate.h | 265 +++++++++++++++++++++++++++++
 tools/lib/luo/libluo.c             | 203 ++++++++++++++++++++++
 7 files changed, 965 insertions(+)
 create mode 100644 tools/lib/luo/LICENSE
 create mode 100644 tools/lib/luo/Makefile
 create mode 100644 tools/lib/luo/README.md
 create mode 100644 tools/lib/luo/include/libluo.h
 create mode 100644 tools/lib/luo/include/liveupdate.h
 create mode 100644 tools/lib/luo/libluo.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b4fde9f62e9b..f833b340fabd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14026,6 +14026,7 @@ F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
 F:	mm/memfd_luo.c
+F:	tools/lib/luo/
 F:	tools/testing/selftests/liveupdate/
 
 LLC (802.2)
diff --git a/tools/lib/luo/LICENSE b/tools/lib/luo/LICENSE
new file mode 100644
index 000000000000..0a041280bd00
--- /dev/null
+++ b/tools/lib/luo/LICENSE
@@ -0,0 +1,165 @@
+                   GNU LESSER GENERAL PUBLIC LICENSE
+                       Version 3, 29 June 2007
+
+ Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+
+  This version of the GNU Lesser General Public License incorporates
+the terms and conditions of version 3 of the GNU General Public
+License, supplemented by the additional permissions listed below.
+
+  0. Additional Definitions.
+
+  As used herein, "this License" refers to version 3 of the GNU Lesser
+General Public License, and the "GNU GPL" refers to version 3 of the GNU
+General Public License.
+
+  "The Library" refers to a covered work governed by this License,
+other than an Application or a Combined Work as defined below.
+
+  An "Application" is any work that makes use of an interface provided
+by the Library, but which is not otherwise based on the Library.
+Defining a subclass of a class defined by the Library is deemed a mode
+of using an interface provided by the Library.
+
+  A "Combined Work" is a work produced by combining or linking an
+Application with the Library.  The particular version of the Library
+with which the Combined Work was made is also called the "Linked
+Version".
+
+  The "Minimal Corresponding Source" for a Combined Work means the
+Corresponding Source for the Combined Work, excluding any source code
+for portions of the Combined Work that, considered in isolation, are
+based on the Application, and not on the Linked Version.
+
+  The "Corresponding Application Code" for a Combined Work means the
+object code and/or source code for the Application, including any data
+and utility programs needed for reproducing the Combined Work from the
+Application, but excluding the System Libraries of the Combined Work.
+
+  1. Exception to Section 3 of the GNU GPL.
+
+  You may convey a covered work under sections 3 and 4 of this License
+without being bound by section 3 of the GNU GPL.
+
+  2. Conveying Modified Versions.
+
+  If you modify a copy of the Library, and, in your modifications, a
+facility refers to a function or data to be supplied by an Application
+that uses the facility (other than as an argument passed when the
+facility is invoked), then you may convey a copy of the modified
+version:
+
+   a) under this License, provided that you make a good faith effort to
+   ensure that, in the event an Application does not supply the
+   function or data, the facility still operates, and performs
+   whatever part of its purpose remains meaningful, or
+
+   b) under the GNU GPL, with none of the additional permissions of
+   this License applicable to that copy.
+
+  3. Object Code Incorporating Material from Library Header Files.
+
+  The object code form of an Application may incorporate material from
+a header file that is part of the Library.  You may convey such object
+code under terms of your choice, provided that, if the incorporated
+material is not limited to numerical parameters, data structure
+layouts and accessors, or small macros, inline functions and templates
+(ten or fewer lines in length), you do both of the following:
+
+   a) Give prominent notice with each copy of the object code that the
+   Library is used in it and that the Library and its use are
+   covered by this License.
+
+   b) Accompany the object code with a copy of the GNU GPL and this license
+   document.
+
+  4. Combined Works.
+
+  You may convey a Combined Work under terms of your choice that,
+taken together, effectively do not restrict modification of the
+portions of the Library contained in the Combined Work and reverse
+engineering for debugging such modifications, if you also do each of
+the following:
+
+   a) Give prominent notice with each copy of the Combined Work that
+   the Library is used in it and that the Library and its use are
+   covered by this License.
+
+   b) Accompany the Combined Work with a copy of the GNU GPL and this license
+   document.
+
+   c) For a Combined Work that displays copyright notices during
+   execution, include the copyright notice for the Library among
+   these notices, as well as a reference directing the user to the
+   copies of the GNU GPL and this license document.
+
+   d) Do one of the following:
+
+       0) Convey the Minimal Corresponding Source under the terms of this
+       License, and the Corresponding Application Code in a form
+       suitable for, and under terms that permit, the user to
+       recombine or relink the Application with a modified version of
+       the Linked Version to produce a modified Combined Work, in the
+       manner specified by section 6 of the GNU GPL for conveying
+       Corresponding Source.
+
+       1) Use a suitable shared library mechanism for linking with the
+       Library.  A suitable mechanism is one that (a) uses at run time
+       a copy of the Library already present on the user's computer
+       system, and (b) will operate properly with a modified version
+       of the Library that is interface-compatible with the Linked
+       Version.
+
+   e) Provide Installation Information, but only if you would otherwise
+   be required to provide such information under section 6 of the
+   GNU GPL, and only to the extent that such information is
+   necessary to install and execute a modified version of the
+   Combined Work produced by recombining or relinking the
+   Application with a modified version of the Linked Version. (If
+   you use option 4d0, the Installation Information must accompany
+   the Minimal Corresponding Source and Corresponding Application
+   Code. If you use option 4d1, you must provide the Installation
+   Information in the manner specified by section 6 of the GNU GPL
+   for conveying Corresponding Source.)
+
+  5. Combined Libraries.
+
+  You may place library facilities that are a work based on the
+Library side by side in a single library together with other library
+facilities that are not Applications and are not covered by this
+License, and convey such a combined library under terms of your
+choice, if you do both of the following:
+
+   a) Accompany the combined library with a copy of the same work based
+   on the Library, uncombined with any other library facilities,
+   conveyed under the terms of this License.
+
+   b) Give prominent notice with the combined library that part of it
+   is a work based on the Library, and explaining where to find the
+   accompanying uncombined form of the same work.
+
+  6. Revised Versions of the GNU Lesser General Public License.
+
+  The Free Software Foundation may publish revised and/or new versions
+of the GNU Lesser General Public License from time to time. Such new
+versions will be similar in spirit to the present version, but may
+differ in detail to address new problems or concerns.
+
+  Each version is given a distinguishing version number. If the
+Library as you received it specifies that a certain numbered version
+of the GNU Lesser General Public License "or any later version"
+applies to it, you have the option of following the terms and
+conditions either of that published version or of any later version
+published by the Free Software Foundation. If the Library as you
+received it does not specify a version number of the GNU Lesser
+General Public License, you may choose any version of the GNU Lesser
+General Public License ever published by the Free Software Foundation.
+
+  If the Library as you received it specifies that a proxy can decide
+whether future versions of the GNU Lesser General Public License shall
+apply, that proxy's public statement of acceptance of any version is
+permanent authorization for you to choose that version for the
+Library.
diff --git a/tools/lib/luo/Makefile b/tools/lib/luo/Makefile
new file mode 100644
index 000000000000..e851c37d3d0a
--- /dev/null
+++ b/tools/lib/luo/Makefile
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: LGPL-3.0-or-later
+SRCS = libluo.c
+OBJS = $(SRCS:.c=.o)
+INCLUDE_DIR = include
+HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)
+
+CC = gcc
+AR = ar
+CFLAGS = -Wall -Wextra -fPIC -O2 -g -I$(INCLUDE_DIR)
+LDFLAGS = -shared
+
+LIB_NAME = libluo
+STATIC_LIB = $(LIB_NAME).a
+SHARED_LIB = $(LIB_NAME).so
+
+.PHONY: all clean install
+
+all: $(STATIC_LIB) $(SHARED_LIB)
+
+$(STATIC_LIB): $(OBJS)
+	$(AR) rcs $@ $^
+
+$(SHARED_LIB): $(OBJS)
+	$(CC) $(LDFLAGS) -o $@ $^
+
+%.o: %.c $(HEADERS)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+clean:
+	rm -f $(OBJS) $(STATIC_LIB) $(SHARED_LIB)
+
+install: all
+	install -d $(DESTDIR)/usr/local/lib
+	install -d $(DESTDIR)/usr/local/include
+	install -m 644 $(STATIC_LIB) $(DESTDIR)/usr/local/lib
+	install -m 755 $(SHARED_LIB) $(DESTDIR)/usr/local/lib
+	install -m 644 $(HEADERS) $(DESTDIR)/usr/local/include
diff --git a/tools/lib/luo/README.md b/tools/lib/luo/README.md
new file mode 100644
index 000000000000..a716ccb2992c
--- /dev/null
+++ b/tools/lib/luo/README.md
@@ -0,0 +1,166 @@
+# LibLUO - Live Update Orchestrator Library
+
+A C library for interacting with the Linux Live Update Orchestrator (LUO) subsystem.
+
+## Overview
+
+LibLUO provides a set of APIs for applications to interact with LUO, avoiding
+the need to directly calling the LUO ioctls. It provides APIs for controlling
+the LUO state and preserve and restore file descriptors across live updates.
+
+## Features
+
+- Initialize and manage connection to the LUO device.
+- Preserve file descriptors before a live update.
+- Restore file descriptors after a live update.
+- Control the live update state machine (prepare, cancel, finish).
+- Query the current state of the LUO subsystem.
+- The library also includes a test suite for testing both LibLUO and the kernel
+  LUO interface.
+
+## Building
+
+```bash
+make
+```
+
+This will build both static (`libluo.a`) and shared (`libluo.so`) versions of the library.
+
+To build the tests, do
+
+``` bash
+make tests
+```
+
+This will build the `tests/test` binary.
+
+## Installation
+
+```bash
+sudo make install
+```
+
+This will install the library to `/usr/local/lib` and the header file to `/usr/local/include`.
+
+## Usage
+
+### Preserving a file descriptor
+
+```c
+#include <libluo.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+int main() {
+    int ret;
+    uint64_t token;
+    int fd, new_fd;
+    enum luo_state state;
+
+    // Initialize the library
+    ret = luo_init();
+    if (ret < 0) {
+        fprintf(stderr, "Failed to initialize LibLUO: %d\n", ret);
+        return 1;
+    }
+
+    // Check if LUO is available
+    if (!luo_is_available()) {
+        fprintf(stderr, "LUO is not available on this system\n");
+        return 1;
+    }
+
+    // Get the current LUO state
+    ret = luo_get_state(&state);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to get LUO state: %d\n", ret);
+        luo_cleanup();
+        return 1;
+    }
+
+    printf("Current LUO state: %s\n", luo_state_to_string(state));
+
+    // Open a file descriptor to preserve
+	fd = memfd_create("luo_memfd", 0);
+    if (fd < 0) {
+        perror("Failed to open memfd");
+        luo_cleanup();
+        return 1;
+    }
+
+    // Preserve the file descriptor
+    ret = luo_fd_preserve(fd, &token);
+    if (ret < 0) {
+        fprintf(stderr, "Failed to preserve FD: %d\n", ret);
+        close(fd);
+        luo_cleanup();
+        return 1;
+    }
+
+    printf("FD %d preserved with token %lu\n", fd, token);
+
+    // After a live update, restore the file descriptor
+    if (state == LUO_STATE_UPDATED) {
+        ret = luo_fd_restore(token, &new_fd);
+        if (ret < 0) {
+            fprintf(stderr, "Failed to restore FD: %d\n", ret);
+        } else {
+            printf("FD restored: %d\n", new_fd);
+            close(new_fd);
+        }
+
+        // Signal completion of restoration
+        luo_finish();
+    }
+
+    close(fd);
+    luo_cleanup();
+    return 0;
+}
+```
+
+### Controlling the Live Update Process
+
+```c
+#include <libluo.h>
+#include <stdio.h>
+
+int main() {
+    int ret;
+
+    ret = luo_init();
+    if (ret < 0) {
+        return 1;
+    }
+
+    // Initiate the preparation phase
+    ret = luo_prepare();
+    if (ret < 0) {
+        fprintf(stderr, "Failed to prepare for live update: %d\n", ret);
+        luo_cleanup();
+        return 1;
+    }
+
+    // At this point, the system is ready for kexec reboot
+    // The freeze operation is handled internally by the kernel
+    // during kexec.
+
+    // After reboot, in the new kernel
+    // Signal completion of restoration
+    ret = luo_finish();
+    if (ret < 0) {
+        fprintf(stderr, "Failed to finish live update: %d\n", ret);
+        luo_cleanup();
+        return 1;
+    }
+
+    luo_cleanup();
+    return 0;
+}
+```
+
+## License
+
+This library is provided under the terms of the GNU Lesser General Public
+License version 3.0, or (at your option) any later version.
diff --git a/tools/lib/luo/include/libluo.h b/tools/lib/luo/include/libluo.h
new file mode 100644
index 000000000000..86b277e8e4f6
--- /dev/null
+++ b/tools/lib/luo/include/libluo.h
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: LGPL-3.0-or-later
+/**
+ * @file libluo.h
+ * @brief Library for interacting with the Linux Live Update Orchestrator (LUO)
+ *
+ * This library provides a simple interface for applications to interact with
+ * the Linux Live Update Orchestrator (LUO) subsystem, allowing them to preserve
+ * and restore file descriptors across live kernel updates.
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#ifndef _LIBLUO_H
+#define _LIBLUO_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <liveupdate.h>
+
+/**
+ * @brief Initialize the LUO library
+ *
+ * Opens the LUO device file and prepares the library for use.
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int luo_init(void);
+
+/**
+ * @brief Clean up and release resources used by the LUO library
+ *
+ * Closes the LUO device file and releases any resources allocated by the
+ * library.
+ */
+void luo_cleanup(void);
+
+/**
+ * @brief Get the current state of the LUO subsystem
+ *
+ * @param[out] state Pointer to store the current LUO state
+ * @return 0 on success, negative error code on failure
+ */
+int luo_get_state(enum liveupdate_state *state);
+
+/**
+ * @brief Preserve a file descriptor for restoration after a live update
+ *
+ * Marks the specified file descriptor for preservation across a live update.
+ * The kernel validates if the FD type is supported for preservation.
+ *
+ * @param[in] fd The file descriptor to preserve
+ * @param[in] token Token to associate fd with. Must be unique.
+ * @return 0 on success, negative error code on failure
+ */
+int luo_fd_preserve(int fd, uint64_t token);
+
+/**
+ * @brief Cancel preservation of a previously preserved file descriptor
+ *
+ * Removes a file descriptor from the preservation list using its token.
+ *
+ * @param[in] token The token used to preserve fd previously.
+ * @return 0 on success, negative error code on failure
+ */
+int luo_fd_unpreserve(uint64_t token);
+
+/**
+ * @brief Restore a previously preserved file descriptor
+ *
+ * Restores a file descriptor that was preserved before the live update.
+ * This must be called after the system has rebooted into the new kernel.
+ *
+ * @param[in] token The token returned by luo_fd_preserve before the update
+ * @param[out] fd Pointer to store the new file descriptor
+ * @return 0 on success, negative error code on failure
+ */
+int luo_fd_restore(uint64_t token, int *fd);
+
+/**
+ * @brief Initiate the preparation phase for a live update
+ *
+ * Triggers the PREPARE phase in the LUO subsystem, which begins the
+ * state saving process for items marked for preservation.
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int luo_prepare(void);
+
+/**
+ * @brief Cancel the live update preparation phase
+ *
+ * Aborts the preparation sequence and returns the system to normal state.
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int luo_cancel(void);
+
+/**
+ * @brief Signal completion of restoration after a live update
+ *
+ * Notifies the LUO subsystem that all necessary restoration actions
+ * have been completed in the new kernel.
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int luo_finish(void);
+
+/**
+ * @brief Check if the LUO subsystem is available
+ *
+ * Tests if the LUO device file exists and can be opened.
+ *
+ * @return true if LUO is available, false otherwise
+ */
+bool luo_is_available(void);
+
+/**
+ * @brief Convert a liveupdate_state enum value to a string
+ *
+ * Returns a string representation of the given LUO state.
+ *
+ * @param[in] state The LUO state to convert
+ * @return A constant string representing the state
+ */
+const char *luo_state_to_string(enum liveupdate_state state);
+
+#endif /* _LIBLUO_H */
diff --git a/tools/lib/luo/include/liveupdate.h b/tools/lib/luo/include/liveupdate.h
new file mode 100644
index 000000000000..7b12a1073c3c
--- /dev/null
+++ b/tools/lib/luo/include/liveupdate.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+/*
+ * Userspace interface for /dev/liveupdate
+ * Live Update Orchestrator
+ *
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _UAPI_LIVEUPDATE_H
+#define _UAPI_LIVEUPDATE_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * enum liveupdate_state - Defines the possible states of the live update
+ * orchestrator.
+ * @LIVEUPDATE_STATE_UNDEFINED:      State has not yet been initialized.
+ * @LIVEUPDATE_STATE_NORMAL:         Default state, no live update in progress.
+ * @LIVEUPDATE_STATE_PREPARED:       Live update is prepared for reboot; the
+ *                                   LIVEUPDATE_PREPARE callbacks have completed
+ *                                   successfully.
+ *                                   Devices might operate in a limited state
+ *                                   for example the participating devices might
+ *                                   not be allowed to unbind, and also the
+ *                                   setting up of new DMA mappings might be
+ *                                   disabled in this state.
+ * @LIVEUPDATE_STATE_FROZEN:         The final reboot event
+ *                                   (%LIVEUPDATE_FREEZE) has been sent, and the
+ *                                   system is performing its final state saving
+ *                                   within the "blackout window". User
+ *                                   workloads must be suspended. The actual
+ *                                   reboot (kexec) into the next kernel is
+ *                                   imminent.
+ * @LIVEUPDATE_STATE_UPDATED:        The system has rebooted into the next
+ *                                   kernel via live update the system is now
+ *                                   running the next kernel, awaiting the
+ *                                   finish event.
+ *
+ * These states track the progress and outcome of a live update operation.
+ */
+enum liveupdate_state  {
+	LIVEUPDATE_STATE_UNDEFINED = 0,
+	LIVEUPDATE_STATE_NORMAL = 1,
+	LIVEUPDATE_STATE_PREPARED = 2,
+	LIVEUPDATE_STATE_FROZEN = 3,
+	LIVEUPDATE_STATE_UPDATED = 4,
+};
+
+/**
+ * struct liveupdate_fd - Holds parameters for preserving and restoring file
+ * descriptors across live update.
+ * @fd:    Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: The user-space file
+ *         descriptor to be preserved.
+ *         Output for %LIVEUPDATE_IOCTL_FD_RESTORE: The new file descriptor
+ *         representing the fully restored kernel resource.
+ * @flags: Unused, reserved for future expansion, must be set to 0.
+ * @token: Input for %LIVEUPDATE_IOCTL_FD_PRESERVE: An opaque, unique token
+ *         preserved for preserved resource.
+ *         Input for %LIVEUPDATE_IOCTL_FD_RESTORE: The token previously
+ *         provided to the preserve ioctl for the resource to be restored.
+ *
+ * This structure is used as the argument for the %LIVEUPDATE_IOCTL_FD_PRESERVE
+ * and %LIVEUPDATE_IOCTL_FD_RESTORE ioctls. These ioctls allow specific types
+ * of file descriptors (for example memfd, kvm, iommufd, and VFIO) to have their
+ * underlying kernel state preserved across a live update cycle.
+ *
+ * To preserve an FD, user space passes this struct to
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE with the @fd field set. On success, the
+ * kernel uses the @token field to uniquly associate the preserved FD.
+ *
+ * After the live update transition, user space passes the struct populated with
+ * the *same* @token to %LIVEUPDATE_IOCTL_FD_RESTORE. The kernel uses the @token
+ * to find the preserved state and, on success, populates the @fd field with a
+ * new file descriptor referring to the restored resource.
+ */
+struct liveupdate_fd {
+	int		fd;
+	__u32		flags;
+	__aligned_u64	token;
+};
+
+/* The ioctl type, documented in ioctl-number.rst */
+#define LIVEUPDATE_IOCTL_TYPE		0xBA
+
+/**
+ * LIVEUPDATE_IOCTL_FD_PRESERVE - Validate and initiate preservation for a file
+ * descriptor.
+ *
+ * Argument: Pointer to &struct liveupdate_fd.
+ *
+ * User sets the @fd field identifying the file descriptor to preserve
+ * (e.g., memfd, kvm, iommufd, VFIO). The kernel validates if this FD type
+ * and its dependencies are supported for preservation. If validation passes,
+ * the kernel marks the FD internally and *initiates the process* of preparing
+ * its state for saving. The actual snapshotting of the state typically occurs
+ * during the subsequent %LIVEUPDATE_IOCTL_PREPARE execution phase, though
+ * some finalization might occur during freeze.
+ * On successful validation and initiation, the kernel uses the @token
+ * field with an opaque identifier representing the resource being preserved.
+ * This token confirms the FD is targeted for preservation and is required for
+ * the subsequent %LIVEUPDATE_IOCTL_FD_RESTORE call after the live update.
+ *
+ * Return: 0 on success (validation passed, preservation initiated), negative
+ * error code on failure (e.g., unsupported FD type, dependency issue,
+ * validation failed).
+ */
+#define LIVEUPDATE_IOCTL_FD_PRESERVE					\
+	_IOW(LIVEUPDATE_IOCTL_TYPE, 0x00, struct liveupdate_fd)
+
+/**
+ * LIVEUPDATE_IOCTL_FD_UNPRESERVE - Remove a file descriptor from the
+ * preservation list.
+ *
+ * Argument: Pointer to __u64 token.
+ *
+ * Allows user space to explicitly remove a file descriptor from the set of
+ * items marked as potentially preservable. User space provides a pointer to the
+ * __u64 @token that was previously returned by a successful
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE call (potentially from a prior, possibly
+ * cancelled, live update attempt). The kernel reads the token value from the
+ * provided user-space address.
+ *
+ * On success, the kernel removes the corresponding entry (identified by the
+ * token value read from the user pointer) from its internal preservation list.
+ * The provided @token (representing the now-removed entry) becomes invalid
+ * after this call.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., -EBUSY or -EINVAL
+ * if not in %LIVEUPDATE_STATE_NORMAL, bad address provided, invalid token value
+ * read, token not found).
+ */
+#define LIVEUPDATE_IOCTL_FD_UNPRESERVE					\
+	_IOW(LIVEUPDATE_IOCTL_TYPE, 0x01, __u64)
+
+/**
+ * LIVEUPDATE_IOCTL_FD_RESTORE - Restore a previously preserved file descriptor.
+ *
+ * Argument: Pointer to &struct liveupdate_fd.
+ *
+ * User sets the @token field to the value obtained from a successful
+ * %LIVEUPDATE_IOCTL_FD_PRESERVE call before the live update. On success,
+ * the kernel restores the state (saved during the PREPARE/FREEZE phases)
+ * associated with the token and populates the @fd field with a new file
+ * descriptor referencing the restored resource in the current (new) kernel.
+ * This operation must be performed *before* signaling completion via
+ * %LIVEUPDATE_IOCTL_FINISH.
+ *
+ * Return: 0 on success, negative error code on failure (e.g., invalid token).
+ */
+#define LIVEUPDATE_IOCTL_FD_RESTORE					\
+	_IOWR(LIVEUPDATE_IOCTL_TYPE, 0x02, struct liveupdate_fd)
+
+/**
+ * LIVEUPDATE_IOCTL_GET_STATE - Query the current state of the live update
+ * orchestrator.
+ *
+ * Argument: Pointer to &enum liveupdate_state.
+ *
+ * The kernel fills the enum value pointed to by the argument with the current
+ * state of the live update subsystem. Possible states are:
+ *
+ * - %LIVEUPDATE_STATE_NORMAL:   Default state; no live update operation is
+ *                               currently in progress.
+ * - %LIVEUPDATE_STATE_PREPARED: The preparation phase (triggered by
+ *                               %LIVEUPDATE_IOCTL_PREPARE) has completed
+ *                               successfully. The system is ready for the
+ *                               reboot transition. Note that some
+ *                               device operations (e.g., unbinding, new DMA
+ *                               mappings) might be restricted in this state.
+ * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully rebooted into the
+ *                               new kernel via live update. It is now running
+ *                               the new kernel code and is awaiting the
+ *                               completion signal from user space via
+ *                               %LIVEUPDATE_IOCTL_FINISH after
+ *                               restoration tasks are done.
+ *
+ * See the definition of &enum liveupdate_state for more details on each state.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+#define LIVEUPDATE_IOCTL_GET_STATE					\
+	_IOR(LIVEUPDATE_IOCTL_TYPE, 0x03, enum liveupdate_state)
+
+/**
+ * LIVEUPDATE_IOCTL_PREPARE - Initiate preparation phase and trigger state
+ * saving.
+ *
+ * Argument: None.
+ *
+ * Initiates the live update preparation phase. This action corresponds to
+ * the internal %LIVEUPDATE_PREPARE. This typically triggers the saving process
+ * for items marked via the PRESERVE ioctls. This typically occurs *before*
+ * the "blackout window", while user applications (e.g., VMs) may still be
+ * running. Kernel subsystems receiving the %LIVEUPDATE_PREPARE event should
+ * serialize necessary state. This command does not transfer data.
+ *
+ * Return: 0 on success, negative error code on failure. Transitions state
+ * towards %LIVEUPDATE_STATE_PREPARED on success.
+ */
+#define LIVEUPDATE_IOCTL_PREPARE					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x04)
+
+/**
+ * LIVEUPDATE_IOCTL_CANCEL - Cancel the live update preparation phase.
+ *
+ * Argument: None.
+ *
+ * Notifies the live update subsystem to abort the preparation sequence
+ * potentially initiated by %LIVEUPDATE_IOCTL_PREPARE. This action
+ * typically corresponds to the internal %LIVEUPDATE_CANCEL kernel event,
+ * which might also be triggered automatically if the PREPARE stage fails
+ * internally.
+ *
+ * When triggered, subsystems receiving the %LIVEUPDATE_CANCEL event should
+ * revert any state changes or actions taken specifically for the aborted
+ * prepare phase (e.g., discard partially serialized state). The kernel
+ * releases resources allocated specifically for this *aborted preparation
+ * attempt*.
+ *
+ * This operation cancels the current *attempt* to prepare for a live update
+ * but does **not** remove previously validated items from the internal list
+ * of potentially preservable resources. Consequently, preservation tokens
+ * previously generated by successful %LIVEUPDATE_IOCTL_FD_PRESERVE or calls
+ * generally **remain valid** as identifiers for those potentially preservable
+ * resources. However, since the system state returns towards
+ * %LIVEUPDATE_STATE_NORMAL, user space must initiate a new live update sequence
+ * (starting with %LIVEUPDATE_IOCTL_PREPARE) to proceed with an update
+ * using these (or other) tokens.
+ *
+ * This command does not transfer data. Kernel callbacks for the
+ * %LIVEUPDATE_CANCEL event must not fail.
+ *
+ * Return: 0 on success, negative error code on failure. Transitions state back
+ * towards %LIVEUPDATE_STATE_NORMAL on success.
+ */
+#define LIVEUPDATE_IOCTL_CANCEL						\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x06)
+
+/**
+ * LIVEUPDATE_IOCTL_EVENT_FINISH - Signal restoration completion and trigger
+ * cleanup.
+ *
+ * Argument: None.
+ *
+ * Signals that user space has completed all necessary restoration actions in
+ * the new kernel (after a live update reboot). This action corresponds to the
+ * internal %LIVEUPDATE_FINISH kernel event. Calling this ioctl triggers the
+ * cleanup phase: any resources that were successfully preserved but were *not*
+ * subsequently restored (reclaimed) via the RESTORE ioctls will have their
+ * preserved state discarded and associated kernel resources released. Involved
+ * devices may be reset. All desired restorations *must* be completed *before*
+ * this. Kernel callbacks for the %LIVEUPDATE_FINISH event must not fail.
+ * Successfully completing this phase transitions the system state from
+ * %LIVEUPDATE_STATE_UPDATED back to %LIVEUPDATE_STATE_NORMAL. This command does
+ * not transfer data.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+#define LIVEUPDATE_IOCTL_FINISH						\
+	_IO(LIVEUPDATE_IOCTL_TYPE, 0x07)
+
+#endif /* _UAPI_LIVEUPDATE_H */
diff --git a/tools/lib/luo/libluo.c b/tools/lib/luo/libluo.c
new file mode 100644
index 000000000000..7de4bf01de16
--- /dev/null
+++ b/tools/lib/luo/libluo.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: LGPL-3.0-or-later
+/*
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ */
+#include <libluo.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+/*
+ * The liveupdate header is not mainline right now, so it is not available on
+ * the system include path. It is copied from Linux tree and put in include/.
+ *
+ * This can be removed when liveupdate hits mainline.
+ */
+#include <liveupdate.h>
+
+#define LUO_DEVICE_PATH	"/dev/liveupdate"
+
+/* File descriptor for the LUO device */
+static int luo_fd = -1;
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+int luo_init(void)
+{
+	if (luo_fd >= 0)
+		/* Already initialized */
+		return 0;
+
+	luo_fd = open(LUO_DEVICE_PATH, O_RDWR);
+	if (luo_fd < 0) {
+		int err = -errno;
+
+		fprintf(stderr, "Failed to open %s: %s\n",
+			LUO_DEVICE_PATH, strerror(errno));
+		return err;
+	}
+
+	return 0;
+}
+
+void luo_cleanup(void)
+{
+	if (luo_fd >= 0) {
+		close(luo_fd);
+		luo_fd = -1;
+	}
+}
+
+bool luo_is_available(void)
+{
+	struct stat st;
+
+	/* Use stat() to check if the device file exists and is accessible */
+	if (stat(LUO_DEVICE_PATH, &st) < 0)
+		return false;
+
+	/* Verify it's a character device file.  */
+	if (!S_ISCHR(st.st_mode))
+		return false;
+
+	return true;
+}
+
+int luo_get_state(enum liveupdate_state *state)
+{
+	int ret;
+
+	if (!state)
+		return -EINVAL;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_GET_STATE, state);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_fd_preserve(int fd, uint64_t token)
+{
+	struct liveupdate_fd fd_data;
+	int ret;
+
+	if (fd < 0)
+		return -EINVAL;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	fd_data.fd = fd;
+	fd_data.flags = 0;  /* Must be set to 0 as per API documentation */
+	fd_data.token = token;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_FD_PRESERVE, &fd_data);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_fd_unpreserve(uint64_t token)
+{
+	int ret;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_FD_UNPRESERVE, &token);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_fd_restore(uint64_t token, int *fd)
+{
+	struct liveupdate_fd fd_data;
+	int ret;
+
+	if (!fd)
+		return -EINVAL;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	fd_data.fd = -1;    /* Will be filled by the kernel */
+	fd_data.flags = 0;  /* Must be set to 0 as per API documentation */
+	fd_data.token = token;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_FD_RESTORE, &fd_data);
+	if (ret < 0)
+		return -errno;
+
+	*fd = fd_data.fd;
+	return 0;
+}
+
+int luo_prepare(void)
+{
+	int ret;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_PREPARE);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_cancel(void)
+{
+	int ret;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_CANCEL);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_finish(void)
+{
+	int ret;
+
+	if (luo_fd < 0)
+		return -EBADF;
+
+	ret = ioctl(luo_fd, LIVEUPDATE_IOCTL_FINISH);
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+const char *luo_state_to_string(enum liveupdate_state state)
+{
+	static const char * const state_strings[] = {
+		[LIVEUPDATE_STATE_UNDEFINED] = "undefined",
+		[LIVEUPDATE_STATE_NORMAL] = "normal",
+		[LIVEUPDATE_STATE_PREPARED] = "prepared",
+		[LIVEUPDATE_STATE_FROZEN] = "frozen",
+		[LIVEUPDATE_STATE_UPDATED] = "updated"
+	};
+
+	if (state >= 0 && state < ARRAY_SIZE(state_strings) && state_strings[state])
+		return state_strings[state];
+
+	return "UNKNOWN";
+}
-- 
2.50.0.727.gbf7dc18ff4-goog


