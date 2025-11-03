Return-Path: <linux-fsdevel+bounces-66805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B717C2CA98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BA8463999
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11831E0EB;
	Mon,  3 Nov 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JopLWCYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256823148D5;
	Mon,  3 Nov 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181870; cv=none; b=RBL9h86xH8oHcXOTDkHD/O+PPBtbYMLiAiyHSM2qtAHS2xyE8m/ts9R4V0Db938KxqElfwnil63+kWcuekauzejwqoQk5xJehDMk+7tpXsxYFSILXEfQGJ2xS0r4i2aSIt0hYAMecuQKRhEpRuDI+D29SLdQCL3DjOW6WbEDgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181870; c=relaxed/simple;
	bh=JXDW7P6E9z56BXNMj15VvrGXF4N3b0bWA60p7x5LQqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DUYuI3/E5KmzQ6ybse6gxLvHPpztuJEu15fAoae1zwh7BmCLibS2vQ9SnI//bfZ1YksPM1LSaX/0l4QOFRpHRcCSp1Lwja2Vo3xy7kIBMhbxPmXOa7w5TpZlxsJ+yW7GHMxSvd3/WavpJ3i2R95duCef5q1xrXnug6Z4ZzvbBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JopLWCYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5322C4CEE7;
	Mon,  3 Nov 2025 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181868;
	bh=JXDW7P6E9z56BXNMj15VvrGXF4N3b0bWA60p7x5LQqQ=;
	h=From:Subject:Date:To:Cc:From;
	b=JopLWCYfHSrSbznS4ihVysckhWf8JMMnvb0Hif1kKondAOJjQ7Dx9G54BJiNcd7Gk
	 posKi1BWWDrqStGY2hjE0V6DFH6kMtLNhkV4B/AAD4UYY6OyUwvS4wD35v4tNtmaiD
	 ipRNu81q3J8lI/vplWFqmt9nFmbF4qsfRvCnusKA+V1QsubpfvUPNGiTPMvXXkvJuV
	 mlkbBMGP3lw4PtpfZIRCWEQ9J6HtSx5euh/4C7ZgjXTgZ6Lu+defSs/qcl9qf614CH
	 Y3X4gKIE3YNdRZ4yRQdz0GHPX2F1rJ5vniRDrpdKKBxW5M6TFIr8pxL+ePvuJofZDw
	 tvyGE00aHeqbw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/12] credential guards: credential preparation
Date: Mon, 03 Nov 2025 15:57:26 +0100
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbCCGkC/yWN3QqDMAyFX0VyvZa2wwl7lTGk1qhhWy0J+wHx3
 Rf1KnzncL4sIMiEAtdqAcYPCc1ZwZ8qSFPMIxrqlSG4UHvvzuY788Mkxl7M+I6spzCWyNgeoXc
 emzqEy9A4UIu2A/32D7e7chcFTccxp2nzbjq7L+2hs0Kv8kRY1z94xaNanAAAAA==
X-Change-ID: 20251103-work-creds-guards-prepare_creds-101e75226f70
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JXDW7P6E9z56BXNMj15VvrGXF4N3b0bWA60p7x5LQqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrxnWHFbIufseyLvsUV3/KtOvVs2ZUXuhP130w9/
 OjalYgl0R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATec/KyHCk5pabi6vlwvDm
 zWt6LZ5XsX/bt7b9z+eMy6su+d3YGf2IkWH/e4HWO9eVNx054XPncMgJvXWqtV6zU2Sn7oiMFP+
 9S4sVAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This converts most users combining

* prepare_creds()
* modify new creds
* override_creds()
* revert_creds()
* put_cred()

to rely on credentials guards.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (12):
      cred: add prepare credential guard
      sev-dev: use guard for path
      sev-dev: use prepare credential guard
      sev-dev: use override credential guards
      coredump: move revert_cred() before coredump_cleanup()
      coredump: pass struct linux_binfmt as const
      coredump: mark struct mm_struct as const
      coredump: split out do_coredump() from vfs_coredump()
      coredump: use prepare credential guard
      coredump: use override credential guard
      trace: use prepare credential guard
      trace: use override credential guard

 drivers/crypto/ccp/sev-dev.c     |  15 ++---
 fs/coredump.c                    | 142 +++++++++++++++++++--------------------
 include/linux/cred.h             |   5 ++
 include/linux/sched/coredump.h   |   2 +-
 kernel/trace/trace_events_user.c |  15 ++---
 5 files changed, 86 insertions(+), 93 deletions(-)
---
base-commit: bcbcea89c608394efecb35237fa9fc1bf5f349d1
change-id: 20251103-work-creds-guards-prepare_creds-101e75226f70


