Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5636898EBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbfHVJG1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 05:06:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732927AbfHVJG0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:06:26 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 1F8C08038BA942CCAE6F;
        Thu, 22 Aug 2019 17:06:23 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 17:06:22 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 22 Aug 2019 17:06:21 +0800
Date:   Thu, 22 Aug 2019 17:05:41 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Gao Xiang <hsiangkao@aol.com>, Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: erofs: Question on unused fields in on-disk structs
Message-ID: <20190822090541.GA193349@architecture4>
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Richard,

On Thu, Aug 22, 2019 at 10:33:01AM +0200, Richard Weinberger wrote:
> On Thu, Aug 22, 2019 at 12:03 AM Gao Xiang <hsiangkao@aol.com> wrote:
> >
> > Hi Richard,
> >
> > On Wed, Aug 21, 2019 at 11:37:30PM +0200, Richard Weinberger wrote:
> > > Gao Xiang,
> > >
> > > On Mon, Aug 19, 2019 at 10:45 PM Gao Xiang via Linux-erofs
> > > <linux-erofs@lists.ozlabs.org> wrote:
> > > > > struct erofs_super_block has "checksum" and "features" fields,
> > > > > but they are not used in the source.
> > > > > What is the plan for these?
> > > >
> > > > Yes, both will be used laterly (features is used for compatible
> > > > features, we already have some incompatible features in 5.3).
> > >
> > > Good. :-)
> > > I suggest to check the fields being 0 right now.
> > > Otherwise you are in danger that they get burned if an mkfs.erofs does not
> > > initialize the fields.
> >
> > Sorry... I cannot get the point...
> 
> Sorry for being unclear, let me explain in more detail.

Thank you!

> 
> > super block chksum could be a compatible feature right? which means
> > new kernel can support it (maybe we can add a warning if such image
> > doesn't have a chksum then when mounting) but old kernel doesn't
> > care it.
> 
> Yes. But you need some why to indicate that the chksum field is now
> valid and must be used.

We can add a compat "feature" as my following saying...
(If I missed something, please kindly point out...)

> 
> The features field can be used for that, but you don't use it right now.
> I recommend to check it for being 0, 0 means then "no features".
> If somebody creates in future a erofs with more features this code
> can refuse to mount because it does not support these features.

"requirements" field is for that, it means incompat features as the following code shown:
 69 static bool check_layout_compatibility(struct super_block *sb,
 70                                        struct erofs_super_block *layout)
 71 {
 72         const unsigned int requirements = le32_to_cpu(layout->requirements);
 73
 74         EROFS_SB(sb)->requirements = requirements;
 75
 76         /* check if current kernel meets all mandatory requirements */
 77         if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
 78                 errln("unidentified requirements %x, please upgrade kernel version",
 79                       requirements & ~EROFS_ALL_REQUIREMENTS);
 80                 return false;
 81         }
 82         return true;
 83 }

if some "requirements" don't be recognized by the current kernel,
it will refuse to mount but "features" not.

> 
> But be very sure that existing erofs filesystems actually have this field
> set to 0 or something other which is always the same.
> Otherwise you cannot use the field anymore because it could be anything.
> A common bug is that the mkfs program keeps such unused fields
> uninitialized and then it can be a more or less random value without
> notice.

Why? In my thought, the logic is that
 - v4.3, "features" that kernel can handle is 0, so chksum is unused (DONTCARE field)
   and chksum field could be anything, but the kernel doesn't care.

 - later version, add an extra compat feature to "features" to indicate SB_CHKSUM
    is now valid, such as EROFS_FEATURE_SB_CHKSUM (rather than requirements, it's
    incompat), so the kernel can check the checksum like that:

    if (feature & EROFS_FEATURE_SB_CHKSUM) {	/* chksum is set */
        if (chk crc32c and no match) {
             return -EFSBADCRC;
	}
        go ahead
    } else {
        /* still don't care chksum field but print the following warning to kmsg */
        warnln("You are mounting a image without super_block chksum, please take care!!!!");

        or maybe we can even refuse mount these images, except for some mount option
        such as "force-mount".
    }

 That is also what F2FS did recently, refer the following commit
   commit d440c52d3151("f2fs: support superblock checksum")

> 
> > Or maybe you mean these reserved fields? I have no idea all other
> > filesystems check these fields to 0 or not... But I think it should
> > be used with some other flag is set rather than directly use, right?
> 
> Basically you want a way to know when a field shall be used and when not.
> Most filesystems have version/feature fields. Often multiple to denote different
> levels of compatibility.

On-disk inode has i_advise field, and super_block has
"features" and "requirements" fields. we can use some of them
or any combinations.

Thanks,
Gao Xiang

> 
> -- 
> Thanks,
> //richard
