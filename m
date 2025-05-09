Return-Path: <linux-fsdevel+bounces-48606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BBAB154A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097BC3AE083
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8428291895;
	Fri,  9 May 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq/FDcR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50620227B81
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797569; cv=none; b=aCnIWp1X87h+MwHCEAk0hclL/AFDiNgNEb9LrAA22j2alX7BWIK8fes40XQot1teNY25AEtgfVNIRax6tMRqM/NcrkTOwadr2vLGs3m7DHiacUVfeQ1y68oemQaCOznBt/ExzHVfn8W2Yw01MvQ+bzYyBfVQqP+wwdsylKMZOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797569; c=relaxed/simple;
	bh=cPKf+uWwneyFZJhSeF0ryu3rvtciUsIoujQvtYWicDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WPptFyP9xi5cQx/UYx7Z1aE3Jv3+8kL5yw88FedVWoAVM17upWawGgNSFAyJlUMxCtsc1coSmgCw5nXZGwD8T2DoTflm6dt8KBpfl840j4U72xwhXcyDSL13g5l2oHtqz2nPtj9fK0TtV/RO61xyj8D9NLk/6Ltx+FCeUjLTP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq/FDcR3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1754881f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797565; x=1747402365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56/lmvkequii3cV8Rbqqz+D4lUZKtoZdAkJGEDgnCUw=;
        b=Fq/FDcR38h+s3moX9BhO0YCxnnLfWsjaAvsYpPd5EjCwtlAij7NEOgDP50Aia8v/jU
         nSJInKjokqJnUi1K9z+XPMmfmHvhwY2VetJmDDGtCZN5nPKPOGPx91CX714MHeW8VGPL
         Lu4xsbevvcTT1rRn6zwgw4Nf4iDNGYXv2ys9ikkoCV/MxMxgGBtUx3tugQcyr2hcFCgN
         FfC8RjifHg/sRvVw8z+Boq1s29+JLyFfVTKwwzr9TDby7FFszpFdzFf2NBFZPysHE8rZ
         kGJoOJifAcJ3XazZVqSeV9Atehq6sd6MBuGIKPgp/qfYOxdJRVWXrG/CACkq6g+KDD6J
         1BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797565; x=1747402365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56/lmvkequii3cV8Rbqqz+D4lUZKtoZdAkJGEDgnCUw=;
        b=CkP1JUNc+24jXi0UfPWoUzSUuegPfeYHcpX2Qu2o77IxOxjmmry8JZCT9HJnocDNcP
         91VZf9MMxOn7UdXOjyo7PpcneYJwW/CTLdPC46tfgY9czFOw2jVQfN5Y/1OYVEyGUvws
         aH+mvaiZGj1Jq7bdMPUkSt25xi+zG+vd5Esy6Jfl2kdQLBGbx51/rAyeW6gOclEldJb8
         wgHUOMJYuQXwtUt7djp7MSUKKSD8YNha0NuD4P1JPcK1M03qZ2b4K/grejDFpCn1vhhi
         YKJjEK1t/XQG1AlA2bmkfY+lVAfzQwRyhn1K/TbLDFXVsIDPfTgcZP2NdYLn2QEa86zC
         qunQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+wRYK/XHzP7Kf3f0D9JzslzNdbc3YqbAblO9K1u71UpVVohCz31tIHyzgT2MK9WjXk6mCyscnwhRqb2PT@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrb3uE1PgehqCSi4RAt7gYxyJQq1itVGYxHyBQv3+B1vMP8Zzl
	UmupyfXm+NkOsNq3PP4BOVNhMI9D1PqFMb4sBFj3EGqQd0HpOwDF
