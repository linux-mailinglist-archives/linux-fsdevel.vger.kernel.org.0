Return-Path: <linux-fsdevel+bounces-48608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA67AB1544
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B22D4E5063
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E62918DD;
	Fri,  9 May 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLrDjXmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF729186E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797570; cv=none; b=qWziff/5XbV5itMuFE2WxEBGp03PPJv72JPaxRqvPTMJUCJGWgn15atGzr3D8KcJ+PNsDZVbAFnmk8DKFP8AayGJ62Djj9N2jn8P9ZuREIo0a6vuLi040TvlV5olOcrjTYIgGT0e7AR6unXz2qyX0Teueh99ikCTs88IQCW107E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797570; c=relaxed/simple;
	bh=0HV/FOTf+6BT0U0cuOOdg33w8zcMoFsvpUobVZkABi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGuZqrS9bBM/Zo7rl8zKhsRzLG1yzR30RRRbhaOn2BNfx+pnQlNJx9yHzl9QtrfGS2UjxSCdm3rKvIGnmVxosjCEpj9ccFRoZ0Pw86lhJVNdAXdyphINcLwHz1B+l78GlmRsBz4SfyV0lohcWvmuvicaO8TkI+baptZz58amb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLrDjXmh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso330571f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797567; x=1747402367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anRC/0cwUrvD/HN5szla7eKMiWzmUPXoUVcOrSHz6p8=;
        b=PLrDjXmhMy5PRZZJ+fuuYknqQ4wLkU8nIo37IPCLrI7HKok6yPfGUcqaU900NjFi/n
         ricDj4vSza2FxrQvd0FuBhCB9uCFpASJWvtfRjG8IcGKf8Y9AzDIgS3KyArjWXf2YYpp
         qP6g9JLZV+Q3OQ9sUXxhl39OqbDXN42uqwfFaO9+3Q2uWKoLClaitRQE0JLyy2d/j1pE
         VfeWluz/OLoidfAmxms2PozD+NTUY7sn+NLSGdwg7YRwgTFbwoVf9VIzXg+98mbLRsMS
         A6BZ1tKhp/zs6q3rWVd2gw+gcRStDCzHA+tHlAFGhszo0Iko5Ka06rYMXkULmjmofCud
         L6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797567; x=1747402367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anRC/0cwUrvD/HN5szla7eKMiWzmUPXoUVcOrSHz6p8=;
        b=vGsTRGvLI52e5aaEs+9psjC8ZQ7G+nEFJvdLv1vKt7OGP6Afj18hGLjY5frei3znMm
         yuFfwRAeR1yS6l37PJaTMNXHJqGyZbX3vSo+PTNbgNslLQZLp+aYHDIpwfDkmyZpfB6l
         3ksQwUOt20j9LwzOSKGfXEBDbeaROwYYTj2UhEYg2J2DThImYhLpcSZ2cvrS/A2niHWr
         d2/CXL12ioTJbPuqovBrsdoSKUUawfLI3fgPcsDpKJaLvULa/rnIqNyF0qQdNlHhaBr9
         yFX0rFhxvzpmOeYvGpZ3kBLL6sBT6SfJezPLavK3nQekMTN5PMYD8dcxyYBIHlHApN7y
         B0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbWLIyNZGfCRsWI2Tv05uXi7RwQ5n4uWtTAUGl6bt+pVw0JfxvPzZRAlEv3fHqrIuYtcPU81l1X4c1NvKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8RojCmIUSFET+L7vzzJJ7V3/MDihdv+NylLlxGjfF6cjVn5G
	5r/dkBOfDEYnFiqi9+bEZ5XhEJ54880m1AcahcZH58Ll8lxv60qe
X-Gm-Gg: ASbGnctfV+wON4viZvEPw6IB90Uz00AejkokL/0jdrLzSeF8h4VYCWhOBaEnb75NLMa
	YUwBxVk9+Ozt8iP12ML9YkG1EzDgr/w6DC64J58n/F/iHiA76AF5oIesus51vrkBvSWZmEsCffc
	opi5y0sNi7KSrpE77De4blbBdN+6EIXU6flQziMuLSrox016XUT77wLVaGOHNLqux6tFLOjryPt
	u+UQGVlIiwhFSO4Er7pPRpTnoaTduIEeon1T7BupN7pJWKrRH2hTa/OsmOLsaa9BhCeYkLFZSdX
	fBrjx0qiJ8OrAgjDlerHdeUnMM7zt9Eja3U/U245clA66XHJckxLNK1ObdeTZnXMgIan9gEF+ps
	gz/DKhs4npLTtAcRinUt6RoMMzivhhhWnwbxsIg==
