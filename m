Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA269B88C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 08:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBRHvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 02:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBRHvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:51:05 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA884FC98;
        Fri, 17 Feb 2023 23:51:04 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 6C2C5C01F; Sat, 18 Feb 2023 08:51:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706687; bh=rqkbDdTH8Q/SkKVOVqq93Y5dIKlvpKXvER9IFuH5QSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxPpy4t5/BUED2lUaCMFjukza5RUGMMQLokPf7cBMS138QnNFdlAxgquvCZCOXDsy
         PvaXPBKh86sym0nEUIlZAgiLRy/fYBnj0FiugW5RowgfMuA45WUI2+6yh3/gJ2/HFB
         Fj0+TdZH7AE+gBOEMrCyrdP/0QSg2FaIFw3ip6CuCjyxyZkJtvf+CuCT0YlVQijj41
         sY90U0ZmYctyclthaO+/RcB8h8S2sAx482CcjxrYBtORvJWAj6zakaLG08t5DeYvGq
         fO6X0KpL/omb2KcaO47YDmEXVQBIQKC8VrE+GCrqSWwn89yHMgXEql2F2zls33TXQs
         ejOoxiMzsPQZw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E6B71C009;
        Sat, 18 Feb 2023 08:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676706686; bh=rqkbDdTH8Q/SkKVOVqq93Y5dIKlvpKXvER9IFuH5QSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCHG6QG7LRNHbpCxRAEc1wo1E/QpTFW2JboGOrYLTvFuGV9ObV20Z9TNO7zTsyU8T
         hVNh99xz4/vini8qjc+TkowSbVOrn89j6MmYweXxSmY5BkmQINPqUdSuGjD26cBC4B
         oGnlGhm0HLxp/39axxgLX8kWQwmuO82J7zHLIJ1swbMuuBspYBQEvb8oFTukrqRH0b
         l6qv9tjVRHoE0UeIJryPsxwnyHCPMbo5kms/swfEnIDArY/5njvsxFk4iDh1icDJwi
         Wq/0+PEC3IiYgAWKJq8OPCy3fVSDIwAXe6HrVj0x3nHAK8KfaDTrK7+449TV8/oNb4
         8HASCTOIPCQGQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1fdbbd87;
        Sat, 18 Feb 2023 07:50:57 +0000 (UTC)
Date:   Sat, 18 Feb 2023 16:50:42 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 01/11] net/9p: Adjust maximum MSIZE to account for p9
 header
Message-ID: <Y/CDUtk3CNIMaf+B@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-2-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-2-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:13AM +0000:
> Add maximum p9 header size to MSIZE to make sure we can
> have page aligned data.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

I'd be tempted to round that up to the next PAGE_SIZE, but it likely
won't make any difference in practice if we want to round the actual
payload. Let's go for this.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

> ---
>  net/9p/client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 622ec6a586ee..6c2a768a6ab1 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -28,7 +28,11 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/9p.h>
>  
> -#define DEFAULT_MSIZE (128 * 1024)
> +/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
> + * room for write (16 extra) or read (11 extra) operands.
> + */
> +
> +#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
>  
>  /* Client Option Parsing (code inspired by NFS code)
>   *  - a little lazy - parse all client options
