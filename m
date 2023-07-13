Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ED77516B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbjGMDVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 23:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjGMDVJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:21:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6059810FC;
        Wed, 12 Jul 2023 20:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=605YgMfajbHUM8zyPverYiNrP/gL/svBXPBHjEAyzKA=; b=BDiydvVJ4ED4g+lWwgib5QO/7H
        QE/h5ih5ZbmG0yjhU0PPEXbHnulFBdGPWy/GGmjw9G1rAjAOYZW8kV7/ryaNP+H/Yw0aS5YW+VuBG
        Dx6iikGUC33E/7DjrAwWYyYoqaCOmsyMg/daZ+KIdMkj4MLNoMNSVrGQVg8bctIhNbZDL2dty1ksW
        ZyBtcyRrVxk8cumG5VATCfRokvtNqFSAjIA+/V71ACX9LOL1VqsiKkv7swjvjPtkFB85ByoY+KBRi
        L6YypChaDTu2RDTBhQ9x84gcfgbMD5epaOhIFH+BSimfhR4jiBl3jBkJzkbF1SHW+8OlKN2gymFKq
        I9EWrwxw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJmt9-001oD3-2n;
        Thu, 13 Jul 2023 03:21:07 +0000
Message-ID: <670a325f-f066-d146-f738-e5db1ca029ee@infradead.org>
Date:   Wed, 12 Jul 2023 20:21:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/20] bcache: move closures to lib/
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-13-kent.overstreet@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712211115.2174650-13-kent.overstreet@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

LGTM.
I have a couple of small nits below...

On 7/12/23 14:11, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> Prep work for bcachefs - being a fork of bcache it also uses closures
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Acked-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/Kconfig                     | 10 +-----
>  drivers/md/bcache/Makefile                    |  4 +--
>  drivers/md/bcache/bcache.h                    |  2 +-
>  drivers/md/bcache/super.c                     |  1 -
>  drivers/md/bcache/util.h                      |  3 +-
>  .../md/bcache => include/linux}/closure.h     | 17 +++++----
>  lib/Kconfig                                   |  3 ++
>  lib/Kconfig.debug                             |  9 +++++
>  lib/Makefile                                  |  2 ++
>  {drivers/md/bcache => lib}/closure.c          | 35 +++++++++----------
>  10 files changed, 43 insertions(+), 43 deletions(-)
>  rename {drivers/md/bcache => include/linux}/closure.h (97%)
>  rename {drivers/md/bcache => lib}/closure.c (88%)
> 

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ce51d4dc68..3ee25d5dae 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1637,6 +1637,15 @@ config DEBUG_NOTIFIERS
>  	  This is a relatively cheap check but if you care about maximum
>  	  performance, say N.
>  
> +config DEBUG_CLOSURES
> +	bool "Debug closures (bcache async widgits)"

	                                   widgets

> +	depends on CLOSURES
> +	select DEBUG_FS
> +	help
> +	Keeps all active closures in a linked list and provides a debugfs
> +	interface to list them, which makes it possible to see asynchronous
> +	operations that get stuck.

Indent those 3 help text lines with 2 additional spaces, please,
as documented and as is done in (most of) the rest of this file.

With those fixed:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
