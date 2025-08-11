Return-Path: <linux-fsdevel+bounces-57251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F1B1FF8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8136417206A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB052D948A;
	Mon, 11 Aug 2025 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ptqdBLk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D22D7818;
	Mon, 11 Aug 2025 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894803; cv=none; b=BQLhNLH37lG/Mg+nXjgLW8xIS/QYZmpNdulfI/8A2GWZisywBchHcwzV328J3XDJvnrKr/UzjM7gblbIZ6RM+onN7xry+rD3710GNos2Y9Cn5g4Shqx4ME614t4n325JYoi500+Gf47+ks3UFyEiC42C6HSkqgGwtSKBQQLOQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894803; c=relaxed/simple;
	bh=xA6I6V5RcV7kAy9Brc3IGuiS6TL+tbl6mcXlmUmGFT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYr1VC90QIKaTbmABBTM4jWp4FtOhjwqIYi5i5bJ2QzcA7Mqf8Zry62mcYJuB8ymSPsNymLOHeBh37WZaAlVXaNZCwNohO6fevxZQUcNEg2rytb1VeEjBD0ltx/wWmDQ2MnpUIb+PGjO1hRI3UsY0HQBG/FOUurBp8EDeMKz+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ptqdBLk0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AkOlSlHnGVT1KRBhwKqmf727gWs6TB6cX2vkRjDeLAc=; b=ptqdBLk0JKXdgsD1MQ7pDWNbTJ
	Yx6u6119QunQo0/L3znvKKPWvfMTw2okCRnwrEiRIRokDj1xoz/hYlOpd6xAEXBuoefl8ebPAJWfM
	a8W4kh0bCi0vufydf+xHW33x3Q/dIONhTo01K5Mh3sDrHL18fF1d6WTvbZ/IWAENhbHLW7EY+r0Cg
	GhV4G6bw1PCYjifGJuvX/EesWsCX6t4y+2t9SWGNtas36iC45P42cXDjqAlINGwf/eDK2ygbczQdR
	aj3YnkYVkBcFXcsTFgwnJxeQCrFVIvvVxF2F6+Fa9hUOmoxA1WuzkDINqs1aLpAX/ewJv9rhHknHu
	FwX5swJQ==;
Received: from [223.233.69.163] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulMIn-00Cdun-Li; Mon, 11 Aug 2025 08:46:38 +0200
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
Subject: [PATCH v7 2/4] include: Set tsk->comm length to 64 bytes
Date: Mon, 11 Aug 2025 12:16:07 +0530
Message-Id: <20250811064609.918593-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250811064609.918593-1-bhupesh@igalia.com>
References: <20250811064609.918593-1-bhupesh@igalia.com>
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

Note, that the existing users have not been modified to migrate to
'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
dealing with only a 'TASK_COMM_LEN' long 'tsk->comm'.

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 include/linux/sched.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 35f1ef06eb6c..87e9dfaf61ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -318,6 +318,7 @@ struct user_event_mm;
  */
 enum {
 	TASK_COMM_LEN = 16,
+	TASK_COMM_EXT_LEN = 64,
 };
 
 extern void sched_tick(void);
@@ -1162,7 +1163,7 @@ struct task_struct {
 	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
 	 *     zero-padded
 	 */
-	char				comm[TASK_COMM_LEN];
+	char				comm[TASK_COMM_EXT_LEN];
 
 	struct nameidata		*nameidata;
 
@@ -1961,7 +1962,7 @@ extern void kick_process(struct task_struct *tsk);
 
 extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
 #define set_task_comm(tsk, from) ({			\
-	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
+	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
 	__set_task_comm(tsk, from, false);		\
 })
 
-- 
2.38.1


