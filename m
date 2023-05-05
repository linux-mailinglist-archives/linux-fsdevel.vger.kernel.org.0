Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A529C6F88B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjEESjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjEESjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BA1E996;
        Fri,  5 May 2023 11:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02AC8612A1;
        Fri,  5 May 2023 18:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60143C433D2;
        Fri,  5 May 2023 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311975;
        bh=K/Y08sTCTSnRoZgjb16tDaF0uh6/O7C3F9BZfsmlEug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAI25Pqes2oc/YXzsbgTjpK1lOHAOBZzubxbrrbKnPrxL1srLXYw+IXxxMGi7koMM
         fT5owlpm4xzf2xtwgMzeHwoFdpd/dZICCv2B2jml8B8BMjVWxogHtAUdpZXL2OeqOH
         0VCfBBz102w5H5Act9Zr6zOhurMGPlKnAVW7xrI8DuGm/nEZVA7SSxBmGP3baSFHRQ
         r5qnAGZGjZD4Pc/7nwE7l9s8HLOjKL1nN0SQuKvJFsvo9WgySG1LQtdIEWkuFuPpKj
         6onOPa1+e9YQHzpLg+/8Fq6bYWZ9A5d18EcZWy71jbPLYIFgwZmY2NaG4A8An5nKWv
         /eP8TF/+lhQqw==
Date:   Fri, 5 May 2023 11:39:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/9] fs: add a method to shut down the file system
Message-ID: <20230505183934.GH15394@frogsfrogsfrogs>
References: <20230505175132.2236632-1-hch@lst.de>
 <20230505175132.2236632-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505175132.2236632-8-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 01:51:30PM -0400, Christoph Hellwig wrote:
> Add a new ->shutdown super operation that can be used to tell the file
> system to shut down, and call it from newly created holder ops when the
> block device under a file system shuts down.
> 
> This only covers the main block device for "simple" file systems using
> get_tree_bdev / mount_bdev.  File systems their own get_tree method
> or opening additional devices will need to set up their own
> blk_holder_ops.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/super.c         | 21 +++++++++++++++++++--
>  include/linux/fs.h |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 012ce140080375..f127589700ab25 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1206,6 +1206,22 @@ int get_tree_keyed(struct fs_context *fc,
>  EXPORT_SYMBOL(get_tree_keyed);
>  
>  #ifdef CONFIG_BLOCK
> +static void fs_mark_dead(struct block_device *bdev)
> +{
> +	struct super_block *sb;
> +
> +	sb = get_super(bdev);
> +	if (!sb)
> +		return;
> +
> +	if (sb->s_op->shutdown)
> +		sb->s_op->shutdown(sb);
> +	drop_super(sb);
> +}
> +
> +static const struct blk_holder_ops fs_holder_ops = {
> +	.mark_dead		= fs_mark_dead,
> +};
>  
>  static int set_bdev_super(struct super_block *s, void *data)
>  {
> @@ -1248,7 +1264,8 @@ int get_tree_bdev(struct fs_context *fc,
>  	if (!fc->source)
>  		return invalf(fc, "No source specified");
>  
> -	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type, NULL);
> +	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type,
> +				  &fs_holder_ops);
>  	if (IS_ERR(bdev)) {
>  		errorf(fc, "%s: Can't open blockdev", fc->source);
>  		return PTR_ERR(bdev);
> @@ -1333,7 +1350,7 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
>  	if (!(flags & SB_RDONLY))
>  		mode |= FMODE_WRITE;
>  
> -	bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
> +	bdev = blkdev_get_by_path(dev_name, mode, fs_type, &fs_holder_ops);
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 21a98168085641..cf3042641b9b30 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1932,6 +1932,7 @@ struct super_operations {
  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	void (*shutdown)(struct super_block *sb);
>  };
>  
>  /*
> -- 
> 2.39.2
> 
