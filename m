Return-Path: <linux-fsdevel+bounces-19990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336A8CBD1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465511F22BC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9657CA2;
	Wed, 22 May 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="f8FsAwll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4157F7F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367150; cv=none; b=A0gnOMi/S8WVWjXzNtd3ofoiIFSLhaMFmJKcnstdjKJwr9tRG+Y+LQAcMTOc9qfdYj9tj+w9R8FNTw15gfCEx9KkYtfDN8t3DjpESjOfpcYsIVFq6LDJM8L5sGvaRHisT7AMrM6pldd2q6Qvd1eNfTHwGSY76KhVhHdlWRjoFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367150; c=relaxed/simple;
	bh=qTmJPEAfjcIFSs6KpQoShXrrxCehuedAas+YJzieai4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3FRJB7mIVwyjzEpwVFPa/cAdXWAkRRlKSlPppO2Vem9B0V6jAKyUC4qHHEYf92Ph/f7XYQtcyJww4XQfHPYrFVHB8QqOmAFJOzn3idOoIQoejV+rfwUTA6yi7MW452XyUrk4o5YRvnSaB4gxj+ZlIDSIs/cm4C/GbmI5w9BlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=f8FsAwll; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=qVHvG27pLONLMH
	a1UvYpmlv58sgPWsAaCFuVRWq3EO8=; b=f8FsAwllsYFmoqNA7vWctlNe7AuGFl
	tJH5JuSUCu5Wbwf8GksztG3Ep9pEwpIy29E9MECw8nuq7AxROt5zdbZ6+Gzhvq+B
	UeY6exUooKiwWHdwbg/y4RMpfmz/MyhJWWEEWDxSvLFefOOfkO6Ni4hWLNSqqiJX
	t082N4dF9U+PcobDkIG7x4SWMOWEfckU/Z2C3IK2zVIm30o/W8nya/XldJP5tyDk
	8O9LsdyzCkIj76tvIpVHzitDwiMk5cg7exhsgg6ZRRxaumP89B24kpsZGmHRY6rF
	WTbsKz/XBpKTSytzqaFABo6e4Kfl7xNDUuZ/jglz9fuwjYsSrC3YVInQ==
Received: (qmail 635703 invoked from network); 22 May 2024 10:39:00 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 May 2024 10:39:00 +0200
X-UD-Smtp-Session: l3s3148p1@ptyv3QYZQusujntm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: ignore auto and noauto options if given
Date: Wed, 22 May 2024 10:38:51 +0200
Message-Id: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'noauto' and 'auto' options were missed when migrating to the new
mount API. As a result, users with these in their fstab mount options
are now unable to mount debugfs filesystems, as they'll receive an
"Unknown parameter" error.

This restores the old behaviour of ignoring noauto and auto if they're
given.

Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

With current top-of-tree, debugfs remained empty on my boards triggering
the message "debugfs: Unknown parameter 'auto'". I applied a similar fix
which CIFS got and largely reused the commit message from 19d51588125f
("cifs: ignore auto and noauto options if given").

Given the comment in debugfs_parse_param(), I am not sure if this patch
is a complete fix or if there are more options to be ignored. This patch
makes it work for me(tm), however.

From my light research, tracefs (which was converted to new mount API
together with debugfs) doesn't need the same fixing. But I am not
super-sure about that.

Looking forward to comments.


 fs/debugfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index dc51df0b118d..915f0b618486 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -89,12 +89,14 @@ enum {
 	Opt_uid,
 	Opt_gid,
 	Opt_mode,
+	Opt_ignore,
 };
 
 static const struct fs_parameter_spec debugfs_param_specs[] = {
 	fsparam_u32	("gid",		Opt_gid),
 	fsparam_u32oct	("mode",	Opt_mode),
 	fsparam_u32	("uid",		Opt_uid),
+	fsparam_flag_no	("auto",	Opt_ignore),
 	{}
 };
 
-- 
2.39.2


