Return-Path: <linux-fsdevel+bounces-58949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C71B33590
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EA73A643B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A5527FD68;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eI9pFuac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F159280339
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=MAEqXjS7o6KSeCGvJM+gsh5EohQnV3wecaSZQG0uPY4Nn2tMSAUizdnIXEo8WsmLk3dPgOrg4caalNm+9CONLeu0G+KjuijzIaQnoBaoID5sZhluPWZP8je8y4cGM6dAsmwFkDwnRJ/k/uYETAIQRgq7ctz5EDhri2zFm4R6AzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=S6EWsyIUzCtnkDsN3D+J2E168XXw572dJj1XoZCp4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTrLKcxDJixp3MB/9XD24lIlNBzYn5BaWuTI4v3oiE6lJ/osG+dY/c+gRQ3xlj7GTVrWrC+EY2ZZlLE0xCB4k4XSDwY5r2P1kolj2BAh0YBBO4odaxgGIwecRCrXysDdBQq2lJGvvF1lTbyCk5tfP0AmwwOnz7QXwFXZspOeygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eI9pFuac; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fknhavajNd1umv3BLNneOonhFAUcASmWU15ccTZ0j1o=; b=eI9pFuacnYRFKGwF0SAHeyfedB
	48E0oV9Pg3eOeWqrGUPOzS0dK1KWN+hNKuyUmgItF9N4wiwakZGU6rUytSmk49iYsCgKri+Du2PoJ
	fxwzf5fFTOB8iXF2w6T0TjPVwflvF6tVJjeiZ2QNW+fWyNwQjxqPFjGfl9kIRrIGTkvYU4IoIl434
	dsLLUBZAUIpLiG4KImWWQxoec853ireKo4e4YvrKozfNjYSp/d5D7Y6FtsM/HqhDwcacdvhfzbM7K
	yh/d3gawBXsi/gFezvabSuQT8Zegs/XYcW+5vkjYUvBPcUZvd33s04uWoAJiughmYSj+3fmTUkbls
	JauLqb5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TFK-2aQj;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 46/52] path_umount(): constify struct path argument
Date: Mon, 25 Aug 2025 05:43:49 +0100
Message-ID: <20250825044355.1541941-46-viro@zeniv.linux.org.uk>
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
 fs/internal.h  | 2 +-
 fs/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index fe88563b4822..549e6bd453b0 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -86,7 +86,7 @@ extern bool may_mount(void);
 
 int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
-int path_umount(struct path *path, int flags);
+int path_umount(const struct path *path, int flags);
 
 int show_path(struct seq_file *m, struct dentry *root);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index a94aa249cedb..76f0dde2ff62 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2084,7 +2084,7 @@ static int can_umount(const struct path *path, int flags)
 }
 
 // caller is responsible for flags being sane
-int path_umount(struct path *path, int flags)
+int path_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	int ret;
-- 
2.47.2


