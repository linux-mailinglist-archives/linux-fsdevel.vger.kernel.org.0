Return-Path: <linux-fsdevel+bounces-55944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63394B10A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06A5584595
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663BA2D46D1;
	Thu, 24 Jul 2025 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YmObt6aa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48D2D238B;
	Thu, 24 Jul 2025 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360612; cv=none; b=pCXLCpwvWG1J9CTYYdLgURSxzZCruVmQL8ecs7YRQGyjf3/pei33Go2NrvSYs7Y3WTH24N4V47ehw9cnKDsAtGbbuEA1WVQ19O/E1NPWJcOiSCqOfdTkrJQAA8Qd7j2C7k94qpF7Hnu+vVCm5VA3CsTdMcqjdfl0TGVE5s3lBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360612; c=relaxed/simple;
	bh=ZTxbfBR4e9g+Vo8kn1KwzFv9oZCibHXpEedTrwXLllA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmhBZpsUZRS6/H24u0WDALz+8dwDAwOezpsnuzKER54F2TQOss5iBv74OXDGX+NhCJV3h512wF6OGHQFYEvY0PCH4CGGHzLOsNAIfvg3wQxclGpr0ou9uyqZoxTL+RA/c/U4D8gA7jwHCz4UOSH1+x5qYL2HbAteM4ZL4q68tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YmObt6aa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ay/n4segqzBtdJcxqD3V5D84mQe9aCStMnYXrz6ny88=; b=YmObt6aaSGJMlOElGiwShkA2s/
	x+rR+nIVtETN4fxSYbthlIKDkyjCfgR7qOqA2UrOGd6LqO9gw+PYxxgZeFBICgr7qUdtBFjLfFM7W
	Nv6FYxDlDTRkKpz7GL0fSTbio5vcycsCc4PJA8PCHRR1bHBai76XHK/b43JKemwkCIWlhbbfMAkTb
	gqSIPF5a/3ltQT2Oof/c5JVFCWpFY3GVTi9kubC7jULyNgI/FYDBiLBzkTqvdzXSqfrewsSh5ATab
	kwkzlCsK1mZ1XhkC/u2qTga8BFUrn9aoaENc/c1pPMTM8oBR6w0dtJKqrpK08kecCVUjhPzt7lpqE
	YouuGFPg==;
Received: from [223.233.78.24] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uevBm-003BPU-Nn; Thu, 24 Jul 2025 14:36:47 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v6 3/3] include: Set tsk->comm length to 64 bytes
Date: Thu, 24 Jul 2025 18:06:12 +0530
Message-Id: <20250724123612.206110-4-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250724123612.206110-1-bhupesh@igalia.com>
References: <20250724123612.206110-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Historically due to the 16-byte length of TASK_COMM_LEN, the
users of 'tsk->comm' are restricted to use a fixed-size target
buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.

To fix the same, we now use a 64-byte TASK_COMM_EXT_LEN and
set the comm element inside 'task_struct' to the same length:
       struct task_struct {
	       .....
               char    comm[TASK_COMM_EXT_LEN];
	       .....
       };

       where TASK_COMM_EXT_LEN is 64-bytes.

Now, in order to maintain existing ABI, we ensure that:

- Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm'
  truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
- New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
 'tsk->comm' supported up to the maximum of 'TASK_COMM_EXT_LEN' (64-bytes).

Note, that the existing users have not been modified to migrate to
'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
dealing with only a 'TASK_COMM_LEN' long 'tsk->comm'.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/sched.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8bbd03f1b978..b6abb759292c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -317,6 +317,7 @@ struct user_event_mm;
  */
 enum {
 	TASK_COMM_LEN = 16,
+	TASK_COMM_EXT_LEN = 64,
 };
 
 extern void sched_tick(void);
@@ -1159,7 +1160,7 @@ struct task_struct {
 	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
 	 *     zero-padded
 	 */
-	char				comm[TASK_COMM_LEN];
+	char				comm[TASK_COMM_EXT_LEN];
 
 	struct nameidata		*nameidata;
 
@@ -1954,7 +1955,7 @@ extern void kick_process(struct task_struct *tsk);
 
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
-	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
+	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
 	__set_task_comm(tsk, from, false);		\
 })
 
@@ -1974,6 +1975,10 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
 #define get_task_comm(buf, tsk) ({			\
 	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
 	strscpy_pad(buf, (tsk)->comm);			\
+	if ((sizeof(buf)) == TASK_COMM_LEN)		\
+		buf[TASK_COMM_LEN - 1] = '\0';		\
+	else						\
+		buf[TASK_COMM_EXT_LEN - 1] = '\0';	\
 	buf;						\
 })
 
-- 
2.38.1


