Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C37AAE33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 11:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjIVJeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 05:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjIVJeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:34:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E0CDE;
        Fri, 22 Sep 2023 02:34:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E5EC433C9;
        Fri, 22 Sep 2023 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695375248;
        bh=3sau3zGAqT64PlvL93L3t5WW9upTsJ7zh15tcnTdr5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhaIBnCaAbuCpSxAopP2bOKGZnEbjsw1ElAoo3Zz7BnAv+l/F+pFaAiLxFA9ny7H4
         9L3mO0A6LcrzntFIYgI89H2ltGDEBIp8buJfoqqX2Oket8WLh5QH4+7vA52PjIoXmF
         zewHVEDJJ5s7nk3si4FZfbeiSKzOb+PQs0ixFTAuCpuG4a7+rn8HDBUBtzxA5Z7LmQ
         9DxTufr/nkZ/j9CT/d7cv8Tjl14CVfZvwM5GTA2Jm9SOkAMYeEIgEsSi7Kk/Fh87yA
         C7Y3P8pP44GUxZbrjNnO7rg1kLoKIIy5/7H2qkrSrshAyEnkdWKtxFpFjNqPVSTvqh
         bwiFNK1GyFDMQ==
Date:   Fri, 22 Sep 2023 10:34:01 +0100
From:   Simon Horman <horms@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/11] iov_iter: Add a kernel-type iterator-only
 iteration function
Message-ID: <20230922093401.GW224399@kernel.org>
References: <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-8-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920222231.686275-8-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:22:27PM +0100, David Howells wrote:
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Christian Brauner <christian@brauner.io>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: David Laight <David.Laight@ACULAB.COM>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  include/linux/iov_iter.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
> index 270454a6703d..a94d605d7386 100644
> --- a/include/linux/iov_iter.h
> +++ b/include/linux/iov_iter.h
> @@ -271,4 +271,35 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
>  	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
>  }
>  
> +/**
> + * iterate_and_advance_kernel - Iterate over a kernel iterator
> + * @iter: The iterator to iterate over.
> + * @len: The amount to iterate over.
> + * @priv: Data for the step functions.

nit: an entry for @priv2 belongs here

> + * @step: Processing function; given kernel addresses.
> + *
> + * Like iterate_and_advance2(), but rejected UBUF and IOVEC iterators and does
> + * not take a user-step function.
> + */
> +static __always_inline
> +size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
> +				  void *priv2, iov_step_f step)
> +{

...
