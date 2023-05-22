Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E32070B244
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjEVABL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 20:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVABK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 20:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155429D;
        Sun, 21 May 2023 17:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9146961184;
        Mon, 22 May 2023 00:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC2DC433D2;
        Mon, 22 May 2023 00:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684713669;
        bh=LUd+HLV5GvAukIRTA3zMsj3Wi8CWTQ9goQe7KtJAgHQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kk4kRfPbbTACy3HBRfR53PIciolvFXLafPUIvBzIIaJxzfuC6EFAkT4x++AFsbuaE
         UuSH1ecPhhtlnjPxykbWpj2QhKYfH+I9/+UG/FpdlLCzA+Aybo3M/TZL7hKn1etep6
         bKTf8mIm/Bqm0iwPBwy/hKYaFXNL6MBg6quCgdeyCI3/SXXIM5E3+FEa8zKs9akvd2
         ADmTIg/oK5AjJlytXI1gq43N62j17HXU1JY9EejDLMDRl+7qeYgk7r/CP1e7BguG1a
         rzyFRiE4z9v686KnqK0luN21wPha2g4uGAQRJJwbeaMhiak/4HLQBy/5ShCOhAST67
         I9tsUEuuNKaUQ==
Message-ID: <5c66fe46-13eb-d9d2-e107-cc48eb50688f@kernel.org>
Date:   Mon, 22 May 2023 09:01:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/13] iomap: update ki_pos in iomap_file_buffered_write
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-8-hch@lst.de>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230519093521.133226-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/23 18:35, Christoph Hellwig wrote:
> All callers of iomap_file_buffered_write need to updated ki_pos, move it
> into common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One nit below.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 063133ec77f49e..550525a525c45c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -864,16 +864,19 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  		.len		= iov_iter_count(i),
>  		.flags		= IOMAP_WRITE,
>  	};
> -	int ret;
> +	ssize_t ret;
>  
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
>  
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_write_iter(&iter, i);
> -	if (iter.pos == iocb->ki_pos)
> +
> +	if (unlikely(ret < 0))

Nit: This could be if (unlikely(ret <= 0)), no ?

>  		return ret;
> -	return iter.pos - iocb->ki_pos;
> +	ret = iter.pos - iocb->ki_pos;
> +	iocb->ki_pos += ret;
> +	return ret;


-- 
Damien Le Moal
Western Digital Research

