Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5F748D77
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjGETLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjGETKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A63C29;
        Wed,  5 Jul 2023 12:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5D861716;
        Wed,  5 Jul 2023 19:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D925CC433CA;
        Wed,  5 Jul 2023 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583943;
        bh=PupGEBmpc4BS3GR/o7WIzvxzbsSfu55Z8rACvDIEA1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeAwqR8Xl0h07N6K15EXbDERNSWmUYaYGEVGFgjnZMtepCmt1llB/o23xcjhlwLas
         6CiwqQJJtoCwixWGV/lVcUuZZKO6JsD8SiSt3FCk1RDYxFjY1KFUCBzxplJ4PXtI+x
         4/ADpSVzofY0F4F1Q2YdzkkG+4AFvl6W/8UJtqbe9omwrrQ1fV58teVyo6S+1Ndtta
         cpR+KOH3XFCEY6W2LvMIs1W3/oR8PY2YrCXkn6ZQIysVDp8v74+o5QHGoKYUw9IojB
         VwDQslscQGW9cYBZbGedv9tH1cMnorngGns+cDo2tXLg4WKBJ1PK3U4rc1mtPRAKWQ
         aUfgQraSQYuZg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 88/92] sunrpc: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:53 -0400
Message-ID: <20230705190309.579783-86-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 0b6034fab9ab..f420d8457345 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -472,7 +472,7 @@ rpc_get_inode(struct super_block *sb, umode_t mode)
 		return NULL;
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
-- 
2.41.0

