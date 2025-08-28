Return-Path: <linux-fsdevel+bounces-59577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D315B3AE33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A13BAFF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40832F1FDE;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PKr8EExE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448D2F1FE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=s6KpXhU2WLAD1hqP3YHwd2VfpnCikc0kA5v5Ol7nsSkPWFADDF9Ni6GbOAxzbnwfgbGMTlRIozE2cMoE9X5fQnipPfFAKlKrK7NqvrYlVbyTeyK5qNyevPp79Vupy+ch1uDm7sT1mZgg2rKU9b/2RvP6ZSvLFa/hbrTpk4A/Bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=dNKwU4gxogpqilkaVL7HqTPn55PGR/HZz1nZ+ASkKtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVF/Xm0i8eP1oWSYI/Y3FF4oBC9EEexCXrEiYHNEz7dLBSTLUWDkP2/p5j/nKEwQypWFlm83QeFjphLtggJeauRAQ/idm5WucuZ5GsTtdolYo+WXrBCpRtz4H3B0Qbcw5dOPNK1RDl/mgzx8UDglpJRnOBMKI9b0sE6LqEy2E0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PKr8EExE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mX0W6Cpb0rmHTEgf49o7Fcrrq+snwv0IhHSB3QAjUto=; b=PKr8EExEEDG+4W425CBvU7Webq
	78J+nrGGgjHXTNlMgHCEh+LsyoRececbXfZBqST36fRQnt0I0T8iElLvzOSWqHuD7yRep8UMdajcv
	xjFoT1XX8nLQvZ2fko1g3BbpJsF3aBL50C3XsXT3cHpSUA7Y2Ha0Ml/1F9lDbyAuVgioCWX3uRkT4
	MQLzXZVLCTu8535XeQTQHrYHp8Wk9iCFI5qja+Xf98mAD9gFQ1yofBxulH9UFn34mDmaujbWBXJii
	mTJJrJAGNbfJ+GyLmvVBXmHFbGWrZbt8sk63bXeovhf6LRtwQpijjCxN6isYWiSB+H+KJFzmSckad
	5cAkRvtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F28V-25fv;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 45/63] path_mount(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:48 +0100
Message-ID: <20250828230806.3582485-45-viro@zeniv.linux.org.uk>
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

now it finally can be done.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h  | 2 +-
 fs/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..fe88563b4822 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -84,7 +84,7 @@ void mnt_put_write_access_file(struct file *file);
 extern void dissolve_on_fput(struct vfsmount *);
 extern bool may_mount(void);
 
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 6ae42f3a9f10..34a71d5cdf88 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4018,7 +4018,7 @@ static char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-- 
2.47.2


