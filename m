Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84D11FAD4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2019 20:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLOTt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Dec 2019 14:49:26 -0500
Received: from albireo.enyo.de ([37.24.231.21]:38274 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfLOTtZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:49:25 -0500
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1igZtC-0008Hm-Si; Sun, 15 Dec 2019 19:49:14 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1igZsO-0002ti-DI; Sun, 15 Dec 2019 20:48:24 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] openat2: switch to __attribute__((packed)) for open_how
References: <20191213222351.14071-1-cyphar@cyphar.com>
Date:   Sun, 15 Dec 2019 20:48:24 +0100
In-Reply-To: <20191213222351.14071-1-cyphar@cyphar.com> (Aleksa Sarai's
        message of "Sat, 14 Dec 2019 09:23:50 +1100")
Message-ID: <87o8w9bcaf.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Aleksa Sarai:

> diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
> index 43ca5ceab6e3..eb1535c8fa2e 100644
> --- a/tools/testing/selftests/openat2/helpers.h
> +++ b/tools/testing/selftests/openat2/helpers.h
> @@ -32,17 +32,16 @@
>   * O_TMPFILE} are set.
>   *
>   * @flags: O_* flags.
> - * @mode: O_CREAT/O_TMPFILE file mode.
>   * @resolve: RESOLVE_* flags.
> + * @mode: O_CREAT/O_TMPFILE file mode.
>   */
>  struct open_how {
> -	__aligned_u64 flags;
> +	__u64 flags;
> +	__u64 resolve;
>  	__u16 mode;
> -	__u16 __padding[3]; /* must be zeroed */
> -	__aligned_u64 resolve;
> -};
> +} __attribute__((packed));
>  
> -#define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
> +#define OPEN_HOW_SIZE_VER0	18 /* sizeof first published struct */
>  #define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0

A userspace ABI that depends on GCC extensions probably isn't a good
idea.  Even with GCC, it will not work well with some future
extensions because it pretty much rules out having arrays or other
members that are access through pointers.  Current GCC does not carry
over the packed-ness of the struct to addresses of its members.
