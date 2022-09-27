Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEED55EC570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiI0OFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiI0OFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:05:44 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 07:05:43 PDT
Received: from hop.stappers.nl (hop.stappers.nl [IPv6:2a02:2308:0:14e::686f:7030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259041D10
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 07:05:43 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [IPv6:2a02:a46d:659e:1::696e:626f])
        by hop.stappers.nl (Postfix) with ESMTP id 088DA2000F;
        Tue, 27 Sep 2022 14:05:42 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id AD319304049; Tue, 27 Sep 2022 16:05:41 +0200 (CEST)
Date:   Tue, 27 Sep 2022 16:05:41 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v10 01/27] kallsyms: use `ARRAY_SIZE` instead of
 hardcoded size
Message-ID: <20220927140541.zpb2effrshaxndqi@gpm.stappers.nl>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-2-ojeda@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:32PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This removes one place where the `500` constant is hardcoded.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index f18e6dfc68c5..8551513f9311 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
>  
>  	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
>  	if (rc != 3) {
> -		if (rc != EOF && fgets(name, 500, in) == NULL)
> +		if (rc != EOF && fgets(name, ARRAY_SIZE(name), in) == NULL)
>  			fprintf(stderr, "Read error or end of file.\n");
>  		return NULL;
>  	}
> -- 
> 2.37.3
> 

Reviewed-by: Geert Stappers <stappers@stappers.nl>
 

Regards
Geert Stappers
Hopes to see the kallsyms patches getting accepted,
that they don't show up in v11 of the Rust patch serie.
-- 
Silence is hard to parse
