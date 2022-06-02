Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFB53BE09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 20:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiFBSXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiFBSXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:23:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE4DF15;
        Thu,  2 Jun 2022 11:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C91BB81F9A;
        Thu,  2 Jun 2022 18:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821D8C385A5;
        Thu,  2 Jun 2022 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654194169;
        bh=yLIgRtsAt61/ViRtkwjVef0xtUPPspKdkzpb2tdOEVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GjA7Ik2eCW0cWALGPFnWPlXPFx2lTWwc2ejH6HhltRQRy/wxigYzjNTQ7orB7IlJn
         cC/CKCQeYm0lujlBzZ+B3gOsq3LxzRAdFVp1JIaOuDyxoOVErbfy5HM3sQkv6FIn/d
         gUm7PXybxWns81FWxECQjAL/Fpr9rVJ9C87hWvJ4=
Date:   Thu, 2 Jun 2022 11:22:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     <willy@infradead.org>, <kent.overstreet@gmail.com>,
        <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
Subject: Re: [PATCH -next] mm/filemap: fix that first page is not mark
 accessed in filemap_read()
Message-Id: <20220602112248.1e3cd871a87fe9df1ca13f08@linux-foundation.org>
In-Reply-To: <20220602082129.2805890-1-yukuai3@huawei.com>
References: <20220602082129.2805890-1-yukuai3@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2 Jun 2022 16:21:29 +0800 Yu Kuai <yukuai3@huawei.com> wrote:

> In filemap_read(), 'ra->prev_pos' is set to 'iocb->ki_pos + copied',
> while it should be 'iocb->ki_ops'. For consequence,
> folio_mark_accessed() will not be called for 'fbatch.folios[0]' since
> 'iocb->ki_pos' is always equal to 'ra->prev_pos'.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2728,10 +2728,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  				flush_dcache_folio(folio);
>  
>  			copied = copy_folio_to_iter(folio, offset, bytes, iter);
> -
> -			already_read += copied;
> -			iocb->ki_pos += copied;
> -			ra->prev_pos = iocb->ki_pos;
> +			if (copied) {
> +				ra->prev_pos = iocb->ki_pos;
> +				already_read += copied;
> +				iocb->ki_pos += copied;
> +			}
>  
>  			if (copied < bytes) {
>  				error = -EFAULT;

It seems tidier, but does it matter?  If copied==0 we're going to break
out and return -EFAULT anyway?
