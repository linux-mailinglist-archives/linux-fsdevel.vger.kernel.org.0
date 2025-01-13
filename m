Return-Path: <linux-fsdevel+bounces-39011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EFA0B1AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 09:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E9188643B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 08:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CB234966;
	Mon, 13 Jan 2025 08:50:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFFD233D69;
	Mon, 13 Jan 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758205; cv=none; b=kg9+NqUdwX92CyosPKxWtHCsveMDtnh62MAsBuCFwrMp1IUOD5GGICHu6YuI7VFDEJsT4rmOV0seMGHDKY5B8o1enWtPLaDeLCJcTIbMqux25udd6O3UwXBFjXRGDTIUqF6T8s2gijjkqqJmBl6OIT1JcxdnuiIqE0+dMX2sIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758205; c=relaxed/simple;
	bh=GfLmI1oWTT5uRUR64Gl4CbPAl2bkR1SyenD+AV/4gok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlmqRYmFt5Qxb1j4z66o600RicF9apaj8bpxjonQf06Wp7r1FJWKH+/jecXRyK2q+XijeXjVoaTlUBb0Ak/zgpIitCM068AylbwwSyWD7SICPOfhprCSobNwAjJgnud789GzPOcgEKY7u3JnC8A5nphyX0njwCtqCjFBGP+U/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YWlxx0DNFz9sRr;
	Mon, 13 Jan 2025 09:37:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w76OwdcTENrn; Mon, 13 Jan 2025 09:37:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YWlxw6dj0z9sRk;
	Mon, 13 Jan 2025 09:37:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D440C8B764;
	Mon, 13 Jan 2025 09:37:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zZzy_d-axCZi; Mon, 13 Jan 2025 09:37:40 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 750F08B763;
	Mon, 13 Jan 2025 09:37:40 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] select: Fix unbalanced user_access_end()
Date: Mon, 13 Jan 2025 09:37:24 +0100
Message-ID: <a7139e28d767a13e667ee3c79599a8047222ef36.1736751221.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736757445; l=1345; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GfLmI1oWTT5uRUR64Gl4CbPAl2bkR1SyenD+AV/4gok=; b=9CX9VONXbPj7xJyUWDM8Nk8fBIzdepNT6o+XxKeNrilu+ZzM4EpHCQ/SIUXNUN0+jMoe/QLPJ eBhPbM1+a6kCtU2dPS2rhfgKmldZ65AqaPKoRKZYFtvn4ainrXLJfU2
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

While working on implementing user access validation on powerpc
I got the following warnings on a pmac32_defconfig build:

	  CC      fs/select.o
	fs/select.o: warning: objtool: sys_pselect6+0x1bc: redundant UACCESS disable
	fs/select.o: warning: objtool: sys_pselect6_time32+0x1bc: redundant UACCESS disable

On powerpc/32s, user_read_access_begin/end() are no-ops, but the
failure path has a user_access_end() instead of user_read_access_end()
which means an access end without any prior access begin.

Replace that user_access_end() by user_read_access_end().

Fixes: 7e71609f64ec ("pselect6() and friends: take handling the combined 6th/7th args into helper")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index e223d1fe9d55..7da531b1cf6b 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -786,7 +786,7 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
 	}
 	return 0;
 Efault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 
@@ -1355,7 +1355,7 @@ static inline int get_compat_sigset_argpack(struct compat_sigset_argpack *to,
 	}
 	return 0;
 Efault:
-	user_access_end();
+	user_read_access_end();
 	return -EFAULT;
 }
 
-- 
2.47.0


