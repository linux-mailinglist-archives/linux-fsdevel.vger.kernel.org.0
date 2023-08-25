Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE4787DA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 04:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbjHYC3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 22:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjHYC2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:28:33 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F11BFB;
        Thu, 24 Aug 2023 19:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CNiECI7eyfbngkcVbLJTEibvtESpiT8D5s+FzCaLrDI=; b=dT3wUK1eA9RqSVFHfeg1HA13/z
        AVyy7HnbWQIaZvvlpKXkn/gL2g01BBjcRLBxdoLjZ1/SOogfCrhD0MGKGxFvEHE6GawZv2yZl9j18
        FB2nlgP5FbuQdAp8V6MvgF5gY5D9TXlm2kgPuejg8NEtMTAU5ccPcxRGNOstZK+lFzocYrrc9nthz
        cyCejn4qRl/twCKmBUx9y7mBVKbc4O42rc4D4G5mBSBwY4Jo7VW5oe0ezQAFPJnVE9xOw++Udek/8
        oK2x66y/RHoIU+BGaJXVOzLe6/XjdJ5Az2epFy/MS/jOhowhGrwoM93BXD+TJkQq0v6VtI9+rZbFh
        3bIIQkyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qZMYk-000eNc-2G;
        Fri, 25 Aug 2023 02:28:26 +0000
Date:   Fri, 25 Aug 2023 03:28:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230825022826.GC95084@ZenIV>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-2-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:13PM +0200, Jan Kara wrote:
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 648670ddb164..54c1e2f71031 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -582,7 +582,8 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  {
>  	struct block_device *bdev = I_BDEV(file->f_mapping->host);
>  	void __user *argp = (void __user *)arg;
> -	blk_mode_t mode = file_to_blk_mode(file);
> +	struct bdev_handle *bdev_handle = file->private_data;
> +	blk_mode_t mode = bdev_handle->mode;
>  	int ret;
>  
>  	switch (cmd) {

	Still the same bug as in v2 - you are missing the effects of
fcntl(2) setting/clearing O_NDELAY and sd_ioctl() is sensitive to that.
