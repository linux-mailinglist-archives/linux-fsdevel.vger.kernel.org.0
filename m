Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B841765A3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjG0R3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 13:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjG0R27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:28:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE132D76;
        Thu, 27 Jul 2023 10:28:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90E131F88F;
        Thu, 27 Jul 2023 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690478934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=;
        b=rOkOCarpeK0rdsiVu53BMJwMjBjURI+WWOnOImW/UMfOuCT9TxPAtGrQwHEftnWYbGqxRg
        55isdToflB6gjJ4ixZCTnOSxZzMxrHrDlEfYMFWrqXZOrWoU2ecYSafFOovgslzyChnwUy
        zRop+mGW/dMK0Y3qrxvmVYvOFVOKi60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690478934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u33Nxud88E1b11kdjmDBklWOJDd3t0YNcG/zXbqscio=;
        b=3EkSCxwp49ojkp/N9SbHUMPFUbhZU0WdMrVNyd2Zz2AeudWjiHNqCePlISR0WkV7KTlm/m
        csvbVWmufulL6zDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B44F13902;
        Thu, 27 Jul 2023 17:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k3HEEFapwmTOaAAAMHmgww
        (envelope-from <krisman@suse.de>); Thu, 27 Jul 2023 17:28:54 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        ebiggers@kernel.org, jaegeuk@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 4/7] libfs: Chain encryption checks after case-insensitive revalidation
Date:   Thu, 27 Jul 2023 13:28:40 -0400
Message-ID: <20230727172843.20542-5-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727172843.20542-1-krisman@suse.de>
References: <20230727172843.20542-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ed04c4dcc312..44c02993adb4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1513,7 +1513,7 @@ static inline int generic_ci_d_revalidate(struct dentry *dentry,
 			}
 		}
 	}
-	return 1;
+	return fscrypt_d_revalidate(dentry, flags);
 }
 
 static const struct dentry_operations generic_ci_dentry_ops = {
@@ -1533,7 +1533,7 @@ static const struct dentry_operations generic_encrypted_dentry_ops = {
 static const struct dentry_operations generic_encrypted_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
-	.d_revalidate = fscrypt_d_revalidate,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0

