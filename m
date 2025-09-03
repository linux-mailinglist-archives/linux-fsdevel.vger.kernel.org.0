Return-Path: <linux-fsdevel+bounces-60086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0697B413EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2AA1560409
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF02D979A;
	Wed,  3 Sep 2025 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="am0CvwK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542DC2D837B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875349; cv=none; b=EzKCvotWoXI3Tw/Z2JW1CbGGANRtIlJFCZ1heDTcZfFXKZ5/E1sehIPDObGqA0Y6ulD5Hy87hay9DpL8wRz9JxbYxhrbMoojJi+OiGX6wYE15AOPge9EuVE7osbeEdNa7dMoKC8nFWVgNe7Rz8bQvUkMJ13UV/Xz3C6O4dPzOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875349; c=relaxed/simple;
	bh=PQHe++9m2TjsPlddLaEEAdfCIOjFywPJ0WOeamXyqEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE6ThI9MV5PafbVlSeDqR3Ww9gg/Rzt0l829XrCIDiWMHsyT/3gmm6HPhLEV3ruzQD29d2sQ8axDS6VOtsroGrUzkFtbJDClP7S4orikZvGe+zUzw84YBWxwCdBV3nN6Wt3zdw1LmL/y4B8c6krNeyimb/zQDkLeH+ZQuOM7TGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=am0CvwK+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CpWPmgojsb5IYnYF45al26KrgoPCu2cBLZZGPl6Kvfs=; b=am0CvwK+GWAdlMB+jBw4DwSVxL
	63kGrEWfQKN/JD/ETuipbsgzuhcHQGk3dT7coxcc0X9uxjcFTojoXNG1GqH7N8le1+y55wXeM55pU
	wPZj1Escj4vf/JoVytyibvtJN3kXiZysUVtR13djVvCSBObZhnIeWsF1sluTrR39UAvmGYkIa9MUI
	+gzt5l+Q19lI8QCevi4E6tKQ3Dm2XdBHXdo5EmXrbpCoOlVlyItQjzETgoxTScli5BVHm7P3m01Ct
	oZVvj218hwz25kxoEEc2o/ZQV2IrinXYOj/OIPTOU5NbhhqxLnv4oeeadU7+DFdRV1/5IrxhUVgCy
	jEt8AAxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX7-0000000ApDG-3AWy;
	Wed, 03 Sep 2025 04:55:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 43/65] do_new_mount{,_fc}(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:05 +0100
Message-ID: <20250903045537.2579614-44-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index be3aecc5a9c0..f3f26125444d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3704,7 +3704,7 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
  * Create a new mount using a superblock configuration and request it
  * be added to the namespace tree.
  */
-static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
+static int do_new_mount_fc(struct fs_context *fc, const struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
 	struct super_block *sb;
@@ -3735,8 +3735,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
  */
-static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
-			int mnt_flags, const char *name, void *data)
+static int do_new_mount(const struct path *path, const char *fstype,
+			int sb_flags, int mnt_flags,
+			const char *name, void *data)
 {
 	struct file_system_type *type;
 	struct fs_context *fc;
-- 
2.47.2


