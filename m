Return-Path: <linux-fsdevel+bounces-33542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24069B9DA2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 08:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D98DB21BB3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C799158862;
	Sat,  2 Nov 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AuWhRiTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C778289;
	Sat,  2 Nov 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532712; cv=none; b=eB6TH/kn1AdBiU5v4HV/ZWHlOOBbRj4prBBvKia5GSUTDnfF7KEupELI/GxVC+yqKiExB8LXY0gWQnxi4zLOZ4nh2be0AHsXPMM69UVogroT8w7QXgtojr3QO7WWaETFpgWqi+D+mEveZydWCDK1eicP0ntxyEcLb1EFUwPxfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532712; c=relaxed/simple;
	bh=tQsnmqXW2K56L9+z+oxlf76cDjO82I5BaJt0mYZtnFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhZymxvNZLxnP7zFmbcHfaJs9hZhO9a1awRNB46egdG85GDJTcxTRLtxTrMfai/Pe2fmtlqeYI+ppS9VV2yOeSNnOc88gQXEhngAOMUJnJPqyn9WEOqSu2ymLAdRPJR3WJVr9VoBfzxUpKsUdslb5LPGpoGyGhbXAkmPFwYZ5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AuWhRiTB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ehBlgSNmphaRaQWd8qdZFfTUDathgqXFkHwLaDfH6SU=; b=AuWhRiTBnZDeOy8WrMRhSSryoY
	53S5iG0EvqNonTlG8PKexHPx4fVR0qHNviIaRXkPsSGsX0hdxmJdkfZ0dNsybk/wi/gEBnGQ6ji2L
	kCFHnErGLSFGi2CjyfCURwRIuDfWNL8Dt8PHp6lQhSBtus+9aWlbqFxICRRiPGk5BncAn8MKEd/mN
	hEF20MWhi0dvfxAfEh+EYwsHCVyN9U6pM1v1+9ODgtRQrFfewx95gWB5mk5TDv0E6A5zTZrbBFryV
	z0JO7mfLxbUx6tw8Hgrh9b59tCUJ6pWQk7eUzDAFyxxpzicgmqN3EePe/14TKJBptpCBtDoeMriVL
	n+D9BB7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t78bt-0000000AJFD-2lOq;
	Sat, 02 Nov 2024 07:31:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	io-uring@vger.kernel.org,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 04/13] io_[gs]etxattr_prep(): just use getname()
Date: Sat,  2 Nov 2024 07:31:40 +0000
Message-ID: <20241102073149.2457240-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102073149.2457240-1-viro@zeniv.linux.org.uk>
References: <20241102072834.GQ1350452@ZenIV>
 <20241102073149.2457240-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

getname_flags(pathname, LOOKUP_FOLLOW) is obviously bogus - following
trailing symlinks has no impact on how to copy the pathname from userland...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 io_uring/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index 4b68c282c91a..967c5d8da061 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -96,7 +96,7 @@ int io_getxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
 
-	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
+	ix->filename = getname(path);
 	if (IS_ERR(ix->filename)) {
 		ret = PTR_ERR(ix->filename);
 		ix->filename = NULL;
@@ -189,7 +189,7 @@ int io_setxattr_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 
 	path = u64_to_user_ptr(READ_ONCE(sqe->addr3));
 
-	ix->filename = getname_flags(path, LOOKUP_FOLLOW);
+	ix->filename = getname(path);
 	if (IS_ERR(ix->filename)) {
 		ret = PTR_ERR(ix->filename);
 		ix->filename = NULL;
-- 
2.39.5


