Return-Path: <linux-fsdevel+bounces-59552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA6B3AE0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4691E583A7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96152F0C66;
	Thu, 28 Aug 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YAaokt6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBC2D640D
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=bbHHPecJ5YgfS/v2Wo5NHJ5vUDgZpBVkHSiU4u/eNu35pCtT3UPUm5gRcpzfmbhALtssSPqxlCfH7gbI9DKygy4u261xDiyFcb+sR9kTK9xbwu9dIaGV0oin1SKhN9CTbdAdSwSSk0ba2VXy6IhP5/KcSDcpf/fQRfHCWK+INDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=2JGfG5Z4d8Vr50575XPQ4vBsSQIRKYdtWxDj1+A4K4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imu2a67LMZTN9ea8SRVWel3nYfKistfxZAbrSlEzh4SzoEAIC/BeA0hzcTDZ2/IOG9+0ZeRmQ8o1m45JPWMhhcDIUb+bS4ZL5oT4wrQx8tWeL8993xkRJeSNNWlYXxjdA1slmjbgz9PEGuIQRX0+SqaNXtHSu+SVyg4DaOkxI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YAaokt6x; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lWXAXfvmIL1JOHGlYroHu5MyhfB4+ykhxEKFJUWvdVA=; b=YAaokt6xIFSLBvJE3qsBz3KqmL
	Vu+sE8l6zvBoDbSM+ci4lUaYAieUJF2zws7gKmcrc2j3FKLIjDZ2x4F884oeYUzi2Vghu/um42t9H
	3qZVV1nhi82DWa2ob+WIeDg0oFPxjLZPPAYYMT6xRQPsp/pV3/joOKiU3q4USUxmIll6NfpkSKsBT
	tSxqhVn3GijzkVaONGpqKjZGO8jg0bAbjz0dDWbW0DizQ49VPhyfxRRbotJIeudC5Q9oEc9rSzsyn
	IXTxQomD+Lb4+wBN2UdLWeFxWH2GkAzQd3T+QsyUYrS7yGO7uOhA2n0HpM2ThJ2LjMSON3NokfffR
	4LUCyIXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F246-2AX4;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 22/63] finish_automount(): simplify the ELOOP check
Date: Fri, 29 Aug 2025 00:07:25 +0100
Message-ID: <20250828230806.3582485-22-viro@zeniv.linux.org.uk>
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

It's enough to check that dentries match; if path->dentry is equal to
m->mnt_root, superblocks will match as well.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 86c6dd432b13..bdb33270ac6e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3798,8 +3798,7 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 
 	mnt = real_mount(m);
 
-	if (m->mnt_sb == path->mnt->mnt_sb &&
-	    m->mnt_root == dentry) {
+	if (m->mnt_root == path->dentry) {
 		err = -ELOOP;
 		goto discard;
 	}
-- 
2.47.2


