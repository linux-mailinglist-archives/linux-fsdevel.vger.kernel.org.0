Return-Path: <linux-fsdevel+bounces-68755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A27C65432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 125864ECC80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372D82FB990;
	Mon, 17 Nov 2025 16:50:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C62FC02F;
	Mon, 17 Nov 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398256; cv=none; b=fQ6ytzf9kCSbo7KQCdmgQ46i7jC4HwwPHG8FetkMlcdL9SfD9s0BovgFDLbbzubHX7ui64FhVcRb07rBDdIhs66bL59TkjnJRtVy63MTxnA0iavIarQYcZ+XZ41JAWLt0sefZrggnRo0O9F9mKPH7EcRYTBZXKYKMDE7KqcCzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398256; c=relaxed/simple;
	bh=qDckhyWd5Xp/iUbxoRJgosMNjecj8byVLupzPsFbxdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/9oyjZvJMhJZ741l9iecsMdhMhgZcdmlEAxHoKri3QiUniULuaOcgrgRKgJgcFGj9gSKAE4JmAz7xtfrvntMQKIqP+jbnvbUVkSzTim2LOduJb2IXEfDvxjJOa0xMcecUTVC2mqqn1RZ5CDnrfIJKI5Ki90WUS2CVjpd/MJW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d9D9B0fVlz9sTk;
	Mon, 17 Nov 2025 17:44:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eU0hj9tte4dv; Mon, 17 Nov 2025 17:44:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d9D996cx9z9sTj;
	Mon, 17 Nov 2025 17:44:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CE2E78B763;
	Mon, 17 Nov 2025 17:44:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id tff4OGSdT2mn; Mon, 17 Nov 2025 17:44:13 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A48D28B768;
	Mon, 17 Nov 2025 17:44:12 +0100 (CET)
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
Subject: [PATCH v5 4/4] lib/strn*,uaccess: Use masked_user_{read/write}_access_begin when required
Date: Mon, 17 Nov 2025 17:43:44 +0100
Message-ID: <cb5e4b0fa49ea9c740570949d5e3544423389757.1763396724.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1763396724.git.christophe.leroy@csgroup.eu>
References: <cover.1763396724.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=qDckhyWd5Xp/iUbxoRJgosMNjecj8byVLupzPsFbxdU=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRKB5zwcf5XZ8nQsPWQR3SBdCH7ipUnHdxv1zv7Ku9On 1xYOe1CRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIyQJGhg+x8vzW+28u3+X+ ZFGOZmr8v6hj/g/nf9VfOM1v700nrukM/71WCtXdYlPy+rWCe77xJ9dct9gfnaqndGPERLYczlm gxQkA
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
v5:
- Removed net/core/scm.c which is converted to scope user access by previous patch
- Renamed the patch as it now only handles lib/strncpy_from_user.c and lib/strnlen_user.c

v4: Rebased on top of core-scoped-uaccess tag

v3: Rebased on top of v6.18-rc1 ==> change in net/core/scm.c

v2: Added more explanations in the commit message following comments received.
---
 lib/strncpy_from_user.c | 2 +-
 lib/strnlen_user.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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


