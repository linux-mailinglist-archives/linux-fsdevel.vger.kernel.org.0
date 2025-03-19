Return-Path: <linux-fsdevel+bounces-44481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAAA69A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 22:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92FBC1889000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F522153C1;
	Wed, 19 Mar 2025 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pfvamp/W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19920C486;
	Wed, 19 Mar 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418180; cv=none; b=nZTq/ZUDiV+H3ASwe7CvTkutEXgQedsUPk1H1I2bTZLOWY2sPTVVl3P+suFuX4oaMCpSTZEyW4qKPdsV3P8f+VZ9zYRSFgHAmFEhcuQ7M1+9xqs+ZO/WDa6BoUz2/sMnucKEYqgzrT6tbJBxzpK9JZQv9aO04IelNgHBD+KufYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418180; c=relaxed/simple;
	bh=dx7tlvghTcJhLnBSdnaZMBrYE6gjJYGb9EsX+/YbT/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r4SAugQXVY4+1zh0yayPaAl22KiqspOjBYlqnJYp4U7LkioacDHY67nFPZV/J+F8ip/BUr/kQjG2f2TEGt+NnVU7/jRqiEb563xP7UmPn9beXoVnOkj/33im0j522NVNIbW6eefICz9DqESqiLU2yFfa+5NvY3BxV31GJSPuJmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pfvamp/W; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZJ1Pm4NmXzm0ytn;
	Wed, 19 Mar 2025 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1742418171; x=1745010172; bh=bQ1Ip1777rTlFl1JG8PuYCxAfZHL5Vi4WTk
	fQkKfvqg=; b=pfvamp/Wps502PoftgBPeERSCNPebX1fdxHLV2i0ZEolY3aeLA+
	kDelbN/qMoa3woDn9+GT9TT2LHqizTg+/0qcMCMJex7Wxev9/ZZbcLyocbnUjz/1
	OZQqlnCbaK01M1gJtXsxMmqgBDiGdLjIOnlbPY9M3ZodYUBiR907voogPgCypGnq
	UyFPJa36U+PKb/bdFTsZoGpBOJ5LH3DQNZDEnqgq+fNxfMRhOVI9mDaixsWixibI
	BDxn0rwOaG7VOnVjF1a2qhbtf1KYqzIabVGEi+7SAHkcTX0zPwdtRQDPI9cLkLLH
	0SduqnrAjeHgUO/4wzXdxPTpsS1TkpcrqNg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lF0TWzNn3H2l; Wed, 19 Mar 2025 21:02:51 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZJ1Pg1lz4zm0XCB;
	Wed, 19 Mar 2025 21:02:46 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/procfs: Fix the comment above proc_pid_wchan()
Date: Wed, 19 Mar 2025 14:02:22 -0700
Message-ID: <20250319210222.1518771-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

proc_pid_wchan() used to report kernel addresses to user space but that
is no longer the case today. Bring the comment above proc_pid_wchan()
in sync with the implementation.

Cc: Kees Cook <kees@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Fixes: b2f73922d119 ("fs/proc, core/debug: Don't expose absolute kernel a=
ddresses via wchan")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..7feb8f41aa25 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -416,7 +416,7 @@ static const struct file_operations proc_pid_cmdline_=
ops =3D {
 #ifdef CONFIG_KALLSYMS
 /*
  * Provides a wchan file via kallsyms in a proper one-value-per-file for=
mat.
- * Returns the resolved symbol.  If that fails, simply return the addres=
s.
+ * Returns the resolved symbol to user space.
  */
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)

