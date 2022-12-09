Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA37647D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLIEvD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 23:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIEvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 23:51:02 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE81B1F3;
        Thu,  8 Dec 2022 20:50:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=0;PH=DS;RN=5;SR=0;TI=SMTPD_---0VWt-q52_1670561448;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VWt-q52_1670561448)
          by smtp.aliyun-inc.com;
          Fri, 09 Dec 2022 12:50:51 +0800
Date:   Fri, 9 Dec 2022 12:50:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Siddh Raman Pant <code@siddh.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Message-ID: <Y5K+p6td52QppRZt@B-P7TQMD6M-0146.local>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
 <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
 <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Siddh,

On Tue, Nov 15, 2022 at 06:50:33PM +0800, Gao Xiang wrote:
> On Tue, Nov 15, 2022 at 03:39:38PM +0530, Siddh Raman Pant via Linux-erofs wrote:
> > On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
> > > I just wonder if we should return -EINVAL for post-EOF cases or
> > > IOMAP_HOLE with arbitrary length?
> > 
> > Since it has been observed that length can be zeroed, and we
> > must stop, I think we should return an error appropriately.
> > 
> > For a read-only filesystem, we probably don't really need to
> > care what's after the EOF or in unmapped regions, nothing can
> > be changed/extended. The definition of IOMAP_HOLE in iomap.h
> > says it stands for "no blocks allocated, need allocation".
> 
> For fiemap implementation, yes.  So it looks fine to me.
> 
> Let's see what other people think.  Anyway, I'd like to apply it later.
>

Very sorry for late response.

I've just confirmed that the reason is that

796                 /*
797                  * No strict rule how to describe extents for post EOF, yet
798                  * we need do like below. Otherwise, iomap itself will get
799                  * into an endless loop on post EOF.
800                  */
801                 if (iomap->offset >= inode->i_size)
802                         iomap->length = length + map.m_la - offset;

Here iomap->length should be length + offset - map.m_la here. Because
the extent start (map.m_la) is always no more than requested `offset'.

We should need this code sub-block since userspace (filefrag -v) could
pass
ioctl(3, FS_IOC_FIEMAP, {fm_start=0, fm_length=18446744073709551615, fm_flags=0, fm_extent_count=292} => {fm_flags=0, fm_mapped_extents=68, ...}) = 0

without this sub-block, fiemap could get into a very long loop as below:
[  574.030856][ T7030] erofs: m_la 70000000 offset 70457397 length 9223372036784318410 m_llen 457398
[  574.031622][ T7030] erofs: m_la 70000000 offset 70457398 length 9223372036784318409 m_llen 457399
[  574.032397][ T7030] erofs: m_la 70000000 offset 70457399 length 9223372036784318408 m_llen 457400

So could you fix this as?
	iomap->length = length + offset - map.m_la;

I've already verified it can properly resolve the issue and do the
correct thing although I'd like to submit this later since we're quite
close to the merge window.

Thanks,
Gao Xiang
