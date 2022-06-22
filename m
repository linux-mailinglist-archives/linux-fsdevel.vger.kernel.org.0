Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E155415D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356703AbiFVEP6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356486AbiFVEP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:15:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC604209
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t07ZYlu7itK5ZfJfROlY9l0+O1mByVNYEP7uyOYsI4g=; b=fA7RJO5GE12hnxIvfGGbALiDCR
        BW4fMZX/8lSx5pgebc1JZQk2E8Ap6iEMOxVoJ/q3CLqca0uLG9WcvQ0yRofcWgU4rr/l1TNmaVZAO
        wbo/5Cw0Av9uAhgGmKgFTEhW1tXKZFOGH0pB39+R+6GOyeC+ws0j7NjsL0AYI41pKvHK8qW04EK1L
        ndbZhAsIRYY94ug0KXGjdPSj3pikeH6z7I3mIHqlme0dp/OHP63lUpNxMO014RMpr7oJeiJjQZYCH
        WCn0gat4IvOZK6ni80HHYhYLP/y2Gea9WPPl+HIjtsonYh5jI7WsAhf6KGDjtZY+Kn86Tj1TLzDo6
        OPw90BbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmS-0035vR-TH;
        Wed, 22 Jun 2022 04:15:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 03/44] teach iomap_dio_rw() to suppress dsync
Date:   Wed, 22 Jun 2022 05:15:11 +0100
Message-Id: <20220622041552.737754-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New flag, equivalent to removal of IOCB_DSYNC from iocb flags.
This mimics what btrfs is doing (and that's what btrfs will
switch to).  However, I'm not at all sure that we want to
suppress REQ_FUA for those - all btrfs hack really cares about
is suppression of generic_write_sync().  For now let's keep
the existing behaviour, but I really want to hear more detailed
arguments pro or contra.

[folded brain fix from willy]

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/iomap/direct-io.c  | 20 +++++++++++---------
 include/linux/iomap.h |  6 ++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 370c3241618a..c10c69e2de24 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,17 +548,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb->ki_flags & IOCB_DSYNC &&
+		    !(dio_flags & IOMAP_DIO_NOSYNC)) {
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
-		/*
-		 * For datasync only writes, we optimistically try using FUA for
-		 * this IO.  Any non-FUA write that occurs will clear this flag,
-		 * hence we know before completion whether a cache flush is
-		 * necessary.
-		 */
-		if ((iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) == IOCB_DSYNC)
-			dio->flags |= IOMAP_DIO_WRITE_FUA;
+		       /*
+			* For datasync only writes, we optimistically try
+			* using FUA for this IO.  Any non-FUA write that
+			* occurs will clear this flag, hence we know before
+			* completion whether a cache flush is necessary.
+			*/
+			if (!(iocb->ki_flags & IOCB_SYNC))
+				dio->flags |= IOMAP_DIO_WRITE_FUA;
+		}
 	}
 
 	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index e552097c67e0..c8622d8f064e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -353,6 +353,12 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * The caller will sync the write if needed; do not sync it within
+ * iomap_dio_rw.  Overrides IOMAP_DIO_FORCE_WAIT.
+ */
+#define IOMAP_DIO_NOSYNC		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.30.2

