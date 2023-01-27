Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A184C67E192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 11:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjA0K1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 05:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjA0K1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:27:33 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3F2A175;
        Fri, 27 Jan 2023 02:27:32 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLLwl-004gF4-LQ; Fri, 27 Jan 2023 18:27:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 18:27:03 +0800
Date:   Fri, 27 Jan 2023 18:27:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        nspmangalore@gmail.com, rohiths.msft@gmail.com, tom@talpey.com,
        metze@samba.org, hch@infradead.org, willy@infradead.org,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfrench@samba.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC 06/13] cifs: Add a function to Hash the contents of an
 iterator
Message-ID: <Y9Om95NlPTFiHMSj@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125214543.2337639-7-dhowells@redhat.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index cbc18b4a9cb2..7be589aeb520 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -24,6 +24,150 @@
> #include "../smbfs_common/arc4.h"
> #include <crypto/aead.h>
> 
> +/*
> + * Hash data from a BVEC-type iterator.
> + */
> +static int cifs_shash_bvec(const struct iov_iter *iter, ssize_t maxsize,
> +                          struct shash_desc *shash)
> +{
> +       const struct bio_vec *bv = iter->bvec;
> +       unsigned long start = iter->iov_offset;
> +       unsigned int i;
> +       void *p;
> +       int ret;
> +
> +       for (i = 0; i < iter->nr_segs; i++) {
> +               size_t off, len;
> +
> +               len = bv[i].bv_len;
> +               if (start >= len) {
> +                       start -= len;
> +                       continue;
> +               }
> +
> +               len = min_t(size_t, maxsize, len - start);
> +               off = bv[i].bv_offset + start;
> +
> +               p = kmap_local_page(bv[i].bv_page);
> +               ret = crypto_shash_update(shash, p + off, len);

Please convert this to ahash.  The whole point of shash is to
process *small* amounts of data that is not on an SG list.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
