Return-Path: <linux-fsdevel+bounces-58923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7CCB33579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAED51B21D58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1CE28135D;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XmruJn2d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C646526D4F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=nKv3nqk10h0atJ4lzRZCUaiMEpPcafc+OQAJD4Bi8zZDEZVGFBnDC+Zg8MDKoJYilNxpoQlRvJpPibjhvt1oWe0LLEUPrOlnh67QgN9BSlnlUEyUIMOrX6wHT5Dedb7csJYWvcb0rPfrMaE3yaEqPNvzYpT860LxvQfdkc8t7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=X+nJkkmn3w2ixB9SG2PCvE2dDx29x6aDRjK5MZRUiqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8j2qrHIoRpHoPDSJAcGCIY603Y3GmWkibaJ03l/XxgTocjNPdFW0CJse2SVUOboxcYSxKY+Sn6jzCm1WkelRFRwBmeKwdtu+pNXqkvh10kjt4ZlWRVwgPOQTywg4FRxWNduYitG2R3LyX5i4+uqy3QOsX2WdlEjLKgz5CbpWdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XmruJn2d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PukSsDemRJM5utEzq0Q56YyWe1EojC3ouOGTSaCYGuQ=; b=XmruJn2d5M6kL2uUEsX5XH3gno
	XdFWQv3KuCYc9Ml1z0L18QtCTs92aoU3+oj1FDv3MljgD/eJph3SdDAMqAttvF3v33xR3YKExdXKl
	d66sWWfYSzSRJWUsYbWhhhEUM8OO9I8Qi4ubcI5xJaFWTzYh0PbkB2vEQ+mgF/Wd+QznavAzZVrOx
	Y2k95s4viEyj36IlFvtHEdiJxLvr49ZSr+9Ak0Wcanga2hb+i/Tvnd1jxXl27zzkg5lBo7maIEJKA
	qQaBg2wf78oL3KHGF9/UlWqPbjiCBIK/ESONcELEUlBtxO/54kkuRHRocVpOPHIka1kBFcz49opLR
	QbpFvlNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TA6-0voo;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 14/52] mnt_set_expiry(): use guards
Date: Mon, 25 Aug 2025 05:43:17 +0100
Message-ID: <20250825044355.1541941-14-viro@zeniv.linux.org.uk>
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

The reason why it needs only mount_locked_reader is that there's no lockless
accesses of expiry lists.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index eabb0d996c6a..acacfe767a7c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3858,9 +3858,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
  */
 void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
 {
-	read_seqlock_excl(&mount_lock);
-	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
-	read_sequnlock_excl(&mount_lock);
+	scoped_guard(mount_locked_reader)
+		list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
 }
 EXPORT_SYMBOL(mnt_set_expiry);
 
-- 
2.47.2


