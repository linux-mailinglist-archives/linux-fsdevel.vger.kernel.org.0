Return-Path: <linux-fsdevel+bounces-53272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF96AED2A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D683B5342
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693220F078;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oHI0gsVK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0C1BD9CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=LSLXnQoTdpQPz441WJxpGmEs/pcEg6RI8rcKLODouu3uxVA1mGz/Z4iITuDNDXzU4Gc3SlRojLxY8I2EsT9gQvQhJ2Z2Sue2fQcPi9Oectx7XL/W6njsPX3p0jzUQ1MCODQypSKIVn7sJJAfpwwH4LrQMrcE6vzAEC/6J8RTLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=acMiXAbfDV6Vx8p9ZW2ER7WK1PPWhldHvQ5slZ+NdRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMrbQVW8rLOYGlewzdFN7zc67voDlctOzL4DM4pGxlEZ+WzngA7CeozvejSrqw5ope/0WF3m/gdwVF97VU5zQN1oLhqppKba543TM8oAF+yY5CB8YLMyaashwZNHgVV13VUG11iyJct6TCeYnTro2uFV0KTyGx4vjk9gPtsySus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oHI0gsVK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LU1iXp3zkz6A3IrKsbdgDUgXiD0MJbpYKi6PB/SWvfI=; b=oHI0gsVKTxOrrfvok0X1VE+DG1
	Nc1ZNC8GWUOVm3td48Ufv1+qerN7WoHEqGf+O0l1cGCxKHIiqVKrSW862WBso9jclXxSXErwA1fmK
	SR0BZZD9/cyF9rY3gsCAUEMVc5ddiiNzcF12/GWTxqQt7pFkSCqlufRL4133QxPupPsz/RCjOipXn
	vLdM5bjjX20H4yMP5E7QUxIPjlOGmNbrw3DqRMkrNupp3AEhSBu9gqMcTwmknWySavZUc7Vdw1DI7
	dTkWLai6w58ovbx2GZh/wwTIYTZ2S9efLlrnyODTxrMcXO2BBQYIW8irZkfR7Mxh38J12ejKQfmnS
	biilkdgg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4de-00000005p1U-361v;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 32/48] propagate_one(): separate the "do we need secondary here?" logics
Date: Mon, 30 Jun 2025 03:52:39 +0100
Message-ID: <20250630025255.1387419-32-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

take the checks into separate helper - need_secondary(mount, mountpoint).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index f55295e26217..7c832f98595c 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -218,19 +218,24 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 static struct mount *last_dest, *first_source, *last_source;
 static struct hlist_head *list;
 
-static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
+static bool need_secondary(struct mount *m, struct mountpoint *dest_mp)
 {
-	struct mount *child;
-	int type;
 	/* skip ones added by this propagate_mnt() */
 	if (IS_MNT_NEW(m))
-		return 0;
+		return false;
 	/* skip if mountpoint isn't visible in m */
 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
-		return 0;
+		return false;
 	/* skip if m is in the anon_ns */
 	if (is_anon_ns(m->mnt_ns))
-		return 0;
+		return false;
+	return true;
+}
+
+static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
+{
+	struct mount *child;
+	int type;
 
 	if (peers(m, last_dest)) {
 		type = CL_MAKE_SHARED;
@@ -313,11 +318,12 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 			n = m;
 		}
 		do {
+			if (!need_secondary(n, dest_mp))
+				continue;
 			err = propagate_one(n, dest_mp);
 			if (err)
 				break;
-			n = next_peer(n);
-		} while (n != m);
+		} while ((n = next_peer(n)) != m);
 	}
 
 	hlist_for_each_entry(n, tree_list, mnt_hash) {
-- 
2.39.5


