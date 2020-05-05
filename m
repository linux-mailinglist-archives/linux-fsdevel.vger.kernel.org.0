Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A727C1C5C0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 17:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgEEPn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEEPn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 11:43:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EEEC061A10;
        Tue,  5 May 2020 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Wm55+kaVzF02vi6ubXJtcTkLmaBwejbSqugyKO7Nr0A=; b=P7YUGRhZD4xKRSOPXCPlindfQ8
        6f8+ZUNYb3JZIVwcbAcqZu8/hEbtV/gm0YHc9+gg6JHZs+bzlQ8qHKzBaWokO6N5hTR+z9MuQXlQF
        z/Z2C82abEvBOidEFbDRiZMFYA2VNbBCZNc7E9jOUrSbAaYak0dmx1E2y9BN9gZD3PWIbhEX7732o
        bBBLqvRepQQ+cahHl4IreOTSAOc3YpYOg5t+lhF2CuaJmuNFdCJ4PKp/EuJ1YnSb3SopKdVpMRODx
        +IHkzrX/+UZDFTemNELhmV7tYIsWz7z9vuh9BXItp9j2HZaRJKWJnxQ74N2nSmUMmYMxIyeVyEikR
        qYSWXwHA==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVzjh-00046v-Ip; Tue, 05 May 2020 15:43:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 11/11] ext4: remove the access_ok() check in ext4_ioctl_get_es_cache
Date:   Tue,  5 May 2020 17:43:24 +0200
Message-Id: <20200505154324.3226743-12-hch@lst.de>
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

access_ok just checks we are fed a proper user pointer.  We also do that
in copy_to_user itself, so no need to do this early.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
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

