Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502716FA2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGVHSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 03:18:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:59268 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVHSw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:18:52 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hpSav-0000Fm-TZ; Mon, 22 Jul 2019 10:18:50 +0300
Subject: Re: [PATCH] fuse: cleanup fuse_wait_on_page_writeback
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
References: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <d8ebd68d-684b-ab32-fcc9-2eaaf894c252@virtuozzo.com>
Date:   Mon, 22 Jul 2019 10:18:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I forget to add this patch was used in OpenVZ kernels last few years.

On 7/22/19 10:17 AM, Vasily Averin wrote:
> From: Maxim Patlasov <mpatlasov@virtuozzo.com>
> fuse_wait_on_page_writeback() always returns zero and nobody cares.
> Let's make it void.
> 
> Signed-off-by: Maxim Patlasov <mpatlasov@virtuozzo.com>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/fuse/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5ae2828beb00..e076c2cf65b0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -383,12 +383,11 @@ static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t index)
>   * Since fuse doesn't rely on the VM writeback tracking, this has to
>   * use some other means.
>   */
> -static int fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
> +static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
> -	return 0;
>  }
>  
>  /*
> 
