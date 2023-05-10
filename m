Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D16FE16E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjEJPT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 11:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237182AbjEJPT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 11:19:28 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 08:19:25 PDT
Received: from forwardcorp1c.mail.yandex.net (forwardcorp1c.mail.yandex.net [178.154.239.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F63F5;
        Wed, 10 May 2023 08:19:25 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a884:0:640:947b:0])
        by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 06C565ECDD;
        Wed, 10 May 2023 18:15:43 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:2::1:11] (unknown [2a02:6b8:b081:2::1:11])
        by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id fFXDTR0OmeA0-PQczfv8d;
        Wed, 10 May 2023 18:15:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1683731742; bh=qptSzgwAzmXXeXe0cMKX94iT+95ACwDpKzD0gKQUQeU=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=X0HNwIF6Mhv2RtWNnyLbk+emXEP0iMbo8TO+O99g/NAt4rz9cAeLEDTrminslCi6Y
         0oevnny2JYRpWT+OAxhnXmjAwokeHPXkYgfUDpFaDwX+ZnzJ55LZKK4/zzC7AEigZy
         3ydn/S6hbdFDvuEvEMwkFclki9wYdLLvXfDiLSCA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <14af0872-a7c2-0aab-b21d-189af055f528@yandex-team.ru>
Date:   Wed, 10 May 2023 18:15:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fs/coredump: open coredump file in O_WRONLY instead of
 O_RDWR
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ptikhomirov@virtuozzo.com, Andrey Ryabinin <arbn@yandex-team.com>
References: <20230420120409.602576-1-vsementsov@yandex-team.ru>
From:   Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230420120409.602576-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gently ping.

Is there any interest?

On 20.04.23 15:04, Vladimir Sementsov-Ogievskiy wrote:
> This makes it possible to make stricter apparmor profile and don't
> allow the program to read any coredump in the system.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   fs/coredump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 5df1e6e1eb2b..8f263a389175 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -646,7 +646,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>   	} else {
>   		struct mnt_idmap *idmap;
>   		struct inode *inode;
> -		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
> +		int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
>   				 O_LARGEFILE | O_EXCL;
>   
>   		if (cprm.limit < binfmt->min_coredump)

-- 
Best regards,
Vladimir

