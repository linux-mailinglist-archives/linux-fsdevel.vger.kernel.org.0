Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C80D1DF5AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgEWHam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgEWHam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D2EC061A0E;
        Sat, 23 May 2020 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=leXRIgudOnQhC6MyjXK1hYrv7FgmR4zM15i9I7RzeJI=; b=MB+8/0pyp96Sb5iN3OD16CLo2E
        9LQGUQXmJhAMnncOXzsf2XqTmtNssc+9gf7+rTxHVUP2jg2BMbYFsNDzs5lkETKrI5xc9iCCelS+d
        jNslhCrQ9mzlCzaZVGeF75a4tXfr3fnBKpHoCnTEsZn0Z79ddmWUGTGt49NuaHRCDFuo5/ksp963i
        SuWasYCaRZqh/64dd7QqYstJFyqseUYyB0/wArP3rfwPgFn2UpxC7qw3AG7khq7G6K5b1pSEY+zdC
        rd02c5tl6tz92O7xQ2PjhbnIRUbQ+GRIS2KaIDlgEkYraNSkABVJHB6C++HEw5PQtA/t0SXcRntrx
        z05i1pKA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcOcD-0007vh-8T; Sat, 23 May 2020 07:30:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 8/9] fs: remove the access_ok() check in ioctl_fiemap
Date:   Sat, 23 May 2020 09:30:15 +0200
Message-Id: <20200523073016.2944131-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523073016.2944131-1-hch@lst.de>
References: <20200523073016.2944131-1-hch@lst.de>
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
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ioctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index b16e962340db6..d69786d1dd911 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -213,13 +213,9 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
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
2.26.2

