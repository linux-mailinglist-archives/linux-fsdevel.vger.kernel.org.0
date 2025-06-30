Return-Path: <linux-fsdevel+bounces-53245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E326AED28C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BF916D167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C21AC88B;
	Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bQLL6Ehi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC717A305
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251979; cv=none; b=ohKrZWxP58lYC7nfVjsf9GrOha48r0imuXTjy0HvCEO85HxPK34IV62FkvgStgtMxa7WNnL94OHbiq09W2dXPI+qQs18BEPZhdYL7HUimCZ5jhCqUsErvvL88Difh378Xzor204akH/R+16oL+qAQ7COJLsWSi7usUhzZt36Zac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251979; c=relaxed/simple;
	bh=fWzydlJQwIYP5NTUlOOKqIHRgF0/xazrcswlMlOv34E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfC8mkUxRCWMs4WH854lnnhbWjR3M1n1Kp7rOx/o5WQSLCFB+wIYWLPTlKAX76DYS6ZPh0p5r5hwDfv9W/XDHVLOKCOUZ87/WpHOPYjiBZp4XTzj9SFuq5XkKJPnmY8KiTQV2kOidGzGIv6uf+wD/o2RedSG19ln5uXN3AjU8E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bQLL6Ehi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fb34o0sKkaf+nETHAlYSCf5rYWqYBEsdEL/2U8pfKlc=; b=bQLL6EhibL3HQXbUIUse22ykha
	W//wZu5+BPdMa/ykJeYfpNG0e2/n6jFUuT7GzTu3vLlnHxtK9BnIlkd5go2+JmBFTZ7dDTBONKUvL
	f6+OP1rde6O65xciU6BATGCocHWv0FuXm2uRfwnPAnYARZddKVaD5MpF2gki9OwOBdyPGbcREp+5Y
	9Dnq44OXHlOLVB/t+dYVbl9WfgK7kballVA9oEG3YrrtZkmY4VrFBEwTj3nhAuHqDCAI5rWknOjVd
	e4xv/Jye8Nfv/cQ3ZlmoFs/qCouazpKieBUgFGyErZlojHnJdmHY6hO/cOVt20XKq9KrSHpHY0b47
	H5uwRfJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4db-00000005owC-3yos;
	Mon, 30 Jun 2025 02:52:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 05/48] constify mnt_has_parent()
Date: Mon, 30 Jun 2025 03:52:12 +0100
Message-ID: <20250630025255.1387419-5-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index b8beafdd6d24..c4d417cd7953 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -102,7 +102,7 @@ static inline struct mount *real_mount(struct vfsmount *mnt)
 	return container_of(mnt, struct mount, mnt);
 }
 
-static inline int mnt_has_parent(struct mount *mnt)
+static inline int mnt_has_parent(const struct mount *mnt)
 {
 	return mnt != mnt->mnt_parent;
 }
-- 
2.39.5


