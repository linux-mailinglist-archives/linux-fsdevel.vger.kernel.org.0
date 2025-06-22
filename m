Return-Path: <linux-fsdevel+bounces-52391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC4AE2F57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 12:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD8E1892940
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBD1C84BB;
	Sun, 22 Jun 2025 10:20:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020481C84D0;
	Sun, 22 Jun 2025 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750587646; cv=none; b=FTv2ZquAL6sqkfMdJCltG/fePTEW2bUY6kG2E8SS4jUWaNYJOFOcEkRYdkoRndW8pxhCrTkbtN344S8jIJcSZP0W3oMB4YJiMnj2mzQ/WpzRFFeEiVvT59N+zKOylwNZBXmPcWzERLNlNyxMSS8sv7IJeOvCKjFNZPpd91+dJ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750587646; c=relaxed/simple;
	bh=aBr5ug3pbfIIRk62LUQKZ+EqAMQWAhKPmPnsru18T2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMfN6ilOLAz9gJQyv9+Xe2UNbQ2X6HGLjALl/iIDc6uSCAoXyqwjHXP2QSTx5vw9UJJSMKK00VGS1tUjYOFy44c+J4qdUZXjp9LTOa9jaUPMzPzxr9Y7AGKhe+IclRo98eBLORK0x7d0VOEL6lhe0kXhhsOz7ud8E1JLssFqOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bQ62p3Ttmz9sZD;
	Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6FkHDcQTmUzv; Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bQ62p2bPnz9sXD;
	Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 50BE08B765;
	Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id B7f7mpVTx9fe; Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 598B58B764;
	Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
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
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] uaccess: Add masked_user_{read/write}_access_begin
Date: Sun, 22 Jun 2025 11:52:39 +0200
Message-ID: <6fddae0cf0da15a6521bb847b63324b7a2a067b1.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750585958; l=3699; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=aBr5ug3pbfIIRk62LUQKZ+EqAMQWAhKPmPnsru18T2w=; b=aJLPxkFnAJjAAnY0M+etgKWknkSFXagT8tFBPQmYzWl+GOTm3envK6GdDSt+ZAJhzvqm23pRc 8C2dbv0jA/oBse2u5aACyUyBHpCpJRg5EdA/oAqEDbh/PIRmkp3wF2J
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Allthough masked_user_access_begin() seems to only be used when reading
data from user at the moment, introduce masked_user_read_access_begin()
and masked_user_write_access_begin() in order to match
user_read_access_begin() and user_write_access_begin().

Have them default to masked_user_access_begin() when they are
not defined.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 fs/select.c             | 2 +-
 include/linux/uaccess.h | 8 ++++++++
 kernel/futex/futex.h    | 4 ++--
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 9fb650d03d52..d8547bedf5eb 100644
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
index 7c06f4795670..682a0cd2fe51 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -41,6 +41,14 @@
  #define mask_user_address(src) (src)
 #endif
 
+#ifndef masked_user_write_access_begin
+#define masked_user_write_access_begin masked_user_access_begin
+#endif
+#ifndef masked_user_read_access_begin
+#define masked_user_read_access_begin masked_user_access_begin
+#endif
+
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617212ee..6cfcafa00736 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -305,7 +305,7 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 	u32 val;
 
 	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
+		from = masked_user_read_access_begin(from);
 	else if (!user_read_access_begin(from, sizeof(*from)))
 		return -EFAULT;
 	unsafe_get_user(val, from, Efault);
@@ -320,7 +320,7 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
 	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
+		to = masked_user_read_access_begin(to);
 	else if (!user_read_access_begin(to, sizeof(*to)))
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


