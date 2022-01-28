Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723BE49F591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiA1IsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 03:48:18 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48743 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240484AbiA1IsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:48:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0V31Qcf-_1643359694;
Received: from 30.240.99.245(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V31Qcf-_1643359694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Jan 2022 16:48:15 +0800
Message-ID: <16ac38b7-6a3a-9f18-b8fa-ca3bfe053504@linux.alibaba.com>
Date:   Fri, 28 Jan 2022 16:48:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] fs: remove duplicate permission checks in do_sendfile()
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130080218.22517-1-tianjia.zhang@linux.alibaba.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20211130080218.22517-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping.

Thanks.

On 11/30/21 4:02 PM, Tianjia Zhang wrote:
> The permission check for out.file is mainly performed in the function
> rw_verify_area(), and this check is called twice in the function
> do_splice_direct() and before calling do_splice_direct(). This is a
> redundant check and it is necessary to remove.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   fs/read_write.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0074afa7ecb3..bc7c3fcc3400 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1238,9 +1238,6 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>   #endif
>   	opipe = get_pipe_info(out.file, true);
>   	if (!opipe) {
> -		retval = rw_verify_area(WRITE, out.file, &out_pos, count);
> -		if (retval < 0)
> -			goto fput_out;
>   		file_start_write(out.file);
>   		retval = do_splice_direct(in.file, &pos, out.file, &out_pos,
>   					  count, fl);
