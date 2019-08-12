Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA348A421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLRSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 13:18:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLRSd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+YNZsLLrlPEHgxpe/aXTTjPaVKmiuk5SL+l/sNwb+ns=; b=WKjvzGbYVhYzvQjOTh2WsDgiT
        6hxUSVu9+fTGD94fmSJtIGQEk9R79K5WuN9GVnWNHw525ZtBf6q7le7b1cXTsbWxoRhcl0jKKh6RS
        rOXYfhF+XI9EmNidIXBwxX6lt1V8ZA7V0qFHLBpo24OOpzf3eLDA5/g/Kmk11DSy3uN+zyKwJikjN
        poMe2UL1OklLd7Dar2GoMkgdCV/tNHOk0wVp+xYLaYkjyal0tGQKCmOILf4Iyz7wJgXFJ2iYNN5Ns
        td4KwsHm/lxUztsD1iOQNHUp50ZDbJJoJ2mnS8A7mvYB/JfaTPRz8C1mKXSjJ4l/nKPPl9FOIRUpO
        jlnOoXV5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxDxo-0001Lt-I3; Mon, 12 Aug 2019 17:18:32 +0000
Date:   Mon, 12 Aug 2019 10:18:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 3/5] iomap: modify ->end_io() calling convention
Message-ID: <20190812171832.GA24564@infradead.org>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <f4abda9c0c835d9a50b644fdbec8d43269f6b0f7.1565609891.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4abda9c0c835d9a50b644fdbec8d43269f6b0f7.1565609891.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

please add linux-xfs to the cc list for the whole series.  Besides
touching xfs itself it is also mentioned in MAINTAINERS for the iomap
code.

On Mon, Aug 12, 2019 at 10:53:11PM +1000, Matthew Bobrowski wrote:
> -	if (size <= 0)
> -		return size;
> +	if (error || !size)
> +		return error ? error : size;

This should be:

	if (error)
		return error;
	if (!size)
		return 0;

>  	if (flags & IOMAP_DIO_COW) {
> -		error = xfs_reflink_end_cow(ip, offset, size);
> -		if (error)
> +		ret = xfs_reflink_end_cow(ip, offset, size);
> +		if (ret)

I think we can just keep reusing error here.

> +typedef int (iomap_dio_end_io_t)(struct kiocb *iocb, ssize_t size,
> +				 ssize_t error, unsigned int flags);

error should be an int and not a ssize_t.
