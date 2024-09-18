Return-Path: <linux-fsdevel+bounces-29655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213797BDCF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD102863CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4D18C354;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7cwxW6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BEF9CB;
	Wed, 18 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668769; cv=none; b=R6m2ELFGrkKziBwj3Yrr8l5CF9lVqgxd55zo167bRJWlSy+rCRk766USXsDZVhYdrij53zYp4+ldFIpPyZEsRr0hAvkJa3ggZAjhz3DKfMXa2ezjvnyBFqN5POXe7j3r8JZKTY53lWGwES27Ko3z3dDEiOZLbN9X90Hyz1mhjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668769; c=relaxed/simple;
	bh=x1Xc/UFz3grEcF9+MRXVNAJu0t50Wbx7WhznyvSgTrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Osg7ARpiRyv9HwgdtgTwvV21PBkkiDU6jvvp6TR5w0GA5O1ljvfJzg9tnvlB3AH2dw1fZ0sCarPnFLla5XgnMkJVb20AYgX0lTcDT1OyPH+dIydOAHEU3VNSoelALwxpxdiRWywQPQ5L2g2DKKbDc+vr6tYn7GcKGILAX2AUBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7cwxW6A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA55EC4CECE;
	Wed, 18 Sep 2024 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668769;
	bh=x1Xc/UFz3grEcF9+MRXVNAJu0t50Wbx7WhznyvSgTrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l7cwxW6AL3DZFqpx9Zd0fCVWabYJB5ltdgqd9N0MolKldfDncEO1E+LwAg7ayCdtZ
	 5NVSOa/Rj8XUCn2QpVRvq1YLqP7GVBn9SfP1vVnPrKIULaIUseB1imxSAaQBA1LlIo
	 QvRxOzTEvS3e+9FR2r/8IRtgd6ekkgh4Y92tI+JsI7BlOie5gyp98mR/WlrqhetW7v
	 F3tEQyxkzSvQ3ZGrkhi4MVOQ6KBfaf9R0TsRJBxM3FXxgVVN2PubE9YYAzZPAFpjUQ
	 3UWcyJl4oc4mv7eeOR5OZjxzsuLYaMnpUD8wLu+/htM8TrzihDXAlIUvuLPHX1ycRU
	 35hsVE5ERy5cA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B2CCD1AB;
	Wed, 18 Sep 2024 14:12:48 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:12:20 +0800
Subject: [PATCH v5.4-v4.19 1/6] fs: implement vfs_stat and vfs_lstat in
 terms of vfs_fstatat
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-5-4-y-v1-1-8a771c9bbe5f@gmail.com>
References: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-5-4-y-v1-0-8a771c9bbe5f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>, 
 Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=CQCVg6bGtOP7dyIJeUlTzT0EMwWixKIfeNRTX+C5op0=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t/dN6H2v5zhZ+VZu7qHixmznKxNo+3Rk1z6P
 MeyL1nJkueJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurf3QAKCRCwMePKe/7Z
 bnotEACicVudyiCwiXPeNPSwGr7S4Ztlm5l8+E5WotWOBHH5e0d5rrkI1IelGuDBBfhhyCbYz0t
 HgmGj3EtwPIuA3KXS5hKhVnncohkyujzu3s7++7GWQBdAAbYZxqnua3ptUx5Nynf13+9Hr2xCbk
 eRYyvnXqVED+TubKqcC+TrlwDy4t63C+pMC5woVgZEh/voFNabz/iCKwaNy35AmsSds+guma01G
 qpkwjRtvy8/HKg6TutXvwz8UJKCTtLq1p3JPD8QS+ztW7kvxz6WyqL7HurZGhn0MHjc63ftA4EY
 OAnTA+fmPsYrX2HzYxduBYuP+1F4ZyRruTilheJFDWjJ+uKNAfFbo3XyRuyYQDHcf098hAdMjkO
 eRnlTJm5RkHxbu6vdnPlljNKHp2I0/OsqmPwk7KVWgP8/X3ZrDAMg7Sqa+mvJxanGscjujSPphH
 xYbGXc5Gtcc1zdPWHjvfZH24x+ooNeKMH0Tf9LkRnv2G2BvQEaB4sJp1ECWWuG1GNdwLhf4s0uu
 SI1phaQB7NwHGc1cBARomx9Rs7NPp/e86l8ajhbCLy6kPMDvbsZxJ0yKvYP7P+sEqnVrI/f9MYL
 FFJgLw7y403UUtsRbhWPVfTjdsNQJy/tuT+9O6+MAUIAyA17Q7MP4T8EN4vUalmz80yBFRNq8Lc
 ZfnlJfEosGcs1yg==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christoph Hellwig <hch@lst.de>

commit 0b2c669 upstream.

Go through vfs_fstatat instead of duplicating the *stat to statx mapping
three times.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Cc: <stable@vger.kernel.org> # 4.19.x-5.4.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/fs.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d4f5fcc60744..2db4e5f7d00b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3262,16 +3262,6 @@ extern int iterate_dir(struct file *, struct dir_context *);
 extern int vfs_statx(int, const char __user *, int, struct kstat *, u32);
 extern int vfs_statx_fd(unsigned int, struct kstat *, u32, unsigned int);
 
-static inline int vfs_stat(const char __user *filename, struct kstat *stat)
-{
-	return vfs_statx(AT_FDCWD, filename, AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
-}
-static inline int vfs_lstat(const char __user *name, struct kstat *stat)
-{
-	return vfs_statx(AT_FDCWD, name, AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
-}
 static inline int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
@@ -3283,6 +3273,14 @@ static inline int vfs_fstat(int fd, struct kstat *stat)
 	return vfs_statx_fd(fd, stat, STATX_BASIC_STATS, 0);
 }
 
+static inline int vfs_stat(const char __user *filename, struct kstat *stat)
+{
+	return vfs_fstatat(AT_FDCWD, filename, stat, 0);
+}
+static inline int vfs_lstat(const char __user *name, struct kstat *stat)
+{
+	return vfs_fstatat(AT_FDCWD, name, stat, AT_SYMLINK_NOFOLLOW);
+}
 
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
 extern int vfs_readlink(struct dentry *, char __user *, int);

-- 
2.43.0



