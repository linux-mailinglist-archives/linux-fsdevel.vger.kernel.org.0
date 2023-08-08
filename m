Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA8773597
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 02:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjHHAyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 20:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjHHAyr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:54:47 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2777FE9;
        Mon,  7 Aug 2023 17:54:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VpIkifi_1691456082;
Received: from 30.221.128.117(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VpIkifi_1691456082)
          by smtp.aliyun-inc.com;
          Tue, 08 Aug 2023 08:54:43 +0800
Message-ID: <259ff3c4-4d9c-aaf4-c7be-205615c00125@linux.alibaba.com>
Date:   Tue, 8 Aug 2023 08:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/4] ocfs2: stop using bdev->bd_super for journal error
 logging
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, linux-block@vger.kernel.org
References: <20230807112625.652089-1-hch@lst.de>
 <20230807112625.652089-4-hch@lst.de>
Content-Language: en-US
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20230807112625.652089-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/7/23 7:26 PM, Christoph Hellwig wrote:
> All ocfs2 journal error handling and logging is based on buffer_heads,
> and the owning inode and thus super_block can be retrieved through
> bh->b_assoc_map->host.  Switch to using that to remove the last users
> of bdev->bd_super.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks fine.
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/journal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 25d8072ccfce46..c19c730c26e270 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -557,7 +557,7 @@ static void ocfs2_abort_trigger(struct jbd2_buffer_trigger_type *triggers,
>  	     (unsigned long)bh,
>  	     (unsigned long long)bh->b_blocknr);
>  
> -	ocfs2_error(bh->b_bdev->bd_super,
> +	ocfs2_error(bh->b_assoc_map->host->i_sb,
>  		    "JBD2 has aborted our journal, ocfs2 cannot continue\n");
>  }
>  
> @@ -780,14 +780,14 @@ void ocfs2_journal_dirty(handle_t *handle, struct buffer_head *bh)
>  		mlog_errno(status);
>  		if (!is_handle_aborted(handle)) {
>  			journal_t *journal = handle->h_transaction->t_journal;
> -			struct super_block *sb = bh->b_bdev->bd_super;
>  
>  			mlog(ML_ERROR, "jbd2_journal_dirty_metadata failed. "
>  					"Aborting transaction and journal.\n");
>  			handle->h_err = status;
>  			jbd2_journal_abort_handle(handle);
>  			jbd2_journal_abort(journal, status);
> -			ocfs2_abort(sb, "Journal already aborted.\n");
> +			ocfs2_abort(bh->b_assoc_map->host->i_sb,
> +				    "Journal already aborted.\n");
>  		}
>  	}
>  }
