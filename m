Return-Path: <linux-fsdevel+bounces-59539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1612B3ADFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370B11C27F0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657632DF6F4;
	Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o9i6qn6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4232D0C72
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=k/WGXtjZYA6UT3lJd3HJHIF0v/gx+NCxANWBIkcZUIWc6qYEzH8BYL6l3mIOdFI3fo0uRU/7GztCeU9fe1CGWEnE5lmKyiYkT84yZTYldzPOAH2kUrPPhxXSOpSkVekhvYLJuCFXyvv7FFspfUkRRJqiwHkp9M5AKQXxPO2Ei6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=QkfkXtUoBI4VJpRGk6gUgrCv+C0f5lfycPQB5D36or8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbHsY8GGkOj3Lstvi4XxT9D8Twyz1FQc7mp8fY/LYBATHBxWnD5uXoarW+IxLpAHfDClu4nHaAokQwMNB8SDUJbm2EyqrehWuaiG8NqO5thh5iQGFmv2Vw7h/SHKQZs88gOqbELJV0Ls4/ZPmrNeBxdsyosHv+TRDPz+dQ49WLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o9i6qn6l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5D1GxuQ5k0GZaxVOYjvPH1/nQoHcqpz0jbV2p/7gZtI=; b=o9i6qn6lPlcBg0wf0xzY+KJa1p
	fB5Fc/oIFwUccGu16PU+u1mVyzImQ7mYz9rWVdVaEDbzZjC5RYnNCWRhg/K0Fa4KdeIkvA5lFkXAB
	0KXUF5T4LC4BxjNvDCYhdmk0RGOFSP6jr23NPdr49ysJuE+hJJWNXXkntUZJxw5XFatUG+V2gZFJd
	WgOn38rHQ24prdUquQmAayaTpqxJ3z8cedDiUkwc2F+xSUdDaoIoG2GeJ/qrh24KmK3NgpZfv7uNn
	IK90Q0ZTSJdxUaf5VAox4b1LBLojVSahbqkLxp+ijhrPAtBr31ZvA6c07p6dSbdRDOPyTMBppeyVz
	TdTE2NRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22L-0u5Y;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 12/63] propagate_mnt(): use scoped_guard(mount_locked_reader) for mnt_set_mountpoint()
Date: Fri, 29 Aug 2025 00:07:15 +0100
Message-ID: <20250828230806.3582485-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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
 fs/pnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 6f7d02f3fa98..0702d45d856d 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -304,9 +304,8 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 				err = PTR_ERR(this);
 				break;
 			}
-			read_seqlock_excl(&mount_lock);
-			mnt_set_mountpoint(n, dest_mp, this);
-			read_sequnlock_excl(&mount_lock);
+			scoped_guard(mount_locked_reader)
+				mnt_set_mountpoint(n, dest_mp, this);
 			if (n->mnt_master)
 				SET_MNT_MARK(n->mnt_master);
 			copy = this;
-- 
2.47.2


