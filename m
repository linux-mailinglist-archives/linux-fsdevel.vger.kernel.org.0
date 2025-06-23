Return-Path: <linux-fsdevel+bounces-52456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F2AE347E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC513B00F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E81EDA02;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j9K9EPET"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0981DB366
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654475; cv=none; b=JGbWZ6uDVatZ80b1j6a7ZfuJj3EAtw2r/ZyWbK5rcv9XGkrK00C0QbBC4qFndPwAWFn5fuV2MPhyroboNdazyMCH+eeTSFDrAMZw7blnGCt2apnx5awXbhZsuYQ8ImLulHeSLqLqKsrqeRVbilrO4qL7+QectaLa/hepeA4G+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654475; c=relaxed/simple;
	bh=xGT3m10MN1vG9qqMbdB5+0iuOi6ae2XwjTyXgWX5j10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWTA52+1eDWzVVbDwEFH3eG30X2wzzrYJE9hqI3wLXAImfUidy8P8Nj5jMBLA0cJ/KaQMTFAO0OD++ujmFMhgQs2eXOpU+5XzRwQ56SaUT3MWECOtQvlG2H4pRO5zC1J5qH7mI38+dluRbf17MT6HRD/H8JDcuD7V1BUUR7J4es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j9K9EPET; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V7cPxOVE3WMHCTTGpADmZuDhPI8sFAW1085MTUmn8vU=; b=j9K9EPET+QcLXluvkQc8nbE6q/
	onw9IfTx9ujKyXYNosuZoyfjdKO5iFTre5MoLt7uGWzLuazKJZnj3DUsaJpAEQF73Ls+WEAan2ukl
	RVv1y3vT9IaPqRyfcPanhdjy/duspt15yLkDvX4A7ynUrlcCHk+Bqt+f2OGpf6u+Zo+7CXnBFSlLE
	OPYC7SfVd119FvbibL1F9E0nNTmsAyEuts18C7n5fdSbd7D6fKG1YlwpVtYiO+SUsYqt8vsp8ST/d
	OwuX2jkhhWEIq5GRw5vi6z7OMW+2MfDWlxaa6gMuYPPpzx4rEJZh+EMWhFwOiv/cV1lM2H0sLqSCj
	IIk2KzqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCS-00000005Ksp-03hq;
	Mon, 23 Jun 2025 04:54:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 25/35] attach_recursive_mnt(): remove from expiry list on move
Date: Mon, 23 Jun 2025 05:54:18 +0100
Message-ID: <20250623045428.1271612-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... rather than doing that in do_move_mount().  That's the main
obstacle to moving the protection of ->mnt_expire from namespace_sem
to mount_lock (spinlock-only), which would simplify several failure
exits.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b6f2172aa5e1..c4aba4e096ae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2684,6 +2684,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	if (moving) {
 		umount_mnt(source_mnt);
 		mnt_notify_add(source_mnt);
+		/* if the mount is moved, it should no longer be expired
+		 * automatically */
+		list_del_init(&source_mnt->mnt_expire);
 	} else {
 		if (source_mnt->mnt_ns) {
 			LIST_HEAD(head);
@@ -3674,12 +3677,6 @@ static int do_move_mount(struct path *old_path,
 		goto out;
 
 	err = attach_recursive_mnt(old, p, mp);
-	if (err)
-		goto out;
-
-	/* if the mount is moved, it should no longer be expire
-	 * automatically */
-	list_del_init(&old->mnt_expire);
 out:
 	unlock_mount(mp);
 	if (!err) {
-- 
2.39.5


