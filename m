Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59E511B9EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfLKRTb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 12:19:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbfLKRTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4J1/yyuW0sNFMU7Tk1XR5eA0O0XmmxHDThV9Nk2vS4w=; b=KNiLzZ+zcRizZMcYKB+qUzvj9
        upGmxAtf1ZzuI8xsrW9scHBlL5obgREKcLChcXDP7sYkF9zTA/B3Njsr310I0KOtUkAwo05H0A3qQ
        Jd0glkUxavowLKxezSEDPelvmfYEK8qcQ1C+z4VhfMNFc/wIopiTTW9S5xPDghr7PY9u/es4onZvZ
        kznr4CwqND97O2wGkTBqYyZTgiKjBjdKG/+YIqtoW5szoMeVgud61SuN5VKJwEh6UtRYfYYxtPjCM
        Xhptv0KTh0/dZp1/jUvmOqky5NRPTONHg3QTt/PdZRNQqmRReogjis47QtRZif3KikUHP8l8uvzRt
        L6SIxDRLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if5e4-0004tT-O2; Wed, 11 Dec 2019 17:19:28 +0000
Date:   Wed, 11 Dec 2019 09:19:28 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
Message-ID: <20191211171928.GN32169@bombadil.infradead.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211152943.2933-6-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
> @@ -670,9 +675,14 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
>  		iomap_read_inline_data(inode, page, srcmap);
>  	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
>  		status = __block_write_begin_int(page, pos, len, NULL, srcmap);
> -	else
> -		status = __iomap_write_begin(inode, pos, len, flags, page,
> +	else {
> +		unsigned wb_flags = 0;
> +
> +		if (flags & IOMAP_UNCACHED)
> +			wb_flags = IOMAP_WRITE_F_UNCACHED;
> +		status = __iomap_write_begin(inode, pos, len, wb_flags, page,
>  				srcmap);

I think if you do an uncached write to a currently shared extent, you
just lost the IOMAP_WRITE_F_UNSHARE flag?
