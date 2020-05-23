Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196EC1DF5B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 09:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbgEWHaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 03:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgEWHao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 03:30:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9220BC061A0E;
        Sat, 23 May 2020 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wwwBPMXZk0+Xy+2OxrNolNTyI26gvme/Du4ivy1Q6t8=; b=MX13GNdfKHFYqFR1ZMr/SJu1gn
        QOmCVB6di3sAOKoZlzMZTM/fSuNAvxoJjZR5ez2TztPnQN/3XnbgoEeFhnkX28Vl8g+154tq0XZ38
        d8zeLRlDWUehL+qv7eVGM7xTCPchrJKB/6MecTOyYsS/KoMBAwKiQK/ys59VbaP7vRS86WxyS3tev
        2eqwno7eSv1TYynXsNNhRFG6OfbXdaY6kLPGNY25zG28fJGfB8pJPz0SzbomX2pclcXYf1NvoQiLv
        js91SsShLQ50KR/68n4m0XC5zVvh2C4U/mXFEKbG7hUkPxnNog0mMJDCIE9FiBmllcNN8EPPDzu9V
        DzO2R5RQ==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcOcG-0007wq-0b; Sat, 23 May 2020 07:30:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 9/9] ext4: remove the access_ok() check in ext4_ioctl_get_es_cache
Date:   Sat, 23 May 2020 09:30:16 +0200
Message-Id: <20200523073016.2944131-10-hch@lst.de>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f81acbbb1b12e..2162db0c747d2 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -754,11 +754,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	fieinfo.fi_extents_max = fiemap.fm_extent_count;
 	fieinfo.fi_extents_start = ufiemap->fm_extents;
 
-	if (fiemap.fm_extent_count != 0 &&
-	    !access_ok(fieinfo.fi_extents_start,
-		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
-		return -EFAULT;
-
 	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
 			fiemap.fm_length);
 	fiemap.fm_flags = fieinfo.fi_flags;
-- 
2.26.2

