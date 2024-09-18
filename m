Return-Path: <linux-fsdevel+bounces-29647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DABC97BD91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DB71F22858
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FB18B47D;
	Wed, 18 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4hc1EkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D518C01B;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668109; cv=none; b=rncC4Q3kg8tMG7UATH2+YRIyfhtAsobPatPNLCxmoHHA1EE/BeDiEEIZz0TRf1l72JhlooMkVLwKl7l9N8Hw/+DblLE8LVRroNn5ExZMKMI3d4D8/6c9/mP8uBYRAuUqGBjB5JvSMgk09AJHCoMh1us6ikcOFChtbnoshRNjs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668109; c=relaxed/simple;
	bh=jYUgZE0B+hry+WMznovQEaTk5Msn5iTgnUNz7MAXlcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMLEzD3k3Yqw+WIwTZraxypoYiM6vfE02p7dA0Vq9XSZ41jo5BX3n3suYJJt05Y2AgR1xllurDQ65VBXdnwFiE3MiJq1bVuQnZj05jYX4HYzhnrYVcWVjsS5r0CrCBpyyMa66q3Cg2ABaXyilvaRZIbzVFDBqaEorpOqbNJ6hBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4hc1EkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454BFC4CEC3;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668109;
	bh=jYUgZE0B+hry+WMznovQEaTk5Msn5iTgnUNz7MAXlcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q4hc1EkZ3+3HLkrplyQabfNim6Jxi6DkuO/8aypbu/0SlAbX4tZXufiJ9DnjrRoke
	 +hINZc8dHVQg0SvqsX0MmqrzRyx7V5H+uBL4t21khfJSwOHml6cNH3P64IHAYrpnqD
	 w0XFz41U7K8vBGnjW6anQpxPmS0Of4WQhUQwoXDZ15DrMmSx8qVjT8zFzE0U/MdWiB
	 x+NrP6iq7F3v6zRPvSNdWKLTKeL2OxYJ/N+KQAdZd8Rrxylnl5EYW80IxuCSxbdfnm
	 paLfrLST7y6fGmP1be9XwVpkBIK55tzDOXOjsGEzd7V+gzQfdRtgOozMn4WNo1Oc9F
	 X8MYDkQCnBNPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C62ACCD1A6;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:01:20 +0800
Subject: [PATCH v6.10 2/3] stat: use vfs_empty_path() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-10-y-v1-2-8364a071074f@gmail.com>
References: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=hecPtMltr78jhtb4nj3TeVbjNkGHnWb3+2dvs/Q+DnI=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t1KDydVEMBXgf20UHmTeiEkJTjTofPNsYYY6
 xA6ga5UO8aJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdSgAKCRCwMePKe/7Z
 bu7YD/9f8RWBQdTZyiyN8jJyNErSuesootBkz6PgMK1350VVrO/eq0FQKY9cWQHFXmptBjbU+30
 wd9Mao5/rf19dWxnvQQkKG1UAnVZ9GWqmBmLb/PSnd8EZr3zzWNGtg9vo+pyKKBKvk008mIect9
 uM6c9oYbuGlvmOUcS90i7qRJyUL+81uoEihvq0sFonNSvNy7fHzxSfNl9GAzgPHGeBzIKyD6VM4
 WAj20j1OiP37XdqAxP7zWPyM8grfdCN4mYAX24IfTkuiJ5JwdXD7bqf+dGXmY2E0dAKdhcvBTrp
 v25ROemy1L5A2KXMo3WDQV+29z6lT/MtgxT4KtSzJOUlNgbReg5+cHieq2ekmToBZphFTLhxuwE
 6bgQmg2OVeLRlGg0T/eJQ0DJvqtk3LuChPHrBBA7bgOzcKCO0hJ4GCE8NJfxt5QBFW+j3vKN1Cf
 9BkNWsrGn734862o2f3vEXZKgYEM9SreP0mqKp6fcuzejNCJ5YtbAPc7Yy06fWgxqBnzcgs6SfJ
 kxE9v2+zU+ObnmMjjzzRAVmlF2+GUjeSbUGdqOJhc0kPk6IV9VkrapodaYxFmp2Qg6TTy3HXCO2
 K6NAsR2D3wDoVd9w8dBepfsQ4X61noaqxKw3846s6iL4OyRkX4AwY0pYloKdAuZ5vZOxjL5Wj6D
 n7t4Czt2gyKJyzg==
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

Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 fs/stat.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 70bd3e888cfa..0e8558f9c0b3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -289,16 +289,8 @@ int vfs_fstatat(int dfd, const char __user *filename,
 	 * If AT_EMPTY_PATH is set, we expect the common case to be that
 	 * empty path, and avoid doing all the extra pathname work.
 	 */
-	if (dfd >= 0 && flags == AT_EMPTY_PATH) {
-		char c;
-
-		ret = get_user(c, filename);
-		if (unlikely(ret))
-			return ret;
-
-		if (likely(!c))
-			return vfs_fstat(dfd, stat);
-	}
+	if (flags == AT_EMPTY_PATH && vfs_empty_path(dfd, filename))
+		return vfs_fstat(dfd, stat);
 
 	name = getname_flags(filename, getname_statx_lookup_flags(statx_flags), NULL);
 	ret = vfs_statx(dfd, name, statx_flags, stat, STATX_BASIC_STATS);

-- 
2.43.0



