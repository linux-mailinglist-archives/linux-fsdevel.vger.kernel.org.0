Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64D9533F4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiEYOe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiEYOe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 10:34:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0958A76F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K85kvpkkDfVbzOHRCHctLisJx1mpqqPA1WaPiZL9mvw=; b=Tpv3RwW+GGQjiaI+MGU3koMQW4
        MzXFdVIB8tJLWqQM2V7fIEYwPaap15TH+hpePHhQBYkMsOuKoE/8dD0JrGcjM+g5iWWdfCwtqtOI3
        w70po1kcIxIrwjqI5B2y/Pe0hLPCSGDuuE3kUhfok3Y1mcI9AfOrWK7+Tw/u9Xl0FwxYHNhNQoURe
        TlLjay2GWiiieUSs9b+92x7QMysUtUTF2IR/23SAYfNvfnRCgbw2SMCIpwDx4GONYht54vPZlTO7h
        9lYHL9bpq01hmD/GvZ5cUPK4pH2Rs1nW1SQgryU2NaXuJ/iEv7DPxOmlawnb8Z7Vzvua+Ge/MGhCC
        4VUt+5Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nts5d-000R54-9b; Wed, 25 May 2022 14:34:21 +0000
Date:   Wed, 25 May 2022 15:34:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <Yo4+bf9ALQdF/UCR@casper.infradead.org>
References: <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
 <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 23, 2022 at 12:42:33AM +0000, Al Viro wrote:
> At the moment it's carved up into 6 commits:
> 	btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression

I happpen to need something similar for JFS, so I tried it out.
There's a mistake where dio->flags should have been dio_flags.
I also added a comment on the definition of DIO_NOSYNC.

(the btrfs patch didn't apply cleanly, so I just dropped it since I
wasn't going to be touching btrfs anyway)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 370c3241618a..6a361131080f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -548,7 +548,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		/* for data sync or sync, we need sync completion processing */
-		if (iocb->ki_flags & IOCB_DSYNC)
+		if (iocb->ki_flags & IOCB_DSYNC &&
+		    !(dio_flags & IOMAP_DIO_NOSYNC))
 			dio->flags |= IOMAP_DIO_NEED_SYNC;
 
 		/*
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
