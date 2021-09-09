Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4B404932
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 13:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhIILYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhIILYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:24:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED3FC061575;
        Thu,  9 Sep 2021 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M0gopQrsLr3UAE05SLf2KetoSMl+JUlvHkNklgk7J9I=; b=eKmuEo4gN8a1EQvUGgpk6G4bYV
        88f9akYrx4vCinB+HrE5W4fV4xy5i0AZjkMIi4jKkgdOw1jLlLbHHRVOiDTaO/4nNS0K1HLejmpe5
        0o5YZQtKGjDkNmcjr5dUaSb2Zmaeo9iUc58oBQEvnfo7jg4ElgxLUgr3ubxQLXr6EYRerwp0qz+3F
        1EscQ3c8K7ZiaH+IKihiC/tfZCgXwy8y+PtUSKGxwi2e7V8UgQGIhGToNFsvjT9EHnAOOJEhH5LSz
        8xRdQhq1nmn6JpTmQuf9R/LsczQVWETH5dW8lGkfcqPUa0dY7yMLhVllKxsr5hiiX1jo1EOyNT+w7
        +VEvjvfQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOI6o-009l4w-TK; Thu, 09 Sep 2021 11:20:53 +0000
Date:   Thu, 9 Sep 2021 12:20:46 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 15/19] iomap: Support partial direct I/O on user copy
 failures
Message-ID: <YTnuDhNlSN1Ie1MJ@infradead.org>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-16-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827164926.1726765-16-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:49:22PM +0200, Andreas Gruenbacher wrote:
> In iomap_dio_rw, when iomap_apply returns an -EFAULT error and the
> IOMAP_DIO_PARTIAL flag is set, complete the request synchronously and
> return a partial result.  This allows the caller to deal with the page
> fault and retry the remainder of the request.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/iomap/direct-io.c  | 6 ++++++
>  include/linux/iomap.h | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 8054f5d6c273..ba88fe51b77a 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -561,6 +561,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
>  				iomap_dio_actor);
>  		if (ret <= 0) {
> +			if (ret == -EFAULT && dio->size &&
> +			    (dio_flags & IOMAP_DIO_PARTIAL)) {
> +				wait_for_completion = true;
> +				ret = 0;

Do we need a NOWAIT check here to skip the wait_for_completion
for that case?
