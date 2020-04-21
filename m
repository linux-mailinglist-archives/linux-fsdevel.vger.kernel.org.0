Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33C41B2F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 20:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDUSuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 14:50:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49476 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgDUSuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:50:07 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQxxl-007lIL-Bu; Tue, 21 Apr 2020 18:49:41 +0000
Date:   Tue, 21 Apr 2020 19:49:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/spufs: simplify spufs core dumping
Message-ID: <20200421184941.GD23230@ZenIV.linux.org.uk>
References: <20200421154204.252921-1-hch@lst.de>
 <20200421154204.252921-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421154204.252921-2-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:41:58PM +0200, Christoph Hellwig wrote:

>  static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
>  				   size_t len, loff_t *pos)
>  {
>  	struct spu_context *ctx = file->private_data;
> +	struct spu_proxydma_info info;
>  	int ret;
>  
> +	if (len < sizeof(info))
> +		return -EINVAL;
> +	if (!access_ok(buf, len))
> +		return -EFAULT;
> +
>  	ret = spu_acquire_saved(ctx);
>  	if (ret)
>  		return ret;
>  	spin_lock(&ctx->csa.register_lock);
> -	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
> +	__spufs_proxydma_info_read(ctx, &info);
> +	ret = simple_read_from_buffer(buf, len, pos, &info, sizeof(info));

IDGI...  What's that access_ok() for?  If you are using simple_read_from_buffer(),
the damn thing goes through copy_to_user().  Why bother with separate access_ok()
here?
