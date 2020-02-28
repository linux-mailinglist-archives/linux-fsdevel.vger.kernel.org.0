Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244B417406D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1ToJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 14:44:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:32836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgB1ToJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:44:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 539FFAD57;
        Fri, 28 Feb 2020 19:44:06 +0000 (UTC)
Date:   Fri, 28 Feb 2020 13:44:01 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200228194401.o736qvvr4zpklyiz@fiona>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dkh3yhd3fkaztkba"
Content-Disposition: inline
In-Reply-To: <20200225205342.GA12066@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--dkh3yhd3fkaztkba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 12:53 25/02, Christoph Hellwig wrote:
> On Fri, Feb 21, 2020 at 10:21:04AM +0530, Ritesh Harjani wrote:
> > >   		if (dio->error) {
> > >   			iov_iter_revert(dio->submit.iter, copied);
> > > -			copied = ret = 0;
> > > +			ret = 0;
> > >   			goto out;
> > >   		}
> > 
> > But if I am seeing this correctly, even after there was a dio->error
> > if you return copied > 0, then the loop in iomap_dio_rw will continue
> > for next iteration as well. Until the second time it won't copy
> > anything since dio->error is set and from there I guess it may return
> > 0 which will break the loop.
> 


Reading the code again, there are a few clarifications.

If iomap_end() handles (written < length) as an error, iomap_apply()
will return an error immediately. It will not execute the 
loop a second time.

On the other hand, if there is no ->iomap_end() defined by the
filesystem such as in the case of XFS, we will need to check for
dio->error in the do {} while loop of iomap_dio_rw().

> In addition to that copied is also iov_iter_reexpand call.  We don't
> really need the re-expand in case of errors, and in fact we also
> have the iov_iter_revert call before jumping out, so this will
> need a little bit more of an audit and properly documented in the
> commit log.

We are still handling this as an error, so why are we concerned about
expanding? There is no success/written returned in iomap_dio_rw() call
in case of an error.

Attached is an updated patch.


-- 
Goldwyn

--dkh3yhd3fkaztkba
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0004-iomap-return-partial-I-O-count-on-error-in-iomap_dio.patch"

From af694f4fc662daf5c62a78391ced5f8e2d4beed2 Mon Sep 17 00:00:00 2001
From: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date: Thu, 13 Feb 2020 13:28:55 -0600
Subject: [PATCH] iomap: return partial I/O count on error in
 iomap_dio_bio_actor

Currently, I/Os that complete with an error indicate this by passing
written == 0 to the iomap_end function.  However, btrfs needs to know how
many bytes were written for its own accounting.  Change the convention
to pass the number of bytes which were actually written, and change the
only user (ext4) to check for a short write instead of a zero length write.

In case a filesystem does not define an ->iomap_end(), check for
dio->error after the iomap_apply() call to diagnose the error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/ext4/inode.c      | 2 +-
 fs/iomap/direct-io.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fa0ff78dc033..d52c70f851e6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3475,7 +3475,7 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	 * the I/O. Any blocks that may have been allocated in preparation for
 	 * the direct I/O will be reused during buffered I/O.
 	 */
-	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
+	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written < length)
 		return -ENOTBLK;
 
 	return 0;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 41c1e7c20a1f..a0002311cc20 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		size_t n;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+			ret = 0;
 			goto out;
 		}
 
@@ -499,6 +499,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	do {
 		ret = iomap_apply(inode, pos, count, flags, ops, dio,
 				iomap_dio_actor);
+
+		if (ret >= 0 && dio->error)
+			ret = dio->error;
+
 		if (ret <= 0) {
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
-- 
2.25.0


--dkh3yhd3fkaztkba--
