Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708A46EB79
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhLIPk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 10:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbhLIPkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:40:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63438C061746;
        Thu,  9 Dec 2021 07:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E26CB82511;
        Thu,  9 Dec 2021 15:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F368C341C7;
        Thu,  9 Dec 2021 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639064210;
        bh=nly5tQeR/A1zmrYakOhDqyeFJLNnKn0nwyBaa8+cYb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxPI8Zent7f4Ohx3cG0o2+H9naczcevT98Sm3qtHajDsWpkBlVfCik+vwdsEWHFGt
         /eMasqPD45zULk8mYahMZMuTHZG1FjG6mZDOhGLAsYONArdM4nKDoQyFxXH8Ai1fGT
         h+zJvcNTGwJYidaWGBzFRVlx+pDFITJ5K1sQzp7tKwcrwqPefQ7k384QyWdSZVtmU1
         NadpdWVkYzq6+b0gcqGEDfbnXG8L4p/BEeDsk00vs+qGPRi13KeXqFDz7RrJhqfJ/5
         pKyHWeIink2V0gon0yTCRSJGeudRQKZy7K/oMrAzfZjDKJLasPszxrOFcP3d0Gnbtm
         G1sBThYnhY0Qg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/36] vfs: export new_inode_pseudo
Date:   Thu,  9 Dec 2021 10:36:12 -0500
Message-Id: <20211209153647.58953-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211209153647.58953-1-jlayton@kernel.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 6b80a51129d5..7fd85501bb32 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -951,6 +951,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.33.1

