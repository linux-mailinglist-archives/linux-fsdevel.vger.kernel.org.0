Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4751210D008
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 00:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfK1X7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 18:59:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42125 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1X7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 18:59:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so5536785qtq.9;
        Thu, 28 Nov 2019 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQwL4adBgXITc3PkYkwHn1sVmJQxAI5c44/ZAMQ909k=;
        b=SzvDGgqDbhXRLCNx2yAvCitr/MeJnBLqu0VZWKbEKIIM6e/tradTFioO2kNcvyLsDS
         N1GjfKiKATmESqzIG7MV0zf+Ge17s3lu8rITgQzXVgMQDvZ7/L80K/eSJeNsAmbp7g6C
         Rp5dEWUc98LpgXd+0f6qCXoBTHbIhl2BKWCIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQwL4adBgXITc3PkYkwHn1sVmJQxAI5c44/ZAMQ909k=;
        b=dt318LtLLdBMtoneHQtMnKSbW+2Kpt+ioUQOtfRRvH1Bae0otyKNPD+kFhgOGNVymk
         wgnJsFbtNPHJfH+KqGg0BbWqDJzzoJUpthATYKDZ03GaAEKENm2RekZXAZvo3JtYhUPh
         dkge/z588b9oTr69wSev/nz9fQmQ78u5E50PCImiP3w/5aTvgKgmcePS1FzEwcPg/Vb4
         mssbDua1P7rwP4s3rGbpW18aZFDq+7u7ftMfhXz3Cqw/vcPE7AnonIzrRDGLQdx6sqep
         g5LobTXEjrd4NHNuJ/5tE3JmobM3iLZHRlmbaqZzIvra+7qmAKSMm7G/pFkNHlfxAHji
         0/Fg==
X-Gm-Message-State: APjAAAWIuzw5be8bS/naqRqw6OCjP0vk92Kxlb8oCXN9SAzciqyyONfc
        VpmcwUlTyrkIA6Rc1SSlOuTePqvSu3k5hOnHZRg=
X-Google-Smtp-Source: APXvYqzXePwMmNs55hixBu4+IfrZ4gkETYPVrExEHD2UWD0h2FOIELUjUmdNdLDG9KQCXq8x8FQZdxVZh7rv0QNJ1Yc=
X-Received: by 2002:ac8:7292:: with SMTP id v18mr1945327qto.169.1574985585624;
 Thu, 28 Nov 2019 15:59:45 -0800 (PST)
MIME-Version: 1.0
References: <156950767876.30879.17024491763471689960.stgit@warthog.procyon.org.uk>
 <f34aaf61-955a-7867-ef93-f22d3d8732c3@cogentembedded.com> <CA+EcR22=7F7X-9qYXb94dAp6w0_3FoKJPMRhFht+VWgKonoing@mail.gmail.com>
 <2758feea-8d6e-c690-5cac-d42213f2024b@huawei.com>
In-Reply-To: <2758feea-8d6e-c690-5cac-d42213f2024b@huawei.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Nov 2019 23:59:33 +0000
Message-ID: <CACPK8Xcv=sm94jA7+g144TMUpy=t=0juKochCvkb2AcG9e-u-g@mail.gmail.com>
Subject: Re: [PATCH] jffs2: Fix mounting under new mount API
To:     Hou Tao <houtao1@huawei.com>
Cc:     Han Xu <xhnjupt@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Richard Weinberger <richard@nod.at>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        viro@zeniv.linux.org.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Nov 2019 at 12:05, Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
> On 2019/11/14 4:38, Han Xu wrote:
> > Tested the JFFS2 on 5.4 kernel as the instruction said, still got some
> > errors, any ideas?
> >
>
> >
> > With the patch,
> >
> > root@imx8mmevk:~# cat /proc/mtd
> > dev:    size   erasesize  name
> > mtd0: 00400000 00020000 "mtdram test device"
> > mtd1: 04000000 00020000 "5d120000.spi"
> > root@imx8mmevk:~# mtd_debug info /dev/mtd0
> > mtd.type = MTD_RAM
> > mtd.flags = MTD_CAP_RAM
> > mtd.size = 4194304 (4M)
> > mtd.erasesize = 131072 (128K)
> > mtd.writesize = 1
> > mtd.oobsize = 0
> > regions = 0
> >
> > root@imx8mmevk:~# flash_erase /dev/mtd0 0 0
> > Erasing 128 Kibyte @ 3e0000 -- 100 % complete
> > root@imx8mmevk:~# mount -t jffs2 /dev/mtdblock0 test_dir/
> > root@imx8mmevk:~# mount
> > /dev/mtdblock0 on /home/root/test_dir type jffs2 (rw,relatime)
> >
> > BUT, it's not writable.
>
> You should revert the following commit to make it work:
>
> commit f2538f999345405f7d2e1194c0c8efa4e11f7b3a
> Author: Jia-Ju Bai <baijiaju1990@gmail.com>
> Date:   Wed Jul 24 10:46:58 2019 +0800
>
>     jffs2: Fix possible null-pointer dereferences in jffs2_add_frag_to_fragtree()
>
> The revert needs to get into v5.4. Maybe Richard has forget about it ?

I hit this today. The error I saw was:

[    4.975868] jffs2: error: (77) jffs2_build_inode_fragtree: Add node
to tree failed -22
[    4.983923] jffs2: error: (77) jffs2_do_read_inode_internal: Failed
to build final fragtree for inode #5377: error -22
[    4.994709] jffs2: Returned error for crccheck of ino #5377. Expect
badness...

Reverting the f2538f999345 commit fixed things.

Is the revert queued for stable?

Cheers,

Joel
