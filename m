Return-Path: <linux-fsdevel+bounces-46104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2AA82A23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAF79A288F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B726AAA3;
	Wed,  9 Apr 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iy1ZC5Lt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762F266EE2;
	Wed,  9 Apr 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210862; cv=none; b=gqQg53rYN//mhQHbGLBufvc5gQu8E1CmnV3gCiaVqscqywaqSHjyRRY0QHD65db1RSRCdWGkTHFv/v/CgO8zyZqxoLhdVHQzC8qlxOlQSudBW4ytgCknxqMGfMlNCqq4jgSpM/YzoCZkJPUcWC3XeUOPrfxnyWf45E9xnEUZcjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210862; c=relaxed/simple;
	bh=fMDoY8ee2pXnS8Dw18Q0OcUjEYyFmG9NC+Qch2lQWCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qythytpzi08P0s0TqRUImVECIsWbcYyEtQdBsVBsskFrVanKYtwUB8u4mKG98zlYjAeoEZsLqtZxtjqw1jsN70B3sxInp73OykdnuCY0qGMNhzfL8s+Bek8jRfTzca3ttQQQe/q3/1gkCWdJ+llIOIUXKKLz8JBq2mSV7CJZI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iy1ZC5Lt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gTwuFNmtqnHIRgvVLsZLNjX7p2roYlt+cuvH6TzFv0Y=; b=iy1ZC5LteO2FtEIBZEALLeGi8G
	tC4TqL/owFmKmTq3psa7w2KadEpzsOo5QsZlxIB41odsB3EwZXTyeYKUkhFu0JQSA1tZlOudQR9za
	IAAMp1Laoq8C6ogBQIOhVvGmdntuCPSDG3sUbtdIJD1zkHek8nFzhyYfxhJr+ROtaSzLP6OLktG5j
	DVsDEwyF9ZpJWeVYrK//CqtQJtZ3xhULCQtH8pbMfNrauiK9CRaMkismPTu6+WLDr48Uzga6RW2Cn
	4phQdelACspP9jCgTt2kUusbTdL6y25gtcRMjfSlM6kbII46A6do6209XDN/95RcdIOoz6hl82ilC
	fLLzqXRg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u2WvA-00EBVR-QF; Wed, 09 Apr 2025 17:00:57 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 09 Apr 2025 12:00:43 -0300
Subject: [PATCH 3/3] ovl: Enable support for casefold filesystems
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-tonyk-overlayfs-v1-3-3991616fe9a3@igalia.com>
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Enable support for casefold filesystems in overlayfs.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/params.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 459e8bddf1777c12c9fa0bdfc150e2ea22eaafc3..28a660f09cff2573c648a00363c153be3903aa5b 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -289,7 +289,7 @@ static int ovl_mount_dir_check(struct fs_context *fc, const struct path *path,
 	 * failures.
 	 */
 	if (sb_has_encoding(path->mnt->mnt_sb))
-		return invalfc(fc, "case-insensitive capable filesystem on %s not supported", name);
+		ovl->casefold = true;
 
 	if (ovl_dentry_weird(path->dentry, ovl))
 		return invalfc(fc, "filesystem on %s not supported", name);

-- 
2.49.0


