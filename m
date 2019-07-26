Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8577427
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 00:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfGZWp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 18:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbfGZWp6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 18:45:58 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD1822CBD;
        Fri, 26 Jul 2019 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564181157;
        bh=p4b6lbT/vXeFl+ohiAaEXRqD9wNsZb1Lt4uv7EKQyOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MM4D5gPH69GqpF3b8koFKDX+wIjuAy9mAzlqBgU4GxwWONYReUxJpZMjDuHqN9sX7
         KFar2HJkjx/eselAi4+v1u3xS4T25z4juBkm2/lgPh1KAYsPHa2e7NsUlZ/Vn8w2X4
         962saN8QDBZExRtmNSRMceMrLT2+JyxT3Nc/B2ek=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH v7 04/16] fscrypt: add ->ci_inode to fscrypt_info
Date:   Fri, 26 Jul 2019 15:41:29 -0700
Message-Id: <20190726224141.14044-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726224141.14044-1-ebiggers@kernel.org>
References: <20190726224141.14044-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add an inode back-pointer to 'struct fscrypt_info', such that
inode->i_crypt_info->ci_inode == inode.

This will be useful for:

1. Evicting the inodes when a fscrypt key is removed, since we'll track
   the inodes using a given key by linking their fscrypt_infos together,
   rather than the inodes directly.  This avoids bloating 'struct inode'
   with a new list_head.

2. Simplifying the per-file key setup, since the inode pointer won't
   have to be passed around everywhere just in case something goes wrong
   and it's needed for fscrypt_warn().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/crypto/fscrypt_private.h | 3 +++
 fs/crypto/keyinfo.c         | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index fae411b2f78dc..d345a7d28df8c 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -73,6 +73,9 @@ struct fscrypt_info {
 	 */
 	struct fscrypt_mode *ci_mode;
 
+	/* Back-pointer to the inode */
+	struct inode *ci_inode;
+
 	/*
 	 * If non-NULL, then this inode uses a master key directly rather than a
 	 * derived key, and ci_ctfm will equal ci_master_key->mk_ctfm.
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 22345ddede119..2d45a86f09db2 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -556,6 +556,8 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (!crypt_info)
 		return -ENOMEM;
 
+	crypt_info->ci_inode = inode;
+
 	crypt_info->ci_flags = ctx.flags;
 	crypt_info->ci_data_mode = ctx.contents_encryption_mode;
 	crypt_info->ci_filename_mode = ctx.filenames_encryption_mode;
-- 
2.22.0