X-Gm-Gg: ASbGncvt2roYALJmvGX3i8mMj8Awj4q4sVFOiQvQ0s0cldJfAnitXqh3a7W1KGKB7i3
	dhmhclCN0XWv3u8B6CaGgP9+TevesplUaHlC/cpp5KyPP+PvVm7UIm9RbKBQxQgBZbw9K9uURzg
	1ialaH66PJ772PP5+0D07CmjG19RpU2BjwmWNgfT0Bdhcg9HtX9Qn4xmAyNQr6/MdAF8NHKK/lD
	w952fbDjS46AdEeQqeXvoUdACBabRkRi4NrUmsr6MqCanUk6K+Sl1u0MO1xYo1kVc7XYYLolWfC
	qFNsiNcv29XqO9h3IJGrUq4dtkWmpISx+GP+f1jfpbNqb2pXzY6mv99yGCIuSTl+M7URh1MmieW
	pZmEoXKz/ddVd8HFlINMlquz/fvxLmjbdtMozMZmvx+LnvF9B
X-Google-Smtp-Source: AGHT+IEeyPwZB4bimaECkNjz2ev8rnB6Z7FUrhwTDWEBdaihAcfNkZRkTFjtLccXFjNWULdKXbJhpw==
X-Received: by 2002:a05:6000:2410:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a1f64b4562mr2434873f8f.42.1746797565168;
        Fri, 09 May 2025 06:32:45 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:44 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/8] selftests/filesystems: move wrapper.h out of overlayfs subdir
Date: Fri,  9 May 2025 15:32:33 +0200
Message-Id: <20250509133240.529330-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not an overlayfs specific header.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/testing/selftests/filesystems/overlayfs/Makefile          | 2 +-
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c     | 2 +-
 .../selftests/filesystems/overlayfs/set_layers_via_fds.c        | 2 +-
 tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h  | 0
 tools/testing/selftests/mount_setattr/Makefile                  | 2 ++
 tools/testing/selftests/mount_setattr/mount_setattr_test.c      | 2 +-
 6 files changed, 6 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/filesystems/{overlayfs => }/wrappers.h (100%)

diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/tools/testing/selftests/filesystems/overlayfs/Makefile
index 6c661232b3b5..d3ad4a77db9b 100644
--- a/tools/testing/selftests/filesystems/overlayfs/Makefile
+++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -Wall
 CFLAGS += $(KHDR_INCLUDES)
 LDLIBS += -lcap
 
-LOCAL_HDRS += wrappers.h log.h
+LOCAL_HDRS += ../wrappers.h log.h
 
 TEST_GEN_PROGS := dev_in_maps
 TEST_GEN_PROGS += set_layers_via_fds
diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 3b796264223f..31db54b00e64 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -17,7 +17,7 @@
 
 #include "../../kselftest.h"
 #include "log.h"
-#include "wrappers.h"
+#include "../wrappers.h"
 
 static long get_file_dev_and_inode(void *addr, struct statx *stx)
 {
diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
index 5074e64e74a8..dc0449fa628f 100644
--- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
+++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds.c
@@ -16,7 +16,7 @@
 #include "../../pidfd/pidfd.h"
 #include "log.h"
 #include "../utils.h"
-#include "wrappers.h"
+#include "../wrappers.h"
 
 FIXTURE(set_layers_via_fds) {
 	int pidfd;
diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
similarity index 100%
rename from tools/testing/selftests/filesystems/overlayfs/wrappers.h
rename to tools/testing/selftests/filesystems/wrappers.h
diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 0c0d7b1234c1..4d4f810cdf2c 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -2,6 +2,8 @@
 # Makefile for mount selftests.
 CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
 
+LOCAL_HDRS += ../filesystems/wrappers.h
+
 TEST_GEN_PROGS := mount_setattr_test
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 432d9af23ab2..9e933925b3c2 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -20,7 +20,7 @@
 #include <stdarg.h>
 #include <linux/mount.h>
 
-#include "../filesystems/overlayfs/wrappers.h"
+#include "../filesystems/wrappers.h"
 #include "../kselftest_harness.h"
 
 #ifndef CLONE_NEWNS
-- 
2.34.1


