Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AB312566A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 23:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLRWSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 17:18:08 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:18:08 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCb2L-1iYayM1wPr-009kFD; Wed, 18 Dec 2019 23:18:05 +0100
Received: by mail-qv1-f53.google.com with SMTP id t6so1417050qvs.5;
        Wed, 18 Dec 2019 14:18:04 -0800 (PST)
X-Gm-Message-State: APjAAAVaZD2Eg3fQdtcxD5JNcEDeSWedyMkZnQMYrHy4zAjY87Gesyih
        JnguV6JWq6ALfPIct0HX+dvV0SENfOwKpuyDtco=
X-Google-Smtp-Source: APXvYqyDPnpRg6mwfTYotGIKOQD9lfniBnekpDffjnBEQMcvT9QFg9SCGIabTN09eE8JL5PLpkkzWzeQzawX7/VdQRw=
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr4714621qvg.197.1576707483927;
 Wed, 18 Dec 2019 14:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de> <20191217221708.3730997-24-arnd@arndb.de>
 <a75a7d44ebd9ff65499445dd6b087c92345af2e4.camel@codethink.co.uk>
In-Reply-To: <a75a7d44ebd9ff65499445dd6b087c92345af2e4.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Dec 2019 23:17:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a28Qn22Cx-bVhY5rjZVuhRXE2Jb0rezCozAhC0DZqxcUg@mail.gmail.com>
Message-ID: <CAK8P3a28Qn22Cx-bVhY5rjZVuhRXE2Jb0rezCozAhC0DZqxcUg@mail.gmail.com>
Subject: Re: [PATCH v2 23/27] compat_ioctl: move HDIO ioctl handling into drivers/ide
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1PWPgZSgrRh6EkOUrB3DH+xnzxWn4VChdd2c+XUEePlmPgEeiRT
 WBXUNhoDFsWsB3hFwrB8BWcaTMZ98sEXhl1yhopz051z3GfzrXW2sjnLGTDTOgoI7h4ZrkA
 Wz3r1NRM3OTTjWJyMOoGBcMyG/0eU2luHF/loRr6FvQzgmZY4FgQyKSCOUwwNZYetGTXSc3
 ObsQGsD1xEzW1TOWm0zkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCLkvQsMPHY=:VDRkTzHgQuVwKcfZTX1u3c
 Odf9cE7PFpDFxH3rWds5DWffyWo9xpGYD7HllVmGHIspdwdcy8OWnDb6pRjzRcR6n10keYisV
 54NYj3peZVr6V5wA2l18peGWDmj/2oNEiDnNQqV4QrQkUVstQdKiwM0GUjU9fwRZvAPIa23bI
 ikebAXX+CkFGogZzFsE/I8FOmKMevGeslbyQkZ0A1bSygpO3h+F8YCaoz0HlcGdaQ+fJUHba1
 eGZRftu6zpBq9CDHpqmPcojBvh6UvPa0IHRmLJlucWmVL88GEYDJQoQ+If9zX40UJWukt+0RT
 uS81BK/d6enp8kTOg2C+EK8/lLgQy/MT2S7Hq+Hxx+O1vD9MjjtDpbH4gzjTr1haxyTe7h6UJ
 drby9OJqq4bBuGnx/Oi8LXaUecAe/X749by6S4hbU+JzZAKpRmBW6XvMDhN5p5LbOF3O1W1pB
 Gyd+HaTpFjrAGa7hxcClEwNU/A5+NBig8cyg+fuLgKUFlDEYsnG2NTx/0uFQuEVFwyqM/NO+V
 ozWcER5O2eJfCOF7c/67Nj03gtVSaKj3NDgg4MKsiLE4UJAtqm37csxazsTgaXv7Qp2j5to3O
 C7ba353V33oTdnoV9ODoqWhWxBhciNbwOZp11vTPS5g7OBLzcLYLZA0SZ+JTi4jBWf5UJY2Wb
 1/5L0N/zuxJuXpRYOj7W7Qy0OyDntmqjCkn6bGqJx19rNVdMjdHMjl4cNHVcPwzm77W7WrJs3
 PKpnpTi8q8uD3GFPW+4nJxbZa6/DLbV0VmpbSZqYDlBC0lzNFEcuU93gd0Vcqu++u6sk2DvPv
 pxugqTtQ6rZ9OGTHmD641paRuungUXGui8mJUrTAHJ0x6CjQ9SAnLzWiUAg+YrjD6b1CnP4W/
 DH3Ifk4KJjOivfjXflFw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:11 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
> > Most of the HDIO ioctls are only used by the obsolete drivers/ide
> > subsystem, these can be handled by changing ide_cmd_ioctl() to be aware
> > of compat mode and doing the correct transformations in place and using
> > it as both native and compat handlers for all drivers.
> >
> > The SCSI drivers implementing the same commands are already doing
> > this in the drivers, so the compat_blkdev_driver_ioctl() function
> > is no longer needed now.
> >
> > The BLKSECTSET and HDIO_GETGEO_BIG ioctls are not implemented
> > in any driver any more and no longer need any conversion.
> [...]
>
> I noticed that HDIO_DRIVE_TASKFILE, handled by ide_taskfile_ioctl() in
> drivers/ide/ide-taskfile.c, never had compat handling before.  After
> this patch it does, but its argument isn't passed through compat_ptr().
> Again, doesn't really matter because IDE isn't a thing on s390.

I checked again, and I think it's worse than that: ide_taskfile_ioctl()
takes an ide_task_request_t argument, which is not compatible
at all (it has two long members). I suspect what happened here
is that I confused it with ide_cmd_ioctl(), which takes a 'struct
ide_taskfile' argument that /is/ compatible.

I don't think there is a point in adding a handler now: most
users of drivers/ide are 32-bit only, and nobody complained
so far, but I would add this change if you agree:

diff --git a/drivers/ide/ide-ioctls.c b/drivers/ide/ide-ioctls.c
index f6497c817493..83afee3983fe 100644
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -270,6 +270,9 @@ int generic_ide_ioctl(ide_drive_t *drive, struct
block_device *bdev,
        case HDIO_DRIVE_TASKFILE:
                if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
                        return -EACCES;
+               /* missing compat handler for HDIO_DRIVE_TASKFILE */
+               if (in_compat_syscall())
+                       return -ENOTTY;
                if (drive->media == ide_disk)
                        return ide_taskfile_ioctl(drive, arg);
                return -ENOMSG;



         Arnd
