Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6AB1252E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 21:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfLRUL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 15:11:58 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:38882 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfLRUL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:11:57 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihffj-0001EL-M8; Wed, 18 Dec 2019 20:11:51 +0000
Message-ID: <5826d31fcf2fcbe25bf2396e32df3df7d585dd99.camel@codethink.co.uk>
Subject: Re: [PATCH v2 21/27] compat_ioctl: move cdrom commands into cdrom.c
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 18 Dec 2019 20:11:51 +0000
In-Reply-To: <20191217221708.3730997-22-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
         <20191217221708.3730997-22-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
[...]
> @@ -1710,6 +1711,38 @@ static int idecd_ioctl(struct block_device *bdev, fmode_t mode,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_COMPAT
> +static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
> +			unsigned int cmd, unsigned long arg)
> +{
> +	struct cdrom_info *info = ide_drv_g(bdev->bd_disk, cdrom_info);
> +	int err;
> +
> +	switch (cmd) {
> +	case CDROMSETSPINDOWN:
> +		return idecd_set_spindown(&info->devinfo, arg);
> +	case CDROMGETSPINDOWN:
> +		return idecd_get_spindown(&info->devinfo, arg);

compat_ptr() should also be applied to the argument for these two
commands, though I'm fairly sure IDE drivers have never been useful on
s390 so it doesn't matter in practice.

Ben.

> +	default:
> +		break;
> +	}
> +
> +	return cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
> +			   (unsigned long)compat_ptr(arg));
> +}
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

