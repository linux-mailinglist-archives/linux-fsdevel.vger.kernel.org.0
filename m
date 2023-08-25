Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13178869D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbjHYMHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbjHYMHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:07:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215341FD7;
        Fri, 25 Aug 2023 05:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAB4C62FBA;
        Fri, 25 Aug 2023 12:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136F5C433C7;
        Fri, 25 Aug 2023 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692965224;
        bh=lBJl7Ltd3m1Yv7N4J9TTCb6VH0fGt8rWbL3lAxnOiyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWbxapWzHPrm6RblL8OQ2SsVuXgYG9X4O3seFQaXlAKDyCP8BhPZQ6cPyh2IO/mg6
         K3OVCgqGdbPijf5yNNlu0trRD9RvHEGFd9jFO+Zaz/vlYFHxrj2FJeO88pxCDXXyFI
         +gLvq7VKNfdnvnqAsN/JYFEVzk0GZ0Sx8WXrO3WdkLuiz6ZjzSup3aOD7OHiqFG5rK
         qI4Cg/X3ukfDVW91q4gTHWjq2+uF/edM2c84s7e8sNO7/qgHOJbqBGiyQDZA2ZZPmQ
         j8JBN8N373mVl0MLoqr+qQqLVOsN42EHvlYz62i4J/CH8gEtRuDlUuoM00SYQT0R6t
         1f7qgn/GS9jng==
Date:   Fri, 25 Aug 2023 14:06:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-bcache@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>
Subject: Re: [PATCH 09/29] bcache: Convert to bdev_open_by_path()
Message-ID: <20230825-galionsfigur-habgier-841bc680f59e@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-9-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:20PM +0200, Jan Kara wrote:
> Convert bcache to use bdev_open_by_path() and pass the handle around.
> 
> CC: linux-bcache@vger.kernel.org
> CC: Coly Li <colyli@suse.de
> CC: Kent Overstreet <kent.overstreet@gmail.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Coly Li <colyli@suse.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

> -	if (!IS_ERR_OR_NULL(dc->bdev))
> -		blkdev_put(dc->bdev, dc);
> +	if (dc->bdev_handle)
> +		bdev_release(dc->bdev_handle);

Fwiw, these conversions confused me a little as the old check gave the
impression that this could be set to an error pointer somehow.
