Return-Path: <linux-fsdevel+bounces-35280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A49D35A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ABAB2136D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A617625C;
	Wed, 20 Nov 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YaRdoGOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5208615A;
	Wed, 20 Nov 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092055; cv=none; b=hONcz1f1nLmd7NSLAq8HFuSj6ufUoBfvnAU4Bws3uVBfpoAypHrBSHba5cEfllk3m/mfj81zn/2pjc1aoTyuH2Ynd0W9gBt1DOJYjp0I0IlJWUDDeyPcWjxdT1Fu5Iz7sg6QJZ684VWC6txRiEdlqmLwkPSgvjRme6i0CymdXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092055; c=relaxed/simple;
	bh=Ui3ctbnKKRdOImumJ4A3TJT2obyL1ylkW3xkwgNY7NU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bS5wwl9mgJAMcajPx85QtILu/0b5dH05A3HS0HEnK8rqmnk2MnNVCoXdWi+j9/mzKq8yx8dmFtN32GkkIWdAXcNi2OarmN5NX0r6FvPSlULwjMuwZaagCkEkTFF6ai8yIIc7dE3xirANhWBzZiHMw1kmDdRra5qWl9ehF0dOSq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YaRdoGOn; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732092048; bh=H9Y1oBLqHBrIdDkJYdX6Ga8AnpCl7ourwR5hxF0QsUI=;
	h=From:To:Cc:Subject:Date;
	b=YaRdoGOn6TPBsED4jNlVteL4NC1RBTbhiL/8emxQ61nU0tV4YSuiyzKvindvlidKu
	 G+2lrWgzsLFL742Ow9SHjAI0wLsKhfgOhKavaDrrqN6ax/MVAClgDd17IoPoFTNmmJ
	 1Lh1vEx8+btIBITkFOz70AeFb5lkmdkEIwmgDUO0=
Received: from archlinux-sandisk.localdomain ([218.95.110.191])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id A2EAEE34; Wed, 20 Nov 2024 16:40:46 +0800
X-QQ-mid: xmsmtpt1732092046t0uad8frp
Message-ID: <tencent_79E5C40F0E9E179868A209952556B053C206@qq.com>
X-QQ-XMAILINFO: M9J3/gYsWGfr80NJ+ti6rl1M1uxoROc9GFuJxt/tf5ma6Z6aBW52ok7P6sEgbc
	 QWWXfYWN4IwPgggaZghuhbIKmAFCa7WWISi5H/+HELEwsFambNpcsAz74lC13Z4l5EHUN3fzXSVM
	 /V74K2bJKLM0lSYyFPBnQ9kIc8m68DAclUJe8swuG8fDyKqDRgQOx7f8hHTAbF0p3lRIUduEj3jn
	 YTFnCeTRVf5vdCU67j8xJLjVkb1VA95Xb0Ru8dAz94tXoETLJzYR/S9DoLL2/NTP/de0wI+dG/U8
	 USML1nY+DKg7Xwc/yXri2hUQXSAYwBqh8iEsN6WBQw7RD7OSYWw7jL4G/9JFEouLWz0Tc5G3OAKY
	 T+4culshWcKIgaAxk35WlksXqbVqkNhCYGQF/bChB9H/D3iLTJQKeuhEy3085mxpwGj2cUprTTfg
	 AWP0CY3xjEUuZPHNZt0zm5A7m7jYrih0tmvlvGHNLjVs2AZIHSNiw4+RVmoCzEBPaPLDLSfarwXG
	 qG5bBt4jSQxu73nfFoPl5oU2rpxH2aClJSGEY0RpfIoxK22sVK8uuR3Ub0HD9jI0VUXMrtuT7Yx7
	 R1bfmp8fyy3felYU04oQgoGtIBONGlKUKaPYwGOoqPp+bE+GXT3Z8gzHvVquD6+O5IPB0+3DQdY4
	 M3cEehL6mIt+qQxuD07qI3lKLt1dVtJ6tiLWi8enam46V6Toc9s/sQcbbvKol4qkyBJfONzrU79w
	 hp6pdQPJ0Zz7QHHn5lBDwR1zAKoMwwBSNGNbW0E+bytnAyJa5C0PE+dM5bnn5qVRX/caMuIKCVO4
	 fmzvYCv4n9yPOXX0JNGZ/TW3Z+FBqshQJhvdCHr4Hq9jhg4F5dF+hhBzdfRN8B1xtRcdQXOxONUr
	 BoYvaaafam4G3MtXS6F0aQEiqFXmFpqM/7z2DrcmbA3rk60GuDModSIYLcAKVsEHwhyVoRkioRM4
	 Ix7lmM6Pg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Jiale Yang <295107659@qq.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiale Yang <295107659@qq.com>
Subject: [PATCH 2/2] fs/fuse: Keep variables in fuse_i.h consistent with those in inode.c
Date: Wed, 20 Nov 2024 16:40:13 +0800
X-OQ-MSGID: <20241120084013.1990-1-295107659@qq.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A similar patch to the previous one. Change 'unsigned's to 'unsigned int's,
to keep these extern variables consistent with their declarations in
inode.c.

Signed-off-by: Jiale Yang <295107659@qq.com>
---
 fs/fuse/fuse_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 74744c6f2..7f761c087 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -54,8 +54,8 @@ extern struct list_head fuse_conn_list;
 extern struct mutex fuse_mutex;
 
 /** Module parameters */
-extern unsigned max_user_bgreq;
-extern unsigned max_user_congthresh;
+extern unsigned int max_user_bgreq;
+extern unsigned int max_user_congthresh;
 
 /* One forget request */
 struct fuse_forget_link {
-- 
2.47.0


