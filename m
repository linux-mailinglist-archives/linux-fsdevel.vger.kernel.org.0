Return-Path: <linux-fsdevel+bounces-67829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33506C4BEAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E34A4F253B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A0357705;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LN6CRJ2n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7223431F5;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844134; cv=none; b=IGiie/ae5JnKU7IEqiccDTi46tN7bZQoov1RalwTsve5kg+RoMoPojdi4BPqAmiLm+GXPIW7QRpUEQrJBaTP3Dc1ar85TPCm4gAG+Hgf0w7LrT0A9kM6SyiexDG+JOVv1DYWIDmXA4vo/pvOWI8AGBt2FEPaIo4NP9m9uv0ej2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844134; c=relaxed/simple;
	bh=uIkWhT5lBZMbGKboTZYEGGJGOnQwh5txmBIVng9mTCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXkATwkGobeVxwxJ1/9ofx2k5Y6kXzPx0a0yTgZYE8DJolka/apb35QjpxsxTUMpHldb0HG1EXZ/T5Y8Vfdgn8qPWikoDAqvm+nWQfLoby7Ybx8UEdEhXLXlgEYQagYiatsshF0wMUWzTCX8JL8P+/HNV8DRlAZNvqwazY1K2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LN6CRJ2n; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nXGw1nJCnekakkZR178NLSh8+iviODtKUClSm5rridQ=; b=LN6CRJ2njLT76zNgYlaloendZP
	sUs3p5zjumc8j/z2khvoDt6+pnpIkisW6gygxsWR+ifalIz1V4Yg5DAQ9FtJs7tAbkVTOk4sQFzEE
	Akpdo+3J8ogkCfh5OvJpyvM3sqOb+5OBZAHsB5nEDbL/doLrK3VQ3BXxoVw3mc0cvWpZeEKGJpK3+
	3I01Dow3QlFmu3TPpN6GW7C0p4u0V6qh6lc5uZmhE3vSZBXAHA4H6KxaKJeeh+6b8Bn7Psl1wdOyZ
	REPNGf5fPVNcffpJNQamrqIiuww6WrjvNELA6e68M74n8WF3URvWF9NFN47LeYZylNTGsroeVQ2D0
	f1oMDRWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHj-0000000Bwy1-0ZAJ;
	Tue, 11 Nov 2025 06:55:23 +0000
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
Subject: [PATCH v3 11/50] convert xenfs
Date: Tue, 11 Nov 2025 06:54:40 +0000
Message-ID: <20251111065520.2847791-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

entirely static tree, populated by simple_fill_super().  Can switch
to kill_anon_super() without any other changes.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/xen/xenfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index d7d64235010d..37ea7c5c0346 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -88,7 +88,7 @@ static struct file_system_type xenfs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"xenfs",
 	.init_fs_context = xenfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.kill_sb =	kill_anon_super,
 };
 MODULE_ALIAS_FS("xenfs");
 
-- 
2.47.3


