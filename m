Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812D25507E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 03:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiFSBfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 21:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSBfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 21:35:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36DE0F5
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UxVHvcI7jFYfJU8+gR/QFSrOfbk7i30Sxs22y4eVzvU=; b=Hme5MWCp+yvDzCHXKjwY/L2gUU
        IARg/25qgZXAxOOzVcgB3lVCgjSaBaSdXtsSBO2fXUaNeNGYhELC/HQa/c06sY+o9y6+w74IEn+bp
        2xeYVpz+U2qzxibtZ/XKb/XhBJ35B5qePcaUbyYGwv/GkQ5iRJnLpAAd10NWPZsZYL/9XjXahh/hR
        GQIhBWUFfsYEX4OYgQG/V8CAojoRMeTXowNWjcUOmy1fkYE2ZoZKeyxIq3ySxrtW9jfCTJUIAdnFV
        PCz9s8tvNzrGkTIXInTei0RxWecPV26l7XrddvF1wbJ+t8zT2esMc/1hYJ+Gxjg3tVZp5T3vyyR8J
        dFJQ9ZKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2jq5-001tgi-Fq;
        Sun, 19 Jun 2022 01:34:57 +0000
Date:   Sun, 19 Jun 2022 02:34:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/31] ITER_PIPE: allocate buffers as we go in
 copy-to-pipe primitives
Message-ID: <Yq59QSzT1ICeeZI3@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-4-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-4-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 06:35:10AM +0100, Al Viro wrote:
> +
> +		if (page)

		if (!page)
that is...

> +			break;
> +		p = kmap_local_page(page);
>  		memset(p + off, 0, chunk);
>  		kunmap_local(p);
> -		i->head = i_head;
> -		i->iov_offset = off + chunk;
>  		n -= chunk;
> -		off = 0;
> -		i_head++;
> -	} while (n);
> -	i->count -= bytes;
> +	}
>  	return bytes;
>  }
>  
> -- 
> 2.30.2
> 
