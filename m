Return-Path: <linux-fsdevel+bounces-24189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E993AF19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18FB1C22D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDAE152787;
	Wed, 24 Jul 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKCWXpFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271313DDC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813631; cv=none; b=jf8MWQGDyH/+SaioA/sHTR2rxOe9t294uDYk6DI8QetrGwbnTljOwiQjh1QRuTfi8+8j/XyE4GON3JWi3mA+VKtb13F/B9/HF76TcDE2pSDAiVjb/JTTrd0yUGbZpAcQKeOQZWrbPyU+c/kPwp3OelsgZUK5pDKxPq9vcQK6NQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813631; c=relaxed/simple;
	bh=JwAN0p9xGTAtBVInec8HKaT/5oiojA+fFig7rXhiNr0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=LoyRApuMk67OCaQj2Lh9rxqhd68YnBUhpBn7DIr3LcGxAysv84tPM6ONSUUAmj+4FvI1DCDorR1aAI0BSGNJHRKhcUubq0+oRJfDBgGV8MgdgmiE8UE8QrWAGyt1k62C70IQGLHBZfhEIq0r2RLr60kDy5FmlZX067meRFzZCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKCWXpFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721813627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GoY4pFrqHX8MXBZW22RszHtr+lnU6O5VxxiYvvR8an8=;
	b=WKCWXpFnLaLXPLaGK8ACpGtpvVFD7K6tFVXXHGcgqip3SXE9XREM0dF5R40x1a3xAzMoah
	ztLkhpfaX1qN6alkfTz9z0vSFCBTuWVu+To+gmhlCW5/lxJmBWdAeRUB5YrJGXQvslN7o6
	SZLnZwHqvLu1ASzY9uTt/5zcfFlwbzU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-mb8YA0wBNQSdkhUQDlftnQ-1; Wed,
 24 Jul 2024 05:33:41 -0400
X-MC-Unique: mb8YA0wBNQSdkhUQDlftnQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152C51955F43;
	Wed, 24 Jul 2024 09:33:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAD9E1955D42;
	Wed, 24 Jul 2024 09:33:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Gao Xiang <xiang@kernel.org>,
    netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Fix non-taking of sb_writers around set/removexattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2299427.1721813616.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jul 2024 10:33:36 +0100
Message-ID: <2299428.1721813616@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Unlike other vfs_xxxx() calls, vfs_setxattr() and vfs_removexattr() don't
take the sb_writers lock, so the caller should do it for them.

Fix cachefiles to do this.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Gao Xiang <xiang@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-erofs@lists.ozlabs.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/xattr.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 4dd8a993c60a..7c6f260a3be5 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -64,9 +64,15 @@ int cachefiles_set_object_xattr(struct cachefiles_objec=
t *object)
 		memcpy(buf->data, fscache_get_aux(object->cookie), len);
 =

 	ret =3D cachefiles_inject_write_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, sizeof(struct cachefiles_xattr) + len, 0);
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write_file(file);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache, buf,
+					   sizeof(struct cachefiles_xattr) + len, 0);
+			mnt_drop_write_file(file);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, file_inode(file), ret,
 					   cachefiles_trace_setxattr_error);
@@ -151,8 +157,14 @@ int cachefiles_remove_object_xattr(struct cachefiles_=
cache *cache,
 	int ret;
 =

 	ret =3D cachefiles_inject_remove_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_removexattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache)=
;
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write(cache->mnt);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_removexattr(&nop_mnt_idmap, dentry,
+					      cachefiles_xattr_cache);
+			mnt_drop_write(cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(object, d_inode(dentry), ret,
 					   cachefiles_trace_remxattr_error);
@@ -208,9 +220,15 @@ bool cachefiles_set_volume_xattr(struct cachefiles_vo=
lume *volume)
 	memcpy(buf->data, p, volume->vcookie->coherency_len);
 =

 	ret =3D cachefiles_inject_write_error();
-	if (ret =3D=3D 0)
-		ret =3D vfs_setxattr(&nop_mnt_idmap, dentry, cachefiles_xattr_cache,
-				   buf, len, 0);
+	if (ret =3D=3D 0) {
+		ret =3D mnt_want_write(volume->cache->mnt);
+		if (ret =3D=3D 0) {
+			ret =3D vfs_setxattr(&nop_mnt_idmap, dentry,
+					   cachefiles_xattr_cache,
+					   buf, len, 0);
+			mnt_drop_write(volume->cache->mnt);
+		}
+	}
 	if (ret < 0) {
 		trace_cachefiles_vfs_error(NULL, d_inode(dentry), ret,
 					   cachefiles_trace_setxattr_error);


