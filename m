Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03FA6111D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJ1Ms1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1MsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:48:25 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F236068E;
        Fri, 28 Oct 2022 05:48:24 -0700 (PDT)
Received: from quad.stoffel.org (068-116-170-226.res.spectrum.com [68.116.170.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 758DE29C47;
        Fri, 28 Oct 2022 08:48:23 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id AC28FA8004; Fri, 28 Oct 2022 08:48:22 -0400 (EDT)
Date:   Fri, 28 Oct 2022 08:48:22 -0400
From:   John Stoffel <john@quad.stoffel.home>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] [xen] fix "direction" argument of
 iov_iter_kvec()
Message-ID: <Y1vPlg66EZOYrqpP@quad.stoffel.home>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
 <20221028023352.3532080-10-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028023352.3532080-10-viro@zeniv.linux.org.uk>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:33:50AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/xen/pvcalls-back.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
> index d6f945fd4147..21b9c850a382 100644
> --- a/drivers/xen/pvcalls-back.c
> +++ b/drivers/xen/pvcalls-back.c
> @@ -129,13 +129,13 @@ static bool pvcalls_conn_back_read(void *opaque)
>  	if (masked_prod < masked_cons) {
>  		vec[0].iov_base = data->in + masked_prod;
>  		vec[0].iov_len = wanted;
> -		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, wanted);
> +		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, wanted);


Wouldn't it make more sense to use READER and WRITER here, since the
current READ/WRITE are 100% non-obvious?  This is probably a bigger
change, but this just looks wrong and will be so easy for people to
screw up again and again down the line.


>  	} else {
>  		vec[0].iov_base = data->in + masked_prod;
>  		vec[0].iov_len = array_size - masked_prod;
>  		vec[1].iov_base = data->in;
>  		vec[1].iov_len = wanted - vec[0].iov_len;
> -		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, wanted);
> +		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, wanted);
>  	}
>  
>  	atomic_set(&map->read, 0);
> @@ -188,13 +188,13 @@ static bool pvcalls_conn_back_write(struct sock_mapping *map)
>  	if (pvcalls_mask(prod, array_size) > pvcalls_mask(cons, array_size)) {
>  		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
>  		vec[0].iov_len = size;
> -		iov_iter_kvec(&msg.msg_iter, READ, vec, 1, size);
> +		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 1, size);
>  	} else {
>  		vec[0].iov_base = data->out + pvcalls_mask(cons, array_size);
>  		vec[0].iov_len = array_size - pvcalls_mask(cons, array_size);
>  		vec[1].iov_base = data->out;
>  		vec[1].iov_len = size - vec[0].iov_len;
> -		iov_iter_kvec(&msg.msg_iter, READ, vec, 2, size);
> +		iov_iter_kvec(&msg.msg_iter, WRITE, vec, 2, size);
>  	}
>  
>  	atomic_set(&map->write, 0);
> -- 
> 2.30.2
> 

-- 
