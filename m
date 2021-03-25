Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF2349A8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCYTkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230393AbhCYTkT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D84361A33;
        Thu, 25 Mar 2021 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616701218;
        bh=t73TCDPbW8CCPOT1gnPyZLIMzYIWH/PeC5jyFO3S+hU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIo7ZcQ+itFZRv3GceyXjflqxbkDu13DtfYPAWifjUac73uuPiFjWbj9C9nr0ZcUN
         xWAznZsIAk/FOT5bePJvRU1zYETQu+HdvYuGBO3U8Y6vi5XE8q5DDzJ+avczZeM6+2
         g0mxoBg8wEg7tiev7kuEm2nJ30wUR05wxTUCCacXpn2IB5gE0J9LsqzHSyv8Eli/U4
         Sf34dqc2TWQDlcvF0Frfs7aynPXOc8LA9tq90P+TuRYE0KvE3hGRi7bIZT2ZYvIFhH
         K91heJwiLnEj7isnTgbBg/cR8Pwfc8eSG+A6yf8KVr6qKn+Ysvfy29RZbyvQggBblR
         bS2uTt4RC1YlA==
Date:   Thu, 25 Mar 2021 12:40:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v4 5/5] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YFznIVf/F68oEuC6@sol.localdomain>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
 <20210325000811.1379641-6-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325000811.1379641-6-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:38:11AM +0530, Shreeya Patel wrote:
> Also, indirect calls using function pointers are easily exploitable by
> speculative execution attacks, hence use static_call() in unicode.h and
> unicode-core.c files inorder to prevent these attacks by making direct
> calls and also to improve the performance of function pointers.

I don't think you need to worry about avoiding indirect calls to prevent
speculative execution attacks.  That's what the mitigations like Retpoline are
for.  Instead my concern was just that indirect calls are *slow*, especially
when those mitigations are enabled.  Some of the casefolding operations are
called a lot (e.g., repeatedly during path resolution), and it would be
desirable to avoid adding more overhead there.

> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..2961b0206b4d 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -8,7 +8,16 @@ config UNICODE
>  	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
>  	  support.
>  
> +# UTF-8 encoding can be compiled as a module using UNICODE_UTF8 option.
> +# Having UTF-8 encoding as a module will avoid carrying large
> +# database table present in utf8data.h_shipped into the kernel
> +# by being able to load it only when it is required by the filesystem.
> +config UNICODE_UTF8
> +	tristate "UTF-8 module"
> +	depends on UNICODE
> +	default m
> +

The help for UNICODE still says that it enables UTF-8 support.  But now there is
a separate option that people will need to remember to enable.

Please document each of these options properly.

Perhaps EXT4_FS and F2FS_FS just should select UNICODE_UTF8 if UNICODE, so that
UNICODE_UTF8 doesn't have to be a user-selectable symbol?

> +DEFINE_STATIC_CALL(validate, unicode_validate_static_call);
> +EXPORT_STATIC_CALL(validate);

Global symbols can't have generic names like "validate".  Please add an
appropriate prefix like "unicode_".

Also, the thing called "unicode_validate_static_call" isn't actually a static
call as the name suggests, but rather the default function used by the static
call.  It should be called something like unicode_validate_default.

Likewise for all the others.

- Eric
