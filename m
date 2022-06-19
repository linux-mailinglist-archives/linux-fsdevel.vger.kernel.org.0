Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6201550833
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 06:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiFSEBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 00:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiFSEBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 00:01:32 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3260CDF43
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NSYdGgIhYfVHpxUFfzaZ98BUHLW9rSsoZ5BqlJCEViU=; b=oFkIEptCxNXtColMRlrc6hRzZs
        19HtdCpAsTX0niepTpO+oR49PqZxKV8ihnKc7gG449EwfKvpUow/rnh0S/IC/Da/YiYNK7Z1sHzoF
        +sbSgkuu1SylFOh3lH5oNMrfsS71zrvHlNBPR57g8KNCuc3QlJhr1cLbDmcgNxwWGNLcns9lqDga/
        Fu+O/KP0okLp/HrvR4I5QfEXwIjoDqIgjt6FfbwhIbqMJ7H078yB+d6s0glxA+IQO7Rq+9bz5ZcU/
        WL6pfBdcrJmZvj9q7RckWoUn+MMW9uNLPThjoxoXTqOjqQLmIMMGN+Fs6w8GOHUt16la8n67n7uvS
        6nY8z/UA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2m7t-001wQF-I6;
        Sun, 19 Jun 2022 04:01:29 +0000
Date:   Sun, 19 Jun 2022 05:01:29 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 30/31] pipe_get_pages(): switch to append_pipe()
Message-ID: <Yq6fmQOOhpAyIs3k@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-31-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-31-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 06:35:37AM +0100, Al Viro wrote:

>  		get_page(*p++ = page);
> -		left -= size;

Argh...
		if (left <= PAGE_SIZE - off)
			return maxsize;
> +		left -= PAGE_SIZE - off;
>  	}
>  	if (!npages)
>  		return -EFAULT;
> -	maxsize -= left;
> -	iov_iter_advance(i, maxsize);
> -	return maxsize;
> +	return maxsize - left;
>  }
>  
>  static ssize_t iter_xarray_populate_pages(struct page **pages, struct xarray *xa,
> -- 
> 2.30.2
> 
