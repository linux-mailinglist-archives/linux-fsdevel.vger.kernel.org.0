Return-Path: <linux-fsdevel+bounces-58942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61752B3358E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504983BFD8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267D2857C1;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DnZKlyrg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1524EAB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=QRTl5pp4GsVO4mVPt/vYWPPJOtaJlSYbhEcytnAP+9I7ArPaOuAEz/6v7G2eqD//c08N8iSzjIxqOAw5tOU5p2bm6l8xN1B2aPi+wReCuf2nVJsyZbTXZ4JrDPND4+Ja3F9UwguPCxAqhiX3Qg/de4+fc1l/JM0ulgDgJpJtPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=QxwmNoSNrNOR7xh5eAgjYktEjaxj6M4t4NMBjmsZ5FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgR/nVZyb8vPTHYzl+Rcfnq6lFbpxL97kBmbflvGf0mTzwZ6ckZ+z/edC7CAMp4ba4N1waid0zcRsvSQ0jpPTQuSV7A4JlwAeYxhFGrWg1yl94Be0j/RPQlUwYEzu7jd8oDj6M2FAWDyvycIMTqL4zjlkQzdVXBaq19K37/09vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DnZKlyrg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=37sDPRHkVgWKWgfnIlDvCGIvYmJPMRZlnS4JodtCdwA=; b=DnZKlyrgrk3V5MWRAPCuYTJ9ZN
	D85KiP4QTkQn68glHGaIhcxcKQzRwYDpHutIE9Am9+G/GRW7ORkdtbHQE2UkQzztJXkjNas93iQpp
	ZUc4AsO6VQIpCGqwaVji7OL1x6XcnW3IJXTW8o2/2hjgTaamN9NCb4Xj1JeNe5JMK5DQ8n74rsawm
	sGbb2XKItfOj6foS9aeSDroqeuSc0yfLINx4dthJKsI6oVrflxLsjDeXK+TXoUnbpFvbtx55Reb2U
	gDsIgZuSlx7v2TVILzYVXt+LHAKa2zRGYdDHH6LbVWjDB9SBidhBItajx6xNtKCOPh/Xv4eYegrEG
	w7HaavvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TEU-3z3Y;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 41/52] mnt_warn_timestamp_expiry(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:44 +0100
Message-ID: <20250825044355.1541941-41-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4704630847af..70636922310c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3231,7 +3231,8 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	touch_mnt_namespace(mnt->mnt_ns);
 }
 
-static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
+static void mnt_warn_timestamp_expiry(const struct path *mountpoint,
+				      struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
 
-- 
2.47.2


