Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB28D3F20D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhHSTmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235154AbhHSTmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHaEisr2dnAFJWG5UtVLVCNWXivpQa+HdNcskVui81k=;
        b=O5svP30sWqVj8jvIR5eJK3pgXn26nxYWPDBS5LaYcOo6s4qB99DCesRs6dhrhWybZnguZS
        xL21mEDTvZQgIBTTrWGZ/eBjNrxuim4+GRezfCjIxNYIHIkcUaD/tyS3n8swAaJxAToHwb
        apOU40pV7xEIdLXA9Ntk7ZKYnFyqMYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ei7g3Qq-NMiokc7jEeJKwQ-1; Thu, 19 Aug 2021 15:41:54 -0400
X-MC-Unique: ei7g3Qq-NMiokc7jEeJKwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A1C801AC5;
        Thu, 19 Aug 2021 19:41:52 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC54D60938;
        Thu, 19 Aug 2021 19:41:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 11/19] gfs2: Move the inode glock locking to gfs2_file_buffered_write
Date:   Thu, 19 Aug 2021 21:40:54 +0200
Message-Id: <20210819194102.1491495-12-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, for buffered writes, we were taking the inode glock in
gfs2_iomap_begin and dropping it in gfs2_iomap_end with the intention of
not holding the inode glock while iomap_write_actor faults in user
pages.  It turns out that iomap_write_actor is called inside iomap_begin
... iomap_end, so the user pages were still faulted in while holding the
inode glock and the locking code in iomap_begin / iomap_end was
completely pointless.

Move the locking into gfs2_file_buffered_write instead.  We'll take care
of the potential deadlocks due to faulting user pages while holding a
glock in a subsequent patch.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/bmap.c | 60 +-------------------------------------------------
 fs/gfs2/file.c | 27 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ed8b67b21718..0d90f1809efb 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -961,46 +961,6 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 	goto out;
 }
 
-static int gfs2_write_lock(struct inode *inode)
-{
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	int error;
-
-	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &ip->i_gh);
-	error = gfs2_glock_nq(&ip->i_gh);
-	if (error)
-		goto out_uninit;
-	if (&ip->i_inode == sdp->sd_rindex) {
-		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
-
-		error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE,
-					   GL_NOCACHE, &m_ip->i_gh);
-		if (error)
-			goto out_unlock;
-	}
-	return 0;
-
-out_unlock:
-	gfs2_glock_dq(&ip->i_gh);
-out_uninit:
-	gfs2_holder_uninit(&ip->i_gh);
-	return error;
-}
-
-static void gfs2_write_unlock(struct inode *inode)
-{
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-
-	if (&ip->i_inode == sdp->sd_rindex) {
-		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
-
-		gfs2_glock_dq_uninit(&m_ip->i_gh);
-	}
-	gfs2_glock_dq_uninit(&ip->i_gh);
-}
-
 static int gfs2_iomap_page_prepare(struct inode *inode, loff_t pos,
 				   unsigned len, struct iomap *iomap)
 {
@@ -1119,11 +1079,6 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
 	return ret;
 }
 
-static inline bool gfs2_iomap_need_write_lock(unsigned flags)
-{
-	return (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT);
-}
-
 static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 			    unsigned flags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -1136,12 +1091,6 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 		iomap->flags |= IOMAP_F_BUFFER_HEAD;
 
 	trace_gfs2_iomap_start(ip, pos, length, flags);
-	if (gfs2_iomap_need_write_lock(flags)) {
-		ret = gfs2_write_lock(inode);
-		if (ret)
-			goto out;
-	}
-
 	ret = __gfs2_iomap_get(inode, pos, length, flags, iomap, &mp);
 	if (ret)
 		goto out_unlock;
@@ -1169,10 +1118,7 @@ static int gfs2_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 	ret = gfs2_iomap_begin_write(inode, pos, length, flags, iomap, &mp);
 
 out_unlock:
-	if (ret && gfs2_iomap_need_write_lock(flags))
-		gfs2_write_unlock(inode);
 	release_metapath(&mp);
-out:
 	trace_gfs2_iomap_end(ip, iomap, ret);
 	return ret;
 }
@@ -1220,15 +1166,11 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	}
 
 	if (unlikely(!written))
-		goto out_unlock;
+		return 0;
 
 	if (iomap->flags & IOMAP_F_SIZE_CHANGED)
 		mark_inode_dirty(inode);
 	set_bit(GLF_DIRTY, &ip->i_gl->gl_flags);
-
-out_unlock:
-	if (gfs2_iomap_need_write_lock(flags))
-		gfs2_write_unlock(inode);
 	return 0;
 }
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 55ec1cadc9e6..813154d60834 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -880,11 +880,38 @@ static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	ssize_t ret;
 
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &ip->i_gh);
+	ret = gfs2_glock_nq(&ip->i_gh);
+	if (ret)
+		goto out_uninit;
+
+	if (inode == sdp->sd_rindex) {
+		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
+
+		ret = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE,
+					 GL_NOCACHE, &m_ip->i_gh);
+		if (ret)
+			goto out_unlock;
+	}
+
 	current->backing_dev_info = inode_to_bdi(inode);
 	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
 	current->backing_dev_info = NULL;
+
+	if (inode == sdp->sd_rindex) {
+		struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
+
+		gfs2_glock_dq_uninit(&m_ip->i_gh);
+	}
+
+out_unlock:
+	gfs2_glock_dq(&ip->i_gh);
+out_uninit:
+	gfs2_holder_uninit(&ip->i_gh);
 	return ret;
 }
 
-- 
2.26.3

