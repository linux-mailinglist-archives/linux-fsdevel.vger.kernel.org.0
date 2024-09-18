Return-Path: <linux-fsdevel+bounces-29650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A9C97BDC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE281C21ED0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11D18C922;
	Wed, 18 Sep 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="havtT3UF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFF18B48D;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668651; cv=none; b=eRs/N1VZ6fYKFgSlKXCA4z1KeEpkqQ+ZaP+8UKLe/1Ci3AHQkSJfyFkacDdiFqi2MGWiX7uj7RU2BVJFjQKN0s5wJL73NJwB7uSFxjPt/rFW7RqmvogxdOrBU7OTs+L6awlMiZ4W+L3k7EmaEEeW7zMvZCumCprrJ5Ht1nGSDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668651; c=relaxed/simple;
	bh=COwTeI27/J7n7O3Msn2gtQ1KtMylFJM8w6EzpT5RgFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFfe8qP99TrP6GzLMeEJoaCqy3+KnEir7IhqK/SSONjkXgxUZ3u2cqvFafgdVwyAdXb1QVenicygrybIDwi2Q5q4YoW6rooP/rgpaBLQhAfQNmtpZOw3OVuAiYu05fJEASGtBxw0mwUOgprUB/kzVcuy0HxPLBhwiUG4CqUyjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=havtT3UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 783E5C4CECF;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668651;
	bh=COwTeI27/J7n7O3Msn2gtQ1KtMylFJM8w6EzpT5RgFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=havtT3UFG+wAAKgIDkXb+uGiFjzj71HKtr5QnWusRx9LYu0B8mBAutfPGM29ic0OA
	 GTrXRXVmqeOsierKvdpq/uiKiMkOyCKsxIJ48Mf7qreyEZMD9VBFuuY1F5ecGsdzR6
	 e1qDUBwIpnU8Vu3jwL3A8iw0+tAb3IGyydNjmYTqZIW/wH0xn+vq+BfPNaaMxTnmNB
	 1rAKiFzM3rke0ZCrsxzJHcczjH9zKQkokjvELLv0YcRFijkwiSKvaWCoPxPxdmpxzw
	 qhOVDiQOE3Q/bOvg4OtzgTHptlIfeXjRQAgRSTEb60OnkRJ4qIkhRhp/GS0W4FMkjW
	 THhIfMeQyapIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F85CCD1B1;
	Wed, 18 Sep 2024 14:10:51 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:10:38 +0800
Subject: [PATCH v5.15-v5.10 2/4] fs: new helper vfs_empty_path()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-15-y-v1-2-5afb4401ddbe@gmail.com>
References: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-15-y-v1-0-5afb4401ddbe@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=NNdeRdWR8oQ0NFsZXKcLndO0clVTPZKHtPgFAjQVi/A=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t9opLBl8Es3PPOAB3sh2DYnhurwkAcr8xbwd
 t0+ZmqsmmmJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurfaAAKCRCwMePKe/7Z
 bvZ/EACAsFifV4qsXKY44jmfyBeldyhGFRY5pwuMVHhdpCD6pudl286QKaFGcDxkhzx7XiDAF4m
 CxbYmME9OJ1WDbCcOWD4lIb3I/CIs7TO5MqfeChlVHE8Kusfegcj3TCJSVwOF3OWzNU7k7XhmpL
 NGNomlTBfjZfPFugUK88w66K6p64sHHs5XseQuLiIBcMg1X9NRbZ2ptYtNE/PSMflPZxOthJCua
 eRAr5bjrauavi7XFby692T4B3w7IhViG1fQLGU9lZBWLdVe47A/bH+gnc5eMVAofuDfsBS5OESD
 4VVRMQgt34Ws7IpRzrLc4aIHjetYl3348QjFD701IAUXLo9CDB4J4Ft0XKSMmjCIG1CZWWjEOKI
 b0IUt3V3JYykbK6po+qieno6bGCKAYtuhvKPyi+EW8zlm6sw9rQJmVrvhBrvfnv6yPAfG7faXsv
 Wwmriw34HtjMNaH4PONAzS6DBEi5gHI43nzsMOWcA1dolPn0/8VmHB3ch70aQro0VQQypIL5wa/
 ToLyiobwgGQEkDZdw1017gnyp77Do0zPnNu3AXw+9LUfz+Md53cc4MrBhkwn9cTrFR2TqEoWcKV
 p7eZ/cykC79iVs0B/1EACEpAFiGyZgR51cbNPMSWdy0TYWM99M7SrNjfWlhP8/aHf6v7bTGhXay
 KnBkJZWU31EDtRg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit 1bc6d44 upstream.

Make it possible to quickly check whether AT_EMPTY_PATH is valid.
Note, after some discussion we decided to also allow NULL to be passed
instead of requiring the empty string.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 5.10.x-5.15.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/fs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 27da89d0ed5a..6fe2ae89bba6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3736,4 +3736,21 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+static inline bool vfs_empty_path(int dfd, const char __user *path)
+{
+	char c;
+
+	if (dfd < 0)
+		return false;
+
+	/* We now allow NULL to be used for empty path. */
+	if (!path)
+		return true;
+
+	if (unlikely(get_user(c, path)))
+		return false;
+
+	return !c;
+}
+
 #endif /* _LINUX_FS_H */

-- 
2.43.0



