Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6F26955E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINTRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgINTRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:11 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026B5217BA;
        Mon, 14 Sep 2020 19:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111031;
        bh=ctqcwP3ioEky4uhXdhIOKc7o4iFce41kFOkOTcCjx44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii+vO0PvfXW5MLyv9hHOjNg7fgOxZyCatcjvL6iQ/ZAti5W1JeWRh96TX4YDTaP8Y
         wN5oABh9T/USFtGrAuaxs1CZKXN9sbRllH8cTm2pPzN4+LcCtRvgdI+kAZLWfJcCXk
         aHB7/UG9zMUr0s24QaRpg/+ejKRMdTatAimo5jBQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 01/16] vfs: export new_inode_pseudo
Date:   Mon, 14 Sep 2020 15:16:52 -0400
Message-Id: <20200914191707.380444-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph needs to be able to allocate inodes ahead of a create that might
involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
but it puts the inode on the sb->s_inodes list and when we go to hash
it, that might be done again.

We could work around that by setting I_CREATING on the new inode, but
that causes ilookup5 to return -ESTALE if something tries to find it
before I_NEW is cleared. To work around all of this, just use
new_inode_pseudo which doesn't add it to the list.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..61554c2477ab 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
 	}
 	return inode;
 }
+EXPORT_SYMBOL(new_inode_pseudo);
 
 /**
  *	new_inode 	- obtain an inode
-- 
2.26.2

