Return-Path: <linux-fsdevel+bounces-65819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A8C1261A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25950582283
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A72EBBA4;
	Tue, 28 Oct 2025 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RshzQwww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDC215077;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612385; cv=none; b=MqxalgX55dVrSZdwX7W1VHj4NCpL0q5MTFnqNq6JdNZChDOpQAhSvtwnWGlHLnXDIlyyzBf75gBcWkLXMb245ITgPR7qt1MWIWYocHE7TUl6o/bZXgPUN+4lSajjYRnSsuELUApnqezcON7Oqm01VbP2oxMyY1CxwP2cx7cVqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612385; c=relaxed/simple;
	bh=bU90G/LAnrPlfV5GT0lIMSVw/xfb8+uYyIix2iEsUM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq5iu059eCykq6rdT2NLq38Jt/R1e33MYvJrESKgqbMm7gEowle91a1BCGxf3tdIGqh5JKAQ/P+U/spunZRoQMcYjufS75pHVFnuXg1VROushjIygZAy6JJWr3wnkLmHJlYFocMpgoG/Dqy64+RrZ4//eaqgrCaOZvrhQp5pcGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RshzQwww; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4Quy3Z9YUR2p7/o0BhLPqipVcn+3o5MzKrJ0FbjbabQ=; b=RshzQwwwhIM4JqS6JZxrRB6SRi
	sXnRpYSIo5COA7j41rIr+FZs7mPLff7B9ySvdiZZ5lxVK1g06AvmaXhv70p6toFwyWll9CLH8n+FE
	Bq5eaBQZ5p6VPRqN6KqAKsQstjhS1pRI2XyGASAUKmqRbjLp5H6jxFr8YgIzLixZkt4ZM99eScusG
	ZvniTtZpZZ5rRgkDy7NGh6LoHz5GnEDif1NgRBV7e2R6k1CpekKobidov/xXX9HqS+xxsxzqpESLf
	1sTR9kt2IXyvCjxM42Ti0MKZ44e35LMsuOuX1BoVt3Um7IFuEeybntNtMTJWIiADZ/bjaKcxTyo3J
	de8RuQdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqp-00000001eWn-2xv8;
	Tue, 28 Oct 2025 00:46:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 10/50] configfs, securityfs: kill_litter_super() not needed
Date: Tue, 28 Oct 2025 00:45:29 +0000
Message-ID: <20251028004614.393374-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

These are guaranteed to be empty by the time they are shut down;
both are single-instance and there is an internal mount maintained
for as long as there is any contents.

Both have that internal mount pinned by every object in root.

In other words, kill_litter_super() boils down to kill_anon_super()
for those.

Reviewed-by: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/mount.c | 2 +-
 security/inode.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 456c4a2efb53..4929f3431189 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -116,7 +116,7 @@ static struct file_system_type configfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "configfs",
 	.init_fs_context = configfs_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 };
 MODULE_ALIAS_FS("configfs");
 
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..bf7b5e2e6955 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -70,7 +70,7 @@ static struct file_system_type fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"securityfs",
 	.init_fs_context = securityfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 
 /**
-- 
2.47.3


