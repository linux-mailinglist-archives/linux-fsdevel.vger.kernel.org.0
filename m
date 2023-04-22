Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758B06EB610
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjDVADe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjDVADV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:03:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF4212D;
        Fri, 21 Apr 2023 17:03:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 657AF21A5B;
        Sat, 22 Apr 2023 00:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682121796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/QY3Q5AUsGwoQIvTobRrxWyVBRqL+pLZ7lAXnxVniA=;
        b=Op+Kfj7XzhSC/JQ5ZdrCSs6iEhM9I/dk6A84frFvXNjAwUT+kJkUlDW66GsQhlRX8sMaGZ
        DiSLat+3a+O6OVs4xj8BLg7i9W9TQ+kO0MM4AoKFLHiNLeKRIgZhSTPG947vw+5rq68n2O
        PkHPzYz4yrfykWsVzei31krRywhEkDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682121796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/QY3Q5AUsGwoQIvTobRrxWyVBRqL+pLZ7lAXnxVniA=;
        b=rDMOkG17UzGXLEFJ/PefeRg+cEc2AaWZcRH/R1l4/8dZFnlLtDjx4TlwdEt8+i0AvOitBN
        +Da5xomtTMb2O8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F08E1358E;
        Sat, 22 Apr 2023 00:03:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 34TjBUQkQ2TldwAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 22 Apr 2023 00:03:16 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     tytso@mit.edu, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, krisman@suse.de
Subject: [PATCH v2 3/7] libfs: Validate negative dentries in case-insensitive directories
Date:   Fri, 21 Apr 2023 20:03:06 -0400
Message-Id: <20230422000310.1802-4-krisman@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422000310.1802-1-krisman@suse.de>
References: <20230422000310.1802-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Introduce a dentry revalidation helper to be used by case-insensitive
filesystems to check if it is safe to reuse a negative dentry.

A negative dentry is safe to be reused on a case-insensitive lookup if
it was created during a case-insensitive lookup and this is not a lookup
that will instantiate a dentry. If this is a creation lookup, we also
need to make sure the name matches sensitively the name under lookup in
order to assure the name preserving semantics.

dentry->d_name is only checked by the case-insensitive d_revalidate hook
in the LOOKUP_CREATE/LOOKUP_RENAME_TARGET case since, for these cases,
d_revalidate is always called with the parent inode locked, and
therefore the name cannot change from under us.

d_revalidate is only called in 4 places: lookup_dcache, __lookup_slow,
lookup_open and lookup_fast:

  - lookup_dcache always calls it with zeroed flags, with the exception
  of when coming from __lookup_hash, which needs the parent locked
  already, for instance in the open/creation path, which is locked in
  open_last_lookups.

  - In __lookup_slow, either the parent inode is locked by the
  caller (lookup_slow), or it is called with no
  flags (lookup_one/lookup_one_len).

  - lookup_open also requires the parent to be locked in the creation
  case, which is done in open_last_lookups.

  - lookup_fast will indeed be called with the parent unlocked, but it
  shouldn't be called with LOOKUP_CREATE.  Either it is called in the
  link_path_walk, where nd->flags doesn't have LOOKUP_CREATE yet or in
  open_last_lookups. But, in this case, it also never has LOOKUP_CREATE,
  because it is only called on the !O_CREAT case, which means op->intent
  doesn't have LOOKUP_CREAT (set in build_open_flags only if O_CREAT is
  set).

Finally, for the LOOKUP_RENAME_TARGET, we are doing a rename, so the
parents inodes are also be locked.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4eda519c3002..f8881e29c5d5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1467,9 +1467,43 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
+static inline int generic_ci_d_revalidate(struct dentry *dentry,
+					  const struct qstr *name,
+					  unsigned int flags)
+{
+	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
+
+	if (d_is_negative(dentry)) {
+		const struct dentry *parent = READ_ONCE(dentry->d_parent);
+		const struct inode *dir = READ_ONCE(parent->d_inode);
+
+		if (dir && needs_casefold(dir)) {
+			if (!d_is_casefold_lookup(dentry))
+				return 0;
+
+			if (is_creation) {
+				/*
+				 * dentry->d_name won't change from under us in
+				 * the is_creation path only, since d_revalidate
+				 * during creation and renames is always called
+				 * with the parent inode locked.  This isn't the
+				 * case for all lookup callpaths, so it should
+				 * not be accessed outside
+				 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
+				 */
+				if (dentry->d_name.len != name->len ||
+				    memcmp(dentry->d_name.name, name->name, name->len))
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.40.0

