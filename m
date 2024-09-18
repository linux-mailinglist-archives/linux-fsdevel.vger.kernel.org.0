Return-Path: <linux-fsdevel+bounces-29645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8997BD8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB7328D43E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007318C92E;
	Wed, 18 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU/JALzQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CEB18C011;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668109; cv=none; b=K7liBriTQxcAwGaQOKhN29V2olzsHSEd5atRqfX1lhdarkxdNPUQCnUS61JNnwU/kAc64Y7fXLIkwt4ZqTmOKpv9vyg+wGy6ddtaRxeJjVJnIpPBlEqTiLuelGNDsjRCrcoUwqp2lkXsn7i4XPBYxtzEEXgBLUSvuE17ulBmj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668109; c=relaxed/simple;
	bh=XwWrkxXFbCDO4HGZO7lMIgPUXvVKDVNC/m/Lbc48u1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSdkad1kvfjaMJeu5NeYkjDYn7b+zR372gHh/G6B0DPsFxnuW0x3QBiUDeyoKWZvUcAgm/k5JeiQ9ClZLPp/12Z80VebsU2LXWLGgMFuX2Kf5UuLAVixGNhQsqm8xs3+WAyQZUDm5X6Qjr5ajhJKuHWYmycksHf/o/OHwsACj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU/JALzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E02C4CEC6;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668109;
	bh=XwWrkxXFbCDO4HGZO7lMIgPUXvVKDVNC/m/Lbc48u1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BU/JALzQhTmhu9djpPZ+TTZrr1U2PRhRrmdOq8iSXNtdEvzXLuCIp/goZUWZlfprZ
	 s+aKekVZ6tx9ZSaeX0CEB+2KXj632spgbbQhKcyEVL7SxqcCczXZNzzqou6lSeLOlk
	 Hfz3dNXPgyLD65QOV+t0b/7pe66xrrxVVjITwU0lN3UgbdIdmz6HSs9EMUWqGo03gW
	 zP/VF+64dMtZ+zWZD8lsqfqRaPJKAH8wcAeyNpjuX8ukZIMXRh2AYmScLIjEn/abdb
	 M3N1+lWssznR1Uug8rLuiRZzlaMxOOWBrzL9GhHczDiGx1AsN/q38Zu18dQ6GNMg7h
	 CNSkvpKAwtVNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E246CCD1A0;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:01:19 +0800
Subject: [PATCH v6.10 1/3] fs: new helper vfs_empty_path()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-10-y-v1-1-8364a071074f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=UKi5cKkDYLorcoPNPh8VgxFKz/KyskePZcWRS3ghFg0=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t1KULu5wqjoaobS1DoIbfuhiZbMceaA06Py/
 Gx0USf7Sq+JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdSgAKCRCwMePKe/7Z
 bgqID/9QaVYMKyEgINsB/9tIo+flZS42k3P9doDhzVYtrYYawV4PpZ7UI9+sS/5dmpNhyQ12t7n
 bKtMoG1veL9VVHM4gq+A4RVkHQPE9yFzFcvzH6o/f3HamoCDC27t+eEnwpupVr5EKKJucIVYwtl
 /baekLgBr81JQL/njKkiui/ruEYJcNTUD5EAce0blpxM6q3UBeZWFxntsV49ZmnHskUPrYt/lQp
 CVeL+KggrPNvn74Z7H3gtZcjKDti22FyQDSVLUo3KR4AkxSfV1MBue57X0MMm1zt1O5lKEJdCXg
 sGNbN8siqUpzYiIg8ImBeojk3tM7b17B0bR5WZ1BXsZA3SO6CpGeDRkg5KlxcK2NW1iZYcMMMBd
 KFOcGLp4KEnXuEZxl0cDxBdTd/LgqIe74nWnTkU2mfXd/5M/DLU0xhpX99QbiMk02HHJKfDAIOw
 3Iz9vgd+wLiKpSWJvNQMhlSYQlYEudtSQU4AkVaqjGPD+xvkFhDKM7sf/iPsPrJmXVcb8uoYSXV
 f9Axm37U8iDiI2sSOI4OHaPUtrBK3EnGLviN9ulrEu/i7ruyFnHr7E+yACyyVCVeokdfn5Duy5H
 rPYAC8wt4rPRqzvUyLR0BnzZdJcb3H6rhgtLrbHS+PithR8rlxsE3p9gUMg7XdS8hDbs6p6RGJ1
 ZmEWz//KPTxMvrg==
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

Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/fs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5f07c1c377df..0e334aad85c5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3619,4 +3619,21 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
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



