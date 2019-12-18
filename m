Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEFD12568F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 23:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRWU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 17:20:26 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:43988 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLRWU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:20:26 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihhg1-0004b8-9k; Wed, 18 Dec 2019 22:20:17 +0000
Message-ID: <50aa62939858f36007d84b97ad02626f32d0c477.camel@codethink.co.uk>
Subject: Re: [PATCH v2 23/27] compat_ioctl: move HDIO ioctl handling into
 drivers/ide
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Date:   Wed, 18 Dec 2019 22:20:16 +0000
In-Reply-To: <CAK8P3a28Qn22Cx-bVhY5rjZVuhRXE2Jb0rezCozAhC0DZqxcUg@mail.gmail.com>
References: <20191217221708.3730997-1-arnd@arndb.de>
         <20191217221708.3730997-24-arnd@arndb.de>
         <a75a7d44ebd9ff65499445dd6b087c92345af2e4.camel@codethink.co.uk>
         <CAK8P3a28Qn22Cx-bVhY5rjZVuhRXE2Jb0rezCozAhC0DZqxcUg@mail.gmail.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-12-18 at 23:17 +0100, Arnd Bergmann wrote:
> On Wed, Dec 18, 2019 at 10:11 PM Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
> > > Most of the HDIO ioctls are only used by the obsolete drivers/ide
> > > subsystem, these can be handled by changing ide_cmd_ioctl() to be aware
> > > of compat mode and doing the correct transformations in place and using
> > > it as both native and compat handlers for all drivers.
> > > 
> > > The SCSI drivers implementing the same commands are already doing
> > > this in the drivers, so the compat_blkdev_driver_ioctl() function
> > > is no longer needed now.
> > > 
> > > The BLKSECTSET and HDIO_GETGEO_BIG ioctls are not implemented
> > > in any driver any more and no longer need any conversion.
> > [...]
> > 
> > I noticed that HDIO_DRIVE_TASKFILE, handled by ide_taskfile_ioctl() in
> > drivers/ide/ide-taskfile.c, never had compat handling before.  After
> > this patch it does, but its argument isn't passed through compat_ptr().
> > Again, doesn't really matter because IDE isn't a thing on s390.
> 
> I checked again, and I think it's worse than that: ide_taskfile_ioctl()
> takes an ide_task_request_t argument, which is not compatible
> at all (it has two long members). I suspect what happened here
> is that I confused it with ide_cmd_ioctl(), which takes a 'struct
> ide_taskfile' argument that /is/ compatible.
> 
> I don't think there is a point in adding a handler now: most
> users of drivers/ide are 32-bit only, and nobody complained
> so far, but I would add this change if you agree:

Looks good to me.

Ben.

> diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
> index f6497c817493..83afee3983fe 100644
> --- a/drivers/ide/ide-ioctls.c
> +++ b/drivers/ide/ide-ioctls.c
> @@ -270,6 +270,9 @@ int generic_ide_ioctl(ide_drive_t *drive, struct
> block_device *bdev,
>         case HDIO_DRIVE_TASKFILE:
>                 if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
>                         return -EACCES;
> +               /* missing compat handler for HDIO_DRIVE_TASKFILE */
> +               if (in_compat_syscall())
> +                       return -ENOTTY;
>                 if (drive->media == ide_disk)
>                         return ide_taskfile_ioctl(drive, arg);
>                 return -ENOMSG;
> 
> 
> 
>          Arnd
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

