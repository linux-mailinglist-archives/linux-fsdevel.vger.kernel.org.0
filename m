Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB91C5BF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgEEPnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgEEPnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A021C061A0F;
        Tue,  5 May 2020 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=i9UYRfuCB6V3KkW4tyodvG9ljpbwXXvXBnAASuky1JA=; b=hdXhZquRZ3VA8667LbnB3bsxvX
        6B7Fot+HqeKhF3r+09umqfmqH+HttUBP2QGmwcGKoFw9z73nKLoyukZka9+gC6iKwwRGubNjRN/V4
        3/5dsSh7KaH9NdwB74Xzifd4b7BkbXFPYzY6x0ZqWsGugif5R3MCva0soZWVRca9h7Znmf4wyUHR6
        Meauh4wPilNlPXVC0cPnNVjM4GfkvDwpoj4e51nMAL7jf7DBebsytkSi6E3oVk6xNq9TzOsGlioj3
        r9h+5/b7/9CqdpzG+ko+SvV1dH4JFIn7+LkHKvwTjsdqlQcEJBVCvH8tN05MY8y2mZ8fqQpNIk5Vp
        dREl7rjQ==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjP-00040I-Ts; Tue, 05 May 2020 15:43:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 04/11] ext4: remove the call to fiemap_check_flags in ext4_fiemap
Date:   Tue,  5 May 2020 17:43:17 +0200
Message-Id: <20200505154324.3226743-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505154324.3226743-1-hch@lst.de>
References: <20200505154324.3226743-1-hch@lst.de>
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
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
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
2.26.2

