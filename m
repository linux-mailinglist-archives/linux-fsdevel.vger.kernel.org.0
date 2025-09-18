Return-Path: <linux-fsdevel+bounces-62101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA72B83FEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5485A4A7BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F82302158;
	Thu, 18 Sep 2025 10:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFFBIQsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335528643F;
	Thu, 18 Sep 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190353; cv=none; b=jbDVuZP6kNLIBLSjkdlgpDse1Jglnma1VhMZYJMP7fve+hJBbgMFJE+D0HcWXqpYaSU5cFA4lWP7u+pPnHr8gfCiCK/xf+JxzWLtIhuN8UjlkZxSig0R9SVNTAeZdF724qac7r0f3XFrFmuSXyuakbx6nodJwKBXF5G5wrtAbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190353; c=relaxed/simple;
	bh=JQj+hKUFm8QJxn9wbCfJ1lqCGI1ADoO5H9i3MIyjzas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XolWt3nXH/GJ6zuvIBy3JEELvuWEdhK4x5vLUA0k0XL7tv8FvD/iyKbBPdJMlWi/IhK/4AVI0jFDysTfghn78vv5/LCs9pCIHjkxDSG++BJ/o1FZqEcxFH45WfscFf88dw5KB3JE6CifUkklybro+H3M0P7qsaz+s78lNHVKl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFFBIQsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE5DC4CEF0;
	Thu, 18 Sep 2025 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190352;
	bh=JQj+hKUFm8QJxn9wbCfJ1lqCGI1ADoO5H9i3MIyjzas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mFFBIQsKlKP2ldt3wifPwejDmvkJh2rAdLxHuSR4r110O9y++g6G3uuyreE5ttmOO
	 x6hBSn2A4X5qcTv3ZFHy7hDHJYfe3eDsB0l/gzBTxIBdtixSjMIPTSbrH9iyhRovUq
	 YCZL+xTWlx1giEvp4ziYos0tN8X27LUlxkhpJpDCuq/7AoT2nl0VsBX084x0xPvGcc
	 3oNE182z5C8WR951txiGuuB/Z/gizbLtHtj+CS2reC04pEyrTipmKPFf440Hp0OVIh
	 x2Fac2XflAAT3Sf6mJGVvo7bjyzbiivczxUlz/hDP2SOTl0LoE9Wm6tZcni6n5sQfu
	 xKlREslXiQc8A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:53 +0200
Subject: [PATCH 08/14] net-sysfs: use check_net()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-8-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JQj+hKUFm8QJxn9wbCfJ1lqCGI1ADoO5H9i3MIyjzas=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXMdrrzK4VDX09wXDnabSld+U2MyfqnxZpeXe2X9
 76qZ5cYdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk5guG/3HZVofT4iNezC5t
 qTpQtMn0sFPTQ58f5VxzJzTbebi/v8/wP0b13VTLTcoy3RrtF3yXrgg9scW8R+Z++3Ot4ANvKt0
 kGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't directly acess the namespace count. There's even a dedicated
helper for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c28cd6665444..3c2dc4c5e683 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1328,7 +1328,7 @@ net_rx_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 		struct netdev_rx_queue *queue = &dev->_rx[i];
 		struct kobject *kobj = &queue->kobj;
 
-		if (!refcount_read(&dev_net(dev)->ns.count))
+		if (!check_net(dev_net(dev)))
 			kobj->uevent_suppress = 1;
 		if (dev->sysfs_rx_queue_group)
 			sysfs_remove_group(kobj, dev->sysfs_rx_queue_group);
@@ -2061,7 +2061,7 @@ netdev_queue_update_kobjects(struct net_device *dev, int old_num, int new_num)
 	while (--i >= new_num) {
 		struct netdev_queue *queue = dev->_tx + i;
 
-		if (!refcount_read(&dev_net(dev)->ns.count))
+		if (!check_net(dev_net(dev)))
 			queue->kobj.uevent_suppress = 1;
 
 		if (netdev_uses_bql(dev))
@@ -2315,7 +2315,7 @@ void netdev_unregister_kobject(struct net_device *ndev)
 {
 	struct device *dev = &ndev->dev;
 
-	if (!refcount_read(&dev_net(ndev)->ns.count))
+	if (!check_net(dev_net(ndev)))
 		dev_set_uevent_suppress(dev, 1);
 
 	kobject_get(&dev->kobj);

-- 
2.47.3


