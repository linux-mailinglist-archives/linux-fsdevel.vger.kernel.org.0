Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A99145B22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAVRwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:52:54 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:5565 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgAVRwx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:52:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482tKY450Pz9vBf4;
        Wed, 22 Jan 2020 18:52:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=najcw7ip; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2vbxDVXx3gT8; Wed, 22 Jan 2020 18:52:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482tKY348bz9vBf1;
        Wed, 22 Jan 2020 18:52:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579715569; bh=Wl+zaBbMBZgvhufq6pfrc9DXJ49WhaqTuzhVpUiFLfc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=najcw7ipVpyl+ds1ybPWEWZx+Trqykq2FxH5AIjJ30tw07JF6/cNp4jIt8m0CpJeD
         wP4sRYVC6CHoqC1gOZDF9buVV+XHf19z0DrlNATjwVUMcvrK+DW5G3ESN4BzvfF9kH
         YZdGZ/BD0xWu+IDv5XGoNUvkiz+i+CEVEtflYF7s=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 251308B810;
        Wed, 22 Jan 2020 18:52:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lXx_an0ltPsO; Wed, 22 Jan 2020 18:52:51 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAC3D8B7FE;
        Wed, 22 Jan 2020 18:52:50 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B3ABD651E0; Wed, 22 Jan 2020 17:52:50 +0000 (UTC)
Message-Id: <d79cb9f680f4e971e05262303103a4b94baa91ce.1579715466.git.christophe.leroy@c-s.fr>
In-Reply-To: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 4/6] powerpc/32s: Drop NULL addr verification
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 22 Jan 2020 17:52:50 +0000 (UTC)
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
v2: no change
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

