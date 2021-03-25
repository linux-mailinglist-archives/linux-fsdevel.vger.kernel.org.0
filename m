Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68B8349806
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhCYRaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 13:30:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38202 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCYR3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:29:47 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3EA4F20B5680;
        Thu, 25 Mar 2021 10:29:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3EA4F20B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616693387;
        bh=QQfTkgsngBop3Tqx5XH9+idTDW0MUYe7P31vACwHE+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=amHaVZJM1c5uXjhVYTo1ubPgMMCmhg7sk0AYbM2TwoJexCKPlsCBxPg5aIu/Xr74Y
         Ho8vOLLIQ/uLTDkZDeSpQNlJ0pUe67rMR2ezdDBWAbX+Bl6jfzXKGgfqhZs6hGU8qV
         C6H0nihmJnvbvScDzYPRlWZiC9RLxBI9rLWC0f7o=
Received: by mail-pg1-f180.google.com with SMTP id l76so2503211pga.6;
        Thu, 25 Mar 2021 10:29:47 -0700 (PDT)
X-Gm-Message-State: AOAM530KulwDei525WfPzMBROGGaGcqv9IMZ5cjw9RogW3Wr64SgcDwP
        njLJ9F77ldByc3JeAQFqa5T/kdVdzFFDkaXBCPc=
X-Google-Smtp-Source: ABdhPJzVxhv7vNQD2GeuO08lyQfBGF5bActoAR1gprqbd95MFicosMvJ611Zv3COVovE4mXPWbeaCVmXSm16zCJ6QGY=
X-Received: by 2002:a63:2345:: with SMTP id u5mr8857421pgm.326.1616693386792;
 Thu, 25 Mar 2021 10:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com> <20210315201824.GB2577561@casper.infradead.org>
 <20210315210452.GC2577561@casper.infradead.org>
In-Reply-To: <20210315210452.GC2577561@casper.infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 25 Mar 2021 18:29:10 +0100
X-Gmail-Original-Message-ID: <CAFnufp3zKa+9K-hsV5vRkv-w8y-1nZioq_bFAnzaxs9RoP+sDA@mail.gmail.com>
Message-ID: <CAFnufp3zKa+9K-hsV5vRkv-w8y-1nZioq_bFAnzaxs9RoP+sDA@mail.gmail.com>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Mar 15, 2021 at 08:18:24PM +0000, Matthew Wilcox wrote:
> > On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > >
> > > Add a sequence number to the disk devices. This number is put in the
> > > uevent so userspace can correlate events when a driver reuses a device,
> > > like the loop one.
> >
> > Should this be documented as monotonically increasing?  I think this
> > is actually a media identifier.  Consider (if you will) a floppy disc.
> > Back when such things were common, it was possible with personal computers
> > of the era to have multiple floppy discs "in play" and be prompted to
> > insert them as needed.  So shouldn't it be possible to support something
> > similar here -- you're really removing the media from the loop device.
> > With a monotonically increasing number, you're always destroying the
> > media when you remove it, but in principle, it should be possible to
> > reinsert the same media and have the same media identifier number.
>
> So ... a lot of devices have UUIDs or similar.  eg:
>
> $ cat /sys/block/nvme0n1/uuid
> e8238fa6-bf53-0001-001b-448b49cec94f
>
> https://linux.die.net/man/8/scsi_id (for scsi)
>

Hi,

I don't have uuid anywhere:

matteo@saturno:~$ ll /dev/sd?
brw-rw---- 1 root disk 8,  0 feb 16 13:24 /dev/sda
brw-rw---- 1 root disk 8, 16 feb 16 13:24 /dev/sdb
brw-rw---- 1 root disk 8, 32 feb 16 13:24 /dev/sdc
brw-rw---- 1 root disk 8, 48 feb 16 13:24 /dev/sdd
brw-rw---- 1 root disk 8, 64 mar  4 06:26 /dev/sde
brw-rw---- 1 root disk 8, 80 feb 16 13:24 /dev/sdf
matteo@saturno:~$ ll /sys/block/*/uuid
ls: cannot access '/sys/block/*/uuid': No such file or directory

mcroce@t490s:~$ ll /dev/nvme0n1
brw-rw----. 1 root disk 259, 0 25 mar 14.22 /dev/nvme0n1
mcroce@t490s:~$ ll /sys/block/*/uuid
ls: cannot access '/sys/block/*/uuid': No such file or directory

I find it only on a mdraid array:

$ cat /sys/devices/virtual/block/md127/md/uuid
26117338-4f54-f14e-b5d4-93feb7fe825d

I'm using a vanilla 5.11 kernel.

Regards,
-- 
per aspera ad upstream
