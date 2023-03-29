Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEE46CF467
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC2UXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 16:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC2UXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:23:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE340F4;
        Wed, 29 Mar 2023 13:23:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79CB421A84;
        Wed, 29 Mar 2023 20:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680121395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BTYMUFJkxD7ap26/zj0eBSKlKQMHZZxSnbtlAEkWe1Q=;
        b=qnygApINZMMV+QaKx4jjtc/4/WD/rqNZUV5fXch+DLYG22AW2UF9yvk/vCM03LTRHPG3Lc
        rH+Ulcr14qu45mVsx4SiXKQGofcyS6q2p3/ewL1Rg/3jG0bVY1U3ennx+7GjXEhdOLUWYB
        06we1NwV455a0aFQuJuZACZ1IyfGOuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680121395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BTYMUFJkxD7ap26/zj0eBSKlKQMHZZxSnbtlAEkWe1Q=;
        b=QLOwJlPk+Hl8LjyMo4vC90GgFbBVzpfGsrmP9ZhWeUqldBuRpcHcMudlWp0Fa5ZDthaV29
        whD1lJ5dqGxyccBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4F404138FF;
        Wed, 29 Mar 2023 20:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HofTETOeJGSVZAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 29 Mar 2023 20:23:15 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, smfrench@gmail.com,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH] cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL
Date:   Wed, 29 Mar 2023 22:24:06 +0200
Message-Id: <20230329202406.15762-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When compiled with CONFIG_CIFS_DFS_UPCALL disabled, cifs_dfs_d_automount
NULL. cifs.ko logic for mapping CIFS_FATTR_DFS_REFERRAL attributes to
S_AUTOMOUNT and corresponding dentry flags is retained regardless of
CONFIG_CIFS_DFS_UPCALL, leading to a NULL pointer dereference in
VFS follow_automount() when traversing a DFS referral link:
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  Call Trace:
   <TASK>
   __traverse_mounts+0xb5/0x220
   ? cifs_revalidate_mapping+0x65/0xc0 [cifs]
   step_into+0x195/0x610
   ? lookup_fast+0xe2/0xf0
   path_lookupat+0x64/0x140
   filename_lookup+0xc2/0x140
   ? __create_object+0x299/0x380
   ? kmem_cache_alloc+0x119/0x220
   ? user_path_at_empty+0x31/0x50
   user_path_at_empty+0x31/0x50
   __x64_sys_chdir+0x2a/0xd0
   ? exit_to_user_mode_prepare+0xca/0x100
   do_syscall_64+0x42/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

This fix adds an inline cifs_dfs_d_automount() {return -EREMOTE} handler
when CONFIG_CIFS_DFS_UPCALL is disabled. An alternative would be to
avoid flagging S_AUTOMOUNT, etc. without CONFIG_CIFS_DFS_UPCALL. This
approach was chosen as it provides more control over the error path.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/cifs/cifsfs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 71fe0a0a7992..415176b2cf32 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -124,7 +124,10 @@ extern const struct dentry_operations cifs_ci_dentry_ops;
 #ifdef CONFIG_CIFS_DFS_UPCALL
 extern struct vfsmount *cifs_dfs_d_automount(struct path *path);
 #else
-#define cifs_dfs_d_automount NULL
+static inline struct vfsmount *cifs_dfs_d_automount(struct path *path)
+{
+	return ERR_PTR(-EREMOTE);
+}
 #endif
 
 /* Functions related to symlinks */
-- 
2.35.3

