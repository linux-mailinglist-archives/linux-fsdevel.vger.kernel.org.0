Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A96B349D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCJDQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJDQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:16:20 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809ABF2F90;
        Thu,  9 Mar 2023 19:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11AJMu/0cs/HvqxMiNs1sKMgouvxxTSuRzL9iqx/214=; b=b3pgLg2BGWVTYim4F7KQAXgPuh
        tvBvaspI+ZuT6n1dLXX0xe2CfyfmScno/rVPwocMA8nAysYzCglC41V3TUPJUjcvIvMYWMgbcWsqA
        mNb7CSDVKPDqEj9FhBJ3BlqtTv2rfZ3lApjmVElaxCebclvKldUPhAJs11i/u4Rq7Yp36tiJrOEj4
        Md5bov/9vJTU9iQSlhFi31jlZEUol6H70DxfbHVTEk7oeZGF6OI/AiRPNpvQTL4/P+kXsBTDJm/bm
        ojuazI9oWqv2bmVjTzwhBLB9gBk6dOhlqYyB/hAillxfNGe/u82JeojkeXAlQWl4Eq3y/so5OQ8Wj
        4Bsb00ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1paTER-00FCSC-2a;
        Fri, 10 Mar 2023 03:15:47 +0000
Date:   Fri, 10 Mar 2023 03:15:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] erofs: convert to use i_blockmask()
Message-ID: <20230310031547.GD3390869@ZenIV>
References: <20230309152127.41427-1-frank.li@vivo.com>
 <20230309152127.41427-2-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309152127.41427-2-frank.li@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:21:23PM +0800, Yangtao Li wrote:
> Use i_blockmask() to simplify code.

Umm...  What's the branchpoint for that series?  Not the mainline -
there we have i_blocksize() open-coded...

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v3:
> -none
> v2:
> -convert to i_blockmask()
>  fs/erofs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 7e8baf56faa5..e9d1869cd4b3 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		if (bdev)
>  			blksize_mask = bdev_logical_block_size(bdev) - 1;
>  		else
> -			blksize_mask = i_blocksize(inode) - 1;
> +			blksize_mask = i_blockmask(inode);
>  
>  		if ((iocb->ki_pos | iov_iter_count(to) |
>  		     iov_iter_alignment(to)) & blksize_mask)
> -- 
> 2.25.1
> 
