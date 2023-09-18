Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630AB7A4C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjIRPeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjIRPeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:34:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F0CF8;
        Mon, 18 Sep 2023 08:29:53 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59c0d002081so30586957b3.2;
        Mon, 18 Sep 2023 08:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050777; x=1695655577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pyv4oO8rrHEd4wiz5Er/b8SPSG4uhIlASx2HO5yMlQ=;
        b=fiAIwznoeOaPa8f54jwL7chi2HiACFejgzjdsMYYCi287WDijxzyWrr6GJVNcAOz3s
         pvyB0kL9KQ72Ggx08iaGDxrhoopTh6Mf0lfBlt11FkGQHwbXg16U2SbOWt6oOh1jk8FL
         l+OUfcIZ6LRxdkgkptqJ3nLkuYvmciJH9ve7clBSx5DtNgCB9nyqrtK9nmeT7LTetVWx
         sRDqJPHlNKykyb1Y9+ReoxumSVUbrZBD0iZXm0C0+2Sx778am2/KjuRhDGPRRiS1HLOH
         DCnsRtRofIulQz1MXV/ySRftWxXyJ6OX4UHiADJjXk5psCZT8+qE2CESeDYQfaGQINGf
         viVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050777; x=1695655577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Pyv4oO8rrHEd4wiz5Er/b8SPSG4uhIlASx2HO5yMlQ=;
        b=h11kBMIM/fRe8oEg8XofbJahS8BaRSKYzvy8oK4mZlE3FhOzFO9JmoZNAKzmfRSNGv
         jJTIoaOtg0NAFvtQGqBOM6aUTdMLOmlMfwQmSLuEk6yRsbd5bgBR6i9bj3IxZ7+ctU7e
         lQwxfH6j4GNIu7CcSGT6oU1Q5meMdS5lLucehpUyaGvvXh7NwdrWOFk5dSp8O6jMVjT5
         7Vyxxl8L4cZxHU2xO+D3k6Jxr8YC/o++jolF1KB0rAtPfKnG+fR5hHNfEhERYwcEe7An
         DJU8qk4sa6rKjfkIk0cz1UWp7bX9mbw8U9eZnrR3Ey0vo75PmARZBwepcdVQq51Oxhii
         RLGQ==
X-Gm-Message-State: AOJu0YyTKNCvZky/k0nFGMxCDS5Xz3OwHnFX9ax/YFJwzuk4/P5kAYiu
        OecL5AKc1d24k/qvps5ECgL3uAhbQxo=
X-Google-Smtp-Source: AGHT+IF7JTS/i+m9/oQRFXfvKeREFGeGsE6KslGHKMNcg+tSAckFmk+2b7p+zXlHPu/4uvCOHinHTA==
X-Received: by 2002:a6b:dc0c:0:b0:795:13ea:477a with SMTP id s12-20020a6bdc0c000000b0079513ea477amr11908098ioc.8.1695049290863;
        Mon, 18 Sep 2023 08:01:30 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id h2-20020a6b7a02000000b00786aa1eb582sm2818737iom.31.2023.09.18.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:01:29 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:59:03 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <ZQhlt/EbRf3Y+0jT@yury-ThinkPad>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:46:02PM +0200, Mirsad Todorovac wrote:

...

> Ah, I see. This is definitely not good. But I managed to fix and test the find_next_bit()
> family, but this seems that simply
> 
> -------------------------------------------
>  include/linux/xarray.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 1715fd322d62..89918b65b00d 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1718,14 +1718,6 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>         if (advance)
>                 offset++;
> -       if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> -               if (offset < XA_CHUNK_SIZE) {
> -                       unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
> -                       if (data)
> -                               return __ffs(data);
> -               }
> -               return XA_CHUNK_SIZE;
> -       }
>         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
>  }

This looks correct. As per my understanding, the removed part is the
1-word bitmap optimization for find_next_bit. If so, it's not needed
because find_next_bit() bears this optimization itself.

...

> --------------------------------------------------------
>  lib/find_bit.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 32f99e9a670e..56244e4f744e 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -18,6 +18,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/swab.h>
> +#include <asm/rwonce.h>
>  /*
>   * Common helper for find_bit() function family
> @@ -98,7 +99,7 @@ out:                                                                          \
>   */
>  unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  {
> -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
>  }
>  EXPORT_SYMBOL(_find_first_bit);
>  #endif

...

That doesn't look correct. READ_ONCE() implies that there's another
thread modifying the bitmap concurrently. This is not the true for
vast majority of bitmap API users, and I expect that forcing
READ_ONCE() would affect performance for them.

Bitmap functions, with a few rare exceptions like set_bit(), are not
thread-safe and require users to perform locking/synchronization where
needed.

If you really need READ_ONCE, I think it's better to implement a new
flavor of the function(s) separately, like:
        find_first_bit_read_once()

Thanks,
Yury
