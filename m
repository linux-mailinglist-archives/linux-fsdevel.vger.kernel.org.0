Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2E62964B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiKOKvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 05:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiKOKu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:50:57 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB0233AC;
        Tue, 15 Nov 2022 02:50:38 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VUtE0x-_1668509434;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUtE0x-_1668509434)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 18:50:36 +0800
Date:   Tue, 15 Nov 2022 18:50:33 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Message-ID: <Y3Nu+TNRp6Fv3L19@B-P7TQMD6M-0146.local>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>
References: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
 <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <917344b4-4256-6d77-b89b-07fa96ec4539@siddh.me>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:39:38PM +0530, Siddh Raman Pant via Linux-erofs wrote:
> On Tue, 15 Nov 2022 08:54:47 +0530, Gao Xiang wrote:
> > I just wonder if we should return -EINVAL for post-EOF cases or
> > IOMAP_HOLE with arbitrary length?
> 
> Since it has been observed that length can be zeroed, and we
> must stop, I think we should return an error appropriately.
> 
> For a read-only filesystem, we probably don't really need to
> care what's after the EOF or in unmapped regions, nothing can
> be changed/extended. The definition of IOMAP_HOLE in iomap.h
> says it stands for "no blocks allocated, need allocation".

For fiemap implementation, yes.  So it looks fine to me.

Let's see what other people think.  Anyway, I'd like to apply it later.

Thanks,
Gao Xiang

> 
> Alternatively, we can return error iff the length of the
> extent with holes is zero, like here.
> 
> Thanks,
> Siddh
