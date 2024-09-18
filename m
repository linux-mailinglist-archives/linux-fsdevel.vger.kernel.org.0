Return-Path: <linux-fsdevel+bounces-29657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B202297BDD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45BE1C22973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81018C901;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmogwCrs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98018A95D;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=GwZNWspiwG6Xj524ld9Eua4pWJLs1YnRRMXklVdU83/W44hz6n77g83vUTmqAqU3l84Lw5uSjrCm6OGdUOxaQfE9IJyqGLryOYIrY+g/lXjDNKGLaiBL1xduoGI/bT80ZzLlTD/UvNlYU2WkPzHRPY4iPfDJ3t75quIdlhfgW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=v7U4ypH/Ac5Ke2FaytFoW3LPOQ2F1eTkTbZmllFXXB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Orumdy0SmtNVQSuGOokSpdIzCbxNMd+V9o+aWWjuEVZDZ4PA/5kkHT3jwk7mDl7PVVN6l0JIbNclaWbuRhifsmSA0bxfQwnJJBqSvSRuBk6xhS34IUxelsfKUzUbq81qWZ5dwcxMDrDKRzvf7ADVIki2+qLNu3Ra7EAoobSfFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmogwCrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29C72C4CED5;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=v7U4ypH/Ac5Ke2FaytFoW3LPOQ2F1eTkTbZmllFXXB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tmogwCrsFq/nofnU2pu7mgNa2VIfaM3HAd6asmqNJT2EwLwjm1sHbII6fQJFlD4yO
	 HrGHntH/AwxFy/SOMsf912+U2x4K0gB1FJX7eRFFnwHFqaH6INz8q0ihCheWXRQ4qB
	 prh/bkViSmSzgouqscRwaNZJXWjK+8Gr4srhgfCJeByVPiKoBrmIj2p+lN7tvDjQ8R
	 Wb8WSXSCw9W9uK3Lt50vu+s5IbXM126Ofboai2f0dQeEDFS0nqhXlRY3sziJJ9O3U4
	 dt5Jbzi3yHqjGoBiKq+3mCiAhjGs/qhmPwt0Dql2QIcgcwMAjcuWXbyDFzdgMr1vpu
	 cmEEyxCwtHYUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A27CCD1B3;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:24 +0800
Subject: [PATCH v5.4-v4.19 5/6] stat: use vfs_empty_path() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-5-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=lbbjfwVQwhBMaQKhLfEbF06OhcMU5I+9P48PRWXjV58=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/duEd97bWZSZWYr+0maaRO+Z57/o0I255hw
 /Y1wn2K5xyJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 blEwEAC2CZBFiARpq0BzXdbsmeSaU+++3T5LIlILiPQILqslb3Sd+tbvA8YUxRClYEU2lR1J8bu
 9O8+qcWfYXacbT1Lw+n3Vp7/66c65DG1vmPCoATC708HjRZCnn7qjgNIF3VItPEhEPIguAtHi/f
 UjUtlk/6KWijVnA/XpK9JrgHIFz/9pf1zehNZa+Plu88S84Wd4PUCO3e95ZxB6c7cHQE6HOjTds
 rUjO7q2MNWAmfc2AwWmxqtg5ZNVHPSp2jWmGTC/M9apZ/KNH7ahbuJn+W91piZW2GvVSuDXM61b
 NHAMpje2zaB+f2sHmqgsTG7QxFzINMq8cp4wB2W1QRPY/hoEVNoLbX18wzp6EjMAytQtEjsHyWW
 nLtBO8duQmz1Br0otDUNMJa6YZHHSy3EW51kByUOVWs3JA4kJ0yY7gzBtaQ2MtSn4X0vUCaF05D
 hou5nPJ5KmDiTtlfweaRVQbr2FA6qlbuW8rFwpHvoY1QTXu6axlMnIUfD45f6gwCLK3Dmcj2P1D
 3h/4ui+c+jbw58YgMy+j4d5u5F85XjGMXTXefUMnjunFI6cn2w5llp77i1vOjzSgKaiV9bnouQe
 2zbCIBOcG6xxRo2yWx034hPaRxHjtUBWe9/ETB46yjHmjTvy6U22A9EYYNuiUT+07fF4EhlyhOC
 sMM7S/UMDdINJWw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit 27a2d0c upstream.

Use the newly added helper for this.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 3ae958308e48..1aaa5d847db8 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -224,16 +224,9 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	 * If AT_EMPTY_PATH is set, we expect the common case to be that
 	 * empty path, and avoid doing all the extra pathname work.
 	 */
-	if (dfd >= 0 && flags == AT_EMPTY_PATH) {
-		char c;
+	if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+		return vfs_fstat(dfd, stat);
 
-		ret = get_user(c, filename);
-		if (unlikely(ret))
-			return ret;
-
-		if (likely(!c))
-			return vfs_fstat(dfd, stat);
-	}
 	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);
 }

-- 
2.43.0



