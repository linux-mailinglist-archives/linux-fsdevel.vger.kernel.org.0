Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA076306BA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 04:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA1D20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 22:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1D2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 22:28:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E95C061574;
        Wed, 27 Jan 2021 19:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7lUT6R2w5meC3ycurgIiPj0j4Q4Qyi7cC+XauNKOYsI=; b=bt9n6+RsVbKHToEhviIK8nFls2
        iusOc6m+y5tRZ8I9RogJy46tzv44Ld9QjJwXqoXit/C62z3MBONceS1UueJDGuuIsw29zeIr6ybIw
        marjzjLAyJuSJs4DYOvObWrGiLCzl48/J7MI/bwtELvbLpe4uqqNIy92CuHtu0rXsV2ofDTV2Dpyt
        Eq6xq/EV85V83T6AvYp2Oj4cakWLo3CF/2fubQv+O0WDQLzz225XedVHu308VssbnYzXb71ur68Nw
        2cTQwsYrNt4cwKITxTRQqlFFDLs5J9WIQA4W7dyDVgAZfBnFRUbUKutUTgv/hmit1H5l6Rvx7vW86
        juPQl1fw==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4xy5-0005rl-EP; Thu, 28 Jan 2021 03:27:37 +0000
Subject: Re: [PATCH 3/3] parser: add unsigned int parser
To:     bingjingc <bingjingc@synology.com>, viro@zeniv.linux.org.uk,
        jack@suse.com, jack@suse.cz, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com
References: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2b423da0-60da-9712-b75c-3ca41ee56634@infradead.org>
Date:   Wed, 27 Jan 2021 19:27:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 1/27/21 6:20 PM, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Will be used by fs parsing options
> 
> Reviewed-by: Robbie Ko<robbieko@synology.com>
> Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
> Signed-off-by: BingJing Chang <bingjingc@synology.com>
> ---
>  fs/isofs/inode.c       | 16 ++--------------
>  fs/udf/super.c         | 16 ++--------------
>  include/linux/parser.h |  1 +
>  lib/parser.c           | 22 ++++++++++++++++++++++
>  4 files changed, 27 insertions(+), 28 deletions(-)

[snip]

> diff --git a/lib/parser.c b/lib/parser.c
> index f5b3e5d..2ec9c4f 100644
> --- a/lib/parser.c
> +++ b/lib/parser.c
> @@ -189,6 +189,28 @@ int match_int(substring_t *s, int *result)
>  EXPORT_SYMBOL(match_int);
>  
>  /**
> + * match_uint: - scan a decimal representation of an integer from a substring_t

This shows us that all of the kernel-doc for functions in
lib/parser.c is formatted incorrectly.

The above should be:

 * match_uint - scan a decimal representation of an integer from a substring_t

i.e., drop the ':' only on the function name lines, for all functions in
this source file.


If you don't want to do that, I'll plan to do it.


> + * @s: substring_t to be scanned
> + * @result: resulting integer on success
> + *
> + * Description: Attempts to parse the &substring_t @s as a decimal integer. On
> + * success, sets @result to the integer represented by the string and returns 0.
> + * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
> + */
> +int match_uint(substring_t *s, unsigned int *result)
> +{
> +	int err = -ENOMEM;
> +	char *buf = match_strdup(s);
> +
> +	if (buf) {
> +		err = kstrtouint(buf, 10, result);
> +		kfree(buf);
> +	}
> +	return err;
> +}
> +EXPORT_SYMBOL(match_uint);
> +
> +/**
>   * match_u64: - scan a decimal representation of a u64 from
>   *                  a substring_t

ditto.

>   * @s: substring_t to be scanned
> 


thanks.
-- 
~Randy

