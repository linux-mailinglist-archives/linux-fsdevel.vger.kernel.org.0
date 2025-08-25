Return-Path: <linux-fsdevel+bounces-58908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE62EB3356C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A353B540A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814B227B51A;
	Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="elzwMAuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824621CC44
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=grbnUnpYv8C6TosMhShUFVc3abiz9txUzHwc8AFbAWJULICy6WVpBuDqsyDmzIX+k/TGv0UA3ARCmRNqRJLa+F9xPXQayzntZ87CWH1rPjiVQVv24B3E3PmlNCQRjSRd0r8ul8x6+R6lqlWwHWAABwQ2Wl5U6uvPHEZyvquL8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=j8A7AkmdwfeGwcxTSC9DgCSTVdWlDAjmbt5AdpB/Ads=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z55ZNUiqVjjzWcwQ3HYddEg5eIN1+EVf3votx3Li1yP1GKEfaHGUtSfVeUdZLhDbqe4qv3Xl5AHjtMH6Tv2MnftC5kMosYAFDxF3kf7G5s167o/EB+x+wtmRw2qur54Vp8BILaiHfPzryLV4BDCxBVjuVu+nKg/ZCU/Xiyx0ZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=elzwMAuU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vbZHDLzmrN400rnkN46F3f1d36LUkiMmbscUyVwH3KM=; b=elzwMAuUPHtR+2anDWzFd/HJFW
	KZhOvZvefbF/mydZLDqAi++jmRaZlTy4CAODrjiSdhzlQtHZoFG/5jhvMQjQBjZttfEo15fLFmUfc
	gavVQ8i+WmEAeO8qZYDvWje70VoKU+IzR3McsZovHsPQ7OlqxPiyohl1NFBKDJGCgB1Cc4TzboxU2
	HBAITcIdPsswHsIpICaSFWS45Lh5zYi72EFg43piqdlUX2KnoAkPI3jpy9s5YJjMJf6T7LYKN1+Zx
	UsCkS3HFT6LO5K5312ZkYNxR2Webtr667tQkNp2CNSZdIfruozXca06xS9SKtZL+5kyYebfuOPdJY
	QvDgopwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3j-00000006T8M-3ipG;
	Mon, 25 Aug 2025 04:43:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 03/52] fs/namespace.c: allow to drop vfsmount references via __free(mntput)
Date: Mon, 25 Aug 2025 05:43:06 +0100
Message-ID: <20250825044355.1541941-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Note that just as path_put, it should never be done in scope of
namespace_sem, be it shared or exclusive.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index fcea65587ff9..767ab751ee2a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -88,6 +88,8 @@ DEFINE_LOCK_GUARD_0(namespace_excl, namespace_lock(), namespace_unlock())
 DEFINE_LOCK_GUARD_0(namespace_shared, down_read(&namespace_sem),
 				      up_read(&namespace_sem))
 
+DEFINE_FREE(mntput, struct vfsmount *, if (!IS_ERR(_T)) mntput(_T))
+
 #ifdef CONFIG_FSNOTIFY
 LIST_HEAD(notify_list); /* protected by namespace_sem */
 #endif
-- 
2.47.2


