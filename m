Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6C346891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhCWTJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 15:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhCWTJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:09:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9284C061574;
        Tue, 23 Mar 2021 12:09:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3D4EC1F455B7
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, ebiggers@google.com, drosen@google.com,
        ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/5] fs: unicode: Use strscpy() instead of strncpy()
Organization: Collabora
References: <20210323183201.812944-1-shreeya.patel@collabora.com>
        <20210323183201.812944-2-shreeya.patel@collabora.com>
Date:   Tue, 23 Mar 2021 15:09:05 -0400
In-Reply-To: <20210323183201.812944-2-shreeya.patel@collabora.com> (Shreeya
        Patel's message of "Wed, 24 Mar 2021 00:01:57 +0530")
Message-ID: <87wntxd6we.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> Following warning was reported by Kernel Test Robot.
>
> In function 'utf8_parse_version',
> inlined from 'utf8_load' at fs/unicode/utf8mod.c:195:7:
>>> fs/unicode/utf8mod.c:175:2: warning: 'strncpy' specified bound 12 equals
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
> Fixes: 9d53690f0d4e5 (unicode: implement higher level API for string handling)
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>
> Changes in v3
>   - Return error if strscpy() returns value < 0
>
> Changes in v2
>   - Resolve warning of -Wstringop-truncation reported by
>     kernel test robot.
>
>  fs/unicode/utf8-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

Hi Shreeya,

Thanks for fixing this.

> diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
> index dc25823bf..706f086bb 100644
> --- a/fs/unicode/utf8-core.c
> +++ b/fs/unicode/utf8-core.c
> @@ -180,7 +180,10 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
>  		{0, NULL}
>  	};
>  
> -	strncpy(version_string, version, sizeof(version_string));
> +	int ret = strscpy(version_string, version, sizeof(version_string));

Usually, no spaces between variable declarations

Other than that,

Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>

> +
> +	if (ret < 0)
> +		return ret;
>  	if (match_token(version_string, token, args) != 1)
>  		return -EINVAL;

-- 
Gabriel Krisman Bertazi
