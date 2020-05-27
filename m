Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE01E4458
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbgE0Ntm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 09:49:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbgE0Ntl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 09:49:41 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MV6G6-1jTNlu1Was-00S3bg; Wed, 27 May 2020 15:49:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf_fdpic: fix execfd build regression
Date:   Wed, 27 May 2020 15:49:01 +0200
Message-Id: <20200527134911.1024114-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tix/bfncLqcvkzlr2Of2L9H3YtX9HuSaEtBUOBjASBeKdIZtPlc
 c19hmm9NvcQ2JaefzsfnEUWJyO3nrW7CFvrGLHULdxI++jnQD/Z/pGh+4qgAi1HbAcJvN0O
 VnZO8X/B22cv2XXUBxD4mQE9MuYOp/S8/lvA+7ijEgeFpwbzoufDo6znkyk3/f9MNVIdCEr
 eF3abH2fY2h0cBWWMn7Pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Glgg6CSdwOg=:ceJKDWPnefN0UE4Fib6v8Z
 1qFH3+59/NZRv07wHGUu+MYuCx2FUK4dzIe8pSf2bVnjPBec4Mm7dWATe1n9dIZgeZqlVMu8H
 TCRkfEopCUc7HXdRfWxDKziLAS8pOG+dIrjG9YpwiIuQXTSF4vi2vBomxoMIb0xqMTgNmRShk
 amIoaAGPo0Do8cbe6xWVWZtzqWBELqrqxx+XOqVgqrmQwGKrcNh488GHIKvpV+JLWq2YE854G
 Szu4rZ8HEDnu2LKj4K7VnbQ0IyPo0aiBEAlatRQHPwlw7nBFsefaa60lkNUl0MLwfqBzWucqS
 k0tifPAcnMF24uyifrvsPiLL4mYOFEwFFjwr0+ljHZbhhAXjk8WeFKhdUH+8dMozLKzpKM7Ws
 UXaizqj19Khb7QEvJXIIl3em+xxuxphSrZEq+koV2PUvVdKm3yGlPGGbRhf0KjPjfxjuR4m/O
 Vp1qnUpIe+5uPtISKQgGoaUhosNyiAqIKta+4J19lnZMW28EllLr5AnAESjYU785AkrzYrRiA
 zG5ag3OcUvpd2cmJujiNoUmjam5zDI1eFyoIga8HOyvncnFqKJIlWqYB80prBmwjPozMehk15
 vGMbG1yDpq9kWAnm1ZHZC6BckGjupOZozQVM3VEZrpFWUR/CtXrN+wrC2qrt1kuKfpYOAgv7p
 5hmuw4Q052AWWbTiedO142Miilw7YV7KcTQocca9+vpGQBFRmXxizoaHa4VkhgWgGY5nENYoK
 lGqY+jNtMUBCt0Q6eA2z2Od5eNuEicgcjhxBveeevpWC5sE89zJvj8An5+Cngw3QXlhNFlo7n
 89qz4C5mdD32DUTEJkk81+1W1Hz8Cr2jN59sHNC/L/hwOVtXKk=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The change to bprm->have_execfd was incomplete, leading
to a build failure:

fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared

Change the last user of BINPRM_FLAGS_EXECFD in a corresponding
way.

Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
Fixes: b8a61c9e7b4a ("exec: Generic execfd support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have no idea whether this is right, I only looked briefly at
the commit that introduced the problem.
---
 fs/binfmt_elf_fdpic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index bba3ad555b94..aaf332d32326 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -588,7 +588,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	nitems = 1 + DLINFO_ITEMS + (k_platform ? 1 : 0) +
 		(k_base_platform ? 1 : 0) + AT_VECTOR_SIZE_ARCH;
 
-	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD)
+	if (bprm->have_execfd)
 		nitems++;
 
 	csp = sp;
-- 
2.26.2

