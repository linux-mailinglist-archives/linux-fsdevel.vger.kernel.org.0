Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625AA42E933
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhJOGnn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJOGnm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:43:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454EC061570;
        Thu, 14 Oct 2021 23:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G5S9y2nrrDptxuOLoJNOSSyaTHp02MaC9gd62byHcIA=; b=R+dIUYtEXxFA2exYyciVgSKT8P
        qzqHlPTAFgWqgf9++8AocTdLtaWHaPNsLR3dk6Ywj4i49KnXkndgi53DN/al/ZisyhTWfAIXnxZWP
        HyE6FiUSRwVvz2C5cULLmG1HQ6yEJhFIazKoRlVz3eJEBkP9O09nsq5DE4Gv54sUuA+hIH9i4UcHc
        gEQSuRUBTFRb/eBYssnKtdYgbFe9Yu6Y9n4YcSruMyGYKcQIoJ9Y+iWBmn3SocGFHdgfH7ZI2YBDx
        qOaIp8PE0trLuxiaZO6/VNmeJlug089okBR/79IBjBJ8YVQMnTWqt2bLFDXZtdQLvN6FXm/RfdwtF
        eg4yBWfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbGuO-005Zjs-AH; Fri, 15 Oct 2021 06:41:36 +0000
Date:   Thu, 14 Oct 2021 23:41:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v7 7/8] xfs: Implement ->notify_failure() for XFS
Message-ID: <YWkioFQrfKAL8PvR@infradead.org>
References: <20210924130959.2695749-1-ruansy.fnst@fujitsu.com>
 <20210924130959.2695749-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924130959.2695749-8-ruansy.fnst@fujitsu.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:09:58PM +0800, Shiyang Ruan wrote:
> +void fs_dax_register_holder(struct dax_device *dax_dev, void *holder,
> +		const struct dax_holder_operations *ops)
> +{
> +	dax_set_holder(dax_dev, holder, ops);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_register_holder);
> +
> +void fs_dax_unregister_holder(struct dax_device *dax_dev)
> +{
> +	dax_set_holder(dax_dev, NULL, NULL);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_unregister_holder);
> +
> +void *fs_dax_get_holder(struct dax_device *dax_dev)
> +{
> +	return dax_get_holder(dax_dev);
> +}
> +EXPORT_SYMBOL_GPL(fs_dax_get_holder);

These should not be in a XFS patch.  But why do we even need this
wrappers?

> @@ -377,6 +385,8 @@ xfs_close_devices(
>  
>  		xfs_free_buftarg(mp->m_logdev_targp);
>  		xfs_blkdev_put(logdev);
> +		if (dax_logdev)
> +			fs_dax_unregister_holder(dax_logdev);
>  		fs_put_dax(dax_logdev);

I'd prefer to include the fs_dax_unregister_holder in the fs_put_dax
call to avoid callers failing to unregister it.

> @@ -411,6 +425,9 @@ xfs_open_devices(
>  	struct block_device	*logdev = NULL, *rtdev = NULL;
>  	int			error;
>  
> +	if (dax_ddev)
> +		fs_dax_register_holder(dax_ddev, mp,
> +				&xfs_dax_holder_operations);

I'd include the holder registration with fs_dax_get_by_bdev as well.
