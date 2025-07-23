Return-Path: <linux-fsdevel+bounces-55802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39A6B0F088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92C63BDD72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1282DAFDB;
	Wed, 23 Jul 2025 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcVFU5L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81A27145B;
	Wed, 23 Jul 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268286; cv=none; b=pg9mb8vUDxQlODJZeQz1tXjuZtnHXSkCTkg9wfenaajXuLBbYP8a7IjlaZSjt/7SC0l3pCoDVezyggLn7bM7NA7UdYYJGWwuNWO0rmUIIi++aZf08mp0hLxOnMXsMp73z+PJrrImgeiInk6X1T9ls53nleEuEsrAEAZAU7ckw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268286; c=relaxed/simple;
	bh=7InBuQ/wFb06ajCJz+YsKpuRRK+jzxPaZ5RD5GCCmis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnaBfAkdLodCnzbwRoj4+/r3SW8w07eecHHvf68/uFzSD1KhXOmTj+gw+oy5ctGXxO7C52ufRvfBKiPnkEszKaUwbjh93RwQtIOmNtQKDM5vyhQCQe30+Bmi+skUTNRltQPOCvuc8Q2/nRThigpIMKJkOw9uoH6zLel/bnxlx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcVFU5L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43800C4CEF7;
	Wed, 23 Jul 2025 10:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753268285;
	bh=7InBuQ/wFb06ajCJz+YsKpuRRK+jzxPaZ5RD5GCCmis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcVFU5L041JE67axHR32wll0He0/alj7Y09sHGrLxbVWAx5R9A7jrQdKezKP2GBXt
	 4K3oZFGShSFK1Xx3QYFdOuDniMEn30XtabgoYinQHrBgjLYAEP/bT3nzlTKg9HYJ0A
	 QZzz4EWK+dM7N4nTCh8XLzQvFJifqIXHrNA0htAKgkoyaW4fBvCg2RuYqLzakPzXxJ
	 zCnzxoeaHyH5gcp3tC8UsKV9MtjmG/TTcdaX14i5cHYIkmZq7QYU59+GR98dVIWpC6
	 a20cXhYYmOaxBWD0E3q3LoBfGgeCggGcGTiTKbX3/BP3x0F0zSLUPgK83Z19G5B2qV
	 90O3s66RnugqQ==
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
Subject: [PATCH v4 01/15] fs: add fscrypt offset
Date: Wed, 23 Jul 2025 12:57:39 +0200
Message-ID: <20250723-work-inode-fscrypt-v4-1-c8e11488a0e6@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=brauner@kernel.org; h=from:subject:message-id; bh=7InBuQ/wFb06ajCJz+YsKpuRRK+jzxPaZ5RD5GCCmis=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0HNC8IHIvWzU3Qqf2Watr7alDU5Q/9Ids/Opp4qysL uBQ//9YRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEReLWX4K/ZrC/vDZD/ZW3cU 7yv5/nX0P2IVlejqFpqmkDDvRkt/EiPD2o7+LZs0fj3PPHPX2jKr8ODD6288Ved4B+//9kXw9b1 NTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Store the offset of the fscrypt data pointer from struct inode in struct
fscrypt_operations. Both are embedded in the filesystem's private inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fscrypt.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 56fad33043d5..0ece9d443c82 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -61,6 +61,11 @@ struct fscrypt_name {
 
 /* Crypto operations for filesystems */
 struct fscrypt_operations {
+	/**
+	 * The offset of struct fscrypt_inode_info from struct inode embedded
+	 * in the filesystem's inode.
+	 */
+	ptrdiff_t inode_info_offs;
 
 	/*
 	 * If set, then fs/crypto/ will allocate a global bounce page pool the

-- 
2.47.2


