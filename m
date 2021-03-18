Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D0340786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCRONV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 10:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCRONQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:13:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ADCC06174A;
        Thu, 18 Mar 2021 07:13:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id AFA041F45F65
Subject: Re: [PATCH v2 3/4] fs: unicode: Use strscpy() instead of strncpy()
To:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com,
        kernel test robot <lkp@intel.com>
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-4-shreeya.patel@collabora.com>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <f6bb5ec3-da94-ae9a-4ac4-e39038b42cb3@collabora.com>
Date:   Thu, 18 Mar 2021 19:43:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318133305.316564-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 18/03/21 7:03 pm, Shreeya Patel wrote:
> Following warning was reported by Kernel Test Robot.
>
> In function 'utf8_parse_version',
> inlined from 'utf8_load' at fs/unicode/utf8mod.c:195:7:
>>> fs/unicode/utf8mod.c:175:2: warning: 'strncpy' specified bound 12 equals
> destination size [-Wstringop-truncation]
> 175 |  strncpy(version_string, version, sizeof(version_string));
>      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The -Wstringop-truncation warning highlights the unintended
> uses of the strncpy function that truncate the terminating NULL
> character from the source string.
> Unlike strncpy(), strscpy() always null-terminates the destination string,
> hence use strscpy() instead of strncpy().


Not sure if strscpy is preferable. Just found this article 
https://lwn.net/Articles/659214/
Should I go for memcpy instead?


>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2
>    - Resolve warning of -Wstringop-truncation reported by
>      kernel test robot.
>
>   fs/unicode/unicode-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
> index d5f09e022ac5..287a8a48836c 100644
> --- a/fs/unicode/unicode-core.c
> +++ b/fs/unicode/unicode-core.c
> @@ -179,7 +179,7 @@ static int unicode_parse_version(const char *version, unsigned int *maj,
>   		{0, NULL}
>   	};
>   
> -	strncpy(version_string, version, sizeof(version_string));
> +	strscpy(version_string, version, sizeof(version_string));
>   
>   	if (match_token(version_string, token, args) != 1)
>   		return -EINVAL;
