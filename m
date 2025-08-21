Return-Path: <linux-fsdevel+bounces-58593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54867B2F52E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50247BAE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1972F658B;
	Thu, 21 Aug 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BMWp8pD7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16F2F549B;
	Thu, 21 Aug 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771740; cv=none; b=DqqXuSF0ymecuMYT0yBCRDtrMidzI0F5uG39ITV5/EU+jcOaHiy0/4lxNOukOAHjID7uvY7OC2tojo61jmuPwHKtnz8JABR2mBSvd8g/2LGBhRLbULjw/T0K98W33oLyKUVTkLJH7KXEXFZ19rK/ozetAH1U2DrOe75onym9EfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771740; c=relaxed/simple;
	bh=ITel6dwryUU1HeYPk6QFIUv0pmLNzObqsWadXZfwTu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OaDmpsfmFGh0WQu+Q1vf+rd/B7D4h9A78sNA5dEb8UZGceyPARioJ39lv4DZeNKTPLrn6qj1xKrXuBKJUB2mu3M0jt6upNLnG0buQYQP0k0aagK+gD8u64TOCdGh5ouSzbVTkyCQGSptBS3yRGAox+hJs4EPOYLF7FfkQYN5XGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BMWp8pD7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SqG59QcNd5zcgM/48bgbCRG/bObN6shwfOiwsu1X8jM=; b=BMWp8pD7b9GiEYM/tFJo1TnmAV
	Vc9hHbhfmKolOyJCKbBRqSIC4CjK59oqtpEVzZ4TBBJ+lNf628BnUHtepubkcq1W7FdVmQaqxOrOo
	PDKmL9ueul+Azb2iulfgVVYyI0CboZGmrTszyAHcAKXbqXbFT50OhNwmgj4GcgQHDN6uweDRRdyLw
	z22GvTK7IQ09Rxx/TLpaVz4ESQDBCwAD5X+iWk2IG2oachNyc4j5/Pci41Yuv9C+QqHjhJJskWOdT
	iqGC5p78QFQI7QoaWRX8QAUCbNSpR4TOKMkOFqmNW/+oTxc/f8Y6YiCGeDzSW5LZChJhAvWpkLhjB
	wmokEYVQ==;
Received: from [223.233.68.152] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1up2Qv-00HBmV-UT; Thu, 21 Aug 2025 12:22:14 +0200
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
Subject: [PATCH v8 2/5] include: Set tsk->comm length to 64 bytes
Date: Thu, 21 Aug 2025 15:51:49 +0530
Message-Id: <20250821102152.323367-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250821102152.323367-1-bhupesh@igalia.com>
References: <20250821102152.323367-1-bhupesh@igalia.com>
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
index 24216259cda4..bcebc5622e07 100644
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


