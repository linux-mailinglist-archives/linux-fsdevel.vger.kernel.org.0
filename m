Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257611BA097
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgD0J7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 05:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgD0J7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:59:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C6C0610D5;
        Mon, 27 Apr 2020 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gZhdoYkjuvbpOueM83yzKSJUBUXDbflvgTLRFJS+QTc=; b=egc5kG+GVTRAk4M2K5JwCl+YSH
        c4IgpR1u4TjSs0pHrVDim1P8p7O9HbCLPYfHbXOuSfDd7PMgmoFLXh4qX2ZyFdArTfnXwelDJyIDQ
        wPI98m3X70sk5s+FQ9IwIrHVzYJqU3D+wjp4DoGd7Dg86ev1ll6Nqvb4xHfnGakmAELeeCP6gVxAL
        4yeJT8yNq/pJ/48X/ZpZjyCeveAOhgRxwT8gSt/8Wnwx79X6P07c55x7jbGE02fxxHHyGjz2H648x
        0G3ON9SsYPWoILEhSaI19VPcCSq4WVU3NYzWKNB2V1SKLKVHXAK/u/sG1EPKvAzdTgiBjytU+G+Ds
        YYi8NDhg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT0Xe-0003go-HB; Mon, 27 Apr 2020 09:59:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 4/8] ext4: remove the call to fiemap_check_flags in ext4_fiemap
Date:   Mon, 27 Apr 2020 11:58:54 +0200
Message-Id: <20200427095858.1440608-5-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427095858.1440608-1-hch@lst.de>
References: <20200427095858.1440608-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_fiemap already calls fiemap_check_flags first thing, so this
additional check is redundant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/extents.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d2a2a3ba5c44a..a41ae7c510170 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4866,9 +4866,6 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
 	}
 
-	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR))
-		return -EBADR;
-
 	/*
 	 * For bitmap files the maximum size limit could be smaller than
 	 * s_maxbytes, so check len here manually instead of just relying on the
-- 
2.26.1

