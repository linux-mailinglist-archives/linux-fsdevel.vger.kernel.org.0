Return-Path: <linux-fsdevel+bounces-29653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855297BDC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3A9286A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893E18C916;
	Wed, 18 Sep 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMl5jAx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E318B494;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668651; cv=none; b=dvu5uHn/yw0cHBkSHmTZqySPqMRbO3kprAlzY/m58rcyOtzF75ol62lUSU17JrWNLlku50h8kJ76u+r8n6yhAy8PVxZJeGE4TZuIaTYyhzK8FiO+HQ3f7x7GNqgVZoWkaVZgTIl2IF1MTlt0VoMNVR+pNrDdaVKx658N0UrGPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668651; c=relaxed/simple;
	bh=9eGxhGLklk3aCZs4scbt0MeHs5Y4XdfBzockE4wWNYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLhclxb7Qd1Zke2uaybCYs3HGDbC5z4g1Zv2TFj4CA5f/A8xj9heQoMGZlRtHaisaxeMdLaA4lMcsXNAjpKY27Mwy7c0uPEMqgQj8rN3uUdGqMatRjbE42V705vOEmBjkAUHpxJ43AJwQQdmPcXkm6KdNv59CtHNIrswNEcknRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMl5jAx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F2CAC4CEC3;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668651;
	bh=9eGxhGLklk3aCZs4scbt0MeHs5Y4XdfBzockE4wWNYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YMl5jAx73wRFU75A1VohTY7vT+NE2yKXmDs3PcbY1pR+JgXy1O5UXgBapmyVBw+u3
	 /HS5MFx+jZDPykTZANilX665+gjP7n15pgSwAk3gTbi/+afSXJC+Q59GH+rJ5q2Cnt
	 UkMHzJQ4O9iSh3w6xlVM2eOmVeittJQwj9db7SDaQTaHx/mTp3nRmU1499Kmx55cD4
	 wa3SN3GS0asTon54cXlvlTXj4HOzGDh59IpScvrz4r8EeKBDGOy5BRMixsQSeUvk6o
	 QiWqAn2ZFSpbX8XlTlCP5xP6YdbVqSgnpRPq4bg0Kix6YRbGWn5O+rlwfceWvH3Jr8
	 379URkLzSW2Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71860CCD1B3;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:10:39 +0800
Subject: [PATCH v5.15-v5.10 3/4] stat: use vfs_empty_path() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-15-y-v1-3-5afb4401ddbe@gmail.com>
References: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=bCFrxJOZ1JlvAjj2Q1DjyhrDQOgyZ9D8tBLlcgyrtKc=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t9oR0f0W5q/TKDHi8vrrYol5brh4IWMqGm/o
 CrztW+Vov+JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurfaAAKCRCwMePKe/7Z
 bjMoD/43wQkEksXRWesOQYsMnncO3tApr7WqjPjqHbkVdYflvX4RqGPyyLaxhy2WyD0s0y/2G/O
 /1P6hAlr6ZK5u/g0aGB6iMmVAI6zxJS+nR+6GP2rd16VpVB1Te+0r++QPtMUg85OgNgYx+HUI5M
 xshcVyMPmb+UXgbZ3FjkvZQ5q99aK7C2fEAHZ9XWvc+VIsO02yYVFDC7XShkwPea96oe9zzBTlJ
 FRifgVefZ0ehZEI0nKzXost8c7xCs3wEHOFs5Kod+9OCdtrqnc9WkItPMME1pzXKWeF0t3cxx+/
 qkS6k1j9+kEuzYt44X2wsvpwkb1CYoyjulmGKoqBEd8LsDrR/o85syu9fRvlD8YhbAqFIift/S5
 BjOM88WQpdkrwyH5TTek7l9rb/AoqTH329CgkF+SLw4YFsvCOsoByzpQEQ1oGY9quajjiYk54Au
 fNlTV1Kwn+aghE0qz96FLBDenXAUE8bhSfrJi7NAfki/DTsHjtNjc0iGv+HcyWQi88F9or5Y9GZ
 Cmdi2pDZf4gAgE5/YpQIYLu7iyS1yuDlaaUkXMwPgVd+EPXynexZYkx90fmBkDkrWc4HNLRrfpc
 sxMKvd70OZ0ZA/YX3KmNhC2GN0zce8TQemlDGW8EdA6/9xVD614cJcrqZIvqrv7CAn/1vOU2JvS
 objHa336Dvmj1pA==
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

Cc: <stable@vger.kernel.org> # 5.10.x-5.15.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 9669f3268286..b8faa3f4b046 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -246,16 +246,9 @@ int vfs_fstatat(int dfd, const char __user *filename,
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



