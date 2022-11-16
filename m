Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700A62C22E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiKPPRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiKPPRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D86A2B625;
        Wed, 16 Nov 2022 07:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2863B61E83;
        Wed, 16 Nov 2022 15:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7B9C433C1;
        Wed, 16 Nov 2022 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611852;
        bh=yV8M/3emkfa0v+JOTDZ4rZGKsnEb+eyCdX2b35M2HGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFSJEruBqD3UjsUIscezAfqvMdcvsa4Sl5KLDACMuWA/jiXclACdRl7MAwGXNgfCX
         ZRZ3RXGnFqrqcsUWVXmTwi8+XiN3bEZA/bs64yZMZNY3WQ/h9M9CMe8wo6RbhaCFRJ
         D5SxE48RrgWvuHOJjKziqn/gyrMvHtM6hWzKxCxHByE/IfL+UhHfgtbqp510ks4yRN
         be/726mUIC3CgM0V0qVa1TxdCFXaDVm/PrazWp6q2Bhy2S079bngjE8w5TWKL5FlhI
         BxVj0krDMw8KFxT4xtaDEdV5fTVfaMIf3KT/eFx33rCi/AtT6jZGMGDHsnd4d9ziZZ
         VclL82dby9UUA==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de,
        Steve French <smfrench@samba.org>
Subject: [PATCH 3/7] cifs: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:22 -0500
Message-Id: <20221116151726.129217-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116151726.129217-1-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cifs currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Steve French <smfrench@samba.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index cd9698209930..6c1431979495 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1413,7 +1413,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 	struct inode *inode = d_inode(cfile->dentry);
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct file_lock *flock;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	unsigned int count = 0, i;
 	int rc = 0, xid, type;
 	struct list_head locks_to_send, *el;
-- 
2.38.1

