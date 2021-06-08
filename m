Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4714039FC2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 18:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFHQP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFHQP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:15:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CACC061574;
        Tue,  8 Jun 2021 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/xv5Jd1LwNtxUXxsgwOwvaHap3qm6MsdrqO3O+zcubA=; b=KpCZpuPjzDDgo7hKOjKWoYKdrx
        3ijnLI0y/XyeyHf4+WjkzsgiULBb4KZq5ltjJeEQWXm7DI37AWZgBzxyx5/kTWVpOQtkh4kkOsZCn
        tOdNzMrsBUrbUCwXIAd9n9JVXQAbZYoWWUwYd7bo8zSkl7WGf75Wb2baR5K8erQQ+UA+jd5rsVYxw
        pfi91HDJ6P1HE7FMalEUeWhL30npvOeaZo3JeyudlfanXaSWTLGWkRexoaA/TfYl3cihWiA/FOXvt
        xY0lhA5WuHKmP4xwUAVPxB6Uq6HKUkGuom9C3j2KVXdgFON3/zqxrauY2FAlHviwkihCGC6LKiN6l
        l/biNxJQ==;
Received: from [2001:4bb8:192:ff5f:74ed:7c4f:a5ee:8dcb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqeM5-009SvR-SW; Tue, 08 Jun 2021 16:13:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, gmpy.liaowx@gmail.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mark pstore-blk as broken
Date:   Tue,  8 Jun 2021 18:13:27 +0200
Message-Id: <20210608161327.1537919-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pstore-blk just pokes directly into the pagecache for the block
device without going through the file operations for that by faking
up it's own file operations that do not match the block device ones.

As this breaks the control of the block layer of it's page cache,
and even now just works by accident only the best thing is to just
disable this driver.

Fixes: 17639f67c1d6 ("pstore/blk: Introduce backend for block devices")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 8adabde685f1..328da35da390 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -173,6 +173,7 @@ config PSTORE_BLK
 	tristate "Log panic/oops to a block device"
 	depends on PSTORE
 	depends on BLOCK
+	depends on BROKEN
 	select PSTORE_ZONE
 	default n
 	help
-- 
2.30.2

