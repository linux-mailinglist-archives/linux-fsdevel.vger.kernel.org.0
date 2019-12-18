Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA455125276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfLRT5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:57:12 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:37712 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726698AbfLRT5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:57:12 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihfRO-0000cc-0V; Wed, 18 Dec 2019 19:57:02 +0000
Message-ID: <f9fd39116713f17e55091868326a419190220559.camel@codethink.co.uk>
Subject: Re: [PATCH v2 18/27] compat_ioctl: scsi: move ioctl handling into
 drivers
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 18 Dec 2019 19:57:01 +0000
In-Reply-To: <20191217221708.3730997-19-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
         <20191217221708.3730997-19-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-17 at 23:16 +0100, Arnd Bergmann wrote:
[...]
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
[...]
> @@ -598,6 +599,55 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_COMPAT
> +static int sr_block_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
> +			  unsigned long arg)
> +{
> +	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
> +	struct scsi_device *sdev = cd->device;
> +	void __user *argp = compat_ptr(arg);
> +	int ret;
> +
> +	mutex_lock(&sr_mutex);
> +
> +	ret = scsi_ioctl_block_when_processing_errors(sdev, cmd,
> +			(mode & FMODE_NDELAY) != 0);
> +	if (ret)
> +		goto out;
> +
> +	scsi_autopm_get_device(sdev);
> +
> +	/*
> +	 * Send SCSI addressing ioctls directly to mid level, send other
> +	 * ioctls to cdrom/block level.
> +	 */
> +	switch (cmd) {
> +	case SCSI_IOCTL_GET_IDLUN:
> +	case SCSI_IOCTL_GET_BUS_NUMBER:
> +		ret = scsi_compat_ioctl(sdev, cmd, argp);
> +		goto put;
> +	}
> +
> +	/*
> +	 * CDROM ioctls are handled in the block layer, but
> +	 * do the scsi blk ioctls here.
> +	 */
> +	ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
> +	if (ret != -ENOTTY)
> +		return ret;

This needs to be be "goto put;"

> +	ret = scsi_compat_ioctl(sdev, cmd, argp);
> +
> +put:
> +	scsi_autopm_put_device(sdev);
> +
> +out:
> +	mutex_unlock(&sr_mutex);
> +	return ret;
> +
> +}
> +#endif
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

