Return-Path: <linux-fsdevel+bounces-51543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF4AD8144
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 04:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F9B1898F79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B48242D9C;
	Fri, 13 Jun 2025 02:52:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973C18A6AD;
	Fri, 13 Jun 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749783158; cv=none; b=QHR3l3CftiSNdHbQFZsavZ7Jc4/oaTtyz/Z2qxM46ixbLEXwdLDaMgvcZRGDAoWKMNPIecQzdJiKyikos3aviA5NBOcN23aLvQ7nN0FNeVUDtgcZncIOSK7tcQqjIi6XQN+MF/E0Xu7cKDRfoFIWeHtsmMVqWpIHi3y2eUlZ0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749783158; c=relaxed/simple;
	bh=QyazcMeLFCkjCNo07nRBEmSyIRcBs2tA3az6DgTS+js=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=V0E0MPIfD4yjEg4PpzB1FIlEvFy2fqXaHANRNYDTIl3pi66FMX50WaRxzJeYrpGsUK1xeV9gGsVNnRn4pWrJfcQ6xprsDoMLjGJC0bT5efhRSWa2pkOT8EzWLqaBQvquF/UTWn+IX9xRopuIrT3Rub0Ph+hLoyBs7Q1kS+3gjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPuWv-009nYt-2o;
	Fri, 13 Jun 2025 02:52:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>,
 Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] proc_sysctl: remove RCU annotations for accessing ->sysctl
Date: Fri, 13 Jun 2025 12:52:32 +1000
Message-id: <174978315268.608730.1330012617868311392@noble.neil.brown.name>


The ->sysctl field of a procfs inode is only set when the inode is
created, and when it is being evicted.  In both these cases there cannot
be concurrent accesses and so using RCU_INIT_POINTER() and
rcu_dereference() is misleading.

I discovered this with some devel code which called d_same_name()
without holding the rcu_read_lock() - rcu_dereference() triggered a
warning.  In mainline ->d_compare is called from d_alloc_parallel()
without rcu_read_lock() after taking ->d_lock.  It is conceivable that
the d_inode will have been set while waiting for that lock so mainline
could trigger the same warning.

This patch removes those accessor call.  Note that the sysctl field is
not marked __rcu so sparse complains too.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/proc/inode.c       | 2 +-
 fs/proc/proc_sysctl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740f76..c3991dd314d9 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -42,7 +42,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	head = ei->sysctl;
 	if (head) {
-		RCU_INIT_POINTER(ei->sysctl, NULL);
+		ei->sysctl = NULL;
 		proc_sys_evict_inode(inode, head);
 	}
 }
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..976d7605560f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -928,7 +928,7 @@ static int proc_sys_compare(const struct dentry *dentry,
 		return 1;
 	if (memcmp(name->name, str, len))
 		return 1;
-	head = rcu_dereference(PROC_I(inode)->sysctl);
+	head = PROC_I(inode)->sysctl;
 	return !head || !sysctl_is_seen(head);
 }
 
-- 
2.49.0


