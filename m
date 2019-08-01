Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 575C07E33F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfHATSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 15:18:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45478 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfHATSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:18:41 -0400
Received: by mail-io1-f68.google.com with SMTP id g20so146840905ioc.12;
        Thu, 01 Aug 2019 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjpoHgl5bdIW+3zphyfPWlEvrE7q6jtPkvim4b+gWWE=;
        b=nzneK+/u3TPRauFfvnomb/Pk19cglmMEjCtBKiLMDM3A8440os6Cy1BJePPtGey4Fu
         B/IGmikieJ24pr+Z/23tvhziRDB4OG0zOHFRYNhf2BGZ5v/SFM7eyH79AeXSnuVainl8
         KBLWMIqQzjT1X4do5oxoIM3BcfEv7smcjA2lKgHrybX8U9we3u/RSyS3zvJvrFD5Hg7W
         d3nAXUBLweU+9tghXXUwUOFzhYKyOPMGDxpDJ10Sj0LptlXJo98InmnQCkypLr04jTx4
         ojLyHMrrzP2HlyE5qIckvCkMjD+nMzdXVpk8EBkvTFQveGpDgsStifcJgRCp4GmRzLjw
         xj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjpoHgl5bdIW+3zphyfPWlEvrE7q6jtPkvim4b+gWWE=;
        b=o/8WUAPQ46nFDxJWt1BWW+kSNlQcVF5Qu76wEW3WfF/dJnsx1DsGNhDBasipukDGYB
         tfdzQzb3H4ZLB+ZeFe7/BMWhenqtDIDLBIf36szXYvI0F7ryxDlu+fDcHjvqhMa63iWz
         pGv1jPA1xx4SBo5h6PnxguDI50Of0J0dILfV2rn8uXspbRRC80kr1BuG50WiYO6u3NJz
         B2OaMOA15G0vL4cYnbNMn/qPPoKbPpE8XLbw1E8ekIpb3w2otfEDTgKjVs0z1OJNRvaY
         jm1I1MbL/rIH5AjsVtqRXuzqbWH+wFyDCZbcsA0EmIiR68G2EGTfgL7S1x3hcYWgHq8j
         to2Q==
X-Gm-Message-State: APjAAAWmgDwF4pmUNn/3CY85xkFUVXYJMlqzaQM63X5z+qzIG1WJTo1R
        QHzx8XipUrms6b9O66N7wp9RBLDLnMoxyykntccQebwE
X-Google-Smtp-Source: APXvYqyOirlLY6jL3gsrbs2t8Mnyu1eLSteNFlFjLUnfILt6FDPS3g+bKQZTIfiRfJuoYjhJpCaVQ76UFN0hr6Q3krE=
X-Received: by 2002:a02:b78a:: with SMTP id f10mr138565005jam.5.1564687120011;
 Thu, 01 Aug 2019 12:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-10-deepa.kernel@gmail.com>
 <20190731152609.GB7077@magnolia>
In-Reply-To: <20190731152609.GB7077@magnolia>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 1 Aug 2019 12:18:28 -0700
Message-ID: <CABeXuvpiom9eQi0y7PAwAypUP1ezKKRfbh-Yqr8+Sbio=QtUJQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] ext4: Initialize timestamps limits
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 8:26 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, Jul 29, 2019 at 06:49:13PM -0700, Deepa Dinamani wrote:
> > ext4 has different overflow limits for max filesystem
> > timestamps based on the extra bytes available.
> >
> > The timestamp limits are calculated according to the
> > encoding table in
> > a4dad1ae24f85i(ext4: Fix handling of extended tv_sec):
> >
> > * extra  msb of                         adjust for signed
> > * epoch  32-bit                         32-bit tv_sec to
> > * bits   time    decoded 64-bit tv_sec  64-bit tv_sec      valid time range
> > * 0 0    1    -0x80000000..-0x00000001  0x000000000   1901-12-13..1969-12-31
> > * 0 0    0    0x000000000..0x07fffffff  0x000000000   1970-01-01..2038-01-19
> > * 0 1    1    0x080000000..0x0ffffffff  0x100000000   2038-01-19..2106-02-07
> > * 0 1    0    0x100000000..0x17fffffff  0x100000000   2106-02-07..2174-02-25
> > * 1 0    1    0x180000000..0x1ffffffff  0x200000000   2174-02-25..2242-03-16
> > * 1 0    0    0x200000000..0x27fffffff  0x200000000   2242-03-16..2310-04-04
> > * 1 1    1    0x280000000..0x2ffffffff  0x300000000   2310-04-04..2378-04-22
> > * 1 1    0    0x300000000..0x37fffffff  0x300000000   2378-04-22..2446-05-10
>
> My recollection of ext4 has gotten rusty, so this could be a bogus
> question:
>
> Say you have a filesystem with s_inode_size > 128 where not all of the
> ondisk inodes have been upgraded to i_extra_isize > 0 and therefore
> don't support nanoseconds or times beyond 2038.  I think this happens on
> ext3 filesystems that reserved extra space for inode attrs that are
> subsequently converted to ext4?
>
> In any case, that means that you have some inodes that support 34-bit
> tv_sec and some inodes that only support 32-bit tv_sec.  For the inodes
> with 32-bit tv_sec, I think all that happens is that a large timestamp
> will be truncated further, right?
>
> And no mount time warning because at least /some/ of the inodes are
> ready to go for the next 30 years?

I'm confused about ext3 being converted to ext4. If the converted
inodes have extra space, then ext4_iget() will start using the extra
space when it modifies the on disk inode, won't it?

But, if there are 32 bit tv_sec and 34 bit tv_sec in a superblock then
from this macro below, if an inode has space for extra bits in
timestamps, it uses it. Otherwise, only the first 32 bits are copied
to the on disk timestamp. This matches the behavior today for 32 bit
tv_sec. But, the 34 bit tv_sec has a better behavior after the series
because of the clamping and warning.

#define EXT4_INODE_SET_XTIME(xtime, inode, raw_inode)                \
do {                                        \
    (raw_inode)->xtime = cpu_to_le32((inode)->xtime.tv_sec);        \
    if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra))     {\
        (raw_inode)->xtime ## _extra =                    \
                ext4_encode_extra_time(&(inode)->xtime);    \
        }                                \
} while (0)

I'm not sure if this corner case if important. Maybe the maintainers
can help me here. If this is important, then the inode time updates
for an ext4 inode should always be through ext4_setattr() and we can
clamp the timestamps there as a special case. And, this patch can be
added separately?

Thanks,
Deepa
