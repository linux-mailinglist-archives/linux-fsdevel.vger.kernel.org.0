Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C1C24DBB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHUQqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgHUQqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:46:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CFC061573;
        Fri, 21 Aug 2020 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nuDpRInBJQyR0NCAf/lyEPb52W6JlB8Y7J9fyZqXXdc=; b=ckkFxN4BN5xFpVQbmFA2HJVarn
        ZwiYvjR8K6W7mmMI7Fg8KwVuoXk5K+6CrNQsPFlts1atmB1Ed0E3VPaV+C5FRkT+ZyALQxAPcvZgS
        GXZfZ0D5X3CaMUrIlHbB9rsIhm6nM8VXVZq2GvP3Y4ahluuPSGDdgwNMD4dpcsS1+LINyHo2SmKy5
        r4LsZ6/0jvI+0k6B743TQO9+DYMBjHtZQ1CK20ToDEvNomhBkAPo3noRH3X8wYAgZSmcrt2v9IZW2
        QtZl7U+PG8FkHcSi0liV9MBLMwuOiGhcZS+oZlT3QpRr8QTX1xGA94zMW9PSYXB78JMruWy0C6y+r
        SkXFm7Yw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9ABJ-0001rq-JI; Fri, 21 Aug 2020 16:46:21 +0000
Subject: Re: [PATCH v2 06/10] fs/ntfs3: Add compression
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <ecaa5cd692294178a38a9a2310d9856f@paragon-software.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e12ee6c4-5064-709a-0d4b-751b23bc5ccb@infradead.org>
Date:   Fri, 21 Aug 2020 09:46:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ecaa5cd692294178a38a9a2310d9856f@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 9:25 AM, Konstantin Komarov wrote:
> This adds compression
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/lznt.c | 449 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 449 insertions(+)
>  create mode 100644 fs/ntfs3/lznt.c
> 
> diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
> new file mode 100644
> index 000000000000..db3256c08387
> --- /dev/null
> +++ b/fs/ntfs3/lznt.c
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  linux/fs/ntfs3/lznt.c
> + *
> + * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
> + *
> + */

Hi,

> +// 0x3FFF
> +#define HeaderOfNonCompressedChunk ((LZNT_CHUNK_SIZE + 2 - 3) | 0x3000)

Do we need something in coding-style.rst that says:
	Avoid CamelCase in Linux kernel source code.
?

> +
> +/*
> + * compess_chunk

Just curious: what is this compess name?

> + *
> + * returns one of the tree values:

s/tree/three/


> + * 0 - ok, 'cmpr' contains 'cmpr_chunk_size' bytes of compressed data
> + * 1 == LZNT_ERROR_ALL_ZEROS - input buffer is full zero
> + * -2 == LZNT_ERROR_TOOSMALL
> + */
> +static inline int compess_chunk(size_t (*match)(const u8 *, struct lznt *),
> +				const u8 *unc, const u8 *unc_end, u8 *cmpr,
> +				u8 *cmpr_end, size_t *cmpr_chunk_size,
> +				struct lznt *ctx)
> +{

...


-- 
~Randy

