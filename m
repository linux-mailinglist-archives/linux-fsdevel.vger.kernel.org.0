Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33F2009AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 15:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgFSNNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgFSNNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAAC06174E;
        Fri, 19 Jun 2020 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G4RUDuCAHK+Un7YwD1qGbgaTvIXNiS2OBRIs2mhOgXU=; b=QXaPewcfN/1Z+wWq3RAkYS4Fsl
        X4mvCPI4LnFv7TLuS0dPZy1guPTOOwC6D2mEAwwuWbNdsh2ikLoV1kWsXKijXVBuaeuoEsMG1cA/e
        qer1BJj+N5IVJrV7rf2HeOfGkpHpdUfwVZfq8nFa6YknDVOALG5cap0pCzIOKKWCn7tR+jBz3gH/h
        JEV0ffjpFoAifS9C4ueU7labKxrF/VXBMqxCrn4pLcDM9QnXTCndKXgSAsLzJB7MlbZqTKOLLW7Zp
        hKRoLKLfkNx8OCqLy6QQycuz14RRTm9gdsohR7KK1nvhkdYQg9d34UjL9VHm178QzYZqZevr3ynTh
        XUyPSkbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmGq3-000433-3P; Fri, 19 Jun 2020 13:13:47 +0000
Date:   Fri, 19 Jun 2020 06:13:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>
Subject: Re: [PATCH v2] iomap: Make sure iomap_end is called after iomap_begin
Message-ID: <20200619131347.GA22412@infradead.org>
References: <20200618122408.1054092-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618122408.1054092-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:24:08PM +0200, Andreas Gruenbacher wrote:
> Make sure iomap_end is always called when iomap_begin succeeds.
> 
> Without this fix, iomap_end won't be called when a filesystem's
> iomap_begin operation returns an invalid mapping, bypassing any
> unlocking done in iomap_end.  With this fix, the unlocking would
> at least still happen.
> 
> This iomap_apply bug was found by Bob Peterson during code review.
> It's unlikely that such iomap_begin bugs will survive to affect
> users, so backporting this fix seems unnecessary.
> 
> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/apply.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 76925b40b5fd..32daf8cb411c 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -46,10 +46,11 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
>  	if (ret)
>  		return ret;
> -	if (WARN_ON(iomap.offset > pos))
> -		return -EIO;
> -	if (WARN_ON(iomap.length == 0))
> -		return -EIO;
> +	if (WARN_ON(iomap.offset > pos) ||
> +	    WARN_ON(iomap.length == 0)) {
> +		written = -EIO;
> +		goto out;
> +	}

As said before please don't merge these for no good reason.
