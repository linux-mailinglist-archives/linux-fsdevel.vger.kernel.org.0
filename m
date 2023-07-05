Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F422748CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGETDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjGETDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DFE6E;
        Wed,  5 Jul 2023 12:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D73C616E4;
        Wed,  5 Jul 2023 19:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E8AC433C8;
        Wed,  5 Jul 2023 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583792;
        bh=HfiQXchZVgUdW2X7NFM83sYUqCp8My1ze+VPJQDRphQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUNvfNyPT7W1MfeOCkDDT+DJnubUSlCH5fU4mFL4FRFG5h6LgjKonwHhqo7TNh5hN
         B+MiEAv22iPTlc2u5YfqIJNc2XtG6I038fBfVm6lJB/eP4QSwogDytyD88KahvHbrI
         VI8+NGIFDp/304cSkuaqDfeLob81nMQNJgSAS4h9FhrzuasAe4S1BbjrpRfg9duB+W
         5k1GhWLMaCUZQXbMhBE29rg5uEXnl/5BQdp8qOtlnNRjV6bTJxrYrYgUxzmDKhZpsZ
         W32RS/IiQM+54sesxu5H7pOsVXojcLfgGF2ZTJf9t/XeIF2s3BxIJSPPJUsesmUk73
         hSpMEDvO02xmA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/92] bfs: update ctime in addition to mtime when adding entries
Date:   Wed,  5 Jul 2023 15:00:29 -0400
Message-ID: <20230705190309.579783-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When adding entries to a directory, POSIX generally requires that the
ctime be updated alongside the mtime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/bfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index 040d5140e426..d2e8a2a56b05 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -294,7 +294,7 @@ static int bfs_add_entry(struct inode *dir, const struct qstr *child, int ino)
 					dir->i_size += BFS_DIRENT_SIZE;
 					dir->i_ctime = current_time(dir);
 				}
-				dir->i_mtime = current_time(dir);
+				dir->i_mtime = dir->i_ctime = current_time(dir);
 				mark_inode_dirty(dir);
 				de->ino = cpu_to_le16((u16)ino);
 				for (i = 0; i < BFS_NAMELEN; i++)
-- 
2.41.0

