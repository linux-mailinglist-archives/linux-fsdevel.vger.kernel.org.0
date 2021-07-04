Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294AB3BAD34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGDNzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDNzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 09:55:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB3C061574;
        Sun,  4 Jul 2021 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=13OzY+8k/62uCzBeEBMYh/0RrObpn1HoAPOblb6GAXI=; b=MsjA9kCQf/Aox4TEnjsAFZBxFJ
        gilAT4NgjLMJ+uNAD9wK2j7rEQSj4oXu/K/gV/MTlgxqj7fSFdOPsLsWFEtsXULGLliFCt2jWeGFN
        DJKyLlVAaqwo1dKGd7u9Q6JoOa+lQMi25UL4Is19hqwcxndivFCUpyzZyRz6Ua9jJ1yfVWvf8e9yT
        ELoAwMYTjNblMbjtkUNRxXfKqEwqROoMIRZQwAOZZDoXvJu2hr0MpnmrIRrIZHYfBHtnkZ35gS3xc
        eMTdIJXM8hY6VdVIY2rr5H4wNIFqTb+LUzgYF6FUWxQGotEKCJTYZYFq1TWK/VLNigmYK3r84Tbdo
        jUX6j8sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m02XB-009LXI-FR; Sun, 04 Jul 2021 13:51:55 +0000
Date:   Sun, 4 Jul 2021 14:51:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
Message-ID: <YOG88dhjfH5PdIfo@casper.infradead.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN7dn08eeUXfixJ7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN7dn08eeUXfixJ7@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 02, 2021 at 10:34:23AM +0100, Christoph Hellwig wrote:
> We might as well just kill off the length variable while we're at it:

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> index dab1b02eba5b7f..942e354e9e13e6 100644
> --- a/fs/iomap/seek.c
> +++ b/fs/iomap/seek.c
> @@ -35,23 +35,21 @@ loff_t
>  iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
>  {
>  	loff_t size = i_size_read(inode);
> -	loff_t length = size - offset;
>  	loff_t ret;
>  
>  	/* Nothing to be found before or beyond the end of the file. */
>  	if (offset < 0 || offset >= size)
>  		return -ENXIO;
>  
> -	while (length > 0) {
> -		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
> -				  &offset, iomap_seek_hole_actor);
> +	while (offset < size) {
> +		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
> +				  ops, &offset, iomap_seek_hole_actor);
>  		if (ret < 0)
>  			return ret;
>  		if (ret == 0)
>  			break;
>  
>  		offset += ret;
> -		length -= ret;
>  	}
>  
>  	return offset;
