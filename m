Return-Path: <linux-fsdevel+bounces-68754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC3C65411
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D50EF28E00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EE2FFFAE;
	Mon, 17 Nov 2025 16:50:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A62FBDEE;
	Mon, 17 Nov 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398251; cv=none; b=fJeUHEOlwO5yXRrKDLnAsUy6FWWRTN1WAHEaeA3zbFzDcaftSXBPxGwqs/EQ77I11cN8SnR2uNGms92NZOjomuxtPrp3YfoYEA0s6kld6XPqqIsteRoEDCyZtimxewH/1PUSIg4hs/OCKmqjRLSOlj9xDZMRkUy6/t1MWZbRg8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398251; c=relaxed/simple;
	bh=G9vSR7KnQqIxN+4o+okHL5tWkQyiUXlrPWVzKylp4RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=faq947fRijeNANQ1bp8OZ4tVWOjK1ufkNcfgqMlRvla/0CbGcIrseY4Q2NTpjDIVocO577KMXJ+X+WYMwX3EvlU/+9yGkz37TVVbEMpgP6i2+YGo2gAxjDb4jQwMC3dWCFITOOG2uCkovzKwXH6s77FLoIMp0193d5JfZLtk3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d9D986Dcjz9sTh;
	Mon, 17 Nov 2025 17:44:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ODDw4OUpL3tH; Mon, 17 Nov 2025 17:44:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d9D98579Gz9sTZ;
	Mon, 17 Nov 2025 17:44:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D7F18B763;
	Mon, 17 Nov 2025 17:44:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hO1787tWgDqo; Mon, 17 Nov 2025 17:44:12 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FB1E8B768;
	Mon, 17 Nov 2025 17:44:11 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
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
	Nichlas Piggin <npiggin@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/4] scm: Convert put_cmsg() to scoped user access
Date: Mon, 17 Nov 2025 17:43:43 +0100
Message-ID: <793219313f641eda09a892d06768d2837246bf9f.1763396724.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763396724.git.christophe.leroy@csgroup.eu>
References: <cover.1763396724.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=G9vSR7KnQqIxN+4o+okHL5tWkQyiUXlrPWVzKylp4RY=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRKB5y4msa79uMdnvb97Ws8Dr5sdLO50Ghlq90Ym1rzX Ofc1FTWjlIWBjEuBlkxRZbj/7l3zej6kpo/dZc+zBxWJpAhDFycAjARSyVGhpazbZ9+HNTk3i7v amJmo3boZihrUcvNMkv+VxX/Nl/4F8vI8EOU7U+KU0bAKSa/9293WU7XvRW190pY0r+tVmXBk7d a8wMA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Replace the open coded implementation with the scoped user access
guards.

No functional change intended.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: New
---
 net/core/scm.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 66eaee783e8b..cd87f66671aa 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -273,17 +273,13 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 
 		check_object_size(data, cmlen - sizeof(*cm), true);
 
-		if (can_do_masked_user_access())
-			cm = masked_user_access_begin(cm);
-		else if (!user_write_access_begin(cm, cmlen))
-			goto efault;
-
-		unsafe_put_user(cmlen, &cm->cmsg_len, efault_end);
-		unsafe_put_user(level, &cm->cmsg_level, efault_end);
-		unsafe_put_user(type, &cm->cmsg_type, efault_end);
-		unsafe_copy_to_user(CMSG_USER_DATA(cm), data,
-				    cmlen - sizeof(*cm), efault_end);
-		user_write_access_end();
+		scoped_user_write_access_size(cm, cmlen, efault) {
+			unsafe_put_user(cmlen, &cm->cmsg_len, efault);
+			unsafe_put_user(level, &cm->cmsg_level, efault);
+			unsafe_put_user(type, &cm->cmsg_type, efault);
+			unsafe_copy_to_user(CMSG_USER_DATA(cm), data,
+					    cmlen - sizeof(*cm), efault);
+		}
 	} else {
 		struct cmsghdr *cm = msg->msg_control;
 
@@ -301,8 +297,6 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 	msg->msg_controllen -= cmlen;
 	return 0;
 
-efault_end:
-	user_write_access_end();
 efault:
 	return -EFAULT;
 }
-- 
2.49.0


