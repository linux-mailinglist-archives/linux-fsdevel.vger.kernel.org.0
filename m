Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEB6290C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 04:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiKODZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 22:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiKODZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:25:00 -0500
Received: from out199-7.us.a.mail.aliyun.com (out199-7.us.a.mail.aliyun.com [47.90.199.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39CDAE5F;
        Mon, 14 Nov 2022 19:24:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUrQ.jq_1668482688;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VUrQ.jq_1668482688)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 11:24:49 +0800
Date:   Tue, 15 Nov 2022 11:24:47 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] erofs/zmap.c: Bail out when no further region remains
Message-ID: <Y3MGf3TzgKpAz4IP@B-P7TQMD6M-0146.local>
Mail-Followup-To: Siddh Raman Pant <code@siddh.me>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20221114120349.472418-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114120349.472418-1-code@siddh.me>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:33:49PM +0530, Siddh Raman Pant wrote:
> The following calculation of iomap->length on line 798 in
> z_erofs_iomap_begin_report() can yield 0:
> 	if (iomap->offset >= inode->i_size)
> 		iomap->length = length + map.m_la - offset;
> 
> This triggers a WARN_ON in iomap_iter_done() (see line 34 of
> fs/iomap/iter.c).
> 
> Hence, return error when this scenario is encountered.
> 
> ============================================================
> 
> This was reported as a crash by syzbot under an issue about
> warning encountered in iomap_iter_done(), but unrelated to
> erofs. Hence, not adding issue hash in Reported-by line.
> 
> C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
> Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
> Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6
> 
> Reported-by: syzbot@syzkaller.appspotmail.com
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  fs/erofs/zmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 0bb66927e3d0..bad852983eb9 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -796,6 +796,9 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
>  		 */
>  		if (iomap->offset >= inode->i_size)
>  			iomap->length = length + map.m_la - offset;
> +
> +		if (iomap->length == 0)

I just wonder if we should return -EINVAL for post-EOF cases or
IOMAP_HOLE with arbitrary length?

Thanks,
Gao Xiang

> +			return -EINVAL;
>  	}
>  	iomap->flags = 0;
>  	return 0;
> -- 
> 2.35.1
> 
