Return-Path: <linux-fsdevel+bounces-65845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF4C12744
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2043B86FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDF833CE9B;
	Tue, 28 Oct 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cWKXwiJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721220B7ED;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612388; cv=none; b=VMakCGLXXD8hHjqJYzRjt4RElTxgZoLmR69SD+bK2fM5ABlIjN3eXj7GfkmWcvbcC4rjjAUKxo4X8iQFMS94Zi+E/6MIMGCCkZ+O21+9enqO4qgc8FGNXY6cQ+I4qqMutwAcdEb0Uxq5NAO44PIa+4tMIMzQdMcrsbKTCsCdgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612388; c=relaxed/simple;
	bh=WxSgeuo0ahJRBpa5cCoszsU7LKgd5x5Hzdw5+x6gsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYOGXlq9boOfGh2SkOn7V4pHbKtT3jFNr/N6m5SWnEKbZOWUGNSDPVfYDbRFvzryAz+MVE8esC92OvDK/FVNEW/b4o+2kn6j3ro2monRtybNIq/7vUfzGrg04e2d+IgNunVJspkeLva402hgykFe56AawzYzp97T6MZ5eTzxkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cWKXwiJR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eoHAGF5loUqH0LAFPRC8F4kXyPuIEz0vDtopK5rWb5o=; b=cWKXwiJRgmyUaWc4btZ5WzGz3e
	P1d4pU2PnDGwHyXYYC3Sgwm/WPpNg6KTwV5sROPVde7FceyNHhhUc0N4X81SxgJMRZaYvSs5qCoF/
	0usQSfZLUxv2nUlR2Jfp5JWmBh+5fu1PIOG0mXjNiaHsbpZuvnuCBQsXL9AKNKoUcXX02D2qMvWqk
	qnAOvMK+sofvaE+oth2FQB23/OCTjk4qP5LStexB4zj8DV7NnUUQGzcMZAJfRFTfyrPeKSt6B6Q3u
	q06p5RvGSDJEqongOiLQqYlkX46ecZiHjCeRWGwudoHTsnkOUbcR71MM5KOW07SuplgdFJG4EF3Ct
	Kh0HmJcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqr-00000001eZ5-2N4G;
	Tue, 28 Oct 2025 00:46:17 +0000
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
Subject: [PATCH v2 28/50] binderfs_binder_ctl_create(): kill a bogus check
Date: Tue, 28 Oct 2025 00:45:47 +0000
Message-ID: <20251028004614.393374-29-viro@zeniv.linux.org.uk>
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

It's called once, during binderfs mount, right after allocating
root dentry.  Checking that it hadn't been already called is
only obfuscating things.

Looks like that bogosity had been copied from devpts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binderfs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index a7b0a773d47f..8253e517ab6c 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -397,12 +397,6 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
 	if (!device)
 		return -ENOMEM;
 
-	/* If we have already created a binder-control node, return. */
-	if (info->control_dentry) {
-		ret = 0;
-		goto out;
-	}
-
 	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
-- 
2.47.3


