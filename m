Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5E1BAC54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 20:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgD0SU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726228AbgD0SU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E78C0610D5;
        Mon, 27 Apr 2020 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wiK8u2lq86CLEJk2sltbigywC//kREoH6b7fL3RvaWg=; b=e/+8k00mqcfTWYriIXfKmf08/X
        cQxqOE8yNydgrjrrrKWwgly2dHrXjiBqyTXmKWRHBJS9w0akmq6ev/XlfCMVKlZh+WG0+SeEn2iuc
        tyWpKVRryZhwPw00d2lopNc+GmJ0hMCbPsVKYcil/ahewVx9w/3xJlA3nKQnwhATWn3VnOBbL/+hC
        wsLbovhP0ghZmJeBsxQe2mpf9/GUlRddt1v9gHfOk36fp2+e0oLEmJEPJ3p/YwqxhdKrSbSnIomX4
        bNsQVzoJNTdna1zZJVX4yulr1OfZ7kmN21IXPBxrOR6dMyz+hDaCtwMnx2kdSdf2yA+qLCCzamQCH
        H6oVRfmg==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT8Mk-0004d4-Lg; Mon, 27 Apr 2020 18:20:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 11/11] ext4: remove the access_ok() check in ext4_ioctl_get_es_cache
Date:   Mon, 27 Apr 2020 20:19:57 +0200
Message-Id: <20200427181957.1606257-12-hch@lst.de>
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
 fs/ext4/ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 0746532ba463d..7fded54d2dba9 100644
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
 	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
 		filemap_write_and_wait(inode->i_mapping);
 
-- 
2.26.1

