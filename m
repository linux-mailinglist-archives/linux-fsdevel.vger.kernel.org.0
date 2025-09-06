Return-Path: <linux-fsdevel+bounces-60431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E9B46A91
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1EF189084E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8C2D0636;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tOcQp5W+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D452289376
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=bJa1CS0URIaQpmlVDp2tJPbaggEyeJNSjky/keREfvY1R7YvHdHzkj9afT/Dh3uewI+iDtON1b9eMVhXWVF7OawUD/SvP88oGrE1DPHUhICqcQw9hOmckouXRxH5M+DkMH3rWD1z15Txf8Te1dJY9G+ET8njX+hTsUXY95uIh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=9V2KAXjKgf9YWu2A4c+rh1ZQFHWvjpWADMawDYNK+ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPziLmExNZA6fnmXxXq+j79+I1SknPW8Qzwg8+iPS3baBk1TQ0HqgJrBN0zeQJlaTv5EdzD+oPdQoO5DvApur1m48Tb4OeGFnplf1qb6M6JQxi+RJ80nENlw2rMT4Z5OTrgpNl3uG46Bf3cgGtjXy/GFLVxm6oJ5Z6i8XtYVhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tOcQp5W+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vqOrsu3sSEEqlBl1ggKOhgzbWzNVcpMwbNurDEwdIBA=; b=tOcQp5W+vKQ54cdhhvJ0qAihN/
	ZEO4twCTPKek0dc67NeXSV1JtHIILF/0WlviEEQLKnvbQqaoS0M716sffP83N5W3IesKlbXEcxxyh
	duZkoVOBsVF/+JylHagT9zQvneZ8L1+uZwgUSbtUeTtK6qsUI3S8CTKD1keD2ssvTb/h8aJihhopT
	OC58jUd4h2yGHvu2fJ85jLytfKpRkCcIBjQa0V8qvqMqcIKJ3+uVDDNS2dGZAJb8Ef4TQyRUv6gC9
	Cnvsvesyrsyzr+T4fI45LXwiHkj8kCFpwj5IdilkzMOqVEm0uyb9NvwvOZxOA9inutTsa0V4wICtn
	HJpnu6+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000Osa-0xfS;
	Sat, 06 Sep 2025 09:11:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 09/21] check_export(): constify path argument
Date: Sat,  6 Sep 2025 10:11:25 +0100
Message-ID: <20250906091137.95554-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
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
 fs/nfsd/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index dffb24758f60..caa695c06efb 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -402,7 +402,7 @@ static struct svc_export *svc_export_update(struct svc_export *new,
 					    struct svc_export *old);
 static struct svc_export *svc_export_lookup(struct svc_export *);
 
-static int check_export(struct path *path, int *flags, unsigned char *uuid)
+static int check_export(const struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
 
-- 
2.47.2


