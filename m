Return-Path: <linux-fsdevel+bounces-55671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81952B0DA44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E0DF7B1A53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5BC2E92BB;
	Tue, 22 Jul 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuLtVmWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D72E9742;
	Tue, 22 Jul 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189069; cv=none; b=Y/2qbvfBe4izRcKbHXLCVUyt9fNayfDvI/NCo0mVcrY2Aa90i0DEji9/TcIV25EiilqaUi60JWAO+7nAIvPXN8cD3bNFd0o2XUiz2htjbVQsj9TAF8RB3eVfu4KKCB21nT+Kywi/e33K7lVnDZllWTj6rBhS5pEt5HWwN53XZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189069; c=relaxed/simple;
	bh=9bagpMuhJRb+rY6i4MvA/UbNEqwbFK7prENCucPGXpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cB2uvDCfYv9wdDaAKuFKTb5pezXef3Zl0C3gU4XuElA5pmJDgmPg8mvp5CZCikfw0f7z828qQPFDeVi/JbCVnXLFWFQjSSEXOG6/fG3Gy1jRce1d9XQbcJRytw9oX2AqMknBdx/lPc1kt1tVAlR/G6YP/Axdw3gfEwt5mt9Y6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuLtVmWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B6CC4CEF1;
	Tue, 22 Jul 2025 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189069;
	bh=9bagpMuhJRb+rY6i4MvA/UbNEqwbFK7prENCucPGXpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuLtVmWETWlsQIQMJG5fF77BcetKHUCAFC3ofrlWAKEaYWrtIYiHllgSumBCbCgFU
	 tBZvKX8M+moFjPG7dhxI3TFzpRz+wuTOjvOPckhSjHyubCCwNfZKNEuGUvRkalAh4k
	 pJL8BABUtrF6YAGh9tg6BCczV47MXn0NeVzvO+mgAtKMHi+nYlNsta3YKrEP3NdjN8
	 khz/fkCEjk5TYOf4vJcSeDas3wsZ2mGN4p1IzKOd2G/IINsQm1J91KkRK/+7n7QAJT
	 HIzI106wuJK1JDdYY0AXcJRNHNTk6BR5nZLYs9eCYEui523EgBJyMEMShmywB0ShY0
	 bNloHu5sfe/Vw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 01/13] fs: add fscrypt offset
Date: Tue, 22 Jul 2025 14:57:07 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-1-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=brauner@kernel.org; h=from:subject:message-id; bh=9bagpMuhJRb+rY6i4MvA/UbNEqwbFK7prENCucPGXpA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd21Ukm/RZtfdczL/+4SuU9+V+9SuR1lc9GzSuhyeY eJlrsjRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHRSIb/MSmC5jcrf1amby46 Xly8Snlm/YXFSkt7j5xnvVJVEvrpHyPDj+ctOTvlLpe1O5Ts+X52a1eiyrKaNb2NGur+adt8d1a zAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fscrypt data pointer from struct inode in struct
inode_operations. Both are embedded in the filesystem's private inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..82678b523720 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2217,6 +2217,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
 	{ return wrap_directory_iterator(file, ctx, x); }
 
 struct inode_operations {
+	ptrdiff_t i_fscrypt;
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
 	int (*permission) (struct mnt_idmap *, struct inode *, int);

-- 
2.47.2


