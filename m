Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43C1C0441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3R7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgD3R7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:59:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336BC035494;
        Thu, 30 Apr 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lPMf1Z1GFT7QUGBGKnoHwGy463ZqTcbG/VsC/8ckYeE=; b=BHla1V7kaYXJqHABxydhsXHLxN
        KJpUGrBVjN3N38i+33Z3RkE0+PkDu1Cou4c40LcmJJtzd3fFu8BsHfPOsXW8K5Uxbyh5M75WzSQZs
        /ltcLXK5SifCKaNrMUfLIDWwx0ET6spmr1grsBmS22VlSuu+dMxDo9IJiqNoLCKNfHwAhxB3jvmx9
        t0JHu0lkp+ymGctsCYe2DMS5V0Ck7U7ERVX+RZ3fYnxuiJ+b2MUz7eLVYci50VqbGheSMzvqFNRGW
        QkHlhSUlpVu4HRRtEFX1+rqw6DnLJjkl371QiBQMiIzWo1BrJa7bW663xBYInX5EaSRM6Ij4de1JL
        QeNYk55g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUDSb-00050J-27; Thu, 30 Apr 2020 17:58:57 +0000
Date:   Thu, 30 Apr 2020 10:58:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pipe: read/write_iter() handler should check for
 IOCB_NOWAIT
Message-ID: <20200430175856.GX29705@bombadil.infradead.org>
References: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273d8294-2508-a4c2-f96e-a6a394f94166@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:24:46AM -0600, Jens Axboe wrote:
> Pipe read/write only checks for the file O_NONBLOCK flag, but we should
> also check for IOCB_NOWAIT for whether or not we should handle this read
> or write in a non-blocking fashion. If we don't, then we will block on
> data or space for iocbs that explicitly asked for non-blocking
> operation. This messes up callers that explicitly ask for non-blocking
> operations.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Wouldn't this be better?

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/pipe.c b/fs/pipe.c
index 16fb72e9abf7..d4cf3ea9ad49 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -363,7 +363,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (ret)
 			break;
-		if (filp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -566,7 +566,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			continue;
 
 		/* Wait for buffer space to become available. */
-		if (filp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..2790c956bd4f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3429,6 +3429,8 @@ static inline int iocb_flags(struct file *file)
 		res |= IOCB_DSYNC;
 	if (file->f_flags & __O_SYNC)
 		res |= IOCB_SYNC;
+	if (file->f_flags & O_NONBLOCK)
+		res |= IOCB_NOWAIT;
 	return res;
 }
 
