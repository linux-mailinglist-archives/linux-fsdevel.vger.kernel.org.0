Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939A43E365D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Aug 2021 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHGQ4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 12:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhHGQ4K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 12:56:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E104C61058;
        Sat,  7 Aug 2021 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628355353;
        bh=xneXCef3FRjBCnaNoY9tPBcNVJGns+i3iXDMrVO58mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U9cRwDNoB6btRNhwTev/FroT9STOvybHbTC5Wd7HQsfk7sHA/LRv2Jz4Ob60iTCW/
         vzmIgNeKI+7hn91QKZPej+HhOnQebH/rf3tl/mjl57NIoOFNGY0CORfAKiMPACjmOS
         PZ8VqjW4lyOC4Mq70yCjJYJ9QiLjZdhFC3ajV3x5onW0x0XJI7TsbOBEwAyLd9asNw
         rO6BXHol6p6s0N0TjMuwKbdmtEIaGSBS9maUDC6DR57GirE9fV2eiZb3XL2C7qchwY
         vPdsVBfmdSL7eRL002qBnjdFbCj9AoyZDEX8PCp1YzK9i1qlOyJhaQGb9W6K7rFY4f
         hmJrE1sa3JyxA==
Date:   Sat, 7 Aug 2021 09:55:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     krisman@collabora.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH] fs: unicode: Add utf8-data module
Message-ID: <YQ67FxJRlfTj5EGy@sol.localdomain>
References: <20210730124333.6744-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730124333.6744-1-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 06:13:33PM +0530, Shreeya Patel wrote:
> diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
> index 0acd530c2c79..6843229bcb2b 100644
> --- a/fs/unicode/utf8n.h
> +++ b/fs/unicode/utf8n.h
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/string.h>
>  #include <linux/module.h>
> +#include <linux/spinlock.h>
>  
>  /* Encoding a unicode version number as a single unsigned int. */
>  #define UNICODE_MAJ_SHIFT		(16)
> @@ -21,6 +22,11 @@
>  	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
>  	 ((unsigned int)(REV)))
>  
> +extern spinlock_t utf8_lock;
> +
> +extern struct utf8_data *utf8_ops;
> +extern bool utf8data_loaded;

The 'utf8data_loaded' variable is unnecessary, since it's equivalent to
'utf8_ops != NULL'.

Also, there are no function pointer fields anymore, so this really should be
called utf8_data, not utf8_ops.

- Eric
