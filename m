Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC62B6DB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgKQSuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbgKQSuJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:50:09 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A480F24180;
        Tue, 17 Nov 2020 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605639009;
        bh=ptz9XT3UpBck0+d8VvUIsolwmj+r8a3+u1aG77tQJmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmVR2pAkTlpMKVjjgmbkim6ODtn1XHcuCvpY+dS/cItfgY5lVJnQyb+QKecfKG9cH
         bB2akSGX5XKm0Y290MyY1d6qvi6oF9ARKg0xqZ0rWF7bfyngwmZbo5JBR5qyfqscDa
         opfxCyeGR/g5xyvZBhCdhIHAorzvoK1oBOibSCcE=
Date:   Tue, 17 Nov 2020 10:50:07 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 3/3] f2fs: Handle casefolding with Encryption
Message-ID: <X7QbX9Q4xzhg+5UU@sol.localdomain>
References: <20201117040315.28548-1-drosen@google.com>
 <20201117040315.28548-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117040315.28548-4-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:03:15AM +0000, Daniel Rosenberg wrote:
> Expand f2fs's casefolding support to include encrypted directories.  To
> index casefolded+encrypted directories, we use the SipHash of the
> casefolded name, keyed by a key derived from the directory's fscrypt
> master key.  This ensures that the dirhash doesn't leak information
> about the plaintext filenames.
> 
> Encryption keys are unavailable during roll-forward recovery, so we
> can't compute the dirhash when recovering a new dentry in an encrypted +
> casefolded directory.  To avoid having to force a checkpoint when a new
> file is fsync'ed, store the dirhash on-disk appended to i_name.
> 
> This patch incorporates work by Eric Biggers <ebiggers@google.com>
> and Jaegeuk Kim <jaegeuk@kernel.org>.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/dir.c      | 89 +++++++++++++++++++++++++++++++++++++---------
>  fs/f2fs/f2fs.h     |  8 +++--
>  fs/f2fs/hash.c     | 11 +++++-
>  fs/f2fs/inline.c   |  4 +++
>  fs/f2fs/recovery.c | 12 ++++++-
>  fs/f2fs/super.c    |  6 ----
>  6 files changed, 103 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 71fdf5076461..0adc6bcfb5c0 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>   *             http://www.samsung.com/
>   */
> +#include <asm/unaligned.h>
>  #include <linux/fs.h>
>  #include <linux/f2fs_fs.h>
>  #include <linux/sched/signal.h>
> @@ -195,26 +196,53 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
>  {
>  	struct f2fs_dentry_block *dentry_blk;
>  	struct f2fs_dentry_ptr d;
> +	struct f2fs_dir_entry *res;
>  
>  	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
>  
>  	make_dentry_ptr_block(dir, &d, dentry_blk);
> -	return f2fs_find_target_dentry(&d, fname, max_slots);
> +	res = f2fs_find_target_dentry(&d, fname, max_slots);
> +	if (IS_ERR(res)) {
> +		dentry_page = ERR_CAST(res);
> +		res = NULL;
> +	}
> +	return res;
>  }

What is the assignment to dentry_page supposed to be accomplishing?  It looks
like it's meant to pass up errors from f2fs_find_target_dentry(), but it doesn't
do that.

> @@ -222,14 +250,20 @@ static bool f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
>  		 * fall back to treating them as opaque byte sequences.
>  		 */
>  		if (sb_has_strict_encoding(sb) || name->len != entry.len)
> -			return false;
> -		return !memcmp(name->name, entry.name, name->len);
> +			res = 0;
> +		else
> +			res = memcmp(name->name, entry.name, name->len) == 0;
> +	} else {
> +		/* utf8_strncasecmp_folded returns 0 on match */
> +		res = (res == 0);
>  	}

The following might be easier to understand:

	/*
	 * In strict mode, ignore invalid names.  In non-strict mode, fall back
	 * to treating them as opaque byte sequences.
	 */
	if (res < 0 && !sb_has_strict_encoding(sb)) {
		res = name->len == entry.len &&
		      memcmp(name->name, entry.name, name->len) == 0;
	} else {
		/* utf8_strncasecmp_folded returns 0 on match */
		res = (res == 0);
	}

> @@ -273,10 +308,14 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
>  			continue;
>  		}
>  
> -		if (de->hash_code == fname->hash &&
> -		    f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> -				    le16_to_cpu(de->name_len)))
> -			goto found;
> +		if (de->hash_code == fname->hash) {
> +			res = f2fs_match_name(d->inode, fname, d->filename[bit_pos],
> +				    le16_to_cpu(de->name_len));
> +			if (res < 0)
> +				return ERR_PTR(res);
> +			else if (res)
> +				goto found;
> +		}

Overly long line here.  Also 'else if' is unnecessary, just use 'if'.

- Eric
