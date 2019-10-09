Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C996D1370
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfJIQBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 12:01:47 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33784 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJIQBr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:01:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so4199294qtd.0;
        Wed, 09 Oct 2019 09:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWFHkd6ek0BtHyg9BV3fh9tCSDHEofWpBNJTTKARQwo=;
        b=kaUhu2nWdn12oM/CzR/8uNlhivq7ptWPXCXwRV3MGgWwJR6U9CGEs7zcoDFHQLrjfM
         RGN1nv86kty9QqzmMzZ0N2YAIUwOvwN3/InyILq43nJrkKuxeOPBTha0vhaT4Oi1XqN7
         LQkULD5xSeQas+PY9+ar+ebSOqsDKz91t+uhqF+hqdsgyt+me9kVj3ubn2v9Mp1Pl6j9
         izL7CG0HJTYxVVVw+u+2fQrPrONiiiTIjUIPnCsNKEfLfTArt/LUnuPp4iDhxCwau3dB
         kDiaVq3L6dzuDx0aNcR2w+XxmlJ3/YL/u0H6M83QXyTV3Lzn/B+pwj3rYwMAIkJdmKgJ
         IzCg==
X-Gm-Message-State: APjAAAWuhvpsq7iUgR+XO/mgZbRe/VAe3ux21SFZVYtoSmpOzo+KSft2
        XBDxl2R31/iDGgNlD5dKynHEsbJpPWvOxWG48Co=
X-Google-Smtp-Source: APXvYqxJLyCeHAUAU1azpG4v5iXs9SXOmBMoaRvC78sbGAuHi5eUtVSvqkcf9ThEOBLk2iBn+of79sDp2hHG8oqoBW0=
X-Received: by 2002:ac8:729a:: with SMTP id v26mr4380259qto.18.1570636905814;
 Wed, 09 Oct 2019 09:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190918153445.1241-1-maier@linux.ibm.com>
In-Reply-To: <20190918153445.1241-1-maier@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Oct 2019 18:01:29 +0200
Message-ID: <CAK8P3a1HBog84Wvdgm1ccz1gRJRxHm8ucsxwUTTqh02gOt9WbQ@mail.gmail.com>
Subject: Re: [PATCH] compat_ioctl: fix reimplemented SG_IO handling causing
 -EINVAL from sg_io()
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Benjamin Block <bblock@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:35 PM Steffen Maier <maier@linux.ibm.com> wrote:
>
> scsi_cmd_ioctl() had hdr as on stack auto variable and called
> copy_{from,to}_user with the address operator &hdr and sizeof(hdr).
>
> After the refactoring, {get,put}_sg_io_hdr() takes a pointer &hdr.
> So the copy_{from,to}_user within the new helper functions should
> just take the given pointer argument hdr and sizeof(*hdr).
>
> I saw -EINVAL from sg_io() done by /usr/lib/udev/scsi_id which could
> in turn no longer whitelist SCSI disks for devicemapper multipath.
>
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> Fixes: 4f45155c29fd ("compat_ioctl: reimplement SG_IO handling")
> ---
>
> Arnd, I'm not sure about the sizeof(hdr32) change in the compat part in
> put_sg_io_hdr().
>
> This is for next, probably via Arnd's y2038/y2038,
> and it fixes next-20190917 for me regarding SCSI generic.

Hi Steffen,

Sorry for the long delay. I ended up not sending my pull request for
v5.4, so the bug is not there. I have now rebased my branch
on top of v5.4-rc2 and plan to send it for the v5.5 merge window.

I have folded your bugfix into my original patch, hope that's ok with
you. Tomorrow's linux-next should be fixed.

    Arnd
