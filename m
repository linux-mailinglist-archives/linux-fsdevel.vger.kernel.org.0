Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48A4721D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 08:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhLMHiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 02:38:12 -0500
Received: from verein.lst.de ([213.95.11.211]:46426 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhLMHiM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:38:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD55C68AA6; Mon, 13 Dec 2021 08:38:08 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:38:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, dan.j.williams@intel.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iomap: turn the byte variable in iomap_zero_iter into
 a ssize_t
Message-ID: <20211213073808.GA20684@lst.de>
References: <20211208091203.2927754-1-hch@lst.de> <YbTk+1I4VFQpgjM/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbTk+1I4VFQpgjM/@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 11, 2021 at 05:50:51PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 08, 2021 at 10:12:03AM +0100, Christoph Hellwig wrote:
> > bytes also hold the return value from iomap_write_end, which can contain
> > a negative error value.  As bytes is always less than the page size even
> > the signed type can hold the entire possible range.
> 
> iomap_write_end() can't return an errno.  I went through and checked as
> part of the folio conversion.  It actually has two return values -- 0
> on error and 'len' on success.  And it can't have an error because
> that only occurs if 'copied' is less than 'length'.
> 
> So I think this should actually be:
> 
> -               bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
> -               if (bytes < 0)
> -                       return bytes;
> +               status = iomap_write_end(iter, pos, bytes, bytes, folio);
> +               if (WARN_ON_ONCE(status == 0))
> +                       return -EIO;
> 
> just like its counterpart loop in iomap_unshare_iter()
> 
> (ok this won't apply to Dan's tree, but YKWIM)

Indeed.  It might make sense to eventually switch to actually return
an errno or a bool as the current calling convention is rather confusing.
