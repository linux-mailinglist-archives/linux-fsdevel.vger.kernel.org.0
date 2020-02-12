Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B094159F8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 04:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBLDiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 22:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgBLDiF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:38:05 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E112073C;
        Wed, 12 Feb 2020 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581478684;
        bh=QFEFG/81Rfdx+DhaJa330Iy0plXtvuXYAYlLrbnAw4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgLuYeSFpKxnDdxa83uM8r7H8S2iSSVhydJQbgl1WskDbn0S35JXuXY6oYMb6AFqU
         HxO5QSmEbAmJQYLuF8FimrMwI0rN+5dYv0mjVwfxsOCEj+bKApbx/sRGflnZL6TTxF
         hsjxh+dI86q2CbBRmKMiAXqhZqvYy14nr51t/CqE=
Date:   Tue, 11 Feb 2020 19:38:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 1/8] unicode: Add utf8_casefold_iter
Message-ID: <20200212033800.GC870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-2-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-2-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:45PM -0800, Daniel Rosenberg wrote:
> This function will allow other uses of unicode to act upon a casefolded
> string without needing to allocate their own copy of one.
> 
> The actor function can return an nonzero value to exit early.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/unicode/utf8-core.c  | 25 ++++++++++++++++++++++++-
>  include/linux/unicode.h | 10 ++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 2a878b739115d..db050bf59a32b 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -122,9 +122,32 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  	}
>  	return -EINVAL;
>  }
> -
>  EXPORT_SYMBOL(utf8_casefold);
>  
> +int utf8_casefold_iter(const struct unicode_map *um, const struct qstr *str,
> +		    struct utf8_itr_context *ctx)
> +{
> +	const struct utf8data *data = utf8nfdicf(um->version);
> +	struct utf8cursor cur;
> +	int c;
> +	int res = 0;
> +	int pos = 0;
> +
> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
> +		return -EINVAL;
> +
> +	while ((c = utf8byte(&cur))) {
> +		if (c < 0)
> +			return c;
> +		res = ctx->actor(ctx, c, pos);
> +		pos++;
> +		if (res)
> +			return res;
> +	}
> +	return res;
> +}
> +EXPORT_SYMBOL(utf8_casefold_iter);

Indirect function calls are expensive these days for various reasons, including
Spectre mitigations and CFI.  Are you sure it's okay from a performance
perspective to make an indirect call for every byte of the pathname?

> +typedef int (*utf8_itr_actor_t)(struct utf8_itr_context *, int byte, int pos);

The byte argument probably should be 'u8', to avoid confusion about whether it's
a byte or a Unicode codepoint.

- Eric
