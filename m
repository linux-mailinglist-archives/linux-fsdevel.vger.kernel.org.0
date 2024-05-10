Return-Path: <linux-fsdevel+bounces-19269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 159418C23DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B032885F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417616F85D;
	Fri, 10 May 2024 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCRZc2s8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E216EBE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341647; cv=none; b=SMyUr2OWXMxCeosXDKIFPn6zgAZCe+GqXNeSJ774McfzswA9rPdXDPFT5y59ULdkuChexQ+DKtcOibD5bU/6VYeAp124HTuXo1j2ThF2Op/E+Np+Xe9bh9R3wGQRtlFTqSaRfL3jKC9M76ha7VIxTORjEkerSnCND6BWe75FW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341647; c=relaxed/simple;
	bh=JKHp4Rh5kiRcj7JDKcLq7wL0HdW0ZmOA3PpfklMf1Ns=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=hMhpV9MAqwHwJt2/on0FRNCrzSNATFLTFSH2xVCzpIQXSoWhaH64uBADpqh9VJDe9cMOswdU076kaJudNvp2rGB7ZWMG0dbZ03UzhPPLuwY9PfnH3oilRZsjtBiBw3EqIVaewrPJELagNFCihlWK/JYuEr5DFfh+nfQZ808oimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCRZc2s8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715341645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sd8WPC6FQ4+Bcwqy340NHitlPtCAliqE6vEb39UhEp8=;
	b=hCRZc2s8bGts+ZIC8sqd5HLvl8RIVA3LBnywqDR83dMDII04kUD8YdW6H1iTEASKmZLm4D
	7YnjCkKEee0Jy9Xm5xGsLXuriGE26zqTyzN0fIZ0qm4/5tPfWSvT1CU5o+BhZCGDpExStJ
	JPT4dVgEGbg8pWFwePERnGDuY+Id66Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-T2OoUr2rMW2tuHOYkkqepg-1; Fri,
 10 May 2024 07:47:23 -0400
X-MC-Unique: T2OoUr2rMW2tuHOYkkqepg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E00429AC02C;
	Fri, 10 May 2024 11:47:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 574FAC54BBC;
	Fri, 10 May 2024 11:47:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, Jan Kara <jack@suse.com>
cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
    Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ext4: Don't reduce symlink i_mode by umask if no ACL support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1586867.1715341641.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 May 2024 12:47:21 +0100
Message-ID: <1586868.1715341641@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

    =

If CONFIG_EXT4_FS_POSIX_ACL=3Dn then the fallback version of ext4_init_acl=
()
will mask off the umask bits from the new inode's i_mode.  This should not
be done if the inode is a symlink.  If CONFIG_EXT4_FS_POSIX_ACL=3Dy, then =
we
go through posix_acl_create() instead which does the right thing with
symlinks.

However, this is actually unnecessary now as vfs_prepare_mode() has alread=
y
done this where appropriate, so fix this by making the fallback version of
ext4_init_acl() do nothing.

Fixes: 484fd6c1de13 ("ext4: apply umask if ACL support is disabled")
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Max Kellermann <max.kellermann@ionos.com>
cc: Jan Kara <jack@suse.com>
cc: Christian Brauner <brauner@kernel.org>
cc: linux-ext4@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ext4/acl.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index ef4c19e5f570..0c5a79c3b5d4 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,11 +68,6 @@ extern int ext4_init_acl(handle_t *, struct inode *, st=
ruct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
-	/* usually, the umask is applied by posix_acl_create(), but if
-	   ext4 ACL support is disabled at compile time, we need to do
-	   it here, because posix_acl_create() will never be called */
-	inode->i_mode &=3D ~current_umask();
-
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */


