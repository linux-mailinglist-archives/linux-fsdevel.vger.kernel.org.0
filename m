Return-Path: <linux-fsdevel+bounces-67295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA30C3ABE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25084252F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCADD322DBB;
	Thu,  6 Nov 2025 11:50:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA085322533;
	Thu,  6 Nov 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429832; cv=none; b=WJh7F6ebMW20xGaMNyW16A+hIjLE5o60XxpUT5YQWLxK15qZzeRSkxrICc4fRW0ThgE/iXGMdl/8rKjcRPOElm9t38bmpPBnSr+3fhWBJTpek4x4nyENpiFacxnbd6vdGH95gHfybqtxQCXiAovZ3fpOXyiK40+UbNUF8igURBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429832; c=relaxed/simple;
	bh=JbwTKyEVJnLxf6vUj4X6LS+htzn0H89SnAxtpthgjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiFy7nPQ0JX5BexeKa6jlTw+xt2ePsvkYe5O8lUIHLq05eig4ATv9mTKvHHKKVz+pOFFxTHz/PbHVI6BNgiMoXyTxdNs3Xy+aql1+8fxyLmWCRnZ+Vealwkiezo3WnUf26X+PKaGLjwU3JJW3vzckHuc/zB4CIK+76Qu8wh7Pig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmH1bTsz9sSS;
	Thu,  6 Nov 2025 12:32:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6NDt_p5pCji; Thu,  6 Nov 2025 12:32:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmG5Dshz9sSR;
	Thu,  6 Nov 2025 12:32:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C6C38B77E;
	Thu,  6 Nov 2025 12:32:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WhhXQCFH8cNy; Thu,  6 Nov 2025 12:32:14 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C88D58B77B;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
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
Subject: [PATCH v4 03/10] uaccess: Use masked_user_{read/write}_access_begin when required
Date: Thu,  6 Nov 2025 12:31:21 +0100
Message-ID: <5effda898b110d413dc84a53c5664d4c9d11c1bf.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=JbwTKyEVJnLxf6vUj4X6LS+htzn0H89SnAxtpthgjmY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytGtV3awWzTHfJtQUKdunn7/rKJefqp9Svuu84yfzM w/Xx6l0lLIwiHExyIopshz/z71rRteX1Pypu/Rh5rAygQxh4OIUgImE+zP8FX27es3+1X056vcK S2LiedpF+ht7Kn5VLpq0qFw/vrzDheF/pu3bJymrPmnY5rxwYawqja3bl/mDddbpQzkGS/X2bJj GBQA=
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Properly use masked_user_read_access_begin() and
masked_user_write_access_begin() instead of masked_user_access_begin()
in order to match user_read_access_end() and user_write_access_end().
This is important for architectures like powerpc that enable
separately user reads and user writes.

That means masked_user_read_access_begin() is used when user memory is
exclusively read during the window and masked_user_write_access_begin()
is used when user memory is exclusively writen during the window.
masked_user_access_begin() remains and is used when both reads and
writes are performed during the open window. Each of them is expected
to be terminated by the matching user_read_access_end(),
user_write_access_end() and user_access_end().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: Rebased on top of core-scoped-uaccess tag

v3: Rebased on top of v6.18-rc1 ==> change in net/core/scm.c

v2: Added more explanations in the commit message following comments received.
---
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 net/core/scm.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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


