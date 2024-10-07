Return-Path: <linux-fsdevel+bounces-31175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CA0992CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0237B231C6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA801D3621;
	Mon,  7 Oct 2024 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="O6SQX4Z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3633118BC14;
	Mon,  7 Oct 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306532; cv=none; b=EIvTiO+SqxBM1Rl1U74/2VZ5lLqGEUrx6oZxeKaNv6uQ4be2zV2wUYfWJTYNESoB4GRpdJlUIkoMpV9rC89NgscpzKAX/e6LYsIpbNxsQqQUp4whLo6GikAQiwjeflctOa8md5qZbczHDfihZB6FR2zSxGrqOAbM3hhJKshT5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306532; c=relaxed/simple;
	bh=KflhzfhUgY57tKVXRMr3jE4oHSBqoCo9AU2kwIcsV5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhLAGasPbkcuH1TZ42zM0MWSFf5NGapxQJ467Njmb/6I93C8+uzyJpCWdtxcx45DtqhZEUtAjIn4aaErjO4aUhlqM6Z+E1PidGW/5gOBIGOqF2KhMC2ravPfemfWX/oVUegvmnHBuOxwyW3DbP+z3DjqbBHSnELGWtwZme8RBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=O6SQX4Z3; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1728306530;
	bh=wNWpuAHmz1SOTelz1pgpdf/5OLCVcYGot+p8wJ9AHcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6SQX4Z3teX2lnMeGa08CfdeLI5evFvrfH3oikbwIoHEgMfoeo1pWyd8oALTFYSNd
	 CrafurULeAQb2ml8bhbP1iy3HIA/5LKmiW6Cm9IrmmJQAfGqjRdHCPN9QLtb5VmZmG
	 G2ppuXR2iNouz99u3Xdmh+9okbJ31RlnzW4LvEZ8=
Received: from stargazer.. (unknown [113.200.174.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BA6B91A41FE;
	Mon,  7 Oct 2024 09:08:48 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Miao Wang <shankerwangmiao@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] vfs: support fstatat(..., NULL, AT_EMPTY_PATH | AT_NO_AUTOMOUNT, ...)
Date: Mon,  7 Oct 2024 21:08:22 +0800
Message-ID: <20241007130825.10326-2-xry111@xry111.site>
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

Since Linux 4.11 AT_NO_AUTOMOUNT is implied for fstatat.  So we should
support this like fstatat(..., NULL, AT_EMPTY_PATH, ...) for
consistency.  Also note that statx(..., NULL, AT_EMPTY_PATH |
AT_NO_AUTOMOUNT) is already supported.

Fixes: 27a2d0cb2f38 ("stat: use vfs_empty_path() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..ed9d4fd8ba2c 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -334,6 +334,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	 * If AT_EMPTY_PATH is set, we expect the common case to be that
 	 * empty path, and avoid doing all the extra pathname work.
 	 */
+	flags &= ~AT_NO_AUTOMOUNT;
 	if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
 		return vfs_fstat(dfd, stat);
 
-- 
2.46.2


