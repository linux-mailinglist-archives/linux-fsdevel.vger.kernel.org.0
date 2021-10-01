Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53941F50A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355895AbhJAShY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 14:37:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355832AbhJAShW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:37:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 63FE01F459BE
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] fs: dcache: Handle case-exact lookup in
 d_alloc_parallel
Organization: Collabora
References: <cover.1632909358.git.shreeya.patel@collabora.com>
        <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
Date:   Fri, 01 Oct 2021 14:35:32 -0400
In-Reply-To: <0b8fd2677b797663bfcb97f6aa108193fedf9767.1632909358.git.shreeya.patel@collabora.com>
        (Shreeya Patel's message of "Wed, 29 Sep 2021 16:23:38 +0530")
Message-ID: <87a6js61aj.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> There is a soft hang caused by a deadlock in d_alloc_parallel which
> waits up on lookups to finish for the dentries in the parent directory's
> hash_table.
> In case when d_add_ci is called from the fs layer's lookup functions,
> the dentry being looked up is already in the hash table (created before
> the fs lookup function gets called). We should not be processing the
> same dentry that is being looked up, hence, in case of case-insensitive
> filesystems we are making it a case-exact match to prevent this from
> happening.
>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>  fs/dcache.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index cf871a81f4fd..2a28ab64a165 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2565,6 +2565,15 @@ static void d_wait_lookup(struct dentry *dentry)
>  	}
>  }
>  
> +static inline bool d_same_exact_name(const struct dentry *dentry,
> +				     const struct dentry *parent,
> +				     const struct qstr *name)
> +{
> +	if (dentry->d_name.len != name->len)
> +		return false;
> +	return dentry_cmp(dentry, name->name, name->len) == 0;
> +}

I don't like the idea of having a flavor of a dentry comparison function
that doesn't invoke d_compare.  In particular because d_compare might be
used for all sorts of things, and this fix is really specific to the
case-insensitive case.

Would it be possible to fold this change into generic_ci_d_compare?  If
we could flag the dentry as part of a parallel lookup under the relevant
condition, generic_ci_d_compare could simply return immediately in
such case.

> +
>  struct dentry *d_alloc_parallel(struct dentry *parent,
>  				const struct qstr *name,
>  				wait_queue_head_t *wq)
> @@ -2575,6 +2584,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  	struct dentry *new = d_alloc(parent, name);
>  	struct dentry *dentry;
>  	unsigned seq, r_seq, d_seq;
> +	int ci_dir = IS_CASEFOLDED(parent->d_inode);
>  
>  	if (unlikely(!new))
>  		return ERR_PTR(-ENOMEM);
> @@ -2626,8 +2636,14 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
>  			continue;
>  		if (dentry->d_parent != parent)
>  			continue;
> -		if (!d_same_name(dentry, parent, name))
> -			continue;
> +		if (ci_dir) {
> +			if (!d_same_exact_name(dentry, parent, name))
> +				continue;
> +		} else {


As is, this is problematic because d_alloc_parallel is also part of the
lookup path (see lookup_open, lookup_slow).  In those cases, you want to
do the CI comparison, to prevent racing two tasks creating a dentry
differing only by case.


> +			if (!d_same_name(dentry, parent, name))
> +				continue;
> +		}
> +
>  		hlist_bl_unlock(b);
>  		/* now we can try to grab a reference */
>  		if (!lockref_get_not_dead(&dentry->d_lockref)) {

-- 
Gabriel Krisman Bertazi
