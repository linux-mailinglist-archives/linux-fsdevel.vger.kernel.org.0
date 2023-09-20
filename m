Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05677A75EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjITIct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjITIcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C899
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695198718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2tzVfOe3L3Ksv5MA/EISDvuv/fnMeNjiXmGn3Pv8s8=;
        b=EtKi/N8j7MBJOyLD+z8W7V6uMYJrNe18u1/fC6LsnZ95qnxeJwY/iSXomEzsVmlAUNX0Hk
        f8fBKuRKhmsHnLybQayClBub/SESJsk4y89NilYK1M5R/zS7g+FJA9jMTOuAXErEABKatM
        0JwU40kMAfd/jYH7nkd2Myf+b/VP3sQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-Yt-gsCluNz2cWsEwiB2agQ-1; Wed, 20 Sep 2023 04:31:56 -0400
X-MC-Unique: Yt-gsCluNz2cWsEwiB2agQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c030cea151so15678771fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695198715; x=1695803515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2tzVfOe3L3Ksv5MA/EISDvuv/fnMeNjiXmGn3Pv8s8=;
        b=cBoRuyUg+HnE4WOrAV+YeygTDAbHesQjT6RqbUxy0bcf3ifIM2Yu0lRriFu/te9oFV
         TlD7AI3Ln8Y7b7o9K7Jxq89ilf+eeQC4kR7fL36J5p/RqjEYSrQwn/3lOFyzm7A0MAX2
         eRuIpeDDpSQ3+xF3uOlN4nWUj65RqViq4aH6OlQ1H9lQGoiA80QP5LTF3giat6+3RPjU
         yrMr18vndv0GxZFEpPvS7tL8pN+b+6XEINhnrZahF5M5wyO0v52+cRrS8zc0us+eNS9e
         cA5GOqxjvwyWlLjA8MDV3hk3pEBzNMbfgaiUoEZ03y+nAbNRjeZYiXKgLAmm1tYb/xqr
         saDQ==
X-Gm-Message-State: AOJu0YyPab2sBfjEGyR84UeA4kKIvvgNslCqweE2znFKGKcrrdk1Gf61
        66tyQUa4848bPQMYF3nHDbYeNN2XYl3ruwG9KpKL1Xl28rWqMOSHJWRpVNxpZas3HHnS2L6Ns5o
        Rke0VOyzbbKfQwj9wSxQCt6wGO9jHocS23w==
X-Received: by 2002:a05:651c:149:b0:2bc:f2d7:f6ce with SMTP id c9-20020a05651c014900b002bcf2d7f6cemr1472792ljd.49.1695198714994;
        Wed, 20 Sep 2023 01:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5ecew2udovydr9mIa1NukjYZsSo/Lz51ZpATEoghwMy55JZd4uj9V9vHNyhey3RQbn5L2lw==
X-Received: by 2002:a05:651c:149:b0:2bc:f2d7:f6ce with SMTP id c9-20020a05651c014900b002bcf2d7f6cemr1472772ljd.49.1695198714521;
        Wed, 20 Sep 2023 01:31:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179? (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de. [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
        by smtp.gmail.com with ESMTPSA id re20-20020a170906d8d400b0099bc8bd9066sm9070916ejb.150.2023.09.20.01.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 01:31:53 -0700 (PDT)
Message-ID: <f26589d6-32b6-9665-677e-06397d0a1028@redhat.com>
Date:   Wed, 20 Sep 2023 10:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] fs/fuse: Rename DIRECT_IO_RELAX to
 DIRECT_IO_ALLOW_MMAP
To:     Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     mszeredi@redhat.com, gmaglione@redhat.com
References: <20230920024001.493477-1-tfanelli@redhat.com>
 <20230920024001.493477-2-tfanelli@redhat.com>
Content-Language: en-US
From:   Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230920024001.493477-2-tfanelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.09.23 04:40, Tyler Fanelli wrote:
> Although DIRECT_IO_RELAX's initial usage is to allow shared mmap, its
> description indicates a purpose of reducing memory footprint. This
> may imply that it could be further used to relax other DIRECT_IO
> operations in the future.
>
> Replace it with a flag DIRECT_IO_ALLOW_MMAP which does only one thing,
> allow shared mmap of DIRECT_IO files while still bypassing the cache
> on regular reads and writes.

Thanks!

I prefer the definition to be narrow so that FUSE servers (virtiofsd, 
specifically) can rely on what exact behavior this flag enables.  As it 
is, I think it’s hard to use the flag, because:

It is not clear what the flag does. 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e78662e818f9 
gives a goal for using it (in case you want to reduce memory footprint), 
but doesn’t say what it will do.  This makes it difficult for us (in 
virtiofsd) to expose it, because we in turn can’t tell users in 
documentation what it’ll do.  For example, the commit correctly advises 
“to make sure it doesn't break coherency in your use case”, but that 
isn’t really possible when it isn’t well-defined what coherency 
properties are changed.

Further, is implied that what the flag does may change in the future, 
but how so is left unclear.  The goal given is to reduce memory 
footprint, but that’s actually done by using DIRECT_IO, not by using 
DIRECT_IO_RELAX, so what restrictions that latter may relax is left 
open.  Allowing mmap specifically kind of increases memory footprint, so 
it seems to me as if the combination of both flags is supposed to 
optimize for memory usage under the hard restriction of allowing every 
operation to work still, and mmap() is the one operation identified so 
far.  But if so, it should be possible to exhaustively identify all 
other operations besides mmap() that are affected by DIRECT_IO, so that 
they can all be enabled by the new flag, and exhaustively listed in its 
documentation.  (I assume mmap() is the only operation that’s affected, 
though.)  Without knowing what the flag will do in the future, any name 
under which we (in virtiofsd) choose to expose this flag might be 
outright wrong in the future.

> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
> ---
>   fs/fuse/file.c            | 6 +++---
>   fs/fuse/fuse_i.h          | 4 ++--
>   fs/fuse/inode.c           | 6 +++---
>   include/uapi/linux/fuse.h | 7 +++----
>   4 files changed, 11 insertions(+), 12 deletions(-)

[...]

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index db92a7202b34..f4e3c083aede 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -209,7 +209,7 @@
>    *  - add FUSE_HAS_EXPIRE_ONLY
>    *
>    *  7.39
> - *  - add FUSE_DIRECT_IO_RELAX
> + *  - add FUSE_DIRECT_IO_ALLOW_MMAP
>    *  - add FUSE_STATX and related structures
>    */
>   
> @@ -409,8 +409,7 @@ struct fuse_file_lock {
>    * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
>    *			symlink and mknod (single group that matches parent)
>    * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
> - * FUSE_DIRECT_IO_RELAX: relax restrictions in FOPEN_DIRECT_IO mode, for now
> - *                       allow shared mmap
> + * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
>    */
>   #define FUSE_ASYNC_READ		(1 << 0)
>   #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -449,7 +448,7 @@ struct fuse_file_lock {
>   #define FUSE_HAS_INODE_DAX	(1ULL << 33)
>   #define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
>   #define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
> -#define FUSE_DIRECT_IO_RELAX	(1ULL << 36)
> +#define FUSE_DIRECT_IO_ALLOW_MMAP (1ULL << 36)

Is it allowed to remove FUSE_DIRECT_IO_RELAX now that it was already 
present in a uapi header?

Personally, I don’t mind keeping the name for the flag and just change 
the documentation.  Or we might keep the old name as an alias for the 
new one.

>   
>   /**
>    * CUSE INIT request/reply flags

