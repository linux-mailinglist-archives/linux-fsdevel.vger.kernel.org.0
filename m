Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B12A6B3D6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 12:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCJLNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 06:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCJLNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:13:18 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A2C5B89;
        Fri, 10 Mar 2023 03:13:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VdX95E7_1678446789;
Received: from 30.221.128.251(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VdX95E7_1678446789)
          by smtp.aliyun-inc.com;
          Fri, 10 Mar 2023 19:13:10 +0800
Message-ID: <faca55dc-fe0d-9014-ede2-f55124cb4227@linux.alibaba.com>
Date:   Fri, 10 Mar 2023 19:13:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/5] ocfs2: convert to use i_blockmask()
To:     Yangtao Li <frank.li@vivo.com>, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org
References: <20230310054829.4241-1-frank.li@vivo.com>
 <20230310054829.4241-4-frank.li@vivo.com>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230310054829.4241-4-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/10/23 1:48 PM, Yangtao Li wrote:
> Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
> to return bool type and the fact that the value will be the same
> (i.e. that ->i_blkbits is never changed by ocfs2).
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/ocfs2/file.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..7fd06a4d27d4 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2159,14 +2159,9 @@ int ocfs2_check_range_for_refcount(struct inode *inode, loff_t pos,
>  	return ret;
>  }
>  
> -static int ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
> +static bool ocfs2_is_io_unaligned(struct inode *inode, size_t count, loff_t pos)
>  {
> -	int blockmask = inode->i_sb->s_blocksize - 1;
> -	loff_t final_size = pos + count;
> -
> -	if ((pos & blockmask) || (final_size & blockmask))
> -		return 1;
> -	return 0;
> +	return ((pos | count) & i_blockmask(inode)) != 0;

Or !!((pos | count) & i_blockmask(inode))?

My concern is just like erofs, we'd better get vfs helper into mainline
first. Or can we fold the whole series into one patch? Since it's simple
enough I think.

Thanks,
Joseph

>  }
>  
>  static int ocfs2_inode_lock_for_extent_tree(struct inode *inode,
