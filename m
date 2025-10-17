Return-Path: <linux-fsdevel+bounces-64467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B4BE8254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37D71AA4450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DB329C6C;
	Fri, 17 Oct 2025 10:50:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CD328B6D;
	Fri, 17 Oct 2025 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698248; cv=none; b=SwY3mQSC0rJaIAGKecaI5e/g2GYSDncFnlMFkOoCTwHjp15jtPwG7osRCmTebjuhRSBYd9lB6ZKJbHhxLm0yhQHcx1EDwINQhZi7+81CWBsbYQ6cQrn8ca1YeQr/7ntiDC6FwR1Pt6C1J721vEkVrMWDmax8Gf129lPr5ptTxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698248; c=relaxed/simple;
	bh=LUaYsPfBDAifxBCt3YcfvFtnZBPfaSxbCGY+1bgSYgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtSfn1U3dFiwXp6jLxWYpRo6TPfLHeWgQC7vvsXYZgJh/0n3P/4aP8oI/e9RkQYE3q1rs+g2fJFNNeH5ZeinWkymLQcouhnH6Va+BEy55pbR4milx1HI5qnDbfEdKMBdR058eL22AiTwg+Y2xKhexa9Y/xl7Jg+9nRbg6CCQTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17q3TdNz9sSW;
	Fri, 17 Oct 2025 12:21:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MUd0DI8w8h4X; Fri, 17 Oct 2025 12:21:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17q2C4rz9sSV;
	Fri, 17 Oct 2025 12:21:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 351218B786;
	Fri, 17 Oct 2025 12:21:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PrL50SiMsfQc; Fri, 17 Oct 2025 12:21:27 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CB558B780;
	Fri, 17 Oct 2025 12:21:26 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 03/10] uaccess: Add masked_user_{read/write}_access_begin
Date: Fri, 17 Oct 2025 12:20:59 +0200
Message-ID: <a4ef0a8e1659805c60fafc8d3b073ecd08117241.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4825; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=LUaYsPfBDAifxBCt3YcfvFtnZBPfaSxbCGY+1bgSYgY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kpjMrdxgqHHhJa+5y5dc/303H/NN3Lr9qOCUqV5nf 616vDt2aUcpC4MYF4OsmCLL8f/cu2Z0fUnNn7pLH2YOKxPIEAYuTgGYSG4hI8PugxP0XD6+P++d tLxF6urFura8RdaX1zJtUZoQsmR3WYwow1+pk7tD5bt6dou+nsl7waZn/fqVSZp/NS8Vn1N76Xp zWxsbAA==
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
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
v3: Rebased on top of v6.18-rc1 ==> change in net/core/scm.c

v2: Added more explanations in the commit message following comments received.
---
 fs/select.c             | 2 +-
 include/linux/uaccess.h | 7 +++++++
 kernel/futex/futex.h    | 4 ++--
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 net/core/scm.c          | 2 +-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e235..36db0359388c8 100644
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
index 1beb5b395d81d..aa48d5415d32f 100644
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
index 2cd57096c38e1..a1120a318c186 100644
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
index 6dc234913dd58..5bb752ff7c61b 100644
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
index 6e489f9e90f15..4a6574b67f824 100644
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
diff --git a/net/core/scm.c b/net/core/scm.c
index 66eaee783e8be..4a65f9baa87e7 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -274,7 +274,7 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 		check_object_size(data, cmlen - sizeof(*cm), true);
 
 		if (can_do_masked_user_access())
-			cm = masked_user_access_begin(cm);
+			cm = masked_user_write_access_begin(cm);
 		else if (!user_write_access_begin(cm, cmlen))
 			goto efault;
 
-- 
2.49.0


