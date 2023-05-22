Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6300270B350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEVCtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVCtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:49:40 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58549C1;
        Sun, 21 May 2023 19:49:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vj6edsh_1684723770;
Received: from 30.221.132.35(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Vj6edsh_1684723770)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 10:49:31 +0800
Message-ID: <376ab23b-52d0-d7fd-2dd9-414cbb474e01@linux.alibaba.com>
Date:   Mon, 22 May 2023 10:49:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v21 22/30] ocfs2: Provide a splice-read stub
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
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
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-23-dhowells@redhat.com>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230520000049.2226926-23-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/20/23 8:00 AM, David Howells wrote:
> Provide a splice_read stub for ocfs2.  This emits trace lines and does an
> atime lock/update before calling filemap_splice_read().  Splicing from
> direct I/O is handled by the caller.
> 
> A couple of new tracepoints are added for this purpose.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Mark Fasheh <mark@fasheh.com>
> cc: Joel Becker <jlbec@evilplan.org>
> cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> cc: ocfs2-devel@oss.oracle.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/ocfs2/file.c        | 39 ++++++++++++++++++++++++++++++++++++++-
>  fs/ocfs2/ocfs2_trace.h |  3 +++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> index efb09de4343d..f7e00b5689d5 100644
> --- a/fs/ocfs2/file.c
> +++ b/fs/ocfs2/file.c
> @@ -2581,6 +2581,43 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
>  	return ret;
>  }
>  
> +static ssize_t ocfs2_file_splice_read(struct file *in, loff_t *ppos,
> +				      struct pipe_inode_info *pipe,
> +				      size_t len, unsigned int flags)
> +{
> +	struct inode *inode = file_inode(in);
> +	ssize_t ret = 0;
> +	int lock_level = 0;
> +
> +	trace_ocfs2_file_splice_read(inode, in, in->f_path.dentry,
> +				     (unsigned long long)OCFS2_I(inode)->ip_blkno,
> +				     in->f_path.dentry->d_name.len,
> +				     in->f_path.dentry->d_name.name,
> +				     0);

Better also trace flags here.

> +
> +	/*
> +	 * We're fine letting folks race truncates and extending writes with
> +	 * read across the cluster, just like they can locally.  Hence no
> +	 * rw_lock during read.
> +	 *
> +	 * Take and drop the meta data lock to update inode fields like i_size.
> +	 * This allows the checks down below generic_file_splice_read() a

Now it calls filemap_splice_read().

> +	 * chance of actually working.
> +	 */
> +	ret = ocfs2_inode_lock_atime(inode, in->f_path.mnt, &lock_level, true);

Since prototype is 'int wait', so directly passing '1' seems more appropriate.

> +	if (ret < 0) {
> +		if (ret != -EAGAIN)
> +			mlog_errno(ret);
> +		goto bail;
> +	}
> +	ocfs2_inode_unlock(inode, lock_level);
> +

Don't see direct IO logic now. Am I missing something?

Thanks,
Joseph

> +	ret = filemap_splice_read(in, ppos, pipe, len, flags);
> +	trace_filemap_splice_read_ret(ret);
> +bail:
> +	return ret;
> +}
> +
>  /* Refer generic_file_llseek_unlocked() */
>  static loff_t ocfs2_file_llseek(struct file *file, loff_t offset, int whence)
>  {
> @@ -2744,7 +2781,7 @@ const struct file_operations ocfs2_fops = {
>  #endif
>  	.lock		= ocfs2_lock,
>  	.flock		= ocfs2_flock,
> -	.splice_read	= generic_file_splice_read,
> +	.splice_read	= ocfs2_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.fallocate	= ocfs2_fallocate,
>  	.remap_file_range = ocfs2_remap_file_range,
> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> index dc4bce1649c1..b8c3d1702076 100644
> --- a/fs/ocfs2/ocfs2_trace.h
> +++ b/fs/ocfs2/ocfs2_trace.h
> @@ -1319,6 +1319,8 @@ DEFINE_OCFS2_FILE_OPS(ocfs2_file_splice_write);
>  
>  DEFINE_OCFS2_FILE_OPS(ocfs2_file_read_iter);
>  
> +DEFINE_OCFS2_FILE_OPS(ocfs2_file_splice_read);
> +
>  DEFINE_OCFS2_ULL_ULL_ULL_EVENT(ocfs2_truncate_file);
>  
>  DEFINE_OCFS2_ULL_ULL_EVENT(ocfs2_truncate_file_error);
> @@ -1470,6 +1472,7 @@ TRACE_EVENT(ocfs2_prepare_inode_for_write,
>  );
>  
>  DEFINE_OCFS2_INT_EVENT(generic_file_read_iter_ret);
> +DEFINE_OCFS2_INT_EVENT(filemap_splice_read_ret);
>  
>  /* End of trace events for fs/ocfs2/file.c. */
>  
