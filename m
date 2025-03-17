Return-Path: <linux-fsdevel+bounces-44214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB4AA65E36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F173ABCD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF4F1EB5CC;
	Mon, 17 Mar 2025 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbTltoax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25EF9DA;
	Mon, 17 Mar 2025 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240464; cv=none; b=abnf/nFcVp0CIXXwU+av5c/7Pu4CoTykjG/N2k7D4ssd3y/N5MdKYim9mxtmi4RbFtGZZ1BlAVmoIVIpV7L6y3LgQ1kt4OgGIwqjWenndvwlbjh1EP9BnENDcyVay/QMb2QErwoTurczzh7oChrizSj+L4M4lL2iikt2B5afXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240464; c=relaxed/simple;
	bh=nepMoQbELtF94lH7T+rYxLvz2Qh9WuaIy9QO1v1CDrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Raas2ymqG7jnY0VdyYhpFvmR+wfZhM80zQ7IhbWW9BOSY+6hSTyHYwUKF98bkUQo0ySflMh+Ji8Axo7NAon0pxFgFLX8nKBRuWHXfPBDOHUSGminTh5M3c+BQ/NeJZ82WGXWkksARr1Vc0Qwe2It3I5/XYoBaEZaftne86AU+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbTltoax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9354BC4CEE3;
	Mon, 17 Mar 2025 19:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240463;
	bh=nepMoQbELtF94lH7T+rYxLvz2Qh9WuaIy9QO1v1CDrQ=;
	h=From:Date:Subject:To:Cc:From;
	b=mbTltoaxCF/20PAdD+F5yABlHph1lzXaz3O8SIAtJDVpLYCJUUwplaXwvnAira745
	 Z0jhDlvde0qpxsKqfK4ST5Jo/WJyATcgnpLiry31xd4MfqP1tva71KB3hG+Qnc8GKc
	 kyuBIZAXGOHwm/7cVO8dvx1ZY0AEETopY8TtXOypPphrgz7/9AFdmnxfySATBEGUkN
	 ZETP10ZSfHEEboaPHrzSu/O9/ndzQzb5ITCHx1Kzs66ghOS3pStZuqRyM/JX8fNZWd
	 Xcrr+UONCJhBPvzO0ZrByEqgBQ4lsqOko8vNUBbPh8QacFsxbMSaDCkdj+R3OVdghG
	 raY1k7srXseGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877E4C282EC;
	Mon, 17 Mar 2025 19:41:03 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 17 Mar 2025 20:40:04 +0100
Subject: [PATCH v2] drop_caches: Allow re-enabling message after disabling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-jag-drop_caches_msg-v2-1-e22d9a6a3038@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJN62GcC/32NWQrCMBRFt1Let5FmKBW/3IeUkqQvg0NSXqQop
 Xs3dgF+ngP33BUKUsQC52YFwiWWmFMFcWjABp08sjhVBtGKrpVcspv2bKI8j1bbgGV8Fs+scsb
 hZDruJNTlTOjie69eh8ohllemz36y8J/931s448wKVNifemV6cbkjJXwcM3kYtm37Aq8QtE63A
 AAA
X-Change-ID: 20250313-jag-drop_caches_msg-c4fbfedb51f3
To: Jonathan Corbet <corbet@lwn.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Ruiwu Chen <rwchen404@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=nepMoQbELtF94lH7T+rYxLvz2Qh9WuaIy9QO1v1CDrQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfYerHFV+3h8K+5MCKKabYyQ8sg92A8cm7yh
 koRx26w9cfa1okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn2HqxAAoJELqXzVK3
 lkFPntoL/RNNBaAKCSj2xAgD7QJjEvjW4CWP0y8gRIjAJ4yTFX5L7PrDAsvjalhDJSUgvZYv+lh
 KusABjpK8ywfgLCrYxEPqgh8WaPxaeAJSHIfcb0MIKMIxFHrtsjP9EdSn3uSqa/11M9ESSBu1Km
 uTU2wLN4MO1fLE4G6wfjvOHu7KDS9y1RKnDqnsX+Ox7sXjjKyQhxrUmWCbII5VI3MwQ8tI2OmRh
 +lgHPk/4SVf8JAi0uZc2dyLDAWE4chvfoFOOJ3MadcGNSlNRlPKVFX6PIjtndgIo5OAz4tRqTbS
 lF8dWG15fFl/n3HuHvnSszCSRxhU5FEcTGhZHVrzNFUk/KjsUYGIXlg5y5yFGSrYZFn6dpHr/ef
 JnM07cKKHzlJ8pONnmEfv5x8xLCfr3r25QMZNS5gsD57rK9jDobm8IwSa7+UZKOD39hGVLEXmix
 Qq8Aiifpp+tfY80UETeY3BUzBT2I7jdW3XxA1+kEiY9186qg5/gFomLYq9OFtvKvihwFq4GdoB7
 Pw=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

After writing "4" to /proc/sys/vm/drop_caches there was no way to
re-enable the drop_caches kernel message. By replacing the "or"
assignment for the stfu variable, it is now possible to toggle the
message on and off by setting the 4th bit in /proc/sys/vm/drop_caches.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Changes in v2:
- Check the 4 bit before we actualy toggle the message
- Link to v1: https://lore.kernel.org/r/20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org
---

---
 Documentation/admin-guide/sysctl/vm.rst | 2 +-
 fs/drop_caches.c                        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f48eaa98d22d2b575f6e913f437b0d548daac3e6..75a032f8cbfb4e05f04610cca219d154bd852789 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -266,7 +266,7 @@ used::
 	cat (1234): drop_caches: 3
 
 These are informational only.  They do not mean that anything is wrong
-with your system.  To disable them, echo 4 (bit 2) into drop_caches.
+with your system.  To toggle them, echo 4 (bit 2) into drop_caches.
 
 enable_soft_offline
 ===================
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d45ef541d848a73cbd19205e0111c2cab3b73617..15730593ae39955ae7ae93aec17546fc96f89dce 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -68,12 +68,13 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 			drop_slab();
 			count_vm_event(DROP_SLAB);
 		}
+		if (sysctl_drop_caches & 4)
+			stfu ^= 1;
 		if (!stfu) {
 			pr_info("%s (%d): drop_caches: %d\n",
 				current->comm, task_pid_nr(current),
 				sysctl_drop_caches);
 		}
-		stfu |= sysctl_drop_caches & 4;
 	}
 	return 0;
 }

---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250313-jag-drop_caches_msg-c4fbfedb51f3

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



