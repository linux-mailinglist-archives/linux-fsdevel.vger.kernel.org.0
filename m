Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79C7260D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbjFGNOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjFGNOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:14:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E893F95;
        Wed,  7 Jun 2023 06:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A641A219FE;
        Wed,  7 Jun 2023 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686143675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3qm10BFMOoxWlTfzY02rDFkH1MgJHM90hSPqL0EKSU=;
        b=h0v2DqBB9ySJiLnmn6KXn42VRK0Z/nPXxfHyl6P9vx/g51yoRFC9AAW5wAXqURmVlJIrCN
        2D+/sGF0Dbl/023m3VKR+jyJmZpI81N2dxOsOVo1Iyv6eQHVy55am5AqqgqG5JbeU+LsvI
        y9I3aAtB7v6O/td5ghW63FzKVmGA63w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686143675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3qm10BFMOoxWlTfzY02rDFkH1MgJHM90hSPqL0EKSU=;
        b=nE+HbFK6uzo+zBGVf8a/fbVecve2gD4PPeEmbpshgySHxZDiiPHczbZcJawWlwnNHAICqS
        Q/nUJxr0GbT6aJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7308A1346D;
        Wed,  7 Jun 2023 13:14:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uiivG7uCgGS9YAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 07 Jun 2023 13:14:35 +0000
Message-ID: <04517ec2-bf6c-0783-9494-fb12a89d07a0@suse.de>
Date:   Wed, 7 Jun 2023 15:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 30/31] block: store the holder in file->private_data
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-31-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230606073950.225178-31-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/23 09:39, Christoph Hellwig wrote:
> Store the file struct used as the holder in file->private_data as an
> indicator that this file descriptor was opened exclusively to  remove
> the last use of FMODE_EXCL.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/fops.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index c40b9f978e3bc7..915e0ef7560993 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
>   		mode |= BLK_OPEN_READ;
>   	if (file->f_mode & FMODE_WRITE)
>   		mode |= BLK_OPEN_WRITE;
> -	if (file->f_mode & FMODE_EXCL)
> +	if (file->private_data)
>   		mode |= BLK_OPEN_EXCL;
>   	if ((file->f_flags & O_ACCMODE) == 3)
>   		mode |= BLK_OPEN_WRITE_IOCTL;
> @@ -501,12 +501,15 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>   	filp->f_flags |= O_LARGEFILE;
>   	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
>   
> +	/*
> +	 * Use the file private data to store the holder, file_to_blk_mode
> +	 * relies on this.
> +	 */

Can you update the comment to reflect that we're only use the
->private_data field for exclusive open?
I know it's indicated by the condition, but we really should
be clarify this usage.

>   	if (filp->f_flags & O_EXCL)
> -		filp->f_mode |= FMODE_EXCL;
> +		filp->private_data = filp;
>   
>   	bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
> -				 (filp->f_mode & FMODE_EXCL) ? filp : NULL,
> -				 NULL);
> +				 filp->private_data, NULL);
>   	if (IS_ERR(bdev))
>   		return PTR_ERR(bdev);
>   
> @@ -517,8 +520,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
>   
>   static int blkdev_release(struct inode *inode, struct file *filp)
>   {
> -	blkdev_put(I_BDEV(filp->f_mapping->host),
> -		   (filp->f_mode & FMODE_EXCL) ? filp : NULL);
> +	blkdev_put(I_BDEV(filp->f_mapping->host), filp->private_data);
>   	return 0;
>   }
>   
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

