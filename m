Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDFE6EB61B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 02:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjDVADs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 20:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjDVADe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 20:03:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923A26AF;
        Fri, 21 Apr 2023 17:03:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 864681FDEA;
        Sat, 22 Apr 2023 00:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682121802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=;
        b=Hh2VIJaS124nZaTolMohKkUM5hDdRHKh/gKSLylf+ks4/JRdorqljW/x+Noa0y5/NWAQlH
        OR3qnqeFqABa9yHtRLBPaBkyE7sLmQpq2Jp7x1WwB0BLvluhFxaRAnYj7hYv8HCpWY1UyJ
        /EWrDBNuGMnsMc3wbQGZmEYhmXaqS08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682121802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JwRiXt7Z0INDOdagK+P+QdTiJUoiuESrT1A53nUDzg=;
        b=2DnnzSmZR58Kp+X+a2SvEJvubUAegf79zBGv5zZ2NFy2kWcYyIb7j3loVuY37T7NiRgRlZ
        j2wYjEwTOivBSeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EEA51358E;
        Sat, 22 Apr 2023 00:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tXvIDUokQ2T5dwAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 22 Apr 2023 00:03:22 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     tytso@mit.edu, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, krisman@suse.de
Subject: [PATCH v2 7/7] f2fs: Enable negative dentries on case-insensitive lookup
Date:   Fri, 21 Apr 2023 20:03:10 -0400
Message-Id: <20230422000310.1802-8-krisman@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230422000310.1802-1-krisman@suse.de>
References: <20230422000310.1802-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Instead of invalidating negative dentries during case-insensitive
lookups, mark them as such and let them be added to the dcache.
d_ci_revalidate is able to properly filter them out if necessary based
on the dentry casefold flag.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/namei.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 11fc4c8036a9..57ca7ea86509 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -564,17 +564,8 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
-		/* Eventually we want to call d_add_ci(dentry, NULL)
-		 * for negative dentries in the encoding case as
-		 * well.  For now, prevent the negative dentry
-		 * from being cached.
-		 */
-		trace_f2fs_lookup_end(dir, dentry, ino, err);
-		return NULL;
-	}
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_set_casefold_lookup(dentry);
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
 	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
@@ -627,16 +618,6 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	f2fs_delete_entry(de, page, dir, inode);
 	f2fs_unlock_op(sbi);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	/* VFS negative dentries are incompatible with Encoding and
-	 * Case-insensitiveness. Eventually we'll want avoid
-	 * invalidating the dentries here, alongside with returning the
-	 * negative dentries at f2fs_lookup(), when it is better
-	 * supported by the VFS for the CI case.
-	 */
-	if (IS_CASEFOLDED(dir))
-		d_invalidate(dentry);
-#endif
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
 fail:
-- 
2.40.0

