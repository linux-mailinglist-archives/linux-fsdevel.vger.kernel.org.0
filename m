Return-Path: <linux-fsdevel+bounces-42191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BD2A3E78D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE047AA74F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 22:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCF72641D2;
	Thu, 20 Feb 2025 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="b2ZveHsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECE1E9B35;
	Thu, 20 Feb 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090834; cv=none; b=g1GLWMSyHFvE6tO7LoghfPL8zPLNEb+wNH2rs+8RcuITdMAeF9EvGoBBjni82sSi8BeR5bC4VQBnIFK+XxLbhHY1oEvMgpBSGP0FuDyePX8Eo7HmqdlzK+mhU3A59I7BMG8wal7VqXtfcomG1JJQCCzsj7DkeR2KGEj5UYnittk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090834; c=relaxed/simple;
	bh=DvLHefPGygISdIDdgY3EAjfcWF0UwZ2BfcmO+M+joUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m3BMbv0vcS8pYnEKdBmh7g/+tBi8JC8rmQ/uE/6p+jD2q7I4aVKL5bg8qFIJES2PEVRHXHsftPjaj+69+Kb34HfB+/Qh8UTxUUe0V5Au/+6uyJslbjGunrDgviYbcWlimpbG99md+m6VmMdxSpcpFFNX87T0/7A+VhMG1Zg/IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=b2ZveHsw; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YzSj83160z9t1x;
	Thu, 20 Feb 2025 23:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740090828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cs2QcMxc9HmP1wP9jsoByrpuBq251Ur+3jOa5WgsIcg=;
	b=b2ZveHsw1VmTKeXNHnwuHtoxdPwc1kEewmiR26oLnNTuSGXHnD13obbSxmmu/tOC+5Zxeq
	ZWbrtUGhsP766UUS5aqL7mUkH39GwAbOY1U16KzulyFAL0tXjJ7gHRIOKG++U4KIoTRGmH
	Bbqp5ka3AAGZGU25owVeSsnGRKwRjwNkHSU0pz4yR9aAB2OcUYjMKXxQoZ6xzN/tBHYjae
	+PmLzCpwXV71h3bMONAmbyNSq7tMExXXLCqWOElDFL0LDzEgJHvJJLfOk8F4G7NF1H7YoB
	ZuycmfyhlQ4RYbpqb0J8cWjvgs3D6KYyrf7LXNt0nML5M5vEkE/oawf11sXNMQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 20 Feb 2025 17:33:44 -0500
Subject: [PATCH] procfs: use str_yes_no() to remove hardcoded "yes" and
 "no".
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-proc_yes_or_no-v1-1-508338f63b03@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAMett2cC/x3MQQqAIBBA0avErBNsyIquEiFmU81GY4QopLsnL
 d/i/wyJhCnBWGUQujhxDAVNXYE/XNhJ8VoMqNFoRK1Oid4+lGwUG6IafGt645a+Iw8lOoU2vv/
 hNL/vB3uJ1uBgAAAA
X-Change-ID: 20250220-proc_yes_or_no-8c4575ab76ec
To: xu xin <xu.xin16@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=DvLHefPGygISdIDdgY3EAjfcWF0UwZ2BfcmO+M+joUw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBHOWZlOUxwOHFhUEI5cmJYNzM4OElLeHYwci9CY3Q4CnRWZXNCck5YY3N6ZmVUL3lS
 NTV0UnlrTGd4Z1hnNnlZSXN2L0hPVzBoNW96RkhiK2RXbUNtY1BLQkRLRWdZdFQKQUNaUzRjL3d
 6NzZYKzRpMFVKeDkxc0YzUFYrK0p6cHQraWl3dzJJT3ozclB1cHVuMkJZbi9HTDRYOTBYdnQyMA
 p6T2ZhUk9jWSs1a2RKMElYcVdkdnZNZFY5ZS9VejVUNWh2dnFHQUEvbTFIago9U0FHdQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Remove hard-coded strings by using the str_yes_no() helper function
provided by <linux/string_choices.h>.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 fs/proc/base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322440f35ed75187416f4b247b07f96..f28acc5d5ec8b1248dfb95cf4e2e50fcb83a5ebf 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -60,6 +60,7 @@
 #include <linux/file.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
 #include <linux/mnt_namespace.h>
@@ -3280,14 +3281,14 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		seq_printf(m, "ksm_merge_any: %s\n",
-				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
+				str_yes_no(test_bit(MMF_VM_MERGE_ANY, &mm->flags)));
 		ret = mmap_read_lock_killable(mm);
 		if (ret) {
 			mmput(mm);
 			return ret;
 		}
 		seq_printf(m, "ksm_mergeable: %s\n",
-				ksm_process_mergeable(mm) ? "yes" : "no");
+				str_yes_no(ksm_process_mergeable(mm)));
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}

---
base-commit: 27eddbf3449026a73d6ed52d55b192bfcf526a03
change-id: 20250220-proc_yes_or_no-8c4575ab76ec

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


