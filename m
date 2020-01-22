Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE61454AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 14:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAVNA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 08:00:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:21233 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbgAVNAl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:00:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482lrQ0w0Pz9v4T5;
        Wed, 22 Jan 2020 14:00:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=asxrAUK4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id K994pD9OcgtK; Wed, 22 Jan 2020 14:00:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482lrP6xDNz9v4T4;
        Wed, 22 Jan 2020 14:00:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579698038; bh=p9gINth/nDuzFeykCT9Ex40uYSsIuyztIe3V1N19VeY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=asxrAUK4apDAM78ttunvrwObfFC3Uuc7voda+IWzqCEpDmNIDllZ0k37f3a692EWq
         nSg0ZpuCIxgdfFyYvYqAPdvj+YA+CHFe2ZrxJBbEqOumIyXKGqmz5kK1MvefLgInPS
         GwEDO3+HsvL2HO7SCWe13SRLgAmCUdgtvpMMJfnw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EBAEE8B7FA;
        Wed, 22 Jan 2020 14:00:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KO4zAQH-MR6m; Wed, 22 Jan 2020 14:00:38 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C19F18B800;
        Wed, 22 Jan 2020 14:00:38 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B9621651E0; Wed, 22 Jan 2020 13:00:38 +0000 (UTC)
Message-Id: <35e82a783b398c085e7e76d2bc754cc831c87541.1579697910.git.christophe.leroy@c-s.fr>
In-Reply-To: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 4/6] powerpc/32s: Drop NULL addr verification
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 22 Jan 2020 13:00:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NULL addr is a user address. Don't waste time checking it. If
someone tries to access it, it will SIGFAULT the same way as for
address 1, so no need to make it special.

The special case is when not doing a write, in that case we want
to drop the entire function. This is now handled by 'dir' param
and not by the nulity of 'to' anymore.

Also make beginning of prevent_user_access() similar
to beginning of allow_user_access(), and tell the compiler
that writing in kernel space or with a 0 length is unlikely

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index d765515bd1c1..3c1798e56b55 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -113,7 +113,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 
 	addr = (__force u32)to;
 
-	if (!addr || addr >= TASK_SIZE || !size)
+	if (unlikely(addr >= TASK_SIZE || !size))
 		return;
 
 	end = min(addr + size, TASK_SIZE);
@@ -124,16 +124,18 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 static __always_inline void prevent_user_access(void __user *to, const void __user *from,
 						u32 size, unsigned long dir)
 {
-	u32 addr = (__force u32)to;
-	u32 end = min(addr + size, TASK_SIZE);
+	u32 addr, end;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
 	if (!(dir & KUAP_W))
 		return;
 
-	if (!addr || addr >= TASK_SIZE || !size)
+	addr = (__force u32)to;
+
+	if (unlikely(addr >= TASK_SIZE || !size))
 		return;
 
+	end = min(addr + size, TASK_SIZE);
 	current->thread.kuap = 0;
 	kuap_update_sr(mfsrin(addr) | SR_KS, addr, end);	/* set Ks */
 }
-- 
2.25.0

