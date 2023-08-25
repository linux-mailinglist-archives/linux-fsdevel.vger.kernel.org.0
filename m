Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D8787CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 03:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbjHYBOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjHYBOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:14:14 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDD19BB;
        Thu, 24 Aug 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VFNVFt/7/5G7r3AO6hVBx/rbI3iYFwIQVfmz3UrxPqI=; b=HPtqqzf93CqXk8WihPhuJV1RSK
        tSfSSqn/vc3mtUcuanRMu0IQ9ysGwINwGa5jpVcjmo90M8vyVKpF8UQ1VaHRGmV8Eg2IcOr1vnsTf
        RAjyJ6Gyf/3ks5v2MwTqTr/C99jBG8nCO1qdfrDVe92FmydcZ4DLBTMKjAXntd7e88uQGcPu/2L7x
        R7iKLLejKOG2tdiXjGz4QC2qK2QtqsUrvB8D6TqbMX39QuczgJnh6bfUUbLHA9s60MTiPon8AcAnW
        t/mDTpPoN/cTrdda1FVyuXXOht41Iwq6gQg3E+KoI87tZRcd07ozop3LluQdjiC89bgCnYHaeZYZl
        FKh0gRcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qZLOr-000czI-12;
        Fri, 25 Aug 2023 01:14:09 +0000
Date:   Fri, 25 Aug 2023 02:14:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 02/29] block: Use bdev_open_by_dev() in blkdev_open()
Message-ID: <20230825011409.GA95084@ZenIV>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811110504.27514-2-jack@suse.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:04:33PM +0200, Jan Kara wrote:

> @@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
>  		mode |= BLK_OPEN_READ;
>  	if (file->f_mode & FMODE_WRITE)
>  		mode |= BLK_OPEN_WRITE;
> -	if (file->private_data)
> +	if (file->f_flags & O_EXCL)
>  		mode |= BLK_OPEN_EXCL;
>  	if (file->f_flags & O_NDELAY)
>  		mode |= BLK_OPEN_NDELAY;


> index 3be11941fb2d..47f216d8697f 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -575,7 +575,7 @@ long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>  {
>  	struct block_device *bdev = I_BDEV(file->f_mapping->host);
>  	void __user *argp = (void __user *)arg;
> -	blk_mode_t mode = file_to_blk_mode(file);
> +	blk_mode_t mode = ((struct bdev_handle *)file->private_data)->mode;

Take a look at sd_ioctl() and note that fcntl(2) can be used to set/clear O_NDELAY.
The current variant works since we recalculate mode every time; this one will end up
stuck with whatever we had at open time.  Note that Christoph's series could do this
in blkdev_ioctl()
-       /*
-        * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-        * to updated it before every ioctl.
-        */
-       if (file->f_flags & O_NDELAY)
-               mode |= FMODE_NDELAY;
-       else
-               mode &= ~FMODE_NDELAY;
precisely because his file_to_blk_mode() picks O_NDELAY from flags when blkdev_ioctl()
calls it.

The same goes for compat counterpart of that thing.  Both need to deal with that
scenario - you need something that would pick the O_NDELAY updates from ->f_flags.

Al, trying to catch up on the awful pile of mail that has accumulated over the 3 months
of being net.dead...
