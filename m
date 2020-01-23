Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49B8146898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAWNAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 08:00:09 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63707 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgAWNAA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:00:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483Mn85D26z9vB4k;
        Thu, 23 Jan 2020 13:59:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=FrIBpB+S; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MTbpDlw4sfRu; Thu, 23 Jan 2020 13:59:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483Mn847xRz9vB4X;
        Thu, 23 Jan 2020 13:59:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579784396; bh=Vfl0AOa1Mdh0VxoIajIH2/Esuy8toZoWQbvUL/0X23U=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=FrIBpB+SvgnON+NoB08b4tmtV/gabjQ+QjDlgAVWzVfpJ4Rwaw56UVOygjP39m9l3
         3S1JVj7pFA7m8SULhfKcZQCjXxL83qnG9/i5HYVNGJlg59WK54M85n9faaXoVT3OEt
         +7aK2mr/N/s1Hseu2VJcRpJbKhb5gmMgurZg45jM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFF0C8B82E;
        Thu, 23 Jan 2020 13:59:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MYYQpzE1hRXB; Thu, 23 Jan 2020 13:59:57 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 880168B82C;
        Thu, 23 Jan 2020 13:59:57 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5DE51651C0; Thu, 23 Jan 2020 12:59:57 +0000 (UTC)
Message-Id: <408c90c4068b00ea8f1c41cca45b84ec23d4946b.1579783936.git.christophe.leroy@c-s.fr>
In-Reply-To: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 6/7] powerpc/32s: Prepare allow_user_access() for
 user_access_begin()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 23 Jan 2020 12:59:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation of implementing user_access_begin and friends
on powerpc, allow_user_access() need to be prepared for
user_access_begin()

user_access_end() doesn't provide the address and size which
were passed to user_access_begin(), required by prevent_user_access()
to know which segment to modify. But user_access_end() takes an
opaque value returned by user_access_begin().

Make allow_user_access() return the value it writes to current->kuap.
This will allow user_access_end() to recalculate the segment range
without having to read current->kuap.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v3: Replaces the patch "Prepare prevent_user_access() for user_access_end()"
---
 arch/powerpc/include/asm/book3s/32/kup.h       | 15 ++++++++++-----
 arch/powerpc/include/asm/book3s/64/kup-radix.h |  7 +++++--
 arch/powerpc/include/asm/kup.h                 |  8 ++++++--
 arch/powerpc/include/asm/nohash/32/kup-8xx.h   |  6 ++++--
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 3c1798e56b55..128dcbf3a19d 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -102,23 +102,28 @@ static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
 	isync();	/* Context sync required after mtsrin() */
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      u32 size, unsigned long dir)
+/* Make sure we never return 0. We only use top and bottom 4 bits */
+static __always_inline unsigned long
+allow_user_access(void __user *to, const void __user *from, u32 size, unsigned long dir)
 {
 	u32 addr, end;
+	unsigned long kuap;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
 	if (!(dir & KUAP_W))
-		return;
+		return 0x100;
 
 	addr = (__force u32)to;
 
 	if (unlikely(addr >= TASK_SIZE || !size))
-		return;
+		return 0x100;
 
 	end = min(addr + size, TASK_SIZE);
-	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
+	kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
+	current->thread.kuap = kuap;
 	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
+
+	return kuap;
 }
 
 static __always_inline void prevent_user_access(void __user *to, const void __user *from,
diff --git a/arch/powerpc/include/asm/book3s/64/kup-radix.h b/arch/powerpc/include/asm/book3s/64/kup-radix.h
index f11315306d41..183f0c87017b 100644
--- a/arch/powerpc/include/asm/book3s/64/kup-radix.h
+++ b/arch/powerpc/include/asm/book3s/64/kup-radix.h
@@ -77,8 +77,9 @@ static inline void set_kuap(unsigned long value)
 	isync();
 }
 
-static __always_inline void allow_user_access(void __user *to, const void __user *from,
-					      unsigned long size, unsigned long dir)
+static __always_inline unsigned long
+allow_user_access(void __user *to, const void __user *from,
+		  unsigned long size, unsigned long dir)
 {
 	// This is written so we can resolve to a single case at build time
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
@@ -88,6 +89,8 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 		set_kuap(AMR_KUAP_BLOCK_READ);
 	else
 		set_kuap(0);
+
+	return 1;
 }
 
 static inline void prevent_user_access(void __user *to, const void __user *from,
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ff57bfcb88f7..691fec5afd4a 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -45,8 +45,12 @@ static inline void setup_kuep(bool disabled) { }
 void setup_kuap(bool disabled);
 #else
 static inline void setup_kuap(bool disabled) { }
-static inline void allow_user_access(void __user *to, const void __user *from,
-				     unsigned long size, unsigned long dir) { }
+static inline unsigned long allow_user_access(void __user *to, const void __user *from,
+					      unsigned long size, unsigned long dir)
+{
+	return 1;
+}
+
 static inline void prevent_user_access(void __user *to, const void __user *from,
 				       unsigned long size, unsigned long dir) { }
 static inline bool
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 1d70c80366fd..ee673d3c0ab6 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -34,10 +34,12 @@
 
 #include <asm/reg.h>
 
-static inline void allow_user_access(void __user *to, const void __user *from,
-				     unsigned long size, unsigned long dir)
+static inline unsigned long allow_user_access(void __user *to, const void __user *from,
+					      unsigned long size, unsigned long dir)
 {
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
+
+	return 1;
 }
 
 static inline void prevent_user_access(void __user *to, const void __user *from,
-- 
2.25.0

