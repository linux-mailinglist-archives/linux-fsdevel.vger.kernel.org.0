Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CA925D2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgIDHr4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:47:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDHr4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:47:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45AA9ACC8;
        Fri,  4 Sep 2020 07:47:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EE1D41E12D1; Fri,  4 Sep 2020 09:47:54 +0200 (CEST)
Date:   Fri, 4 Sep 2020 09:47:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] direct-io: clean up error paths of
 do_blockdev_direct_IO
Message-ID: <20200904074754.GA2867@quack2.suse.cz>
References: <20200903200414.673105-1-krisman@collabora.com>
 <20200903200414.673105-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903200414.673105-2-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-09-20 16:04:12, Gabriel Krisman Bertazi wrote:
> In preparation to resort DIO checks, reduce code duplication of error
> handling in do_blockdev_direct_IO.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Two comments below:

> @@ -1368,7 +1360,15 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	} else
>  		BUG_ON(retval != -EIOCBQUEUED);
>  
> -out:
> +	return retval;
> +
> +fail_dio:
> +	if (dio->flags & DIO_LOCKING) {
> +		inode_unlock(inode);
> +	}

No need for braces here. Also please add '&& iov_iter_rw(iter) == READ' to
the condition for unlocking to make fail_dio safe also for writes.
Currently you jump to fail_dio only for reads but in 3/3 you can jump to it
also for writes and that is a bug.

								Honza

> +fail_dio_unlocked:
> +	kmem_cache_free(dio_cache, dio);
> +
>  	return retval;
>  }
>  
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
