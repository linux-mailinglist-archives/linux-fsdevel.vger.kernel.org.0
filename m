Return-Path: <linux-fsdevel+bounces-51651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4722BAD9A4D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F9D17CE98
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 06:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5B1E22E6;
	Sat, 14 Jun 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pEXs6Wa/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3C2A1AA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Jun 2025 06:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749880954; cv=none; b=HQ+MwKmebwDia4tUZo/fgBuJ3OBpr6NKi6trD/3PKT/WSRXrIg0qTyF0Dx2+LhE/o2IIWsYNlLCA748g78rQyxDOHPuprEcNf7u3hRWuOOMVxLCkYtAj2CFH7HrEpifsFWy2DQQuoPpDdzDRpzf/y1eTc163RFurfIqrY4hU5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749880954; c=relaxed/simple;
	bh=LJu1OY3fvPIFXU4lCCF00oqI6kjeuHvxUnP3ly9W5Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcK8hezyCSnWtw/D2kptfXinH2RGs4BlI9DWCGHU+z4EFfO2/sPLylCGYsEF0AQqw26fWE9dnWbgDn4UMysScE7xjcTEZh1CSBvd8wWT5ZKqaTYtcMMzd2y5AwPU5l6m6uyrqSyigCoFtuyTqObCUEY1QZ9bo4H/QJvNzk99J1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pEXs6Wa/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wr0H5jh3TZJ0zV7oltYvQB4G1eh/qrqcOY7Bhi9PWLU=; b=pEXs6Wa/HSLvhSk8txIHad68Qt
	0gvOOfLvq1jQ+jCgyptdt80tBx/xGub2TqpMlCO6LfASXfVcr6Wb5gD+qK2XRfbm845J1Ks9alncF
	F03aD95ugVBhFJgekwyzPAJLYg4Ee+4dTnp8UuxXsTQxVNVzleJvddUjoRv/0Ql4g35xBub4EOtBL
	n3UIPuGOmGU1Y2mZ3+V6iUj9Z7biR4Ocz29eYAiDqVWs074vpdB1M+iFEFRqUEMwHyhOyLz9JnWVk
	TiNej0z3KQHCddyz1zzxZ777JARpAPSn9aDIYIVIwY9VipNRPL5cpyev23eLgtG+RgLDrmqqL8xsq
	FoR8+1tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQJyI-000000022p7-2jIM;
	Sat, 14 Jun 2025 06:02:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: neil@brown.name,
	torvalds@linux-foundation.org,
	brauner@kernel.org
Subject: [PATCH 1/8] simple_recursive_removal(): saner interaction with fsnotify
Date: Sat, 14 Jun 2025 07:02:23 +0100
Message-ID: <20250614060230.487463-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250614060050.GB1880847@ZenIV>
References: <20250614060050.GB1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Make it match the real unlink(2)/rmdir(2) - notify *after* the
operation.  And use fsnotify_delete() instead of messing with
fsnotify_unlink()/fsnotify_rmdir().

Currently the only caller that cares is the one in debugfs, and
there the order matching the normal syscalls makes more sense;
it'll get more serious for users introduced later in the series.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..42e226af6095 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -628,12 +628,9 @@ void simple_recursive_removal(struct dentry *dentry,
 			inode_lock(inode);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
-				if (d_is_dir(victim))
-					fsnotify_rmdir(inode, victim);
-				else
-					fsnotify_unlink(inode, victim);
 				if (callback)
 					callback(victim);
+				fsnotify_delete(inode, d_inode(victim), victim);
 				dput(victim);		// unpin it
 			}
 			if (victim == dentry) {
-- 
2.39.5


