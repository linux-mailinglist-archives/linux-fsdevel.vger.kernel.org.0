Return-Path: <linux-fsdevel+bounces-48351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9902DAADCFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854E27BF12D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0372367BE;
	Wed,  7 May 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c+V9v308"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA528236440;
	Wed,  7 May 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615922; cv=none; b=i9k7/WhFFjZb4Ha09VUSB4m4UFw1qcGRY7B2yq7BIbtUT1JIg720qbJcTwVATZrj1v2LIzMPP9A2SRKFiDLFKUrXAM0FlVcXvykcUZh5s0xDGPpK7wf4riqxhYfRGeVmP66KiRn/Uxzk/UDymD/+Wpg1j7xFCoJNQsyYXzDsM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615922; c=relaxed/simple;
	bh=7XqKkySLH3XnP5dCcWNxk+0DtN1bkrte9oK/saSgtts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkicUFrTvhY138a/CCgpQMK24xtIgJeOUid3Fx8kFtDRyFdUQhmKy1l/n68I2grxddwLbcEtfFaL8dpG+++W/kFk+6FSHRhJRDXkRK762JniHJhmJoQiXleq8YkgQQ2hMxSNv5kLT6E002eqiqZJcg23owUX7EX/+bul+9kjeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c+V9v308; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=51AuBhOBwcqdxbUaoVuoZuKLaFvWUDOFVfRKxcUsvBc=; b=c+V9v308TdkSpaG+OfUH7HAacT
	9/B9haik3YVxK0Ia3scGUjrCntDrNaLtCbHYvRr2HNnjF7DVkLEicy0+dtcxdd2NlxYVC1gLPGtt7
	n8ibJh4vHTvLTsjgyF5oXT788+GUY0ltDBPXOAhKweJeJZr5ZYypXBOVik9/+ipxGfij5ozXQoDTK
	hMwpeT2LSMeUG3TWyYhsjTij331Vx2F16L9PFbz6qLBFUu3Dxk8ClrOAuwC/4x18wvjTy0fpXX2mZ
	Gy1DeGH7iZnapCCKlVg5ohtDpP3yg6HJgiwRB8pBEwHHxGeHrenrerLHCVQlCVlzz73u92xCeOpdM
	ZDzBRbYg==;
Received: from [223.233.66.62] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uCcWg-004fhg-Ha; Wed, 07 May 2025 13:05:17 +0200
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
	vschneid@redhat.com
Subject: [PATCH v3 3/3] exec: Add support for 64 byte 'tsk->real_comm'
Date: Wed,  7 May 2025 16:34:44 +0530
Message-Id: <20250507110444.963779-4-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250507110444.963779-1-bhupesh@igalia.com>
References: <20250507110444.963779-1-bhupesh@igalia.com>
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

To fix the same, Linus suggested in [1] that we can add the
following union inside 'task_struct':
       union {
               char    comm[TASK_COMM_LEN];
               char    real_comm[REAL_TASK_COMM_LEN];
       };

and then modify '__set_task_comm()' to pass 'tsk->real_comm'
to the existing users.

This would mean that:
(1) The old common pattern of just printing with '%s' and tsk->comm
    would just continue to work (as it is):

        pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
                current->comm, page_to_pfn(page));

(2) And, the memcpy() users of 'tsk->comm' would need to be made more
    stable by ensuring that the destination buffer always has a closing
    NUL character (done already in the preceding patch in this series).

So, eventually:
- users who want the existing 'TASK_COMM_LEN' behavior will get it
  (existing ABIs would continue to work),
- users who just print out 'tsk->comm' as a string will get the longer
  new "real comm",
- users who do 'sizeof(->comm)' will continue to get the old value
  because of the union.

[1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/exec.c             | 6 +++---
 include/linux/sched.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..2b2f2dacc013 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1190,11 +1190,11 @@ static int unshare_sighand(struct task_struct *me)
  */
 void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
 {
-	size_t len = min(strlen(buf), sizeof(tsk->comm) - 1);
+	size_t len = min(strlen(buf), sizeof(tsk->real_comm) - 1);
 
 	trace_task_rename(tsk, buf);
-	memcpy(tsk->comm, buf, len);
-	memset(&tsk->comm[len], 0, sizeof(tsk->comm) - len);
+	memcpy(tsk->real_comm, buf, len);
+	memset(&tsk->real_comm[len], 0, sizeof(tsk->real_comm) - len);
 	perf_event_comm(tsk, exec);
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cb219c6db179..2744d90badf1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -317,6 +317,7 @@ struct user_event_mm;
  */
 enum {
 	TASK_COMM_LEN = 16,
+	REAL_TASK_COMM_LEN = 64,
 };
 
 extern void sched_tick(void);
@@ -1162,7 +1163,10 @@ struct task_struct {
 	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
 	 *     zero-padded
 	 */
-	char				comm[TASK_COMM_LEN];
+	union {
+		char			comm[TASK_COMM_LEN];
+		char			real_comm[REAL_TASK_COMM_LEN];
+	};
 
 	struct nameidata		*nameidata;
 
@@ -2005,7 +2009,7 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
  */
 #define get_task_comm(buf, tsk) ({			\
 	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
-	strscpy_pad(buf, (tsk)->comm);			\
+	strscpy_pad(buf, (tsk)->real_comm);		\
 	buf;						\
 })
 
-- 
2.38.1


