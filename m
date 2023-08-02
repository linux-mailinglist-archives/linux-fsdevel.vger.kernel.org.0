Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF3576D49C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHBRDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 13:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjHBRC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7526B5;
        Wed,  2 Aug 2023 10:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAC361377;
        Wed,  2 Aug 2023 17:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A438C433CD;
        Wed,  2 Aug 2023 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690995769;
        bh=sjqBXD6oFCrgUqohETGdLnElwGXtye3lxYOYXr8IIBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tu2qP6Hb8TEFQJFv5V0JPnO5+W3847Kw7qcHa6wLbwOOdz7/AW1SL0kAIhiQiDQa9
         LGABdIUhh3g3jl/eKOmtnW7Yrb4K7mb8YjCqknHxA8yL2gKi6mVuKgMWfj6tu1STHl
         +u8dSibFuCdF0pAe0EeTTCFF/4cPweTek6z7CzRQ=
Date:   Wed, 2 Aug 2023 10:02:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, Al.Smith@aeschi.ch.eu.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] efs: fix -Wunused-const-variable= warning
Message-Id: <20230802100248.b6e24e19f33e483d4cf55512@linux-foundation.org>
In-Reply-To: <20230802065753.217179-1-wangzhu9@huawei.com>
References: <20230802065753.217179-1-wangzhu9@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Aug 2023 14:57:53 +0800 Zhu Wang <wangzhu9@huawei.com> wrote:

> When building with W=1, the following warning occurs.
> 
> In file included from fs/efs/super.c:18:0:
> fs/efs/efs.h:22:19: warning: ‘cprt’ defined but not used [-Wunused-const-variable=]
>  static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith
> <Al.Smith@aeschi.ch.eu.org>";
>                    ^~~~
> The header file is included in many C files, there are many
> similar errors which are not included here. We add __maybe_unsed
> to remove it.
> 
> ...
>
> --- a/fs/efs/efs.h
> +++ b/fs/efs/efs.h
> @@ -19,7 +19,8 @@
>  
>  #define EFS_VERSION "1.0a"
>  
> -static const char cprt[] = "EFS: "EFS_VERSION" - (c) 1999 Al Smith <Al.Smith@aeschi.ch.eu.org>";
> +static const char __maybe_unused cprt[] =
> +	"EFS: "EFS_VERSION" - (c) 1999 Al Smith <Al.Smith@aeschi.ch.eu.org>";
>  
>  
>  /* 1 block is 512 bytes */

I don't know if Al is still around, but I added the Cc anyway.

cprt[] is unreferenced in fs/efs/*.c.  I assume the intent here was to
embed the copyright strings in the generated binary.  But this doesn't
work nowadays - the compiler/linker are removing this string entirely.

I guess the best approach is to move this copyright statement into a
comment as we do in many other places.  See fs/ext2/acl.c for a random
example.

