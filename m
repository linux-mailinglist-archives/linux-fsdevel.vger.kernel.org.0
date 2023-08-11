Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D10778950
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjHKI4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjHKI4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:56:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605CAE75
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 01:56:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC1321F88C;
        Fri, 11 Aug 2023 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691744192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fhVb2cx4yzEnYTf9Ohkg8zDjKEMQKhFBxXUAKKq+aU=;
        b=JqNe/CyvlBtYjWqcGYTzITpkCs70XnLANK/XkJmPg5d2LGH6HCj8GvH1NZfz/ZSiBNlRbH
        I1SzawXs7wWw1khy+iUiHupqQm7S+WrXrl4VryxO6JPLXILsLRcwYNRnAr1G6R/+5gOuDx
        2zTvkDG4K+BejSKRnWv/EfC3MNGezH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691744192;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6fhVb2cx4yzEnYTf9Ohkg8zDjKEMQKhFBxXUAKKq+aU=;
        b=Tfu7sJUr1Wyc5JsibINKkP1kVCyWdQqypjPKx3qo3ydW4k8rC0Y7pHtBubF5Yjhgjv+F8k
        2ntel4Q+Lw/UtfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA8F113592;
        Fri, 11 Aug 2023 08:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6xhcMcD31WQMDgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 08:56:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4FA1DA076F; Fri, 11 Aug 2023 10:56:32 +0200 (CEST)
Date:   Fri, 11 Aug 2023 10:56:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        Carlos Maiolino <cem@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>, Daniel Xu <dxu@dxuuu.xyz>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        Yu Kuai <yukuai3@huawei.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs v2 4/5] tmpfs: trivial support for direct IO
Message-ID: <20230811085632.hfmdzni2yzgmcy44@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <7c12819-9b94-d56-ff88-35623aa34180@google.com>
 <6f2742-6f1f-cae9-7c5b-ed20fc53215@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2742-6f1f-cae9-7c5b-ed20fc53215@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-08-23 23:27:07, Hugh Dickins wrote:
> Depending upon your philosophical viewpoint, either tmpfs always does
> direct IO, or it cannot ever do direct IO; but whichever, if tmpfs is to
> stand in for a more sophisticated filesystem, it can be helpful for tmpfs
> to support O_DIRECT.  So, give tmpfs a shmem_file_open() method, to set
> the FMODE_CAN_ODIRECT flag: then unchanged shmem_file_read_iter() and new
> shmem_file_write_iter() do the work (without any shmem_direct_IO() stub).
> 
> Perhaps later, once the direct_IO method has been eliminated from all
> filesystems, generic_file_write_iter() will be such that tmpfs can again
> use it, even for O_DIRECT.
> 
> xfstests auto generic which were not run on tmpfs before but now pass:
> 036 091 113 125 130 133 135 198 207 208 209 210 211 212 214 226 239 263
> 323 355 391 406 412 422 427 446 451 465 551 586 591 609 615 647 708 729
> with no new failures.
> 
> LTP dio tests which were not run on tmpfs before but now pass:
> dio01 through dio30, except for dio04 and dio10, which fail because
> tmpfs dio read and write allow odd count: tmpfs could be made stricter,
> but would that be an improvement?
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Thanks for your earlier review, Jan: I've certainly not copied that
> into this entirely different version.  I prefer the v1, but fine if
> people prefer this v2.

Yeah, this solution is also fine with me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I agree the previous version has less code duplication but once .direct_IO
is gone shmem_file_write_iter() will be actually how some generic helper
will look like so we can deduplicate the code then.

								Honza
 
>  mm/shmem.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ca43fb256b8e..b782edeb69aa 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2388,6 +2388,12 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> +static int shmem_file_open(struct inode *inode, struct file *file)
> +{
> +	file->f_mode |= FMODE_CAN_ODIRECT;
> +	return generic_file_open(inode, file);
> +}
> +
>  #ifdef CONFIG_TMPFS_XATTR
>  static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
>  
> @@ -2839,6 +2845,28 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return retval ? retval : error;
>  }
>  
> +static ssize_t shmem_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct inode *inode = file->f_mapping->host;
> +	ssize_t ret;
> +
> +	inode_lock(inode);
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto unlock;
> +	ret = file_remove_privs(file);
> +	if (ret)
> +		goto unlock;
> +	ret = file_update_time(file);
> +	if (ret)
> +		goto unlock;
> +	ret = generic_perform_write(iocb, from);
> +unlock:
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
>  static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
>  			      struct pipe_buffer *buf)
>  {
> @@ -4434,12 +4462,12 @@ EXPORT_SYMBOL(shmem_aops);
>  
>  static const struct file_operations shmem_file_operations = {
>  	.mmap		= shmem_mmap,
> -	.open		= generic_file_open,
> +	.open		= shmem_file_open,
>  	.get_unmapped_area = shmem_get_unmapped_area,
>  #ifdef CONFIG_TMPFS
>  	.llseek		= shmem_file_llseek,
>  	.read_iter	= shmem_file_read_iter,
> -	.write_iter	= generic_file_write_iter,
> +	.write_iter	= shmem_file_write_iter,
>  	.fsync		= noop_fsync,
>  	.splice_read	= shmem_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
> -- 
> 2.35.3
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
