Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83577D9AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241831AbjHPFIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 01:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbjHPFIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:08:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24377123;
        Tue, 15 Aug 2023 22:08:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D1C1F1F85D;
        Wed, 16 Aug 2023 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692162495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7BnRrZj/BGeCpY2Eau7Peq32o7FSQuNiLArj6jqWIo=;
        b=q+nIByajPNGdCgxwjTHcLgAcAAE3vo30+GSTTYImLwz+LrBlsadIBIdtJJzpGVjC8TX+nl
        UgdLS9nV2sQ94Mk1eqJ15RlrylbuwzmbdIwsX18ke7XNSgO5U70hWHCLUBzm8HNE9d5LQL
        wKCyWapwZWLv+WHv+QLulCV8clwKKUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692162495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7BnRrZj/BGeCpY2Eau7Peq32o7FSQuNiLArj6jqWIo=;
        b=FX/3mY0BqMtV9jaM2LR1JG0RlWYXG2jiexMxBdbGEsHVgQxelSZGCBNPbBTH2wWdzy6poC
        +2WHUIrDFrUZj6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D139133F2;
        Wed, 16 Aug 2023 05:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4A70IL9Z3GTwTgAAMHmgww
        (envelope-from <krisman@suse.de>); Wed, 16 Aug 2023 05:08:15 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v6 5/9] libfs: Validate negative dentries in case-insensitive directories
Date:   Wed, 16 Aug 2023 01:07:59 -0400
Message-ID: <20230816050803.15660-6-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816050803.15660-1-krisman@suse.de>
References: <20230816050803.15660-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Introduce a dentry revalidation helper to check the negative dentries of
case-insensitive filesystems.  This helper is based on the fact that a
negative dentry might safe to be reused on a casefolded directory if it
was created during a case-insensitive lookup, because that kind of
lookup verifies not only the exact name doesn't exist in a directory,
but also that *any* case-equivalent name also doesn't exist.  The sole
exception is during file creation, in which case we also need to make
sure the name matches case-sensitively, in order to assure the disk
name-preserving semantics.

We cover most creations by checking LOOKUP_CREATE|LOOKUP_RENAME_TARGET
flags.  But, while most creations use those flags, there are filesystem
helpers that call lookup for creation with flags==0.  Since we can't
know whether those are for creation, just reject the negative dentries
if there are no flags to check.

Note that we avoid taking the ->d_lock while accessing ->d_name, because
it isn't really necessary for the LOOKUP_CREATE/LOOKUP_RENAME_TARGET
case. That is because in every creation path with these flags, we know
the parent inode lock is acquired, at least for reading, thus
stabilizing the d_name, since it prevents the dentry from being
instantiated and negative dentries cannot be moved.

See also the comment in the code.

* Discussion on the ->d_name stability

d_revalidate can only be reached from 4 code paths: lookup_dcache,
__lookup_slow, lookup_open and lookup_fast:

  - lookup_dcache only reaches d_revalidate with creation flags when
  coming from __lookup_hash, which needs the parent locked already.

  - In __lookup_slow, either the parent inode is read-locked by the
  caller (lookup_slow), or it is called with no flags (lookup_one*).  A
  read lock suffices to prevent concurrent ->d_name modifications, with
  the exception of a modification inside __d_unalias, which is not a
  problem because negative dentries are not allowed to be moved with
  __d_move.  In addition, d_instantiate shouldn't race with this case
  because its callers also acquire the parent inode lock, preventing it
  from racing with lookup creation.

  - lookup_open also requires the parent to be locked in the creation
  case, which is done in open_last_lookups.

  - lookup_fast will indeed be called with the parent unlocked, but it
  shouldn never be called with LOOKUP_CREATE.  Either it is called in the
  link_path_walk, where nd->flags doesn't have LOOKUP_CREATE yet or in
  open_last_lookups. But, in this case, it also never has LOOKUP_CREATE,
  because it is only called on the !O_CREAT case, which means op->intent
  doesn't have LOOKUP_CREAT (set in build_open_flags only if O_CREAT is
  set).

In addition, for the LOOKUP_RENAME_TARGET, we are doing a rename, so the
parents inodes are also locked.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Use IS_CASEFOLDED directly (Eric)
  - Reword commit message and comment in the code (Eric)
Changes since v4:
  - Drop useless inline declaration (eric)
  - Refactor to drop extra identation (Christian)
  - Discuss d_instantiate
Changes since v3:
  - Add comment regarding creation (Eric)
  - Reorder checks to clarify !flags meaning (Eric)
  - Add commit message explanaton of the inode read lock wrt.
    __d_move. (Eric)
Changes since v2:
  - Add comments to all rejection cases (Eric)
  - safeguard against filesystem creating dentries without LOOKUP flags
---
 fs/libfs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..26bf1b832b0a 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1462,9 +1462,63 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
+static int generic_ci_d_revalidate(struct dentry *dentry,
+				   const struct qstr *name,
+				   unsigned int flags)
+{
+	const struct dentry *parent;
+	const struct inode *dir;
+
+	if (!d_is_negative(dentry))
+		return 1;
+
+	parent = READ_ONCE(dentry->d_parent);
+	dir = READ_ONCE(parent->d_inode);
+
+	if (!dir || !IS_CASEFOLDED(dir))
+		return 1;
+
+	/*
+	 * Negative dentries created prior to turning the directory
+	 * case-insensitive cannot be trusted, since they don't ensure
+	 * any possible case version of the filename doesn't exist.
+	 */
+	if (!d_is_casefolded_name(dentry))
+		return 0;
+
+	/*
+	 * If the lookup is for creation, then a negative dentry can only be
+	 * reused if it's a case-sensitive match, not just a case-insensitive
+	 * one.  This is needed to make the new file be created with the name
+	 * the user specified, preserving case.
+	 *
+	 * LOOKUP_CREATE or LOOKUP_RENAME_TARGET cover most creations.  In these
+	 * cases, ->d_name is stable and can be compared to 'name' without
+	 * taking ->d_lock because the caller must hold dir->i_rwsem.  (This
+	 * is because the directory lock blocks the dentry from being
+	 * concurrently instantiated, and negative dentries are never moved.)
+	 *
+	 * All other creations actually use flags==0.  These come from the edge
+	 * case of filesystems calling functions like lookup_one() that do a
+	 * lookup without setting the lookup flags at all.  Such lookups might
+	 * or might not be for creation, and if not don't guarantee stable
+	 * ->d_name.  Therefore, invalidate all negative dentries when flags==0.
+	 */
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
+		if (dentry->d_name.len != name->len ||
+		    memcmp(dentry->d_name.name, name->name, name->len))
+			return 0;
+	} else if (!flags) {
+		return 0;
+	}
+
+	return 1;
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
+	.d_revalidate = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0

