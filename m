Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79F7340F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 22:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhCRVDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 17:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhCRVDM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 17:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FE9261582;
        Thu, 18 Mar 2021 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616101391;
        bh=chcir1xO1kTSXJFgly4UY7zIqLtB9SGZzjqPKGeyPyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufV2Xgp+HNERSH28TPNr2hUqMnGAALWbcaUgtUfnSwkeoq1Up/31KyHpBpuDZLG+q
         FIGEscYy339CN9uO5roRQNC2S/mHcqnF/iFtGASmProQKYLpmpsgfBXVu4jxBf//oy
         Odd7g99rUZmB80lGQAgj/uRCvhHXppzVJqm+SB5FFL9+5qqiRE//aUwUjxANMhSUGX
         yK8CHlTOr+Hzxs6OVPinwXs1H2T0OPAJhCEOZcjVm/zl64RTrWYX4VNd/3lY6S5+dF
         2RnuVAKFyKLoeGy9A3miOkYciLJ0UUWs+z9YUc3+brVneP+lZkuZHHnmZlgiQVAnqa
         9JYMAc6N69U+A==
Date:   Thu, 18 Mar 2021 14:03:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/4] fs: unicode: Use strscpy() instead of strncpy()
Message-ID: <YFPADdUVA51/PTGk@gmail.com>
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
 <20210318133305.316564-4-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318133305.316564-4-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:03:04PM +0530, Shreeya Patel wrote:
> Following warning was reported by Kernel Test Robot.
> 
> In function 'utf8_parse_version',
> inlined from 'utf8_load' at fs/unicode/utf8mod.c:195:7:
> >> fs/unicode/utf8mod.c:175:2: warning: 'strncpy' specified bound 12 equals
> destination size [-Wstringop-truncation]
> 175 |  strncpy(version_string, version, sizeof(version_string));
>     |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The -Wstringop-truncation warning highlights the unintended
> uses of the strncpy function that truncate the terminating NULL
> character from the source string.
> Unlike strncpy(), strscpy() always null-terminates the destination string,
> hence use strscpy() instead of strncpy().
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2
>   - Resolve warning of -Wstringop-truncation reported by
>     kernel test robot.
> 
>  fs/unicode/unicode-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
> index d5f09e022ac5..287a8a48836c 100644
> --- a/fs/unicode/unicode-core.c
> +++ b/fs/unicode/unicode-core.c
> @@ -179,7 +179,7 @@ static int unicode_parse_version(const char *version, unsigned int *maj,
>  		{0, NULL}
>  	};
>  
> -	strncpy(version_string, version, sizeof(version_string));
> +	strscpy(version_string, version, sizeof(version_string));
>  

Shouldn't unicode_parse_version() return an error if the string gets truncated
here?  I.e. check if strscpy() returns < 0.

Also, this is a "fix" (though one that doesn't currently matter, since 'version'
is currently always shorter than sizeof(version_string)), so it should go first
in the series and have a Fixes tag.

- Eric
