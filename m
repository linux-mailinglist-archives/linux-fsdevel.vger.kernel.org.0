Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564E54E409E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiCVOPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiCVOPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1447E084;
        Tue, 22 Mar 2022 07:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57B8DB81D07;
        Tue, 22 Mar 2022 14:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E76AC340EE;
        Tue, 22 Mar 2022 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958400;
        bh=AaxOnL8mdAdq+KdGal4+3WiKd1Y2UhA87mL/WJTtmAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGgcsyxFKWsfinbcBaUgit/ZuxamZeBfZq7MQka2Yo5DzyF3uQSHtzAR6QCWg0Z2F
         rla79syQ/T7Z9DjuJBwZ8NUCrFM7+P2dLvY3eFiX1G/A4B1N4Hf9/QYohHS41n2uwh
         QbexeUb6Yks+sU4BIqm+RsRZxg6R/llojGfAryGkXfgoDLJ/8V4UcjWNz1+cuYjkWK
         9i2eaffC4DsimxyecPJXvDLaPnM1H+k9FT8nsEtddlliQ/VM/5F6wv++X2wvyhac0W
         r32mfX1SjZVrH18cDF2/JD42FOPwLH9dmBReIO/xGx/TFgSYhg+vcDNTxQCL/chfO8
         CtBazQqNxhCuA==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [RFC PATCH v11 01/51] vfs: export new_inode_pseudo
Date:   Tue, 22 Mar 2022 10:12:26 -0400
Message-Id: <20220322141316.41325-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph needs to be able to allocate inodes ahead of a create that might
involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
but it puts the inode on the sb->s_inodes list and when we go to hash
it, that might be done again.

We could work around that by setting I_CREATING on the new inode, but
that causes ilookup5 to return -ESTALE if something tries to find it
before I_NEW is cleared. This is desirable behavior for most
filesystems, but doesn't work for ceph.

To work around all of this, just use new_inode_pseudo which doesn't add
it to the sb->s_inodes list.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

Al, can I get your Acked-by on this if you're OK with it? Alternately if
you just want to take it in via your tree, then that would be fine too.

diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..9ddf7d1a7359 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1025,6 +1025,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.35.1

