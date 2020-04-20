Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D871B078D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTLiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLix (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:38:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B3E206D4;
        Mon, 20 Apr 2020 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382732;
        bh=veCGgKP+gaMaBxAIpl/jdA0mDZiqNm79OtKradPHlN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSv9KlPALQJwITlfEXQWZBKfTFX3Lc197g3Q8P8hhWjMQdROLzHL4K9KMio/IONiC
         5fodZe10QtCuAN7yHrgwgFtBahvsrbC6jYbm3WOBcv4YJEBjYg9GmRAm9CLUTGV3U2
         HxwYBll9AtQn8IQGb+0B89WmylTNdKz49QFIMyqc=
Date:   Mon, 20 Apr 2020 13:38:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] block: panic if block debugfs dir is not created
Message-ID: <20200420113850.GC3906674@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419194529.4872-10-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 07:45:28PM +0000, Luis Chamberlain wrote:
> If DEBUG_FS is disabled we have another inline
> blk_debugfs_register() which just returns 0.
> 
> If BLK_DEV_IO_TRACE is enabled we rely on the block debugfs
> directory to have been created. If BLK_DEV_IO_TRACE is not enabled
> though, but if debugfs is still enabled we will always create a
> debugfs directory for a request_queue. Instead of special-casing
> this just for BLK_DEV_IO_TRACE, ensure this block debugfs dir is
> always created at boot if we have enabled debugfs.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/blk-debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-debugfs.c b/block/blk-debugfs.c
> index 761318dcbf40..d6ec980e7531 100644
> --- a/block/blk-debugfs.c
> +++ b/block/blk-debugfs.c
> @@ -15,6 +15,8 @@ struct dentry *blk_debugfs_root;
>  void blk_debugfs_register(void)
>  {
>  	blk_debugfs_root = debugfs_create_dir("block", NULL);
> +	if (!blk_debugfs_root)
> +		panic("Failed to create block debugfs directory\n");

How rude, never crash the kernel for something so trivial as that.

Heck, never do ANYTHING different in the kernel if debugfs fails to do
something you think it should do.  This is debugging code, nothing
should ever depend on it, so just save the value (if you need it) and
move on.  Never check the value, as it means nothing to you.

greg k-h
