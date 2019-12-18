Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3822C12545C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 22:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfLRVLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 16:11:30 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:41368 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbfLRVLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:11:30 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihgbL-0002sO-Fs; Wed, 18 Dec 2019 21:11:23 +0000
Message-ID: <a75a7d44ebd9ff65499445dd6b087c92345af2e4.camel@codethink.co.uk>
Subject: Re: [PATCH v2 23/27] compat_ioctl: move HDIO ioctl handling into
 drivers/ide
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 18 Dec 2019 21:11:22 +0000
In-Reply-To: <20191217221708.3730997-24-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
         <20191217221708.3730997-24-arnd@arndb.de>
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
> Most of the HDIO ioctls are only used by the obsolete drivers/ide
> subsystem, these can be handled by changing ide_cmd_ioctl() to be aware
> of compat mode and doing the correct transformations in place and using
> it as both native and compat handlers for all drivers.
> 
> The SCSI drivers implementing the same commands are already doing
> this in the drivers, so the compat_blkdev_driver_ioctl() function
> is no longer needed now.
> 
> The BLKSECTSET and HDIO_GETGEO_BIG ioctls are not implemented
> in any driver any more and no longer need any conversion.
[...]

I noticed that HDIO_DRIVE_TASKFILE, handled by ide_taskfile_ioctl() in
drivers/ide/ide-taskfile.c, never had compat handling before.  After
this patch it does, but its argument isn't passed through compat_ptr().
Again, doesn't really matter because IDE isn't a thing on s390.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

