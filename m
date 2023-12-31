Return-Path: <linux-fsdevel+bounces-7043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB7820976
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 02:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F261C21CDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 01:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FD5A41;
	Sun, 31 Dec 2023 01:14:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B572659;
	Sun, 31 Dec 2023 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VzViQy2_1703985251;
Received: from 192.168.70.84(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzViQy2_1703985251)
          by smtp.aliyun-inc.com;
          Sun, 31 Dec 2023 09:14:12 +0800
Message-ID: <8f0dd1ed-8849-46ef-af2a-4baf4dc91422@linux.alibaba.com>
Date: Sun, 31 Dec 2023 09:14:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 xiang@kernel.org
References: <000000000000321c24060d7cfa1c@google.com>
 <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/29 19:09, Edward Adam Davis wrote:
> When LZ4 decompression fails, the number of bytes read from out should be
> inputsize plus the returned overflow value ret.
> 
> Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/erofs/decompressor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 021be5feb1bc..8ac3f96676c4 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
>   		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
>   			       16, 1, src + inputmargin, rq->inputsize, true);
>   		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
> -			       16, 1, out, rq->outputsize, true);
> +			       16, 1, out, (ret < 0 && rq->inputsize > 0) ?
> +			       (ret + rq->inputsize) : rq->outputsize, true);

It's incorrect since output decompressed buffer has no relationship
with `rq->inputsize` and `ret + rq->inputsize` is meaningless too.

Also, the issue was already fixed by avoiding debugging messages as
https://lore.kernel.org/r/20231227151903.2900413-1-hsiangkao@linux.alibaba.com

Thanks,
Gao Xiang

