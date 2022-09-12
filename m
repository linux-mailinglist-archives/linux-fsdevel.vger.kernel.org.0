Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330265B616B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiILTFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiILTFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:05:11 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6318342
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 12:05:06 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRGJ04nyTzMrFxq;
        Mon, 12 Sep 2022 21:05:04 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRGHz53JBzMpnPl;
        Mon, 12 Sep 2022 21:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663009504;
        bh=F0ZloUyCGoKbXhd87JV7iaD7J77fjOqr5Ic5aNLSYsY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fnYfzXcfwhsrT7TsE7DVtVt4O+wokbxkvuX3so88nd2AntazzZHKCa1/0gnnCI7Ku
         gYdCFEZfpDtcerGlSvIHt3lXySUc3oA9qXXB5pXNdqLVPuI16bBQd0uOw4i9aZbp3e
         qgLjpP90a0qtKUDWKbg4MKRS8g0vFETbcykYIjvU=
Message-ID: <c302374d-f380-9da4-c6d9-94b9b4555407@digikod.net>
Date:   Mon, 12 Sep 2022 21:05:03 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v6 4/5] samples/landlock: Extend sample tool to support
 LANDLOCK_ACCESS_FS_TRUNCATE
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
 <20220908195805.128252-5-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220908195805.128252-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 08/09/2022 21:58, Günther Noack wrote:
> Update the sandboxer sample to restrict truncate actions. This is
> automatically enabled by default if the running kernel supports
> LANDLOCK_ACCESS_FS_TRUNCATE, expect for the paths listed in the

except for

> LL_FS_RW environment variable.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>   samples/landlock/sandboxer.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 3e404e51ec64..771b6b10d519 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
>   #define ACCESS_FILE ( \
>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> -	LANDLOCK_ACCESS_FS_READ_FILE)
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
>   /* clang-format on */
>   
> @@ -160,10 +161,8 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
>   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
>   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
>   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> -	LANDLOCK_ACCESS_FS_REFER)
> -
> -#define ACCESS_ABI_2 ( \
> -	LANDLOCK_ACCESS_FS_REFER)
> +	LANDLOCK_ACCESS_FS_REFER | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE)
>   
>   /* clang-format on */
>   
> @@ -226,11 +225,17 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   		return 1;
>   	}
>   	/* Best-effort security. */
> -	if (abi < 2) {
> -		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
> -		access_fs_ro &= ~ACCESS_ABI_2;
> -		access_fs_rw &= ~ACCESS_ABI_2;
> +	switch (abi) {
> +	case 1:
> +		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> +		__attribute__((fallthrough));
> +	case 2:
> +		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
>   	}
> +	access_fs_ro &= ruleset_attr.handled_access_fs;
> +	access_fs_rw &= ruleset_attr.handled_access_fs;
>   
>   	ruleset_fd =
>   		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
