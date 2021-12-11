Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4F471514
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhLKRvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 12:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhLKRvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 12:51:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2FC061714;
        Sat, 11 Dec 2021 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NeLcXd3rCUW11H5q6lj3WBajFaZ0nROX1lQbEfPAe50=; b=AUem481ZozwyJeZxF1t/0jRGCP
        LSpDUjvS0AYcGLu0C05bPH5cbhuQxpUU38yTaKgOC2dldabdYRFWdO7fy0mK6Lo/46uzWBWN/O6z2
        b8csLu9awk6SQ6zpySsCQ/CwsUToDSnsLTktVs0l0ufrIvQWqcZHzwoInj7ns4LlS9n76bwwPfgkW
        c5R02ti75YTvfMl4zTq9Y5wjzpYSwl01qdgDW4S1YlkvfP/3RERtCkj9CNnFeafBCOj5g2y2yqy9M
        qYoqODoRYjrCTgyDOnGElyDVVOO3YV9Ted7scILgznTOQFvYuxcqWBwsNwPpVthn3/384gGtTUYTA
        PkXRKKeQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mw6WJ-00BMwC-B4; Sat, 11 Dec 2021 17:50:51 +0000
Date:   Sat, 11 Dec 2021 17:50:51 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into a
 ssize_t
Message-ID: <YbTk+1I4VFQpgjM/@casper.infradead.org>
References: <20211208091203.2927754-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208091203.2927754-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> bytes also hold the return value from iomap_write_end, which can contain
> a negative error value.  As bytes is always less than the page size even
> the signed type can hold the entire possible range.

iomap_write_end() can't return an errno.  I went through and checked as
part of the folio conversion.  It actually has two return values -- 0
on error and 'len' on success.  And it can't have an error because
that only occurs if 'copied' is less than 'length'.

So I think this should actually be:

-               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
-               if (bytes < 0)
-                       return bytes;
+               status = iomap_write_end(iter, pos, bytes, bytes, folio);
+               if (WARN_ON_ONCE(status == 0))
+                       return -EIO;

just like its counterpart loop in iomap_unshare_iter()

(ok this won't apply to Dan's tree, but YKWIM)
