Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366C614340D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 23:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgATWee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 17:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgATWeU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:34:20 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE59C24654;
        Mon, 20 Jan 2020 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579559659;
        bh=a6AglMzuzSADbIykjFsh6WiXfUA9a8BSXSse5YpowJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxGsA6XSOH79/Ez1YYKFPwXEuecFLee2D4d34j5HPAbu0KJ494XC9qdVSW62bCxh/
         gg3un57dpwbCJT0BoaNxddQ6mXy41R5m3H+nmpvn5XDzbEb64fyS8RSpBsVTkZZBTi
         etgWdPATptkXqIamnw2Ms4bOtO2E8kcWZ4mwWCDc=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v5 5/6] ubifs: allow both hash and disk name to be provided in no-key names
Date:   Mon, 20 Jan 2020 14:32:00 -0800
Message-Id: <20200120223201.241390-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120223201.241390-1-ebiggers@kernel.org>
References: <20200120223201.241390-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In order to support a new dirhash method that is a secret-keyed hash
over the plaintext filenames (which will be used by encrypted+casefolded
directories on ext4 and f2fs), fscrypt will be switching to a new no-key
name format that always encodes the dirhash in the name.

UBIFS isn't happy with this because it has assertions that verify that
either the hash or the disk name is provided, not both.

Change it to use the disk name if one is provided, even if a hash is
available too; else use the hash.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/dir.c     | 4 +---
 fs/ubifs/journal.c | 4 ++--
 fs/ubifs/key.h     | 1 -
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 5f937226976a6..ef85ec167a843 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -225,9 +225,7 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 		goto done;
 	}
 
-	if (nm.hash) {
-		ubifs_assert(c, fname_len(&nm) == 0);
-		ubifs_assert(c, fname_name(&nm) == NULL);
+	if (fname_name(&nm) == NULL) {
 		if (nm.hash & ~UBIFS_S_KEY_HASH_MASK)
 			goto done; /* ENOENT */
 		dent_key_init_hash(c, &key, dir->i_ino, nm.hash);
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index a38e18d3ef1d7..3bf8b1fda9d74 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -588,7 +588,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 
 	if (!xent) {
 		dent->ch.node_type = UBIFS_DENT_NODE;
-		if (nm->hash)
+		if (fname_name(nm) == NULL)
 			dent_key_init_hash(c, &dent_key, dir->i_ino, nm->hash);
 		else
 			dent_key_init(c, &dent_key, dir->i_ino, nm);
@@ -646,7 +646,7 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	ubifs_add_auth_dirt(c, lnum);
 
 	if (deletion) {
-		if (nm->hash)
+		if (fname_name(nm) == NULL)
 			err = ubifs_tnc_remove_dh(c, &dent_key, nm->minor_hash);
 		else
 			err = ubifs_tnc_remove_nm(c, &dent_key, nm);
diff --git a/fs/ubifs/key.h b/fs/ubifs/key.h
index afa704ff5ca08..8142d9d6fe5da 100644
--- a/fs/ubifs/key.h
+++ b/fs/ubifs/key.h
@@ -150,7 +150,6 @@ static inline void dent_key_init(const struct ubifs_info *c,
 	uint32_t hash = c->key_hash(fname_name(nm), fname_len(nm));
 
 	ubifs_assert(c, !(hash & ~UBIFS_S_KEY_HASH_MASK));
-	ubifs_assert(c, !nm->hash && !nm->minor_hash);
 	key->u32[0] = inum;
 	key->u32[1] = hash | (UBIFS_DENT_KEY << UBIFS_S_KEY_HASH_BITS);
 }
-- 
2.25.0

