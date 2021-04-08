Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2211D357945
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 03:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhDHBBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 21:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDHBBi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:01:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDABE6121E;
        Thu,  8 Apr 2021 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617843688;
        bh=4u5tOpeCMncpEEQTHvI1+RnAHtrGNOf7zF8rhQ0eQbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f1IAmgDh/ajJXxqKR9vXpvbxKyFaWcCycgnCj0Czvr6yiCvIbQQqLEttUcyroC3iz
         +b+B8zQ14heqrSnyfEi5fUdZyyJmW0vIMazvd2wIwAnoCcpMwd0k+tXBmDgOLi/8IJ
         +AsOkm5cNi0GdTcNjikrbtPCvU5K/55cv6csvcuPqAtWDIXFB79v9Du4F4WiuO49Go
         p0wTQekgcBuRylR/AP+Z+ncpt9dg2Ypv9RpIXnG+H3egdTZapV+MDYQLDhZ4ciHjlS
         BdGYyUCH6GZ0C2BlVAP2EUdTP7SwusqsGPZFVNO8Mpg2L54LBtBbN8FCS3M+Rlytg8
         PyJ1mhozAsknA==
Date:   Wed, 7 Apr 2021 18:01:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v7 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YG5V5l2pD3DCiyVA@gmail.com>
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
 <20210407144845.53266-5-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407144845.53266-5-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:18:45PM +0530, Shreeya Patel wrote:
> diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
> index 2c27b9a5cd6c..0c69800a2a37 100644
> --- a/fs/unicode/Kconfig
> +++ b/fs/unicode/Kconfig
> @@ -2,13 +2,31 @@
>  #
>  # UTF-8 normalization
>  #
> +# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
> +# is enabled. This config option adds the unicode subsystem layer which loads
> +# the UTF-8 module whenever any filesystem needs it.
>  config UNICODE
> -	bool "UTF-8 normalization and casefolding support"
> +	bool
> +
> +config UNICODE_UTF8
> +	tristate "UTF-8 module"
> +	select UNICODE
>  	help
> -	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
> -	  support.
> +	  Say M here to enable UTF-8 NFD normalization and NFD+CF casefolding
> +	  support as a loadable module or say Y for building it into the kernel.
> +
> +	  utf8data.h_shipped has a large database table which is an
> +	  auto-generated decodification trie for the unicode normalization
> +	  functions and it is not necessary to carry this large table in the
> +	  kernel. Hence, enabling UNICODE_UTF8 as M will allow you to avoid
> +	  carrying this large table into the kernel and module will only be
> +	  loaded whenever required by any filesystem.
> +	  Please note, in this case utf8 module will only be available after
> +	  booting into the compiled kernel. If your filesystem requires it to
> +	  have utf8 during boot time then you should have it built into the
> +	  kernel by saying Y here to avoid boot failure.

This help text seems to contradict itself; it says "it is not necessary to carry
this large table in the kernel", and then later it says that in some cases it is
in fact necessary.

It would also be helpful for the help text to mention which filesystems actually
support this feature.

> diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
> index 730dbaedf593..d9e9e410893d 100644
> --- a/fs/unicode/unicode-core.c
> +++ b/fs/unicode/unicode-core.c
> @@ -1,228 +1,132 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> -#include <linux/string.h>
>  #include <linux/slab.h>
> -#include <linux/parser.h>
>  #include <linux/errno.h>
>  #include <linux/unicode.h>
> -#include <linux/stringhash.h>
> +#include <linux/spinlock.h>
>  
> -#include "utf8n.h"
> +DEFINE_SPINLOCK(utf8mod_lock);

This spinlock should be 'static'.

- Eric