X-Google-Smtp-Source: AGHT+IG99pmk+qPno9KJpm8p3rNYSIyJHpcUD9wSxyZLfjmPmHSloB1RFG8CSCSaIa54zqbDRxNn7w==
X-Received: by 2002:a05:6000:430e:b0:39f:efb:c2f6 with SMTP id ffacd0b85a97d-3a1f646600fmr3225130f8f.33.1746797566778;
        Fri, 09 May 2025 06:32:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/8] selftests/pidfd: move syscall definitions into wrappers.h
Date: Fri,  9 May 2025 15:32:35 +0200
Message-Id: <20250509133240.529330-4-amir73il@gmail.com>
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

There was already duplicity in some of the defintions.

Remove syscall number defintions for __ia64__ that are
both stale and incorrect.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../testing/selftests/filesystems/wrappers.h  | 42 ++++++++++-
 .../selftests/pidfd/pidfd_bind_mount.c        | 74 +------------------
 2 files changed, 42 insertions(+), 74 deletions(-)

diff --git a/tools/testing/selftests/filesystems/wrappers.h b/tools/testing/selftests/filesystems/wrappers.h
index b9b090ef47b4..420ae4f908cf 100644
--- a/tools/testing/selftests/filesystems/wrappers.h
+++ b/tools/testing/selftests/filesystems/wrappers.h
@@ -40,6 +40,28 @@ static inline int sys_mount(const char *src, const char *tgt, const char *fst,
 #define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
 #endif
 
+#ifndef MOVE_MOUNT_T_EMPTY_PATH
+#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040 /* Empty to path permitted */
+#endif
+
+#ifndef __NR_move_mount
+	#if defined __alpha__
+		#define __NR_move_mount 539
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_move_mount 4429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_move_mount 6429
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_move_mount 5429
+		#endif
+	#else
+		#define __NR_move_mount 429
+	#endif
+#endif
+
 static inline int sys_move_mount(int from_dfd, const char *from_pathname,
 				 int to_dfd, const char *to_pathname,
 				 unsigned int flags)
@@ -57,7 +79,25 @@ static inline int sys_move_mount(int from_dfd, const char *from_pathname,
 #endif
 
 #ifndef AT_RECURSIVE
-#define AT_RECURSIVE 0x8000
+#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
+#endif
+
+#ifndef __NR_open_tree
+	#if defined __alpha__
+		#define __NR_open_tree 538
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_open_tree 4428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_open_tree 6428
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_open_tree 5428
+		#endif
+	#else
+		#define __NR_open_tree 428
+	#endif
 #endif
 
 static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
diff --git a/tools/testing/selftests/pidfd/pidfd_bind_mount.c b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
index 7822dd080258..c094aeb1c620 100644
--- a/tools/testing/selftests/pidfd/pidfd_bind_mount.c
+++ b/tools/testing/selftests/pidfd/pidfd_bind_mount.c
@@ -15,79 +15,7 @@
 
 #include "pidfd.h"
 #include "../kselftest_harness.h"
-
-#ifndef __NR_open_tree
-	#if defined __alpha__
-		#define __NR_open_tree 538
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_open_tree 4428
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_open_tree 6428
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_open_tree 5428
-		#endif
-	#elif defined __ia64__
-		#define __NR_open_tree (428 + 1024)
-	#else
-		#define __NR_open_tree 428
-	#endif
-#endif
-
-#ifndef __NR_move_mount
-	#if defined __alpha__
-		#define __NR_move_mount 539
-	#elif defined _MIPS_SIM
-		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
-			#define __NR_move_mount 4429
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
-			#define __NR_move_mount 6429
-		#endif
-		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
-			#define __NR_move_mount 5429
-		#endif
-	#elif defined __ia64__
-		#define __NR_move_mount (428 + 1024)
-	#else
-		#define __NR_move_mount 429
-	#endif
-#endif
-
-#ifndef MOVE_MOUNT_F_EMPTY_PATH
-#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004 /* Empty from path permitted */
-#endif
-
-#ifndef MOVE_MOUNT_F_EMPTY_PATH
-#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040 /* Empty to path permitted */
-#endif
-
-static inline int sys_move_mount(int from_dfd, const char *from_pathname,
-                                 int to_dfd, const char *to_pathname,
-                                 unsigned int flags)
-{
-        return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
-                       to_pathname, flags);
-}
-
-#ifndef OPEN_TREE_CLONE
-#define OPEN_TREE_CLONE 1
-#endif
-
-#ifndef OPEN_TREE_CLOEXEC
-#define OPEN_TREE_CLOEXEC O_CLOEXEC
-#endif
-
-#ifndef AT_RECURSIVE
-#define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
-#endif
-
-static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
-{
-	return syscall(__NR_open_tree, dfd, filename, flags);
-}
+#include "../filesystems/wrappers.h"
 
 FIXTURE(pidfd_bind_mount) {
 	char template[PATH_MAX];
-- 
2.34.1


