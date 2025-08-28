Return-Path: <linux-fsdevel+bounces-59579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C69B3AE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BC3583F5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDED2FDC5A;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JwOgmlSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085F2F290A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=lZqBZZflIjtk5pmXaIyzTqBBWfP8+ILSjOe5okx/ILDg5MAUJQ8BylQsSX8wZ3ikHGNAb45amuhx+CO4mcoAjPBFLyu5e+lFdXkO+8IJqECJ+tk0RCnvm53MZdENxQNpd4RMDEYpGoPBnXF1d07tB83ip672N+P3jyK2IunNqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=kvEWCqcw8qckIUAd6jLu8wa1s5H04euOpmD32AxudCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZRcAqPdA9s0OHDFYYl2hbWrSSJRJAqf8eiSV1nt0aO/EiOERiuIyjlA5Qxc06m4AmNKFQ+n2eRk2+2J2GwknNtwyizkBCBV7pnksH7/kWUOEhlYiJEgT/EjdJV40VhFGs9Ek8xxf9E+W+ex8oHhkDWBQmxfgZqZkkDtHTuC9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JwOgmlSV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8XgUTj5g7uLsTi2dJxdvQhtf2NMTXs3oSFFm3PVupnI=; b=JwOgmlSVnAH3yAqDcmQZ9Xp6Uj
	V29uOWjiWnjsJO4xWIiaYFLXwsN2ltvehFGqOFJOX7kNNz6T8ZkUaN7IyHzjB1avCAN2uYStmpMsC
	GJUoqiOBTqeEnujtsekwYEgNVYrzEIlPX1WnkXLTCo/6uLCKMcYx3WnIYnI/dG2ZVZY42XByZKEcz
	qeyFajZCaBZFqHplYw64ED29trFhq+V4Qqg7RRt8mZ69oV39hlF6UEwhwcXoXBz9zOcZbaiCe1qS8
	5MAxtqKsc16rPb2dYRX+E0R7dmla1nNg3P3srzv4RYIma38puMpOC7GcWZp9f+wkkblML9G4hjPk1
	KUcJnJBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F28s-3CnK;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 47/63] path_umount(): constify struct path argument
Date: Fri, 29 Aug 2025 00:07:50 +0100
Message-ID: <20250828230806.3582485-47-viro@zeniv.linux.org.uk>
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
index b15632b70223..a14cb2cabc1a 100644
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


