Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9C5EC6FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiI0O4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI0O4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C95AC6B;
        Tue, 27 Sep 2022 07:54:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FFE61A05;
        Tue, 27 Sep 2022 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B2DC433D7;
        Tue, 27 Sep 2022 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664290489;
        bh=U7CXbjuRUpWrnogBI5ZLChtegWrFmMKgB6ClDZvfrKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vrGl2quLpFfr5xI69aBEp+0I8RhtCzoq8bZTvmB1ti9L0FArjekTo6GTPIiQ56Z2k
         A52co9zvrDd7ESDe47O19aYLu7/eLrWzLQLOcInzKNvfSNZDh4Mn06EdS7InkSD2um
         QzDnbn2WsSDGnhywumia6NkAISIGaPxvokwMx1lM=
Date:   Tue, 27 Sep 2022 16:54:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 03/27] kallsyms: add static relationship between
 `KSYM_NAME_LEN{,_BUFFER}`
Message-ID: <YzMOt2wSugmHzQD1@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-4-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:34PM +0200, Miguel Ojeda wrote:
> This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
> gets updated when `KSYM_NAME_LEN` changes.
> 
> The relationship used is one that keeps the new size (512+1)
> close to the original buffer size (500).
> 
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 25e2fe5fbcd4..411ff5058b51 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -32,8 +32,18 @@
>  
>  #define KSYM_NAME_LEN		128
>  
> -/* A substantially bigger size than the current maximum. */
> -#define KSYM_NAME_LEN_BUFFER	499
> +/*
> + * A substantially bigger size than the current maximum.
> + *
> + * It cannot be defined as an expression because it gets stringified
> + * for the fscanf() format string. Therefore, a _Static_assert() is
> + * used instead to maintain the relationship with KSYM_NAME_LEN.
> + */
> +#define KSYM_NAME_LEN_BUFFER	512
> +_Static_assert(
> +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> +);

Messy, but I can't think of any other way right now either :(

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
