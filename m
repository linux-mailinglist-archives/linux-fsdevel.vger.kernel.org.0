Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95D13AECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgANQMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 11:12:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgANQMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x+ttUEN/NS6BrlO/9nKVYw2uuqodMabBguY4qU1kFWc=; b=iWnmoMlRQkItEjXzvB/HH5yDWZ
        PS0zTIEcudypIh4nwuowXENkKhWW01nf5gAcY00+vGC0HIrBHoSkdhNhqbmTlbaubBeUoQ/4FuLW+
        MvXfiI4rJZxhKmKyciLADxGonrBgfq62VBcA4ZdoFDvCbjDtN0WTJTOtSKfUb3+ki9+rNXkKRlu7b
        s0kyyX8KYDNz94WWMCMSYaFE+gzN1dwLgd/CtX/HmpCd151jSZJF0RrWdIoemOyd/wSHAfBETH/bk
        JEKJ0p7/d68aL/JzgCs3ClBs1coxtIf0tk2hlPQC1Z515sGlE5pyMYwgo1OIXxLkBamqVUnkqiKie
        gLwFZ78w==;
Received: from [2001:4bb8:18c:4f54:fcbb:a92b:61e1:719] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irOoF-0000E6-P5; Tue, 14 Jan 2020 16:12:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/12] gfs2: hold i_rwsem until AIO completes
Date:   Tue, 14 Jan 2020 17:12:22 +0100
Message-Id: <20200114161225.309792-10-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch gfs from the magic i_dio_count scheme to just hold i_rwsem
until the actual I/O has completed to reduce the locking complexity
and avoid nasty bugs due to missing inode_dio_wait calls.

Note that gfs only uses i_rwsem for direct I/O writes, not for
reads so no change to the read behavior.  It might also make sense
to use the same scheme for the gfs2 internal cluster lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/bmap.c  |  2 --
 fs/gfs2/file.c  |  6 ++++--
 fs/gfs2/glops.c | 10 ++--------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 08f6fbb3655e..226f4eb680c7 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2181,8 +2181,6 @@ int gfs2_setattr_size(struct inode *inode, u64 newsize)
 	if (ret)
 		return ret;
 
-	inode_dio_wait(inode);
-
 	ret = gfs2_rsqa_alloc(ip);
 	if (ret)
 		goto out;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 2260cb5d31af..82a2f313a3e6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -806,7 +806,8 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (offset + len > i_size_read(&ip->i_inode))
 		goto out;
 
-	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL, 0);
+	ret = iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
+			   IOMAP_DIO_RWSEM_EXCL);
 
 out:
 	gfs2_glock_dq(&gh);
@@ -923,7 +924,8 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return generic_write_sync(iocb, ret);
 
 out_unlock:
-	inode_unlock(inode);
+	if (ret != -EIOCBQUEUED)
+		inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 4ede1f18de85..a705eeb75117 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -243,11 +243,8 @@ static void inode_go_sync(struct gfs2_glock *gl)
 	struct address_space *metamapping = gfs2_glock2aspace(gl);
 	int error;
 
-	if (isreg) {
-		if (test_and_clear_bit(GIF_SW_PAGED, &ip->i_flags))
-			unmap_shared_mapping_range(ip->i_inode.i_mapping, 0, 0);
-		inode_dio_wait(&ip->i_inode);
-	}
+	if (isreg && test_and_clear_bit(GIF_SW_PAGED, &ip->i_flags))
+		unmap_shared_mapping_range(ip->i_inode.i_mapping, 0, 0);
 	if (!test_and_clear_bit(GLF_DIRTY, &gl->gl_flags))
 		goto out;
 
@@ -440,9 +437,6 @@ static int inode_go_lock(struct gfs2_holder *gh)
 			return error;
 	}
 
-	if (gh->gh_state != LM_ST_DEFERRED)
-		inode_dio_wait(&ip->i_inode);
-
 	if ((ip->i_diskflags & GFS2_DIF_TRUNC_IN_PROG) &&
 	    (gl->gl_state == LM_ST_EXCLUSIVE) &&
 	    (gh->gh_state == LM_ST_EXCLUSIVE)) {
-- 
2.24.1

