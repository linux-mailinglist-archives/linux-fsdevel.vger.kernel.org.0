Return-Path: <linux-fsdevel+bounces-36145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B97819DE7C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5970AB209A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E51A08D7;
	Fri, 29 Nov 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dia4x6uX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F001A0739;
	Fri, 29 Nov 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887563; cv=none; b=WjtWIvpAu+KBczv2A2Qxvy2eW6KTJcdn45Lo3muZ0lMGGUGBCuzqzO927FF9mtRKbqA3hgTglHFtZagGIp3f2KIuempJTeTKVSLWCnTvHFtUfch4LbiWcrgv0Eh/ttm44MQWtVc/mGCQWdetfzSHXtpk4/1vPD8ly9bJQJNu+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887563; c=relaxed/simple;
	bh=78FWMXwHgkAge4U3uiflgkNmg1SNR5mVwKYGgc3VpOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkBYj9T0bOmF7SJk+F5n450LZ8r3Xnr+OW64RbcnLjiRpcrHDKYGasjL3rzhr8GT4I8lsoZk6uag8fX91T7Cp8X6eWUsHYDn2Sc3tO9nPjrVVLUygOBanySj4C2PGN8IwWKQM1m4Nts1bo8sz5fAJoUMglzMEwiHWBhyzjs9gZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dia4x6uX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13657C4CED7;
	Fri, 29 Nov 2024 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732887562;
	bh=78FWMXwHgkAge4U3uiflgkNmg1SNR5mVwKYGgc3VpOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dia4x6uXxqhkjc3HJrbianIpD2citF4JNVr14TvxN9YMIQKJitaR1COnmHUfV6qoi
	 fa1/dbWohRWPKwT35c8/jzBqrSDULP0mUtsmKVXC8KgIpjgj27+KRXEzx3679zmzBx
	 ZkhhhWndf9Of8MGIGmxlNFXWJNlN97/NakNR6e4RUrtLmz2dK2zofo+4Sqywga46x7
	 fIejAwfBtRS8p+LDmpETCRDjcN5IQh8RGH2+yHRKcc8VE/cmnsx1wQoatBPlQv6H6B
	 JX0lb2m9GovWTl7jnP+HjtoiO440m3vQoSd/hefem52HUe7+aTnuKrPXqgRCzzmvMd
	 XVW0nnnklkIYw==
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 1/6] pseudofs: add support for export_ops
Date: Fri, 29 Nov 2024 14:38:00 +0100
Message-ID: <20241129-work-pidfs-file_handle-v1-1-87d803a42495@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=brauner@kernel.org; h=from:subject:message-id; bh=M0fgsqn/CebFxcPKkzyrf+owSKApWHVZ3/j7hOlekWk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR7Ht4f8EK3Y3VmgdbZH5y7RTRlNyqvj2u9+/rISeP4u /2L5z2q6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIYhAjw443PVMbglhvP51R fDDK0HD92/aabEfPRv6NAq8lVXNf7WZk+Be8/AaDwVerd5tfTu+7FOQVU/WyY0FI4vczjr/+uYn M4QcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

From: Erin Shepherd <erin.shepherd@e43.eu>

Pseudo-filesystems might reasonably wish to implement the export ops
(particularly for name_to_handle_at/open_by_handle_at); plumb this
through pseudo_fs_context

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
Link: https://lore.kernel.org/r/20241113-pidfs_fh-v2-1-9a4d28155a37@e43.eu
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c                | 1 +
 include/linux/pseudo_fs.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 748ac59231547c29abcbade3fa025e3b00533d8b..2890a9c4a414b7e2be5c337e238db84743f0a30b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -673,6 +673,7 @@ static int pseudo_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_blocksize_bits = PAGE_SHIFT;
 	s->s_magic = ctx->magic;
 	s->s_op = ctx->ops ?: &simple_super_operations;
+	s->s_export_op = ctx->eops;
 	s->s_xattr = ctx->xattr;
 	s->s_time_gran = 1;
 	root = new_inode(s);
diff --git a/include/linux/pseudo_fs.h b/include/linux/pseudo_fs.h
index 730f77381d55f1816ef14adf7dd2cf1d62bb912c..2503f7625d65e7b1fbe9e64d5abf06cd8f017b5f 100644
--- a/include/linux/pseudo_fs.h
+++ b/include/linux/pseudo_fs.h
@@ -5,6 +5,7 @@
 
 struct pseudo_fs_context {
 	const struct super_operations *ops;
+	const struct export_operations *eops;
 	const struct xattr_handler * const *xattr;
 	const struct dentry_operations *dops;
 	unsigned long magic;

-- 
2.45.2


