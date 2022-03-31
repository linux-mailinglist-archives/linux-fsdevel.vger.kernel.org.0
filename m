Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173C14EDCCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiCaPdW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiCaPdW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A9F21C701;
        Thu, 31 Mar 2022 08:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60CA161AE4;
        Thu, 31 Mar 2022 15:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C4EC340F3;
        Thu, 31 Mar 2022 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740693;
        bh=ZlzjrhJwihw4PodPL/miGHnNRfWsGW7gPpCGkZ2TtMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMRHPEMaONOOXQBk1kxEbDYqgJgNwaqh0/8/L+Itgg6BiFK6KOZFi70NkAUdNt5/L
         kI9aj0t9AwtRLeEcpbIXUD+8dJ3gqaarypkdDppBnlYs546tXjrIlAgfRVxzauwGvz
         hSe0F2mYXc81Tn2+ICopQpyl8zybxyg8Sv1G8tLO03brdFYe1jAYHJxAyn+0oXwrsy
         k7Z03aTKXOBmixXOzaNsc3oi8pR7pquugA6puOXycDG6EJvXDhPrsGykowpKvkbHms
         vdhfAJKLvCiXdHBW1EP0zj3ggmOvZ5YcgbpfJJY5xH9ZTrTJdXindmgxGl+Ihfb6GC
         xkt2U3FvMlWUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v12 01/54] vfs: export new_inode_pseudo
Date:   Thu, 31 Mar 2022 11:30:37 -0400
Message-Id: <20220331153130.41287-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
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

