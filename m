Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574934DDC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 03:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC3BtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 21:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhC3Bss (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C49360C41;
        Tue, 30 Mar 2021 01:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617068927;
        bh=iIeIM/OuGtjaYTjydbbG0UkVMkzGNNchPxEVUAEmnkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDxq7K9t7dlImUknG3pZavwpTDgqaPC7F9NdQLDcVbBczilmQZvhCW0eksYB8RuYt
         WjNUkzadhFtYGdO6BMlWvTRw1NW2eir9qEheqsePkacJsCdS2n/WJYmFgsXweXbnHo
         1PT+uC3kAf881vRVcH30ssY4QqHieFaZg+7iVRum4xbCXh6WBWyd4aP52uL34rkcvH
         rTPtpyumwG13TKR9pY8RmdZsGh7As/NrnVe8LDGtHCGWBLPbo4ro2YhnSCs1MvmKHl
         KaK/qtyaBcuqUh91ULqym24uAAtps7VmWan4KPhFTY2ueJ92c5xT/nlAI4snicxy2l
         clT9SDt2FfZaA==
Date:   Mon, 29 Mar 2021 18:48:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        kernel@collabora.com, Daniel Rosenberg <drosen@google.com>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        krisman@collabora.com
Subject: Re: [PATCH 1/3] fs/dcache: Add d_clear_dir_neg_dentries()
Message-ID: <YGKDfo1vZfFXwG/v@gmail.com>
References: <20210328144356.12866-1-andrealmeid@collabora.com>
 <20210328144356.12866-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210328144356.12866-2-andrealmeid@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 28, 2021 at 11:43:54AM -0300, André Almeida wrote:
> For directories with negative dentries that are becoming case-insensitive
> dirs, we need to remove all those negative dentries, otherwise they will
> become dangling dentries. During the creation of a new file, if a d_hash
> collision happens and the names match in a case-insensitive way, the name
> of the file will be the name defined at the negative dentry, that may be
> different from the specified by the user. To prevent this from
> happening, we need to remove all dentries in a directory. Given that the
> directory must be empty before we call this function we are sure that
> all dentries there will be negative.
> 
> Create a function to remove all negative dentries from a directory, to
> be used as explained above by filesystems that support case-insensitive
> lookups.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  fs/dcache.c            | 27 +++++++++++++++++++++++++++
>  include/linux/dcache.h |  1 +
>  2 files changed, 28 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 7d24ff7eb206..fafb3016d6fd 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1723,6 +1723,33 @@ void d_invalidate(struct dentry *dentry)
>  }
>  EXPORT_SYMBOL(d_invalidate);
>  
> +/**
> + * d_clear_dir_neg_dentries - Remove negative dentries in an inode
> + * @dir: Directory to clear negative dentries
> + *
> + * For directories with negative dentries that are becoming case-insensitive
> + * dirs, we need to remove all those negative dentries, otherwise they will
> + * become dangling dentries. During the creation of a new file, if a d_hash
> + * collision happens and the names match in a case-insensitive, the name of
> + * the file will be the name defined at the negative dentry, that can be
> + * different from the specified by the user. To prevent this from happening, we
> + * need to remove all dentries in a directory. Given that the directory must be
> + * empty before we call this function we are sure that all dentries there will
> + * be negative.
> + */
> +void d_clear_dir_neg_dentries(struct inode *dir)
> +{
> +	struct dentry *alias, *dentry;
> +
> +	hlist_for_each_entry(alias, &dir->i_dentry, d_u.d_alias) {
> +		list_for_each_entry(dentry, &alias->d_subdirs, d_child) {
> +			d_drop(dentry);
> +			dput(dentry);
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(d_clear_dir_neg_dentries);

As Al already pointed out, this doesn't work as intended, for a number of
different reasons.

Did you consider just using shrink_dcache_parent()?  That already does what you
are trying to do here, I think.

The harder part (which I don't think you've considered) is how to ensure that
all negative dentries really get invalidated even if there are lookups of them
happening concurrently.  Concurrent lookups can take temporary references to the
negative dentries, preventing them from being invalidated.

- Eric
