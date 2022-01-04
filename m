Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F134843FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiADO66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 09:58:58 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:52494 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbiADO66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:58:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V0z5cF9_1641308333;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V0z5cF9_1641308333)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 22:58:55 +0800
Date:   Tue, 4 Jan 2022 22:58:53 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/23] erofs: add nodev mode
Message-ID: <YdRgrWEDU8sJVExX@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
 <20211227125444.21187-8-jefflexu@linux.alibaba.com>
 <YdRattisu+ITYvvZ@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdRattisu+ITYvvZ@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:33:26PM +0800, Gao Xiang wrote:
> On Mon, Dec 27, 2021 at 08:54:28PM +0800, Jeffle Xu wrote:
> > Until then erofs is exactly blockdev based filesystem. In other using
> > scenarios (e.g. container image), erofs needs to run upon files.
> > 
> > This patch introduces a new nodev mode, in which erofs could be mounted
> > from a bootstrap blob file containing the complete erofs image.
> > 
> > The following patch will introduce a new mount option "uuid", by which
> > users could specify the bootstrap blob file.
> > 
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> I think the order of some patches in this patchset can be improved.
> 
> Take this patch as an example. This patch introduces a new mount
> option called "uuid", so the kernel will just accept it (which
> generates a user-visible impact) after this patch but it doesn't
> actually work.
> 
> Therefore, we actually have three different behaviors here:
>  - kernel doesn't support "uuid" mount option completely;
>  - kernel support "uuid" but it doesn't work;
>  - kernel support "uuid" correctly (maybe after some random patch);
> 
> Actually that is bad for bisecting since there are some commits
> having temporary behaviors. And we don't know which commit
> actually fully implements this "uuid" mount option.
> 
> So personally I think the proper order is just like the bottom-up
> approach, and make sure each patch can be tested / bisected
> independently.

Oh, I may misread this patch, but I still think we'd better to
avoid dead paths "TODO" like this as much as possible.

Just do in the bottom-up way.

Thanks,
Gao Xiang
