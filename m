Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721F779C10
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjHLAm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbjHLAmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:42:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395FF358E;
        Fri, 11 Aug 2023 17:42:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E9BAF1F6E6;
        Sat, 12 Aug 2023 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691800925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCB8KBQ2MnwnOXcRfTwBuvP3bZPVD+Fzqq9bmI2qOzc=;
        b=VEa/yxyUmvLnU8M5rMa6VInz+xIkndwA129DATZ7J2v04V5lRjCVRaNU9uClH1KmhCueBO
        DoA5DUj/KhhvzeF5q9I4x9Zyc/mY5ZQ8Bdjrvs4SxLUtF34ShMfG5ZW0Mlm/HzNDl3/QQ7
        adZfxnggYSDDdLEoa+RCAhOkRBVXsEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691800925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCB8KBQ2MnwnOXcRfTwBuvP3bZPVD+Fzqq9bmI2qOzc=;
        b=NfuR/N4Fsp58zGGMNAm3rojG/E4y7R9MXU5LcfTHzbnDX0Dyjv4SfG9FxqbMA8SjAwjFRD
        +wt0cBd4K6kP2lDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B365913592;
        Sat, 12 Aug 2023 00:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZcjoJV3V1mQnEAAAMHmgww
        (envelope-from <krisman@suse.de>); Sat, 12 Aug 2023 00:42:05 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v5 07/10] libfs: Chain encryption checks after case-insensitive revalidation
Date:   Fri, 11 Aug 2023 20:41:43 -0400
Message-ID: <20230812004146.30980-8-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230812004146.30980-1-krisman@suse.de>
References: <20230812004146.30980-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Support encrypted dentries in generic_ci_d_revalidate by chaining
fscrypt_d_revalidate at the tail of the d_revalidate.  This allows
filesystem to just call generic_ci_d_revalidate and let it handle any
case-insensitive dentry (encrypted or not).

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Enable negative dentries of encrypted filesystems (Eric)
---
 fs/libfs.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index cb98c4721327..efb245118d10 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1452,9 +1452,8 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
-static int generic_ci_d_revalidate(struct dentry *dentry,
-				   const struct qstr *name,
-				   unsigned int flags)
+static int ci_d_revalidate(struct dentry *dentry, const struct qstr *name,
+			   unsigned int flags)
 {
 	const struct dentry *parent;
 	const struct inode *dir;
@@ -1508,6 +1507,15 @@ static int generic_ci_d_revalidate(struct dentry *dentry,
 	return 1;
 }
 
+static int generic_ci_d_revalidate(struct dentry *dentry,
+				   const struct qstr *name,
+				   unsigned int flags)
+{
+	if (!ci_d_revalidate(dentry, name, flags))
+		return 0;
+	return fscrypt_d_revalidate(dentry, name, flags);
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
@@ -1525,7 +1533,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0

