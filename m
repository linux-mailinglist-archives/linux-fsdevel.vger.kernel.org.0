Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463BC3801FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 04:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhENC2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 22:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhENC2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 22:28:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5319C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/y7f1SJ7oxbzKPXRu5/YKNvMqsz80b4evu2dBKfYHvk=; b=da1RY7OUyJvnl4xRffJt7/8dLg
        ib2CHlrHpec0iiQZM7qj1iquBppC6QM1sq0ieF1HPFZRiCfB3ao05WJ7ovY5Fz0WDoJ4skW2aAQP/
        tQ7OsFM5RiKIBKczrbj4ObcCOpMyO0vKF0ereYohiGoFpqrZBWsgwP+G7k2MGDIzqvkgmg08jICGg
        Uu4owil5HBIbajRzmkfQx2LTaIDbzeu706zFOLv5NdglP4qhOz7rg0pgg/GEBfHYg6GV5IWAw5JIW
        te+AbWMFGuQ+im80Cst2aIK1cXFvbUATN0XkHBF4mI7DifrVythU8C7NhwTVp42ZB0YCMqeQdfaEJ
        n4mRERQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lhNX4-009z0l-Qi; Fri, 14 May 2021 02:26:36 +0000
Date:   Fri, 14 May 2021 03:26:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Fengnan Chang <changfengnan@vivo.com>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: fix inconsistent status between faccess and mkdir
Message-ID: <YJ3f1lBkwY+9vqss@casper.infradead.org>
References: <20210514015517.258-1-changfengnan@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514015517.258-1-changfengnan@vivo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 09:55:17AM +0800, Fengnan Chang wrote:
> +++ b/fs/fuse/dir.c
> @@ -1065,6 +1065,14 @@ static int fuse_do_getattr(struct inode *inode, struct kstat *stat,
>  				fuse_fillattr(inode, &outarg.attr, stat);
>  		}
>  	}
> +	if (err == -ENOENT) {
> +		struct dentry *entry;
> +
> +		entry = d_obtain_alias(inode);

Why d_obtain_alias() instead of d_find_any_alias()?

And what if you find the wrong alias?  ie an inode with two links?
Or does fuse not support hardlinks?

