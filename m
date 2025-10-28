Return-Path: <linux-fsdevel+bounces-65813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E25C1258D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740493B64DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02693271A6D;
	Tue, 28 Oct 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZP/5LJ2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863421A434;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612383; cv=none; b=ZMkOE9hzoLJKUmX2/7ypxd6faeYfS3WxXUVi1N/0AQaiuiZvKu/2GwQLyocK9N2MQzbfYxhrXO8VUP2mNEkxc/ChbttNnsSRcMqdhxIABOhVz3fwfj/D3ZjMzjCm7+1NrF7hoeFNpDtMBPKE2Spc4iYM6lP4koDi3GOwQffZczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612383; c=relaxed/simple;
	bh=cPOxFMBLc13aTQ6kNNeMr1nHH9VwsrN2XN8U+K2FM4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eu/yrgrBDjEqkJcGzzYAilk/thUHsBscleYPSaxkBERB9byaIa7xExi3SNgpu28LyPMJQoO4wd0ccuwNsiQxgpq6moRh8GglWNuLbJYwE9aDIRD4icHtZAED4pMtioj1umbo8gbz9lUK4cElJH+hJS/C+4RS+uB4sfo1O722FcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZP/5LJ2L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IpNAvIvaquRQO1Ji53mf5vyLMZJ4O2UIIE/EO15yw64=; b=ZP/5LJ2LFqkgPJcGiYKyxpw1bl
	eE3CR/YNuYLN0WTyuXwstIsr4MFxI2VWRTUkfj42e3nPv/cUgi0kuvG/bWyRLxSi5NQw7ta1hlYv4
	Xd5dbq/1RgBzh34OYZIx+WEXJGf6km9LeONaBmB9ZMfMIPXlmqSQ+hT7FWjsKbJ9vbGyq/LFSSxKm
	A0vkavXp26fq9SVKdWu5aIE6UDcTLlY77eXEFO/mLAq+Ea1RoI513C5nQ17dKaQ87vH129hNwOX9w
	ckBwjy/VEiET6MWdU6BL+O/WKM5gcsk8pDaiZz5CqjAwGDoqmKOewqwSjwO/29YQIX+8JGowiC0Jp
	MRIn2MRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqp-00000001eWz-3auK;
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
Subject: [PATCH v2 12/50] convert smackfs
Date: Tue, 28 Oct 2025 00:45:31 +0000
Message-ID: <20251028004614.393374-13-viro@zeniv.linux.org.uk>
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

Entirely static tree populated by simple_fill_super().  Can use
kill_anon_super() as-is.

Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index b1e5e62f5cbd..e989ae3890c7 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2960,7 +2960,7 @@ static int smk_init_fs_context(struct fs_context *fc)
 static struct file_system_type smk_fs_type = {
 	.name		= "smackfs",
 	.init_fs_context = smk_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 };
 
 static struct vfsmount *smackfs_mount;
-- 
2.47.3


