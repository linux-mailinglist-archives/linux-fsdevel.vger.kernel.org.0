Return-Path: <linux-fsdevel+bounces-13612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6D6871F30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 13:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC3D1C2503E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4C5CDD1;
	Tue,  5 Mar 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtvVEKGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E65C91C;
	Tue,  5 Mar 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641662; cv=none; b=CoxyBGxIrgKQWSEXElZjzYQwGuvcmLQf3ao0Y9EW/JwV60Cvzl4bDqtrwCqrkOB3ozuftPPGLz4fs1W3/NK48gehUqx6hM6+gvCwIbVHE1BAO160giN5J9Fk4Ia8WM0TYlVsvMaV5d762KR1Vs8KWnvgKLkBzv2CfCrHp3fTJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641662; c=relaxed/simple;
	bh=9Hv0NhDd5yJ2rN0EquGuHE0G93tjK43hLajBYWiBYns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu6sGvcXGS4hHQjfqlInF55v2ugxT6kq4+K7b/YeHcPat5qAMvLVtjYAfIdOoNFu5Tkh52/HmCIxmNkQpeFLMnXQAuq431ZRPl+QQgxOl8/5o86/ud740+JpTGOMJRT+cz0ETqpi3GRV6zcHrv6Hh6fBCVeqFB5TWeQyYVySLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtvVEKGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8FC43390;
	Tue,  5 Mar 2024 12:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709641661;
	bh=9Hv0NhDd5yJ2rN0EquGuHE0G93tjK43hLajBYWiBYns=;
	h=From:To:Cc:Subject:Date:From;
	b=VtvVEKGhn0ktSseMhbKlABxyzsDGI00ZprGz2oNogIMoDbc77/2pwNo2P5YUE8jEs
	 5pdBQGkgR+9zB37m8ZDXOHGOSMB1V1fVEr7klH6Xe+0ROv6/Eqx5gxKdsmLLjst5Vm
	 +Xp7QNSZCS/4voxzoc4esVKF92b1PYeFMInK1HNpS5SsdRpu7zDHwf1EijUtlG14sV
	 5AF93MQV0c8pUKBdp6v0n5Yq8e3feRy5T8S0YfjZTBhOKTXp7Vumicr6EgsUnAt/Fy
	 cQMJzmgoFU+3tReEwBJg6OmH7zwx4STR5jKh5tBbZDMR21pQLl/m+QLstHw/fSlXy0
	 wVgqULvZu0bfw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
Date: Tue,  5 Mar 2024 13:27:06 +0100
Message-ID: <20240305-effekt-luftzug-51913178f6cd@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=brauner@kernel.org; h=from:subject:message-id; bh=9Hv0NhDd5yJ2rN0EquGuHE0G93tjK43hLajBYWiBYns=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+59/W31H893LfGUGB9MXhRwPefne3Y1d1inio3R18p 6UvKym3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL2Xgz/C1f9XX31XhrHpDO6 91IkjJU3Xn3ZWNh7r1D5yP37y72PJDP8U4988NZ/1+bMmByhTf49ht/kPGZ9m1UT1yYyR5/pzEp hPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
that does a racy query-size+allocate-buffer+retrieve-data. It is used by
EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
where 9p returned values that amount to allocating about 8000GB worth of
memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
no reason to allow getting xattr values that are larger than
XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
values and nothing currently goes beyond that limit afaict. Let it check
for that and reject requests that are larger than that.

Link: https://lore.kernel.org/r/ZeXcQmHWcYvfCR93@do-x1extreme [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09d927603433..a53c930e3018 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -395,6 +395,9 @@ vfs_getxattr_alloc(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (error < 0)
 		return error;
 
+	if (error > XATTR_SIZE_MAX)
+		return -E2BIG;
+
 	if (!value || (error > xattr_size)) {
 		value = krealloc(*xattr_value, error + 1, flags);
 		if (!value)
-- 
2.43.0


