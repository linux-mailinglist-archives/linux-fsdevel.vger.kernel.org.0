Return-Path: <linux-fsdevel+bounces-58762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC6B31539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE4660541D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F32EE615;
	Fri, 22 Aug 2025 10:20:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D872EE281;
	Fri, 22 Aug 2025 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858059; cv=none; b=bxP0xLxngwGoOre8mH8zCk6O+s3i7L2nq/3WxtHJ0WH/gKFFwJHO3McQ6c/8P7vfeWwMSEGLfgQTaacovZ0JAj1//CPh3/gVH2ZrMx2iIuvFFQra5yGi22TDsYr6xG1NHa3nhTsqhEl90sqyQDp/WNh4R3l8iJeGi0dr4TnnWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858059; c=relaxed/simple;
	bh=dM/STExlfioZ7RWL1LZ1zuqJ7l+Gd1UGLLRM2BZr8VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVc4TrVJNkFMBBgEwrqGrkSAh2g6VmmXcRYspoBUQGugWEEgo54H5GP0bL7yFTkn5oJUh0CnCJmz36hZQfvj3ZF633Z12/ngmIANED4/1hh+LdBli/d4JAycRUm8PCfMBKG0MmTLQZrTdOZPTOJxuCGRo5ftdFukX3fwOkIOlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGn55hjz9sSS;
	Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pu_SUmsG5KVL; Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGn4GTMz9sSR;
	Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E0CC8B781;
	Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id i33fjxtVLFhx; Fri, 22 Aug 2025 11:58:09 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 704358B780;
	Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 03/10] uaccess: Add masked_user_{read/write}_access_begin
Date: Fri, 22 Aug 2025 11:57:59 +0200
Message-ID: <7b570e237f7099d564d7b1a270169428ac1f3099.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856678; l=4235; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=dM/STExlfioZ7RWL1LZ1zuqJ7l+Gd1UGLLRM2BZr8VQ=; b=LfW2Zrcf/qOLKMyRJmXFszZyR+auMiNHDPsO2CmZ3LWYtqVMaj5jy30Bs37sk/DpkfpY4ScpY BhH/brYHdWZCciqcb6YZXz9IaYEwPiyBPpDY3g/qom3TrZu+gfvLQVX
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Allthough masked_user_access_begin() is to only be used when reading
data from user at the moment, introduce masked_user_read_access_begin()
and masked_user_write_access_begin() in order to match
user_read_access_begin() and user_write_access_begin().

That means masked_user_read_access_begin() is used when user memory is
exclusively read during the window, masked_user_write_access_begin()
is used when user memory is exclusively writen during the window,
masked_user_access_begin() remains and is used when both reads and
writes are performed during the open window. Each of them is expected
to be terminated by the matching user_read_access_end(),
user_write_access_end() and user_access_end().

Have them default to masked_user_access_begin() when they are
not defined.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Added more explanations in the commit message following comments received.
---
 fs/select.c             | 2 +-
 include/linux/uaccess.h | 7 +++++++
 kernel/futex/futex.h    | 4 ++--
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e23..36db0359388c 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -777,7 +777,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
 		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
+			from = masked_user_read_access_begin(from);
 		else if (!user_read_access_begin(from, sizeof(*from)))
 			return -EFAULT;
 		unsafe_get_user(to->p, &from->p, Efault);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..aa48d5415d32 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -41,6 +41,13 @@
  #define mask_user_address(src) (src)
 #endif
 
+#ifndef masked_user_write_access_begin
+#define masked_user_write_access_begin masked_user_access_begin
+#endif
+#ifndef masked_user_read_access_begin
+#define masked_user_read_access_begin masked_user_access_begin
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 2cd57096c38e..a1120a318c18 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -303,7 +303,7 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 	u32 val;
 
 	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
+		from = masked_user_read_access_begin(from);
 	else if (!user_read_access_begin(from, sizeof(*from)))
 		return -EFAULT;
 	unsafe_get_user(val, from, Efault);
@@ -318,7 +318,7 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
 	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
+		to = masked_user_write_access_begin(to);
 	else if (!user_write_access_begin(to, sizeof(*to)))
 		return -EFAULT;
 	unsafe_put_user(val, to, Efault);
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 6dc234913dd5..5bb752ff7c61 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -126,7 +126,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (can_do_masked_user_access()) {
 		long retval;
 
-		src = masked_user_access_begin(src);
+		src = masked_user_read_access_begin(src);
 		retval = do_strncpy_from_user(dst, src, count, count);
 		user_read_access_end();
 		return retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6e489f9e90f1..4a6574b67f82 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -99,7 +99,7 @@ long strnlen_user(const char __user *str, long count)
 	if (can_do_masked_user_access()) {
 		long retval;
 
-		str = masked_user_access_begin(str);
+		str = masked_user_read_access_begin(str);
 		retval = do_strnlen_user(str, count, count);
 		user_read_access_end();
 		return retval;
-- 
2.49.0


