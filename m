Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14138206B91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgFXFNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:13:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47028 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgFXFNW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:13:22 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B1D7D2A3349
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v9 1/4] unicode: Add utf8_casefold_hash
Organization: Collabora
References: <20200624043341.33364-1-drosen@google.com>
        <20200624043341.33364-2-drosen@google.com>
Date:   Wed, 24 Jun 2020 01:13:17 -0400
In-Reply-To: <20200624043341.33364-2-drosen@google.com> (Daniel Rosenberg's
        message of "Tue, 23 Jun 2020 21:33:38 -0700")
Message-ID: <87h7v1gi6q.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
>  include/linux/unicode.h |  3 +++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index 2a878b739115d..90656b9980720 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -6,6 +6,7 @@
>  #include <linux/parser.h>
>  #include <linux/errno.h>
>  #include <linux/unicode.h>
> +#include <linux/stringhash.h>
>  
>  #include "utf8n.h"
>  
> @@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  	}
>  	return -EINVAL;
>  }
> -
>  EXPORT_SYMBOL(utf8_casefold);
>  
> +int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
> +		       struct qstr *str)
> +{
> +	const struct utf8data *data = utf8nfdicf(um->version);
> +	struct utf8cursor cur;
> +	int c;
> +	unsigned long hash = init_name_hash(salt);
> +
> +	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
> +		return -EINVAL;
> +
> +	while ((c = utf8byte(&cur))) {
> +		if (c < 0)
> +			return c;

Return -EINVAL here to match other unicode functions, since utf8byte
will return -1 on a binary blob, which doesn't make sense for this.

Other than that, looks good to me.

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> +		hash = partial_name_hash((unsigned char)c, hash);
> +	}
> +	str->hash = end_name_hash(hash);
> +	return 0;
> +}
> +EXPORT_SYMBOL(utf8_casefold_hash);
> +
>  int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>  		   unsigned char *dest, size_t dlen)
>  {
> diff --git a/include/linux/unicode.h b/include/linux/unicode.h
> index 990aa97d80496..74484d44c7554 100644
> --- a/include/linux/unicode.h
> +++ b/include/linux/unicode.h
> @@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
>  int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
>  		  unsigned char *dest, size_t dlen);
>  
> +int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
> +		       struct qstr *str);
> +
>  struct unicode_map *utf8_load(const char *version);
>  void utf8_unload(struct unicode_map *um);

-- 
Gabriel Krisman Bertazi
