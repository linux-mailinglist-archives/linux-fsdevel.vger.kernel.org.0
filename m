Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA7A70B586
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjEVG5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjEVG5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:57:21 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806CB1;
        Sun, 21 May 2023 23:55:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vj99.vZ_1684738493;
Received: from 30.221.132.35(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vj99.vZ_1684738493)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 14:54:55 +0800
Message-ID: <9059d4e5-3813-b84c-b0d6-ecfd9a1c5570@linux.alibaba.com>
Date:   Mon, 22 May 2023 14:54:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
References: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
 <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-23-dhowells@redhat.com>
 <2414055.1684738198@warthog.procyon.org.uk>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <2414055.1684738198@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/22/23 2:49 PM, David Howells wrote:
> So something like the attached changes?  Any suggestions as to how to improve
> the comments?
> 

Looks fine to me now. Thanks.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> David
> ---
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index f7e00b5689d5..86add13b5f23 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2552,7 +2552,7 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
>  	 *
>  	 * Take and drop the meta data lock to update inode fields
>  	 * like i_size. This allows the checks down below
> -	 * generic_file_read_iter() a chance of actually working.
> +	 * copy_splice_read() a chance of actually working.
>  	 */
>  	ret = ocfs2_inode_lock_atime(inode, filp->f_path.mnt, &lock_level,
>  				     !nowait);
> @@ -2593,7 +2593,7 @@ static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
>  				     (unsigned long long)OCFS2_I(inode)->ip_blkno,
>  				     in->f_path.dentry->d_name.len,
>  				     in->f_path.dentry->d_name.name,
> -				     0);
> +				     flags);
>  
>  	/*
>  	 * We're fine letting folks race truncates and extending writes with
> @@ -2601,10 +2601,10 @@ static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
>  	 * rw_lock during read.
>  	 *
>  	 * Take and drop the meta data lock to update inode fields like i_size.
> -	 * This allows the checks down below generic_file_splice_read() a
> -	 * chance of actually working.
> +	 * This allows the checks down below filemap_splice_read() a chance of
> +	 * actually working.
>  	 */
> -	ret = ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, true);
> +	ret = ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, 1);
>  	if (ret < 0) {
>  		if (ret != -EAGAIN)
>  			mlog_errno(ret);
