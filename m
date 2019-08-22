Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF92996C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbfHVOfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 10:35:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3973 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfHVOfQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:35:16 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 8DCA9D90A3DC820CA5CD;
        Thu, 22 Aug 2019 22:35:12 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 22:35:12 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 22:35:11 +0800
Date:   Thu, 22 Aug 2019 22:34:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        Gao Xiang <hsiangkao@aol.com>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822143432.GB195034@architecture4>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
 <20190822142142.GB2730@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190822142142.GB2730@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

On Thu, Aug 22, 2019 at 10:21:42AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Aug 22, 2019 at 10:33:01AM +0200, Richard Weinberger wrote:
> > > super block chksum could be a compatible feature right? which means
> > > new kernel can support it (maybe we can add a warning if such image
> > > doesn't have a chksum then when mounting) but old kernel doesn't
> > > care it.
> > 
> > Yes. But you need some why to indicate that the chksum field is now
> > valid and must be used.
> > 
> > The features field can be used for that, but you don't use it right now.
> > I recommend to check it for being 0, 0 means then "no features".
> > If somebody creates in future a erofs with more features this code
> > can refuse to mount because it does not support these features.
> 
> The whole point of "compat" features is that the kernel can go ahead
> and mount the file system even if there is some new "compat" feature
> which it doesn't understand.  So the fact that right now erofs doesn't
> have any "compat" features means it's not surprising, and perfectly
> OK, if it's not referenced by the kernel.
> 
> For ext4, we have some more complex feature bitmasks, "compat",
> "ro_compat" (OK to mount read-only if there are features you don't
> understand) and "incompat" (if there are any bits you don't
> understand, fail the mount).  But since erofs is a read-only file
> system, things are much simpler.
> 
> It might make life easier for other kernel developers if "features"
> was named "compat_features" and "requirements" were named
> "incompat_features", just because of the long-standing use of that in
> ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
> legacy of ext2 and its descendents, and there's no real reason why it
> has to be that way on other file systems.

Thanks for your detailed explanation, thanks a lot!

Thanks,
Gao Xiang

> 
> Cheers,
> 
> 						- Ted
