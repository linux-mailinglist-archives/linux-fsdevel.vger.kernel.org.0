Return-Path: <linux-fsdevel+bounces-64460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0426EBE8233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5C71566161
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E06320A3F;
	Fri, 17 Oct 2025 10:50:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5E31AF18;
	Fri, 17 Oct 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698215; cv=none; b=SMpmzRzqz9rbEWAuIAAFIsf9ToXmY3xI54QjxpsElErZwpVTkXQGfIaSBTuvsVe8AFDWPkCaKP8H2cRdFcomiveREzi3D8gJe7db7IgJjau3Ks+Lq25nqfFN8XaW2p0pzlfBpcmBf6OlUznSsRRvv0tCEyQeOTknYpzB4bTDlsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698215; c=relaxed/simple;
	bh=UvRe1comr2eR9AXgYZtq85YOzdzM9AabV0Yw9dB03zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY9YWW4bKQodjsTOvZiUaM/MDhzYmGaVIgUI/41c7AOgK08/uH0oXEQTIJKM0RCpwkZsEi1/TJqea7QqjGz4+IqoLV5hMh6kWp1m338tTx31yDSU4pwPUIS5TB84/SYbQbvuNmM13WW7rJSJv25igZLdZxZUnpMUdjDYjtXCbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17w0N06z9sSn;
	Fri, 17 Oct 2025 12:21:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFW7-YaYrFBX; Fri, 17 Oct 2025 12:21:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17v6MQLz9sSm;
	Fri, 17 Oct 2025 12:21:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C62308B786;
	Fri, 17 Oct 2025 12:21:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id RGRc2vgVmK50; Fri, 17 Oct 2025 12:21:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A01AE8B780;
	Fri, 17 Oct 2025 12:21:30 +0200 (CEST)
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
Subject: [PATCH v3 07/10] powerpc/uaccess: Refactor user_{read/write/}_access_begin()
Date: Fri, 17 Oct 2025 12:21:03 +0200
Message-ID: <bc416b7e34fbf6ed9cbdac4566f23ce30c0a0008.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=UvRe1comr2eR9AXgYZtq85YOzdzM9AabV0Yw9dB03zE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kphikPjQIlVxtt1uu8/8/Bt13125Kectqvz6vQxv6 L7pj/rOd5SyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJJCxkZLiXzfjswjqPzfkN 3h/vb63Ou6Q9Y/7mF0qpM/7vCXW+dJ+d4X+gzoGGUukPsj2FAYwpE6fkLLrsxO8y9+aU71yftBv f7WAEAA==
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

user_read_access_begin() and user_write_access_begin() and
user_access_begin() are now very similar. Create a common
__user_access_begin() that take direction as parameter.

In order to avoid a warning with the conditional call of
barrier_nospec() which is sometimes an empty macro, change it to a
do {} while (0).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New
---
 arch/powerpc/include/asm/barrier.h |  2 +-
 arch/powerpc/include/asm/uaccess.h | 46 +++++++++---------------------
 2 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 9e9833faa4af8..9d2f612cfb1d7 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -102,7 +102,7 @@ do {									\
 
 #else /* !CONFIG_PPC_BARRIER_NOSPEC */
 #define barrier_nospec_asm
-#define barrier_nospec()
+#define barrier_nospec()	do {} while (0)
 #endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 /*
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 698996f348914..49254f7d90691 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -410,50 +410,30 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 		unsigned size);
 
-static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline bool __user_access_begin(const void __user *ptr, size_t len,
+							     unsigned long dir)
 {
 	if (unlikely(!access_ok(ptr, len)))
 		return false;
 
 	might_fault();
 
-	barrier_nospec();
-	allow_read_write_user((void __user *)ptr, ptr, len);
+	if (dir & KUAP_READ)
+		barrier_nospec();
+	allow_user_access((void __user *)ptr, dir);
 	return true;
 }
-#define user_access_begin	user_access_begin
-#define user_access_end		prevent_current_access_user
-#define user_access_save	prevent_user_access_return
-#define user_access_restore	restore_user_access
 
-static __must_check __always_inline bool
-user_read_access_begin(const void __user *ptr, size_t len)
-{
-	if (unlikely(!access_ok(ptr, len)))
-		return false;
+#define user_access_begin(p, l)		__user_access_begin(p, l, KUAP_READ_WRITE)
+#define user_read_access_begin(p, l)	__user_access_begin(p, l, KUAP_READ)
+#define user_write_access_begin(p, l)	__user_access_begin(p, l, KUAP_WRITE)
 
-	might_fault();
-
-	barrier_nospec();
-	allow_read_from_user(ptr, len);
-	return true;
-}
-#define user_read_access_begin	user_read_access_begin
-#define user_read_access_end		prevent_current_read_from_user
+#define user_access_end()		prevent_user_access(KUAP_READ_WRITE)
+#define user_read_access_end()		prevent_user_access(KUAP_READ)
+#define user_write_access_end()		prevent_user_access(KUAP_WRITE)
 
-static __must_check __always_inline bool
-user_write_access_begin(const void __user *ptr, size_t len)
-{
-	if (unlikely(!access_ok(ptr, len)))
-		return false;
-
-	might_fault();
-
-	allow_write_to_user((void __user *)ptr, len);
-	return true;
-}
-#define user_write_access_begin	user_write_access_begin
-#define user_write_access_end		prevent_current_write_to_user
+#define user_access_save	prevent_user_access_return
+#define user_access_restore	restore_user_access
 
 #define unsafe_get_user(x, p, e) do {					\
 	__long_type(*(p)) __gu_val;				\
-- 
2.49.0


