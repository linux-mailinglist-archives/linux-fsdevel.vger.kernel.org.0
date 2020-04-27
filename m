Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B901BAC50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0SUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgD0SUY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A48C0610D5;
        Mon, 27 Apr 2020 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pBDtFKgKjFPTy/7kZQr6MjBBEStoexbRszb28pwTV8g=; b=e2w8d7Zn8pEP+kltNMu3Tb8Bq5
        57+PSY23PPuEgo9i5nTwlWTtu+rl8xEw3pgshCSAdlPTV1pxnp59RKTcA5Ydj1RSe7NZkyeuKnzOV
        /zbLbQ7oC+VqfbVkCx18wnvK/Vg3s779Ur+sGOJCsakZcvg9Tr9sF2s4+Ou7d65y9aUYHAiK9gIde
        BUBxEdHqxTNrnVCOyZD/lkYXXA4nu+sovXAm4sPLKhIcLYgufUcKYai6abZ8uqQXzhWHE0+3y1mo7
        1gQei8xp1G/Wi8X4WVbj18hIj00o8i+6z+IfPrISx/8XyjZTbD6CTsuut0/i9ny3o5/DhbmYbf71n
        egcrWlcA==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8Mi-0004cF-8j; Mon, 27 Apr 2020 18:20:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 10/11] fs: remove the access_ok() check in ioctl_fiemap
Date:   Mon, 27 Apr 2020 20:19:56 +0200
Message-Id: <20200427181957.1606257-11-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427181957.1606257-1-hch@lst.de>
References: <20200427181957.1606257-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

access_ok just checks we are fed a proper user pointer.  We also do that
in copy_to_user itself, so no need to do this early.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ioctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index ae0d228d18a16..d24afce649037 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -209,13 +209,9 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
 
-	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
-		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
-		return -EFAULT;
-
 	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
 			fiemap.fm_length);
+
 	fiemap.fm_flags = fieinfo.fi_flags;
 	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
 	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
-- 
2.26.1

