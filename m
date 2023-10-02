Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED8E7B5828
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 18:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjJBQc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbjJBQc5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:32:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA68B3
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 09:32:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7F31D2185F;
        Mon,  2 Oct 2023 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696264372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TMQIOOIaFDrmUgpa8A3HnXHD8TcSIEniV0QVVHf12k=;
        b=qE47uU55SHYSmSKxpwbRo5BuVTaZ2RFmjYpZ4soUlWaliCn/n/n20bU2L4K9OmERh//Lnn
        S0Fy74/um6kVqBWDroh6Q6Ee1Z+/5IExcKp2IjgCnzRsxGq+s/Kmfgpr9CALn/ryIXmyQ0
        Rjo4dRIvFhoormneVpLCRDLDPiUt9Y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696264372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2TMQIOOIaFDrmUgpa8A3HnXHD8TcSIEniV0QVVHf12k=;
        b=eSe4698PGcOFbTE1uBLZr3keaj/DtmGYCs8en17WCSkWviQd5fuUcTUrypzGwuq+ZBzyXd
        PdZpZpMVLUIZmbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67C5313434;
        Mon,  2 Oct 2023 16:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +MtRGbTwGmXdJAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Oct 2023 16:32:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C33E3A07C9; Mon,  2 Oct 2023 18:32:51 +0200 (CEST)
Date:   Mon, 2 Oct 2023 18:32:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 2/7] bdev: add freeze and thaw holder operations
Message-ID: <20231002163251.vwsbwwmi4vyfu4ae@quack3>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
 <20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-vfs-super-freeze-v1-2-ecc36d9ab4d9@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-09-23 15:21:15, Christian Brauner wrote:
> Add block device freeze and thaw holder operations. Follow-up patches
> will implement block device freeze and thaw based on stuct
> blk_holder_ops.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good (I don't really care whether you fold this into patch 3 or not).
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index bf25b63e13d5..f2ddccaaef4d 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1468,6 +1468,16 @@ struct blk_holder_ops {
>  	 * Sync the file system mounted on the block device.
>  	 */
>  	void (*sync)(struct block_device *bdev);
> +
> +	/*
> +	 * Freeze the file system mounted on the block device.
> +	 */
> +	int (*freeze)(struct block_device *bdev);
> +
> +	/*
> +	 * Thaw the file system mounted on the block device.
> +	 */
> +	int (*thaw)(struct block_device *bdev);
>  };
>  
>  extern const struct blk_holder_ops fs_holder_ops;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
