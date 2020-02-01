Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6C14F8B7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBAPsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:48:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35946 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBAPsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yGIgcb3CmGMyo0/Lz0VtvC3YVMdDRbL17gGOx8oi+ZQ=; b=ufoWGPcfyX1q9mdMD4mpi46ae
        bbXJkuBWXsKgQoxRoYcR4Wy6wi3A5T5SPfAGQTvU9X5Ezq2VqAmMmKbbutFlQRZ/S/mK3yKSt9au8
        jPRAn5AwVFjYRJQq3D9yDLypr3idM0R7R7qo8PKPh57kmUzk0KxMUU1M4sAnId1XRvMQbDFAH5UWU
        Ks6GaC3WqdYj2Fm92f7/NYUvuii2ohGgLUwxbrK8x5sqvufLl3CJ5X5LncjLk9V79CaeSa7iF+LDG
        ORM/cq+8R/rGU0cnVC/l2FkihsBj9L22md5MGJiJe5LvXtGtqgD7yn68eiWarHiM1DGAyZo7eDPyi
        hl+emzMxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuzw-0001qt-Ka; Sat, 01 Feb 2020 15:47:52 +0000
Date:   Sat, 1 Feb 2020 07:47:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     qiwuchen55@gmail.com
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] fuse: fix inode rwsem regression
Message-ID: <20200201154752.GA12698@bombadil.infradead.org>
References: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580536171-27838-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 01, 2020 at 01:49:31PM +0800, qiwuchen55@gmail.com wrote:
> Apparently our current rwsem code doesn't like doing the trylock, then
> lock for real scheme.  So change our direct write method to just do the
> trylock for the RWF_NOWAIT case.
> This seems to fix AIM7 regression in some scalable filesystems upto ~25%
> in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")

This commit message doesn't match the patch.

>  	/* Don't allow parallel writes to the same file */
> -	inode_lock(inode);
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
>  	res = generic_write_checks(iocb, from);
>  	if (res > 0) {
>  		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> -- 
> 1.9.1
> 
