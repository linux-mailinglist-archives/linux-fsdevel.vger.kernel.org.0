Return-Path: <linux-fsdevel+bounces-60046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24FBB413BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E00568135E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD932D5A13;
	Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mQqCcuFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB612D4819
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875342; cv=none; b=PLBodI3/hTXR+iNh3JvcOQkYPOnGDHv3Voc2/4hMmK2nu5gr3VowaT4409HGdJIqBn/Z+E3vagqt3VYy19iZ+1UNWt7SDH4u5HQlUsCCPMN8cU8q/MmXEx5D911Y23rv6YwOJ4EIh8J4PKXz2rraVC9BGMBg4xQhJZCPvBy2YBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875342; c=relaxed/simple;
	bh=wtiz5sYiRIpV2t78CxESQk/t46wMenUuUXR2UcLm+gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbQs5MNRVAK2kDhYPOBPDkBWoQmiM3ZI4zWUnxTvRZJsgX7Zurc8JKfYdLTtkJdFKHA1vkDgQv/sN6Il511zoO6CpUO1qChDgNu1ku9QBGGmIZz6BFCbgqK6HgoMoIDYMVOQbT1H3i3oaSsTBHmXigVBsjQmZxmCGEvN5H7crt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mQqCcuFZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/fWPqZ4ywFKv8vjhSdG5KA+GDOrGz640JabM2QX/h38=; b=mQqCcuFZbA+Lpz/3eVNlzZq3ZL
	qdAaAVygF8AYM1KNDZxL6Udi3CARx53ajTtAX1A/GmzCSuQpw+8TSDK8RxD0Ti2JFonuEKx7EinXS
	Zt/UKmZYQxWy/FmK7WXrCgvFN26X5CvTvoZ5HIhbX6DGo3cw/XmHEaxgAR5CvJmEAl6aM2SoXVNg1
	ClPXBVE01eGkZ427e1pNWdOUcoGFDZKZHckvvSPzibUdLhybEBPTI0Z6qnlYeQAffUbaPPUNZ+ZCu
	LzBGpmolMEjSu+cPykJOYkpo+byQYGHiKrZYZ8y/0WIVTMnwqBtmjTYsRgcuvdVhldKnjFan27maJ
	cQwX5tbg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX1-0000000Ap5m-0fPk;
	Wed, 03 Sep 2025 04:55:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 04/65] __detach_mounts(): use guards
Date: Wed,  3 Sep 2025 05:54:25 +0100
Message-ID: <20250903045537.2579614-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Clean fit for guards use; guards can't be weaker due to umount_tree() calls.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 767ab751ee2a..1ae1ab8815c9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2032,10 +2032,11 @@ void __detach_mounts(struct dentry *dentry)
 	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
+
 	if (!lookup_mountpoint(dentry, &mp))
-		goto out_unlock;
+		return;
 
 	event++;
 	while (mp.node.next) {
@@ -2047,9 +2048,6 @@ void __detach_mounts(struct dentry *dentry)
 		else umount_tree(mnt, UMOUNT_CONNECTED);
 	}
 	unpin_mountpoint(&mp);
-out_unlock:
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 /*
-- 
2.47.2


