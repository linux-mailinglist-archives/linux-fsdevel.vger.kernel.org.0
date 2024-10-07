Return-Path: <linux-fsdevel+bounces-31176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB435992CAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562AC1F23EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7D1D4173;
	Mon,  7 Oct 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="mCoRwMsC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636E1D3644;
	Mon,  7 Oct 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306535; cv=none; b=GQdLhKstwFiAaVwLtQimqw7s+A9e34OZxbwlV/QbBZt7TQg69kcE6KZFdh0ACTMmBuizKEtTOiW0TrtBiK2FTEMTkGVg4cL1o7ffnBQsv6tOo0bOHw3Dpc4SGzwQ2pHlAXAqPIlcE4yllPEIJQb12KwOZEB8c9UmsKoveKHbdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306535; c=relaxed/simple;
	bh=Hwn+L+H96EJQ6fbu74oOsk0yt1bHFdhq8Aneq+L/aRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRNhjvWVegXM89boAolFYycDBSHyWKkZtyqYLnIzzjwFVdMKY66OJH9UuY/vAqMmw1Y17Zz0+RD38x912NRw6Zh2tOTdJ2yIh8F0iHC7QsuEFICB1ENDq+3UFGSF/M5OgUDaTg/pCAQVb0772O/ANzxhEGEhhREHa/h1IxV3TU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=mCoRwMsC; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1728306533;
	bh=YjS8pOHAMAb3lFxDk/ag9Aaz6T0IQGKpkIr0d1Ynq34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCoRwMsCPg0+MVQJ+sI5hryZA7UL982qDRqI5yEclIPiyRC4TaFYgNR7uMktIzsg4
	 XW9AxBauMiQF4HfOgCP7blZ2H7zxjm2JcFRK22JYoTXqY6NuWxBvUhvNhxQUnHdJ9b
	 k/oxGeE9gVD8YKlZBEkvKQD1FgeNuLslVZhrU6nw=
Received: from stargazer.. (unknown [113.200.174.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 858D91A41FF;
	Mon,  7 Oct 2024 09:08:51 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Miao Wang <shankerwangmiao@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] vfs: Make sure {statx,fstatat}(..., AT_EMPTY_PATH | ..., NULL, ...) behave as (..., AT_EMPTY_PATH | ..., "", ...)
Date: Mon,  7 Oct 2024 21:08:23 +0800
Message-ID: <20241007130825.10326-3-xry111@xry111.site>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007130825.10326-1-xry111@xry111.site>
References: <20241007130825.10326-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've supported {statx,fstatat}(real_fd, NULL, AT_EMPTY_PATH, ...) since
Linux 6.11 for better performance.  However there are other cases, for
example using AT_FDCWD as the fd or having AT_SYMLINK_NOFOLLOW in flags,
not covered by the fast path.  While it may be impossible, too
difficult, or not very beneficial to optimize these cases, we should
still turn NULL into "" for them in the slow path to make the API easier
to be documented and used.

Fixes: 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index ed9d4fd8ba2c..5d1b51c23c62 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -337,8 +337,11 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	flags &= ~AT_NO_AUTOMOUNT;
 	if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
 		return vfs_fstat(dfd, stat);
+	else if ((flags & AT_EMPTY_PATH) && !filename)
+		name = getname_kernel("");
+	else
+		name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
 
-	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags));
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);
 	putname(name);
 
@@ -791,8 +794,11 @@ SYSCALL_DEFINE5(statx,
 	lflags = flags & ~(AT_NO_AUTOMOUNT | AT_STATX_SYNC_TYPE);
 	if (lflags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
 		return do_statx_fd(dfd, flags & ~AT_NO_AUTOMOUNT, mask, buffer);
+	else if ((lflags & AT_EMPTY_PATH) && !filename)
+		name = getname_kernel("");
+	else
+		name = getname_flags(filename, getname_statx_lookup_flags(flags));
 
-	name = getname_flags(filename, getname_statx_lookup_flags(flags));
 	ret = do_statx(dfd, name, flags, mask, buffer);
 	putname(name);
 
-- 
2.46.2


