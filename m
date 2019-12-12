Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4B11C8F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 10:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfLLJSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 04:18:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfLLJSD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:18:03 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MYvoW-1iAeaH2EHg-00UtcV; Thu, 12 Dec 2019 10:18:01 +0100
Received: by mail-qk1-f177.google.com with SMTP id k6so1027076qki.5;
        Thu, 12 Dec 2019 01:18:01 -0800 (PST)
X-Gm-Message-State: APjAAAU0UtilEnUCQTaJYmBUXTRahod+qULvJwS1XeKjKQFtJ0CwesBs
        e4tLZV27XkGr9zodnIP0oANEw+fK0owckrsCN/g=
X-Google-Smtp-Source: APXvYqxQ00UNQvIg4lRrwqZ6prCq1ld+K+cVy4gCbiI7WVM1uWsZJdRSTMNOdaexs+HkrBjFyzUyLfqiJWBof8X+Tg8=
X-Received: by 2002:a37:5b45:: with SMTP id p66mr7106225qkb.394.1576142280134;
 Thu, 12 Dec 2019 01:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-16-arnd@arndb.de>
 <20191211180155-mutt-send-email-mst@kernel.org> <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
In-Reply-To: <858768fb-5f79-8259-eb6a-a26f18fb0e04@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 10:17:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2hxD9aaabf2sK3ozqVdr2pbDS10W+Z6oT4idk=AitwVQ@mail.gmail.com>
Message-ID: <CAK8P3a2hxD9aaabf2sK3ozqVdr2pbDS10W+Z6oT4idk=AitwVQ@mail.gmail.com>
Subject: Re: [PATCH 15/24] compat_ioctl: scsi: move ioctl handling into drivers
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        John Garry <john.garry@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:etAzTzAXTBuE1n7+RgDQ+4qewvW2SmRgdxlCZwQKwACTZ0dz46t
 uvymLy48UI4w/Ne1YF85QhRqNe+A38yuaXH2ehQFJF/qMb55lDdn2eD2rQDSGqwpT5tYr4j
 Vbk74ffHDk5L7vaPzcr3wT5bAsdHAo6DPQnCjQZSsKQMJprIh4+ZgGANy9m2XC3TfzY1ZhP
 MkpvfSl1bPLcfpV8NO4aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yoo1EQsxf+0=:9LgzVd8CwF7yxMCHZSmNWu
 WnBvulPLYwgf38Zp4K0uCs1cYV5iPCSXtFGTmjOgRQ9JifXQ+32SrQYJHyWlkOmKhW/sqAORB
 4GMTFDK2+VswTTv53x9LjylGqrdlr3Mr9ull+Xkh9EH+eyAa2oggDcenwKfGuhqAz0EX0sbYI
 3l6g61e5RpsTD7+35HNH4Ic4Ceh9IV+GxyStxizrOeYYieb9+b68SyoRjdB9rPmvMzFw8JMgS
 no7x7+u0z9/EzualpgN5UZjVtZwogbxmeWqZIcuVFy3Wue2/fj9x5887PtsWC2HFKiVUbCm34
 /1zPQlQtL0ipLgp1UkozTy0kQp4UoPgcmFuW7rmliP0oxcvRPzG+oYp/Gk5Nt3nBiETuO6SXK
 9B1lzKXf/Fee8nbmoMdUIl8YC7VkPeV53+oiWVEm8SWGJrF3QDiDLkBCUKKpS3tmAQGIz16Jk
 e5ZRYy5Vjpb0nUQcJrt/DCZoW0H7Hp8tK1gJLuYDdvSnHYDvjQhkpR1coIDk6ATkmyBiQzsAL
 bLOhOVYS6vG5Bc4y/dcDHnCk0sQET77QG56/ZZecBvsMQWoOJVDpvioIr1wOTRmnFb9b4BNa4
 TYstnQmBCTV94YmDRffcDU565z087vhJs2CIvttvMWhB1dS8sdp3UDdXdTOTzL6MkjNJni2fL
 UMwe/9x5lm8Fkr5Uv8PEv/zN85zC0WCE7/wXDEYMBIpCguBtVoqBGbstw8xJJuWq9Bz9gDx6q
 r3Zjes2Gh/vZMTUoZiSGa2GuQk0+q/16wU8eyFD9oaWfVOnjFE37C3BAqEduZt6eFSO6Gte9p
 kWkVq7AYrX6JA9IWhQYFXe2VuXwBBEt0wiVFkqOA16shup+GNRN0qFlL9e+qhfScuIe9VUS6A
 0pH7F4DrlVid+mTCKSNA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 12, 2019 at 1:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/12/19 00:05, Michael S. Tsirkin wrote:
> >> @@ -405,6 +405,9 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
> >>
> >>  static const struct block_device_operations virtblk_fops = {
> >>      .ioctl  = virtblk_ioctl,
> >> +#ifdef CONFIG_COMPAT
> >> +    .compat_ioctl = blkdev_compat_ptr_ioctl,
> >> +#endif
> >>      .owner  = THIS_MODULE,
> >>      .getgeo = virtblk_getgeo,
> >>  };
> > Hmm - is virtio blk lumped in with scsi things intentionally?
>
> I think it's because the only ioctl for virtio-blk is SG_IO.  It makes
> sense to lump it in with scsi, but I wouldn't mind getting rid of
> CONFIG_VIRTIO_BLK_SCSI altogether.

It currently calls scsi_cmd_blk_ioctl(), which implements a bunch of ioctl
commands, including some that are unrelated to SG_IO:

                case SG_GET_VERSION_NUM:
                case SCSI_IOCTL_GET_IDLUN:
                case SCSI_IOCTL_GET_BUS_NUMBER:
                case SG_SET_TIMEOUT:
                case SG_GET_TIMEOUT:
                case SG_GET_RESERVED_SIZE:
                case SG_SET_RESERVED_SIZE:
                case SG_EMULATED_HOST:
                case SG_IO: {
                case CDROM_SEND_PACKET:
                case SCSI_IOCTL_SEND_COMMAND:
                case CDROMCLOSETRAY:
                case CDROMEJECT:

My patch changes all callers of this function, and the idea is
to preserve the existing behavior through my series, so I think
it makes sense to keep my patch as is.

I would assume that calling scsi_cmd_blk_ioctl() is harmless
here, but if you want to remove it or limit the set of supported
commands, that should be independent of my change.

       Arnd
