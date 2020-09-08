Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193BE2610B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgIHLbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 07:31:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgIHLbM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:31:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CD6DAB0E;
        Tue,  8 Sep 2020 11:31:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 492231E1325; Tue,  8 Sep 2020 13:31:10 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:31:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: adjust dirtytime_interval_handler definition to
 match prototype
Message-ID: <20200908113110.GB2956@quack2.suse.cz>
References: <20200907093140.13434-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907093140.13434-1-tklauser@distanz.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-09-20 11:31:40, Tobias Klauser wrote:
> Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> changed ctl_table.proc_handler to take a kernel pointer. Adjust the
> definition of dirtytime_interval_handler to match its prototype in
> linux/writeback.h which fixes the following sparse error/warning:
> 
> fs/fs-writeback.c:2189:50: warning: incorrect type in argument 3 (different address spaces)
> fs/fs-writeback.c:2189:50:    expected void *
> fs/fs-writeback.c:2189:50:    got void [noderef] __user *buffer
> fs/fs-writeback.c:2184:5: error: symbol 'dirtytime_interval_handler' redeclared with different type (incompatible argument 3 (different address spaces)):
> fs/fs-writeback.c:2184:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )
> fs/fs-writeback.c: note: in included file:
> ./include/linux/writeback.h:374:5: note: previously declared as:
> ./include/linux/writeback.h:374:5:    int extern [addressable] [signed] [toplevel] dirtytime_interval_handler( ... )
> 
> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 149227160ff0..58b27e4070a3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2184,7 +2184,7 @@ static int __init start_dirtytime_writeback(void)
>  __initcall(start_dirtytime_writeback);
>  
>  int dirtytime_interval_handler(struct ctl_table *table, int write,
> -			       void __user *buffer, size_t *lenp, loff_t *ppos)
> +			       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int ret;
>  
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
