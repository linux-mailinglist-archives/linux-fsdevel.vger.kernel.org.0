Return-Path: <linux-fsdevel+bounces-39051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B31A0BBA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A43AD6A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB9C1C5D4B;
	Mon, 13 Jan 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R8VJClAM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A01C5D42
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781281; cv=none; b=LdVjSVyJig4m1zhZCb0FzOIlqxqS6DDuiVR3QoBmjgOrMR12/4+FD5mhS0CoK5ZIrl9EG1jFeNuL6Tgbqa7leLgQ3tm5NXBZi9KGfQtk2Bp/eSeL5W/KzRbB2b6qQlrfUZwXCNNrcwVBVl0e8egjzN/i5xNg5q59UaJAV7iiFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781281; c=relaxed/simple;
	bh=27af6UFTjgC8JXuzWTKbG4wXMsixlK2CXsc9i10mk8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gGR0Cc+hXhB7otVyPn5vjP7Bs9uFOAy7/jk0FplrJDfLwHbSQcLHclrvP3M153XzVcnoZ5R6NjFS9ILKZMU5RHMdhKTmr+GC/VckRugr1Ol9m/PhCjaA/soJIAruaJPVJI3N2bNwZjLbn3f1PMjnJNTd8xxX/X870y0lBmiFx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R8VJClAM; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736781279; x=1768317279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABTXRqtlKUWAkRNrq8PVrov2W35Dcn6JEopf0ixSESc=;
  b=R8VJClAMsMm4Q8cR1+Prezl4qFvqzvsHstK43//m9MnGIH3zoCnU6Eg8
   G+Gb1+57FZoL3J/jjATdqpaj92nKM+3MSn4Mu0Ow11Iorixg9KDa1JHf5
   ZUcvRzIlSPZK3hoUi5PBVMQQ1dD8/upPjWxDwcTWznzzz1q8EXqG+f2GM
   I=;
X-IronPort-AV: E=Sophos;i="6.12,310,1728950400"; 
   d="scan'208";a="163779839"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 15:14:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:64957]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id f8d8fd07-36e5-4732-b743-984d6e52c462; Mon, 13 Jan 2025 15:14:37 +0000 (UTC)
X-Farcaster-Flow-ID: f8d8fd07-36e5-4732-b743-984d6e52c462
Received: from EX19D005AND004.ant.amazon.com (10.37.240.247) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 15:14:36 +0000
Received: from c889f3c14e42.amazon.com (10.119.6.222) by
 EX19D005AND004.ant.amazon.com (10.37.240.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 13 Jan 2025 15:14:33 +0000
From: Sentaro Onizuka <sentaro@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Sentaro Onizuka <sentaro@amazon.com>
Subject: [PATCH] fs: Fix return type of do_mount() from long to int
Date: Tue, 14 Jan 2025 00:14:00 +0900
Message-ID: <20250113151400.55512-1-sentaro@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D005AND004.ant.amazon.com (10.37.240.247)

Fix the return type of do_mount() function from long to int to match its ac
tual behavior. The function only returns int values, and all callers, inclu
ding those in fs/namespace.c and arch/alpha/kernel/osf_sys.c, already treat
 the return value as int. This change improves type consistency across the
filesystem code and aligns the function signature with its existing impleme
ntation and usage.

Signed-off-by: Sentaro Onizuka <sentaro@amazon.com>
---
 fs/namespace.c        | 2 +-
 include/linux/mount.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3f..5d808778a3ae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3835,7 +3835,7 @@ int path_mount(const char *dev_name, struct path *path,
 			    data_page);
 }
 
-long do_mount(const char *dev_name, const char __user *dir_name,
+int do_mount(const char *dev_name, const char __user *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	struct path path;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 33f17b6e8732..a7b472faec2c 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -114,7 +114,7 @@ extern struct vfsmount *kern_mount(struct file_system_type *);
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
-extern long do_mount(const char *, const char __user *,
+int do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
 extern struct vfsmount *collect_mounts(const struct path *);
 extern void drop_collected_mounts(struct vfsmount *);
-- 
2.39.5 (Apple Git-154)


