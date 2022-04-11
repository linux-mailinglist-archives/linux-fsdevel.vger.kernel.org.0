Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369344FBFCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbiDKPGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiDKPGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:06:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEAE23BEF;
        Mon, 11 Apr 2022 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E4dwbCWrITT9Gc93/E4bis1uw9rHZXkBXHbxh0GQ1ew=; b=OUbKgv6Ffn4P0SjIjiIO2TXNWm
        KmHPB0hhxQH+tBea3Y6K3UH8izu7lEhi2KZJCd7sEc30IT+Vwfm5q2zrzarbwl2Ist2akc5zIRKEO
        qbClGABwgo0MBNZkkMNJajExdg9654sBPodCy0KbhcwZ9TiAMhZ1Z9/yOsABWB60tmSpGElbo85iZ
        9dAMAjBFxCg3DM0p4k928WgIAqB6gvrRUKnDxw2pl++Xt0E+Icg87ssIcgTLNZb1n42K9pVFzBwX1
        K6Mia2am0Pw76RPBB/xRwUQsTIO8DKqdBWppfy/zEnWP4qe+UYH4hnYWBAMnfObvtjiFYL4bzTmPJ
        HvnR2X4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndvZq-00CQ4p-0L; Mon, 11 Apr 2022 15:03:38 +0000
Date:   Mon, 11 Apr 2022 16:03:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
Message-ID: <YlRDSXQG+ED1Okpp@casper.infradead.org>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:43:33AM -0400, Mikulas Patocka wrote:
> If you run a program compiled with OpenWatcom for Linux on a filesystem on 
> NVMe, all "stat" syscalls fail with -EOVERFLOW. The reason is that the 
> NVMe driver allocates a device with the major number 259 and it doesn't 
> pass the "old_valid_dev" test.
> 
> This patch removes the tests - it's better to wrap around than to return
> an error. (note that cp_old_stat also doesn't report an error and wraps
> the number around)

Is it better?  You've done a good job arguing why it is for this particular
situation, but if there's a program which compares files by
st_dev+st_ino, it might think two files are identical when they're
actually different and, eg, skip backing up a file because it thinks
it already did it.  That would be a silent failure, which is worse
than this noisy failure.

The real problem is clearly that Linus denied my request for a real
major number for NVMe back in 2012 or whenever it was :-P

> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>  fs/stat.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> Index: linux-5.17.2/fs/stat.c
> ===================================================================
> --- linux-5.17.2.orig/fs/stat.c	2022-04-10 21:39:27.000000000 +0200
> +++ linux-5.17.2/fs/stat.c	2022-04-10 21:42:43.000000000 +0200
> @@ -334,7 +334,6 @@ SYSCALL_DEFINE2(fstat, unsigned int, fd,
>  #  define choose_32_64(a,b) b
>  #endif
>  
> -#define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
>  #define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)
>  
>  #ifndef INIT_STRUCT_STAT_PADDING
> @@ -345,8 +344,6 @@ static int cp_new_stat(struct kstat *sta
>  {
>  	struct stat tmp;
>  
> -	if (!valid_dev(stat->dev) || !valid_dev(stat->rdev))
> -		return -EOVERFLOW;
>  #if BITS_PER_LONG == 32
>  	if (stat->size > MAX_NON_LFS)
>  		return -EOVERFLOW;
> @@ -644,9 +641,6 @@ static int cp_compat_stat(struct kstat *
>  {
>  	struct compat_stat tmp;
>  
> -	if (!old_valid_dev(stat->dev) || !old_valid_dev(stat->rdev))
> -		return -EOVERFLOW;
> -
>  	memset(&tmp, 0, sizeof(tmp));
>  	tmp.st_dev = old_encode_dev(stat->dev);
>  	tmp.st_ino = stat->ino;
> 
