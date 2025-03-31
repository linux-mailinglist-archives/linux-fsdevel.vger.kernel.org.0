Return-Path: <linux-fsdevel+bounces-45340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4322A765B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783EC1889A78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378121E8335;
	Mon, 31 Mar 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TqEYOS1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572291E7C19;
	Mon, 31 Mar 2025 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423536; cv=none; b=n/uYZhTHpVgbyT4DVK/874eeHkTUpavP0OqHQpIT1m36bouqg8lWko0BDNtPqOmNdFLvtMj6Df5ELJR6hTP2W9z+DSwFNK6ww+0yqQATtH2e3B35dz76NVMnZGlh4R/3PCqzM+mW3VMCX38ZXxXBhR4tTq7L8TQeo9YVm6mQjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423536; c=relaxed/simple;
	bh=KdHzqtsGEaarH4qC3RnC2h6Djh19sDj4W+qW72GXONc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrteHUjj1Dmt4QzRGWKY4gDpnljfirq6OURLG+uxEmya0Lo4bQF07HKmVUtCuX5DgovvSh+MOYN7O/bH1ItkkadqgRCtx7O5cxoHOO2/8Nccw6CONpxV86kTk+ugSH3bj338KWLoyyIyatg93r2e+OG9BkNRVN6Gycxmq5Mm/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TqEYOS1L; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1vPxYQklOIhLFkReMGUcHBCTjGCn9JiiqKZjhqBdRYE=; b=TqEYOS1L0FuyNPN6TTGJbIhjWh
	Wv6kmaGcSFWdzjyJpWyzinSSBVAvoahZ250TPc1+V1nKbFfVCBHv+FvFswD5tjZsh2dAkXqtnmTqn
	5zHVmbIIPu8Jo0kw6gSUSxx9FqGex6HFS2inBsaidT5/qFyGPtuKfYSej51pL3w2heC79jIeihsYX
	Bv+yr86mXTMVr04VBnoEKyF1IRgG84bZ0qFmsuV2jRLOhgTfXlx/Z4jwy4Sbkd/l9Rbs805RMbwSk
	em+a+oZX74gkW+JRxRK6rA1gPrTj5zz4XLyDTiurr4h06HWLoQEhfwFblTMYFQEazwBPiYZg7S4O1
	pmUfRABg==;
Received: from [223.233.69.2] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzE6M-009Btr-UZ; Mon, 31 Mar 2025 14:18:51 +0200
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
Subject: [PATCH v2 2/3] fs/proc: Pass 'task->full_name' via 'proc_task_name()'
Date: Mon, 31 Mar 2025 17:48:19 +0530
Message-Id: <20250331121820.455916-3-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250331121820.455916-1-bhupesh@igalia.com>
References: <20250331121820.455916-1-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have the get_task_full_name() implementation which allows
the dynamically allocated and filled in task's full name to be passed
to interested users, use it in proc_task_name() by default for
task names so that user-land can see them through appropriate tools
(such as 'ps').

Signed-off-by: Bhupesh <bhupesh@igalia.com>
---
 fs/proc/array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..2cbeb1584f8a 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	else if (p->flags & PF_KTHREAD)
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
-		get_task_comm(tcomm, p);
+		get_task_full_name(tcomm, sizeof(tcomm), p);
 
 	if (escape)
 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
-- 
2.38.1


