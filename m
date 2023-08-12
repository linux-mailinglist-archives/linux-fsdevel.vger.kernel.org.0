Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF9779C02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjHLAmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbjHLAmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:42:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E04A6;
        Fri, 11 Aug 2023 17:42:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2026B1F45A;
        Sat, 12 Aug 2023 00:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691800924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rboAhxFh4vXaAaxXhYnXEsNgIGq+WuMjEQjmzuhhcBA=;
        b=yPHW/KW99FkobstIfyZ/sDxFi5xpqOFvAkfJ31DfjY7MVOYoI6+eJ+lmeJtNdWd1Ce9I7r
        1IquXEvycPUfOm3fUuBkInbFRkqUKFmaYS9AF2JyC7ozZk0EYGCmggZFJvwVKPtvP+HhWq
        uMmbV7Onl6KA0SGk986x6avE9/tluqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691800924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rboAhxFh4vXaAaxXhYnXEsNgIGq+WuMjEQjmzuhhcBA=;
        b=LCXLd7R33X9KhxaoePEQheYn/UMXFwBikpRSIXAVpuCAeBdnhjmbpXwoyxCFwYaezWPpyh
        0X9c6s8oIRWvKaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCE7B13592;
        Sat, 12 Aug 2023 00:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7DxOMFvV1mQlEAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:42:03 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v5 06/10] libfs: Validate negative dentries in case-insensitive directories
Date:   Fri, 11 Aug 2023 20:41:42 -0400
Message-ID: <20230812004146.30980-7-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
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

Introduce a dentry revalidation helper to be used by case-insensitive
filesystems to check if it is safe to reuse a negative dentry.

A negative dentry is safe to be reused on a case-insensitive lookup if
it was created during a case-insensitive lookup and this is not a lookup
that will instantiate a dentry. If this is a creation lookup, we also
need to make sure the name matches sensitively the name under lookup in
order to assure the name preserving semantics.

dentry->d_name is only checked by the case-insensitive d_revalidate hook
in the LOOKUP_CREATE/LOOKUP_RENAME_TARGET case since, for these cases,
d_revalidate is always called with the parent inode at least
read-locked, and therefore the name cannot change from under us.

d_revalidate is only called in 4 places: lookup_dcache, __lookup_slow,
lookup_open and lookup_fast:

  - lookup_dcache always calls it with zeroed flags, with the exception
    of when coming from __lookup_hash, which needs the parent locked
    already, for instance in the open/creation path, which is locked in
    open_last_lookups.

  - In __lookup_slow, either the parent inode is read-locked by the
    caller (lookup_slow), or it is called with no flags (lookup_one*).
    The read lock suffices to prevent ->d_name modifications, with the
    exception of one case: __d_unalias, will call __d_move to fix a
    directory accessible from multiple dentries, which effectively swaps
    ->d_name while holding only the shared read lock.  This happens
    through this flow:

    lookup_slow()  //LOOKUP_CREATE
      d_lookup()
        ->d_lookup()
          d_splice_alias()
            __d_unalias()
              __d_move()

    Nevertheless, this case is not a problem because negative dentries
    are not allowed to be moved with __d_move.  In addition,
    d_instantiate shouldn't race with this case because it's callers
    also acquire the parent inode lock, preventing it from racing with
    lookup creation, so the dentry cannot become positive and be moved
    while inside d_revalidate, which would be a problem if a parallel
    lookup did d_splice_alias.

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
parents inodes are also locked.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
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
 fs/libfs.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8d0b64cfd5da..cb98c4721327 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1452,9 +1452,66 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
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
+	if (!dir || !dir_is_casefolded(dir))
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
+	 * Filesystems will call into d_revalidate without setting
+	 * LOOKUP_ flags even for file creation (see lookup_one*
+	 * variants).  Reject negative dentries in this case, since we
+	 * can't know for sure it won't be used for creation.
+	 */
+	if (!flags)
+		return 0;
+
+	/*
+	 * If the lookup is for creation, then a negative dentry can
+	 * only be reused if it's a case-sensitive match, not just a
+	 * case-insensitive one.  This is needed to make the new file be
+	 * created with the name the user specified, preserving case.
+	 */
+	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
+		/*
+		 * ->d_name won't change from under us in the creation
+		 * path only, since d_revalidate during creation and
+		 * renames is always called with the parent inode
+		 * locked.  It isn't the case for all lookup callpaths,
+		 * so ->d_name must not be touched outside
+		 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
+		 */
+		if (dentry->d_name.len != name->len ||
+		    memcmp(dentry->d_name.name, name->name, name->len))
+			return 0;
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

