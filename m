Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFB782FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbjHUR5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjHUR5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:57:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884EE9
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 10:57:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B45711F459;
        Mon, 21 Aug 2023 17:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692640654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gCIG0JsVp3QHiEtAiEKjNvHMosM+Qxtt2B4cFNpJCOI=;
        b=GQZuukXeDNvRLCN8jLrQYJU2wQcy73fzQZ9trFI9HxSWJ39JQSkAOiUDqtYoHCfdDPSJqn
        OniSYqhVzxKXB1whQiMwjy8ggeHEXsSQVPaG/XZQd2n7+x0AUUVfcKGIcodEi711GDorBX
        uOUt1ttsDZEfmpq4ku+qHkO0o8RBrw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692640654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gCIG0JsVp3QHiEtAiEKjNvHMosM+Qxtt2B4cFNpJCOI=;
        b=zwrF1l6ogiNiyD/7aPbLiQbbMsQk7qeLDXDSnyOiihtb8yNHkh/AlinTUiVt2Wx4t0PIuu
        p5KlQvLx6+rYqPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E63B13421;
        Mon, 21 Aug 2023 17:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7XGqJo6l42QSYAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 21 Aug 2023 17:57:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12C63A0774; Mon, 21 Aug 2023 19:57:34 +0200 (CEST)
Date:   Mon, 21 Aug 2023 19:57:34 +0200
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
        Franklin Mathieu <snaipe@arista.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH vfs.tmpfs] tmpfs,xattr: GFP_KERNEL_ACCOUNT for simple
 xattrs
Message-ID: <20230821175734.hkgxg7xixilhgvzp@quack3>
References: <e92a4d33-f97-7c84-95ad-4fed8e84608c@google.com>
 <20230809-postkarten-zugute-3cde38456390@brauner>
 <20230809-leitgedanke-weltumsegelung-55042d9f7177@brauner>
 <cdedadf2-d199-1133-762f-a8fe166fb968@google.com>
 <20230810-notwehr-denkbar-3be0cc53a87a@brauner>
 <f6953e5a-4183-8314-38f2-40be60998615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6953e5a-4183-8314-38f2-40be60998615@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-08-23 10:39:20, Hugh Dickins wrote:
> It is particularly important for the userns mount case (when a sensible
> nr_inodes maximum may not be enforced) that tmpfs user xattrs be subject
> to memory cgroup limiting.  Leave temporary buffer allocations as is,
> but change the persistent simple xattr allocations from GFP_KERNEL to
> GFP_KERNEL_ACCOUNT.  This limits kernfs's cgroupfs too, but that's good.
> 
> (I had intended to send this change earlier, but had been confused by
> shmem_alloc_inode() using GFP_KERNEL, and thought a discussion would be
> needed to change that too: no, I was forgetting the SLAB_ACCOUNT on that
> kmem_cache, which implicitly adds __GFP_ACCOUNT to all its allocations.)
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

So I've checked and also kernfs is affected by these changes. I guess that
makes sense as well. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/xattr.c | 4 ++--
>  mm/shmem.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 2d607542281b..efd4736bc94b 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -1093,7 +1093,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
>  	if (len < sizeof(*new_xattr))
>  		return NULL;
>  
> -	new_xattr = kvmalloc(len, GFP_KERNEL);
> +	new_xattr = kvmalloc(len, GFP_KERNEL_ACCOUNT);
>  	if (!new_xattr)
>  		return NULL;
>  
> @@ -1217,7 +1217,7 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
>  		if (!new_xattr)
>  			return ERR_PTR(-ENOMEM);
>  
> -		new_xattr->name = kstrdup(name, GFP_KERNEL);
> +		new_xattr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
>  		if (!new_xattr->name) {
>  			simple_xattr_free(new_xattr);
>  			return ERR_PTR(-ENOMEM);
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b782edeb69aa..11298c797cdc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3616,7 +3616,7 @@ static int shmem_initxattrs(struct inode *inode,
>  
>  		len = strlen(xattr->name) + 1;
>  		new_xattr->name = kmalloc(XATTR_SECURITY_PREFIX_LEN + len,
> -					  GFP_KERNEL);
> +					  GFP_KERNEL_ACCOUNT);
>  		if (!new_xattr->name) {
>  			kvfree(new_xattr);
>  			break;
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
