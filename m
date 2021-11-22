Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D914589AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 08:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKVHOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 02:14:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVHOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:14:40 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 585221FD26;
        Mon, 22 Nov 2021 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637565093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLXt6amhrvHnna7k2TRUoTyg1Kt2r+zwqjjZ9be/TiE=;
        b=RJa8cxNm15iC6NaZJ//oEwGJu6GK6tfwSlegzlvSb+jjBpresQzZKuJCmxDs8YGKyEheuW
        eQ+phdRSsR5mJ8q0It2TrLQ4RCAN+2eC86oNS0yfnAEcDYiRCzq7/Fxy5/+H2b7/L2d2cK
        F/dWGdFXAnehUyS71q9XWXKRnDLj5l4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BDFCA3B83;
        Mon, 22 Nov 2021 07:11:33 +0000 (UTC)
Date:   Mon, 22 Nov 2021 08:11:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm,fs: Split dump_mapping() out from dump_page()
Message-ID: <YZtCpK2ZsV0qLm6+@dhcp22.suse.cz>
References: <20211121121056.2870061-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211121121056.2870061-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 21-11-21 12:10:56, Matthew Wilcox wrote:
> dump_mapping() is a big chunk of dump_page(), and it'd be handy to be
> able to call it when we don't have a struct page.  Split it out and move
> it to fs/inode.c.  Take the opportunity to simplify some of the debug
> messages a little.

Makes sense. I haven't checked the head files inclusion side of this but
I suspect mm heads do include uaccess.h. Not sure inode.c does as well.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/inode.c         | 49 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  1 +
>  mm/debug.c         | 52 ++--------------------------------------------
>  3 files changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index bdfbd5962f2b..67758b2b702f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -522,6 +522,55 @@ void __remove_inode_hash(struct inode *inode)
>  }
>  EXPORT_SYMBOL(__remove_inode_hash);
>  
> +void dump_mapping(const struct address_space *mapping)
> +{
> +	struct inode *host;
> +	const struct address_space_operations *a_ops;
> +	struct hlist_node *dentry_first;
> +	struct dentry *dentry_ptr;
> +	struct dentry dentry;
> +	unsigned long ino;
> +
> +	/*
> +	 * If mapping is an invalid pointer, we don't want to crash
> +	 * accessing it, so probe everything depending on it carefully.
> +	 */
> +	if (get_kernel_nofault(host, &mapping->host) ||
> +	    get_kernel_nofault(a_ops, &mapping->a_ops)) {
> +		pr_warn("invalid mapping:%px\n", mapping);
> +		return;
> +	}
> +
> +	if (!host) {
> +		pr_warn("aops:%ps\n", a_ops);
> +		return;
> +	}
> +
> +	if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
> +	    get_kernel_nofault(ino, &host->i_ino)) {
> +		pr_warn("aops:%ps invalid inode:%px\n", a_ops, host);
> +		return;
> +	}
> +
> +	if (!dentry_first) {
> +		pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
> +		return;
> +	}
> +
> +	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
> +	if (get_kernel_nofault(dentry, dentry_ptr)) {
> +		pr_warn("aops:%ps ino:%lx invalid dentry:%px\n",
> +				a_ops, ino, dentry_ptr);
> +		return;
> +	}
> +
> +	/*
> +	 * if dentry is corrupted, the %pd handler may still crash,
> +	 * but it's unlikely that we reach here with a corrupt mapping
> +	 */
> +	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
> +}
> +
>  void clear_inode(struct inode *inode)
>  {
>  	/*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d6a4eb6cf825..acaad2b0d5b9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3149,6 +3149,7 @@ extern void unlock_new_inode(struct inode *);
>  extern void discard_new_inode(struct inode *);
>  extern unsigned int get_next_ino(void);
>  extern void evict_inodes(struct super_block *sb);
> +void dump_mapping(const struct address_space *);
>  
>  /*
>   * Userspace may rely on the the inode number being non-zero. For example, glibc
> diff --git a/mm/debug.c b/mm/debug.c
> index fae0f81ad831..b3ebfab21cb3 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -110,56 +110,8 @@ static void __dump_page(struct page *page)
>  		type = "ksm ";
>  	else if (PageAnon(page))
>  		type = "anon ";
> -	else if (mapping) {
> -		struct inode *host;
> -		const struct address_space_operations *a_ops;
> -		struct hlist_node *dentry_first;
> -		struct dentry *dentry_ptr;
> -		struct dentry dentry;
> -		unsigned long ino;
> -
> -		/*
> -		 * mapping can be invalid pointer and we don't want to crash
> -		 * accessing it, so probe everything depending on it carefully
> -		 */
> -		if (get_kernel_nofault(host, &mapping->host) ||
> -		    get_kernel_nofault(a_ops, &mapping->a_ops)) {
> -			pr_warn("failed to read mapping contents, not a valid kernel address?\n");
> -			goto out_mapping;
> -		}
> -
> -		if (!host) {
> -			pr_warn("aops:%ps\n", a_ops);
> -			goto out_mapping;
> -		}
> -
> -		if (get_kernel_nofault(dentry_first, &host->i_dentry.first) ||
> -		    get_kernel_nofault(ino, &host->i_ino)) {
> -			pr_warn("aops:%ps with invalid host inode %px\n",
> -					a_ops, host);
> -			goto out_mapping;
> -		}
> -
> -		if (!dentry_first) {
> -			pr_warn("aops:%ps ino:%lx\n", a_ops, ino);
> -			goto out_mapping;
> -		}
> -
> -		dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
> -		if (get_kernel_nofault(dentry, dentry_ptr)) {
> -			pr_warn("aops:%ps ino:%lx with invalid dentry %px\n",
> -					a_ops, ino, dentry_ptr);
> -		} else {
> -			/*
> -			 * if dentry is corrupted, the %pd handler may still
> -			 * crash, but it's unlikely that we reach here with a
> -			 * corrupted struct page
> -			 */
> -			pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n",
> -					a_ops, ino, &dentry);
> -		}
> -	}
> -out_mapping:
> +	else if (mapping)
> +		dump_mapping(mapping);
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
>  	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
> -- 
> 2.33.0

-- 
Michal Hocko
SUSE Labs
